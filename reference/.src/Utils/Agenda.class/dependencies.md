# Agenda — Dépendances

> Source : `.src/Utils/Agenda.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Agenda.class` — classe, formulaire associé `Agenda.form`
- Handlers GUI détectés : 11
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coldetail_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Agenda`

### Membres Public sans usage externe détecté (portée réductible ?)

`Init`, `Ecr_action`, `Maj_Zones`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant non détecté** : `Fmenu.class:1847` (`Agenda.show`, auto-instance de la fenêtre, menu
  « Agenda »). `deps.py` indique 0 appelant car `show` est un membre hérité de `Form`.
- Table : `Fiches_Agenda` (`Cbase.Table("TabAgenda")`), lecture et écriture.
- Programme externe : `xdg-open` (4 URL en dur).
- Contrôles du formulaire utilisés : `Coldetail` (GridView), `DateChooser1`, `TextArea1`,
  `Button1`…`Button6`, `Timer2`, `V1`, `Label3`, `Label4` ; `LCD2` (DrawingArea) n'est plus utilisé
  (référence commentée dans `Button2_Click`).
- Aucune dépendance vers d'autres classes du projet hors `Utils`/`Cbase`. Aucun appel dynamique.
