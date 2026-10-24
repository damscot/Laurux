# LauruxMaj — Synthèse

> Source : `.src/Communs/LauruxMaj.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module de migration du schéma de la base : `Verif_Version`, appelé à chaque ouverture de `Fmenu`,
enchaîne les fonctions `MajXXX()` (2.04 → 3.69) selon la version lue, puis écrit la version suivante.
C'est l'unique endroit autorisé pour modifier le schéma (AGENTS.md).

## Points clés

- Trois générations de stockage de la version : `Laurux.conf` `/dbase/Version` (2.04 → 3.09, boucle
  sur toutes les sociétés d'une base unique), `/Societes/Soc<XX>` (3.10 → 3.59, une base par société
  depuis `Maj310`), puis `Fiches_Parametres.version` en base (3.60 → 3.69).
- Blocs séquentiels « en cascade » : une base ancienne franchit toutes les versions en un lancement.
- `/dbase/Maj` ne conditionne que l'appel de la migration ; la version est incrémentée même si
  `Maj = 0`.
- Instructions presque toutes sous `Try` (erreurs SQL ignorées) ; un `Catch` global affiche un
  message de restauration si la version en base diffère de celle de l'application.
- `Maj368` est la dernière migration taguée ; `Maj369` (CC 550, ~970 lignes : utf8mb4/InnoDB,
  règlements, caisse, dates, comptabilité, GED, index) n'est pas encore taguée.
- **Consigne utilisateur : migrations et dispatch non refactorisables.**
- 12 fonctions jamais appelées (`Maj40` … `Maj205`) ; 34 migrations historiques modifiées après leur
  tag (support SQLite : `AutoIncrement`/`Engine`).

## Dépendances principales

- Appelé uniquement par `Fmenu.Form_Open` (le mode caisse `-p` ne migre pas).
- Utilise `Utils.db` (DB_Connection), `Majversion`, `Start.LocalSettings`, `LDate`, `LGed`,
  `Mreglement`, `ProgBar`, `Sha1Calc`, `Cbase` ; `Shell mysql`/`mysqldump`/`xdg-open`.
- Touche ~150 tables, dont des tables dynamiques par caisse et toute la base via `information_schema`.

## Risques

- `Maj369` peut s'arrêter (moulinage non effectué) alors que le dispatcher marque la base en 3.69 ;
  « Continuer » arrête aussi.
- Sous SQLite, `SET NAMES` du prologue fait échouer tout le dispatcher (à confirmer) : aucune migration.
- `Maj = 0` sur un poste client fige une base dans l'ancien schéma tout en la déclarant à jour.
- Conversion utf8mb4 fondée sur le nom `"Laurux" & Societe` (ignore `/dbase/Prefixe`).
- Écarts attendus avec `db_control.csv` après migration (index historiques résiduels, types ajoutés).
- Dialogues modaux au milieu des migrations : automatisation des tests délicate.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 5100 |
| Lignes de commentaire | 188 |
| Fonctions | 110 |
| Fonctions Public | 110 |
| Complexité cyclomatique totale | 2251 |
| Complexité max (fonction) | 550 (`Maj369`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Un seul test replay, LAURUXMAJ-T01 « mise à jour depuis une base précédente » : `Laurux01.sql` du tag
`v3.68.8` (version 3.68), lancement avec `/dbase/Maj=1`, comparaison du schéma obtenu avec
`Laurux01.sql` et `db_control.csv` de HEAD (MariaDB ; SQLite en caractérisation). Les chemins
historiques (< 3.60) ne sont pas testables.

## Rework

Une seule case de documentation (LAURUXMAJ-001 : en-tête du module, flux d'exécution, règle de gel).
Aucune anomalie en case : les défauts (arrêt partiel, `Maj = 0`, SQLite, GED à un document, typo
`vatchar`, Sha1 `Mvt1` commenté, index MariaDB, index résiduels…) sont listés avec leurs liens dans
architecture.md, « Optimisations possibles (changement de schéma futur) ».
