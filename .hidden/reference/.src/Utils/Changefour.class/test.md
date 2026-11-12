# Changefour — Tests

> Source : `.src/Utils/Changefour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui ne modifie que `Fiches_Art.art_four` : tests **replay** sur MariaDB avec dump
normalisé de `Fiches_Art` (et de `Fiches_Four` pour contrôle) et diff des lignes `Exec_SQL`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHANGEFOUR-T01 | replay | Un article | Menu Gestion → Changement de fournisseur ; `Code` existant, `Nfour` via `TriCpt`, « Lancer » | `art_four` modifié pour l'article | `tests/article/` | à faire : scénario prêt, attendus ref enregistrés ; compare rework suspendu (collision des bacs) |
| CHANGEFOUR-T02 | replay | Champs manquants | « Lancer » avec `Code` vide puis `Nfour` vide | messages, aucune écriture | `tests/champs_vides/` | à faire : scénario prêt, attendus ref enregistrés ; compare rework suspendu (collision des bacs) |
| CHANGEFOUR-T03 | replay | Fournisseur entier | `Afour2` → `Nfour2`, bouton `Tag 6` ; puis `Afour2` vide, puis `Nfour2` vide | dump ; figer les messages inversés (A02) | `tests/fournisseur_global/` | à faire : scénario prêt, attendus ref enregistrés ; compare rework suspendu (collision des bacs) |
| CHANGEFOUR-T04 | replay | Liste d'articles | case `Liste`, 3 articles, « Lancer » | 3 articles modifiés | `tests/liste_articles/` | implémenté (`changefour_liste_articles`) |
| CHANGEFOUR-T05 | replay | Liste : doublon | même article ajouté 2 fois | figer l'erreur SQL (`code` inexistant, A01) | `tests/liste_doublon/` | implémenté (`.hidden/Tests/Utils/assets/changefour_liste_doublon/`, erreur fatale « Unknown column 'code' » Changefour.AjoutArt.138 figée, code 125) |
| CHANGEFOUR-T06 | replay | Import fichier | fichier `code;four` (2 valides, 1 fournisseur inconnu) | dump ; avertissement pour la ligne inconnue | `tests/import_fichier/` | à faire : formulaire créé par code ($hForm) non observé, chemin choisi par Dialog.OpenFile |
| CHANGEFOUR-T07 | replay | Sélection `TriCpt` annulée | sélection valide puis 2ᵉ ouverture annulée | figer la reprise de l'ancien `Bval` (A03) | `tests/selection_annulee/` | à faire : sélection dans la grille de TriCpt non synthétisée |
| CHANGEFOUR-T08 | replay | Saisie code-barres | `Code` = `*<code-barres>` | article retrouvé | `tests/code_barre/` | implémenté (`changefour_code_barre`, code-barres 2148413200001 de l'article 001) |

## Détail des tests

- **Valeurs attendues** : capture dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`),
  dump MariaDB normalisé, puis rejeu sur `Laurux_reworked` ; diff vide exigé.
- **Données** : `Laurux01.sql` + jeu dérivé : 3 fournisseurs, 5 articles répartis, un code-barres.
- **Non testable automatiquement** : sons, apparence du formulaire dynamique.
- **Phase 2** : jeu `.hidden/Tests/Utils/assets/changefour_shared/changefour.sql` ; scénarios `.hidden/Tests/Utils/assets/changefour_{article,champs_vides,fournisseur_global,liste_articles,liste_doublon,code_barre}/` (T01, T02, T03, T04, T05, T08). Le nouveau fournisseur est saisi au clavier (pas de `TriCpt`). Case `Liste` : valeur de rejeu `-1` (CheckBox, `CInt`).
- **Rejeu phase 2** : T08 saisit `*2148413200001` (code-barres de l'article `001` présent dans `Fiches_CdBarre` de
  Laurux01.sql) : le code-barres de `CF5` du jeu `changefour.sql` n'existe que dans `art_cbarre`, or
  `Utils.Find_cbarre` ne consulte que `Fiches_CdBarre` puis `art_code`. En mode Liste, `Nfour` n'est pas vidé après
  « Ajouter » : il n'est saisi que pour le premier article (sinon concaténation `401005401005`).
