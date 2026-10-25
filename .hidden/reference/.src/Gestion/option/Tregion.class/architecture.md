# Tregion — Architecture

> Source : `.src/Gestion/option/Tregion.class`

## Vue d'ensemble

Écran **« Table de la TIPP régionale »** (option carburant) : saisie de la table `Fiches_region`
(`code` char(2), `cart` char(15), `libelle` varchar(30), `taux` decimal(6,2), **clé primaire
`(code, cart)`**). Pour un même code région :
- la ligne `cart = '0'` porte l'**intitulé** de la région ;
- chaque autre ligne porte le **taux** (en €/hl, libellé « En Hl » du `.form`) applicable à un
  article (`cart` = code article de `Fiches_Art`).

Ouvert par `menuopt.tipp_click` (`menuopt.class:57`, `Tregion.Show`). La table est lue ailleurs
par [rechtipp](../rechtipp.class/architecture.md) (recherche), [Edittipp](../Edittipp.class/architecture.md)
(édition de la TIPP), `Facture.class:12214` et `FClient.class:805`.

**Table créée à l'exécution** par [`modfichier.fichiercarbu`](../modfichier.module/architecture.md)
(`modfichier.module:107`, appelé par `Prefs.pp_Click` quand l'option carburant est cochée) :
elle est **absente de `db_control.csv` et de `Laurux01.sql`**, n'a pas de clé `Cbase` et n'est
donc ni contrôlée par `DB_Sanity` ni présente dans les jeux de test standard.

Construction sur `Barselection("111111110", panel1)` (pas de bouton recherche) avec le cycle
transactionnel commun à [Ttourne](../Ttourne.class/architecture.md),
[Tregie](../Tregie.class/architecture.md), [Tconsigne](../Tconsigne.class/architecture.md) et
[Mreglement](../../Tables/Mreglement.class/architecture.md). La suppression est affichée mais
non implémentée.

Situation par rapport au socle « table code/libellé » de
[Centrales](../../Tables/Centrales.class/architecture.md) : **hors socle** (clé composée, taux,
contrôle d'article) ; relève du socle `Barselection` (MREGLEMENT-006).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `bs` | var | Private |  | Barselection | 3 |
| `$resreg` | var | Private |  | Result | 4 |
| `$ind` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 7-25 | Public | 2 | 15 | 0 | handler GUI |
| `cmpt_gotfocus` | 27-31 | Public | 2 | 3 | 0 | handler GUI |
| `cmpt_lostfocus` | 33-37 | Public | 2 | 3 | 0 | handler GUI |
| `bar1_annule` | 39-51 | Public | 2 | 11 | 0 | handler GUI |
| `bar1_creer` | 53-63 | Public | 1 | 9 | 0 | handler GUI |
| `bar1_dernier` | 65-72 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_modif` | 74-79 | Public | 1 | 4 | 0 | handler GUI |
| `bar1_precedent` | 81-88 | Public | 3 | 6 | 0 | handler GUI |
| `bar1_premier` | 90-97 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_suivant` | 99-105 | Public | 2 | 5 | 0 | handler GUI |
| `bar1_valide` | 107-144 | Public | 8 | 34 | 0 | handler GUI |
| `bar1_suprimer` | 146-150 | Public | 1 | 2 | 0 | handler GUI |
| `bar1_quitter` | 152-156 | Public | 1 | 3 | 0 | handler GUI |
| `form_Close` | 158-165 | Public | 4 | 6 | 0 | handler GUI |
| `Textcode_LostFocus` | 167-185 | Public | 3 | 15 | 0 | handler GUI |
| `Textart_LostFocus` | 187-200 | Public | 2 | 11 | 0 | handler GUI |
| `affichedonne` | 201-216 | Private | 3 | 14 | 0 |  |
| `affectedonne` | 218-225 | Private | 1 | 6 | 0 |  |
| `mablanc` | 227-234 | Private | 1 | 6 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et focus

- **`form_Open()`** [handler] [nature : mixte] : `Utils.Observers(Me)`, barre `bar1`, quatre
  `Observer` nommés `cmpt` sur `Textcode`, `Textlib`, `Valuetaux`, `Textart` (variable locale
  `obs` réaffectée : les observateurs restent attachés à leurs contrôles), puis
  `SELECT * FROM Fiches_region ORDER BY code` et affichage de la première ligne. Le tri ne porte
  que sur `code` : l'ordre des lignes d'une même région est indéterminé.
- **`cmpt_gotfocus` / `cmpt_lostfocus`** [handler du groupe d'observateurs `cmpt`] [nature : GUI] :
  `Try Utils.ObsGotf/ObsLstf(Last)` (journalisation du focus pour le replay).
- **`Textcode_LostFocus()`** [handler] [nature : mixte] : ballon si le code est vide (le traitement
  continue quand même) ; si aucune ligne `cart='0'` n'existe pour ce code, `Message.Info` « Le
  premier code région ne doit contenir que l'intilulé », force `Textart = "0"` et désactive
  `Textart`/`Valuetaux` (première ligne d'une région = intitulé seul).
- **`Textart_LostFocus()`** [handler] [nature : mixte] :
  `SELECT * FROM Fiches_Art WHERE art_code=&1` (table en dur, clé `TabArt` disponible) ;
  affiche la désignation dans `Label6` ou ballon « Code article inconnu » et retour du focus.

### Barre d'actions (événements de `Barselection`)

- **`bar1_creer()`** [handler] [nature : mixte] : `$ind = $resreg.Index`, `Begin`,
  `Create9("Fiches_region")`, zones vidées, `Textcode`/`Textart` activés.
- **`bar1_modif()`** [handler] [nature : mixte] : `Begin`,
  `$resreg = Utils.db.Edit("Fiches_region", "code=&1", Textcode.Text)` : le filtre **ignore
  `cart`**, alors que la clé est `(code, cart)`. Le `Result` éditable porte donc sur toutes les
  lignes de la région, et c'est la **première** qui est modifiée par `bar1_valide`, pas forcément
  celle affichée (TREGION-A03, à confirmer en replay).
- **`bar1_valide(creer, modi)`** [handler] [nature : mixte] (CC 8, max du fichier) : en création,
  refuse un couple `(code, cart)` existant (ballon « Code région déja créer ») ; en modification,
  refuse un couple inexistant (« Code région inconnu ») ; ni l'un ni l'autre (suppression) :
  retour sans rien faire. Sinon `affectedonne`, `Update`, `Commit`, rechargement, zones
  `Textcode`/`Textart` désactivées, `Valuetaux` réactivé.
- **`bar1_annule(creer, anul)`** [handler] [nature : mixte] : `Rollback`, rechargement, mêmes
  activations que `bar1_valide`.
- **`bar1_suprimer()`** [handler] : vide (« a completer ») ; bouton pourtant affiché (TREGION-A04).
- **`bar1_premier` / `bar1_precedent` / `bar1_suivant` / `bar1_dernier`** [handler] [nature : GUI] :
  navigation dans `$resreg`.
- **`bar1_quitter()`** [handler] : `Me.Close`.
- **`form_Close()`** [handler] [nature : GUI] : comme Ttourne, appelle **`bar1_valide` sans
  argument** sur « Oui » (« Not enough arguments », TREGION-A01) et laisse la transaction ouverte
  sur « Non » (TREGION-A02).

### Fonctions privées

- **`affichedonne()`** [Private] [nature : mixte] : recopie la ligne courante et relit la
  désignation de l'article (`SELECT * FROM Fiches_Art WHERE art_code=&1`) ; extractible :
  `DesignationArticle(code) As String` (même requête que `Textart_LostFocus`).
- **`affectedonne()`** / **`mablanc()`** [Private] [nature : GUI] : zones ↔ `$resreg`, mise à blanc.

## État global utilisé

- `Utils.db` (`Exec`, `Begin`, `Commit`, `Rollback`, `Create9`, `Edit`) ; transaction ouverte sur
  la connexion partagée pendant la saisie.
- `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `ChargeRegions() As Result` (requête écrite trois fois), `RegionExiste(code, cart) As Boolean`
  (deux fois dans `bar1_valide`), `DesignationArticle(code) As String` (deux fois).
- `Cbase.Table("TabArt")` pour `Fiches_Art` (SQL identique).

### Commonalisation avec d'autres fichiers

- Cycle `Barselection` commun avec [Ttourne](../Ttourne.class/architecture.md),
  [Tregie](../Tregie.class/architecture.md), [Tconsigne](../Tconsigne.class/architecture.md),
  [Mreglement](../../Tables/Mreglement.class/architecture.md) (voir TTOURNE-005, MREGLEMENT-006).
- Lecture de la désignation d'un article : idiome répandu (recherche d'article déjà relevée pour
  `FpromoArt`, `MvtDepots`, `Sdepots`, `DB_Connection.RecArt`) ; `DesignationArticle` pourrait
  devenir un helper commun.
- Lecture de `Fiches_region` partagée avec [rechtipp](../rechtipp.class/architecture.md),
  [Edittipp](../Edittipp.class/architecture.md), `Facture` et `FClient` : une clé `Cbase`
  (`TabRegion`) servirait à tous.

### Réduction de portée

Rien à réduire : les 16 méthodes `Public` sont des handlers ; les fonctions utilitaires sont déjà
`Private`.

### Séparation traitement / GUI

- `ValideRegion(creer, modi, code, cart) As String` (motif de refus) appelé par `bar1_valide`,
  qui garde ballons et `Stop Event`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- **Créer `Fiches_region` par une migration `LauruxMaj`** (ou au moins l'ajouter à
  `db_control.csv` et aux bases de référence) au lieu de `modfichier.fichiercarbu`, pour que
  `DB_Sanity` la contrôle. Même remarque pour les colonnes ajoutées à l'exécution par
  `modfichier` (`tipp_ligbl`, `cli_tipp`, `cli_cons`…).
- Séparer l'intitulé de la région (`cart = '0'`) des taux par article : deux tables
  (`Fiches_Regions(code, libelle)`, `Fiches_RegionTaux(code, cart, taux)`) supprimeraient la ligne
  sentinelle `'0'` et le contrôle de `Textcode_LostFocus`.
- Clé étrangère `cart` → `Fiches_Art.art_code`.
