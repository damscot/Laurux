# FSauve — Synthèse

> Source : `.src/Communs/FSauve.class` · Synthèse des autres documents.

## Rôle

Écran de sauvegarde manuelle de la base courante : `mysqldump --lock-tables=0` vers
`<rep>/<base>.sql`, compression facultative en `<base>.sql.gz` (le `.sql` est conservé), copie du
fichier de configuration `Laurux.conf` dans le même répertoire. Produit les fichiers attendus par
`FRestore` et envoyés par `Expbase`.

## Points clés

- Écran GUI avec traitement shell intégré, MySQL/MariaDB uniquement.
- Contrôle préalable du nombre de processus MySQL (`Mmysql.Process_List`) : 0 → mot de passe
  invalide, > 7 → proposition de redémarrer MySQL.
- La détection d'erreur du dump est morte : tout dump est annoncé réussi.
- `mysqldump` est construit à la main dans 16 endroits du projet : candidat majeur de
  commonalisation (`Utils.DumpBase`).

## Dépendances principales

- Utilisé par : `Fmenu.Menu57_Click`.
- Utilise : `Utils.db`, `Start.LocalSettings` (`/Rep_Sauv`, `/Compression`, `/dbase/Host`),
  `Mmysql`, `Editeur`, `Doc`, `gb.compress`, commandes `mysqldump`, `cp`.

## Risques

- Échec de dump non détecté (A01) ; répertoire absent sans message (A02).
- Copie de la configuration en dur, `-c` ignoré (A03) ; erreur de compression non interceptée (A04).
- Port et tunnel SSH ignorés, mot de passe visible dans `ps` (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 23 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 12 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (FSAUVE-T01 à T06) sur MariaDB Docker : sauvegarde simple et compressée (validées par
réimport et comparaison de dump), répertoire absent, contrôle des processus, mémorisation de la
compression, échec de `mysqldump`. `HOME` isolé pour la copie du `.conf`.

## Rework

6 étapes (FSAUVE-001 à 006) : documentation, variables locales, séparation `SauveBase`, helpers
communs `Utils.DumpBase`, `Utils.FichierSauvegarde`, écran jumeau de `FRestore`. 7 anomalies
(FSAUVE-A01 à A07).
