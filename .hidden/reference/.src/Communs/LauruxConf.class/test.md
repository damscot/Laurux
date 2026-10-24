# LauruxConf — Tests

> Source : `.src/Communs/LauruxConf.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans logique `Public` isolable (hors `Createbase`, lié aux contrôles) : tests **replay**.
Critères : `Laurux.conf` final (diff ligne à ligne, mots de passe chiffrés compris), dump des bases
`Laurux*` du serveur MariaDB Docker, messages du log GUI.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LAURUXCONF-T01 | replay | Ouverture avec configuration existante | `Laurux.conf` de test (`Password` = `crypt("laurux")`), bases `Laurux01`, `Laurux02` | `Nbase` liste les 2 bases, `Login`/`Host`/`Port` affichés, mot de passe déchiffré (log GUI) | `tests/ouverture/` | à faire |
| LAURUXCONF-T02 | replay | Valider une connexion correcte | Valider sans modification | `Laurux.conf` réécrit (dont `[Societes] Soc01`, `[dbase/ssh] Con-ssh`) ; message « Le fichier de configuration a été crée ou modifié » ; collation `utf8mb4_unicode_ci` | `tests/valider_ok/` | à faire |
| LAURUXCONF-T03 | replay | Mauvais mot de passe | `Password` faux, Valider | avertissement « utilisateur ou le mot de passe est erroné » ; mot de passe faux enregistré chiffré | `tests/mdp_faux/` | à faire |
| LAURUXCONF-T04 | replay | Base inconnue → création | `Nbase` = `Laurux05`, Valider, « Oui » | base `Laurux05` = `Laurux01.sql` avec `cd_sc` = `05` ; préférences `[Soc05]` et `[Coul]` par défaut ; `/Soc<courante>/Exp`… écrits sur la société courante (A05 figée) | `tests/creation_base/` | à faire |
| LAURUXCONF-T05 | replay | Création refusée | comme T04, réponse « Non » | aucune base créée ; configuration écrite par l'étape 1 de `Button1_Click` | `tests/creation_refusee/` | à faire |
| LAURUXCONF-T06 | replay | Fermeture non modale | ouverture par le menu (`Menu166`), Fermer | `Laurux.conf` réécrit par `Form_Close` (sans `Passphrase`/`Passp`), redémarrage de Laurux | `tests/fermeture_redemarrage/` | à faire |
| LAURUXCONF-T07 | replay | Premier démarrage | aucun `Laurux.conf` ; Laurux lancé avec `-c <fichier vide>` | écran modal, valeurs par défaut `Laurux01` / `3306` / `localhost` / `Maj` coché ; conf créée après validation | `tests/premier_demarrage/` | à faire |
| LAURUXCONF-T08 | replay | Serveur arrêté | conteneur MariaDB stoppé, Valider | avertissement « accès MySQL impossible » | `tests/serveur_arrete/` | à faire |
| LAURUXCONF-T09 | replay | Tunnel SSH | `Bssh` coché, conteneur SSH de test devant MariaDB | clés `[dbase/ssh]` écrites ; connexion via `127.0.0.1:<Portlocal>` (à confirmer : faisabilité du conteneur SSH) | `tests/tunnel_ssh/` | à faire |
| LAURUXCONF-T10 | replay | Mode préfixe | `/Soc01/Prefixe` actif, `Prefixe` = `pre_`, bases `pre_Laurux01` | figer le nom de base utilisé à l'ouverture (préfixe doublé, A04) et `Name` écrit par `Form_Close` | `tests/prefixe/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** avec un
  `Laurux.conf` de test passé par `-c`, puis rejeu sur les deux clones ; comparaison du
  `Laurux.conf` final et du dump des bases.
- **Fichiers `.conf` de test** : générés par `gen_input.py` à partir d'un gabarit (format décrit
  dans `architecture.md`, section « Format de `Laurux.conf` ») ; les mots de passe sont chiffrés
  par l'équivalent Python de `hexdblKey.Crypt` (`crypt("laurux") == "2D0D0D0D0D0D"`). T01 vérifie
  indirectement ce chiffrement (mot de passe déchiffré affiché).
- **Prérequis Docker** : `Host = 127.0.0.1` et port **3306** : `Shell mysql` et
  `Utils.Fill_DataBase` n'utilisent pas `/dbase/Port` ; `localhost` imposerait le socket Unix au
  client `mysql`. Utilisateur de test avec `CREATE`/`DROP DATABASE` ; `SUPER` facultatif.
- **Données** : `Laurux01.sql` (création) ; jeu dérivé `cd_sc = 02` pour la seconde base.
- **Non testable automatiquement** : le `FileChooser` SQLite (branche inatteignable, A01),
  l'aide HTML, les sons ; T09 dépend d'un conteneur SSH (à confirmer).
