# Tleg — Dépendances

> Source : `.src/Gestion/Tables/Tleg.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Tleg.class` — classe, formulaire associé `Tleg.form`
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

`Fiches_Tleg`

### Membres Public sans usage externe détecté (portée réductible ?)

`CleanChamps`, `Refresh`, `Lib_KeyPress`, `Lib_GotFocus`, `Button2_Click`, `Button3_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1841` (`Tleg.Show()`).
- Lecteurs de `Fiches_Tleg` (première ligne, sans `WHERE`) : `ObjFac.class:215`,
  `Facturergbl.class:580` ; verrous `LOCK TABLES` dans `Moulinage.class:1064` (READ), `ValidBR.class:616`,
  `:618` et `Facturergbl.class:563` (WRITE). Un replay de facturation dépend donc de son contenu.
- `Button3_Click` : handler inactif (bouton groupé `Btn`). `Lib_KeyPress`/`Lib_GotFocus` : groupe
  `Lib` inexistant dans le `.form`. `CleanChamps` : jamais appelée.
- Ordre de rework : avec Tmail et LibelFac (fonctions communes « texte unique »).
