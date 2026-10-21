# STRUCTURE — Laurux

Cartographie du dépôt **Laurux** (PGI français en Gambas 3) : répertoires, fichiers et description
associée.

> **Périmètre** : ce document ne décrit que les fichiers **sous contrôle de version** (listing
> `git ls-files`), soit **992 fichiers**. Les artefacts de compilation (`.gambas/`, `Laurux`,
> `.settings`, `.lang/`, `sha1.txt`, `branch.txt`, `output/`) et les sauvegardes `*~` sont
> **exclus** — voir [§8](#8-fichiers-hors-contrôle-de-version).

Dernière analyse : **22 octobre 2026** — base : `git ls-files` (992 entrées), inspecté avec
`git log` / lecture directe des sources.

---

## 1. Vue d'ensemble

| Niveau | Chemin | Fichiers | Rôle |
|--------|--------|----------|------|
| Racine | `.` | 29 | Configuration du projet, build, documentation, données de référence |
| Sources | `.src/` | 797 | **Code applicatif Gambas 3** (le cœur du dépôt) |
| Assets | `Icones/` | 144 | Icônes de l'interface (PNG/GIF/JPG) |
| Assets | `son/` | 5 | Sons d'interface (`.ogg`, SDL2) |
| Assets | `Fonds_Laurux/` | 5 | Fonds d'écran du logiciel |
| Assets | `tips/` | 1 | Textes d'aide contextuels (français) |
| Données | `.hidden/` | 11 | Données non inclus dans l'application : fichier exemple + environnement Docker |
| Docs | `*.md` | 7 | Documentation markdown (racine) |

### 1.1. Répartition par type de fichier

| Type | Nombre | Rôle |
|------|--------|------|
| `.class` | 404 | Classes Gambas (logique métier + classes de formulaire) |
| `.form` | 313 | Formulaires Gambas (description XML des widgets) |
| `.png` | 156 | Icônes et images |
| `.module` | 53 | Modules Gambas (procédures globales, pas de classe) |
| `.txt` | 7 | Référentiels texte (postaux, plans de comptes, libellés) |
| `.md` | 7 | Documentation |
| `.report` | 6 | États `gb.report2` (gabarits d'impression) |
| `.jpg` | 6 | Fonds d'écran et signature |
| `.sh` | 5 | Scripts shell (Docker, conversion, build) |
| `.ogg` | 5 | Sons d'interface |
| `.gif` | 5 | Icônes animées / décoratives |
| `.conf` | 3 | Configuration (Gambas, Docker) |
| `.csv` | 2 | Données tabulaires (postaux, contrôles) |
| autres | 20 | Fichiers sans extension ou à extension unique : `.project`, `.info`, `.list`, `.version`, `.gitignore`, `.directory`, `Makefile`, `mysql2sqlite`, `Drop_base`, `.src/CHANGELOG`, `Dockerfile`, `README`, `keyboard`, `sshd_config`, `01-uinput-permission.rules`, `Laurux01.sql`, `Laurux01.sqlite`, `tips.fr` |

> **Correspondance `.class` / `.form`** : les **313** formulaires ont chacun leur classe
> jumelle (`X.class` ↔ `X.form`). Les **91** classes sans `.form` sont des classes
> **non visuelles** : logique métier, générateurs de documents, widgets~, helpers et modules de
> report. Il n'y a **aucun** `.form` orphelin.

---

## 2. Racine du dépôt

| Fichier | Type | Description |
|---------|------|-------------|
| [`.project`](.project) | config | Fichier de projet Gambas 3. Déclare le titre, la version (3.69.0), le point d'entrée (`Startup=Start`), l'icône, et les **24 composants Gambas** requis. |
| [`.version`](.version) | config | Version de l'application (`3.69.0`), dupliquée dans `.project` et utilisée par le `Makefile`. |
| [`.info`](.info) | config | Métadonnées des classes **non visuelles** (propriétés, événements) — nécessaire pour `gb.form` et l'IDE. Classes listées : `ImageButton`, `LDate`, `LTrans`, `NetHandler`, `TextReg`, `TypeClient`, `barselection`, `hexdblKey`, `textfamille`. |
| [`.list`](.list) | config | Liste des classes « custom » à exposer dans l'IDE Gambas. |
| [`.gitignore`](.gitignore) | config | Exclusions Git : `*.gambas`, `*~`, `.lang/*.pot`, `.settings`, `.startup`, `*.orig`, `sha1.txt`, `branch.txt`, `Laurux`, `output/**`. |
| [`.directory`](.directory) | config | Entrée `.desktop` minimale (icône du dossier dans le gestionnaire de fichiers). |
| [`.app.png`](.app.png) | image | Icône de l'application 64×64 (aperçu IDE / gestionnaire de fichiers). |
| [`.icon.png`](.icon.png) | image | Icône de l'application 256×256. |
| [Makefile](Makefile) | build | Build principal : `gbc3 -agt` puis `gba3 -o Laurux`. Écrit `sha1.txt` / `branch.txt` (version affichée dans « À propos »), génère les `.desktop`, et fournit les cibles `clean`, `package`, `changelog`. |
| [Laurux01_to_sqlite.sh](Laurux01_to_sqlite.sh) | script | Conversion d'un dump MySQL vers SQLite3 : `mysqldump …` puis `mysql2sqlite` puis `sqlite3`. |
| [mysql2sqlite](mysql2sqlite) | script | Script **AWK** de conversion SQL MySQL → SQLite3 (support des types entiers, transactions, `PRAGMA`). |
| [sqlite3.txt](sqlite3.txt) | script | Note d'exécution de la conversion : `mysql2sqlite.sh …` puis `sqlite3 ./Laurux01.sqlite`. |
| [report.sh](report.sh) | script | Script *Gambas IDE* : rapport système (OS, distribution, mémoire, version Gambas). |
| [wayland.sh](wayland.sh) | script | Configuration **Wayland** : installation de `ydotool`/`ydotoold`, ajout au groupe `users`, pose des règles udev et du module noyau `uinput`. |
| [01-uinput-permission.rules](01-uinput-permission.rules) | config | Règle **udev** donnant accès à `/dev/uinput` au groupe `users` (injection d'événements souris/clavier). |
| [uinput.conf](uinput.conf) | config | Fichier de `/etc/modules-load.d/` : charge le module noyau `uinput` au démarrage. |
| [Laurux01.sqlite](Laurux01.sqlite) | données | Base **SQLite 3** de référence (mode portable). |
| [Laurux01.sql](Laurux01.sql) | données | Dump **SQL/MySQL** de la base de référence. |
| [db_control.csv](db_control.csv) | données | Référentiel des **contrôles de sommes** (tables, colonnes, index, collation) — audit de structure de la base. |
| [Drop_base](Drop_base) | données | Script SQL `drop database` — remise à zéro de la base. |
| [CV.txt](CV.txt) | données | Liste des **formes juridiques** françaises (SARL, EURL, SAS, SCI, SCOP…). |
| [Pays.txt](Pays.txt) | données | Référentiel des **pays** (adresses clients/fournisseurs). |
| [CHANGELOG.md](CHANGELOG.md) | doc | Historique des versions de Laurux. |
| [README.md](README.md) | doc | Présentation, modes d'usage (CLI / GUI), toolchain requis. |
| [AGENTS.md](AGENTS.md) | doc | Instructions pour les agents de codage (conventions Gambas, style d'erreur, arborescence attendue). |
| [TESTING.md](TESTING.md) | doc | Stratégie de test : harnais `Internal_Test`, mode log/replay. |
| [DEPENDANCES.md](DEPENDANCES.md) | doc | Inventaire des dépendances (composants Gambas, paquets, exécutables, assets). |
| [INSTALL.md](INSTALL.md) | doc | Renvoi vers la procédure d'installation officielle (`laurux.fr`). |
| [LICENSE.md](LICENSE.md) | doc | Licence **GPL**. |

---

## 3. `.src/` — Code applicatif Gambas 3

797 fichiers. Convention : une classe `X.class` implémente la logique, un `X.form` décrit ses
widgets ; un `X.module` expose des procédures globales sans état d'instance.

### 3.1. Points d'entrée et modules racine

| Fichier | Description |
|---------|-------------|
| [`.src/Start.module`](.src/Start.module) | **Point d'entrée** (`Startup=Start`). Parse les arguments CLI (`-c`, `-p`, `-l`, `-r`, `-d`, `--devel`, `-s`, `-t`, `--restore`, `--version-full`), charge la configuration (`GlobalSettings` / `LocalSettings`), gère le verrou mono-instance (`~/Laurux.lock` + `ps`), la capture/rejeu des événements, l'interception de `SIGINT`, et le harnais de test `Start_Test()`. Expose l'état global (société courante, couleurs, chemins,Musique). |
| [`.src/Serveur.module`](.src/Serveur.module) | Mode **serveur** : export d'enregistrements (articles, etc.) vers des fichiers texte `…_Serveur.txt` consommés par d'autres postes ou par des automates. |
| [`.src/CHANGELOG`](.src/CHANGELOG) | Journal de versions **embarqué** dans l'exécutable (affiché dans « À propos ») — distinct de `CHANGELOG.md`. |
| [`.src/Drop_base`](.src/Drop_base) | Script SQL embarqué : `drop database` (remise à zéro). |
| [`.src/Restore_base`](.src/Restore_base) | Script SQL embarqué : `create database` (création / restauration). |

### 3.2. `.src/Communs/` — 41 fichiers

Fonctions partagées par tous les modules : menu principal, configuration, sauvegardes, mises à jour.

| Fichier / Classe | Description |
|------------------|-------------|
| `Fmenu.class` / `.form` | **Menu principal** de l'application (barre de navigation, arborescence des rubriques). Point d'entrée de l'IHM en mode gestion. |
| `Cmenu.class` / `.form` | Menu principal du **mode caisse** (point de vente) — lanceur de `Caisse`. |
| `Doc.module` | `Doc.Open(rubrique)` — ouverture centralisée d'un écran par sa rubrique (navigation interne). |
| `LauruxConf.class` / `.form` | Configuration de la **connexion à la base** (type MySQL/SQLite, hôte, port, identifiants, tunnel SSH). |
| `Prefs.class` / `.form` | Préférences générales (couleurs, formats, SMTP, client mail, impression, synthèse vocale). |
| `Parametre.class` / `.form` | Paramètres par société. |
| `Fsystem.class` / `.form` | Information système et configuration des chemins. |
| `Fusers.class` / `.form` | Gestion des utilisateurs et des droits. |
| `MDP.class` / `.form` | Saisie et vérification des mots de passe (via `hexdblKey.Crypt`). |
| `Fsoc.class` / `.form` | Gestion des **sociétés** (multi-sociétés). |
| `Fblocsoc.class` / `.form` | Blocage / déblocage d'une société (verrou de travail). |
| `FAbout.class` / `.form` | Boîte « À propos » (version, branche, SHA-1). |
| `FTips.class` / `.form` | Affichage des **tips** (aides contextuelles). |
| `Fprepdus.class` / `.form` | Préparation des sauvegardes. |
| `FSauve.class` / `.form` | Sauvegarde de la base (dump MySQL, compression `gb.compress`). |
| `FRestore.class` / `.form` | Restauration depuis un dump SQL (`.sql`, `.sql.gz`). |
| `SauvesAuto.module` | Sauvegarde **automatique** planifiée, envoi FTP optionnel (`FtpClient`). |
| `Majversion.class` / `.form` | Détection des **mises à jour** sur `laurux.fr` (`HttpClient`, `HtmlDocument`, `XmlElement`). |
| `LauruxMaj.module` | Script de **mise à jour du schéma** de la base entre versions (ALTER TABLE, conversions). |
| `Raz.class` / `.form` | Remise à zéro des données (opérations annuelles). |
| `Prgm.class` / `.form` | Gestion des programmes / raccourcis de navigation. |
| `Deblockbl.class` / `.form` | Déblocage des lignes bloquées. |
| `DocActif.class` / `.form` | Documents actifs (GED). |
| `Fmenu` / `Fmenuc` | (voir §8) — `Fmenuc.class~` est une sauvegarde non suivie. |

### 3.3. `.src/Utils/` — 110 fichiers (+ 16 dans `Exports-Imports/`)

Bibliothèque applicative transversale : accès base de données, objets métier typés, widgets
réutilisables, exports.

| Fichier / Classe | Description |
|------------------|-------------|
| `DB_Connection.class` | **Cœur d'accès aux données**. Hérite de `Connection` ; implémente `Exec()` (requêtes paramétrées `&1`, `&2`), `IsType()` (MySQL / SQLite), `AutoIncrement()`, `Engine()`, le **logging** (fichier, console, distant via `NetHandler`) et les **filtres** de log (`RegExp`). |
| `DB_Desktop.class` | Détection de l'environnement de poste (Wayland / X11, présence de `ydotool`). |
| `DB_Log.class` / `.form` | Interface de configuration du log (activation, filtres, niveaux). |
| `DB_Sanity.class` / `.form` | Contrôle de **cohérence** entre le schéma attendu et la base réelle. |
| `Utils.module` | Module utilitaire global : `Utils.db` (instance `DB_Connection`), helpers de grille (`Base`…`Base4`), tunnel SSH MySQL (`monteTunnel` / `fermeTunnel`), sortie du programme. |
| `Variables.module` | **Variables globales** lues depuis la configuration (options d'export/import, maj articles/fournisseurs/clients, chemins). |
| `LPrix.class` | Objet typé de **prix / montants** (formats `.L`, `.Q`, `.QD`, `.G`, `.D`, `.DT`, `.PuBHT`). Implémente `Internal_Test`. |
| `LDate.class` | Objet typé de **date** (exercices, périodes, fins de mois, comparaisons). |
| `LTrans.class` | Conteneur de transport inter-classes (`Text` + `List`). |
| `LVar.class` | Variables de l'interpréteur de script (`Eval`). |
| `LScript.class` | Moteur de script. Implémente `Internal_Test`. |
| `LCoul.class` | Palette de couleurs de l'interface. |
| `LTaxe.class` | Utilitaires de calcul de taxe (TVA). |
| `TextReg.class` | Widget de saisie **filtré** par expressions régulières (validation, format de date/heure, mask). |
| `LBox.class` | Liste déroulante typée. |
| `HexdblKey.module` | Chiffrement **XOR** des mots de passe (clé « Laurux ») — implémentation maison, cf. [DEPENDANCES.md §2.1](DEPENDANCES.md). |
| `Sha1Calc.module` | Somme de contrôle **SHA-1** des lignes d'écriture (`Digest["sha1"]` + Base64) — chaînage anti-falsification. |
| `Cbase.module` | `Cbase.Table(prog)` — résolution du **nom physique de table** selon le programme appelant. |
| `Crupt.module` | Cryptage utilitaire (divers). |
| `Csolde.module` / `Cstock.module` / `CPrix.module` | Calculs de solde, de stock et de prix. |
| `Copie.module` | Copie de données entre entités. |
| `Enrgcp.module` | Enregistrement de la gestion commerciale. |
| `CheckProg.module` | Vérifications de cohérence entre programmes. |
| `gridv.module`, `gridvi.class`, `gridvi2.class` | Wrappers de **grille** (affichage tabulaire des écritures). |
| `RichDataGrid.class`, `DataButtonList.class` | Widgets de grille enrichis (colonnes configurables, boutons d'action). |
| `SaiTableau.class`, `Sailig.class` | Saisie de tableau / saisie alignée. |
| `NetHandler.class` | **Log distant** : envoi du log vers un serveur via `Socket` (le serveur écoute avec `nc -l -k -p <port>`). |
| `LLog.class` | Journalisation locale (fichier + console). |
| `ReplayObserver.class` | Capture / rejeu des **événements IHP** (clics, saisies) — base des tests de non-régression. |
| `ObjProp.class` | Stockage d'objets dans les `Settings` (préférences). |
| `ProgBar.class` / `.form` | Barre de progression. |
| `modCrBcode.module` | Génération de **codes-barres** (drawing). |
| `Impression.module` | Choix de l'imprimante / lancement de l'impression. |
| `Visualiseur.module` | Ouverture d'un document avec l'application par défaut (`Desktop.Open`). |
| `GedR.class` / `.form`, `LGed.class` / `.form` | **GED** électronique : gestion et indexation des documents. |
| `Cdoc.class` / `.form` | Gestion documentaire. |
| `CFormat.class` | Formatage des montants / dates selon les préférences. |
| `FSetFormat.class` / `.form` | Paramétrage des formats (longueur, décimales). |
| `SetColors.class` / `.form` | Palette de couleurs de l'interface. |
| `Recup.module`, `RecupN.class` | Récupération de données (ré-initialisation, imports). |
| `Monip.module` | Adresse IP publique (`curl ifconfig.me`). |
| `Mmysql.module` | Utilitaires MySQL en ligne de commande (élévation de privilèges, `processlist`). |
| `Syntheses.module` | **Synthèse vocale** (`pico2wave` + `aplay`). |
| `Numtostring.module`, `Posnum.module` | Conversion numérique / position de curseur numérique. |
| `VerifNumfac.module` | Vérification de la numérotation des factures. |
| `VerifDate.class` | Contrôle de validité des dates. |
| `CTestTVA.class` | Validation du calcul de TVA. |
| `HistoCom.class` | Historique commercial. |
| `AffRdv.module` | Affichage des rendez-vous. |
| `Condition.class`, `Conditions.class` | Évaluation de conditions (filtres, règles). |
| `Epurfour.class` | Épuration des données fournisseurs. |
| `Cmo.class`, `Cmoprod.class` | Calculs de marge / marge produit. |
| `CompArt.class`, `Cprod.class`, `Cstock.module` | Comparaison et gestion des articles / produits / stocks. |
| `Calc*.class` / `.form` | Calculettes : `Calc`, `CalcRem`, `Calcsolde`, `Calcstock`, `FCalc`. |
| `Carch.class` / `.form` | Archivage des articles. |
| `Chaine*.class` / `.form` | Changement de famille / de fournisseur d'un article. |
| `CFormat`, `Dcfour.class` / `.form` | Gestion des codes fournisseur. |
| `FSetFormat`, `TarArt.class` / `.form`, `RazArt.class` / `.form`, `Trifam.class`, `RenumBl.class` | Divers outils articles / familles / blonds. |
| `Papmp.class`, `VisPmp.class` / `.form` | Fiche PMP (prix moyen pondéré) et sa visualisation. |
| `textfamille.class` | Widget de saisie de famille d'article. |
| `Cbase.module`, `Cdoc.class` / `.form`, `Carch.class` / `.form` | Modules et classes de référence métier (tables, documents, archivage). |
| `Exports-Imports/` (16 fichiers) | Écrans d'**export / import** : `Expart`, `Expbase`, `Expclient`, `Expcontact`, `Impclient`, `Impcpostaux`, `ImportStk`, `ImptartypeC`. |

### 3.4. `.src/Compta/` — 23 fichiers (+ 4 sous-répertoires)

Comptabilité générale : écritures, journaux, lettrage, clôtures, relances, plans de comptes.

| Répertoire / Fichier | Description |
|----------------------|-------------|
| `Saisecrit.class` / `.form` | **Saisie d'une écriture comptable**. |
| `Pointage.class` / `.form` | Pointage / lettrage manuel entre écritures et pièces. |
| `Analytique.class` / `.form` | Analyse analytique (axes, ventilation). |
| `Trecarts.class` / `.form`, `Tresor.class` / `.form` | Écritures de trésorerie (caisse, banque). |
| `Cecrit.module`, `Ccomptes.module` | Modules d'écritures et de plan comptable. |
| `Echeances.class` / `.form` | Échéances clients / fournisseurs. |
| `Extrait.class` / `.form` | Extraction d'un compte (état `gb.report2`). |
| `Cielcorsp.class`, `Cielcorspj.class`, `Cielimp.class` | Rapprochement bancaire (Ciels,.imports). |
| `Clotures/` (4) | `FCloture.class`, `FClotureAn.class` — clôture d'exercice et **clôture annuelle** (export `gb.compress`). |
| `Lettrages/` (8) | Lettrage : `Lettrage`, `Lettragemontant`, `Lettragesoldes`, `Visimpayes`. |
| `Relances/` (14) | Relances clients : `FRelance`, `FPrepRel2`, `FEditrel`, `FRelCompte`, `FRelFacture`, `Ligcli`, `Ligext`. |
| `Impressions/` (41) | Éditions comptables : `Balance`, `BalanceM`, `BordereauxC`, `Echeancier`, `EcrM`, `EdImpayes`, `Editcompte(A/M)`, `EdNjustifiees`, `EdNlettrees`, `ExportA47` (export AGEC/AF47), `FTVA`, `Imp_Bilan`, `Imp_Sig`, `Jourcent`, `Journaux(A/M)`, `journauxSetting`, `Plancomptable`, `RubImp`, `Anomalies`. |
| `Tables/` (16) | Tables de référence : `Abont`, `FCollectif`, `FComptes`, `FJournaux`, `FLibelle`, `FPostes`, `FTvac`, `FTvav`. |
| `Utils/` (43) | Utilitaires comptables : `Comptabilite.module`, `Ecritures`, `EcrAuto` (écritures automatiques), `EcrReg`, `Equilibrage`, `Epurjdv`, `ExportJdv`/`Intjdv`/`ImpJdv` (export/import des écritures), `Exprub`, `Fmontant`, `impfec` (export FEC), `ImpSage` (export Sage), `Listextcpt`, `RazClos`, `RazEcr`, `Recalcsolde.module`, `RecupDech`, `RenAN`, `Renech`, `RenMvt.module`, `Rubcompt`, `Rubresult`, `TypeClient`, `VarEcr`, `Verbal`, `Dup`. |
| `Rslt.txt` | Référentiel texte annexe (données d'appui). |

### 3.5. `.src/Gestion/` — 9 fichiers directs + 11 sous-répertoires

Gestion commerciale, stock, facturation, étiquettes, dépot, SMS, mails.

| Répertoire / Fichier | Description |
|----------------------|-------------|
| `Site.module` | Module du **site web** (option d'édition multi-sites). |
| `Tables/` (60) | Tables de référence : `Articles`, `Familles`, `FClient`, `FFournisseur`, `Centrales`, `Commerciaux`, `ComMail`, `Comment`, `Identite`, `LibelFac`, `Marques`, `Materiel`, `Mreglement`, `Prodcomposes`, `Remisecli`, `Remisec`, `Statut`, `TarTypeCli`, `Tleg`, `Tmail`, `Txmo`, `Typec`, `Fpromo`/`FpromoArt`, `ArtPromo.module`, `Btqart` (catalogue FTP), `Cpostaux`, `CoefTypeC`, `Movr`, `ConsultArt`, `CV.txt`. |
| `option/` (49) | Options et paramétrage métier : `artopt`, `atribvignette`, `barselection`, `calculdroit(1)`, `Caleditcmat` (export CSV/HTML), `Consigne`, `Ecomptamat` (+`.report`), `Edconsigne`, `EditfacB`, `EditStkDepart` (+`.report`), `Edittipp` (+`.report`), `Einvmat` (+`.report`), `facopt`, `fourconsdroi`, `menuopt`, `modfichier.module`, `ObjFacB`, `rechcons`, `rechtipp`, `rechtour`, `Saisiedecons`, `Tchauffeur`, `Tconsigne`, `ticpe`, `Tregie`, `Tregion`, `Ttarfioul`, `Ttourne`, `Visucmat`. |
| `Impressions/` (42) | Éditions de gestion : `EdArt1/2/3/4`, `Edbl`, `Edbr.module`, `EdClient`, `Edcom`, `EdDocs`, `EdFam`, `EdFour`, `EdMat`, `Edmo`, `Edpaiement`, `EdPrep`, `EdReg` (+`.report`), `Edregul`, `Edregulprdc`, `EdRup`, `EdStk`, `Editeur.module`, `Traites`. |
| `Facturation/` (17) | Facturation : `Facture`, `Facturefm`, `FacturefmA`, `Facturergbl` (Règlements / bilan), `Fcaras` (carte de fidélité), `ConVendeurs`, `ObjFac` (objet facture partagé), `OptFac`, `SaiReg`. |
| `Stock/` (15 + 29 sous-dossiers) | Stock : `commande1` (commandes fournisseurs), `Epurmvtexp`, `Listecom`, `Mvtex`, `MvtProdcomp`, `ValidBR(1)`, `VarMajTar` ; `Inventaires/Fin-annee/` (16) : `Edinv`, `Edinv1`, `Ednsaisis`, `Ecarts`, `Geninv`, `RazInv`, `SaisieInv`, `Validinv` ; `Inventaires/Tournant/` (14) : mêmes écrans en inventaire tournant ; `Tarifs/` (13) : `Impart`, `ImpartParam`, `MajEqu.module`, `MajFbtarif1/2`, `MajTarifM`, `MajTarifP`. |
| `Etiquettes/` (18) | **Étiquettes code-barres** : `Dymo.module` et `Zebra.module` (protocole ZPL via `Socket`), `Eticli`, `Etigond`, `Etiqart`, `Etiqcasier`, `Etiqfbtarif`, `EtiqPromo`, `EtiqRecpt`, `Etiquettes`. |
| `Depots/` (10) | Dépôts : `Depots`, `Sdepots`, `MvtDepots`, `ImpDepots`, `Edsdepots`. |
| `Entrées/` (5) | Réceptions : `Achat` (achat fournisseur), `GesTar` (gestion des tarifs), `DateTar`. |
| `Reglements/` (4) | Règlements : `TresorFac`, `Visreglements`. |
| `Lcr/` (14) | **Lettre de voiture / LCR** : `Lcr`, `Glcr`, `CLcr` (sortie PDF), `Preparation`, `Attribution`, `Banque`, `Bordrx`, `EntreeItem.module` ; `Portables/` (3) : `Portable.module`, `Majcasier`. |
| `Mails/` (5) | Courriel : `Emailing`, `EmailingCarte`, `EnvMail.module` (envoi SMTP ou via client mail). |
| `SMS/` (6) | SMS : `Sms`, `Psms` (paramétrage), `Gsm` (envoi via `gammu`). |

### 3.6. `.src/Caisse/` — 41 fichiers (+ 2 sous-répertoires)

**Point de vente** (mode `-p` / `Laurux-Pos`).

| Fichier / Classe | Description |
|------------------|-------------|
| `Caisse.class` / `.form` | **Écran principal de la caisse** : saisie des ventes, encaissements (espèces, chèques, cartes), tickets, commerciaux, rappels, TPE. Fichier le plus volumineux du projet. |
| `Cmenu.class` / `.form` | Menu d'entrée du mode caisse. |
| `Ouverture.class` / `.form` | Ouverture de caisse (session, caisseiro, mot de passe). |
| `Fondcaisse.class` / `.form` | Fond de caisse (écran de saisie rapide, pavé numérique). |
| `Clavier.class` / `.form` | Pavé numérique tactile. |
| `Positions.class` | Positions / touches de vente rapide. |
| `Attrib.class` / `.form` | Attribution des ventes à un commercial. |
| `Moulinage.class` / `.form` | **Moulinage** : cumul des ventes de la journée et transfert vers la comptabilité. |
| `Bordereaux.class` / `.form` | Bordereaux de caisse (Z, etc.). |
| `Statcai.class` / `.form` | Statistiques de caisse. |
| `Telium.class` | Terminal de paiement **Telium** (TPE bancaire). |
| `Fvendeurs.class` / `.form`, `Svendeur.class` / `.form` | Vendeurs / caissières. |
| `Fcaisses.class` / `.form` | Gestion des caisses. |
| `Dcaisses.module` | Données de caisse (variables, aide). |
| `FClientcarte.class` / `.form` | Fidélité : carte de points, recherche d'adresses (Google Maps). |
| `Fclientc.class` / `.form` | Client de la caisse. |
| `LibelTicket.class` / `.form`, `LibelAvoirs.class` / `.form` | Libellés de ticket et d'avoir. |
| `Preferences.class` / `.form` | Préférences de la caisse (imprimante, logo, sons). |
| `ImageButton.class` | Widget bouton image (avec `Image` de `gb.image`). |
| `MyStyle.class` | Style graphique personnalisé. |
| `numtostring.module` | Conversion de nombre en libellé. |
| `TestCaisses.module` | Tests manuels de la caisse (`TestCai()`). |
| `Affichages/` (4) | Triangles de caisse : `Tricartes`, `TriclientsD`. |
| `Reports/` (2) | `Cfacture.class`, `Cticket.class` — tickets et factures PDF (héritent de `PdfWriter`). |

### 3.7. `.src/Affichages/` — 31 fichiers

Écrans de **tri / recherche** (les « triangles » de l'application).

| Préfixe | Description |
|---------|-------------|
| `Tri*.class` / `.form` | Trieurs génériques : `TriArticles`, `TriBl` (blonds), `Tricp` (comptes), `TriCpt`, `TriEcritures` / `TriEcritures2`, `TriEqu` (équipements), `TriFac` / `TriFac2` / `TriFacture`, `TriHistos`, `TriMat` (matériel), `TriMo` (modèles), `TriGen` (moteur générique, sans formulaire). |
| `ACom.class` / `.form` | Analyse des commandes. |
| `AFacture.class` / `.form` | Analyse des factures. |

### 3.8. `.src/Archivages/` — 16 fichiers

Archivage et purge des données.

| Fichier | Description |
|---------|-------------|
| `Archives.class` / `.form` | Archivage des pièces (factures, tickets). |
| `ArchivesTck.class` / `.form` | Archivage des tickets de caisse. |
| `RazClientd.class` / `.form` | Purge des données clients. |
| `RazDevis.class` / `.form` | Purge des devis. |
| `RazHistoFac.class` / `.form` | Purge de l'historique des factures. |
| `RazHistoFbl.class` / `.form` | Purge de l'historique des factures fournisseur. |
| `RazHistoTk.class` / `.form` | Purge de l'historique des tickets. |
| `RazRlvb.class` / `.form` | Purge des lignes de vente. |

### 3.9. `.src/Reports/` — 26 fichiers

Bibliothèque de **génération de documents PDF**.

| Fichier | Description |
|---------|-------------|
| `PdfWriter.class` | **Moteur PDF autonome** (≈ 3 000 lignes) : polices Core/Type1/TrueType intégrées, flux compressés (`gb.compress`), tableaux, graphiques (`PieChart`, `BarDiagram`), images. Classe de base de 20 rapports. |
| `PdfWriterFont.class` | Gestion des polices intégrées au PDF (`courier`, `helvetica`, …). |
| `C*.class` | Rapports specialized héritant de `PdfWriter` : `Carticles`, `Cbalances`, `Cbilan`, `Cbordereaux`, `Cclients`, `Ccompta`, `Cdocuments` (+`2`, `3`), `Cecheancier`, `Cetiquettes`, `Chistoriques`, `Clivre`, `Cmat`, `Creleve`, `Cresultat`, `Csig`, `Cstocks`, `Ctraites`, `Htickets`. |
| `Editfac.class` / `.report` | Édition de facture (gabarit `gb.report2`). |
| `ChxImp.class` / `.form` | Choix de l'imprimante (`lpc`, `lpstat`). |

### 3.10. `.src/Statistiques/` — 38 fichiers

Statistiques et tableaux de bord.

| Préfixe | Description |
|---------|-------------|
| `Stat*.class` / `.form` | Statistiques : `Statbase`, `StatClimo` (climato), `StatComArt` (commercial/articles), `StatComm` (commercial), `StatFour` (fournisseur), `StatPromo`, `StatTypCli` (type de client). |
| `Vis*.class` / `.form` | Visualisations : `VisStatClimo`, `VisStatComArt`, `VisStatComm`, `VisStatFour`, `VisStatTypCli`, `VisHitCartes`. |
| `Histo*.class` / `.form` | Historiques : `Histocliart` (client/article), `Histovmo` (ventes/mouvements). |
| `HitCarte.class` / `.form` | Analyse du hit de la carte de fidélité. |
| `Rel*.class` / `.form` | Relations statistiques : `RelMoprod`, `RelvMo`. |
| `TBord.class` / `.form` | Tableau de bord. |

### 3.11. `.src/Images/monnaie/` — 16 fichiers

Billets et pièces `b5`…`b500` (5, 10, 20, 50, 100, 200, 500) et `p1`…`p50` (1, 2, 5, 10, 20, 50) — pièces
et billets en PNG.

> **Doublon** : ce répertoire contient **exactement les mêmes 16 fichiers** que
> [`Icones/Euros/`](Icones/Euros/) et n'est référencé par **aucune** source. Doublon à supprimer
> (cf. [§8](#8-fichiers-hors-contrôle-de-version)).

### 3.12. `.src/Tests/` — 2 fichiers

| Fichier | Description |
|---------|-------------|
| `TriTest.class` / `.form` | Prototype de test du widget `TriGen` (trieur générique). |

---

## 4. `Icones/` — 144 fichiers

Ressources graphiques de l'interface : boutons, pictogrammes métier, logos.

| Sous-dossier | Fichiers | Contenu |
|--------------|----------|---------|
| `Icones/` | 128 | PNG (≈ 120), GIF (5), JPG (1). Boutons (`back`, `next`, `up2`, `down2`, `open`, `print`), pictogrammes métier (`Article`, `Client`, `Fournisseur`, `Comptes`, `Stock`, `Tauxmo`, `Tresor`, `Journaux`, `familles`…), outils (`calc`, `find`, `trash`, `columns`), logos (`Larus.png`, `Laurus.png`, `Laurux-Pos.png`), signature (`signature.png` / `.jpg`). |
| `Icones/Euros/` | 16 | Pièces et billets en euros (identique à `.src/Images/monnaie/`). |

---

## 5. `son/` — 5 fichiers

Sons d'interface, lus via `gb.sdl2.audio` (`Music.Load` / `Music.Play`).

| Fichier | Description |
|---------|-------------|
| `warning.ogg` | Son d'avertissement par défaut (`Start.Musique`). |
| `warning2.ogg` | Variante d'avertissement. |
| `menu.ogg` | Son d'ouverture de menu. |
| `fermeture.ogg` | Son de fermeture. |
| `fermeture-menu.ogg` | Son de fermeture de menu. |

---

## 6. `Fonds_Laurux/` — 5 fichiers

Fonds d'écran du logiciel (`.jpg`) : `Laurux1.jpg` … `Laurux5.jpg`. Utilisés par
[`.src/Communs/Fmenu.class`](.src/Communs/Fmenu.class) (`Chemin = "Fonds_Laurux/"`).

---

## 7. `tips/` — 1 fichier

| Fichier | Description |
|---------|-------------|
| `tips.fr` | Messages d'aide contextuels en français (activables via `Tips=1` dans la configuration). |

---

## 8. Fichiers hors contrôle de version

Présents sur le disque mais **absents** de `git ls-files` — à ne pas documenter comme des sources.

| Chemin | Nature | Statut |
|--------|--------|--------|
| `.gambas/` | Cache de compilation Gambas (459 fichiers) | Ignoré (`.gitignore`) |
| `Laurux` | Exécutable lié (80 Mo) | Ignoré |
| `.settings` | État de l'IDE Gambas (breakpoints, géométrie) | Ignoré |
| `.startup` | Point d'entrée de l'IDE | Ignoré |
| `.lang/*.pot` | ~461 catalogues de traduction i18n | Ignoré (`.lang/*.pot`) |
| `sha1.txt`, `branch.txt` | SHA-1 et branche Git (écrits par le `Makefile`) | Ignoré |
| `Laurux.desktop`, `Laurux-Pos.desktop` | Entrées bureau générées | Ignoré |
| `output/` | Sorties des outils d'analyse | Ignoré |
| `*~` (114 fichiers) | **Sauvegardes Gambas** dans `.src/` | Ignoré (`*~`) |
| `*.orig` (2 fichiers) | Copies de sauvegarde (ex. `LauruxMaj.module.orig`) | Ignoré |
| `.src/Plugins/` (5 fichiers) | Ancien **système de plugins** — ne subsiste qu'en sauvegardes `*~` | **Inactif** |
| `.src/Gestion/Entrées/` | 5 fichiers, mais le chemin git est échappé (`Entr\303\251es`) | Suivi, chemin accentué à manager avec précaution |
| `Laurux01_converted.sqlite`, `Laurux01_default.sqlite`, `Laurux01_chezjeanne.sqlite` | Bases SQLite de travail | Non suivies |
| `.connection/` | Connexions enregistrées par l'IDE | Ignoré |
| `.action/` | Actions de l'IDE | Non suivie |

### 8.1. Points de vigilance

| Sujet | Constat |
|-------|---------|
| **Système de plugins désactivé** | `.src/Plugins/` ne contient que des `*~` (5 fichiers : `Plugins.module~`, `PluginsGestion.class~`, `PluginsGestion.form~`, `SimplePlugins.class~`, `Context.class~`). Aucun code actif ne les référence ; `gbc3`/`gba3` ne sont donc requis qu'au build. |
| **Doublon `Images/monnaie`** | `.src/Images/monnaie/` duplique `Icones/Euros/` à l'identique (16 fichiers) et n'est référencé par aucune source. |
| **Doublon `numtostring`** | `.src/Caisse/numtostring.module` et `.src/Utils/Numtostring.module` coexistent (casse différente). |
| **`Fmenuc.class~`** | Sauvegarde d'un ancien menu (`Fmenuc`) à côté de `Fmenu.class` actif. |
| **`.info` / `.list`** | Doivent être maintenus **à la main** en même temps que les classes : Gambas s'appuie dessus pour les classes sans formulaire. |
| **Chemin accentué** | `.src/Gestion/Entrées/` apparaît échappé dans Git (`Entr\303\251es`) — piège classique pour les scripts. |

---

## 9. Conventions de nommage

| Préfixe / suffixe | Signification | Exemples |
|-------------------|---------------|----------|
| `F` (préfixe) | **Formulaire** (fenêtre) | `Fmenu`, `FClient`, `FAbout` |
| `C` (préfixe) | Classe **métier** ou conteneur | `Cbase`, `Cprod`, `Cstock` |
| `E` (préfixe) | Écran d'**édition** | `EdArt1`, `EdClient`, `Editfac` |
| `F` (infixe `…Fm`) | Facture de **fin de mois** | `Facturefm`, `FacturefmA` |
| `Tri` (préfixe) | Écran de **tri / recherche** | `TriArticles`, `TriEcritures` |
| `Stat` / `Vis` (préfixe) | Statistique / sa visualisation | `StatFour`, `VisStatFour` |
| `Raz` (préfixe) | **Remise à zéro** (purge) | `RazArt`, `RazClos` |
| `Ed` (préfixe) | Édition / impression | `EdReg`, `EdImp` |
| `L` (préfixe) | Objet générique de conversion/formatage `Laurux` de type | `LPrix`, `LDate`, `LTrans` |
| `DB_` (préfixe) | Couche **base de données** | `DB_Connection`, `DB_Log` |
| `.class` + `.form` | Classe et son formulaire (paire obligatoire) | `Utils.module` (sans formulaire) |
| `.module` | Module : procédures globales, sans état d'instance | `Utils.module`, `Cbase.module` |
| `.report` | Gabarit d'état `gb.report2` | `Editfac.report` |

---

*Document généré par analyse du listing `git ls-files` (992 entrées) du dépôt Laurux v3.69.0 —
à maintenir à jour lors de l'ajout, du déplacement ou du retrait d'un fichier suivi par Git.*
