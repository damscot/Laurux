# MajTarifM — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/MajTarifM.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Maj tarif manuelle » : liste des articles d'un fournisseur avec recherche incrémentale,
affichage côte à côte des prix actuels et des nouveaux prix saisissables (cascade prix de base →
remise → prix net → prix de revient → coefficient → PV HT → PV TTC arrondi), enregistrement dans
`Fiches_Art` et préparation des étiquettes.

## Points clés

- **Module complexe** : scénarios de test à faire valider par l'utilisateur avant la phase 2.
- 72 fonctions, toutes `Public` ; la cascade travaille sur le texte des contrôles.
- ~20 fonctions homonymes d'`Articles` (`Calc_*`, `TrC`, `arrondi`, `Tva_Calcul`, `ChkPrx`…).
- Calcul du PV par coefficient multiplicatif et arrondi par chaîne : pas équivalent a priori à
  la fabrique `PrixVente` (GESTAR-008) ; T09 mesure l'écart.
- Code mort : `Deb2`, `Deb3`, `Deb4`, `Dbclk`, `Calc_coeff`.

## Dépendances principales

- Utilisé par : `Fmenu.Menu249_Click`.
- Utilise : `Utils` (`Base`, `rs1`, `cpoint`, `CDec`, `Observers`…), `CPrix.Cascade/CTva`,
  `Cbase.Table`, `Serveur.Pass`, `Variables`, `EtiqRecpt`.

## Risques

- Liste des articles par SQL concaténé, code fournisseur sans guillemets (A01).
- Validations faites sur la colonne de gauche (`PaUA`, `Frais`, `Pvht`) au lieu des nouveaux
  prix (A04) ; marges fausses après le premier article (A05).
- Taux de conversion et frais saisis non enregistrés (A06) ; export serveur erroné (A03).
- Fournisseur saisi au clavier non contrôlé (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1107 |
| Lignes de commentaire | 91 |
| Fonctions | 72 |
| Fonctions Public | 72 |
| Complexité cyclomatique totale | 319 |
| Complexité max (fonction) | 25 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests : 10 replays (recherche, fournisseur alphanumérique, prix de base, remises en cascade,
prix net, coefficient/PV, étiquettes et exports, enchaînement de deux articles, conversion et
décimales, SQLite) et 1 gb.test documentaire de l'écart avec `PrixVente`.

## Rework

7 étapes (MAJTARIFM-001 à 007) : documentation, code mort, réduction de portée de 31 fonctions,
factorisation des handlers de recherche et de `Cmpt_KeyPress`, fonctions pures d'`Articles`
(ARTICLES-011/012), `EtiqMaj`/`Serveur.Actif`, séparation SQL/GUI. 6 anomalies (A01 à A06).
