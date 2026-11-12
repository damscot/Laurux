# FCollectif — Tests

> Source : `.src/Compta/Tables/FCollectif.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : `replay` avec diff de `Fiches_Comptes`. Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCOLLECTIF-T01 | replay | Création | menu Collectifs ; `411100`, `Clients export` ; Enregistrer | ligne `coll = 1`, `cent_cc = 1`, `solde = 0`, type `B` | `tests/creation/` | implémenté |
| FCOLLECTIF-T02 | replay | Préfixe refusé | `456000` puis `512000` | message (cite 456, A04 figée), aucune écriture | `tests/prefixe_refuse/` | implémenté |
| FCOLLECTIF-T03 | replay | Modification | collectif existant avec solde ≠ 0 : intitulé modifié ; puis intitulé avec apostrophe | `solde` remis à 0 (A02 figée) ; erreur SQL affichée (A01 figée) | `tests/modification/` | implémenté |
| FCOLLECTIF-T04 | replay | Suppression | collectif mouvementé ; collectif avec comptes rattachés ; collectif libre ; compte non collectif `6xx` sans mouvement dans `Fiches_Mvt` | refus, refus, suppression, suppression (A03 figée) | `tests/suppression/` | implémenté |
| FCOLLECTIF-T05 | replay | Compte existant non collectif | code d'un compte client `411…` | « déjà utilisé par un compte client » | `tests/compte_non_collectif/` | implémenté |

## Détail des tests

- **Données** : `Laurux01.sql` ; jeu dérivé pour T03/T04 (solde forcé, écriture sur le collectif,
  compte rattaché par `coll_cc`).
- **Comparaison** : dump normalisé de `Fiches_Comptes`.

- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Compta/assets/fcollectif_creation` (T01),
  `fcollectif_prefixe_refuse` (T02), `fcollectif_modification` (T03), `fcollectif_suppression_refus` et
  `fcollectif_suppression` (T04, scindé pour tenir en 20 s), `fcollectif_compte_non_collectif` (T05).
  Jeu partagé `fcollectif_shared/fcollectif.sql` (453100 mouvementé au solde 125,5 ; 453200 libre).
