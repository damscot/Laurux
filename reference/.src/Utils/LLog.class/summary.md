# LLog — Synthèse

> Source : `.src/Utils/LLog.class` · Synthèse des autres documents.

## Rôle

Logger de débogage par module (hérite de `ComplexLogger`). Créé à la demande par `Utils.Log` et rangé
dans `Start.LLogColl`, il écrit sur la console, dans `~/tmp/Debug/<Module>.log` (rotation 64 Ko) et
relaie chaque message au journal applicatif de `DB_Connection` (lignes `Log`).

## Points clés

- Niveaux 0 (Critical) à 7 (MessageBox), 8 = Max ; niveaux initiaux pris dans l'option `-d c,f`.
- Le message est préfixé par la backtrace de l'appelant.
- Niveau `MessageBox` : ouvre une boîte `Message.Error`.
- `DB_Log` modifie activation et niveaux à chaud.

## Dépendances principales

- Utilise : `Start.ConsoleLogLevel`, `Start.FileLogLevel`, `Utils.db.Log_Event`.
- Utilisé par : `Utils.Log` (fabrique), `DB_Log` (via `Start.LLogColl`), `Start.module` (constantes).

## Risques

- Indice non borné dans le message de boîte et `Extract` sur pile courte (A01).
- Niveaux hors échelle gb.logging relayés vers `DB_Connection` (A02).
- `deps.py` propose à tort de réduire la portée de `Level_Id`/`Level_Name`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 6 (`Log`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `gbtest` prévus (LLOG-T01 à T07) : construction, format et niveaux, logger inactif, relais vers
`DB_Connection`, libellés de niveaux, rotation, fabrique `Utils.Log`.

## Rework

4 étapes sans changement de comportement (LLOG-001 à 004) : documentation, extraction de la
backtrace, séparation du test d'affichage, chemin de débogage commun. 2 anomalies (LLOG-A01, A02).
