# LauruxConf — Architecture

> Source : `.src/Communs/LauruxConf.class`

## Vue d'ensemble

`LauruxConf` est l'écran **« Configuration de la connexion SQL »**. Il lit et écrit la section
`[dbase]` (et `[dbase/ssh]`) du fichier `~/.config/gambas3/Laurux.conf` (ou du fichier passé par
`-c`, via `Start.LocalSettings`), teste la connexion (avec montage éventuel d'un tunnel SSH), et
**crée une base société** (`Createbase`) à partir de `Laurux01.sql` en initialisant les préférences
par défaut de la société.

Il est ouvert depuis `Fmenu` (`Config()` en modal au premier démarrage ou après erreur,
`Menu166_Click` en non modal), `Cmenu.class:269` et `Caisse/Preferences.class:233`. Sa méthode
`Createbase` est aussi appelée **sur l'auto-instance** par `Fsoc.class:476` et
`Compta/Utils/Dup.class:89` : `_new` s'exécute alors sur un formulaire caché et `Createbase` lit
ses contrôles (`Login`, `Password`, `Host`, `Port`, `Bssh`).

Deux modes de fermeture (`Form_Close`) : en **modal** (configuration initiale), la configuration est
seulement enregistrée ; en **non modal**, Laurux est redémarré (`Start.Restart = True`, fermeture
de la fenêtre principale).

⚠️ `ComboBox1_Click` force le type à `mysql` : la branche SQLite de l'écran est **inatteignable**
depuis la GUI (LAURUXCONF-A01).

## Format de `Laurux.conf` géré par cet écran

Fichier INI `gb.settings`. Les clés sans section (`/Soc`, `/intitule`, `/son`, `/Tips`) sont
rangées dans `[General]`. Extrait conforme à un fichier réel (valeurs d'exemple) :

```ini
[General]
son=0
Tips=1
Soc="01"
intitule="  "

[Societes]
Soc01="3.69"          ; version de la base à la création (Majversion.Version)

[dbase]
type="mysql"          ; "mysql" | "sqlite3" (sqlite3 inatteignable par la GUI)
Prefixe=""            ; préfixe optionnel des bases (<préfixe>_Laurux01)
Name="Laurux01"       ; nom de base SANS préfixe (Utils.glb ajoute Prefixe)
Login="laurux"
Password="2D0D0D0D0D0D" ; chiffré, voir ci-dessous (ici "laurux")
Port="3306"
Host="127.0.0.1"      ; pour sqlite3 : répertoire du fichier .sqlite
Maj=-1                ; migration automatique (LauruxMaj) : -1/1 actif, 0 inactif
backtrace=0
Con-ssh=0             ; lu par Utils.glb et par _new

[dbase/ssh]
Con-ssh=0             ; écrit par Button1_Click, jamais lu (LAURUXCONF-A03)
Login="user"
Hostssh="serveur"
Passwssh="…"          ; chiffré avec la clé "LauruX2012"
Portssh="22"
Portlocal="3307"
Passphrase=""
Passp=0
```

**Chiffrement des mots de passe** (`hexdblKey.Crypt("en", mdp, clé)`) : pour chaque octet `i` du
mot de passe (UTF-8), `octet Xor clé[i mod len(clé)] Xor 13`, puis écriture en hexadécimal
majuscule sur 2 chiffres. Clé `"Laurux"` pour `/dbase/Password` (et `/Soc<XX>/MdpFTP`), clé
`"LauruX2012"` pour `/dbase/ssh/Passwssh`. Équivalent Python, utile aux `.conf` de test de la
phase 2 :

```python
def crypt(mdp, cle="Laurux"):
    k = cle.encode()
    return "".join("%02X" % (c ^ k[i % len(k)] ^ 13) for i, c in enumerate(mdp.encode()))
# crypt("laurux") == "2D0D0D0D0D0D" ; crypt("secret") == "32091B0D1D01"
```

`Createbase` écrit en plus les préférences par défaut de la société (`[Soc<XX>]` : `Entete`,
`Conditions`, `Tva550`, `Codetva`, `Qt1`, `Coul_fen`, `Ctrlstk`, `AutoEnt`, `Font`, `Copie`,
`Siret`, `Prxdec`, `Taxe`, `Pays`, `Impbl`, `nbfam`, `ipr`, `pp`, `bois`) et les couleurs `[Coul]`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Soc` | var | Private |  | String | 32 |
| `intitule` | var | Private |  | String | 33 |
| `son` | var | Private |  | Integer | 34 |
| `Lig` | var | Private |  | String | 35 |
| `rResult` | var | Private |  | Result | 36 |
| `Nouveau` | var | Private |  | Boolean | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 39-173 | Public | 54 | 122 | 0 | méthode spéciale |
| `Button1_Click` | 181-319 | Public | 20 | 107 | 0 | handler GUI |
| `Createbase` | 321-414 | Public | 9 | 86 | 2 |  |
| `Button2_Click` | 416-420 | Public | 1 | 3 | 0 | handler GUI |
| `Form_Close` | 426-468 | Public | 8 | 36 | 0 | handler GUI |
| `Bssh_Click` | 474-482 | Public | 2 | 7 | 0 | handler GUI |
| `Button3_Click` | 487-491 | Public | 1 | 3 | 0 | handler GUI |
| `ComboBox1_Click` | 493-508 | Public | 2 | 14 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** (CC 54, max du fichier) [portée : nécessaire (constructeur)] [nature : mixte].
  Observateurs, centrage, type (`ComboBox1_Click` force `mysql`), filtre `*.sqlite`. Si
  `/Soc<XX>/Prefixe` : affiche `Prefixe`. Si la société n'est pas bloquée (`/Soc<XX>/Blocsoc` faux
  ou vide) : remplit `Nbase` avec les bases Laurux de `Utils.db.Databases` (même règle que
  [`Fsoc.Init_base`](../Fsoc.class/architecture.md)). Puis `Nbase.Text = Prefixe & Name` (défaut
  `Laurux01`, `Nouveau = True`, `Maj` coché), `Login`, `Port` (défaut 3306), `Host` (défaut
  `localhost`) ou racine du `FileChooser1`, `Backtrace`, `Maj` (désactivé si société bloquée),
  mot de passe déchiffré, et paramètres SSH si `/dbase/Con-ssh` ≠ 0. Le **`Catch`** (base
  inaccessible, typiquement `Utils.db.Databases` sans connexion) **recopie** presque tout le bloc
  de lecture (l. 137-169) puis force `Nouveau` et `Maj`. `Nouveau` n'est jamais lu (code mort).
- **`Button1_Click()`** (Valider) [portée : nécessaire (handler)] [nature : mixte].
  1. Écrit `[Societes] Soc<XX> = Majversion.Version` (version de la base courante), puis `type`,
     `Prefixe`, `Login`, `Password` (chiffré), `Port`, `Host`/`Name` (mysql : `Name = Nbase.Text`,
     préfixe compris ; sqlite3 : répertoire et nom du fichier choisi), `Maj`, `backtrace`,
     `[dbase/ssh] Con-ssh` (**clé différente** de celle lue par `Utils.glb`), et les paramètres SSH.
     `Save` + `Reload`.
  2. Paramètre `Utils.db` (type, nom, login, mot de passe) ; avec tunnel : `Host = 127.0.0.1`,
     `Port = Portlocal` et variables `Utils.MysqlServeur`, `RemotePort`, `SshPort`, `SshPassw`,
     `SshHost`, `SshUser`, `SshPassphrase` (copie de `Utils.glb`) ; puis `Utils.monteTunnel()`.
  3. MySQL : `Utils.db.name = Prefixe.Text & Nbase.Text` (préfixe potentiellement doublé,
     LAURUXCONF-A04), `Open`, séquence `SET NAMES` / `Shell mysql … sql_mode` /
     `ALTER DATABASE … COLLATE` / `SET NAMES … COLLATE`. SQLite : ouverture de `<nom>.sqlite`,
     liste des tables sur la sortie standard (`Print`, trace de débogage), `SELECT` sur `TabSoc`.
  4. `If Not Error` (dernier `Try` : `SET NAMES`) : lit `Fiches_Societes` (`Cbase.Table("TabSoc")`,
     `cd_sc = Right$(Nbase.Text, 2)`, **sans test `Available`**), message, `/Soc`, `Save`,
     `Start.Societe`, titre de `Fmenu`. Sinon `Createbase`.
  `Catch` : analyse le texte de l'erreur (`Access denied` → avertissement ; `Unknown database` →
  `Createbase` ; `Can't connect` → avertissement ; sinon `Message.Error`). Textes du pilote
  `gb.db.mysql` en anglais : dépendance à la langue du message.
- **`Createbase(Base, Optional AsCurrent = True) As Boolean`** [portée : nécessaire (`Fsoc`,
  `Dup`)] [nature : mixte]. Question « Le programme va créer la base … ». Si oui : ferme
  `Utils.db`, ouvre une `Connection` MySQL **sans base** avec les identifiants **des contrôles**
  de l'écran, `Databases.Add(Base)` (= `CREATE DATABASE`), écrit `/dbase/Con-ssh`, `/Soc`
  (si `AsCurrent`), `/intitule`, `/son = 0`, `/Tips = 1` et ~40 préférences par défaut (dont
  `/Soc<Start.Societe>/Exp`, `/Lettrage`, `/Impbl` : **société courante** et non nouvelle société,
  LAURUXCONF-A05), `Save` ; puis `Utils.Fill_DataBase("Laurux" & Soc, "Laurux01.sql")` (**nom
  sans préfixe** et retour d'erreur ignoré), réouvre `Utils.db` si besoin, `UPdate
  <Base>.Fiches_Societes SET cd_sc = &1 WHERE cd_sc = 01`, `[Societes] Soc<XX>`, `Reload`,
  `Start.Societe` (si `AsCurrent`), message. Renvoie `True` ; `False` si l'utilisateur refuse.
  Aucun `Catch` : une erreur remonte à l'appelant. `sTemp` inutilisé ; `Qt1` écrit deux fois ;
  `/Coul/Coulfonds` et `/Coul/Others` écrits deux fois (la première valeur est perdue).
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Fermeture.
- **`Form_Close()`** [portée : nécessaire (handler)] [nature : mixte]. Réécrit la configuration
  (`Prefixe`, `Con-ssh`, `type`, `Login`, `Password`, `Port`, `Name` = partie après `_` de
  `Nbase.Text` ou nom entier, `Host`, `Maj`, `backtrace`, paramètres SSH **sans** `Passphrase` ni
  `Passp`) **sans `Save`** (enregistrée plus tard par `Start.LocalSettings`). Si l'écran n'est pas
  modal : `Start.UnLock`, `Utils.fermeTunnel`, `Utils.db.Close`, `Start.Restart = True`, fermeture
  de la fenêtre principale (redémarrage).
- **`Bssh_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Active le cadre SSH.
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Conf")`.
- **`ComboBox1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. **Force** `mysql`, puis
  affiche les cadres MySQL : la branche `Else` (SQLite) est morte.

## État global utilisé

- `Start.LocalSettings` : sections `[dbase]`, `[dbase/ssh]`, `[Societes]`, `[Coul]`, `[Soc<XX>]`,
  clés `/Soc`, `/intitule`, `/son`, `/Tips` ; `Start.Societe`, `Start.Son`, `Start.UnLock`,
  `Start.Restart`, `Start.MainWindow`.
- `Utils.db` (type, nom, hôte, port, login, mot de passe, `Databases`, `Tables`, `Open`/`Close`,
  `Exec`, `Opened`) ; variables de tunnel `Utils.MysqlServeur`, `RemotePort`, `SshPort`,
  `SshPassw`, `SshHost`, `SshUser`, `SshPassphrase` ; `Utils.monteTunnel`, `Utils.fermeTunnel`,
  `Utils.Fill_DataBase`.
- `Majversion.Version` (auto-instance du formulaire `Majversion`), `hexdblKey.Crypt`, `Fmenu.Text`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : extraire la lecture de la configuration dans un helper privé `ChargeConfig()` appelé
  par le corps et par le `Catch` (le bloc est dupliqué à 90 %) ; CC 54 → environ 20.
- `Button1_Click` et `Form_Close` écrivent les mêmes clés avec de petites différences : helper
  privé `EcritConfig(bAvecName)` conservant chaque différence actuelle (clé `ssh/Con-ssh`,
  `Passphrase`, calcul de `Name`).
- `Createbase` : sortir les préférences par défaut dans un helper `PrefsDefaut(sSoc)` ; supprimer
  les doubles écritures sans effet (`Qt1`, premières valeurs de `Coulfonds`/`Others`) et `sTemp`.
- `Nouveau`, `rResult` d'instance, `Lig` d'instance : code mort ou variables locales.

### Commonalisation avec d'autres fichiers

- **Paramètres SSH** (l. 245-251) : copie de `Utils.glb` → `Utils.ChargeParamSsh()` (UTILS-015,
  voir [`Utils.module`](../../Utils/Utils.module/architecture.md)).
- **Séquence de reconnexion MySQL** (l. 274-280) : commune avec
  [`Fsoc`](../Fsoc.class/architecture.md) (`Button4_Click`, `Soclist_Click`) et `Fmenu.class:175`
  → `Utils.OuvreBase(sNom)`.
- **Ligne de commande `mysql`** (l. 278) : helper commun proposé par UTILS-014 (avec
  `Utils.Fill_DataBase`, `Clear_DataBase`, `Create_DataBase`, `ControlTunnel`,
  `Mmysql.Process_List`, [`FRestore`](../FRestore.class/architecture.md) l. 68).
- **Détection des bases Laurux** (l. 58-87) : commune avec `Fsoc.Init_base` et `Dup` →
  `Utils.BasesLaurux(bPrefixe)`.
- **Couleurs par défaut** `[Coul]` (l. 360-379) : aussi écrites par `Start.module` (l. 132-150,
  avec un séparateur `;` au lieu de `,` pour `Coulfonds`/`Others`), `Fmenu.class:437` et
  `Utils/SetColors.class:106`. Helper commun `Prefs.CouleursDefaut()` en conservant les valeurs
  propres à chaque appelant.
- **`Createbase` dépend des contrôles** : pour `Fsoc` et `Dup`, il faudrait une fonction
  `Utils.CreeBaseSociete(sBase, sLogin, sMdp, sHost, sPort)` sans GUI ; la question à l'utilisateur
  resterait dans `Createbase`.

### Réduction de portée

- Aucune : toutes les méthodes `Public` sont des handlers, le constructeur ou `Createbase`
  (appelé par `Fsoc` et `Dup`).

### Séparation traitement / GUI

- `Createbase` : isoler la création + remplissage (`CreeBaseSociete`) de la question et des
  messages.
- `Button1_Click` : isoler `TesteConnexion() As String` (renvoie le code d'erreur) et laisser les
  messages dans le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune modification de schéma n'est liée à cet écran. Une table de paramètres globaux
  (hors `Laurux.conf`) permettrait de partager la configuration entre postes ; hors périmètre.
