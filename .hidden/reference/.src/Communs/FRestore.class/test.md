# FRestore — Tests

> Source : `.src/Communs/FRestore.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests **replay** sur MariaDB Docker : ce sont les tests les plus importants du harnais pour la
sauvegarde/restauration. Critère principal : dump normalisé de la base restaurée comparé au dump
d'origine ; secondaire : messages du log GUI, `Laurux.conf` final.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRESTORE-T01 | replay | Restauration non compressée | `Laurux01` modifiée (lignes ajoutées) ; `<rep>/Laurux01.sql` = dump de `Laurux01.sql` d'origine ; `/Compression` = 0 | dump identique à l'origine ; `Fiches_Docactif` vide ; message « correctement restaurée » | `tests/restauration_sql/` | à faire |
| FRESTORE-T02 | replay | Restauration compressée | `<rep>/Laurux01.sql.gz` ; `/Compression` = -1 | idem T01 ; `<rep>/Laurux01.sql` créé par la décompression | `tests/restauration_gz/` | à faire |
| FRESTORE-T03 | replay | Fichier absent | répertoire vide | `Message.Error` « ne peut pas être restaurée » ; base inchangée | `tests/fichier_absent/` | à faire |
| FRESTORE-T04 | replay | Restauration des préférences | `<rep>/Laurux.conf` différent du `.conf` courant, réponse « Oui » | `Laurux.conf` final = copie (ou réécrit à la fermeture : figer A03) ; arrêt de Laurux | `tests/preferences/` | à faire |
| FRESTORE-T05 | replay | Version différente | sauvegarde dont `Fiches_Parametres.version` = `3.68` | avertissement « version … différente » puis arrêt ; base restaurée | `tests/version_differente/` | à faire |
| FRESTORE-T06 | replay | Base très ancienne | sauvegarde sans colonne `version` | avertissement « très ancienne » puis arrêt | `tests/version_ancienne/` | à faire |
| FRESTORE-T07 | replay | Import en erreur | `<rep>/Laurux01.sql` tronqué (erreur SQL au milieu) | message d'échec ; base laissée partiellement remplie (A07 figée) | `tests/import_erreur/` | à faire |
| FRESTORE-T08 | replay | Mot de passe invalide | `Password` faux dans le `.conf` de test (connexion `Utils.db` faite avant changement) | figer la détection actuelle (`Process_List` en locale fr/en, MMYSQL-A01) | `tests/mdp_invalide/` | à faire |
| FRESTORE-T09 | replay | Trop de processus | > 7 connexions ouvertes sur le serveur | `Panel1` affiché ; `Button6` le masque | `tests/processus/` | à faire |
| FRESTORE-T10 | replay | Aller-retour sauvegarde/restauration | FSAUVE-T01 puis modification de la base puis FRESTORE-T01 | dump final = dump avant modification | `tests/aller_retour/` | à faire |

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
