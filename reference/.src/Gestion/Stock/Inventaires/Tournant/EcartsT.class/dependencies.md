# EcartsT — Dépendances

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` — classe, formulaire associé `EcartsT.form`
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
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `PointBase`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_InvT`

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1`, `Level2`, `Level3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu98_Click` (`Fmenu.class:1109`, `EcartsT.Show`).
- `unused` / `scope_reducible` = `Level1`, `Level2`, `Level3` : confirmés par grep (code mort,
  dessin `Draw` remplacé par `Cstocks.Level*E`).
- Tables par littéral : `Fiches_InvT`, `Fiches_Art`. `Cstocks` (`.src/Reports/Cstocks.class`) :
  `Entete`, `Level1E`, `Level2E` (9 paramètres), `Level3E`, `Baspage`.
- Aucun appel dynamique ; aucune écriture en base.
