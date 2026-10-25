# Carticles — Dépendances

> Source : `.src/Reports/Carticles.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Carticles.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level3bis`, `EnteteTC`, `Level2TC`, `Level3TC`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/EdArt1.class` | `<type>`, `Entete`, `Footer`, `Level10`, `Level6`, `Level6M`, `Level6bis`, `Level7`, `Level7M`, `Level7bis`, `Ligne`, `Photo` |
| `.src/Gestion/Impressions/EdArt2.class` | `<type>`, `Entete`, `Footer`, `Level8`, `Level8bis`, `Level9`, `Level9bis`, `Ligne2`, `Photo` |
| `.src/Gestion/Impressions/EdArt3.class` | `<type>`, `Entete`, `Footer`, `Level10`, `Level6`, `Level6bis`, `Level7`, `Level7bis`, `Ligne`, `Photo` |
| `.src/Gestion/Impressions/EdRup.class` | `<type>`, `Entete`, `Footer`, `Level13`, `Level13R`, `Level13V`, `Level14`, `Level14V`, `Ligne` |
| `.src/Gestion/Impressions/EdStk.class` | `<type>`, `Entete`, `Level1`, `Level2`, `Level3`, `Level4`, `Level5` |
| `.src/Gestion/Impressions/Edmo.class` | `<type>`, `Entete`, `Footer`, `Level1MO`, `Level2MO` |
| `.src/Gestion/Impressions/Edregul.class` | `<type>`, `Entete`, `Footer`, `Level11`, `Level12`, `Ligne` |
| `.src/Gestion/Impressions/Edregulprdc.class` | `<type>`, `Entete`, `Footer`, `Level11`, `Level12`, `Ligne` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level3bis`, `EnteteTC`, `Level2TC`, `Level3TC`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés par `grep -rn "New CArticles\|As Carticles"`** : 8 éditions de
  `.src/Gestion/Impressions` (`EdArt1`, `EdArt2`, `EdArt3`, `EdRup`, `EdStk`, `Edmo`, `Edregul`,
  `Edregulprdc`), toutes par `Dim pdf As Carticles` + `New CArticles("Portrait", "mm", "A4")`
  (casse différente du nom de fichier, sans effet en Gambas). Les arguments du `New` vont au
  constructeur de `PdfWriter`. La liste de l'heuristique est complète.
- **`EdArt2` est mort** (EDART2-A01, aucun appelant depuis `29df3a6d`) : `Level8`, `Level8bis`,
  `Level9`, `Level9bis` et `Ligne2` n'ont pas d'autre utilisateur (vérifié : les `Level8`/`Level9`
  de `Ligcli`, `FEditrel`, `BordereauxC`, `FRelFacture` et le membre `ligne2` d'`ObjFac` visent
  d'autres classes). Ils deviennent du code mort si l'anomalie est validée (CARTICLES-003).
- **Code mort vérifié** (`grep -rniw` sur `.src`, aucune chaîne dynamique) : `Level3bis`,
  `EnteteTC`, `Level2TC`, `Level3TC` (signal `unused` et « portée réductible » de l'heuristique :
  traités en suppression, CARTICLES-002).
- **Surcharge** : `Footer` redéfinit `PdfWriter.Footer` (vide, jamais appelée par `PdfWriter`
  depuis que l'appel automatique est commenté dans `AddPage`/`Close`) ; seuls les écrans
  l'appellent explicitement. `EdStk` ne l'appelle pas.
- **`Photo`** est aussi appelé par `EdArt1`/`EdArt3` (vivants) : il reste après EDART2-A01.
- **Erreur d'exécution** : `Level6bis` lève « Undefined font » (CARTICLES-A01) ; appelants
  touchés `EdArt3` (mode photo accessible) et `EdArt1` (case `Phot` invisible).
- Aucun appel dynamique, aucune dépendance circulaire. Dépendance vers `PdfWriter` (héritage) :
  tout rework de `PdfWriter` qui change `Cell`/`SetFont`/`Image` se répercute sur les 8 éditions.
- **Ordre de rework** : création de la base commune `PdfLaurux` (CARTICLES-004, à placer avant
  les autres gabarits en phase 3) ; puis `EnteteTarif`/`FormatAligne` avant EDART1-006/007,
  EDART3-*, EdStk, EdRup, EdMat ; suppression de `Level8`… après EDART2-A01.
