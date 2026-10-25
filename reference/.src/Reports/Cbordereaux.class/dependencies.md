# Cbordereaux — Dépendances

> Source : `.src/Reports/Cbordereaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cbordereaux.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Bordereaux.class` | `<type>`, `Entete`, `Entete2`, `Level5`, `Ligne`, `Logo`, `TitreB` |
| `.src/Compta/Impressions/BordereauxC.class` | `<type>`, `Entete`, `Level6`, `Level7`, `Level8`, `Ligne`, `TitreB` |
| `.src/Gestion/Impressions/Edpaiement.class` | `<type>`, `EnteteP`, `Footer`, `Level1`, `Level2`, `Level3`, `Ligne` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Trois appelants, chacun par `New Cbordereaux("Portrait", "mm", "A4")` : `Caisse/Bordereaux:59`,
  `Compta/Impressions/BordereauxC:256` et `:262`, `Gestion/Impressions/Edpaiement:140`.
- Arités vérifiées : aucun écart (`BordereauxC:276` `Pdf.Level7(Grd1[inlg, 3].text, …, PosY)` a bien
  5 arguments ; les virgules des indices `[ , ]` ne sont pas des séparateurs).
- `Footer` surcharge `PdfWriter.Footer` (même signature) ; `deps.py` le compte comme un membre
  propre utilisé par `Edpaiement`. Le crochet n'est pas appelé par `PdfWriter` aujourd'hui.
- `Logo(Logo)` est le seul `Logo` du projet appelé depuis l'extérieur (`Bordereaux:153`).
- Pas de `.form`, pas de SQL, aucun appel dynamique.
- Ordre de rework : `PdfWriter` (sans réactiver `Header`/`Footer`) → `PdfLaurux` → `Cbordereaux`
  → appelants.
