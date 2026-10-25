# Htickets — Dépendances

> Source : `.src/Reports/Htickets.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Htickets.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Footer`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/ArchivesTck.class` | `<type>`, `Entete`, `Entete2`, `Level4` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Footer`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique vérifié** : `ArchivesTck` (`Private pdf As Htickets`,
  `New Htickets("Portrait", "mm", "A4")` dans `Button4_Click`). Liste complète.
- **Code mort vérifié** : `Footer` (aucun `pdf.Footer` dans `ArchivesTck`, aucune chaîne
  dynamique ; signaux `unused` et « portée réductible ») ; `_free` vide.
- **Paramètre ignoré** : `Entete2.PosX` (appels `ArchivesTck:599` et `:654`).
- **Pagination** : ni le gabarit ni `ArchivesTck` ne gèrent le saut de page ; le saut automatique
  de `PdfWriter.Cell` s'applique (HTICKETS-A01).
- Plusieurs appels `Level4` d'`ArchivesTck` sont protégés par `Try` : une erreur de rendu y est
  ignorée silencieusement.
- Aucun appel dynamique, aucune dépendance circulaire. **Ordre de rework** : indépendant ;
  HTICKETS-003 dans le même commit que la mise à jour d'`ArchivesTck`.
