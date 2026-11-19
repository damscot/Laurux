# Stockmvt — Tests

> Source : `.src/Gestion/Stockmvt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran est en lecture seule sur la base : les replays comparent le **SQL émis** (`Exec_SQL`,
bloquant pour les reworks sans changement SQL) et le **contenu affiché** (grille, totaux, CSV), pas
le dump. Écran complexe (CC 75) : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STOCKMVT-T01 | gbtest | Détail, toutes sources, un article | `Radioart` + code article, toutes les cases sources, `Radiotouta`, `Radiodetail`, C.A. et marge | SQL identique ; lignes et totaux affichés | `tests/detail_article/` | implémenté (StockmvtTest.T01DetailArticle, gb.test : écran instancié, Buttrait_Click appelé ; grille relevée par GridView1_Data, totaux ; le SQL n’est pas comparé, le jeu fait foi) |
| STOCKMVT-T02 | gbtest | Regroupement jour / mois / année par familles | `Radiofam`, 2 familles sélectionnées, `Checkart` coché puis non, chacun des 3 regroupements | SQL et grilles de référence | `tests/regroupements_familles/` | implémenté (T02RegroupementFamilles : 2 familles, Checkart × jour / mois / année) |
| STOCKMVT-T03 | gbtest | Filtres marque et centrale | marque puis centrale saisies, factures archivées cochées | fige A01 (jointure `art_code = num_ligfac`) | `tests/marque_centrale/` | implémenté (T03MarqueCentrale ; A01 figée : les factures archivées disparaissent du résultat) |
| STOCKMVT-T04 | gbtest | Filtres client / fournisseur | client seul ; fournisseur seul (réceptions seules) ; fournisseur + stock de départ coché | SQL de référence ; fige A02 (erreur SQL attendue dans le dernier cas) | `tests/client_fournisseur/` | implémenté (T04ClientFournisseur ; A02 figée : erreur SQL « …near SELECT Fiches_Ligrecpt.code… ») |
| STOCKMVT-T05 | gbtest | Entrées / sorties | `Radioentre` puis `Radiosortie`, stock départ et théorique valorisés PMP et prix d'achat | colonnes et totaux | `tests/entrees_sorties/` | implémenté (T05EntreesSorties : stock de départ et théorique, PMP / prix d’achat ; date du stock théorique (Now) masquée) |
| STOCKMVT-T06 | gbtest | Familles sans sélection | `Radiofam`, aucun nœud sélectionné | fige UTILS-A02 (SQL invalide `IN)`) | `tests/familles_vides/` | implémenté (T06FamillesVides ; UTILS-A02 figée : erreur SQL « …near ) UNION ALL… ») |
| STOCKMVT-T07 | gbtest | Édition PDF | après T01 : Éditer | `~/tmp/stockmvt.pdf` produit (comparaison texte via `pdftotext`) | `tests/edition_pdf/` | implémenté (T07EditionPdf : ~/tmp/stockmvt.pdf produit ; texte vide : rapport gb.report construit par code) |
| STOCKMVT-T08 | gbtest | Export CSV | après T01 (détail) puis après T02 (regroupé) | `~/tmp/Stockmvt.csv` de référence ; fige A04 (erreur en regroupé) | `tests/export_csv/` | implémenté (T08ExportCsv : CSV du détail, question « Non » par Timer ; A04 figée en regroupé : « Unknown field: nom ») |
| STOCKMVT-T09 | replay | Navigation vers le document | double-clic sur une ligne « Factures en cours », « … entretien », « Entrées fournisseurs » | document ouvert (fige A03) | `tests/ouverture_document/` | à faire : passe par Facture (ObjFacB.visualisation) et Achat (Commande1 en mode Achat.Validee) (revue manuelle) |
| STOCKMVT-T10 | gbtest | Construction de la requête | après STOCKMVT-004 : `ConstruitRequete` sur les jeux de critères de T01 à T06 | chaîne SQL identique à celle capturée par les replays | `tests/construit_requete/` | à faire : après extraction de ConstruitRequete (STOCKMVT-004) |
| STOCKMVT-T11 | gbtest | Performance | base volumineuse dérivée (10 000 lignes de BL/factures), toutes sources, regroupement mensuel | durée de référence (`gbx3 -p`) | `tests/perf_requete/` | implémenté (T11Performance : jeu stockmvt_shared/stock_performance, 1 000 lignes de vente générées par gen_stockmvt_perf.py ; regroupement mensuel et détail, lignes triées avant comparaison (ex aequo de ORDER BY dte,code non déterministes) ; ~2 s) |

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
