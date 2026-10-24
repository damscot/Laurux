# DB_Desktop — Tests

> Source : `.src/Utils/DB_Desktop.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe d'entrées simulées : son effet n'est observable que dans une session graphique. Les tests
`gbtest` vérifient la détection et le routage (avec un faux `ydotool` placé en tête du `PATH` qui
journalise ses arguments) ; le test `replay` vérifie l'effet réel sous X11. Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DB_DESKTOP-T01 | gbtest | Détection de session | `XDG_SESSION_TYPE` = `x11`, `wayland`, vide | valeur de `wayland` | `tests/detection_session/` | à faire |
| DB_DESKTOP-T02 | gbtest | Routage Wayland | `wayland` forcé ; faux `ydotool` ; `SendKey("[Return]")`, `"[Tab]"`, `"abc def"`, `"a;b"` | arguments reçus par le faux `ydotool` (figer l'absence de quotes) | `tests/routage_wayland/` | à faire |
| DB_DESKTOP-T03 | gbtest | Message d'installation | `wayland` + `PATH` sans `apt` / avec faux `apt` sans ydotool | `Message.Info` levé ou non (après DB_DESKTOP-003) | `tests/message_ydotool/` | à faire |
| DB_DESKTOP-T04 | replay | Validation par Entrée dans `TextReg` | écran utilisant un `TextReg` avec grille (ex. recherche client), sélection d'une ligne | la saisie est validée (X11) ; tables inchangées | `tests/textreg_entree/` | à faire |

## Détail des tests

- **Faux binaires** : `tests/<nom>/bin/ydotool` et `bin/apt` (scripts shell écrivant leurs arguments
  dans un fichier) ; le `PATH` du test est préfixé par ce répertoire.
- **Non testable** : l'effet réel de `ydotool` sous Wayland (nécessite `/dev/uinput` et le démon
  `ydotoold`) ; à valider manuellement.
- `Shell` étant asynchrone, T02 attend la création du fichier de trace (timeout 2 s).
