# RazRlvb — Synthèse

> Source : `.src/Archivages/RazRlvb.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran modal « Epuration des relevés bancaires » (menu Comptabilité, `Fmenu.Menu262`) : supprime de
`Fiches_Rappro` les relevés dont la date est strictement antérieure à la date choisie, après une
question de confirmation et une sauvegarde `mysqldump`.

## Points clés

- Opération **destructive**, un seul handler (`Button1_Click`) qui porte tout le SQL.
- Borne `<` stricte : les relevés du jour choisi sont conservés (MySQL).
- Table nommée en dur (`Fiches_Rappro`), sans `Cbase.Table` ; variable `PB` inutilisée.
- Écran non instrumenté (`Utils.Observers` absent) : pas de rejeu possible en l'état.

## Dépendances principales

- Appelé par `Fmenu.Menu262_Click` uniquement.
- Utilise `Utils.db`, `Start.LocalSettings["/dbase/Host"]`, `Syntheses.Message`, `Shell mysqldump`.
- Lien de données avec `Pointage` (relevé précédent, solde) et `Fiches_Mvt*.nrlv`.

## Risques

- **RAZRLVB-A01 (critique)** : répondre « Non » lance quand même la purge, sans sauvegarde.
- Sauvegarde non contrôlée, mot de passe en clair (A02) ; purge sans effet sous SQLite (A03, à
  confirmer) ; aucun garde-fou ni transaction, références orphelines dans `Fiches_Mvt*.nrlv` (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 2 |
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

6 tests `replay` (RAZRLVB-T01 à T06) : purge nominale, abandon (A01 figée), rien à purger,
sauvegarde, effet sur le pointage, SQLite. Comparaison du dump avant/après sur un jeu dérivé,
horloge figée ; scénarios **à valider par l'utilisateur** ; instrumentation de l'écran à décider en
phase 2.

## Rework

7 étapes (RAZRLVB-001 à 007) : documentation, code mort, `Cbase.Table`, `Utils.DumpBase`,
séparation `Purge`, module commun `Epuration` pour les six `Raz*`, `DELETE` unique. 4 anomalies
(A01 à A04) soumises à validation.
