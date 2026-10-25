# Edregul — Dépendances

> Source : `.src/Gestion/Impressions/Edregul.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edregul.class` — classe, formulaire associé `Edregul.form`
- Handlers GUI détectés : 4
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `date2_GotFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `date2_GotFocus`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Footer`, `Level11`, `Level12`, `Ligne` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Mvtexp`

### Membres Public sans usage externe détecté (portée réductible ?)

`date1_LostFocus`, `date2_GotFocus`, `date2_LostFocus`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:1040` (`Menu91_Click`, `Edregul.Show`).
- `date2_GotFocus` : `handlers_inactifs` et `unused` confirmés (`Date2` est dans le groupe `Cmpt`
  du `.form`) → code mort. `date1_LostFocus`, `date2_LostFocus` : appelés seulement par
  `Cmpt_KeyPress` (grep) → réductibles en `Private`.
- Utilise `Carticles` (`.src/Reports/Carticles.class` : `Entete`, `Level11`, `Level12`, `Ligne` ;
  `Footer`, `Output`, `AliasNbPages` hérités de `PdfWriter`) et `Visualiseur.Prog`.
- `Fiches_Mvtexp` est écrite par `Mvtex`, `ValidinvT`, `Articles`, `Changefam`, lue par `Cstock` et
  `Stockmvt`, purgée aussi par `Epurmvtexp` : la purge de cet écran influe sur l'historique de
  stock (`Stockmvt`) — à prendre en compte dans le scénario de test.
- Boutons du `.form` sans handler : `Button1` (aide), `Button6`.
- Contrainte d'ordre : rework conjoint avec `Edregulprdc` (EDREGUL-004 / EDREGULPRDC-004).
