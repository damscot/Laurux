# SauvesAuto — Tests

> Source : `.src/Communs/SauvesAuto.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Sauvegarde(Menu)` est `Public` dans un module : elle peut être appelée depuis gb.test avec une
fenêtre factice (`New Form`), à condition qu'un composant graphique soit chargé (affichage
virtuel, à confirmer en phase 2). Le scénario réel (fermeture de Laurux) est couvert par replay.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAUVESAUTO-T01 | gbtest | Sauvegarde sans FTP | `/Rep_Sauv` = répertoire de test absent, base `Laurux01.sql`, `Envoiftp` faux | répertoire créé, `<base>.sql` réimportable (dump identique), `<base><WeekDay(Now)>.sql.gz` = `gzip` du `.sql` | `tests/sauvegarde_locale/` | implémenté |
| SAUVESAUTO-T02 | gbtest | Chemin absent | `/Rep_Sauv` vide | `Message.Warning` (à neutraliser ou capturer), aucun fichier | `tests/chemin_vide/` | implémenté (replay `sauvesauto_chemin_vide` : /Rep_Sauv absent via `conf`, fermeture par Menu118 ; avertissement vérifié par le rejeu ; le cas gb.test reste bloqué par Message.Warning) |
| SAUVESAUTO-T03 | replay | Déclenchement à la fermeture | `/Soc01/Sauvauto` = -1, `/dbase/Maj` = -1 ; fermeture de Laurux | fichiers de T01 présents ; avec `Maj` = 0 : aucun fichier | `tests/fermeture/` | implémenté (`sauvesauto_fermeture` et `sauvesauto_fermeture_sans_maj` : fermeture explicite par Menu118, --replay-exit ne ferme pas Fmenu ; .sql et .sql.gz comparés) |
| SAUVESAUTO-T04 | replay | Envoi FTP | conteneur FTP de test, `Envoiftp` = -1, `Adrbase` = `ftp://127.0.0.1/sauve`, `Idftp`, `MdpFTP` = `crypt("…")` | fichier `.sql.gz` présent sur le serveur ; message « Sauvegarde terminée ! » | `tests/envoi_ftp/` | implémenté (`sauvesauto_envoi_ftp` : faux serveur FTP « ok », @ftp.trace et archive reçue comparées) |
| SAUVESAUTO-T05 | replay | Échec FTP | serveur FTP arrêté | figer le comportement actuel (exception non interceptée à la fermeture, A01) | `tests/echec_ftp/` | implémenté (`sauvesauto_echec_ftp_refus`, `sauvesauto_echec_ftp_absent` : aucune exception, succès annoncé, A01 figée) |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** ; les `.sql` sont validés
  par réimport dans une base vierge et comparaison des dumps normalisés (le texte du dump varie
  avec la date et la version du serveur).
- **Prérequis** : `mysqldump` sur l'hôte, `Host = 127.0.0.1`, port **3306** ; un conteneur FTP
  (`vsftpd` ou équivalent) pour T04/T05. Le nom du fichier dépend du jour (`WeekDay(Now)`) : le
  test calcule le suffixe attendu au moment de l'exécution.
- **Non testable automatiquement** : l'aspect du curseur de la fenêtre.
- **Implémentation (phase 2)** : `.src/Tests/Communs/SauvesAutoTest.test` (T01) : `/Rep_Sauv` = sous-répertoire
  absent d'un répertoire temporaire (`Mkdir` n'est pas récursif : un parent absent fait échouer la sauvegarde
  sur `Message.Error`), `Form` factice, `mysqldump` par l'enveloppe de `Framework/bin` (port de test). Vérifiés :
  création du répertoire, noms des deux fichiers (`WeekDay(Now)` calculé à l'exécution), structure du dump
  (`DROP TABLE`, `CREATE TABLE`, `INSERT`, « Dump completed ») et `gzip -dc` de l'archive identique au `.sql`.
  Le réimport dans une base vierge n'est pas fait.
- **Implémentation (vague 2 bis)** : scénarios `.hidden/Tests/Communs/assets/sauvesauto_<nom>/`, configuration par
  `conf` de meta.json, sauvegarde déclenchée par Paramètres › Quitter (`Menu118` → `Fmenu.form_close`) : `--replay-exit`
  quitte sans fermer `Fmenu` et ne déclenche donc pas la sauvegarde (vérifié : aucun fichier produit).
  - `fermeture` (T03) : `Sauvauto` = -1, `Maj` = -1, `Rep_Sauv` = `/home/laurux/tmp/rejeu/sauve` (répertoire des sorties
    de `-T` dans le conteneur du runner, `LAURUX_DOCKER=1`) ; comparés `@sauve/Laurux01.sql` et `@sauve/Laurux014.sql.gz`
    (déterministes : `mysqldump`, nouveau processus sous `faketime`, écrit « Dump completed on 2026-01-15 10:00:00 » ;
    `WeekDay` du 15/01/2026 = 4). `fermeture_sans_maj` : `Maj` = 0, fichiers absents.
  - `chemin_vide` (T02) : `/Rep_Sauv` absent → avertissement (Entrée sur `FMessage`), aucun dump dans `sql.log`.
  - `envoi_ftp` (T04) : `"ftp": "ok"`, `Rep_Sauv` = `/tmp/laurux-test/sauve`, `Adrbase` = `{ftp}/sauve`, `Idftp` = `laurux`,
    `MdpFTP` = `2C030C1B1D05201F0B1A` (hexdblKey « en » de `motdepasse`, comme Prefs) ; comparés `@ftp.trace`
    (USER, PASS déchiffré, CWD sauve, STOR Laurux014.sql.gz), l'archive reçue `@ftp/sauve/Laurux014.sql.gz` et
    `@Laurux.conf`. « Sauvegarde terminée ! » validé par Entrée sur `FMessage`.
  - `echec_ftp_refus` / `echec_ftp_absent` (T05) : serveur « refus » (530, la trace s'arrête après PASS) ou « absent »
    (aucune trace). **Comportement observé** : aucune exception non interceptée (code 0, contrairement à ce que
    supposait A01) ; une seule boîte est affichée, l'annonce de succès (le `If Error` teste le `Try cp.File`) : A01
    figée pour sa partie « succès toujours annoncé ».
  - `Rep_Sauv` commençant par `~` : `Mkdir` et le `Shell mysqldump` le développent, pas `Compress.File` (archive non
    créée, `Message.Error`) : non figé par un test (candidat anomalie).

