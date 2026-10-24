# Enrgcp — Dépendances

> Source : `.src/Utils/Enrgcp.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Enrgcp.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/FClientcarte.class` | `Ecp` |
| `.src/Gestion/Facturation/Facture.class` | `Ecp` |
| `.src/Gestion/Tables/FClient.class` | `Ecp` |
| `.src/Gestion/Tables/FFournisseur.class` | `Ecp` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Cpostaux`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep `Enrgcp\.Ecp` : `Caisse/FClientcarte.class:586,598`,
  `Gestion/Facturation/Facture.class:1717`, `Gestion/Tables/FClient.class:1454,1476`,
  `Gestion/Tables/FFournisseur.class:1383,1406`.
- Duplication de code : `Utils/Exports-Imports/Impcpostaux.class:36-38`.
- Table : `Fiches_Cpostaux` via `Cbase.Table("TabCpostaux")`.
- Aucun appel dynamique, aucun cycle.
