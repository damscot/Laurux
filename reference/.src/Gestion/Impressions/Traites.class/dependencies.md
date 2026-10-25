# Traites — Dépendances

> Source : `.src/Gestion/Impressions/Traites.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Traites.class` — classe, formulaire associé `Traites.form`
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1`, `Level2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level1T`, `Level2T` |
| `DB_Connection` | `AutoIncrement`, `Engine`, `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Traites`

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1`, `Level2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée unique : `Fmenu.class:2134` (`Menu265_Click`, `Traites.Show()`).
- `Level1`, `Level2` : `unused` confirmé par grep (anciennes routines `Draw`).
- Utilise `Ccompta` (`.src/Reports/Ccompta.class` : `Entete`, `Level1T`, `Level2T`, `BasPage`,
  `Output`, `AliasNbPages`) et `Visualiseur.Prog`.
- Table `Fiches_Traites` : écrite par `EcrAuto.class:558` (`INSERT … value`), lue/vidée aussi par
  `Lcr.class:383-387` et `Lcr.Imp_Traites` (`TRUNCATE`, `Lcr.class:583`), créée et modifiée par
  `LauruxMaj` (`Maj217`, colonnes `nom`/`acceptee`/`ecartee` ajoutées ensuite). Sa structure de
  référence est dans `db_control.csv` (lignes `Fiches_Traites`).
- Duplication avec `Lcr.Imp_Traites` : rework conjoint recommandé (TRAITES-003 dans le même commit
  qu'un rework de `Lcr`).
