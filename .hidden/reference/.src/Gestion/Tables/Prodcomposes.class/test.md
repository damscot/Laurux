# Prodcomposes — Tests

> Source : `.src/Gestion/Tables/Prodcomposes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui modifie `Fiches_PrdComp` **et** `Fiches_Art` (coût du produit composé recalculé à
chaque affichage). Les replays comparent le dump normalisé de ces deux tables. Les calculs de coût
deviennent testables en `gbtest` après PRODCOMPOSES-004.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PRODCOMPOSES-T01 | replay | Affichage d'un produit composé | liste (`Button5`), sélection de `PC1` | grille des composants ; `Fiches_Art` de `PC1` : `art_pmp`, `art_pbht`, `art_pauaht`, `art_prvt` recalculés, `art_coef = 0` (A02 figée) | `tests/affichage/` | implémenté (A02 figée : art_coef = 0, art_prvt NULL pour PC1) |
| PRODCOMPOSES-T02 | replay | Ajout d'un composant article | code `PC1`, composant article `A3`, quantité `2,5`, Ajouter (clic) | ligne `Fiches_PrdComp` ; valeurs successives écrites dans `Fiches_Art` (A01 figée) | `tests/ajout_article/` | implémenté |
| PRODCOMPOSES-T03 | replay | Ajout d'une MO et modification de quantité | radio MO, sélection `04` (TriArticles), quantité `1` ; puis clic sur la ligne `A1`, quantité `3`, Ajouter | ligne `mo = 1` ; quantité remplacée ; coût recalculé | `tests/ajout_mo_modif/` | à faire : la saisie d'un code MO + Entrée passe par Art_Man (« composant n'existe pas ») ; MO accessible seulement par TriArticles (Button6), non synthétisé faute de temps |
| PRODCOMPOSES-T04 | replay | Contrôles et retrait | produit composé saisi comme composant ; composant inexistant ; composant déjà présent (réponse 1 puis 2) ; retrait d'un composant présent dans un BL (Oui/Non) ; Suppr dans la grille | messages ; `Fiches_PrdComp` modifiée ou non selon les réponses | `tests/controles_retrait/` | implémenté partiellement (prodcomposes_controles, prodcomposes_retrait) ; à faire : retrait répondu Non puis nouveau retrait (2e Message.Question non affiché au rejeu, non expliqué) et touche Suppr dans la grille |
| PRODCOMPOSES-T05 | replay | Clavier et F4 | Tab sur le bouton Ajouter (A05) ; F2 sur code et composant ; F4 sur code et sur composant (A06) | ajout déclenché par Tab ; listes ; produit composé rechargé | `tests/clavier/` | à faire : F2/F4 non rejoués ; F4 ouvre Articles (écran complexe exclu) |
| PRODCOMPOSES-T06 | replay | Composant article supprimé | jeu dérivé : `PC2` dont un composant n'existe plus dans `Fiches_Art` ; affichage de `PC2` | aucune mise à jour de `Fiches_Art` (A03 figée), affichage partiel | `tests/composant_absent/` | implémenté (A03 figée : aucune mise à jour de Fiches_Art pour PC2) |
| PRODCOMPOSES-T07 | gbtest | `CoutCompose` / `PrixRevientCompose` (après PRODCOMPOSES-004) | composants articles et MO, quantités `"1"`, `"2,5"`, `"0"`, quantité saisie `"0"`/`"3"`/vide | Float de référence | `tests/cout_compose/` | à faire : attend l'extraction PRODCOMPOSES-004 |
| PRODCOMPOSES-T08 | replay | Base SQLite | T01 et T03 rejoués sur `Laurux01.sqlite` | même dump qu'en MySQL ou écart documenté (test `"False"` de la colonne `mo`, A08) | `tests/sqlite/` | à faire : non traité dans la vague 4 (rejeu sur Laurux01.sqlite à étudier) |

## Détail des tests

- **Implémentation (phase 2)** : jeu `.hidden/Tests/Gestion/assets/prodcomposes_shared/prodcomposes_pc.sql` ;
  scénarios `prodcomposes_affichage` (T01), `prodcomposes_ajout_article` (T02), `prodcomposes_controles` et
  `prodcomposes_retrait` (T04), `prodcomposes_composant_absent` (T06). Date figée 2018-06-15.

- **Données** : jeu dérivé de `Laurux01.sql` (script SQL) : articles `PC1`/`PC2` avec
  `art_prdcomp = 1`, articles composants `A1`-`A3` avec PMP et prix de revient non nuls et des
  `art_dec` différents, lignes `Fiches_PrdComp` (articles et MO `04`), un BL contenant `A1`.
- **Valeurs attendues** : dumps de `Fiches_PrdComp` et `Fiches_Art` produits par le même replay
  dans le clone **Laurux non modifié** ; les anomalies A01-A03 sont figées telles quelles.
- **Locale** : `fr_FR.UTF-8` (quantités et montants stockés en texte avec virgule).
- **Non testable automatiquement** : couleurs de fond de la marge, bulles d'aide, contenu de
  l'écran `Articles` ouvert par F4 (seul son effet sur la base est comparé).
