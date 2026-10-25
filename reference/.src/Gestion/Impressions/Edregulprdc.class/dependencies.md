# Edregulprdc — Dépendances

> Source : `.src/Gestion/Impressions/Edregulprdc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edregulprdc.class` — classe, formulaire associé `Edregulprdc.form`
- Handlers GUI détectés : 4
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `date2_GotFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `date2_GotFocus`, `Level1`, `Level2`

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

`Fiches_Art`, `Fiches_Mvtexpdc`

### Membres Public sans usage externe détecté (portée réductible ?)

`date1_LostFocus`, `date2_GotFocus`, `date2_LostFocus`, `Level1`, `Level2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:2140` (`Menu264_Click`).
- `Level1`, `Level2` : `unused` confirmés (grep). `date2_GotFocus` : handler inactif (groupe `Cmpt`).
  `date1_LostFocus`, `date2_LostFocus` : appelés seulement par `Cmpt_KeyPress`.
- `Fiches_Mvtexpdc` est écrite par `MvtProdcomp.class:457-523` (`mind`, `type` P/C, dates
  `Cdate_Dbase`) ; la purge de cet écran efface aussi des lignes d'autres fabrications.
- Utilise `Carticles` (`Entete`, `Level11`, `Level12`, `Ligne`, `Footer`) et `Visualiseur.Prog`.
- Même fichier de sortie `~/tmp/Regul.pdf` qu'`Edregul` (écrasement mutuel, sans conséquence
  fonctionnelle).
- Contrainte d'ordre : rework conjoint avec `Edregul`.
