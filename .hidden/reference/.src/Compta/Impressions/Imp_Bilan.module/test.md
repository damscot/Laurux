# Imp_Bilan — Tests

> Source : `.src/Compta/Impressions/Imp_Bilan.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Lancement` n'est appelé que depuis l'écran `RubImp` (bouton radio « Bilan », bouton Imprimer) :
les tests de non-régression sont des replays de cet écran. Trois sorties sont comparées :

1. **le PDF** `~/tmp/Bilan.pdf`, produit dans le clone Laurux non modifié (référence) puis dans le
   clone reworké, converti par `pdftotext -layout`, avec normalisation du pied de page
   (`Page n/N - jj/mm/aaaa - Impression demandée par <utilisateur>` → date et utilisateur
   remplacés par des jetons) ;
2. les fichiers `~/tmp/BilanDetail.csv` et `~/tmp/BilanRub.csv` (diff texte exact) ;
3. le **dump normalisé** de la base, tables de travail `centralisation` et `Comptes` comprises
   (elles restent dans la base après l'édition et portent les valeurs N-1 non imprimées).

`Laurux01.sql` contient le paramétrage (111 rubriques `B`, plages) mais aucune écriture : les tests
utilisent un **jeu dérivé** (comptes de bilan de toutes les rubriques concernées par les règles
d'exclusion, écritures validées et non validées dans `Fiches_Mvt` pour 2018 et `Fiches_Mvt1` pour
2017, dont des comptes d'amortissement `28…` et un compte `129`). `Visualiseur.Prog` doit être
neutralisé (visualiseur de test qui ne fait rien, réglage de `Laurux.conf` à confirmer en phase 2).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMP_BILAN-T01 | replay | Bilan exercice courant | jeu dérivé, `RubImp` : Bilan, `E1`, dates proposées | PDF (texte normalisé), 2 CSV, dump `centralisation`/`Comptes` identiques à la référence | `tests/bilan_e1/` | à faire |
| IMP_BILAN-T02 | replay | Bilan d'un exercice antérieur | `N1` (tables `Fiches_Mvt1`/`Fiches_Mvt2`) | idem T01 | `tests/bilan_n1/` | à faire |
| IMP_BILAN-T03 | replay | Bilan `N5` (pas de N-1) | `N5`, écritures dans `Fiches_Mvt5` | idem T01 ; `Comptes.solde2` à 0 | `tests/bilan_n5/` | à faire |
| IMP_BILAN-T04 | replay | Règles d'exclusion actif/passif | jeu dérivé avec, pour chaque préfixe du tableau des règles, un compte à solde positif, nul et négatif, en N et en N-1 | répartition des comptes figée (PDF, `BilanRub.csv`, `centralisation` col1…col4) | `tests/regles_exclusion/` | à faire |
| IMP_BILAN-T05 | replay | Amortissements et compte 129 | plages `amortissement = 1` (`28…`), compte `129` en perte | colonne Amortissements et signe du résultat figés | `tests/amortissements/` | à faire |
| IMP_BILAN-T06 | replay | Deux éditions successives | T01 puis T02 sans quitter l'application | second PDF identique à celui de T02 joué seul (état de module, à confirmer) | `tests/editions_successives/` | à faire |
| IMP_BILAN-T07 | replay | Rien à imprimer | jeu sans rubrique `B` (`Fiches_Rubriques` filtrée) | `Message.Info`, pas de PDF ; tables de travail vides | `tests/rien_a_imprimer/` | à faire |
| IMP_BILAN-T08 | gbtest | Règles d'exclusion (après IMP_BILAN-005) | `Exclu(rub, cpt, solde, règles N/N-1)` sur la matrice de T04 | booléens identiques au comportement figé par T04 | `tests/exclu/` | à faire |
| IMP_BILAN-T09 | gbtest | Choix des tables par exercice (après IMP_BILAN-003) | `E1`, `N1`…`N5`, code inconnu | couples de tables de la référence ; `""` pour un code inconnu | `tests/tables_exercice/` | à faire |
| IMP_BILAN-T10 | replay | Performance | jeu dérivé de 2 000 comptes, 50 000 écritures | durée de référence (`gbx3 -p`) | `tests/perf/` | à faire |

## Détail des tests

- **Valeurs attendues** : toujours produites dans le clone Laurux non modifié avec le même jeu
  dérivé, la même locale (`LANG=fr_FR.UTF-8`) et la même horloge (dates proposées par `RubImp`).
- **gen_input.py** : génère le jeu dérivé (comptes par préfixe des règles, écritures N et N-1).
- **check_output.py** : `pdftotext -layout` puis normalisation du pied de page (regex sur
  `\d{2}/\d{2}/\d{4}` et `Impression demandée par .*`), diff texte ; diff exact des CSV ; dump trié
  des tables de travail (les valeurs `Char(12)` sont comparées en texte).
- **SQL** : pour les reworks déclarés « sans changement SQL » (IMP_BILAN-005 à 007), le diff des
  lignes `Exec_SQL` entre les deux clones est bloquant.
- **Non testable automatiquement** : rendu graphique du PDF (mise en page, filets) au-delà du texte ;
  à contrôler visuellement une fois après les reworks de l'impression.
