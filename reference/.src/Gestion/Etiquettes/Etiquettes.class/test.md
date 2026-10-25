# Etiquettes — Tests

> Source : `.src/Gestion/Etiquettes/Etiquettes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` avec diff de `Fiches_Etiquettes`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQUETTES-T01 | replay | Création d'un format | menu Types étiquettes ; `Code_etiq` = `Z- Test` ; page `A4 Portrait` ; 3, 8, 700, 370, 0, 0, 0, 0 ; Enregistrer | INSERT d'une ligne `(Z, A4 Portrait)` | `tests/etiquettes_creation/` | à faire |
| ETIQUETTES-T02 | replay | Modification | choix de `Z- Test`, page A4 Portrait ; largeur 650 ; Enregistrer | UPDATE de la seule ligne `(Z, A4 Portrait)` | `tests/etiquettes_modification/` | à faire |
| ETIQUETTES-T03 | replay | Même code, deuxième page | `Z- Test` + `A4 Paysage` ; Enregistrer ; puis choix de `Z- Test` | deux lignes ; liste sans doublon ; page affichée figée (A02) | `tests/etiquettes_deux_pages/` | à faire |
| ETIQUETTES-T04 | replay | Zone vide | Hauteur vide ; Enregistrer | message « Vous devez remplir… », base inchangée | `tests/etiquettes_zone_vide/` | à faire |
| ETIQUETTES-T05 | replay | Saisie filtrée et enchaînement | frappe `12a3` puis Entrée dans chaque zone | `123` conservé, focus suivant (log) | `tests/etiquettes_saisie/` | à faire |
| ETIQUETTES-T06 | replay | Code vide / libellé mal formé | `Code_etiq` vide puis `Y Test` ; Enregistrer | caractérisation : ligne de code `""` / libellé `est` (A01) | `tests/etiquettes_code_invalide/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (formats livrés) ; pour T02-T03, jeu dérivé contenant `Z- Test`.
- **Comparaison** : dump normalisé de `Fiches_Etiquettes` ; T05 sur le log de rejeu.
- **Instrumentation** : `Utils.Observers(Me)` appelé une fois dans `_New` (écran rejouable) ;
  l'écran est ouvert non modal sur l'auto-instance.
- **Non testable** : bouton Aide (`xdg-open`), coloration du focus (visuelle).
- Les valeurs saisies ici conditionnent les PDF des écrans d'impression : le jeu `Z- Test` sert
  aussi de fixture aux replays ETIQART, ETIGOND, ETIQCASIER, ETICLI, ETIQRECPT, ETIQPROMO,
  ETIQFBTARIF.
