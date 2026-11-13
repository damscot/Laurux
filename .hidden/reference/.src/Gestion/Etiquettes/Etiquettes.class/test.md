# Etiquettes — Tests

> Source : `.src/Gestion/Etiquettes/Etiquettes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` avec diff de `Fiches_Etiquettes`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQUETTES-T01 | replay | Création d'un format | menu Types étiquettes ; `Code_etiq` = `Z- Test` ; page `A4 Portrait` ; 3, 8, 700, 370, 0, 0, 0, 0 ; Enregistrer | INSERT d'une ligne `(Z, A4 Portrait)` | `tests/etiquettes_creation/` | implémenté |
| ETIQUETTES-T02 | replay | Modification | choix de `Z- Test`, page A4 Portrait ; largeur 650 ; Enregistrer | UPDATE de la seule ligne `(Z, A4 Portrait)` | `tests/etiquettes_modification/` | implémenté |
| ETIQUETTES-T03 | replay | Même code, deuxième page | `Z- Test` + `A4 Paysage` ; Enregistrer ; puis choix de `Z- Test` | deux lignes ; liste sans doublon ; page affichée figée (A02) | `tests/etiquettes_deux_pages/` | implémenté |
| ETIQUETTES-T04 | replay | Zone vide | Hauteur vide ; Enregistrer | message « Vous devez remplir… », base inchangée | `tests/etiquettes_zone_vide/` | implémenté |
| ETIQUETTES-T05 | replay | Saisie filtrée et enchaînement | frappe `12a3` puis Entrée dans chaque zone | `123` conservé, focus suivant (log) | `tests/etiquettes_saisie/` | implémenté |
| ETIQUETTES-T06 | replay | Code vide / libellé mal formé | `Code_etiq` vide puis `Y Test` ; Enregistrer | caractérisation : ligne de code `""` / libellé `est` (A01) | `tests/etiquettes_code_invalide/` | xfail : code vide → INSERT code NULL refusé, erreur fatale (code 125) au lieu d'une ligne de code '' |

## Détail des tests

- **Données** : `Laurux01.sql` (formats livrés) ; pour T02-T03, jeu dérivé contenant `Z- Test`.
- **Comparaison** : dump normalisé de `Fiches_Etiquettes` ; T05 sur le log de rejeu.
- **Instrumentation** : `Utils.Observers(Me)` appelé une fois dans `_New` (écran rejouable) ;
  l'écran est ouvert non modal sur l'auto-instance.
- **Assets** : `.hidden/Tests/Gestion/assets/etiquettes_{creation,modification,deux_pages,zone_vide,saisie,code_invalide}/` ;
  jeu `etiquettes_shared/etiquettes_ztest.sql` (ligne `Z`, `Test`, A4 Portrait, 3, 8, 700, 370, 0…) pour T02-T03.
- T05 : « 1a2 » dans les zones `decimal(2,0)` (Nblargeur, Nbhauteur), « 12a3 » ailleurs ; Entrée sans Focus explicite :
  les valeurs filtrées arrivent dans la bonne zone (enchaînement vérifié par le dump après Enregistrer).
- T06 : « Y Test » enregistré d'abord (libellé `est`), puis code vide : `Left$("", 1)` vaut Null, INSERT refusé
  (`Column 'code' cannot be null`, Etiquettes.Button3_Click.143), `code_sortie` 125 + xfail. Cadence `traitement` 400.
- **Non testable** : bouton Aide (`xdg-open`), coloration du focus (visuelle).
- Les valeurs saisies ici conditionnent les PDF des écrans d'impression : le jeu `Z- Test` sert
  aussi de fixture aux replays ETIQART, ETIGOND, ETIQCASIER, ETICLI, ETIQRECPT, ETIQPROMO,
  ETIQFBTARIF.
