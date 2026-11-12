# FRestore — Tests

> Source : `.src/Communs/FRestore.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests **replay** sur MariaDB Docker : ce sont les tests les plus importants du harnais pour la
sauvegarde/restauration. Critère principal : dump normalisé de la base restaurée comparé au dump
d'origine ; secondaire : messages du log GUI, `Laurux.conf` final.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRESTORE-T01 | replay | Restauration non compressée | `Laurux01` modifiée (lignes ajoutées) ; `<rep>/Laurux01.sql` = dump de `Laurux01.sql` d'origine ; `/Compression` = 0 | dump identique à l'origine ; `Fiches_Docactif` vide ; message « correctement restaurée » | `tests/restauration_sql/` | implémenté |
| FRESTORE-T02 | replay | Restauration compressée | `<rep>/Laurux01.sql.gz` ; `/Compression` = -1 | idem T01 ; `<rep>/Laurux01.sql` créé par la décompression | `tests/restauration_gz/` | implémenté |
| FRESTORE-T03 | replay | Fichier absent | répertoire vide | `Message.Error` « ne peut pas être restaurée » ; base inchangée | `tests/fichier_absent/` | implémenté |
| FRESTORE-T04 | replay | Restauration des préférences | `<rep>/Laurux.conf` différent du `.conf` courant, réponse « Oui » | `Laurux.conf` final = copie (ou réécrit à la fermeture : figer A03) ; arrêt de Laurux | `tests/preferences/` | implémenté |
| FRESTORE-T05 | replay | Version différente | sauvegarde dont `Fiches_Parametres.version` = `3.68` | avertissement « version … différente » puis arrêt ; base restaurée | `tests/version_differente/` | implémenté |
| FRESTORE-T06 | replay | Base très ancienne | sauvegarde sans colonne `version` | avertissement « très ancienne » puis arrêt | `tests/version_ancienne/` | implémenté |
| FRESTORE-T07 | replay | Import en erreur | `<rep>/Laurux01.sql` tronqué (erreur SQL au milieu) | message d'échec ; base laissée partiellement remplie (A07 figée) | `tests/import_erreur/` | implémenté |
| FRESTORE-T08 | replay | Mot de passe invalide | `Password` faux dans le `.conf` de test (connexion `Utils.db` faite avant changement) | figer la détection actuelle (`Process_List` en locale fr/en, MMYSQL-A01) | `tests/mdp_invalide/` | à faire : Process_List lance gksu (absent) : le message d'erreur du shell donne toujours lg = 1, « Mot de passe invalide » inatteignable |
| FRESTORE-T09 | replay | Trop de processus | > 7 connexions ouvertes sur le serveur | `Panel1` affiché ; `Button6` le masque | `tests/processus/` | à faire : même raison que T08 (gksu absent : lg = 1, jamais > 7) ; Panel1 inatteignable |
| FRESTORE-T10 | replay | Aller-retour sauvegarde/restauration | FSAUVE-T01 puis modification de la base puis FRESTORE-T01 | dump final = dump avant modification | `tests/aller_retour/` | implémenté |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** (`-c` vers un
  `Laurux.conf` de test, `/Rep_Sauv` pointant vers un répertoire du test), puis rejeu sur les deux
  clones ; les dumps de référence sont produits par `mysqldump` du conteneur.
- **Données** : `Laurux01.sql` ; jeu dérivé `version = 3.68` (T05), table `Fiches_Parametres` sans
  colonne `version` (T06), fichier tronqué (T07).
- **Prérequis Docker** : client `mysql`/`mysqladmin` installés sur l'hôte du test, `Host =
  127.0.0.1`, port **3306** (aucun `Shell` ne passe `-P`), `~/tmp` existant. Le conteneur doit
  être **MariaDB** (branche `bmariadb`) ; un second conteneur MySQL 8 couvrirait la branche
  « Using a password » (facultatif).
- **Volatilité** : la date/heure et le « propriétaire » lus par `ls` figurent dans la question de
  confirmation ; le runner les masque dans le log.
- **Non testable automatiquement** : `Button5_Click` (redémarrage de MySQL par `gksu`/`kdesu` +
  `sudo`), l'éditeur `Button4_Click`, les sons.

## Implémentation (phase 2)

- Scénarios `.hidden/Tests/Communs/assets/frestore_<répertoire>/` (Restauration : `Fmenu#Menu55#Menu65`), jeu
  `fusers_base` (3 utilisateurs, effacés par la restauration). Fichiers de sauvegarde dans le répertoire du
  scénario (copiés dans `/tmp/laurux-test/`, saisi dans `SauveB`) : `Laurux01.sql` (d'origine ; + `UPDATE …
  version = '3.68'` pour T05 ; + `ALTER TABLE Fiches_Parametres DROP COLUMN version` pour T06 ; tronqué à
  110 000 octets pour T07), `Laurux01.sql.gz` (T02 : Laurux01.sql + utilisateur témoin « depuis_gz », qui prouve la
  décompression). `/tmp/laurux-test/` est partagé par les scénarios d'un même conteneur : chaque scénario qui
  atteint la question des préférences apporte son propre `Laurux.conf` (réponse « Non », sauf T04 « Oui »).
- `/Compression` (absent de la configuration de test) est posé dans le même rejeu par FSauve (Compb coché puis
  Quitter) pour T02. T03 : répertoire inexistant `/tmp/laurux-test/absent`.
- Codes de sortie figés : T05, T06 : 255 (arrêt par `Utils.Exit(False)`) ; T04 : 125 (après `Utils.Exit`,
  `Me.Close` journalise l'événement GUI dans un journal fermé : « [gb.logging].FileHandler.Write.46:
  Uninitialized or already closed handler! », candidat anomalie). Le `Laurux.conf` final (T04) n'est pas comparé.
- T10 `frestore_aller_retour` : FSauve dans `/tmp`, suppression de « martin » (Fusers), restauration : retour à
  l'état sauvegardé.
- `Process_List` lance `gksu` (absent) : le message d'erreur du shell compte pour une ligne, `lg` vaut toujours 1
  (ni « Mot de passe invalide », ni `Panel1`) ; T08 et T09 ne sont pas atteignables.
