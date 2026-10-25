# Cfacture — Dépendances

> Source : `.src/Caisse/Reports/Cfacture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Reports/Cfacture.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1T`, `Logo`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<type>`, `Com`, `Entete`, `Entete2`, `Entete3`, `Level1`, `Level2F`, `Level2T`, `Level4`, `Lines`, `Lines2`, `Logo2`, `newPage` |
| `.src/Caisse/Moulinage.class` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Level2E`, `Level3`, `Lines2`, `newPage` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Caisse` | `Ba4` |
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `GetFormat`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetMargins`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1T`, `Logo`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants confirmés par `grep`** : `Caisse` (`Defaut_Tk` 5206-5308, `Defaut_Facture`
  6620-6770 : `New Cfacture("P", "mm", "A4" | "80mm")`) et `Moulinage.Livre_caisse`
  (`Moulinage.class:167`, `New Cfacture("P", "mm", Format)`, `Format` = `"A4"` pour les deux
  appelants `Moulinage.class:1444` et `Caisse.class:6915`).
- **`unused` vérifiés** : `Level1T` (les `pdf.Level1T(Posy)` de `Traites.class:54/74` et
  `Lcr.class:551/574` portent sur `Ccompta`) et `Logo` (`Bordereaux.class:153` appelle
  `Cbordereaux.Logo`). Code mort réel → CFACTURE-002.
- **`Caisse.Ba4`** (`Caisse.class:140`, `Public Ba4 As Boolean`) est lu 10 fois ; `deps.py` le
  voit comme un membre ordinaire, sans signaler qu'il s'agit de l'**auto-instance** du formulaire
  (la caisse affichée est un `New Caisse`, voir CFACTURE-A01). C'est une dépendance **circulaire** `Caisse` ↔ `Cfacture` (Caisse instancie Cfacture, Cfacture
  lit Caisse) et une dépendance cachée `Moulinage` → `Caisse` via Cfacture.
- `PdfWriter` (classe parente, `.src/Reports/PdfWriter.class`) : `_new(orientation, unit, form)`,
  `GetFormat`, `SetMargins`, `AddPage`, `SetXY`, `SetY`, `SetFont`, `Cell`, `Line`,
  `SetLineWidth`, `SetFillColor`, `Image`, `PageNo`. Toute évolution de `PdfWriter` (lot Reports)
  doit repasser les tests CFACTURE.
- Aucun SQL, aucun appel dynamique.
- **Ordre de rework** : CFACTURE-002/003 sont indépendants. L'anomalie A01, si elle est validée,
  se traite avec `Caisse` (remplacement de `Caisse.Ba4` par un état interne) et touche aussi
  `Moulinage` (rendu du livre de caisse).
