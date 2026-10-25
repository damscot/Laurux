# MajFbtarif2 — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Maj future base tarif » (Gestion > Stock > Tarif > Future base tarif) : applique aux
articles dont `art_datefbt` vaut la date saisie leur futur prix de base `art_pbfbt` (importé par
`Impart`), recalcule toute la chaîne de prix, met à jour `Fiches_Art` et prépare les étiquettes.

## Points clés

- Tout le traitement est dans `Button2_Click`, sous `LOCK TABLES Fiches_Art, Fiches_Tvaav`.
- Chaîne de calcul sur 18 variables de module `String` ; 9 fonctions identiques ligne à ligne à
  `Etiqfbtarif`, 7 à `MajTarifP`.
- `Calc_Marge` n'a aucun effet observable ; `arr` n'est jamais affecté (pas d'arrondi du TTC).

## Dépendances principales

- Utilisé par : `Fmenu.Menu246_Click`.
- Utilise : `Utils.db`, `Cbase.Table`, `Utils.cpoint/Find_nbdec/Cdate_Dbase`, `Serveur.Pass`,
  `Variables.Sprix/Sexport/SMajArt` ; tables `Fiches_Art`, `Fiches_Tvaav`, `Fiches_EtiProd`,
  `Fiches_EtiGond`.

## Risques

- **Date vide** : les articles déjà traités sont resélectionnés et leurs prix recalculés depuis
  un prix de base nul (A01, critique, à confirmer par T04).
- Tables d'étiquettes hors `LOCK TABLES` : arrêt du traitement sous MySQL sans `UNLOCK` (A02).
- Arrondi `art_cdarr` ignoré (A03) ; `Val` sans `cpoint` en mode net (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 236 |
| Lignes de commentaire | 35 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 63 |
| Complexité max (fonction) | 15 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 replays (modes brut et net, étiquettes et verrou, date vide, aucun article, SQLite)
et 1 gb.test de la chaîne de calcul, possible après la commonalisation `LTarifCalc`.

## Rework

7 étapes (MAJFBTARIF2-001 à 007) : documentation, code mort `Calc_Marge`, réduction de portée de
12 fonctions, classe commune `LTarifCalc` (avec `MajTarifP`, `Etiqfbtarif`), module `EtiqMaj`,
séparation traitement/GUI, `Serveur.Actif`. 4 anomalies (A01 à A04).
