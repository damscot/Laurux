# Rubcompt — Tests

> Source : `.src/Compta/Utils/Rubcompt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : les scénarios partent de `Fmenu` (Comptabilité > Compte de résultat > Gestion des
comptes). Le critère est le dump normalisé de `Fiches_RubCompt` (et de `Fiches_Rubriques`, qui doit
rester inchangée) ; le contenu affiché (grille, champs, case à cocher) est relevé dans le log de
replay quand l'observateur l'enregistre (à confirmer en phase 2), sinon par capture manuelle.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RUBCOMPT-T01 | replay | Ouverture et liste | `Laurux01.sql` (364 plages) | grille : rubrique, intitulé, début, fin, drapeau ; dump inchangé | `tests/ouverture_liste/` | à faire |
| RUBCOMPT-T02 | replay | Ajout d'une plage | rubrique `B0050`, `Cpt1 = 205` (fin proposée `20599999`), Enregistrer | nouvelle ligne `('B0050','205','20599999',0)` dans le dump ; ligne sélectionnée | `tests/ajout_plage/` | à faire |
| RUBCOMPT-T03 | replay | Modification avec amortissement | clic sur une plage existante, case cochée, `Cpt2` modifié, Enregistrer | `compte2` et `amortissement = 1` dans le dump | `tests/modif_plage/` | à faire |
| RUBCOMPT-T04 | replay | Suppression | sélection d'une plage ; Supprimer → Non, puis Oui ; variante : `Cpt1` modifié avant Supprimer (A02 figée) | dump inchangé (Non), plage supprimée (Oui) ; variante : ligne effacée selon `Current[0]` + `Cpt1` | `tests/suppression/` | à faire |
| RUBCOMPT-T05 | replay | Rubrique inconnue / liste des rubriques | `Numrub = X9999` + Entrée ; puis F2, flèches, Entrée | `Message.Warning`, focus sur `Numrub` ; liste des rubriques `L`, champs remplis, focus `Cpt1` | `tests/rubrique_inconnue/` | à faire |
| RUBCOMPT-T06 | replay | État de la case amortissement au clic (A01 figée) | clic sur une plage `amortissement = 0` après chargement (dernière ligne = 1, ou l'inverse) | valeur de la case figée (curseur `Item` et non `Current`) | `tests/clic_amortissement/` | à faire |
| RUBCOMPT-T07 | replay | Enregistrer sans compte, touches sur Enregistrer | `Numrub` seul + Enregistrer (INSERT en erreur ou non selon le moteur) ; Tab sur `Button2` (A05 figée) | `Message.Info` ou ligne vide, figé ; enregistrement déclenché par Tab | `tests/saisie_incomplete/` | à faire |
| RUBCOMPT-T08 | gbtest | Fin de plage proposée (après RUBCOMPT-004) | `FinPlage("6")`, `("601")`, `("60100000")`, `("")` | `"69999999"`, `"60199999"`, `"60100000"`, `"99999999"` ; cas > 8 caractères documenté | `tests/fin_plage/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, base restaurée depuis
  `Laurux01.sql` avant chaque scénario ; dump limité à `Fiches_RubCompt` et `Fiches_Rubriques`.
- **MySQL et SQLite** : T01, T03 et T06 sont à jouer sur les deux moteurs (représentation du
  drapeau `amortissement`, anomalie RUBCOMPT-A03).
- **gen_input.py** : sans objet (saisie interactive) ; **check_output.py** compare les dumps.
- **Non testable automatiquement** : le son (`Music.Play`), l'ouverture de l'aide `Doc.Open`
  (vérifier seulement l'appel dans le log), le cas `Cpt1` de plus de 8 caractères si l'erreur
  d'exécution interrompt le replay (à documenter comme test manuel).
