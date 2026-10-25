# Cstocks — Dépendances

> Source : `.src/Reports/Cstocks.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cstocks.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Depots/Edsdepots.class` | `<type>`, `BasPage`, `Entete`, `Level1M`, `Level2M`, `Lines` |
| `.src/Gestion/Depots/ImpDepots.class` | `<type>`, `BasPage`, `Entete`, `Level1D`, `Level2D`, `Level3D`, `Level4D`, `Lines` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` | `<type>`, `BasPage`, `Entete`, `Level1E`, `Level2E`, `Level3E` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` | `<type>`, `BasPage`, `Entete`, `Entetefam`, `Level1`, `Level2`, `Level3`, `level3fam` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` | `<type>`, `BasPage`, `Entete`, `Entetefam`, `Level1`, `Level2`, `Level3`, `level3fam` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` | `<type>`, `BasPage`, `Entete`, `Level1NS`, `Level2NS`, `Level3NS` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` | `<type>`, `BasPage`, `Entete`, `Level1G`, `Level2G`, `Lines` |
| `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` | `<type>`, `BasPage`, `Entete`, `Level1E`, `Level2E`, `Level3E` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Level3` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` | `<type>`, `BasPage`, `Entete`, `Level1NS`, `Level2NS`, `Level3NS` |
| `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` | `<type>`, `BasPage`, `Entete`, `Level1G`, `Level2G`, `Lines` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn "As Cstocks\|New Cstocks"`) : 11 écrans, tous avec
  `New Cstocks("Portrait", "mm", "A4")` (arguments du constructeur de `PdfWriter`) :
  `Ecarts`, `Edinv`, `Edinv1`, `Ednsaisis`, `Geninv` (`Inventaires/Fin-annee`), `EcartsT`,
  `EdinvT`, `EdnsaisisT`, `GeninvT` (`Inventaires/Tournant`), `ImpDepots`, `Edsdepots`
  (`Depots`). Liste de l'heuristique complète.
- **Écrans morts** : `Edinv1` (EDINV1-A01) et `EdinvT` (EDINVT-A01) n'utilisent que des méthodes
  aussi appelées par `Edinv` : leur suppression ne rend aucune méthode de `Cstocks` morte.
  L'heuristique rattachait à tort les `pdf.Level1/2/3` d'`EdinvT` à des fonctions locales
  homonymes (notes transverses, lot inventaires) ; ils visent bien `Cstocks`.
- **Homonymes** : `Level1`, `Level2`, `Level3`, `Lines`, `Entete` existent dans d'autres gabarits ;
  le rattachement à `Cstocks` est sûr car les variables `pdf` de ces écrans sont typées `Cstocks`.
- **Comportements portés par les appelants** (non modifiés par le rework du gabarit) : seuils de
  saut de page 270 (`Edinv`), 280 (`ImpDepots`, `Edsdepots`), 283 (`Ecarts*`, `Ednsaisis*`), 288
  (`Geninv*`) ; `Edsdepots` n'appelle pas `BasPage` au saut de page des entrées (ligne 226) ;
  `EcartsT:47`/`EdnsaisisT:46` testent `rResult.Available` après une erreur (anomalies de ces
  écrans).
- Aucun appel dynamique, aucune dépendance circulaire. **Ordre de rework** : après la base
  `PdfLaurux` (CARTICLES-004) ; le squelette `DebutEdition`/`SautDePageSi` (CSTOCKS-006) avant
  les reworks de factorisation des inventaires (socle `Inventaire`, GENINV-006) et des dépôts.
