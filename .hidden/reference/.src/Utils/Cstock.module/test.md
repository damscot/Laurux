# Cstock — Tests

> Source : `.src/Utils/Cstock.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Logique métier critique : le stock théorique de chaque article. Tests sur **MariaDB** (Docker) avec
un jeu de mouvements construit pour couvrir chaque source de la formule, et comparaison du dump
normalisé de `Fiches_Art` (`art_code`, `art_qte`, `art_stkdep`) **et** des tables lues (inchangées),
plus diff des lignes `Exec_SQL`.

Tant que `Calc_stock` lit `Calcstock.Cbx*`, un test gb.test doit instancier le formulaire
(affichage virtuel Xvfb, à confirmer) et positionner les boutons radio ; après CSTOCK-003 (paramètre
de mode), l'appel est direct.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CSTOCK-T01 | gbtest | Tous les articles | jeu « mouvements » ; `Cbx3` coché (ou mode « tous ») ; `Calc_stock("", "")` | `art_qte` de référence pour chaque article | `tests/tous_articles/` | à faire |
| CSTOCK-T02 | gbtest | Un article | `Cbx` ; `Calc_stock("ART1", "")` | seul ART1 modifié | `tests/un_article/` | à faire |
| CSTOCK-T03 | gbtest | Plage de casiers | `Cbx2` ; `Calc_stock("A01", "B99")` | articles des casiers concernés seulement | `tests/casiers/` | à faire |
| CSTOCK-T04 | gbtest | Chaque source isolée | 9 articles, chacun avec un seul type de mouvement (BL B, BL F, BLM, facture, facture M, réception avec `txconv` 1 et 6, Mvtexp, Mvtexpdc, Sdepots '01' E/S et '02') | contribution de chaque source | `tests/sources/` | à faire |
| CSTOCK-T05 | gbtest | Inventaire tournant | article avec 2 inventaires tournants ; mouvements avant/après | stock repart du dernier inventaire | `tests/inventaire_tournant/` | à faire |
| CSTOCK-T06 | gbtest | Fuite de `dte2` entre articles | ART1 avec inventaire tournant au 01/06, ART2 (ordre suivant) avec inventaire tournant au 01/03 | figer le stock actuel (faux) d'ART2 (A02) | `tests/fuite_date/` | à faire |
| CSTOCK-T07 | gbtest | Date de départ | `dteinv` renseignée / Null (repli `dteclec1`) ; mouvements de part et d'autre | mouvements antérieurs exclus | `tests/date_depart/` | à faire |
| CSTOCK-T08 | gbtest | Valeurs nulles / texte | quantités Null, `"1,5"`, `art_txconv` Null, `art_stkdep` Null | figer les résultats | `tests/valeurs_limites/` | à faire |
| CSTOCK-T09 | replay | Appel depuis `Validinv` | validation d'un inventaire de fin d'année (écran Validinv) | figer l'absence de recalcul (A01) : `art_qte = art_stkdep` inventorié | `tests/validinv/` | à faire |
| CSTOCK-T10 | gbtest | `Art` non vide sans bouton | `Cbx` et `Cbx2` décochés, `Calc_stock("ART1", "")` | figer l'erreur « objet nul » (A03) | `tests/art_sans_mode/` | à faire |
| CSTOCK-T11 | gbtest | SQLite | T01 sur `Laurux01.sqlite` dérivé | figer l'erreur de syntaxe `UNION ALL(` (A04) | `tests/sqlite/` | à faire |
| CSTOCK-T12 | gbtest | Performance | 5 000 articles × 20 mouvements | durée de référence (`gbx3 -p`) | `tests/perf/` | à faire |

## Détail des tests

- **Valeurs attendues** : toujours produites en exécutant le recalcul dans le clone **Laurux non
  modifié** sur la même base restaurée, jamais calculées à la main (les anomalies A01-A04 sont ainsi
  figées). Un contrôle indépendant (`check_output.py`) recalcule la formule documentée en SQL pur
  et **signale** les écarts, sans faire échouer le test, pour aider la validation des anomalies.
- **Données** : `Laurux01.sql` + jeu dérivé `tests/<nom>/data.sql` généré par `gen_input.py`
  (articles stockés et non stockés, BL/BLM de types B, F et autres, factures et factures M,
  réceptions, mouvements exceptionnels, mouvements de dépôt sur `01` et `02`, inventaires
  tournants, `Fiches_Parametres.dteinv`). Les tables de caisse (`Fiches_EntTickets*`,
  `Fiches_EntTicketz`) sont vides et aucune caisse n'est connectée.
- **Normalisation** : tri par `art_code` ; `art_qte` arrondi à 1e-6.
- **Non testable automatiquement** : comportement concurrent (verrous avec un autre poste) ;
  T09 nécessite le scénario GUI de Validinv.
