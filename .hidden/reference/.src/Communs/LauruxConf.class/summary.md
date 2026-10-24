# LauruxConf — Synthèse

> Source : `.src/Communs/LauruxConf.class` · Synthèse des autres documents.

## Rôle

Écran de configuration de la connexion SQL : lit et écrit les sections `[dbase]` et `[dbase/ssh]`
de `~/.config/gambas3/Laurux.conf` (ou du fichier `-c`), teste la connexion (tunnel SSH
facultatif) et crée une base société depuis `Laurux01.sql` avec les préférences par défaut
(`Createbase`, utilisé aussi par `Fsoc` et `Dup`).

## Points clés

- Format du fichier : INI `gb.settings` ; `[dbase]` = `type`, `Prefixe`, `Name` (sans préfixe),
  `Login`, `Password` (chiffré), `Port`, `Host`, `Maj`, `backtrace`, `Con-ssh` ; `[dbase/ssh]` =
  `Login`, `Hostssh`, `Passwssh` (chiffré), `Portssh`, `Portlocal`, `Passphrase`, `Passp`.
- Chiffrement : octet `Xor` clé cyclique (`Laurux` ou `LauruX2012`) `Xor 13`, puis hexadécimal
  majuscule (`crypt("laurux") = "2D0D0D0D0D0D"`) ; équivalent Python dans `architecture.md`.
- `_new` (CC 54) duplique son bloc de lecture dans le `Catch`.
- `Createbase` lit les contrôles de l'écran, même quand il est appelé sur l'auto-instance cachée.
- `ComboBox1_Click` force `mysql` : SQLite inatteignable par la GUI.

## Dépendances principales

- Utilisé par : `Fmenu` (`Config`, `Menu166_Click`), `Cmenu`, `Caisse/Preferences`, `Fsoc` et `Dup`
  (`Createbase`).
- Utilise : `Start.LocalSettings`, `Utils.db`, tunnel SSH (`Utils.monteTunnel`/`fermeTunnel`),
  `Utils.Fill_DataBase`, `hexdblKey.Crypt`, `Majversion.Version`, `Cbase.Table("TabSoc")`.

## Risques

- `Createbase` remplit `Laurux<XX>` au lieu de la base demandée et ignore l'échec de l'import (A02).
- Clé `Con-ssh` écrite au mauvais endroit (A03), préfixe doublé (A04).
- Préférences par défaut écrites sur la société courante, clés globales réinitialisées (A05).
- Mot de passe MySQL visible dans `ps` ; `Shell mysql` sans port ni tunnel (A09).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 384 |
| Lignes de commentaire | 81 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 54 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 replays (LAURUXCONF-T01 à T10) : ouverture, validation, mauvais mot de passe, création de base
(acceptée/refusée), fermeture modale ou non, premier démarrage, serveur arrêté, tunnel SSH
(faisabilité à confirmer), préfixe. Critères : `Laurux.conf` final et dump des bases. Les `.conf`
de test sont générés avec l'équivalent Python du chiffrement.

## Rework

10 étapes (LAURUXCONF-001 à 010) : documentation du format, code mort, factorisation de `_new` et
des écritures de configuration, helpers transverses `Utils.OuvreBase`, `Utils.BasesLaurux`,
`Utils.ChargeParamSsh`, couleurs par défaut, séparation de `Createbase`. 10 anomalies
(LAURUXCONF-A01 à A10).
