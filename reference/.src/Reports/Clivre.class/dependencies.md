# Clivre — Dépendances

> Source : `.src/Reports/Clivre.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Clivre.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `newPage`, `Entete`, `Entete2`, `Entete3`, `Lines`, `Lines2`, `Level2T`, `Level1`, `Level2`, `Level2E`, `Level3`, `Com`, `Level2F`, `Level4`, `Logo2`, `Logo`, `BasPage`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`newPage`, `Entete`, `Entete2`, `Entete3`, `Lines`, `Lines2`, `Level2T`, `Level1`, `Level2`, `Level2E`, `Level3`, `Com`, `Level2F`, `Level4`, `Logo2`, `Logo`, `BasPage`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Classe jamais référencée** (`jamais_reference`), confirmé :
  - `grep -rni "\bclivre\b" .src .project` : seule occurrence, le fichier lui-même ;
  - aucun `Class.Load`/`Object.New`/`Class[…]` sur un nom construit (seul `Class.Load` du projet :
    `Start.module:493`, liste fixe `LPrix`, `LScript`) ;
  - pas de `.form` ni de `.report` associé.
- Les 17 fonctions `unused` (`newPage`, `Entete`, `Entete2`, `Entete3`, `Lines`, `Lines2`,
  `Level2T`, `Level1`, `Level2`, `Level2E`, `Level3`, `Com`, `Level2F`, `Level4`, `Logo2`, `Logo`,
  `BasPage`) sont mortes par conséquence ; les appels `pdf.Logo`, `pdf.Lines`… du projet visent
  d'autres gabarits.
- Historique : dernier appelant `Caisse/Moulinage.class` (`New Clivre("P", "mm", "A4")`), supprimé
  par le commit `f442d721` (2018).
- Le binaire compilé `.gambas/CLIVRE` existe (compilation de toutes les classes du projet) ; il
  disparaîtra à la recompilation après suppression.
- Aucune contrainte d'ordre : la suppression peut se faire à tout moment, de préférence avant la
  création de `PdfLaurux` (décompte des doublons).
