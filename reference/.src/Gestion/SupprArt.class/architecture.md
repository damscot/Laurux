# SupprArt — Architecture

> Source : `.src/Gestion/SupprArt.class` · Formulaire : `.src/Gestion/SupprArt.form`

## Vue d'ensemble

`SupprArt` est l'écran de **suppression en masse d'articles** (`Fmenu.Menu234_Click`,
`SupprArt.ShowModal()`). Quatre modes, choisis par boutons radio :

| Mode (radio) | Sélection des articles |
|---|---|
| `Selection` | familles `Fam1`–`Fam2` et fournisseurs `Cp1`–`Cp2` (bornes **strictes**), et exclusion des articles vendus (archives factures) après la date `Dte1` |
| `CheckSpd` | articles suspendus (`art_suspendu`) dans les mêmes bornes |
| `Liste` | liste manuelle saisie article par article, stockée dans la table de travail `Artsup` |
| `Fichier` | fichier texte, un code article par ligne |

La suppression elle-même est déléguée, article par article, à **`Articles.art_Suppr(code, False)`**
(`Articles.class:4060`), appelée sur l'**auto-instance** du formulaire `Articles`. Les refus sont
écrits dans `~/tmp/Artsuppr.txt`, ouvert ensuite dans l'éditeur.

`Dte1` est initialisée avec `Fiches_Parametres.dteclec5` (début du 5e exercice antérieur, à
confirmer selon la convention `dteclec1..5`).

Nature globale : **mixte** (GUI + SQL), la logique métier de suppression étant hors fichier.

### Tables portant un code article : `art_Suppr` comparé à `Changefam.Modifart`

`Changefam.Modifart` (`Changefam.class:500-555`) est la liste la plus complète des tables qui
référencent un code article (renommage). Comparaison avec ce que fait `art_Suppr` :

| Table (colonne) | `Modifart` | `art_Suppr` |
|---|---|---|
| `Fiches_Art` | renomme | supprime |
| `Fiches_Ligbl` (`code_ligbl`) | renomme | **bloque** si présent (BL/factures en cours) |
| `Fiches_LigblM` | renomme | **non contrôlé** |
| `Fiches_HistoLigfac[M]` | renomme | non contrôlé (sauf mode `Selection` dans `SupprArt`, date ≥ `Dte1`) ; lignes conservées |
| `Fiches_Materiels` (`mat_code`) | renomme | bloque |
| `Fiches_HisLigTickets` | renomme | non contrôlé ; lignes conservées |
| `Fiches_LigTicketz` (`TabLigTck`) | renomme | bloque (tickets non archivés) |
| `Fiches_Ligcom` | renomme | bloque (commandes fournisseurs) |
| `Fiches_Ligrecpt` | renomme | bloque si réception non validée, sinon **supprime** |
| `Fiches_Mvtexp` | renomme | supprime |
| `Fiches_Mvtexpdc` | renomme | **non traité** (orphelins) |
| `Fiches_Inv`, `Fiches_InvT` | renomme | supprime (si la table existe, `SHOW TABLES`) |
| `Fiches_HisInvT` | renomme | **non traité** |
| `Fiches_CdBarre` (`codep`) | renomme | supprime |
| `Fiches_CdFour` (`codep`) | renomme | **non traité** |
| `Fiches_Cequ` (`codep`, `codequ`) | renomme | supprime |
| `Fiches_Rpl1`, `Fiches_Rpl2` (`codep`) | renomme | supprime |
| `Fiches_Rpl1.coderpl1`, `Fiches_Rpl2.coderpl2` | renomme | **non traité** (remplaçants orphelins) |
| `Fiches_PrdComp` (`codep`, `codec`) | renomme | **non traité** (produit composé pointant vers un article supprimé) |
| `Fiches_ArtPromo`, `Fiches_EtiGond`, `Fiches_EtiProd` | renomme | **non traité** |
| `Fiches_Tarcli`, `Fiches_TarTypcli` (`cart`) | renomme | **non traité** |
| `Docs_Ged` (type article) | renomme | supprime (via `LGed.Supprime`) |
| `Rupture`, `RuptureC` (tables de travail) | renomme | non traité (sans conséquence) |

