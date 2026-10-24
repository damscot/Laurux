# FComptes — Tests

> Source : `.src/Compta/Tables/FComptes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI complexe : `replay` avec diff de `Fiches_Comptes`, `Fiches_SousComptes`,
`Fiches_Analytiques` ; `gbtest` sur les fonctions extraites (`TypeParNumero`,
`RepartitionEquilibree`). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCOMPTES-T01 | replay | Création de comptes avec forçage du type | menu Plan comptable ; `606100` type `B` ; `512100` type `G` ; `801000` vide ; `901000` `G` | types forcés `G`, `B`, `B`, `A` ; messages ; lignes créées | `tests/creation_type_force/` | à faire |
| FCOMPTES-T02 | replay | Refus d'enregistrement | type `F` ; type `C` sans collectif ; case collectif cochée ; `411200` type `G` ; code vide | messages, aucune écriture | `tests/refus/` | à faire |
| FCOMPTES-T03 | replay | Modification avec TVA | compte 707 : F2 TVA ventes, choix du code 3 ; F2 TVA achats ; Enregistrer | `code_tvente`, `taux_tvente`, `gen_tv`… ; formes des booléens en base | `tests/modification_tva/` | à faire |
| FCOMPTES-T04 | replay | Type `A` et drapeau `Enr` | type `A` saisi après un code TVA invalide, puis après un code valide | pas d'enregistrement puis enregistrement (A04 figée) | `tests/drapeau_enr/` | à faire |
| FCOMPTES-T05 | replay | Suppression | compte libre ; compte mouvementé (Mvt3) ; compte de famille ; code saisi ≠ ligne sélectionnée | suppression (+ `Fiches_SousComptes`) ; refus ; refus ; suppression de la ligne sélectionnée (A03) | `tests/suppression/` | à faire |
| FCOMPTES-T06 | replay | Sous-comptes | compte principal coché ; ajout de 2 sous-comptes (F2 `TriCpt`) ; touche quelconque puis Suppr dans la liste | lignes `Fiches_SousComptes` ; question à chaque touche (A01) | `tests/sous_comptes/` | à faire |
| FCOMPTES-T07 | replay | Analytique | option `/Soc01/Analytique` active ; compte 6xx : postes 60 % + 40 % ; puis 60 % seul ; suppression de tous les postes ; fermeture | `Fiches_Analytiques` ; fermeture refusée puis bloquée (A02 figée) | `tests/analytique/` | à faire |
| FCOMPTES-T08 | replay | Recherche et tri | clic et saisie dans `CO`, `INTIT`, double-clic | contenu de la grille (relevé) | `tests/recherche/` | à faire |
| FCOMPTES-T09 | replay | Ouverture depuis la saisie | `Saisecrit`, compte inexistant en Gestion → création | compte créé ; retour à la saisie | `tests/depuis_saisie/` | à faire |
| FCOMPTES-T10 | gbtest | `TypeParNumero` (après FCOMPTES-007) | codes `100`…`999` par tranches × types `""`, `B`, `G`, `A` | type résultant et indicateur d'avertissement | `tests/type_par_numero/` | à faire |
| FCOMPTES-T11 | gbtest | `RepartitionEquilibree` (après FCOMPTES-008) | totaux 0, 60, 100, 99.99, 100.00000001 ; 0 ou n postes ; état précédent | valeur de `Qpostes` identique à `Quitter_Postes` | `tests/repartition/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` ; jeux dérivés : écriture sur un compte dans `Fiches_Mvt3`, famille
  utilisant un compte, postes analytiques, option `Analytique` dans `Laurux.conf` du test.
- **Comparaison** : dump normalisé de `Fiches_Comptes`, `Fiches_SousComptes`, `Fiches_Analytiques` ;
  grille relevée par le replay pour T08.
- **Non testable automatiquement** : couleurs de focus (`ObsGotf`), son.
- **Couverture visée** : toutes les branches de `Button2_Click` et `Button1_Click`.
