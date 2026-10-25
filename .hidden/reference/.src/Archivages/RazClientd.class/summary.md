# RazClientd — Synthèse

> Source : `.src/Archivages/RazClientd.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran modal « Epuration des clients divers caisses » (`Fmenu.Menu296`) : supprime de `Fiches_Clid`
les clients dont la date de dernier passage est strictement antérieure à la date choisie, après
confirmation et sauvegarde `mysqldump`.

## Points clés

- **Écran sans objet** : `Fiches_Clid` n'est plus alimentée par aucun code ; son seul lecteur,
  `TriclientsD`, est mort depuis `f442d721` (TRICLIENTSD-A01).
- Suppression exacte par clé `lind` ; borne `<` stricte ; pas de table liée.
- Sauvegarde dans le même fichier que `RazDevis` (`EffaceD.sql`), libellé de l'écran incohérent.
- Écran non instrumenté (`Utils.Observers` absent).

## Dépendances principales

- Appelé par `Fmenu.Menu296_Click` ; utilise `Utils.db`, `Cbase.Table("TabClid")`,
  `Syntheses.Message`, `Shell mysqldump`.

## Risques

- Faible en pratique (table figée, vide dans `Laurux01`) ; sauvegarde écrasée par `RazDevis` et non
  contrôlée (A02) ; SQLite sans effet (A03, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 27 |
| Lignes de commentaire | 6 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 6 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (RAZCLIENTD-T01 à T05), dump avant/après, horloge figée, **à valider par
l'utilisateur** ; sans objet si l'écran est supprimé.

## Rework

5 étapes (RAZCLIENTD-001 à 005) : documentation, code mort, `Purge`, commonalisation
(`Utils.DumpBase`, `Epuration`), `DELETE` unique. 3 anomalies, dont la suppression de l'écran
(A01) à décider avec TRICLIENTSD-A01.
