# Tmail — Dépendances

> Source : `.src/Gestion/Tables/Tmail.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Tmail.class` — classe, formulaire associé `Tmail.form`
- Handlers GUI détectés : 3
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `CleanChamps`, `Lib_KeyPress`, `Lib_GotFocus`, `Button3_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Utils` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_TxtMail`

### Membres Public sans usage externe détecté (portée réductible ?)

`CleanChamps`, `Refresh`, `Lib_KeyPress`, `Lib_GotFocus`, `Button2_Click`, `Button3_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:2092` (`Tmail.Show()`).
- Lecteur de `Fiches_TxtMail` : `ObjFacB.class:663` et `:877` (première ligne, utilisée si
  `Variables.sTexte` est vide, c'est-à-dire si aucun texte n'a été choisi dans ComMail).
- `Button3_Click` : handler inactif (bouton groupé `Btn`). `Lib_KeyPress`/`Lib_GotFocus` : groupe
  `Lib` inexistant. `CleanChamps` : jamais appelée.
- Ordre de rework : avec Tleg et LibelFac.
