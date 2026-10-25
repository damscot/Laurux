# TBord — Synthèse

> Source : `.src/Statistiques/TBord.class` · Synthèse des autres documents.

## Rôle

Écran « Tableau de bord » de la gestion commerciale (menu `Fmenu`, ou `Prgm` avec le nom `Tbord`).
Tout est calculé à l'ouverture : histogramme du CA HT mensuel sur 12 mois glissants, CA brut,
panier moyen, marges articles/MO et taux, nombre et montant des documents clients en cours par type
(proforma, devis, commande, BL, facture).

## Points clés

- Sources : factures historisées `Fiches_HistoFac` (+ `Fiches_HistoFacM` si matériel) et BL facturés
  imprimés `Fiches_Bl` type `F` (+ `Fiches_BlM`) pour la période ; `Fiches_Bl` toutes dates pour les
  documents en cours.
- Cumul mensuel dans la **table de travail `Total`** (DROP/CREATE à chaque ouverture, hors
  `db_control.csv`, nom partagé avec 7 autres écrans de statistiques et la caisse).
- `Traitement` (CC 49, 220 lignes) mêle SQL, cumuls et écriture des libellés ; le cumul est recopié
  deux fois (factures, BL).
- Pas d'`Utils.Observers` : l'écran n'est pas rejouable au-delà de son ouverture.

## Dépendances principales

- Appelé par `Fmenu` (ligne 2068) et `Prgm` (ligne 70), sur l'auto-instance.
- Utilise `Utils` (`db`, `Cdate_Dbase`, `cpoint`, `PointBase`), `Cbase`, `Variables` (son),
  `Start.LocalSettings` (`Materiel`, `Prxdec`).

## Risques

- Montants des documents en cours sous-évalués d'un document par type (A01).
- SQLite : `MONTH(&1)` avec une date substituée probablement non traduit (A02, à confirmer).
- Table `Total` partagée : collisions entre écrans et postes (A03 = STATCAI-A04).
- Barres de l'histogramme décalées si un mois est sans vente (A04) ; divisions par zéro (A05) ;
  indicateurs brut/net et échelle `Prxdec` à confirmer (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 339 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 49 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests prévus (TBORD-T01 à T08) : 6 replays d'ouverture comparant le dump de `Total` et les lignes
`Exec_SQL` (factures, matériel, BL facturés, documents en cours, base vide, division par zéro), 1
replay SQLite et 1 gbtest des indicateurs après extraction. Jeu de données commun `statistiques_ventes`
et horloge fixée. Le rendu graphique reste un contrôle visuel.

## Rework

8 étapes (TBORD-001 à 008) : documentation, code mort (requête et branche inutiles), `Cbase.Table`,
factorisation du cumul mensuel, séparation calcul/GUI, `Select Case`, histogramme commun avec
`VisHitCartes`, réduction de portée de 3 méthodes. 6 anomalies (TBORD-A01 à A06) soumises à
validation.
