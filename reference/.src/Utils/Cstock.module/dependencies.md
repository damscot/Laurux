# Cstock — Dépendances

> Source : `.src/Utils/Cstock.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Cstock.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` | `Calc_stock` |
| `.src/Utils/Calcstock.class` | `Calc_stock` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Calcstock` | `<hérité>` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Entrecpt`, `Fiches_HisEntTickets`, `Fiches_HisInvT`, `Fiches_HisLigTickets`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Ligrecpt`, `Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_Parametres`, `Fiches_Sdepots`

### Membres Public sans usage externe détecté (portée réductible ?)

`date_ex`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Dépendance manquée par l'heuristique** : `Cstock` lit les contrôles publics du formulaire
  `Calcstock` (`Calcstock.Cbx.Value` ligne 28, `Calcstock.Cbx2.Value` ligne 31). Il existe donc une
  **dépendance circulaire** `Calcstock` ↔ `Cstock`, et une dépendance cachée de `Validinv` envers
  le formulaire `Calcstock` (instance automatique créée en arrière-plan).
- Appelants confirmés par grep : `Calcstock.class:84,88,94` et `Validinv.class:190`.
- Tables via `Cbase.Table` (LOCK et `UPDATE`) : `TabArt`, `TabBl`, `TabLigbl`, `TabBlM`, `TabLigblM`,
  `TabHisFac`, `TabHisLigFac`, `TabHisFacm`, `TabHisLigFacm`, `TabMvtexp`, `TabEntrecpt`,
  `TabLigrecpt`, `TabHEntTck`, `TabHLigTck`, `TabSdepots`. En dur : `Fiches_HisInvT`,
  `Fiches_Mvtexpdc`, `Fiches_Parametres` et **toutes** les tables de la requête `UNION ALL`.
- **Ordre de rework** : `Cstock` et `Calcstock` dans le même commit pour le paramètre de mode ;
  `Validinv` (appelant) mis à jour dans ce même commit.
