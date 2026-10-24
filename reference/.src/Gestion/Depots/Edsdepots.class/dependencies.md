# Edsdepots — Dépendances

> Source : `.src/Gestion/Depots/Edsdepots.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Depots/Edsdepots.class` — classe, formulaire associé `Edsdepots.form`
- Handlers GUI détectés : 6
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `date2_GotFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `date2_GotFocus`, `Level1`, `Level2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cstocks` | `<type>`, `BasPage`, `Entete`, `Level1M`, `Level2M`, `Lines` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Sdepots`

### Membres Public sans usage externe détecté (portée réductible ?)

`date1_LostFocus`, `date2_GotFocus`, `date2_LostFocus`, `Level1`, `Level2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée : `Fmenu.class:2176` et `Prgm.class:76` (`If Prog = "Edsdep"`).
- Utilise `Cstocks` (`.src/Reports/Cstocks.class` : `Entete`, `Level1M`, `Level2M`, `Lines`,
  `BasPage`, `Output`) et `Visualiseur.Prog`.
- `Fiches_Sdepots` est aussi lue par `Cstock.module:98` (recalcul du stock du dépôt `01` à partir
  des mouvements) : une purge effective modifierait ce recalcul ; elle est aujourd'hui inopérante
  (colonne `datesortie` inexistante).
- `date2_GotFocus` : handler inactif (contrôle groupé `Cmpt`) ; `Level1`, `Level2` : jamais
  appelées (`unused`). `date1_LostFocus`/`date2_LostFocus` : pseudo-handlers appelés par
  `Cmpt_KeyPress`.
- Boutons `Button1` et `Button6` du `.form` sans aucun handler.
