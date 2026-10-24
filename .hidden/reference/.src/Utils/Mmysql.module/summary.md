# Mmysql — Synthèse

> Source : `.src/Utils/Mmysql.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Administration du serveur MySQL local par shell pour les écrans de sauvegarde et de restauration :
redémarrage du service (`Init`) et contrôle du mot de passe par `mysqladmin processlist`
(`Process_List`).

## Points clés

- Deux fonctions, 4 appels (`FSauve`, `FRestore`).
- Élévation par `gksu`/`kdesu` + `sudo -S` : outils obsolètes.
- Échec d'authentification détecté par un message en français.
- Mot de passe MySQL visible dans la liste des processus ; fichier temporaire `~/tmp/resultat`.

## Dépendances principales

- `Utils.db` (login, mot de passe), `Start.LocalSettings` (hôte).
- Programmes externes : `gksu`, `kdesu`, `sudo`, `mysqladmin`, `/etc/init.d/mysql`.

## Risques

- Contrôle de mot de passe inopérant hors locale française.
- Redémarrage inopérant sur les systèmes actuels.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 27 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 7 (`Process_List`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `gbtest` (MMYSQL-T01 à T03) avec des outils d'élévation factices dans le `PATH` et le
MariaDB Docker.

## Rework

3 étapes (MMYSQL-001 à 003) : documentation, simplification d'`Init`, helper MySQL commun avec
`Utils`. 2 anomalies (MMYSQL-A01, A02).
