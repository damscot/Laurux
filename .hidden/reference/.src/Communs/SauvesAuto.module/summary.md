# SauvesAuto — Synthèse

> Source : `.src/Communs/SauvesAuto.module` · Synthèse des autres documents.

## Rôle

Sauvegarde automatique de la base courante à la fermeture de la fenêtre principale
(`Fmenu.form_close`, si `/Soc<XX>/Sauvauto` et `/dbase/Maj`) : `mysqldump` vers
`<Rep_Sauv>/<base>.sql`, archive compressée `<base><jour>.sql.gz` (rotation sur 7 jours) et envoi
FTP facultatif de l'archive.

## Points clés

- Une seule fonction `Sauvegarde(Menu)`, nature mixte (shell, fichiers, FTP, messages).
- Le `.sql` non compressé est conservé : c'est la seule sauvegarde automatique restaurable
  directement par `FRestore`.
- Pas de `--lock-tables=0` (différence avec `FSauve`).
- Gestion d'erreur défaillante sur l'envoi FTP et sur le dump.

## Dépendances principales

- Utilisé par : `Fmenu.form_close` (`Fmenu.class:1228`).
- Utilise : `Utils.db`, `Start.LocalSettings` (`/Rep_Sauv`, `/dbase/Host`, préférences FTP de la
  société), `hexdblKey.Crypt`, `gb.compress`, `gb.net.curl` (`FtpClient`), `mysqldump`.

## Risques

- Erreur FTP non interceptée pendant la fermeture, succès toujours annoncé (A01).
- Échec de dump non détecté, archive vide envoyée (A02) ; contrôle d'URL inopérant (A03).
- Mot de passe visible dans `ps`, port et tunnel ignorés (A05) ; envoi possiblement interrompu si
  `Put` est asynchrone (A06, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 35 |
| Lignes de commentaire | 3 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 10 (`Sauvegarde`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests : 2 `gbtest` (sauvegarde locale, chemin vide ; fenêtre factice) et 3 replays (déclenchement
à la fermeture, envoi FTP vers un conteneur de test, échec FTP). Les `.sql` sont validés par
réimport et comparaison de dump.

## Rework

5 étapes (SAUVESAUTO-001 à 005) : documentation, nom d'archive calculé une fois, création du helper
transverse `Utils.DumpBase` (réutilisé par `FSauve` puis 14 autres appels), chemin de sauvegarde
commun, séparation traitement/messages. 6 anomalies (SAUVESAUTO-A01 à A06).
