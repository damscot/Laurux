# Ecarts — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` — classe, formulaire associé `Ecarts.form`
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1`, `Level2`, `Level3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1E`, `Level2E`, `Level3E` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `PointBase`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Inv`

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1`, `Level2`, `Level3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu83_Click` (`Fmenu.class:1070`, `Ecarts.Show`).
- `unused` / `scope_reducible` = `Level1`, `Level2`, `Level3` : confirmés par grep (code mort,
  dessin `Draw` remplacé par `Cstocks.Level*E`).
- Tables par littéral : `Fiches_Inv`, `Fiches_Art`. `Cstocks` (`.src/Reports/Cstocks.class`) :
  `Entete`, `Level1E`, `Level2E` (9 paramètres), `Level3E`, `Baspage`.
- Aucun appel dynamique ; aucune écriture en base.