Les tables marquées « non traité » gardent des références orphelines après suppression : défaut de
`Articles.art_Suppr` (à reporter dans la doc d'`Articles`, lot Gestion/Tables), relevé ici comme
SUPPRART-A05. Une **liste de référence unique** des colonnes « code article » (partagée par
`Modifart`, `art_Suppr` et les contrôles de cohérence) est un candidat de commonalisation.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Org` | var | Private |  | String | 3 |
| `Type` | var | Private |  | String | 4 |
| `Coulfc` | var | Private |  | Integer | 5 |
| `Coulfond` | var | Private |  | New String[] | 6 |
| `son` | var | Private |  | Integer | 7 |
| `Bsel` | var | Public |  | Boolean | 8 |
| `Bval` | var | Public |  | String | 9 |
| `Tri` | var | Private |  | String | 10 |
| `filename` | var | Private |  | String | 11 |
<!-- /AUTO:declarations -->

Membres sans mot-clé de portée (donc `Private`) absents du tableau : `Org` (`"1"`/`"2"` : champ
famille à remplir), `Type` (`"F"` : type de compte pour `TriCpt`), `Coulfc`, `Coulfond` (écrits,
jamais lus), `son`. `Tri` est inutilisé. Le membre `filename` n'est affecté que par `Suppression`
(mode fichier), alors que `button8_Click` déclare une **locale** homonyme : `button9_Click` ne
supprime donc le fichier de rapport qu'après le mode fichier.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 13-27 | Public | 1 | 12 | 0 | méthode spéciale |
| `Liste_Click` | 29-61 | Public | 6 | 29 | 0 | handler GUI |
| `Fichier_Click` | 63-69 | Public | 1 | 5 | 0 | handler GUI |
| `CheckSpd_Click` | 71-80 | Public | 1 | 8 | 0 | handler GUI |
| `Selection_Click` | 82-91 | Public | 1 | 8 | 0 | handler GUI |
| `Choisir_Click` | 93-102 | Public | 3 | 8 | 0 | handler GUI |
| `Suppr_KeyPress` | 106-132 | Public | 8 | 21 | 0 | handler GUI |
| `Button5_Click` | 136-144 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 146-151 | Public | 1 | 4 | 0 | handler GUI |
| `Button3_Click` | 158-169 | Public | 2 | 9 | 0 | handler GUI |
| `Button4_Click` | 174-185 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 192-197 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 199-204 | Public | 1 | 4 | 0 | handler GUI |
| `Aff` | 206-237 | Public | 5 | 29 | 0 | portée réductible ? |
| `Colfam_KeyPress` | 242-262 | Public | 6 | 17 | 0 | handler GUI |
| `Colfam_Click` | 267-279 | Public | 2 | 11 | 0 | handler GUI |
| `SelectionArt` | 282-293 | Public | 2 | 9 | 0 | portée réductible ? |
| `ChkPrx` | 295-303 | Public | 7 | 7 | 0 | portée réductible ? |
| `art_man` | 308-345 | Public | 8 | 35 | 0 | portée réductible ? |
| `button8_Click` | 347-405 | Public | 18 | 56 | 0 | handler GUI |
| `Suppression` | 410-440 | Public | 8 | 28 | 0 | portée réductible ? |
| `button9_Click` | 442-447 | Public | 3 | 4 | 0 | handler GUI |
| `Button10_Click` | 449-453 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et choix du mode (GUI)

- **`_new()`** [spéciale] [mixte] : couleurs (`Utils.FColr`, `Utils.Coulfd`, résultats inutilisés),
  `SELECT * FROM Cbase.Table("TabParam")` → `Dte1 = Cdate_Aff(dteclec5)` (sans test `Available`),
  `type = "F"`, centrage. Pas d'appel à `Utils.Observers(Me)` (à vérifier pour le rejeu).
- **`Liste_Click()`** [handler] [mixte] (l. 29-61) : affiche la saisie manuelle ; si la table
  `Artsup` existe et n'est pas vide, propose de la supprimer ou de la compléter ; sinon (ou choix 1)
  `DROP TABLE IF EXISTS Artsup` puis `CREATE TABLE Artsup(art_code, art_design)`
  (`Utils.db.Engine()`).
- **`Fichier_Click()`, `CheckSpd_Click()`, `Selection_Click()`** [handlers] [GUI] : visibilité des
  panneaux.
- **`Choisir_Click()`** [handler] [GUI] : `Dialog.OpenFile` → `Fic`.
- **`Suppr_KeyPress()`** [handler du groupe `Suppr`] [GUI] : F2 sur `Cp1`/`Cp2` (Tags 3/4) →
  recherche fournisseur, sur `Art` (Tag 7) → recherche article ; Entrée sur `Art` → `art_man`.
- **`Button5_Click()`, `DateChooser1_Activate()`** [handlers] [GUI] : choix de `Dte1`.
- **`Button3_Click()`, `Button4_Click()`** [handlers] [GUI] : `TriCpt(Type="F", Sans_Solde, Me)`,
  retour par `Bsel`/`Bval` (posés par `TriCpt` via `Object.SetProperty`) → `Cp1`/`Cp2`.
- **`Button1_Click()`, `Button2_Click()`** [handlers] [GUI] : `Org` puis `Aff`.
- **`Aff()`** [portée : réductible] [mixte] : bascule la liste `Colfam`
  (`SELECT * FROM Cbase.Table("TabFam") ORDER BY code_fam`).
- **`Colfam_KeyPress()`** [handler] [GUI] ; **`Colfam_Click()`** [handler, `replay_dynamic` : doit
  rester `Public`] [GUI] : reporte la famille dans `Fam1` ou `Fam2` selon `Org`.
- **`SelectionArt()`** [réductible] [GUI] : `TriArticles(…, Me)` → `Art`, puis `art_man`.
- **`Button10_Click()`** [handler] [GUI] : `SelectionArt`.
- **`ChkPrx()`** [réductible] [GUI] : **code mort** (jamais appelé ; copie de `Suivi.Chkinput`).

### Liste manuelle

- **`art_man()`** [réductible] [mixte] (l. 308-345) : recherche du code saisi dans
  `Cbase.Table("TabArt")` par `art_code`, puis `art_cfour`, puis `art_cbarre` ; `Try INSERT INTO
  Artsup` (doublon → `Message.Error`) et ajout au texte `ListArt`. Même cascade de recherche que
  `DB_Connection.RecArt` (à comparer).

### Suppression

- **`button8_Click()`** [handler, CC 18] [mixte] (l. 347-405) :
  - ouvre `~/tmp/Artsuppr.txt` en écriture **avant** la confirmation (fichier tronqué et jamais
    fermé si l'utilisateur répond « Sortir » ou en mode fichier) ;
  - modes `Selection`/`CheckSpd` : `SELECT art_code, art_design FROM TabArt WHERE [art_suspendu =
    1 AND] art_fam > Fam1 AND art_fam < Fam2 AND art_four > Cp1 AND art_four < Cp2` : les bornes
    saisies sont **exclues** (SUPPRART-A02) ; mode `Liste` : `SELECT * FROM Artsup` (erreur si la
    table n'existe pas) ;
  - `ProgBar` interruptible (forme `New ProgBar(titre, n, Null, True, "", True)`, le 3e argument va
    au parent `Form`) ;
  - pour chaque article : `SELECT * FROM TabHisLigFac WHERE dtligbl_ligfac >= Dte1 AND code_ligfac
    = &2 UNION SELECT * FROM TabHisLigFacm …` ; en mode `Selection`, un article vendu après `Dte1`
    est refusé, mais la ligne de rapport est écrite **avant** l'affectation du message (l. 386-387) :
    le rapport contient une ligne vide ou le message de l'article précédent (SUPPRART-A01) ;
    sinon `Articles.art_Suppr(code, False)` ;
  - messages de synthèse et ouverture du rapport (`Editeur.Prog_Editeur`) ;
  - mode `Fichier` : `Suppression()`.
- **`Suppression()`** [réductible] [mixte] (l. 410-440) : lit `Fic` ligne à ligne, `art_Suppr`
  pour chaque code (sans `Trim`, lignes vides comprises), même rapport.
- **`button9_Click()`** [handler] [GUI] : supprime le rapport (membre `filename`) et ferme.

### Comportement de `Articles.art_Suppr` vu depuis cet écran (hors fichier)

- Le contrôle de stock `If stocke.value = True And qte.Text <> 0` (`Articles.class:4082`) lit les
  **contrôles du formulaire `Articles`** (auto-instance), pas l'article à supprimer : depuis
  `SupprArt`, il porte sur un formulaire non chargé et **ne bloque jamais** ; un article stocké
  avec un stock non nul est supprimé, contrairement au message affiché (« seuls les produits ayant
  un stock égal à zéro… ») (SUPPRART-A03). L'appel instancie aussi le formulaire `Articles`
  (constructeur coûteux) en arrière-plan.
- `DELETE IGNORE` et `SHOW TABLES LIKE` : syntaxe MySQL non traduite pour SQLite.
- Envoi éventuel au serveur (`Serveur.Pass("Art", "S", …)`) et suppression des documents GED.

## État global utilisé

- `Utils.db`, `Utils.FColr`, `Utils.Coulfd`, `Utils.Cdate_Aff`, `Cbase.Table` (`TabParam`,
  `TabFam`, `TabArt`, `TabHisLigFac`, `TabHisLigFacm`), `LDate`, `ProgBar`, `Editeur`,
  `Start.LocalSettings["/Coul/Focus|Fnets"]`, `Start.Son`.
- `Articles` (auto-instance, `art_Suppr`), `TriCpt`, `TriArticles`.
- Tables : `Fiches_Parametres`, `Fiches_Fam`, `Fiches_Art`, `Fiches_HistoLigfac[M]` (lecture) ;
  table de travail `Artsup` (DROP/CREATE/INSERT, hors `Cbase` et `db_control.csv`) ; toutes les
  tables écrites par `art_Suppr`.
- Fichiers : `~/tmp/Artsuppr.txt` (rapport), fichier texte choisi par l'utilisateur.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser la boucle « supprimer + compter + rapport » commune à `button8_Click` et
  `Suppression` (helper `SupprimeCode(code, hRapport) As Boolean` + synthèse commune).
- Construire la requête de sélection en une seule fois (condition `art_suspendu` optionnelle).
- Ouvrir le rapport après la confirmation et le fermer dans tous les cas (comportement visible
  identique : même contenu).
- Supprimer `ChkPrx`, `Tri`, `Coulfc`, `Coulfond`, `Frmt`.

### Commonalisation avec d'autres fichiers

- Liste unique des colonnes « code article » partagée avec
  [`Changefam.Modifart`](../../Utils/Changefam.class/architecture.md) et `Articles.art_Suppr`
  (voir tableau ci-dessus).
- `art_man` (recherche par code / code fournisseur / code-barre) ↔ `DB_Connection.RecArt` et
  `Changefam.art_man` : helper unique de recherche d'article.
- `ChkPrx` ↔ [`Suivi.Chkinput`](../Suivi.class/architecture.md).
- Formulaire « chemin fichier texte » (`Choisir_Click`) : même motif que `CompArt`, `ImportStk`,
  `Impclient`… (notes transverses).

### Réduction de portée

- `Aff`, `SelectionArt`, `art_man`, `Suppression` (et `ChkPrx` s'il n'est pas supprimé) →
  `Private` : aucun appelant externe (grep). Handlers inchangés ; `Colfam_Click` reste `Public`.

### Séparation traitement / GUI

- Extraire `SelectionArticles(mode, fam1, fam2, four1, four2) As Result` et
  `VenduApres(code, dte) As Boolean` (SQL sans contrôle) ; `button8_Click` garde la confirmation,
  la `ProgBar` et les messages.
- À terme, `art_Suppr` devrait recevoir l'article (et non lire le formulaire `Articles`) : c'est la
  correction d'A03, hors rework autonome.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Des clés étrangères (`ON DELETE RESTRICT`/`CASCADE`) sur les colonnes « code article »
  garantiraient l'absence d'orphelins et remplaceraient les contrôles manuels d'`art_Suppr`.
- La table de travail `Artsup` pourrait être une table temporaire ou une colonne « à supprimer »
  dans `Fiches_Art`.
