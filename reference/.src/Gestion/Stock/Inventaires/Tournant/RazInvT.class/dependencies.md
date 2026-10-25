# RazInvT — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` — classe, formulaire associé `RazInvT.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_InvT`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu233_Click` (`Fmenu.class:1983`, `RazInvT.ShowModal()`).
- Table : `Fiches_InvT` via `Cbase.Table("TabInvT")` (table de travail, absente de `db_control.csv`).
- Consommateurs indirects de `Fiches_InvT` : `SaisieInvT`, `ValidinvT`, `EcartsT`, `EdnsaisisT`,
  `Edinv("T")`, `EditStkDepart.class:32`, `Articles.class:4134`, `Changefam.class:526`.
- Signaux `deps.py` : aucun — vérifié. Aucun appel dynamique.
- À reworker avec `RazInv` (commonalisation).
