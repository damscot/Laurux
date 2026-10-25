# ImageButton — Dépendances

> Source : `.src/Caisse/ImageButton.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/ImageButton.class` — classe, hérite de `UserControl`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Attrib.class` | `<form>`, `<type>`, `BackGround`, `Picture`, `Text` |
| `.src/Caisse/Caisse.class` | `<form>`, `<type>`, `BackGround`, `Picture`, `Text` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `MyStyle` | `Disabled`, `DrawButton`, `HasFocus`, `Hovered` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Utilisateurs confirmés : `Caisse.form` (35 `ImageButton`, groupe `Clav2`), `Attrib.form`
  (35), créations dynamiques `New (ImageButton, hpan) As "Clav3"` (`Caisse.class:8673`,
  `Attrib.class:278`), variables typées `btn`/`hbutton`/`hCont` dans `Caisse` et `Attrib`
  (`Fond_ImageButton`, `Attrib.class:345`). Le contrat utilisé est : `Text`, `BackGround`,
  `Picture`, `Tag`, `Name`, géométrie, `Refresh`, événement `Click`.
- Les handlers `Clav2_Click`/`Clav3_Click` des appelants dépendent de l'événement `Click` levé
  par `View_MouseUp` : à repasser après tout rework de `ImageButton`.
- `Position` : propriété jamais utilisée, non signalée par `deps.py`.
- Contrôle exporté (`Export`) : il apparaît dans la boîte à outils de l'EDI ; ne pas le
  renommer (les `.form` le référencent par son nom de classe).
- `ReplayObserver` / `Utils.Recursive_Observers` ne gèrent pas ce `UserControl` : pas de
  journalisation des touches (contrainte de test, voir test.md).
- Dépendance vers `MyStyle` (seul utilisateur) : rework de `MyStyle` et d'`ImageButton` dans le
  même lot.
