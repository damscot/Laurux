# Changefour — Tests

> Source : `.src/Utils/Changefour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui ne modifie que `Fiches_Art.art_four` : tests **replay** sur MariaDB avec dump
normalisé de `Fiches_Art` (et de `Fiches_Four` pour contrôle) et diff des lignes `Exec_SQL`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHANGEFOUR-T01 | replay | Un article | Menu Gestion → Changement de fournisseur ; `Code` existant, `Nfour` via `TriCpt`, « Lancer » | `art_four` modifié pour l'article | `tests/article/` | à faire |
| CHANGEFOUR-T02 | replay | Champs manquants | « Lancer » avec `Code` vide puis `Nfour` vide | messages, aucune écriture | `tests/champs_vides/` | à faire |
| CHANGEFOUR-T03 | replay | Fournisseur entier | `Afour2` → `Nfour2`, bouton `Tag 6` ; puis `Afour2` vide, puis `Nfour2` vide | dump ; figer les messages inversés (A02) | `tests/fournisseur_global/` | à faire |
| CHANGEFOUR-T04 | replay | Liste d'articles | case `Liste`, 3 articles, « Lancer » | 3 articles modifiés | `tests/liste_articles/` | à faire |
| CHANGEFOUR-T05 | replay | Liste : doublon | même article ajouté 2 fois | figer l'erreur SQL (`code` inexistant, A01) | `tests/liste_doublon/` | à faire |
| CHANGEFOUR-T06 | replay | Import fichier | fichier `code;four` (2 valides, 1 fournisseur inconnu) | dump ; avertissement pour la ligne inconnue | `tests/import_fichier/` | à faire |
| CHANGEFOUR-T07 | replay | Sélection `TriCpt` annulée | sélection valide puis 2ᵉ ouverture annulée | figer la reprise de l'ancien `Bval` (A03) | `tests/selection_annulee/` | à faire |
| CHANGEFOUR-T08 | replay | Saisie code-barres | `Code` = `*<code-barres>` | article retrouvé | `tests/code_barre/` | à faire |

## Détail des tests

- **Valeurs attendues** : capture dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`),
  dump MariaDB normalisé, puis rejeu sur `Laurux_reworked` ; diff vide exigé.
- **Données** : `Laurux01.sql` + jeu dérivé : 3 fournisseurs, 5 articles répartis, un code-barres.
- **Non testable automatiquement** : sons, apparence du formulaire dynamique.
