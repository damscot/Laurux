# FpromoArt — Synthèse

> Source : `.src/Gestion/Tables/FpromoArt.class` · Synthèse des autres documents.

## Rôle

Saisie des articles d'une promotion (`Fiches_ArtPromo`) : choix de la promotion, de l'article,
du prix promo HT ou TTC avec contrôle de marge et de prix normal.

## Points clés

- `Cmpt_Keypress` (CC 22) concentre la saisie et les calculs de prix.
- Calculs HT/TTC et recherche d'article dupliqués (Facture, MvtDepots, LPrix/LTaxe).
- Code mort : `Code_KeyPress` (handler inactif, contrôle groupé), `Calc_Marge` (jamais appelée).
- `Bsel`/`Bval` écrits par `TriArticles` via `Object.SetProperty`.

## Dépendances principales

- Utilise : `Utils.Base`, `Utils.rs1`, `Utils.db`, `Utils.Find_Cbarre`, `Utils.cpoint`,
  `TriArticles`, `Cbase`.
- Utilisé par : `Fmenu` (`ShowModal`) ; table lue par `Caisse`, `Facture`, `ArtPromo`, `EtiqPromo`.
- `Colpromo_Click`, `ColArtPromo_Click` rejoués par `ReplayObserver` : restent `Public`.

## Risques

- A01 : `Deb2` concaténé et tri inopérant ; A02 : colonnes de dates hors bornes ; A03 : drapeau de
  marge mal réinitialisé.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 377 |
| Lignes de commentaire | 52 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 96 |
| Complexité max (fonction) | 22 (`Cmpt_Keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (ajout HT, ajout TTC refusé, drapeau de marge, modification, suppression, recherche
d'article) et 1 `gbtest` de calcul HT/TTC après séparation.

## Rework

6 étapes (001 à 006) : documentation, code mort, découpage de `Cmpt_Keypress`, recherche d'article
et calculs communs, séparation traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
