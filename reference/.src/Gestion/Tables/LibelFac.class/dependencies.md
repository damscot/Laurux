# LibelFac — Dépendances

> Source : `.src/Gestion/Tables/LibelFac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/LibelFac.class` — classe, formulaire associé `LibelFac.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `Musique` |
| `Utils` | `Observers`, `ReplaceLb`, `db` |

### Tables SQL référencées

`Fiches_LibelFac`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1320` (`LibelFac.Show`).
- Lecteur de `Fiches_LibelFac` : `ObjFac.class:221` (première ligne) ; verrous dans
  `Facturergbl.class:555-563` (WRITE) et `Moulinage.class:1064` (READ).
- `Button2_Click` est un pseudo-handler (bouton groupé `Btn`) appelé par `Btn_Click`.
- Aucun appel dynamique. Ordre de rework : avec Tleg et Tmail.
