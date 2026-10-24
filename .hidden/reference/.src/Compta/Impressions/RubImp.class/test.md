# RubImp — Tests

> Source : `.src/Compta/Impressions/RubImp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'impression : scénarios lancés depuis `Fmenu` (Comptabilité > Compte de résultat >
Impression). Pour le compte de résultat, trois sorties sont comparées : texte du PDF
`~/tmp/Resultat.pdf` (`pdftotext -layout`, pied de page normalisé : date et utilisateur) produit
d'abord dans le clone Laurux non modifié, `~/tmp/Resultat.csv` (diff exact) et dump de la table de
travail `centralisation`. Les éditions bilan et SIG sont couvertes par IMP_BILAN-T* et IMP_SIG-T*
(mêmes scénarios, autre bouton radio). Jeu dérivé de `Laurux01.sql` (97 rubriques `R`) avec des
écritures de classes 6 et 7 dans `Fiches_Mvt` (2018) et `Fiches_Mvt1` (2017), validées et non
validées. L'horloge est fixée pour les dates proposées ; `Visualiseur.Prog` est neutralisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RUBIMP-T01 | replay | Compte de résultat non détaillé, bénéfice | jeu « bénéfice », `E1`, Imprimer | PDF (texte normalisé), CSV, dump `centralisation` identiques à la référence | `tests/resultat_benefice/` | à faire |
| RUBIMP-T02 | replay | Compte de résultat détaillé, perte | jeu « perte », `Impd` coché, `E1` | idem ; ordre des lignes de détail figé (A04) | `tests/resultat_perte_detail/` | à faire |
| RUBIMP-T03 | replay | Exercices antérieurs | `N1`, `N4`, `N5` (sans N-1) | idem pour chaque exercice | `tests/resultat_exercices/` | à faire |
| RUBIMP-T04 | replay | Aiguillage | Bilan puis SIG avec `Impd` coché avant de changer de bouton | appel de `Imp_Bilan`/`Imp_Sig` (log) ; `Resultat.csv` vide ; `centralisation` au format bilan/SIG | `tests/aiguillage/` | à faire |
| RUBIMP-T05 | replay | Dates proposées par exercice | `E1`, `N1`…`N5` sur `Fiches_Parametres` de `Laurux01.sql` ; puis jeu de dates de clôture non calendaires (30/06) | `DteN0`/`DteN1` et en-tête `Periode` (dates N-1 + 1 jour, A03) figés | `tests/dates_exercice/` | à faire |
| RUBIMP-T06 | replay | Contrôle des dates saisies | début avant l'exercice, fin après la clôture précédente, fin < début | avertissements et remises à l'exercice en cours figés (A02) | `tests/controle_dates/` | à faire |
| RUBIMP-T07 | replay | Quitter | Imprimer puis Quitter | `~/tmp/Resultat.pdf` toujours présent (A01 figée) | `tests/quitter/` | à faire |
| RUBIMP-T08 | replay | Base SQLite | T01 sur `Laurux01.sqlite` + jeu dérivé | PDF et dump comparés à la référence SQLite (ordre physique, A06) | `tests/resultat_sqlite/` | à faire |
| RUBIMP-T09 | gbtest | Bornes d'exercice (après RUBIMP-003) | `BornesExercice(k)` pour `k` = 0…5 sur `Laurux01.sql` | chaînes identiques aux dates de T05 | `tests/bornes_exercice/` | à faire |
| RUBIMP-T10 | replay | Performance | jeu de 2 000 comptes et 50 000 écritures, détaillé | durée de référence (`gbx3 -p`) | `tests/perf/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié, même jeu, même locale
  (`LANG=fr_FR.UTF-8`), même horloge.
- **gen_input.py** : jeux « bénéfice » et « perte » (produits > charges et inverse, en N et N-1),
  rubriques `L` avec plusieurs comptes pour le détail.
- **check_output.py** : `pdftotext -layout`, normalisation du pied de page, diff texte ; diff exact
  du CSV ; dump trié de `centralisation`.
- **SQL** : diff `Exec_SQL` bloquant pour RUBIMP-005/006 (déclarés sans changement SQL).
- **Non testable automatiquement** : rendu graphique du PDF ; `Message.info` « traitement long »
  rejoué mais non vérifié.
