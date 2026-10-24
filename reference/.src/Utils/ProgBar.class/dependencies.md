# ProgBar — Dépendances

> Source : `.src/Utils/ProgBar.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/ProgBar.class` — classe, formulaire associé `ProgBar.form`
- Handlers GUI détectés : 4
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Disable_Detail`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/RazDevis.class` | `<type>`, `Avancement` |
| `.src/Archivages/RazHistoFac.class` | `<type>`, `Avancement` |
| `.src/Archivages/RazHistoFbl.class` | `<type>`, `Avancement` |
| `.src/Archivages/RazHistoTk.class` | `<type>`, `Avancement` |
| `.src/Archivages/RazRlvb.class` | `<type>` |
| `.src/Caisse/Moulinage.class` | `<type>`, `Avancement` |
| `.src/Communs/LauruxMaj.module` | `<type>`, `Avancement`, `Finalize` |
| `.src/Compta/Clotures/FCloture.class` | `<type>`, `Avancement` |
| `.src/Compta/Clotures/FClotureAn.class` | `<type>`, `Avancement`, `Finalize` |
| `.src/Compta/Extrait.class` | `<type>` |
| `.src/Compta/Impressions/Anomalies.class` | `<type>`, `Avancement`, `Enable_Detail`, `IsStoppable` |
| `.src/Compta/Impressions/ExportA47.class` | `<type>`, `Avancement` |
| `.src/Compta/Relances/FEditrel.class` | `<type>`, `Avancement` |
| `.src/Compta/Utils/impfec.class` | `<type>`, `Avancement` |
| `.src/Gestion/ClotureF.class` | `<type>`, `Avancement` |
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `Avancement` |
| `.src/Gestion/Entrées/DateTar.class` | `<type>`, `Avancement` |
| `.src/Gestion/Facturation/SaiReg.class` | `<type>`, `Avancement` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `Avancement` |
| `.src/Gestion/Stockmvt.class` | `<type>` |
| `.src/Gestion/SupprArt.class` | `<type>`, `Avancement` |
| `.src/Gestion/option/Caleditcmat.class` | `<type>`, `Avancement` |
| `.src/Gestion/option/ObjFacB.class` | `<type>`, `Avancement` |
| `.src/Utils/DB_Sanity.class` | `<type>`, `Avancement` |
| `.src/Utils/GedR.class` | `<type>`, `Avancement` |
| `.src/Utils/LGed.class` | `<type>`, `Avancement` |
| `.src/Utils/Sha1Calc.module` | `<type>`, `Avancement`, `Finalize` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `Observers` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Disable_Detail`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Formulaire associé : `.src/Utils/ProgBar.form` (`ProgressionBar`, `Title`, `DetailLog`,
  `elemdone`, `Pause`, `Stop`). Pas un `UserControl` : aucun autre `.form` ne l'instancie.
- La liste « Utilisé par » est exacte (vérifiée par `grep -rn 'New ProgBar'`). Quatre appelants
  créent une barre « indéterminée » (`nbelem = 0`) sans appeler `Avancement` :
  `Stockmvt.class:485,712`, `Caleditcmat.class:284`, `Extrait.class:1289`. `RazRlvb` ne fait que
  déclarer le type.
- Méthodes héritées utilisées par les appelants et non indexées par `deps.py` : `Show`, `Close`,
  `Delete`.
- Le 3ᵉ argument du constructeur est passé à `Window._new` (parent) : vérifié par expérience avec
  `gbx3` 3.19 (classe fille avec `_new(a, b, Optional …)` héritant d'une classe à `_new(Optional p)`).
- Portée réductible proposée : `Disable_Detail` → exact (aucun appelant, code mort).
- Pas de dépendance circulaire. Rework indépendant ; toute modification de signature toucherait
  27 fichiers (dont `LauruxMaj`, 18 instanciations).
