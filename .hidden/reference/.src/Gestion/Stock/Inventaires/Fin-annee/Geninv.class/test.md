# Geninv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (inventaire)** : la liste des scénarios ci-dessous est **à faire valider par
> l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5). Elle vise une couverture maximale de la
> génération de l'inventaire de fin d'exercice.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GENINV-T01 | replay | Génération, tri par défaut (Casiers + Code article) | `Laurux01.sql` sans `Fiches_Inv` ; date du jour forcée ; « Traitement » | dump `Fiches_Inv` : une ligne par article `art_stocke = 1`, `inv_nlig` 1..n dans l'ordre `art_casier, art_code`, `inv_qtestock = art_qte`, comptage 0 | `tests/gen_casier_code/` | à faire |
| GENINV-T02 | replay | Familles + Code | idem, radio `Fm` | ordre `art_fam, art_code` | `tests/gen_famille_code/` | à faire |
| GENINV-T03 | replay | Fournisseurs + Code | radio `Fr` | ordre `art_four, art_code` | `tests/gen_four_code/` | à faire |
| GENINV-T04 | replay | Casiers + Désignation | radio `Ds` | ordre `art_casier, art_design` | `tests/gen_casier_design/` | à faire |
| GENINV-T05 | replay | Familles + Désignation | `Fm` + `Ds` | ordre `art_fam, art_design` | `tests/gen_famille_design/` | à faire |
| GENINV-T06 | replay | Fournisseurs + Désignation | `Fr` + `Ds` | ordre `art_four, art_design` | `tests/gen_four_design/` | à faire |
| GENINV-T07 | replay | Régénération acceptée | `Fiches_Inv` existante avec comptages ; « Oui » | table recréée, comptages perdus ; message « non validé » (figé : jamais « validé ») | `tests/regen_oui/` | à faire |
| GENINV-T08 | replay | Régénération refusée | idem, « Non » | dump identique | `tests/regen_non/` | à faire |
| GENINV-T09 | replay | Première génération (table absente) | base sans `Fiches_Inv`, backtrace activé puis désactivé | génération via le `Catch` ; log `Exec_SQL` du `SELECT` en erreur (figé, GENINV-A03) | `tests/gen_premiere/` | à faire |
| GENINV-T10 | replay | Aucun article stocké | jeu dérivé avec `art_stocke = 0` partout | table créée vide ; message « Aucun article » | `tests/gen_vide/` | à faire |
| GENINV-T11 | replay | Stocks particuliers | articles avec `art_qte` Null, vide, négatif, 3 décimales | `inv_qtestock` 0 / 0 / négatif / arrondi à 2 décimales (figé) | `tests/gen_stocks/` | à faire |
| GENINV-T12 | replay | Date d'inventaire saisie | date ≠ jour (fin d'exercice) | `inv_date` = date saisie | `tests/gen_date/` | à faire |
| GENINV-T13 | replay | Impression de la feuille de comptage | après T01 ; case stock théorique cochée puis décochée | `~/tmp/Inventaire.pdf` converti en texte (`pdftotext`) : ordre des lignes (figé, GENINV-A01), colonne stock présente/absente | `tests/imp_feuille/` | à faire |
| GENINV-T14 | replay | Impression sans inventaire / article supprimé | table absente ; puis article supprimé de `Fiches_Art` après génération | message « Veuillez générer votre inventaire » dans les deux cas (figé, GENINV-A04) | `tests/imp_erreurs/` | à faire |
| GENINV-T15 | replay | Pagination | jeu dérivé > 40 articles stockés | changement de page à 288 mm, en-têtes répétés | `tests/imp_pagination/` | à faire |
| GENINV-T16 | replay | SQLite | T01 et T13 sur base SQLite | même contenu de `Fiches_Inv` ; ordre d'impression (rowid) à comparer avec MySQL | `tests/gen_sqlite/` | à faire |

## Détail des tests

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
