# SetColors — Tests

> Source : `.src/Utils/SetColors.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de configuration : le résultat comparé est le fichier `Laurux.conf` (section `[Coul]`) après
le scénario, plus les couleurs des zones d'aperçu (dump des propriétés `Background`, `Foreground`,
`Alignment`, `Font` des 21 `TextBox`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SETCOLORS-T01 | replay | Ouverture | `Laurux.conf` de référence ; menu → couleurs ; parcours des 6 onglets | dump des 21 zones | `tests/ouverture/` | à faire |
| SETCOLORS-T02 | replay | Double-clic zone simple | double-clic « Stk », fond choisi | `/Coul/Stk` et zone | `tests/dblclic_zone/` | à faire |
| SETCOLORS-T03 | replay | Double-clic fond documents | double-clic `Docscli` et `Others` | `/Coul/Coulfond`, `/Coul/Coulfonds`, `/Coul/Other`, `/Coul/Others` | `tests/dblclic_rvb/` | à faire |
| SETCOLORS-T04 | replay | Défauts zones | bouton « défaut » du panneau 8 (`Button2`) ; fermeture | 5 clés `/Coul/*` (enregistrement à la fermeture à confirmer) | `tests/defaut_zones/` | à faire |
| SETCOLORS-T05 | replay | Défauts documents | `Button3` | 4 clés, triplets RVB figés (A01) | `tests/defaut_documents/` | à faire |
| SETCOLORS-T06 | gbtest | `RVBTexte` (après SETCOLORS-004) | `&HFFEE81&`, `&H000000&`, `&HFFFFFF&`, `&H0000FF&` | `"255;238;129;"`… | `tests/rvb_texte/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié, avec un `Laurux.conf` de test
  passé par `-c` ; le diff porte sur la section `[Coul]`.
- **Non testable automatiquement** : le rendu visuel ; le choix de couleur dans `FSetFormat` est
  injecté par le harnais de replay.
