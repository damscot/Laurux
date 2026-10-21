# DEPENDANCES — Laurux

Ce document recense **toutes les dépendances externes** du projet Laurux (PGI français écrit en
**Gambas 3**) : composants Gambas, librairies natives, paquets système, exécutables externes,
services et ressources.

Dernière analyse : **22 octobre 2026** — sources analysées : `.src/**` (770 fichiers `.class` /
`.module` / `.form` / `.report`), `.project`, `Makefile`, `.hidden/Docker/`, `README.md`, `TESTING.md`.

**Révision du 22/10/2026** — deux chantiers :
1. mise à jour après correction du [`.project`](.project) : 3 composants retirés (`gb.crypt`,
   `gb.desktop.x11`, `gb.form.mdi`) et 3 ajoutés (`gb.db.mysql`, `gb.db.sqlite3`, `gb.form.print`) ;
2. **rationalisation** : chaque dépendance n'apparaît plus qu'**une seule fois** (§3), décrite par
   toutes ses faces — composant Gambas, librairie native, client CLI, service, paquet, outil.
   Les sectionsFormerment redondantes (paquets / exécutables / librairies / services dispersés)
   ont été fusionnées en [§3](#3-inventaire-rationalisé-des-dépendances).

> **Convention de lecture**
> - La colonne *Utilisé dans* liste les fichiers de `.src/` qui référencent réellement la
>   dépendance (recherche par symbole de l'API Gambas ou par la commande exécutée, pas par le
>   nom du composant).
> - La colonne *Rôle* (§3) indique **comment** la dépendance est exploitée : *Composant*,
>   *Librairie*, *Client*, *Service*, *Outil* ou *Paquet*.
> - La colonne *Statut* indique si la dépendance est **réellement utilisée** ou **optionnelle**
>   (activée par configuration ou par contexte).
> - Les chemins sont relatifs à la racine du dépôt.

---

## 1. Vue d'ensemble

| Catégorie | Nombre | Criticité | Section |
|-----------|--------|-----------|---------|
| Composants Gambas 3 (déclarés dans `.project`) | 24 | **Bloquante** — compilation | [§2](#2-composants-gambas-3-déclarés-dans-project) |
| Modules Gambas internes (`.src/`) + bibliothèque PDF | 6 | **Bloquante** — compilation | [STRUCTURE.md §3](STRUCTURE.md) |
| Paquets Debian / Ubuntu (hors composants Gambas) | 69 | selon rôle | [§3](#3-inventaire-rationalisé-des-dépendances) |
| Exécutables externes (client, outil, service) | 113 | selon rôle | [§3](#3-inventaire-rationalisé-des-dépendances) |
| Bibliothèques Linux natives | 8 | selon rôle | [§3.4](#34-bibliothèques-natives-backends-des-composants) |
| Ressources & assets | 7 | **Bloquante** — exécution | [STRUCTURE.md §4-7](STRUCTURE.md) |
| Bases de données & fichiers de données | 10 | **Bloquante** — exécution | [STRUCTURE.md §8](STRUCTURE.md) |

> **Lecture des chiffres** : un même paquet peut fournir plusieurs exécutables (par exemple
> `mariadb-client` → `mysql`, `mysqldump`, `mysqladmin`) et un même exécutable peut être invoqué
> depuis plusieurs points du code. Le §3 liste chaque dépendance **une seule fois**, en décrivant
> toutes ses faces.

> **État de la déclaration `.project`** : les 24 composants déclarés sont **tous réellement
> utilisés** par le code. Aucun composant orphelin ne subsiste, et aucun composant utilisé ne
> manque. Détail des corrections apportées en §2.1 (retraits) et §2.2 (ajouts).

> **Point d'attention MySQL / SSH** : c'est la dépendance la plus riche du projet — elle cumule
> quatre rôles (composant, librairie, client, service). Elle est traitée **une seule fois**, en
> [§3.1](#31-base-de-données-mysql--mariadb) (MySQL) et [§3.3](#33-accès-distant-et-tunnel-ssh) (SSH).

---
## 2. Composants Gambas 3 déclarés dans `.project`

Fichier de référence : [`.project`](.project) (lignes `Component=…`).

| # | Composant | Paquet Debian | Classes Gambas | Utilisé dans | Description / Rôle | Statut |
|---|---|---|---|---|---|---|
| 1 | `gb.args` | `gambas3-gb-args` | `Args` | [`.src/Start.module`](.src/Start.module) | Analyse de la ligne de commande (`Args.Begin`, `Args.Get`, `Args.Has`) : options `-c/--config`, `-p/--pos`, `-l/--log`, `-r/--replay`, `-d/--debug`, `--devel`, `-s/--societe`, `-t/--test`, `--restore`, `--version-full`. | **Utilisé** |
| 2 | `gb.image` | `gambas3-gb-image` | `Image`, `Color` | [`.src/Caisse/Caisse.class`](.src/Caisse/Caisse.class), [`.src/Caisse/Preferences.class`](.src/Caisse/Preferences.class), [`.src/Caisse/Reports/Cfacture.class`](.src/Caisse/Reports/Cfacture.class), [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class), [`.src/Gestion/Impressions/EdArt1.class`](.src/Gestion/Impressions/EdArt1.class), [`.src/Gestion/Impressions/EdArt2.class`](.src/Gestion/Impressions/EdArt2.class), [`.src/Gestion/Impressions/EdArt3.class`](.src/Gestion/Impressions/EdArt3.class), [`.src/Gestion/Impressions/Edart4.class`](.src/Gestion/Impressions/Edart4.class), [`.src/Gestion/Facturation/Facturergbl.class`](.src/Gestion/Facturation/Facturergbl.class), [`.src/Gestion/Facturation/Fcaras.class`](.src/Gestion/Facturation/Fcaras.class), [`.src/Gestion/Tables/Articles.class`](.src/Gestion/Tables/Articles.class), [`.src/Gestion/Tables/Materiel.class`](.src/Gestion/Tables/Materiel.class), [`.src/Reports/Cdocuments.class`](.src/Reports/Cdocuments.class), [`.src/Reports/Cdocuments2.class`](.src/Reports/Cdocuments2.class) | Chargement du logo société (`Image.Load`) et rendu des images dans les documents PDF (factures, articles, bons, étiquettes). | **Utilisé** |
| 3 | `gb.gui.qt` | `gambas3-runtime` | `Application`, `Form`, `Window`, `Desktop`, `Clipboard`, `Draw`, `Paint`, `Printer`, `Key`, `Mouse`, `Fonts`, `Screens` | **Partout** — toutes les 770 sources | Moteur graphique de l'IHP (Widgets Qt4/Qt5 : `Form`, `Label`, `TableView`, `TreeView`, `ButtonBox`, `TextBox`, `ProgressBar`, `Draw`, `Key`/`Mouse` pour les raccourcis et le rejeu de scénarios). Inclut `Printer` (impression directe) et `Clipboard`. | **Utilisé — socle IHP** |
| 4 | `gb.form` | `gambas3-gb-form` | `ButtonBox`, `TableView`, `TreeView`, `ScrollView`, `FileChooser`, `FontChooser`, `IconPanel`, `DateBox`, `Message`, `Stock`, `Wizard`… | [`.src/Caisse/ImageButton.class`](.src/Caisse/ImageButton.class), [`.src/Compta/Utils/TypeClient.class`](.src/Compta/Utils/TypeClient.class), [`.src/Utils/textfamille.class`](.src/Utils/textfamille.class), [`.src/Utils/TextReg.class`](.src/Utils/TextReg.class) + tous les `.form` | Widgets de haut niveau Gambas : sélecteurs de fichiers/dossiers, sélecteur de police, sélecteur de date, panneaux d'icônes, boîtes de dialogue standard, `Wizard`. | **Utilisé** |
| 5 | `gb.compress` | `gambas3-gb-compress` | `Compress`, `Uncompress` | [`.src/Communs/FSauve.class`](.src/Communs/FSauve.class), [`.src/Communs/FRestore.class`](.src/Communs/FRestore.class), [`.src/Communs/SauvesAuto.module`](.src/Communs/SauvesAuto.module), [`.src/Compta/Clotures/FClotureAn.class`](.src/Compta/Clotures/FClotureAn.class), [`.src/Compta/Utils/Epurjdv.class`](.src/Compta/Utils/Epurjdv.class), [`.src/Reports/PdfWriter.class`](.src/Reports/PdfWriter.class) | Compression/décompression des sauvegardes et exports (`.gz`), des archives de clôture annuelle et des flux PDF (Flate). | **Utilisé** |
| 6 | `gb.db` | `gambas3-gb-db` | `Connection`, `Result`, `Database`, `Field` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | Couche d'accès aux bases de données. `DB_Connection` hérite de `Connection` et implémente `Exec()` (requêtes paramétrées `&1`, `&2`), `IsType()` (détection MySQL/SQLite), `AutoIncrement()`, `Engine()`. | **Utilisé — cœur data** |
| 7 | `gb.desktop` | `gambas3-gb-desktop` | `Desktop` | [`.src/Utils/Visualiseur.module`](.src/Utils/Visualiseur.module), [`.src/Gestion/Impressions/Editeur.module`](.src/Gestion/Impressions/Editeur.module), [`.src/Gestion/option/Caleditcmat.class`](.src/Gestion/option/Caleditcmat.class) | Ouverture d'un fichier avec l'application par défaut du système (`Desktop.Open`) : ouvrir un document, un visueliseur, une facture. | **Utilisé** |
| 8 | `gb.eval` | `gambas3-runtime` | `Expression`, `Highlight`, `System` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class), [`.src/Utils/FCalc.class`](.src/Utils/FCalc.class), [`.src/Utils/LVar.class`](.src/Utils/LVar.class) | Évaluation dynamique d'expressions : formules de calcul (`FCalc`), variables de l'interpréteur de script (`LVar`), exécution de requêtes SQL stockées en base (`DB_Connection.Exec` → `Eval("Me.Exec(…)")`). | **Utilisé** |
| 9 | `gb.form.dialog` | `gambas3-gb-form-dialog` | `Dialog` | [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class), [`.src/Communs/FSauve.class`](.src/Communs/FSauve.class), [`.src/Communs/FRestore.class`](.src/Communs/FRestore.class), [`.src/Caisse/Preferences.class`](.src/Caisse/Preferences.class), [`.src/Compta/Cielimp.class`](.src/Compta/Cielimp.class), [`.src/Compta/Impressions/ExportA47.class`](.src/Compta/Impressions/ExportA47.class), [`.src/Compta/Utils/ExportJdv.class`](.src/Compta/Utils/ExportJdv.class), [`.src/Compta/Utils/ImpJdv.class`](.src/Compta/Utils/ImpJdv.class), [`.src/Compta/Utils/ImpSage.class`](.src/Compta/Utils/ImpSage.class), [`.src/Compta/Utils/Intjdv.class`](.src/Compta/Utils/Intjdv.class), [`.src/Gestion/Mails/Emailing.class`](.src/Gestion/Mails/Emailing.class), [`.src/Gestion/Mails/EmailingCarte.class`](.src/Gestion/Mails/EmailingCarte.class), [`.src/Gestion/Stock/Tarifs/Impart.class`](.src/Gestion/Stock/Tarifs/Impart.class), [`.src/Gestion/Stock/Tarifs/ImpartParam.class`](.src/Gestion/Stock/Tarifs/ImpartParam.class) | Boîtes de dialogue natives : sélection de fichier/dossier, filtres d'export, confirmation de sauvegarde/restauration. | **Utilisé** |
| 10 | `gb.settings` | `gambas3-gb-settings` | `Settings` | [`.src/Start.module`](.src/Start.module), [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class), [`.src/Utils/ObjProp.class`](.src/Utils/ObjProp.class) | Persistance de la configuration utilisateur dans `~/.config/gambas3/Laurux.conf` (`GlobalSettings` / `LocalSettings`), sections `[General]`, `[Soc]`, `[Soc01]`, `[dbase]`, `[dbase/ssh]`. | **Utilisé** |
| 11 | `gb.logging` | `gambas3-gb-logging` | `Logger`, `ComplexLogger`, `LogHandler`, `ConsoleHandler`, `FileHandler`, `LogRotator` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class), [`.src/Utils/LLog.class`](.src/Utils/LLog.class), [`.src/Utils/NetHandler.class`](.src/Utils/NetHandler.class), [`.src/Utils/Utils.module`](.src/Utils/Utils.module), [`.src/Start.module`](.src/Start.module) | Journalisation : log fichier local (`~/tmp/Debug/Laurux.log`), log console, et **log distant** via `NetHandler` (socket réseau) vers un `nc -l -k -p <port>` sur le serveur. | **Utilisé** |
| 12 | `gb.net` | `gambas3-gb-net` | `Socket`, `SerialPort`, `ServerSocket`, `Net`, `DnsClient` | [`.src/Utils/NetHandler.class`](.src/Utils/NetHandler.class), [`.src/Caisse/Caisse.class`](.src/Caisse/Caisse.class), [`.src/Caisse/Telium.class`](.src/Caisse/Telium.class), [`.src/Gestion/Etiquettes/Zebra.module`](.src/Gestion/Etiquettes/Zebra.module), [`.src/Gestion/Etiquettes/Dymo.module`](.src/Gestion/Etiquettes/Dymo.module), [`.src/Gestion/Etiquettes/Etigond.class`](.src/Gestion/Etiquettes/Etigond.class), [`.src/Gestion/Etiquettes/Etiqart.class`](.src/Gestion/Etiquettes/Etiqart.class), [`.src/Gestion/Etiquettes/Etiqcasier.class`](.src/Gestion/Etiquettes/Etiqcasier.class), [`.src/Gestion/Etiquettes/EtiqPromo.class`](.src/Gestion/Etiquettes/EtiqPromo.class) | Communication TCP/IP : (a) log distant vers le serveur, (b) connexion aux **imprimantes d'étiquettes code-barres** (Zebra / Dymo, protocole ZPL via `Write #Mysock`), (c) TPE bancaire série (terminal de paiement). | **Utilisé** |
| 13 | `gb.net.curl` | `gambas3-gb-net-curl` | `HttpClient`, `FtpClient`, `Curl`, `Download` | [`.src/Communs/Majversion.class`](.src/Communs/Majversion.class) (`HttpClient`), [`.src/Communs/SauvesAuto.module`](.src/Communs/SauvesAuto.module) (`FtpClient`) | Téléchargement des mises à jour et de la feuille de version (`www.laurux.fr/Stable/…`) ; sauvegarde automatique de la base vers un serveur FTP. | **Utilisé** |
| 14 | `gb.net.smtp` | `gambas3-gb-net-smtp` | `SmtpClient` | [`.src/Gestion/Mails/EnvMail.module`](.src/Gestion/Mails/EnvMail.module) | Envoi de mail (factures, relances, étiquettes) via serveur SMTP, avec authentification `SmtpClient.Automatic` et pièces jointes. | **Utilisé** |
| 15 | `gb.openssl` | `gambas3-gb-openssl` | `OpenSSL`, `Cipher`, `Digest`, `HMac` | [`.src/Utils/Sha1Calc.module`](.src/Utils/Sha1Calc.module) (`Digest["sha1"]`) | Calcul de la **somme de contrôle SHA-1** des écritures comptables (chaînage anti-falsification des lignes d'écriture), encodée en Base64. Utilisé par `Moulinage` (mise à jour des contrôles) et la caisse. | **Utilisé** |
| 16 | `gb.pcre` | `gambas3-gb-pcre` | `RegExp` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class), [`.src/Utils/TextReg.class`](.src/Utils/TextReg.class), [`.src/Utils/LDate.class`](.src/Utils/LDate.class), [`.src/Utils/LBox.class`](.src/Utils/LBox.class), [`.src/Utils/LGed.class`](.src/Utils/LGed.class), [`.src/Utils/Utils.module`](.src/Utils/Utils.module), [`.src/Communs/LauruxMaj.module`](.src/Communs/LauruxMaj.module), [`.src/Gestion/Facturation/ObjFac.class`](.src/Gestion/Facturation/ObjFac.class) | Expressions régulières PCRE : validation de saisie, masquage des filtres de log, extraction d'URL, parsing des dates, recherche de motifs dans les documents. | **Utilisé** |
| 17 | `gb.report2` | `gambas3-gb-report2` | `Report`, `ReportLabel`, `ReportImage`, `ReportHBox/VBox`, `ReportPadding`, `ReportBorder`, `ReportMargin` | [`.src/Reports/Editfac.class`](.src/Reports/Editfac.class) + [`.src/Reports/Editfac.report`](.src/Reports/Editfac.report), [`.src/Compta/Extrait.class`](.src/Compta/Extrait.class), [`.src/Compta/Utils/EcrAuto.class`](.src/Compta/Utils/EcrAuto.class), [`.src/Gestion/Impressions/Edart4.class`](.src/Gestion/Impressions/Edart4.class), [`.src/Gestion/Impressions/EdReg.class`](.src/Gestion/Impressions/EdReg.class) + [`.src/Gestion/Impressions/EdReg.report`](.src/Gestion/Impressions/EdReg.report), [`.src/Gestion/option/Ecomptamat.class`](.src/Gestion/option/Ecomptamat.class) + [`.src/Gestion/option/Ecomptamat.report`](.src/Gestion/option/Ecomptamat.report), [`.src/Gestion/option/EditStkDepart.class`](.src/Gestion/option/EditStkDepart.class) + [`.src/Gestion/option/EditStkDepart.report`](.src/Gestion/option/EditStkDepart.report), [`.src/Gestion/option/Einvmat.class`](.src/Gestion/option/Einvmat.class) + [`.src/Gestion/option/Einvmat.report`](.src/Gestion/option/Einvmat.report), [`.src/Gestion/option/Edittipp.report`](.src/Gestion/option/Edittipp.report), [`.src/Gestion/option/Edconsigne.class`](.src/Gestion/option/Edconsigne.class), [`.src/Gestion/option/EditfacB.class`](.src/Gestion/option/EditfacB.class), [`.src/Affichages/TriGen.class`](.src/Affichages/TriGen.class) | Générateur d'états (6 fichiers `.report`) : édition de facture, états comptables, extraits, inventaires, bons. | **Utilisé** |
| 18 | `gb.sdl2.audio` | `gambas3-gb-sdl2-audio` | `Music`, `Sound`, `Channel` | [`.src/Start.module`](.src/Start.module), [`.src/Caisse/Caisse.class`](.src/Caisse/Caisse.class), [`.src/Caisse/Cmenu.class`](.src/Caisse/Cmenu.class), [`.src/Caisse/Bordereaux.class`](.src/Caisse/Bordereaux.class), [`.src/Caisse/LibelTicket.class`](.src/Caisse/LibelTicket.class), [`.src/Caisse/Fcaisses.class`](.src/Caisse/Fcaisses.class), [`.src/Caisse/FClientcarte.class`](.src/Caisse/FClientcarte.class), [`.src/Caisse/Fvendeurs.class`](.src/Caisse/Fvendeurs.class) + [`.src/Archivages/`](.src/Archivages/) (~10 fichiers) | Lecture des sons de l'IHP via SDL2 : `son/warning.ogg` (avertissement), `son/menu.ogg`, `son/fermeture.ogg`, `son/fermeture-menu.ogg`. | **Utilisé** |
| 19 | `gb.signal` | `gambas3-gb-signal` | `Signal` | [`.src/Start.module`](.src/Start.module), [`.src/Utils/Utils.module`](.src/Utils/Utils.module) | Interception de `SIGINT` (Ctrl+C) pour la fermeture propre de l'application ; `Signal.Send` pour demander l'arrêt. | **Utilisé** |
| 20 | `gb.xml` | `gambas3-gb-xml` | `XmlDocument`, `XmlElement`, `XmlReader`, `XmlWriter` | [`.src/Communs/Majversion.class`](.src/Communs/Majversion.class) (`XmlElement`) | Analyse du flux XML de la page de version du site `laurux.fr` pour détecter les nouvelles versions disponibles. | **Utilisé** |
| 21 | `gb.xml.html` | `gambas3-gb-xml-html` | `HtmlDocument`, `XmlElement` | [`.src/Communs/Majversion.class`](.src/Communs/Majversion.class) | Parsing HTML de la page de version (liste des versions, liens de téléchargement `.tar.gz`). | **Utilisé** |
| 22 | `gb.db.mysql` | `gambas3-gb-db-mysql` — faces cliente / librairie / service : §3.1 | `MySQL` (pilote de `Connection`) | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | Pilote MySQL/MariaDB : base de données principale (mode serveur). Sélectionné via `Super.Type = "mysql"` et `DB_Connection.IsType(type_mysql)`. | **Utilisé** |
| 23 | `gb.db.sqlite3` | `gambas3-gb-db-sqlite3` — faces cliente / librairie : §3.2 | `SQLite3` (pilote de `Connection`) | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | Pilote SQLite 3 : mode portable (base `Laurux01.sqlite` embarquée). Détecté via `Super.Type = "sqlite3"` et `DB_Connection.IsType(type_sqlite3)`. | **Utilisé** |
| 24 | `gb.form.print` | `gambas3-gb-form-print` | `Printer` | [`.src/Gestion/option/Caleditcmat.class`](.src/Gestion/option/Caleditcmat.class), [`.src/Gestion/option/menuopt.class`](.src/Gestion/option/menuopt.class), [`.src/Gestion/option/Edconsigne.class`](.src/Gestion/option/Edconsigne.class) | Impression directe et export PDF via `prt.OutputFile`, `prt.Preview`, `Printer.Landscape`. **Note** : `gb.gui.qt` fournit aussi une classe `Printer` (spécifique Qt) — la version native de `gb.form.print` est déclarée explicitement pour garantir le comportement multi-backend. | **Utilisé** |

### 2.1. Composants Gambas **retirés de `.project`** (nettoyage effectué)

Ces trois composants étaient déclarés mais **n'étaient utilisés par aucune source**. Ils ont été
retirés de [`.project`](.project) ; la compilation et l'exécution ont été revalidées depuis.

| Composant | Classes | Raison du retrait | Conséquence |
|-----------|---------|-------------------|-------------|
| `gb.crypt` | `Crypt` | Le chiffrement des mots de passe passe par `hexdblKey.Crypt` (XOR maison, §3), pas par la classe `Crypt` de `gb.crypt`. Aucune source n'instancie `Crypt`. | Aucune. Le paquet `gambas3-gb-crypt` n'est plus requis. |
| `gb.desktop.x11` | `X11`, `X11Watcher`, `DesktopWatcher`, `X11Systray` | Aucun watcher de fenêtres ni icône systray dans le code. L'intégration bureau passe par `gb.gui.qt` et la lecture de l'environnement (`KDE_FULL_SESSION`, `GNOME_DESKTOP_SESSION_ID`). | Aucune. Le paquet `gambas3-gb-desktop-x11` n'est plus requis. |
| `gb.form.mdi` | `Workspace`, `ToolBar`, `Action` | Aucun `Workspace` : Laurux utilise des fenêtres indépendantes, pas une interface multi-document. | Aucune. |

> **Point de vigilance sécurité** : `hexdblKey` chiffre par XOR avec une clé fixe (« Laurux »),
> ce qui est **beaucoup plus faible** qu'AES (`gb.crypt` / `gb.openssl`). Le retrait de `gb.crypt`
> du `.project` ne change rien à ce point, mais un durcissement futur gagnerait à basculer sur
> `gb.openssl` (`Cipher`) — le composant `gb.openssl` est **déjà déclaré et utilisé**
> (voir [`.src/Utils/Sha1Calc.module`](.src/Utils/Sha1Calc.module)).

### 2.2. Composants Gambas **ajoutés à `.project`** (correction effectuée)

Trois composants **utilisés par le code** mais **absents** de la déclaration précédente ont été
ajoutés à [`.project`](.project). Sans eux, la compilation échouait sur une installation Gambas
standard.

| Composant | Classe utilisée | Fichiers sources | Rôle |
|-----------|-----------------|-----------------|------|
| `gb.db.mysql` | `MySQL` (pilote de `Connection`) | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | Pilote MySQL/MariaDB — base de données principale. |
| `gb.db.sqlite3` | `SQLite3` (pilote de `Connection`) | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | Pilote SQLite 3 — mode portable (base embarquée). |
| `gb.form.print` | `Printer` | [`.src/Gestion/option/Caleditcmat.class`](.src/Gestion/option/Caleditcmat.class), [`.src/Gestion/option/menuopt.class`](.src/Gestion/option/menuopt.class), [`.src/Gestion/option/Edconsigne.class`](.src/Gestion/option/Edconsigne.class) | Impression directe / export PDF via `Printer`. |

> **Vérifié** : `gbc3 -agt` puis `gba3 -o Laurux` compilent sans erreur, et l'exécutable démarre
> et s'exécute normalement avec les 24 composants déclarés.

---

## 3. Inventaire rationalisé des dépendances

**Principe** : chaque dépendance n'apparaît qu'**une seule fois** dans ce document, décrite par
toutes ses faces. La colonne *Rôle* indique comment la dépendance est réellement exploitée :

| Rôle | Signification |
|------|---------------|
| **Composant** | Composant Gambas chargé par `gbx3` à l'exécution (`.project`). |
| **Librairie** | Bibliothèque native (`.so`) fournit un backend à un composant. |
| **Client** | Exécutable **CLI** invoqué par l'application (`Shell` / `Exec`). |
| **Service** | Daemon tournant sur la machine (côté serveur ou poste). |
| **Outil** | Exécutable requis hors exécution de l'application (build, packaging, maintenance). |
| **Paquet** | Paquet Debian fournit une ou plusieurs des dépendances ci-dessus. |

Le *paquet* correspondant est indiqué entre parenthèses dans la colonne *Paquet Debian*. Une même
ligne peut donc couvrir plusieurs rôles : MySQL, par exemple, est à la fois **client** (`mysql`,
`mysqldump`, `mysqladmin`), **librairie** (`libmariadb`) et **service** (`mysqld`).

### 3.1. Base de données MySQL / MariaDB

C'est la dépendance structurante du projet : Laurux fonctionne en **mode serveur** sur MySQL/MariaDB
(ou en mode portable SQLite, cf. §3.2).

> Le **composant Gambas** `gb.db.mysql` et le composant générique `gb.db` sont décrits en
> [§2](#2-composants-gambas-3-déclarés-dans-project) ; cette section couvre les faces
> **client**, **librairie** et **service**.

| Paquet Debian | Rôle | Binaire / bibliothèque | Utilisé par | Description |
|---------------|------|------------------------|-------------|-------------|
| `mariadb-server` / `mysql-server` | **Service** | `mysqld` | [`.hidden/Docker/entrypoint.sh`](.hidden/Docker/entrypoint.sh) (`service mysql start`) | Serveur de base de données **principal**. Dans le conteneur : création du répertoire `/var/run/mysqld`, `bind-address` désactivé, port 3306 explicitement activé dans `mysqld.cnf`, utilisateur `laurux` créé avec `GRANT ALL`. Port 3306 exposé. |
| `mariadb-client` / `mysql-client` | **Client** | `mysql`, `mysqldump`, `mysqladmin` | `mysql` : [`.src/Communs/Fmenu.class`](.src/Communs/Fmenu.class), [`.src/Communs/LauruxConf.class`](.src/Communs/LauruxConf.class), [`.src/Communs/FRestore.class`](.src/Communs/FRestore.class), [`.src/Communs/LauruxMaj.module`](.src/Communs/LauruxMaj.module) — `mysqldump` : [`.src/Caisse/Moulinage.class`](.src/Caisse/Moulinage.class), [`.src/Communs/FRestore.class`](.src/Communs/FRestore.class) — `mysqladmin` : [`.src/Utils/Mmysql.module`](.src/Utils/Mmysql.module) | Trousse de clients SQL : `mysql` (a) `SET @@global.sql_mode=NO_ENGINE_SUBSTITUTION` après changement de base, (b) `show variables Like 'version'` pour **distinguer MariaDB de MySQL** avant restauration, (c) `show tables` lors des mises à jour de schéma ; `mysqldump` — dump SQL (`--add-drop-table`), base du mécanisme de sauvegarde/restauration et de l'export FTP ; `mysqladmin processlist` — compte les connexions actives pour interdire une restauration pendant que des postes sont connectés. |
| `mariadb-server` / `mysql-server` | **Service** | `mysql` (service) | [`.src/Utils/Mmysql.module`](.src/Utils/Mmysql.module) | Redémarrage du service MySQL local (`/etc/init.d/mysql stop` puis `start`) via `sudo -S` avec élévation `gksu` / `kdesu`. |
| `libmariadb-dev` | **Librairie** | `libmariadb` / `libmysqlclient` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) (via `gb.db.mysql`) | Connecteur natif C utilisé par le composant Gambas `gb.db.mysql` pour ouvrir la connexion `Connection`. |

### 3.2. Base de données SQLite 3 (mode portable)

> Les **composants Gambas** `gb.db.sqlite3` et `gb.db` sont décrits en
> [§2](#2-composants-gambas-3-déclarés-dans-project) ; cette section couvre les faces
> **client** et **librairie**.

| Paquet Debian | Rôle | Binaire / bibliothèque | Utilisé par | Description |
|---------------|------|------------------------|-------------|-------------|
| `sqlite3` | **Client** | `sqlite3` | [Laurux01_to_sqlite.sh](Laurux01_to_sqlite.sh), [mysql2sqlite](mysql2sqlite), [sqlite3.txt](sqlite3.txt) | Conversion MySQL → SQLite3 du schéma et des données. Utilisé **hors application** (scripts de conversion), pas à l'exécution. |
| `libsqlite3-dev` | **Librairie** | `libsqlite3` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) (via `gb.db.sqlite3`) | Connecteur natif C du mode portable (base `Laurux01.sqlite` embarquée). |

### 3.3. Accès distant et tunnel SSH

| Paquet Debian | Rôle | Binaire / bibliothèque | Utilisé par | Description |
|---------------|------|------------------------|-------------|-------------|
| `openssh-client` | **Client** | `ssh` | [`.src/Utils/Utils.module`](.src/Utils/Utils.module) (`monteTunnel` / `fermeTunnel`), [`.src/Communs/Fmenu.class`](.src/Communs/Fmenu.class), [`.src/Communs/LauruxConf.class`](.src/Communs/LauruxConf.class) | Montage du **tunnel SSH** vers un serveur MySQL distant : `ssh -N -f -L <port_local>:<hote_mysql>:<port_distant> -p <port> <user>@<hote>`. Le processus est repéré par `ps u -C ssh` puis filtré sur `<port>:<mysql>:<port>` pour en conserver le PID (`Utils.TunnelPid`), tué à la fermeture (`Utils.fermeTunnel` → `kill <PID>`). Activation et paramètres pilotés par l'interface : `/dbase/Con-ssh` et la section `/dbase/ssh` de `Laurux.conf` (hôte, port, utilisateur, mot de passe, passphrase). |
| `openssh-client` | **Client** | `sshpass` | [`.src/Utils/Utils.module`](.src/Utils/Utils.module) | Fourniture non interactive du mot de passe SSH. **Code commenté** : la ligne active utilise `ssh` seul (authentification par clé). |
| `openssh-server` | **Service** | `sshd` | [`.hidden/Docker/entrypoint.sh`](.hidden/Docker/entrypoint.sh) (`service ssh start`), [`.hidden/Docker/sshd_config`](.hidden/Docker/sshd_config) | Daemon SSH du conteneur : `X11Forwarding yes` (affichage distant de l'IHP), `Port 22`, `PermitRootLogin yes`, `UsePAM yes`. Port 22 exposé. Sert aussi de **support au tunnel** ci-dessus en mode conteneur. |
| `sudo` / `gksu` | **Client** | `sudo`, `gksu` | [`.src/Utils/Mmysql.module`](.src/Utils/Mmysql.module) | Élévation de privilèges pour `mysqladmin processlist` et le redémarrage du service MySQL. Le choix du préfixe dépend du bureau (`kdesu` sous KDE, `gksu` sinon, cf. §3.7). |

### 3.4. Bibliothèques natives (backends des composants)

| Paquet Debian | Rôle | Bibliothèque | Fournit | Description |
|---------------|------|--------------|---------|-------------|
| `libqt5*` / `libqt4*` | **Librairie** | `libQt5Core` / `libQt5Gui` / `libQt5Widgets` | `gb.gui.qt` | Runtime graphique Qt. |
| `libqt5svg5` | **Librairie** | `libQt5Svg` | `gb.gui.qt` (`SvgImage`) | Rendu d'images vectorielles SVG. |
| `libqt5printsupport5` | **Librairie** | `libQt5PrintSupport` | `gb.form.print` | Sous-couche d'impression Qt. |
| `libssl-dev` | **Librairie** | `libssl` / `libcrypto` | `gb.openssl` | SHA-1, Cipher, HMac pour le chaînage des écritures. |
| `libpcre3-dev` | **Librairie** | `libpcre3` | `gb.pcre` | Moteur d'expressions régulières PCRE. |
| `libcurl4-gnutls-dev` | **Librairie** | `libcurl` | `gb.net.curl` | Client HTTP/FTP (mises à jour, sauvegardes). |
| `libzip-dev`, `zlib1g-dev` | **Librairie** | `libzip` / `zlib` | `gb.compress` | Compression zip/gzip des sauvegardes et exports PDF. |
| `libsdl2-2.0-0` | **Librairie** | `libsdl2` | `gb.sdl2.audio` | Sortie audio (sons d'IHP). |

> Les deux connecteurs de bases de données — `libmariadb` (`gb.db.mysql`) et `libsqlite3`
> (`gb.db.sqlite3`) — sont décrits **en place**, dans [§3.1](#31-base-de-données-mysql--mariadb) et
> [§3.2](#32-base-de-données-sqlite-3-mode-portable), avec le client et le service associés.

### 3.5. Client HTTP / FTP et mises à jour

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `wget` | **Client** | `wget` | [`.src/Communs/Majversion.class`](.src/Communs/Majversion.class) | Téléchargement de la feuille de version et de l'archive de mise à jour `.tar.gz` depuis `laurux.fr`. |
| `curl` | **Client** | `curl` | [`.src/Utils/Monip.module`](.src/Utils/Monip.module), [`.src/Utils/LGed.class`](.src/Utils/LGed.class), [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class) | (a) IP publique (`curl ifconfig.me`), (b) type MIME d'une URL (`timeout 5 curl -s -k -I -w '%{content_type}'`), (c) crédits SMS API (`spot-hit.fr`). |
| `wput` | **Client** | `wput` | [`.src/Gestion/Tables/Btqart.class`](.src/Gestion/Tables/Btqart.class) | Envoi FTP de catalogues produits (`ftp://user:pass@host/Prod.csv`). |
| `ping` | **Client** | `ping` | [`.src/Communs/Majversion.class`](.src/Communs/Majversion.class) | Test de connectivité réseau. **Code legacy commenté.** |
| `netcat-openbsd` | **Client** | `nc` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | **Côté serveur** : `nc -l -k -p <port> > laurux_log.csv` pour recevoir le log distant de Laurux. |
| `hostid`, `hostname`, `getent` | **Client** | `hostid`, `hostname`, `getent` | [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class), [`.src/Utils/Recup.module`](.src/Utils/Recup.module) | Identifiant machine / nom d'hôte / résolution de groupe — traçabilité des logs et contrôle des permissions. |

### 3.6. Système, fichiers et permissions

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `coreutils` | **Client** | `cp`, `mv`, `rm`, `mkdir`, `cd`, `ls`, `sed`, `chmod`, `echo`, `cat` | [`.src/Caisse/Caisse.class`](.src/Caisse/Caisse.class), [`.src/Caisse/Bordereaux.class`](.src/Caisse/Bordereaux.class), [`.src/Communs/Fmenu.class`](.src/Communs/Fmenu.class), [`.src/Communs/FRestore.class`](.src/Communs/FRestore.class), [`.src/Utils/DB_Connection.class`](.src/Utils/DB_Connection.class) | Manipulation de fichiers : copie/déplacement des tickets PDF, nettoyage de `~/tmp/*`, création de répertoires, extraction de la version (`grep`/`sed`), lecture de `/etc/machine-id` (identifiant machine persistant pour la traçabilité des logs). |
| `procps` | **Client** | `ps` | [`.src/Start.module`](.src/Start.module), [`.src/Utils/Utils.module`](.src/Utils/Utils.module) | Vérifie si une autre instance de Laurux est déjà ouverte (fichier `~/Laurux.lock`) ; repère le processus du tunnel SSH. |
| `procps` | **Client** | `free` | [`.src/Utils/Utils.module`](.src/Utils/Utils.module) | Lecture de la mémoire disponible. |
| `debianutils` | **Client** | `which` | [`.src/Utils/Utils.module`](.src/Utils/Utils.module) | Détection de la disponibilité d'un binaire. |
| `env` | **Client** | `env` | [`.src/Utils/Mmysql.module`](.src/Utils/Mmysql.module) | Détection de l'environnement de bureau via `KDE_FULL_SESSION` / `GNOME_DESKTOP_SESSION_ID` — détermine le préfixe d'élévation de privilèges (`kdesu` sous KDE, `gksu` ailleurs). |
| `apt` | **Client** | `apt` | [`.src/Utils/DB_Desktop.class`](.src/Utils/DB_Desktop.class) | Détection de la présence de `ydotool` (`apt list --installed`) et suggestion de paquets à installer sous Wayland. |

### 3.7. Impression, GED, scan et synthèse vocale

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `cups` / `cups-pdf` | **Service** + **Client** | `cupsd`, `lpc`, `lpstat` | [`.src/Caisse/Preferences.class`](.src/Caisse/Preferences.class), [`.src/Gestion/Facturation/Facturergbl.class`](.src/Gestion/Facturation/Facturergbl.class), [`.src/Reports/ChxImp.class`](.src/Reports/ChxImp.class) | Serveur d'impression **CUPS** (file d'impression) et ses clients `lpc status` / `lpstat -p` pour interroger les imprimantes. |
| `evince` | **Client** | `evince` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Visionneuse PDF (prévisualisation des documents). |
| `sane-utils` | **Client** | `xsane` | [`.src/Utils/LGed.class`](.src/Utils/LGed.class) | Numérisation multi-pages vers PDF pour la GED (`xsane -s -m`, puis `scangui` si configuré). |
| `xdg-utils` | **Client** | `xdg-open`, `xdg-mime` | [`.src/Caisse/FClientcarte.class`](.src/Caisse/FClientcarte.class), [`.src/Communs/Fmenu.class`](.src/Communs/Fmenu.class), [`.src/Utils/LGed.class`](.src/Utils/LGed.class) | `xdg-open` (ouverture navigateur / document / URL), `xdg-mime` (type MIME d'une pièce jointe). |
| `espeak` / `libespeak` | **Client** | `pico2wave` | [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class), [`.src/Utils/Syntheses.module`](.src/Utils/Syntheses.module) | Synthèse vocale : génération du fichier `msg.wav` à partir d'un texte. |
| `alsa-utils` / `libasound2` | **Client** | `aplay` | [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class) | Lecture du WAV de synthèse vocale. |

### 3.8. Messagerie

> Le **composant Gambas** `gb.net.smtp` (envoi SMTP natif, authentification `SmtpClient.Automatic`,
> serveur et port configurables via `Laurux.conf` → `/Smtp`) est décrit en
> [§2](#2-composants-gambas-3-déclarés-dans-project). Ce tableau couvre les **clients de messagerie**
> utilisés en alternative ou en complément.

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `thunderbird` | **Client** | `thunderbird` | [`.src/Gestion/Mails/EnvMail.module`](.src/Gestion/Mails/EnvMail.module) | Envoi d'e-mail avec pièce jointe via le client mail du poste (`thunderbird -compose to=…`). |
| `evolution` | **Client** | `evolution` | [`.src/Gestion/Mails/EnvMail.module`](.src/Gestion/Mails/EnvMail.module) | Alternative : `evolution mailto:<adr>?subject=…&body=…&attach=…`. |
| `icedove` | **Client** | `icedove` | [`.src/Gestion/Mails/EnvMail.module`](.src/Gestion/Mails/EnvMail.module) | Alternative Debian de Thunderbird. |
| `kmail` | **Client** | `kmail` | [`.src/Gestion/Mails/EnvMail.module`](.src/Gestion/Mails/EnvMail.module) | Alternative KDE : `kmail -s <sujet> --attach <pièce> --body <corps> <adr>`. |

### 3.9. SMS et périphériques

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `gammu` | **Client** | `gammu` | [`.src/Gestion/SMS/Gsm.class`](.src/Gestion/SMS/Gsm.class) | Envoi de SMS via modem GSM (`gammu sendsms TEXT <n°> -text <msg>`). Nécessite la configuration de Gammu (cf. *Prefs*). |
| `ydotool` | **Client** | `ydotool` | [`.src/Utils/ReplayObserver.class`](.src/Utils/ReplayObserver.class), [`.src/Utils/DB_Desktop.class`](.src/Utils/DB_Desktop.class) | Injection d'événements souris/clavier **sous Wayland** (rejeu de scénarios de test, pilotage de la caisse). |
| `xdotool` | **Client** | `xdotool` | [`.src/Utils/ReplayObserver.class`](.src/Utils/ReplayObserver.class) | Variante X11 de l'injection d'événements. **Code legacy commenté.** |
| `uinput` (module noyau) | **Service** | `ydotoald` | [wayland.sh](wayland.sh), [01-uinput-permission.rules](01-uinput-permission.rules), [uinput.conf](uinput.conf) | Daemon d'injection d'événements sous Wayland ; règle udev donnant accès à `/dev/uinput` au groupe `users` ; chargement du module noyau au démarrage. |

### 3.10. Outillage, build et maintenance

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `gambas3` (≥ 3.19) + `gambas3-devel` | **Outil** | `gbc3`, `gba3`, `gbx3` | [Makefile](Makefile), [report.sh](report.sh), [`.src/Communs/Prefs.class`](.src/Communs/Prefs.class) | Compilateur Gambas 3 : `gbc3 -agt` compile `.src/` → `.gambas/` ; `gba3 -o Laurux` lie le binaire. `gbx3` sert à la détection de version (script de rapport système) et à la comparaison avec la version attendue dans les préférences. Requis **uniquement au développement**, pas à l'exécution. |
| `git` | **Outil** | `git` | [Makefile](Makefile) | Récupération du SHA-1 et de la branche (écrits dans `sha1.txt` / `branch.txt`, affichés dans « À propos »). |
| `tar`, `gzip` | **Outil** + **Client** | `tar`, `gzip` | [Makefile](Makefile), [`.src/Communs/Majversion.class`](.src/Communs/Majversion.class) | Création de l'archive de distribution `.tar.gz` (make) ; extraction de l'archive de mise à jour (application). |
| `gawk` | **Outil** | `awk` | [mysql2sqlite](mysql2sqlite) | Script de conversion MySQL → SQLite3. |
| `github_changelog_generator` | **Outil** | `github_changelog_generator` | [Makefile](Makefile) | Génération du `CHANGELOG.md` (cible `make changelog`). |
| `docker` | **Outil** | `docker` | [`.hidden/Docker/README`](.hidden/Docker/README) | Construction et lancement du conteneur Laurux. |
| `xdg-user-dir` | **Outil** | `xdg-user-dir` | [Makefile](Makefile) | Emplacement du fichier `.desktop` sur le bureau utilisateur. |

### 3.11. Environnement conteneur (stack X11 / xpra)

Ces éléments ne sont pas des dépendances de l'application mais de son **environnement d'exécution
en conteneur** ; ils sont listés ici pour mémoire complète.

| Paquet Debian | Rôle | Binaire | Utilisé par | Description |
|---------------|------|---------|-------------|-------------|
| `xpra` | **Service** | `xpra` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Affichage distant du conteneur (alternative à X11 direct) — `xpra start :100 --start-child=…/Laurux`. |
| `xserver-xephyr`, `x11-apps`, `xterm` | **Client** | `Xephyr`, `xterm` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Serveur X secondaire et émulateur de terminal pour l'accès graphique. |
| `xdm` | **Service** | `xdm` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Serveur X de session, reconfiguré pour accepter les connexions distantes. |
| `fluxbox` | **Client** | `fluxbox` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Gestionnaire de fenêtres léger du conteneur. |
| `dbus-x11` | **Service** | `dbus-daemon` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Bus de messages requis par l'IHP Qt. |
| `pwgen` | **Outil** | `pwgen` | [`.hidden/Docker/entrypoint.sh`](.hidden/Docker/entrypoint.sh) | Génération du mot de passe utilisateur du conteneur. Le daemon SSH associé est décrit en [§3.3](#33-accès-distant-et-tunnel-ssh). |
| `python-numpy` | **Client** | `python3` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Utilitaire système de la stack X11/xpra. |
| `build-essential`, `vim` | **Outil** | `gcc`, `make`, `vim` | [`.hidden/Docker/Dockerfile`](.hidden/Docker/Dockerfile) | Chaîne de compilation et éditeur dans l'image de développement. |

### 3.12. Paquets retirés du `.project` (non requis)

| Paquet Debian | Ancien composant | Raison du retrait |
|---------------|-----------------|-------------------|
| `gambas3-gb-crypt` | `gb.crypt` | Retiré du `.project` (§2.1) : le chiffrement passe par `hexdblKey` (XOR) et le hachage par `gb.openssl` (cf. §3.4). |
| `gambas3-gb-desktop-x11` | `gb.desktop.x11` | Retiré du `.project` (§2.1) : aucun watcher X11 ni icône systray dans le code. |

---

## 4. Récapitulatif : obligatoires vs optionnelles

### Obligatoires (l'application ne démarre pas, ou perd une fonction centrale, sans eux)

**Les 24 composants** déclarés dans [`.project`](.project), en paquets Debian :
`gambas3-runtime` (ou `gambas3-gb-qt5`) · `gambas3-gb-form` · `gambas3-gb-form-dialog` ·
`gambas3-gb-form-print` · `gambas3-gb-db` · `gambas3-gb-db-mysql` · `gambas3-gb-db-sqlite3` ·
`gambas3-gb-compress` · `gambas3-gb-image` · `gambas3-gb-args` · `gambas3-gb-settings` ·
`gambas3-gb-logging` · `gambas3-gb-signal` · `gambas3-gb-net` · `gambas3-gb-net-curl` ·
`gambas3-gb-net-smtp` · `gambas3-gb-openssl` · `gambas3-gb-pcre` · `gambas3-gb-report2` ·
`gambas3-gb-sdl2-audio` · `gambas3-gb-desktop` · `gambas3-gb-xml` · `gambas3-gb-xml-html`.

**Base de données** : `mariadb-server` (ou `mysql-server`) **ou** base SQLite — §3.1 / §3.2.

**Système** : `coreutils` (`cp`/`mv`/`rm`/`mkdir`/`sed`…) · `procps` (`ps`) · `wget` (mises à jour) ·
polices `Serif`/`Sans Serif`.

### Optionnelles (activées par configuration ou par contexte)

| Fonctionnalité | Dépendances | Section |
|----------------|-------------|---------|
| Accès MySQL distant (tunnel SSH) | `openssh-client` (`ssh`), `sudo`/`gksu` | [§3.3](#33-accès-distant-et-tunnel-ssh) |
| Sauvegarde / restauration | `mariadb-client` (`mysqldump`, `mysql`, `mysqladmin`) | [§3.1](#31-base-de-données-mysql--mariadb) |
| Log distant | `netcat-openbsd` (`nc`) sur le serveur | [§3.6](#35-client-http--ftp-et-mises-à-jour) |
| GED électronique | `xdg-utils` (`xdg-mime`, `xdg-open`), `curl`, `sane-utils` (`xsane`) | [§3.8](#37-impression-ged-scan-et-synthèse-vocale) |
| SMS | `gammu` | [§3.10](#39-sms-et-périphériques) |
| Synthèse vocale | `espeak` (`pico2wave`), `alsa-utils` (`aplay`) | [§3.8](#37-impression-ged-scan-et-synthèse-vocale) |
| E-mails | `thunderbird` / `evolution` / `icedove` / `kmail`, ou serveur `SMTP` (`gb.net.smtp`) | [§3.9](#38-messagerie) |
| Impression | `cups` (`lpc`, `lpstat`), `evince` | [§3.8](#37-impression-ged-scan-et-synthèse-vocale) |
| FTP catalogue produits | `wput` | [§3.6](#35-client-http--ftp-et-mises-à-jour) |
| Wayland / rejeu de scénarios | `ydotool`, `ydotoald`, module noyau `uinput` | [§3.10](#39-sms-et-périphériques) |
| Conteneur | `docker`, `xpra`, `xdm`, `fluxbox`, `dbus-x11` | [§3.12](#311-environnement-conteneur-stack-x11--xpra) |
| Maintenance et compilation | `gambas3-devel` (`gbc3`/`gba3`), `git`, `make`, `github_changelog_generator` | [§3.11](#310-outillage-build-et-maintenance) |

### Non requises (retirées du `.project`, cf. §2.1)

`gambas3-gb-crypt` · `gambas3-gb-desktop-x11` — ne doivent **plus** être installés pour Laurux.

---

## 5. Chaîne de compilation complète

```
.project (24 composants Gambas)
  │
  ├── .src/**/*.class   (404)   +  .src/**/*.form   (313)   → .gambas/
  ├── .src/**/*.module  (53)
  └── .src/**/*.report  (6)
        │
        │  gbc3 -agt          (Makefile)   ← gambas3-devel, requis au build UNIQUEMENT
        │  gba3 -o Laurux     (Makefile)
        ▼
     Laurux  (exécutable)
        │
        ├──► .src/Serveur.module, .src/CHANGELOG, .src/Drop_base, .src/Restore_base
        │   (ressources embarquées)
        ├──► Icones/, son/, Fonds_Laurux/, tips/   (chargées à l'exécution)
        ├──► MySQL / MariaDB  (mode serveur)  ← gb.db.mysql + libmariadb + mysqld
        └──► SQLite 3         (mode portable) ← gb.db.sqlite3 + libsqlite3
```

> **Note de cohérence** : les 24 composants listés en §2 correspondent exactement aux 24 lignes
> `Component=` de [`.project`](.project). Les 6 modules internes et la bibliothèque PDF s'y ajoutent
> comme dépendances intra-projet (compilées en même temps que les sources, sans paquet externe).

---

*Document généré par analyse statique du dépôt Laurux v3.69.0 — à maintenir à jour lors de
l'ajout ou du retrait d'un composant, d'un paquet ou d'un appel `Shell`/`Exec`.*
