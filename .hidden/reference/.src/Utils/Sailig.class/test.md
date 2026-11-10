# Sailig — Tests

> Source : `.src/Utils/Sailig.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe graphique sans SQL : tests **gbtest sous affichage virtuel** (Xvfb, à confirmer en phase 2),
avec instanciation dans un `Panel` d'une `Window` non affichée ; la simulation de touches passe par
l'appel direct de `groupe_keypress` impossible (dépend de `Key`) : ces cas sont couverts par les
replays de `SaiTableau` (SAITABLEAU-T07/T08).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAILIG-T01 | gbtest | Construction par type | un `ObjProp` de chaque type (sauf TextBox), états `lecture`/`ecriture`/`reception` | contrôles créés, noms, `Enabled`, `Dernier` = dernier contrôle | `tests/construction/` | implémenté |
| SAILIG-T02 | gbtest | Cas `ObjProp.TextBox` | un `ObjProp.TextBox` | figer le comportement actuel (erreur ou non, cf. A01) | `tests/textbox/` | implémenté |
| SAILIG-T03 | gbtest | Propriétés | `Background`, `X`, `Y`, `Dernier`, `Tag` | valeurs relues ; couleur appliquée à tous les contrôles | `tests/proprietes/` | implémenté |
| SAILIG-T04 | gbtest | `Delete` | ligne avec `AutresObj` (2 objets) | collection vide, `prx`/`txl` à `Null` | `tests/delete/` | implémenté |
| SAILIG-T05 | replay | Clavier dans une grille | écran Achat : Entrée sur le dernier champ, Inser, Suppr, Alt+↑/↓, ↓ sur dernier champ | log/dump identiques (voir SAITABLEAU-T07) | `tests/replay_clavier/` | à faire : scénario Achat (SAITABLEAU-T07) non synthétisé dans ce lot |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (sorties `id;valeur`).
- **Données** : aucune base pour T01-T04 ; T05 utilise `Laurux01.sql` + jeu dérivé de
  SAITABLEAU-T07.
- **Non testable automatiquement** : `groupe_keypress` hors replay (lecture de `Key`), focus réel.
- **Phase 2 (implémentation)** : `.src/Tests/Utils/SailigTest.test` (T01-T04), ligne créée dans un `Panel`
  d'une `Window` jamais affichée. T02 : erreur de type figée (A01).
