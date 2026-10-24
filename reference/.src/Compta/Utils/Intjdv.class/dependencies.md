# Intjdv — Dépendances

> Source : `.src/Compta/Utils/Intjdv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Intjdv.class` — classe, formulaire associé `Intjdv.form`
- Handlers GUI détectés : 8
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `jour_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Journaux`, `Fiches_Rubriques`

### Membres Public sans usage externe détecté (portée réductible ?)

`journauxman`, `journaux`, `journal_LostFocus`, `date1_LostFocus`, `date2_LostFocus`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : confirmé par `grep -rniw Intjdv .src` (seul le fichier lui-même) et par
  l'absence d'entrée de menu dans `Fmenu.form` ; aucune instanciation dynamique.
- `Fiches_Rubriques` est listée par `deps.py` mais n'est jamais interrogée (variable `Tab`
  affectée puis inutilisée) : faux positif. La table de travail `centralisation` (DDL) n'est pas
  détectée ; elle porte le même nom que celle de `Jourcent` (structure différente).
- Les handlers `journal_LostFocus`, `date1_LostFocus`, `date2_LostFocus` sont des handlers
  nominaux de contrôles du groupe `Cmpt` : ils ne sont déclenchés que par appel explicite depuis
  `Cmpt_KeyPress` / `jour_Click` (non signalés comme inactifs par `deps.py` car appelés).
- Pas de dépendance circulaire ; aucune contrainte d'ordre.
