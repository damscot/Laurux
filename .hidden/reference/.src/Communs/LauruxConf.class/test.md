# LauruxConf — Tests

> Source : `.src/Communs/LauruxConf.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans logique `Public` isolable (hors `Createbase`, lié aux contrôles) : tests **replay**.
Critères : `Laurux.conf` final (diff ligne à ligne, mots de passe chiffrés compris), dump des bases
`Laurux*` du serveur MariaDB Docker, messages du log GUI.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LAURUXCONF-T01 | replay | Ouverture avec configuration existante | `Laurux.conf` de test (`Password` = `crypt("laurux")`), bases `Laurux01`, `Laurux02` | `Nbase` liste les 2 bases, `Login`/`Host`/`Port` affichés, mot de passe déchiffré (log GUI) | `tests/ouverture/` | implémenté |
| LAURUXCONF-T02 | replay | Valider une connexion correcte | Valider sans modification | `Laurux.conf` réécrit (dont `[Societes] Soc01`, `[dbase/ssh] Con-ssh`) ; message « Le fichier de configuration a été crée ou modifié » ; collation `utf8mb4_unicode_ci` | `tests/valider_ok/` | implémenté (lauruxconf_valider_ok : boîte Message.Info et @Laurux.conf comparé : [Societes] Soc01, Maj=-1, backtrace=0 ; requêtes après Utils.db.Close absentes de sql.log, DB_CONNECTION-A12) |
| LAURUXCONF-T03 | replay | Mauvais mot de passe | `Password` faux, Valider | avertissement « utilisateur ou le mot de passe est erroné » ; mot de passe faux enregistré chiffré | `tests/mdp_faux/` | implémenté (lauruxconf_mdp_faux : boîte d'avertissement et @Laurux.conf comparé, mot de passe faux chiffré) |
| LAURUXCONF-T04 | replay | Base inconnue → création | `Nbase` = `Laurux05`, Valider, « Oui » | base `Laurux05` = `Laurux01.sql` avec `cd_sc` = `05` ; préférences `[Soc05]` et `[Coul]` par défaut ; `/Soc<courante>/Exp`… écrits sur la société courante (A05 figée) | `tests/creation_base/` | xfail : erreur fatale dans Fill_DataBase (journal fermé par Utils.db.Close, mode -l, DB_CONNECTION-A12) avant UPdate cd_sc ; base Laurux05 (« bases ») et @Laurux.conf comparés |
| LAURUXCONF-T05 | replay | Création refusée | comme T04, réponse « Non » | aucune base créée ; configuration écrite par l'étape 1 de `Button1_Click` | `tests/creation_refusee/` | implémenté (lauruxconf_creation_refusee : Message.Question, réponse Non, @Laurux.conf de l'étape 1 comparé ; aucune base créée) |
| LAURUXCONF-T06 | replay | Fermeture non modale | ouverture par le menu (`Menu166`), Fermer | `Laurux.conf` réécrit par `Form_Close` (sans `Passphrase`/`Passp`), redémarrage de Laurux | `tests/fermeture_redemarrage/` | implémenté (gb.test : Form_Close appelé directement, configuration vérifiée en mémoire ; redémarrage réel non rejoué) |
| LAURUXCONF-T07 | replay | Premier démarrage | aucun `Laurux.conf` ; Laurux lancé avec `-c <fichier vide>` | écran modal, valeurs par défaut `Laurux01` / `3306` / `localhost` / `Maj` coché ; conf créée après validation | `tests/premier_demarrage/` | implémenté (gb.test : configuration vide, valeurs par défaut puis Form_Close ; validation non couverte) |
| LAURUXCONF-T08 | replay | Serveur arrêté | conteneur MariaDB stoppé, Valider | avertissement « accès MySQL impossible » | `tests/serveur_arrete/` | implémenté (serveur injoignable simulé par le port 1) |
| LAURUXCONF-T09 | replay | Tunnel SSH | `Bssh` coché, conteneur SSH de test devant MariaDB | clés `[dbase/ssh]` écrites ; connexion via `127.0.0.1:<Portlocal>` (à confirmer : faisabilité du conteneur SSH) | `tests/tunnel_ssh/` | à faire : conteneur SSH de test indisponible (tunnel ssh hors Laurux) |
| LAURUXCONF-T10 | replay | Mode préfixe | `/Soc01/Prefixe` actif, `Prefixe` = `pre_`, bases `pre_Laurux01` | figer le nom de base utilisé à l'ouverture (préfixe doublé, A04) et `Name` écrit par `Form_Close` | `tests/prefixe/` | implémenté (gb.test) |

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

### Implémentation (phase 2, 2026-11-11)

- gb.test `.src/Tests/Communs/LauruxConfTest.test` (T01, T06, T07, T10) : formulaire construit sans être affiché,
  contrôles relus par `Controls`, `Form_Close` appelé directement, configuration vérifiée en mémoire
  (`Start.LocalSettings`). Jeux : `fsoc_deux_bases` (T01, T06, T07), `lauruxconf_prefixe` (T10 : bases
  `pre_Laurux01/02` ; préfixe doublé `pre_pre_Laurux01` à l'ouverture et `Name` = `pre` à la fermeture, A04).
  Constat T01 : `Backtrace.Value = /dbase/backtrace` absent lève une erreur dans `_new` → passage par le `Catch`
  (Maj forcé à vrai, `Nouveau` = vrai) même avec une configuration valide (candidat anomalie).
- Scénarios `.hidden/Tests/Communs/assets/lauruxconf_<nom>/` : `lauruxconf_valider_ok` (T02),
  `lauruxconf_mdp_faux` (T03), `lauruxconf_creation_base` (T04, xfail, code 125),
  `lauruxconf_creation_refusee` (T05), `lauruxconf_serveur_arrete` (T08 : port 1 au lieu d'arrêter le
  conteneur). `Button1_Click` ferme Utils.db (et le journal SQL) : seules les boîtes Message.* sont vérifiées.

### Implémentation (vague 2 bis, 2026-11-12 : clés bases / fichiers de meta.json)

- T02, T03, T05 : `"fichiers": ["@Laurux.conf"]` ajouté ; sql.log et dump inchangés. Configuration finale : `[Coul]`
  par défaut de `Start.Main`, `[Societes] Soc01` = version, `/dbase/Maj` = -1, `/dbase/backtrace` = 0 ; T03 :
  `Password` = chiffré de « faux » ; T05 : même configuration que T02 (étape 1), sans base créée.
- T04 : `"bases": ["Laurux05"]` et `"fichiers": ["@Laurux.conf"]` ajoutés (xfail et code 125 maintenus,
  DB_CONNECTION-A12) : Laurux05 = copie brute de Laurux01.sql (`Fiches_Societes` ligne `01`, UPdate cd_sc non
  atteint) ; configuration : `/Soc` = 05, `Tips` = 1, `[Soc05]` créée, `/Soc01/Exp`/`Lettrage` écrits sur la société
  courante (A05), `[Coul]` à virgules de `Createbase`. sql.log et dump de Laurux01 inchangés.
