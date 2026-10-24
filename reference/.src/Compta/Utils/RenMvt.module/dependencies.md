# RenMvt — Dépendances

> Source : `.src/Compta/Utils/RenMvt.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/RenMvt.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ren`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `Run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ren`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Lancement** : uniquement par `Prgm.class:82` (`If Prog = "RenMvt" Then RenMvt.Run()`), écran
  « Appel programme » (mot de passe administrateur si `Admin`, voir PRGM-A01).
- `Ren` : aucun appelant (grep `RenMvt.Ren`, `"Ren"`) ; portée réductible confirmée → code mort.
- Tables vues par `deps.py` (littéraux) ; aucune via `Cbase`.
- Aucun appel dynamique ; aucune dépendance circulaire. Le retrait du script se fait avec
  `Prgm` (même commit, PRGM-A02).
