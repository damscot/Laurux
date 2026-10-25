# Ednsaisis — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` — classe, formulaire associé `Ednsaisis.form`
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1`, `Level2`, `Level3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1NS`, `Level2NS`, `Level3NS` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `CDec`, `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Inv`

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1`, `Level2`, `Level3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu93_Click` (`Fmenu.class:1085`, `Ednsaisis.Show`).
- `unused` / `scope_reducible` = `Level1`, `Level2`, `Level3` : confirmés (code mort).
- Tables par littéral : `Fiches_Inv`, `Fiches_Art`. `Cstocks` : `Level1NS`, `Level2NS` (6 paramètres,
  appelé `level2NS`), `Level3NS`, `Entete`, `Baspage`.
- Aucun appel dynamique ; aucune écriture en base.
