# Analytique — Tests

> Source : `.src/Compta/Analytique.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran modal ouvert depuis la saisie d'écritures (`Saisecrit`) : replays sur MariaDB Docker,
critère = dump normalisé de `Fiches_MvtA` (et `Fiches_Mvt` pour le contexte) ; gbtests sur les
fonctions pures créées par la séparation traitement/GUI.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ANALYTIQUE-T01 | replay | Ventilation par défaut | `/Soc01/Analytique` actif ; compte 6xxx ventilé 60/40 dans `Fiches_Analytiques` ; saisie d'une écriture puis Valider | grille préremplie ; `Fiches_MvtA` après validation (nombre de lignes figé, voir A02) | `tests/ventilation_defaut/` | à faire |
| ANALYTIQUE-T02 | replay | Rechargement d'une ventilation existante | écriture déjà ventilée, modification depuis `Saisecrit` | lignes `Fiches_MvtA` rechargées ; validation identique | `tests/ventilation_existante/` | à faire |
| ANALYTIQUE-T03 | replay | Édition des cellules | changement de poste, de %, de montant | libellés `Label3`…`Label6` et cellules (capture) | `tests/edition_cellules/` | à faire |
| ANALYTIQUE-T04 | replay | Ventilation non équilibrée | total ≠ 100 % après édition, Valider | message ; `Fiches_MvtA` de l'écriture **vidée** (suppression avant contrôle, figée) | `tests/non_equilibree/` | à faire |
| ANALYTIQUE-T05 | replay | Deux comptes ventilés dans une écriture | deux lignes de charges ventilées dans la même écriture | ventilation du 1er compte supprimée par la validation du 2nd (A02 figée) | `tests/deux_comptes/` | à faire |
| ANALYTIQUE-T06 | replay | Aide | clic sur le bouton d'aide ; puis F1 | clic sans effet (A01) ; F1 appelle `Doc.Open` (lancement `xdg-open` intercepté) | `tests/aide/` | à faire |
| ANALYTIQUE-T07 | replay | Plus de 20 postes | 21 postes dans `Fiches_Postes` | erreur d'indice à l'ouverture (A03 figée) | `tests/postes_21/` | à faire |
| ANALYTIQUE-T08 | gbtest | Calcul de répartition (après ANALYTIQUE-005) | montants `"100,00"`, `"33,33"`, `"-12,5"` ; % 0, 33,33, 100 | montants et % arrondis identiques à ceux affichés dans T03 | `tests/repartition/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**
  (depuis l'écran de saisie d'écritures), rejoués dans les deux clones ; T08 compare la sortie
  des fonctions pures aux valeurs affichées dans T03.
- **Données** : jeu dérivé de `Laurux01.sql` avec `Fiches_Postes`, `Fiches_Analytiques` remplis
  et l'option `/Soc01/Analytique` active dans le `Laurux.conf` de test.
- **Locale** : la validation compare `Label4.Text` à `"0,00 %"` ; les replays tournent en
  `fr_FR.UTF-8`.
- **Non testable automatiquement** : documentation HTML (vérification limitée à l'appel).
