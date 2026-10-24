# CPrix — Dépendances

> Source : `.src/Utils/CPrix.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/CPrix.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `CTva` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `Cascade` |
| `.src/Gestion/Stock/Tarifs/MajTarifM.class` | `CTva`, `Cascade` |
| `.src/Gestion/Tables/Articles.class` | `CTva`, `Cascade` |
| `.src/Gestion/Tables/ConsultArt.class` | `CTva` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Tvaav`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep : `CPrix.Cascade` → `Gestion/Stock/Tarifs/Impart.class` (3),
  `Gestion/Stock/Tarifs/MajTarifM.class` (6), `Gestion/Tables/Articles.class` (6) ; `CPrix.CTva` →
  `Gestion/Facturation/Facture.class:7606`, `MajTarifM.class:985,988`, `Articles.class:4607`,
  `ConsultArt.class:447`.
- Table : `Fiches_Tvaav` (`TabTvav`).
- Aucun appel dynamique ni cycle.
