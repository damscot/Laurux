# Lcr — Synthèse

> Source : `.src/Gestion/Lcr/Lcr.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Traitements LCR non attribuées » : première étape de la chaîne LCR. Import des traites de
facturation (`Fiches_Traites`) dans `Fiches_Lcr`, saisie/modification/suppression des LCR non
attribuées, impression de la liste des traites et de la liste des LCR.

## Points clés

- Chaîne LCR : `Lcr` → `Attribution` (banque) → `Preparation` (bordereau) → `Bordrx` (fichier
  bancaire CFONB + mail) ; aucune écriture comptable.
- SQL dans les handlers, tables en dur ; `insert … value` et `TRUNCATE` non compatibles SQLite.
- Signal d'arité `Ccompta.level2` (l. 635) : **faux positif** de `deps.py` ; l'appel vise
  `CLcr.Level2` avec la bonne arité.
- Code mort : `Deb3`, 4 impressions `Draw` (`Level1` à `Level4`), `sCmpt`, `sdesg`.
- Non instrumenté (`Utils.Observers` absent).

## Dépendances principales

- Ouvert par `Fmenu.MenuTrlcr_Click`. Utilise `CLcr`, `Ccompta`, `TriCpt`, `Utils`, `Cbase`,
  `LDate`, `Visualiseur`, `Doc`.
- Tables : `Fiches_Lcr`, `Fiches_Traites`, `Fiches_Cli`, `Fiches_Comptes`.
- Code dupliqué avec `Attribution`, `Preparation` (copier-coller) et `Impressions/Traites`.

## Risques

- Doublons de LCR à l'import si la purge est refusée (A02) → risque de double présentation à la
  banque.
- Clé de réglage `/Soc/Lcr` erronée (A01), impression des traites superposée (A04), liste imprimée
  différente de la liste affichée (A05).
- Mode SQLite inutilisable pour cet écran (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 562 |
| Lignes de commentaire | 45 |
| Fonctions | 48 |
| Fonctions Public | 48 |
| Complexité cyclomatique totale | 121 |
| Complexité max (fonction) | 17 (`Imp_Lcr`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 replays (LCR-T01 à T11) : filtres, consultation, création, modification, suppression, import
avec et sans purge, impression, recherche de compte, SQLite. **Module complexe : liste de
scénarios à valider par l'utilisateur avant la phase 2.** Replays conditionnés à l'instrumentation
(A08).

## Rework

8 étapes (LCR-001 à 008) : documentation, code mort, réduction de portée, `Lcrtable`, séparation
traitement/GUI, commonalisations avec `Attribution`/`Preparation` et `Traites`. 8 anomalies
(LCR-A01 à A08).
