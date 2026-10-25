# RazInv — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` — classe, formulaire associé `RazInv.form`
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

`Fiches_Inv`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu232_Click` (`Fmenu.class:1977`, `RazInv.ShowModal()`, auto-instance).
- Table : `Fiches_Inv` via `Cbase.Table("TabInv")` (table de travail, absente de `db_control.csv`).
- Consommateurs indirects de `Fiches_Inv`, rendus inopérants par la suppression : `Geninv`
  (réimpression), `SaisieInv`, `Validinv` (dont `button4_Click`, compta matière), `Ecarts`,
  `Ednsaisis`, `Edinv("F")`, `Gestion/option/EditStkDepart.class:30`, `Articles.class:2794/4130`
  (contrôle avant suppression d'article), `Changefam.class:525` (renommage de code).
- Signaux `deps.py` : aucun (`arity_errors`, `unused`, `handlers_inactifs`, `replay_*`,
  `scope_reducible` vides) — vérifié.
- Aucun appel dynamique. Rework indépendant, à faire avec `RazInvT` pour la commonalisation.
