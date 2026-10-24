# ClotureF — Synthèse

> Source : `.src/Gestion/ClotureF.class` · Synthèse des autres documents.

## Rôle

Écran de **clôture mensuelle de la facturation** : archive les factures imprimées de la période
(`Fiches_Bl` et `Fiches_BlM` → `Fiches_HistoFac[M]` via `ObjFacB.transblfac`), avance la période
(`Fiches_Parametres.dtepp`/`dtepec`), puis recalcule le solde de tous les comptes depuis
`Fiches_Mvt`.

## Points clés

- Ouvert en modal par `Fmenu.Menu147_Click` (avec contrôle du tunnel de réplication) et
  `Fmenu.lblClm_MouseDown` (sans ce contrôle).
- Tables en dur, aucune transaction, beaucoup de variables mortes.
- Condition l. 134 toujours vraie (chaîne évaluée en booléen) : filtre de période sans effet.
- `Calc_solde` est une copie exacte de `Csolde.Solde_caisse` (boucle sur tous les comptes).
- Table des paramètres vide → `Quit` de l'application.

## Dépendances principales

- Utilise : `ObjFacB` (calcul et transfert en archive), `Utils` (db, dates, tunnel), `LDate`,
  `ProgBar`, `Start`.
- Utilisé par : `Fmenu` (2 points d'entrée).

## Risques

- Borne de date incohérente entre `Fiches_Bl` (`<=`) et `Fiches_BlM` (`<`) (CLOTUREF-A01).
- Période avancée même en cas de transfert incomplet (CLOTUREF-A02).
- Aucune pré-condition (caisse, ticket Z, moulinage, période future) (CLOTUREF-A04).
- Le replay doit comparer les tables écrites indirectement par `ObjFacB.transblfac`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 32 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 8 (`Aff_date`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (CLOTUREF-T01 à T07 : nominal, borne de fin de mois, facture déjà archivée, annulation,
recalcul des soldes, changement d'année, dates nulles) et 1 gbtest (T08, période suivante après
séparation). Module de clôture : scénarios à valider par l'utilisateur avant la phase 2.

## Rework

7 étapes (CLOTUREF-001 à 007) : documentation, code mort, condition inutile, `Cbase.Table`,
délégation du solde à `Csolde`, séparation traitement/GUI, réduction de portée. 4 anomalies
(CLOTUREF-A01 à A04).
