# Geninv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle,
> tests implémentés sans validation individuelle (PLAN.md §0 et §4.5). Elle vise une couverture maximale de la
> génération de l'inventaire de fin d'exercice.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GENINV-T01 | replay | Génération, tri par défaut (Casiers + Code article) | `Laurux01.sql` sans `Fiches_Inv` ; date du jour forcée ; « Traitement » | dump `Fiches_Inv` : une ligne par article `art_stocke = 1`, `inv_nlig` 1..n dans l'ordre `art_casier, art_code`, `inv_qtestock = art_qte`, comptage 0 | `tests/gen_casier_code/` | implémenté (gb.test `GeninvTest.T01…`) |
| GENINV-T02 | replay | Familles + Code | idem, radio `Fm` | ordre `art_fam, art_code` | `tests/gen_famille_code/` | implémenté (gb.test `GeninvTest.T02…`) |
| GENINV-T03 | replay | Fournisseurs + Code | radio `Fr` | ordre `art_four, art_code` | `tests/gen_four_code/` | implémenté (gb.test `GeninvTest.T03…`) |
| GENINV-T04 | replay | Casiers + Désignation | radio `Ds` | ordre `art_casier, art_design` | `tests/gen_casier_design/` | implémenté (gb.test `GeninvTest.T04…`) |
| GENINV-T05 | replay | Familles + Désignation | `Fm` + `Ds` | ordre `art_fam, art_design` | `tests/gen_famille_design/` | implémenté (gb.test `GeninvTest.T05…`) |
| GENINV-T06 | replay | Fournisseurs + Désignation | `Fr` + `Ds` | ordre `art_four, art_design` | `tests/gen_four_design/` | implémenté (gb.test `GeninvTest.T06…`) |
| GENINV-T07 | replay | Régénération acceptée | `Fiches_Inv` existante avec comptages ; « Oui » | table recréée, comptages perdus ; message « non validé » (figé : jamais « validé ») | `tests/regen_oui/` | implémenté (gb.test `GeninvTest.T07…`) |
| GENINV-T08 | replay | Régénération refusée | idem, « Non » | dump identique | `tests/regen_non/` | implémenté (gb.test `GeninvTest.T08…`) |
| GENINV-T09 | replay | Première génération (table absente) | base sans `Fiches_Inv`, backtrace activé puis désactivé | génération via le `Catch` ; log `Exec_SQL` du `SELECT` en erreur (figé, GENINV-A03) | `tests/gen_premiere/` | implémenté (gb.test `GeninvTest.T09PremiereGeneration`, `T09bPremiereSansBacktrace`) |
| GENINV-T10 | replay | Aucun article stocké | jeu dérivé avec `art_stocke = 0` partout | table créée vide ; message « Aucun article » | `tests/gen_vide/` | implémenté (gb.test `GeninvTest.T10…`) |
| GENINV-T11 | replay | Stocks particuliers | articles avec `art_qte` Null, vide, négatif, 3 décimales | `inv_qtestock` 0 / 0 / négatif / arrondi à 2 décimales (figé) | `tests/gen_stocks/` | implémenté (gb.test `GeninvTest.T11…`) |
| GENINV-T12 | replay | Date d'inventaire saisie | date ≠ jour (fin d'exercice) | `inv_date` = date saisie | `tests/gen_date/` | implémenté (gb.test `GeninvTest.T12…`) |
| GENINV-T13 | replay | Impression de la feuille de comptage | après T01 ; case stock théorique cochée puis décochée | `~/tmp/Inventaire.pdf` converti en texte (`pdftotext`) : ordre des lignes (figé, GENINV-A01), colonne stock présente/absente | `tests/imp_feuille/` | implémenté (gb.test `GeninvTest.T13…`) |
| GENINV-T14 | replay | Impression sans inventaire / article supprimé | table absente ; puis article supprimé de `Fiches_Art` après génération | message « Veuillez générer votre inventaire » dans les deux cas (figé, GENINV-A04) | `tests/imp_erreurs/` | implémenté (gb.test `GeninvTest.T14…`) |
| GENINV-T15 | replay | Pagination | jeu dérivé > 40 articles stockés | changement de page à 288 mm, en-têtes répétés | `tests/imp_pagination/` | implémenté (gb.test `GeninvTest.T15…`) |
| GENINV-T16 | replay | SQLite | T01 et T13 sur base SQLite | même contenu de `Fiches_Inv` ; ordre d'impression (rowid) à comparer avec MySQL | `tests/gen_sqlite/` | à faire : SQLite (le framework ne joue que MySQL/MariaDB) |

## Détail des tests

- **Implémentation (vague 9)** : module gb.test `.src/Tests/Gestion/GeninvTest.test` (prévu en replay) : écran
  instancié sans affichage, radios / Stkt / date posés, `gen_Inv`, `button1_Click` ou `Button3_Click` appelés ; les
  boîtes `Message.*` sont relevées et répondues par un Timer du module. Jeux `.hidden/Tests/Gestion/assets/geninv_shared/`
  (`inv_gen_articles` 6 articles croisés + 1 non stocké, `inv_gen_vide`, `inv_gen_stocks`, `inv_gen_nombreux` 45
  articles, `inv_gen_supprime`) et `validinv_shared/inv_fin_compte` (T07/T08, lecture seule). Feuille de comptage :
  `~/tmp/Inventaire.pdf` lu par `pdftotext -layout` (visualiseur neutralisé par `/Soc01/caisse/CmdVis`). T11 : le cas
  « art_qte vide » n'est pas représentable (colonne `double`) ; T09 : texte de la boîte d'erreur relevé sans la backtrace.

- **Valeurs attendues** : produites en rejouant chaque scénario dans le clone **Laurux non
  modifié** (dump normalisé, colonne `inv_date` non masquée car saisie ; date système figée par la
  configuration de test). Jamais déduites de la lecture du code.
- **Données** : `Laurux01.sql` ; jeux dérivés `art_non_stocke.sql` (T10), `art_stocks_limites.sql`
  (T11), `art_nombreux.sql` (T15, généré par `gen_input.py`).
- **PDF** : comparaison du texte extrait (`pdftotext -layout`) ; les dates d'impression sont
  masquées par `check_output.py`.
- **Replay** : écran instrumenté par `Utils.Observers` dans `_New`. Les `Message.Question` /
  `Message.Warning` doivent être rejoués par le harnais (réponse enregistrée dans le log).
- **gbtest** : après GENINV-005 (séparation traitement/GUI), `Generer` devient testable en gb.test
  s'il reste `Public` ; sinon la couverture passe par les replays ci-dessus.
- **Non testable** : la musique (`Music.Play`), le visualiseur PDF (`Visualiseur.Prog`, à
  neutraliser par configuration de test).
