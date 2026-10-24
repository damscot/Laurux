# chainage — Tests

> Source : `.src/Utils/chainage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHAINAGE-T01 | gbtest | Gestion de liste | `New Chainage([a, b, c])` (contrôles d'une fenêtre cachée) ; `add([d])` ; `sup(b)` ; `sup(a, 2)` ; `addintercale(c, e)` | contenu de `tableaux` après chaque appel | `tests/gestion_liste/` | à faire |
| CHAINAGE-T02 | gbtest | `_new(Null)` et liste partagée | `New Chainage(Null)` ; modification du tableau passé à `_new` | `tableaux` vide ; même référence que le tableau passé | `tests/construction/` | à faire |
| CHAINAGE-T03 | gbtest | `modif` (anomalie) | `modif(a, x)` | figer l'erreur de type | `tests/modif/` | à faire |
| CHAINAGE-T04 | replay | Navigation avant | écran `Parametre` : Entrée, Tab, Bas successifs jusqu'au bouclage | séquence des contrôles ayant le focus (log GUI) | `tests/navigation_avant/` | à faire |
| CHAINAGE-T05 | replay | Navigation arrière et Alt/Ctrl | `Parametre` : Haut, Maj+Tab depuis le 1er champ ; Ctrl+Bas | focus sur le dernier champ ; aucune navigation avec Ctrl | `tests/navigation_arriere/` | à faire |
| CHAINAGE-T06 | replay | Couleur de focus | `Parametre` : entrée/sortie d'un champ | couleurs `/Coul/Focus` puis couleur d'origine | `tests/couleur_focus/` | à faire |
| CHAINAGE-T07 | replay | Liste modifiée par `sup`/`add` | saisie d'une ligne d'achat (`Achat`) avec suppression de colonnes | ordre de focus de référence | `tests/achat_sup_add/` | à faire |

## Détail des tests

- gbtest : les contrôles sont créés dans une fenêtre non affichée (composant GUI chargé par le module
  de test) ; seules les méthodes publiques et `tableaux` sont vérifiées.
- Replays : capturés dans le clone **Laurux non modifié** avec `ReplayObserver` (log des focus et des
  touches), rejoués sur les deux clones ; comparaison des lignes de log de focus. Aucune table
  modifiée par ces scénarios (sauf T07 si la ligne est validée : diff des tables d'achat).
- Non testable en gb.test : les événements clavier (`Key.Code`) et `Stop Event`.
