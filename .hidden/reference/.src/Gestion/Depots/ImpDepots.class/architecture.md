# ImpDepots — Architecture

> Source : `.src/Gestion/Depots/ImpDepots.class`

## Vue d'ensemble

Écran d'**impression du stock d'un dépôt** : liste des articles de `Fiches_StkDepots` pour le
dépôt choisi, chiffrée (prix HT, TVA, prix TTC, quantité) ou non chiffrée (quantité seule), en PDF
(`Cstocks`, `~/tmp/Depots.pdf`, visualisé par `Visualiseur.Prog`). Ouvert par `Fmenu.class:2170`
(`ImpDepots.show()`) et par `Prgm.class:75` (programme `Impdep`).

Contrôles : `Code` (code dépôt, F2 ou `ToggleButton1` pour la liste `Coldep` des dépôts **hors
`01`**), `Libelle` (lecture seule), `RadioButton1` (chiffrée, par défaut) / `RadioButton2`,
boutons `Button2` (imprimer), `Button3` (quitter) et `Button1` (aide, **sans handler**). Aucun
contrôle groupé. **Pas d'appel à `Utils.Observers`** : l'écran n'est pas instrumenté pour le
log/replay.

Nature : **mixte** (requêtes + mise en page PDF dans `Button2_Click`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `PosY` | var | Private |  | Integer | 3 |
| `Filename` | var | Private |  | String | 4 |
| `Coulfond` | var | Private |  | New String[] | 5 |
| `son` | var | Private |  | Integer | 6 |
| `pdf` | var | Private |  | Cstocks | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-19 | Public | 1 | 9 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 22-32 | Public | 2 | 9 | 0 | handler GUI |
| `aff_Depot` | 34-48 | Public | 3 | 12 | 0 | portée réductible ? |
| `Coldep_Click` | 50-57 | Public | 1 | 6 | 0 | handler GUI |
| `Code_KeyPress` | 59-70 | Public | 5 | 10 | 0 | handler GUI |
| `Code_GotFocus` | 72-76 | Public | 2 | 3 | 0 | handler GUI |
| `Code_LostFocus` | 78-82 | Public | 2 | 3 | 0 | handler GUI |
| `Cman` | 84-91 | Public | 2 | 5 | 0 | portée réductible ? |
| `Button3_Click` | 93-97 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 99-171 | Public | 11 | 70 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : GUI] : centre, `Coulfond = Utils.Coulfd()` (jamais
  utilisé), colonnes de `Coldep`.
- **`ToggleButton1_Click()`** [handler] : affiche/masque la liste des dépôts (`aff_Depot`).
- **`aff_Depot()`** [portée : réductible] [nature : mixte] : `SELECT * FROM <TabDepots> where code
  <> &1 order by code` (`"01"` exclu de la liste, mais saisissable au clavier).
- **`Coldep_Click()`** [handler] : dépôt choisi → zones, liste masquée. Rejoué par `ReplayObserver`
  (`replay_dynamic`) : **reste `Public`**.
- **`Code_KeyPress()`** [handler] : F2 → liste ; Entrée/Tab → `Cman`.
- **`Code_GotFocus()` / `Code_LostFocus()`** [handlers] : `Utils.ObsGotf`/`ObsLstf` (sous `Try`).
- **`Cman()`** [portée : réductible] [nature : mixte] : libellé du dépôt saisi (rien si inconnu).
- **`Button3_Click()`** [handler] : ferme.
- **`Button2_Click()`** [handler] [nature : mixte] (CC 11, max du fichier) : `Shell "cd ~"` (sans
  effet) ; crée **toujours** le PDF et son en-tête (avant de savoir s'il y a des articles) ;
  `SELECT * FROM <TabStkDepots> where coded = &1 order by codea`, puis **une requête par ligne**
  sur `<TabArt>` (N+1) ; pour chaque article trouvé : prix formatés selon `art_nbd`
  (`Utils.Find_nbdec`, espace ajoutée si 2 décimales), ligne `level4D` (chiffrée) ou `level2D`,
  saut de page à 280 ; pied, sortie, visualisation. Si le dépôt n'a aucun article : message puis
  `Draw.End` sans `Draw.Begin` (vestige de l'ancienne impression `Draw`, erreur probable, à
  confirmer). Le code dépôt n'est pas vérifié (dépôt inconnu → « aucun article »).

## État global utilisé

- `Utils.db`, `Utils.Coulfd`, `Utils.ObsGotf`, `Utils.ObsLstf`, `Utils.Find_nbdec`,
  `Cbase.Table` (`TabDepots`, `TabStkDepots`, `TabArt`) ; `Cstocks`, `Visualiseur` ; `Start.Son`,
  `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Une seule requête `SELECT … FROM <TabStkDepots> JOIN <TabArt> ON art_code = codea WHERE coded = &1
  ORDER BY codea` (SQL modifié, même PDF ; les lignes de stock sans article restent ignorées).
- Supprimer `Coulfond`, le `Shell "cd …"`, le `Draw.End` (si A01 validée).

### Commonalisation avec d'autres fichiers

- `aff_Depot`, `Coldep_Click`, `Code_KeyPress`, `Cman` : copies dans
  [MvtDepots](../MvtDepots.class/architecture.md) et [Sdepots](../Sdepots.class/architecture.md)
  (module `Depot` proposé dans [Depots](../Depots.class/architecture.md)).
- Formatage des prix selon `art_nbd` : présent dans les éditions de stock et `Facture` ; voir
  [LPrix](../../../Utils/LPrix.class/architecture.md).
- Boucle PDF commune avec [Edsdepots](../Edsdepots.class/architecture.md).

### Réduction de portée

`aff_Depot`, `Cman` → `Private`.

### Séparation traitement / GUI

`StockDepot(sCode) As Result` (requête jointe) appelée par `Button2_Click`, qui garde la mise en page.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère `Fiches_StkDepots.codea` → `Fiches_Art.art_code` (lignes orphelines aujourd'hui
  ignorées silencieusement).
