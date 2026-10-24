# Stockmvt — Tests

> Source : `.src/Gestion/Stockmvt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran est en lecture seule sur la base : les replays comparent le **SQL émis** (`Exec_SQL`,
bloquant pour les reworks sans changement SQL) et le **contenu affiché** (grille, totaux, CSV), pas
le dump. Écran complexe (CC 75) : liste de scénarios à valider par l'utilisateur avant la phase 2.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STOCKMVT-T01 | replay | Détail, toutes sources, un article | `Radioart` + code article, toutes les cases sources, `Radiotouta`, `Radiodetail`, C.A. et marge | SQL identique ; lignes et totaux affichés | `tests/detail_article/` | à faire |
| STOCKMVT-T02 | replay | Regroupement jour / mois / année par familles | `Radiofam`, 2 familles sélectionnées, `Checkart` coché puis non, chacun des 3 regroupements | SQL et grilles de référence | `tests/regroupements_familles/` | à faire |
| STOCKMVT-T03 | replay | Filtres marque et centrale | marque puis centrale saisies, factures archivées cochées | fige A01 (jointure `art_code = num_ligfac`) | `tests/marque_centrale/` | à faire |
| STOCKMVT-T04 | replay | Filtres client / fournisseur | client seul ; fournisseur seul (réceptions seules) ; fournisseur + stock de départ coché | SQL de référence ; fige A02 (erreur SQL attendue dans le dernier cas) | `tests/client_fournisseur/` | à faire |
| STOCKMVT-T05 | replay | Entrées / sorties | `Radioentre` puis `Radiosortie`, stock départ et théorique valorisés PMP et prix d'achat | colonnes et totaux | `tests/entrees_sorties/` | à faire |
| STOCKMVT-T06 | replay | Familles sans sélection | `Radiofam`, aucun nœud sélectionné | fige UTILS-A02 (SQL invalide `IN)`) | `tests/familles_vides/` | à faire |
| STOCKMVT-T07 | replay | Édition PDF | après T01 : Éditer | `~/tmp/stockmvt.pdf` produit (comparaison texte via `pdftotext`) | `tests/edition_pdf/` | à faire |
| STOCKMVT-T08 | replay | Export CSV | après T01 (détail) puis après T02 (regroupé) | `~/tmp/Stockmvt.csv` de référence ; fige A04 (erreur en regroupé) | `tests/export_csv/` | à faire |
| STOCKMVT-T09 | replay | Navigation vers le document | double-clic sur une ligne « Factures en cours », « … entretien », « Entrées fournisseurs » | document ouvert (fige A03) | `tests/ouverture_document/` | à faire |
| STOCKMVT-T10 | gbtest | Construction de la requête | après STOCKMVT-004 : `ConstruitRequete` sur les jeux de critères de T01 à T06 | chaîne SQL identique à celle capturée par les replays | `tests/construit_requete/` | à faire |
| STOCKMVT-T11 | replay | Performance | base volumineuse dérivée (10 000 lignes de BL/factures), toutes sources, regroupement mensuel | durée de référence (`gbx3 -p`) | `tests/perf_requete/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (journal `Exec_SQL`,
  textes de la grille via `Utils.Observers`, fichiers PDF/CSV produits).
- **Données** : `Laurux01.sql` + jeu dérivé commun « stock » (à partager avec
  `Cstock`/`Calcstock`) : articles de plusieurs familles, marques et centrales, BL et factures
  (types A, B, F, en cours, entretien, archivées), réceptions, mouvements exceptionnels, produits
  composés, tickets archivés, `dteinv` renseigné.
- **Horloge** : dates par défaut (`Now`) et stock théorique daté de `Now` → horloge figée.
- **Fichiers** : `HOME` isolé ; ouverture du visualiseur PDF et de l'éditeur neutralisée.
- **SQLite** : non couvert (le `CAST … AS DATE` est à valider séparément).
