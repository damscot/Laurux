# FRelCompte — Tests

> Source : `.src/Compta/Relances/FRelCompte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu Relevés › De compte. Données : `Laurux01.sql` + jeu dérivé
(clients avec et sans `cli_rlvc`, fournisseurs, période couvrant plus de 50 écritures pour un compte,
un compte 411 sans fiche client). Comparaisons : dump de `Fiches_Relcomptes`, texte du PDF.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRELCOMPTE-T01 | replay | Liste clients | période du mois, `RB3` | dump `Fiches_Relcomptes` ; lignes et totaux de la liste | `tests/liste_clients/` | à faire |
| FRELCOMPTE-T02 | replay | Liste fournisseurs | même période, `RB4` | dump `Fiches_Relcomptes` (tous les fournisseurs) | `tests/liste_fournisseurs/` | à faire |
| FRELCOMPTE-T03 | replay | Édition de tous les comptes | `RB1`, Éditer | texte PDF de référence, saut de page | `tests/edition_tous/` | à faire |
| FRELCOMPTE-T04 | replay | Édition de la sélection | `RB2`, 2 comptes sélectionnés | texte PDF des 2 comptes seulement | `tests/edition_selection/` | à faire |
| FRELCOMPTE-T05 | replay | Contrôle de période | début modifié au 15, fin au 10 ; fin = début | avertissement selon `dte1` initial (A02 figée) | `tests/controle_periode/` | à faire |
| FRELCOMPTE-T06 | replay | Compte sans fiche tiers | écriture 411 sans `Fiches_Cli` | comportement actuel figé (erreur) | `tests/sans_fiche/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; PDF comparé par
  `pdftotext -layout`, date du jour masquée.
- Les mêmes scénarios existent pour `FRelFacture` : les jeux de données sont partagés.
- Non testable automatiquement : l'aide (`Doc.Open`).
