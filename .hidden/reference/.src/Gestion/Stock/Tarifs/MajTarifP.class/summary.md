# MajTarifP — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/MajTarifP.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Maj tarif en % » : applique un pourcentage de hausse ou de baisse à tous les articles
d'un fournisseur, sur le prix de base (mode brut) ou sur le PV HT (mode net), recalcule la chaîne
de prix, met à jour `Fiches_Art` et prépare les étiquettes produit et gondole.

## Points clés

- Traitement sous `LOCK TABLES` (articles, TVA, étiquettes) dans `Button2_Click` (CC 31).
- Chaîne de calcul copiée de `MajFbtarif2` (7 fonctions identiques) ; `Prix_achat` est mort,
  `Calc_Marge` sans effet, l'arrondi du TTC jamais appliqué (`arr` vide).
- Toute touche sur le bouton « Lancer » lance la mise à jour.

## Dépendances principales

- Utilisé par : `Fmenu.Menu248_Click`.
- Utilise : `Utils.db`, `Cbase.Table`, `Utils.cpoint/Find_nbdec/SetEditColor/Observers`,
  `Serveur.Pass`, `Variables.Sprix/Sexport/SMajArt`, `EtiqRecpt`.

## Risques

- Arrondi `art_cdarr` ignoré (A01) ; lancement par Tab (A02) ; tables laissées verrouillées en cas
  d'erreur, fournisseur vide accepté (A03) ; liste fournisseurs sans test `Available` (A04).
- Opération irréversible sur tout un fournisseur.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 350 |
| Lignes de commentaire | 44 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 112 |
| Complexité max (fonction) | 31 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 replays (modes brut et net, fournisseur, tabulation, fournisseur vide, SQLite) et
1 gb.test de la chaîne de calcul après `LTarifCalc`.

## Rework

7 étapes (MAJTARIFP-001 à 007) : documentation, code mort, réduction de portée de 14 fonctions,
`LTarifCalc` commun, factorisation des boucles, `EtiqMaj`/`Serveur.Actif`, séparation
traitement/GUI. 4 anomalies (A01 à A04).
