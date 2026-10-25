# ValidinvT — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` — classe, formulaire associé `ValidinvT.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_HisInvT`, `Fiches_InvT`, `Fiches_Mvtexp`, `Fiches_Parametres`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu100_Click` (`Fmenu.class:1123`, `ValidinvT.Show`).
- Tables par variables `Tab`..`Tab4` (littéraux) : `Fiches_Art`, `Fiches_Parametres`,
  `Fiches_InvT`, `Fiches_HisInvT`, `Fiches_Mvtexp`.
- Consommateurs des écritures : `Cstock.Calc_stock` (`Fiches_HisInvT` + `Fiches_Mvtexp`),
  `Stockmvt` (`Fiches_Mvtexp`), `Changefam` (renommage de codes dans `Fiches_HisInvT`).
- `Fiches_HisInvT` est aussi créée par `LauruxMaj.Maj303` et vidée par `Validinv`.
- Signaux `deps.py` : aucun (vérifié). Aucun appel dynamique.
- Ordre : avec `Validinv` (sauvegarde commune), après le module `Inventaire`.
