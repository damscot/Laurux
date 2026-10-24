# SauvesAuto — Tests

> Source : `.src/Communs/SauvesAuto.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`Sauvegarde(Menu)` est `Public` dans un module : elle peut être appelée depuis gb.test avec une
fenêtre factice (`New Form`), à condition qu'un composant graphique soit chargé (affichage
virtuel, à confirmer en phase 2). Le scénario réel (fermeture de Laurux) est couvert par replay.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAUVESAUTO-T01 | gbtest | Sauvegarde sans FTP | `/Rep_Sauv` = répertoire de test absent, base `Laurux01.sql`, `Envoiftp` faux | répertoire créé, `<base>.sql` réimportable (dump identique), `<base><WeekDay(Now)>.sql.gz` = `gzip` du `.sql` | `tests/sauvegarde_locale/` | à faire |
| SAUVESAUTO-T02 | gbtest | Chemin absent | `/Rep_Sauv` vide | `Message.Warning` (à neutraliser ou capturer), aucun fichier | `tests/chemin_vide/` | à faire |
| SAUVESAUTO-T03 | replay | Déclenchement à la fermeture | `/Soc01/Sauvauto` = -1, `/dbase/Maj` = -1 ; fermeture de Laurux | fichiers de T01 présents ; avec `Maj` = 0 : aucun fichier | `tests/fermeture/` | à faire |
| SAUVESAUTO-T04 | replay | Envoi FTP | conteneur FTP de test, `Envoiftp` = -1, `Adrbase` = `ftp://127.0.0.1/sauve`, `Idftp`, `MdpFTP` = `crypt("…")` | fichier `.sql.gz` présent sur le serveur ; message « Sauvegarde terminée ! » | `tests/envoi_ftp/` | à faire |
| SAUVESAUTO-T05 | replay | Échec FTP | serveur FTP arrêté | figer le comportement actuel (exception non interceptée à la fermeture, A01) | `tests/echec_ftp/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** ; les `.sql` sont validés
  par réimport dans une base vierge et comparaison des dumps normalisés (le texte du dump varie
  avec la date et la version du serveur).
- **Prérequis** : `mysqldump` sur l'hôte, `Host = 127.0.0.1`, port **3306** ; un conteneur FTP
  (`vsftpd` ou équivalent) pour T04/T05. Le nom du fichier dépend du jour (`WeekDay(Now)`) : le
  test calcule le suffixe attendu au moment de l'exécution.
- **Non testable automatiquement** : l'aspect du curseur de la fenêtre.
