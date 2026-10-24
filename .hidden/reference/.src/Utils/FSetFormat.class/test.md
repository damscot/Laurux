# FSetFormat — Tests

> Source : `.src/Utils/FSetFormat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Boîte de dialogue : tests `replay`. Le résultat comparé est l'objet `CFormat` relu par l'appelant
(sérialisé par `ToString` dans `Laurux.conf` ou dans `Fiches_Touches.coul`) et le contenu de
`Fiches_Touches` pour le logo.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSETFORMAT-T01 | replay | Couleur de fond depuis `SetColors` | Menu couleurs ; double-clic sur « Factures » ; choix d'une couleur ; Fermer | entrée `/Coul/Facts` de `Laurux.conf` | `tests/fond_setcolors/` | à faire |
| FSETFORMAT-T02 | replay | Réinitialiser | même scénario ; bouton « Réinitialiser » | `/Coul/Facts` = fond `&HDFE7FF&` | `tests/reinit/` | à faire |
| FSETFORMAT-T03 | replay | Touche de caisse | Caisse, écran `Attrib` ; double-clic sur une touche ; couleur | `Fiches_Touches.coul` (diff de table) | `tests/fond_touche/` | à faire |
| FSETFORMAT-T04 | replay | Logo de touche | `Attrib`, touche « A01 » sur 2 caisses ; « Choisir » une image | diff `Fiches_Touches.fond` (toutes caisses, anomalie A01 figée) | `tests/logo_touche/` | à faire |
| FSETFORMAT-T05 | replay | Logo depuis `SetColors` | `SetColors` ; « Choisir » une image | diff `Fiches_Touches` (figer A02) | `tests/logo_setcolors/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées en rejouant les scénarios dans le clone Laurux non modifié ;
  base `Laurux01.sql` + jeu dérivé avec des touches identiques sur deux caisses (`cai`).
- **Non testable automatiquement** : le choix dans `Dialog.SelectFont`/`OpenFile` dépend du
  dialogue natif ; le harnais de replay injecte le résultat (chemin, couleur) — à confirmer avec
  l'outillage `replay/`.
