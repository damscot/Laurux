# EdNjustifiees — Tests

> Source : `.src/Compta/Impressions/EdNjustifiees.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans écriture en base. Résultat : `~/tmp/Enlettrees.pdf` comparé après
`pdftotext -layout` et normalisation (date du jour dans l'en-tête « du dd.mm.yyyy », date et
utilisateur du pied de page) ; lignes `Exec_SQL` du log en complément.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDNJUSTIFIEES-T01 | replay | Clients, écarts | jeu avec 3 clients : justifié, solde mémorisé faux, sans écriture non lettrée mais solde ≠ 0 | seuls les comptes en écart, avec leurs lignes et solde progressif | `tests/clients/` | à faire |
| EDNJUSTIFIEES-T02 | replay | Fournisseurs | `Bfournisseur` | idem côté 401 | `tests/fournisseurs/` | à faire |
| EDNJUSTIFIEES-T03 | replay | Type de clients | sélection dans `TypeClient1` | filtre `cli_typec IN (…)` (rejouabilité de `TypeClient` à valider) | `tests/type_client/` | à faire |
| EDNJUSTIFIEES-T04 | replay | Tous justifiés / aucun compte | plage sans écart ; plage vide | PDF sans ligne ; message « Aucune ecriture » | `tests/vide/` | à faire |
| EDNJUSTIFIEES-T05 | replay | F2 sur `Cpt` | F2 dans `Cpt` puis `Cpt2` | aucune sélection ouverte (A01 figée) ; boutons `ToggleButton1/2` fonctionnels | `tests/f2/` | à faire |
| EDNJUSTIFIEES-T06 | replay | Arrondi de la comparaison | solde mémorisé 100,005 vs écritures 100,00 | décision figée de la comparaison formatée | `tests/arrondi/` | à faire |
| EDNJUSTIFIEES-T07 | replay | Multipage | > 60 lignes sur un compte en écart | en-têtes répétés | `tests/multipage/` | à faire |
| EDNJUSTIFIEES-T08 | gbtest | `Compte_Non_Justifie` (après EDNJUSTIFIEES-005) | comptes de T01, T06 | même décision et mêmes lignes que T01/T06 | `tests/non_justifie/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : clone **Laurux non modifié**, `faketime` à date fixe (date
  de l'en-tête), `/Soc01/caisse/CmdVis` = copie du PDF ; rejeu sur les deux clones.
- **Données** : `Laurux01.sql` ne contient **aucune écriture** : base = jeu dérivé commun aux
  éditions comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests),
  complété par des soldes `Fiches_Comptes.solde` volontairement faux sur quelques comptes (jeu
  partagé avec EDNLETTREES).
- **`TypeClient`** (`Inherits TreeView`) : `ReplayObserver` reconnaît les contrôles par le nom exact
  de leur classe et ne rejoue probablement pas la sélection dans `TypeClient1` : T03 à valider en
  début de phase 2 (sinon scénario manuel).
- **Non testable automatiquement** : son, aide, rendu graphique.
