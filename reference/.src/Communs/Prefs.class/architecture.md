# Prefs — Architecture

> Source : `.src/Communs/Prefs.class`

## Vue d'ensemble

`Prefs` est la **fenêtre des préférences** de Laurux (11 onglets, environ 160 contrôles). Elle lit
et écrit un objet `Settings` (gb.settings, format INI) reçu au constructeur, qui peut être :

- en **mode local** (`IsGlobal = False`, menu Fmenu `Menu110`) : `Start.LocalSettings`, c'est-à-dire
  `~/.config/gambas3/Laurux.conf` (ou le fichier passé par `-c`) ;
- en **mode global** (`IsGlobal = True`, menu Fmenu `Menu329`, fonction « expérimentale ») : un
  fichier temporaire `Temp$("global_Laurux.conf")` dont le contenu est stocké dans la colonne blob
  `conf` de `Fiches_Parametres` (une base par société, donc un blob par société).

La classe porte aussi la **mécanique de surcharge locale/globale** (`ReadGlobal`, `ApplyGlobal`),
appelée par `Fmenu` au démarrage. C'est le seul point du code qui lit ou écrit la colonne `conf`.

Elle gère 163 clés de configuration (tableau exhaustif en fin de document) : 105 locales
seulement, 55 locales et globales, 2 globales seulement (`AdminG`, `MdpPrefsG`) et 1 lue mais
jamais écrite (`Kgl`). **Chaque fermeture de la fenêtre enregistre** : il n'y a pas de bouton
« Annuler ».

Nature globale : **GUI**, avec quelques traitements isolables : SQL de remplissage des listes,
SQL d'écriture du blob `conf`, et la fusion `ApplyGlobal` (calcul pur sur deux `Settings`).

## Mécanisme de surcharge locale / globale

```
Démarrage (Fmenu.Form_Open l.191-194)
  Pr = New Prefs(Start.LocalSettings)
  Start.GlobalSettings = Pr.ReadGlobal()     ' blob conf → Temp$/global_Laurux.conf → Settings (ou Null)
  Pr.ApplyGlobal(Start.GlobalSettings)       ' copie chaque clé globale dans le local, puis Save()
```

1. **Lecture du global** (`ReadGlobal`) : `SELECT * FROM Fiches_Parametres` ; si `conf` est non vide,
   le blob est écrit tel quel dans `Temp$("global_Laurux.conf")` et ouvert comme `Settings`.
   Sinon : `Null`.
2. **Application** (`ApplyGlobal`) : pour chaque section et chaque clé du global, la valeur est
   recopiée dans le `Settings` courant si elle est absente ou différente, puis le fichier local est
   **sauvegardé**. Le global **gagne toujours** : une clé globale modifiée localement est écrasée
   au prochain démarrage, à la prochaine ouverture de `Prefs` locale (`Form_Open` l.122) et à sa
   fermeture (`form_close` l.761), sans avertissement. Les clés absentes du global ne sont pas
   touchées ; une clé supprimée du global reste dans le local.
   Les tableaux (`ipr`, `Integer[]`) sont comparés par référence : ils sont toujours recopiés.
3. **Édition du global** (Fmenu `Menu329`) : `New Prefs(Start.GlobalSettings, Null, True)`. Si aucun
   global n'existe, `_new` demande confirmation puis crée un `Settings` vide dans le fichier
   temporaire. À la fermeture (`form_close`), seules les clés « G+L » et « G » sont écrites (le
   bloc « paramètres locaux » l.607-752 est sauté), puis le fichier est rechargé en texte et
   stocké par `UPDATE Fiches_Parametres SET conf = &1` (sans `WHERE` : table mono-ligne). Fmenu
   rejoue ensuite `ApplyGlobal` sur le local.
   ⚠️ La distribution des trois arguments entre `Prefs._new(Current_Settings, IsGlobal)` et le
   constructeur hérité de `Form` est **à confirmer** (un test replay T05 la fige).
4. **Suppression du global** (`Supprime_Click`, bouton visible en mode global seulement) :
   `UPDATE … SET conf = NULL`, suppression du fichier temporaire, `Start.GlobalSettings = Null`.
   Les valeurs déjà recopiées dans les fichiers locaux des postes **restent** en place.
5. **Lecteurs** : le reste du code lit toujours `Start.LocalSettings` (après surcharge), sauf
   Fmenu `Menu329` qui lit `AdminG` dans `Start.GlobalSettings`. `MDP.class:32` lit `MdpPrefsG` ou
   `MdpPrefs` dans le local (copie issue du global pour `MdpPrefsG`).

`Parametre` lit `Fiches_Parametres` mais ne touche jamais `conf` (voir
[Parametre](../Parametre.class/architecture.md)).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 29 |
| `Fontes` | var | Private |  | String | 30 |
| `hImage` | var | Private |  | Image | 31 |
| `hImage2` | var | Private |  | Image | 32 |
| `ipos` | var | Private |  | Integer | 33 |
| `$check` | var | Private |  | New CheckBox[] | 34 |
| `$ipr` | var | Private |  | New Integer[] | 35 |
| `global` | var | Private |  | Boolean | 36 |
| `cursettings` | var | Private |  | Settings | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 40-65 | Public | 5 | 19 | 0 | méthode spéciale |
| `ReadSettings` | 67-71 | Public | 1 | 3 | 1 |  |
| `ReadGlobal` | 75-93 | Public | 4 | 15 | 1 |  |
| `ApplyGlobal` | 95-113 | Public | 7 | 14 | 1 |  |
| `Form_Open` | 115-450 | Public | 186 | 303 | 0 | handler GUI |
| `Mdp_KeyPress` | 455-459 | Public | 4 | 3 | 0 | handler GUI |
| `Mdp_LF` | 461-483 | Public | 5 | 20 | 0 | portée réductible ? |
| `AdminG_Click` | 485-495 | Public | 2 | 9 | 0 | handler GUI |
| `Admin_Click` | 497-507 | Public | 2 | 9 | 0 | handler GUI |
| `Button2_Click` | 509-513 | Public | 1 | 3 | 0 | handler GUI |
| `form_close` | 515-766 | Public | 11 | 218 | 0 | handler GUI |
| `Cmpt_keypress` | 768-776 | Public | 7 | 7 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 778-789 | Public | 5 | 8 | 0 | handler GUI |
| `NmBr_pays` | 791-803 | Public | 3 | 10 | 0 | portée réductible ? |
| `Echeances` | 805-818 | Public | 5 | 11 | 0 | portée réductible ? |
| `Typeclient` | 820-833 | Public | 5 | 11 | 0 | portée réductible ? |
| `Tva550_Click` | 836-844 | Public | 2 | 7 | 0 | handler GUI |
| `MO_Click` | 846-854 | Public | 2 | 7 | 0 | handler GUI |
| `Exp_Click` | 856-862 | Public | 1 | 5 | 0 | handler GUI |
| `Imp_Click` | 864-870 | Public | 1 | 5 | 0 | handler GUI |
| `Libdevis_Click` | 872-880 | Public | 2 | 7 | 0 | handler GUI |
| `TxtF_Click` | 882-891 | Public | 2 | 8 | 0 | handler GUI |
| `Bchemin10_Click` | 893-903 | Public | 2 | 9 | 0 | handler GUI |
| `Svs_Click` | 905-915 | Public | 2 | 9 | 0 | handler GUI |
| `Svs2_Click` | 917-927 | Public | 2 | 9 | 0 | handler GUI |
| `Svs3_Click` | 929-939 | Public | 2 | 9 | 0 | handler GUI |
| `Svs4_Click` | 941-951 | Public | 2 | 9 | 0 | handler GUI |
| `codeTva_Click` | 953-957 | Public | 1 | 3 | 0 | handler GUI |
| `Zebra_Click` | 959-969 | Public | 2 | 9 | 0 | handler GUI |
| `Ecr_Click` | 971-983 | Public | 3 | 10 | 0 | handler GUI |
| `Lgo2_Click` | 985-1001 | Public | 4 | 15 | 0 | handler GUI |
| `Phot_Click` | 1003-1013 | Public | 2 | 9 | 0 | handler GUI |
| `FileFilter` | 1015-1023 | Private | 1 | 6 | 0 |  |
| `aff_logo` | 1025-1034 | Public | 3 | 8 | 0 | portée réductible ? |
| `dwgImage_Draw` | 1036-1040 | Public | 2 | 3 | 0 | handler GUI |
| `Copie_Click` | 1042-1050 | Public | 2 | 7 | 0 | portée réductible ? |
| `Bchemin_Click` | 1052-1062 | Public | 2 | 9 | 0 | handler GUI |
| `Button3_Click` | 1067-1071 | Public | 1 | 3 | 0 | handler GUI |
| `Btq_Click` | 1073-1082 | Public | 1 | 2 | 0 | handler GUI |
| `Button1_Click` | 1084-1100 | Public | 4 | 14 | 0 | handler GUI |
| `sauvauto_Click` | 1102-1116 | Public | 3 | 13 | 0 | handler GUI |
| `Envoiftp_Click` | 1118-1126 | Public | 2 | 7 | 0 | handler GUI |
| `Affichage` | 1128-1137 | Public | 1 | 8 | 0 | portée réductible ? |
| `Masquage` | 1139-1148 | Public | 1 | 8 | 0 | portée réductible ? |
| `Bchemin2_Click` | 1150-1160 | Public | 2 | 9 | 0 | handler GUI |
| `Bchemin3_Click` | 1162-1170 | Public | 2 | 6 | 0 | handler GUI |
| `Bchemin4_Click` | 1172-1182 | Public | 2 | 9 | 0 | handler GUI |
| `Bchemin5_Click` | 1184-1194 | Public | 2 | 9 | 0 | handler GUI |
| `Bchemin6_Click` | 1196-1206 | Public | 2 | 9 | 0 | handler GUI |
| `Bchemin7_Click` | 1208-1215 | Public | 2 | 6 | 0 | handler GUI |
| `Bchemin8_Click` | 1217-1227 | Public | 2 | 9 | 0 | handler GUI |
| `Bchemin9_Click` | 1229-1239 | Public | 2 | 9 | 0 | handler GUI |
| `Impetiq_Click` | 1241-1251 | Public | 2 | 9 | 0 | handler GUI |
| `Sms_Click` | 1253-1275 | Public | 2 | 21 | 0 | handler GUI |
| `Lgo4_Click` | 1277-1293 | Public | 4 | 15 | 0 | handler GUI |
| `aff_logo2` | 1295-1308 | Public | 3 | 11 | 0 | portée réductible ? |
| `slide_click` | 1310-1314 | Public | 2 | 3 | 0 | handler GUI |
| `dwgImage2_Draw` | 1316-1320 | Public | 2 | 3 | 0 | handler GUI |
| `api_LostFocus` | 1322-1339 | Public | 5 | 15 | 0 | handler GUI |
| `pp_Click` | 1341-1349 | Public | 2 | 6 | 0 | handler GUI |
| `bois_Click` | 1351-1359 | Public | 2 | 6 | 0 | handler GUI |
| `Textfam_LostFocus` | 1361-1369 | Public | 3 | 8 | 0 | handler GUI |
| `Textfam_KeyPress` | 1371-1379 | Public | 4 | 7 | 0 | handler GUI |
| `afffam` | 1381-1407 | Public | 8 | 24 | 0 | portée réductible ? |
| `CheckBox2_Click` | 1409-1417 | Public | 2 | 7 | 0 | handler GUI |
| `Support_Change` | 1419-1436 | Public | 3 | 14 | 0 | handler GUI |
| `Supprime_Click` | 1439-1453 | Public | 4 | 11 | 0 | handler GUI |
| `MdpStmp_KeyPress` | 1455-1461 | Public | 2 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et surcharge globale

- **`_new(Current_Settings, IsGlobal)`** [portée : nécessaire] [nature : mixte]. Mémorise le mode
  (`global`) et le `Settings` (`cursettings`) ; affiche le chemin du fichier dans `TextLabel2`. En
  mode global avec `Current_Settings = Null` : `Message.Warning` (« expérimentale »), puis création
  d'un `Settings` vide dans `Temp$("global_Laurux.conf")` (après `Kill`). Si l'utilisateur annule,
  `cursettings` reste `Null` : toutes les lectures de `Form_Open` échouent sous `Try` et
  `form_close` sort immédiatement.
- **`ReadSettings()`** [portée : nécessaire, Fmenu l.1174] [nature : calcul]. Renvoie `cursettings`.
- **`ReadGlobal()`** [portée : nécessaire, Fmenu l.193/1188] [nature : calcul].
  SQL : `SELECT * FROM Cbase.Table("TabParam")`. Écrit le blob dans un fichier temporaire.
  Renvoie un `Settings` ou `Null`. ⚠️ `(rResult!conf).Length` sur un blob `NULL` : comportement à
  confirmer (vraisemblablement un objet `Blob` de longueur 0).
- **`ApplyGlobal(Global_Settings)`** [portée : nécessaire, Fmenu l.194/1188] [nature : calcul].
  Fusion décrite ci-dessus, puis `cursettings.Save()`. Sans effet si l'un des deux est `Null`.

### Ouverture : `Form_Open` (CC 186, 303 lignes)

[portée : nécessaire (handler)] [nature : mixte]. Dans l'ordre :

1. Mode local : `ApplyGlobal(ReadGlobal())` (sauvegarde du fichier local **avant** affichage) et
   bouton `Supprime` masqué. Mode global : 51 affectations `Background = &HFFEFBF` (dont 3 en double,
   l.168-173) qui signalent les contrôles enregistrés aussi en global.
2. `Utils.Observers(Me)`, centrage, remplissage des listes : `NmBr_pays` (fichier `Pays.txt`),
   `Echeances` (`TabEch`), `Typeclient` (`TabTypec`), codes TVA (`Fiches_Tvaav`, nom **en dur**
   l.186) et taux de main-d'œuvre (`TabTxmo`).
3. `Shell "gbx3 -V" To sVer` : résultat jamais utilisé (code mort qui lance un processus).
   `Majver` masqué si l'application est installée dans `/usr/bin`.
4. Environ 150 lectures `Try <contrôle> = cursettings[clé]` (voir tableau). Valeurs par défaut
   codées : `Taxe` « Tva », `Port` « 25 », `Siret` « Siret », police « Serif,9 », `nbfam` « 5 »,
   **`ServerLogIP` « 127.0.0.1 » et `ServerLogPort` 6556**. Les mots de passe (`MdpPrefs`,
   `MdpPrefsG`, `MdpStmp`, `MdpFTP`, `MdpFTP3`) sont déchiffrés par `hexdblKey.crypt("de", …)`.
5. Visibilités conditionnelles : `codetva`, `Mdp2`/`Mdp2G`, `Panexp`/`Panimp`/`Expmail`, `LTxtF`,
   `codeMO`, bloc SMS (lu **sans** `Try` l.399-402), `Panel4`, Zebra (⚠️ affiche `Label27`, le
   libellé FTP, au lieu de `Label31`), familles (`afffam`).
6. Infobulles des scripts de scan (`ScanGui`, `ScanBatch`, `ScanConvert`).

### Fermeture : `form_close` (CC 11, 218 lignes)

[portée : nécessaire (handler)] [nature : mixte]. Sort si `cursettings` est `Null`. Écrit :

- mode global seulement : `MdpPrefsG` (chiffré) et `AdminG` ;
- les deux modes : 55 clés, dont `ServerLogIP`/`ServerLogPort` (la valeur par défaut affichée
  127.0.0.1 est donc **persistée dès la première fermeture**), `Codetva` = 1ᵉʳ caractère,
  `CodeMO` = texte avant le premier « - » (⚠️ si le texte ne contient pas « - », `Left$(x, -1)`
  supprime le dernier caractère), `ipr` = indices (base 1) des cases cochées de `Panelfam` ;
  écritures en double l.578-583 (`Devis`, `Libdevis`, `Devis2`) ;
- mode local seulement : 105 clés, puis appel de `Fmenu.Menushowhide` (Exp), `Menu2showhide`
  (Btq), `Menu3showhide` (Materiel), `Menu4showhide` (Caisse) avec « 1 »/« 0 » ;
- enfin : mode global → `Save`, `File.Load` du fichier et `UPDATE Fiches_Parametres SET conf = &1` ;
  mode local → `ApplyGlobal(ReadGlobal())` (les clés globales écrasent la saisie), `Save`, `Reload`.

### Mots de passe

- **`Mdp_KeyPress`**, **`Mdp_LF`** [portée : nécessaire (handler) / réductible pour `Mdp_LF`]
  [nature : mixte]. Vérifient le mot de passe administrateur saisi dans `Mdp` (conteneur `HBox20`).
  **Inatteignables** : `HBox20` est `Visible = False` dans le `.form` et n'est jamais affiché ; le
  contrôle d'accès est fait en amont par `MDP.class` (Fmenu). `Mdp_LF` joue `Music.Play` si
  `Start.son`.
- **`AdminG_Click`**, **`Admin_Click`** [GUI] : affichent et sélectionnent `Mdp2G`/`Mdp2`.
- **`MdpStmp_KeyPress`** [GUI] : F2 bascule l'affichage du mot de passe SMTP.

### Listes et saisies

- **`NmBr_pays`** [portée : réductible] [mixte] : lit `Pays.txt` (fichier du projet) ligne à ligne
  dans `Pays`. ⚠️ Le fichier n'est jamais fermé.
- **`Echeances`**, **`Typeclient`** [portée : réductible] [mixte] : `SELECT * FROM TabEch ORDER BY num`,
  `SELECT * FROM TabTypec ORDER BY code` ; libellés « code - libellé ».
- **`Cmpt_keypress`**, **`Cmpt_Lostfocus`** [handlers du groupe `Cmpt` : `Tp1`/`Tg1`] : filtre
  numérique puis format `0.00` selon `Tag`.
- **`Textfam_LostFocus`**, **`Textfam_KeyPress`**, **`afffam`** [`afffam` réductible] : nombre de
  familles (1 à 20) et cases à cocher dynamiques dans `Panelfam` (`$check`), précochées selon
  `$ipr` (défaut `[5]`). ⚠️ Un `ipr` contenant 0 provoque `$check[-1]` ; un `Textfam` vide donne
  `Val("") - 1` (erreur à confirmer).
- **`codeTva_Click`** : ne garde que le premier caractère.
- **`Support_Change`** : libellés « Identifiant/Mot de passe » (support 3) ou « Clé API/Type »
  (support 2) et visibilité `Api2`/`Api3`.
- **`api_LostFocus`** [mixte] : `Shell "curl http://www.spot-hit.fr/api/credits/?key=<clé>" > ~/tmp/sms.txt`,
  puis `Message.Error` si la réponse contient « erreur ». ⚠️ Clé concaténée dans une commande
  shell (injection), HTTP en clair, `~/tmp` supposé exister.

### Bascules de visibilité (GUI pur)

`Tva550_Click`, `MO_Click`, `Exp_Click`, `Imp_Click`, `Libdevis_Click`, `TxtF_Click`,
`Zebra_Click`, `Impetiq_Click`, `Sms_Click`, `CheckBox2_Click`, `sauvauto_Click`,
`Envoiftp_Click`, `Affichage`, `Masquage` [réductibles], `slide_click` (vide `Ecran` si décoché),
`Copie_Click` (⚠️ **mort** : aucun contrôle `Copie` dans le `.form` ; `Copie` désigne le module
`Copie`), `Btq_Click` (corps entièrement commenté).

### Sélecteurs de fichiers et répertoires (GUI pur)

`Bchemin_Click`, `Bchemin2_Click` … `Bchemin10_Click`, `Svs_Click`, `Svs2_Click`, `Svs3_Click`,
`Svs4_Click`, `Phot_Click` : même schéma `Dialog.SelectDirectory()` ; en cas d'annulation, le champ
reçoit `User.Home` (comportement surprenant mais constant). ⚠️ `Svs3_Click` écrit `User.Home` dans
`Chmexport` au lieu de `Chmimp` lors d'une annulation. `Bchemin3_Click`, `Bchemin7_Click` :
`Dialog.OpenFile()` (annulation sans effet). `Bchemin2_Click` a le titre « Choisir un fichier » mais
sélectionne un répertoire.
`Ecr_Click`, `Lgo2_Click`, `Lgo4_Click` : choix du fond d'écran et des logos (`FileFilter` : `*.jpg`),
`aff_logo`/`aff_logo2` [réductibles] et `dwgImage_Draw`/`dwgImage2_Draw` : affichage du logo.
`Ecr_Click` déclare `NmFic`/`ific` inutilisés.

### Divers

- **`Button1_Click`** [mixte] : test de synthèse vocale (`pico2wave … msg.wav` dans le répertoire
  courant, puis `Shell "pico2wave ; aplay msg.wav"`, dont le premier `pico2wave` sans argument est
  inutile).
- **`pp_Click`**, **`bois_Click`** [mixte] : à l'activation des options métiers carburant/boisson,
  `modfichier.fichiercarbu`/`fichierboisson` puis `modfichier.supf` **modifient le schéma** de la
  base (colonnes optionnelles de `Fiches_Parametres`, `Fiches_Societes`, table `Art_Tipp`, voir
  `modfichier.module`), immédiatement, avant toute fermeture de la fenêtre.
- **`Supprime_Click`** : voir mécanisme global, point 4.
- **`Button2_Click`** : `Me.Close` (donc enregistrement). **`Button3_Click`** : `Doc.Open("Prefs")`.
- **`FileFilter`** [Private] : filtre `*.jpg`, paramètre `All` ignoré.

## État global utilisé

- `Start.Societe` (préfixe de section `/Soc<XX>`), `Start.son`, `Start.GlobalSettings` (mis à
  `Null` par `Supprime_Click`).
- `Utils.db` (SQL), `Utils.Observers`, `Utils.cpoint`, `Utils.totobs`, `hexdblKey.crypt`.
- `Fmenu.Menushowhide`, `Menu2showhide`, `Menu3showhide`, `Menu4showhide` (auto-instance de la
  fenêtre principale).
- `modfichier` (modification de schéma pour les options pp/bois).
- Fichiers : `Pays.txt` (projet), `Temp$("global_Laurux.conf")`, `~/tmp/sms.txt`, `msg.wav`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **Table de description des clés** : un tableau privé `[clé, contrôle, propriété, mode]` (les 163
  lignes ci-dessous) parcouru par deux boucles, l'une pour `Form_Open`, l'autre pour `form_close`.
  Les cas particuliers (mots de passe chiffrés, `Codetva`, `CodeMO`, `ipr`, police, défauts) restent
  explicites. CC de `Form_Open` : 186 → environ 30. L'ordre d'écriture des **nouvelles** clés dans
  `Laurux.conf` peut changer : les tests comparent un fichier normalisé (sections et clés triées).
- Coloration des contrôles globaux : boucle sur la même table (mode « G+L ») au lieu de 51 lignes,
  ce qui supprime aussi les doublons.
- Factoriser les 12 sélecteurs de répertoire en `ChoisirRepertoire(hCible As TextBox, sTitre)`,
  en conservant les exceptions actuelles (titres, cible de `Svs3_Click`).
- Remplacer les bascules `If x Then a.Visible = True Else a.Visible = False` par
  `a.Visible = x.Value`.

### Commonalisation avec d'autres fichiers

- Les valeurs de création d'une société sont dupliquées dans `Fmenu.preferences()` (l.421-470) et
  dans [`LauruxConf`](../LauruxConf.class/architecture.md) (l.349-395), avec des différences
  (`Slide`, `Pays`, `Impbl`, `Exp`, `Lettrage`) et des défauts incohérents avec ceux de `Prefs`
  (`Taxe` « TVA » contre « Tva », police « Serif,+1 » contre « Serif,9 »). Une procédure
  `Prefs.Defauts(hSettings, sSoc)` statique (ou dans un module) porterait la partie commune ;
  chaque appelant conserverait ses ajouts. Voir aussi [Fmenu](../Fmenu.class/architecture.md).
- Le chiffrement `hexdblKey.crypt(…, "Laurux")` des mots de passe est répété 11 fois ici et dans
  `MDP`, `Prgm`, `EnvMail`, `SauvesAuto` : deux helpers `Utils.MdpLire(clé)` / `Utils.MdpEcrire`.
- Les visibilités de `Label27`/`Label31`/`IpZebra` sont gérées à 3 endroits (`Form_Open`,
  `Zebra_Click`, `Impetiq_Click`).

### Réduction de portée

`NmBr_pays`, `Echeances`, `Typeclient`, `aff_logo`, `aff_logo2`, `afffam`, `Affichage`,
`Masquage`, `Mdp_LF` : aucun appelant externe (vérifié par `grep -rn "Prefs\."`). `ReadSettings`,
`ReadGlobal`, `ApplyGlobal` restent `Public` (Fmenu). Les handlers gardent leur portée.

### Séparation traitement / GUI

- `EcrireConfGlobale(sConf As Variant)` : seul point d'écriture SQL du blob (utilisé par
  `form_close` et `Supprime_Click`).
- `ListeEcheances()`, `ListeTypesClient()`, `ListeCodesTva()`, `ListeTauxMo()` renvoyant des
  `String[]` ; les handlers remplissent les `ComboBox`.
- `CodeAvantTiret(s)` pour `CodeMO` (comportement actuel conservé, anomalie comprise).
- `ApplyGlobal` est déjà une fonction de calcul : la rendre testable en gb.test sans instancier la
  fenêtre (méthode `Static`), ce qui demande de passer le `Settings` cible en paramètre.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker la configuration globale dans une table clé/valeur (`Fiches_Config(section, cle, valeur)`)
  plutôt qu'un blob INI : fusion clé par clé, suppression ciblée, historique, et plus de fichier
  temporaire.
- Les options métiers (pp/bois) ajoutent des colonnes à la volée (`modfichier`) : les intégrer au
  schéma de référence (`db_control.csv`) avec une migration `LauruxMaj` supprimerait les schémas
  variables selon les postes.

## Clés de configuration (référence pour les tests)

Légende :
- **Mode** : `L` = écrite seulement en mode local ; `G+L` = écrite dans les deux modes (donc
  surchargeable par le global) ; `G` = mode global seulement ; `lecture seule` = jamais écrite.
- `<XX>` = `Start.Societe`. Les numéros de ligne renvoient à `Prefs.class` (commit `6b6b9dfc`).
- **Défaut Prefs** : valeur affichée (puis enregistrée à la fermeture) si la clé est absente.
- **Défaut création** : valeur écrite par `Fmenu.preferences()` et `LauruxConf` à la création ou
  réinitialisation d'une société ; `(F)` = Fmenu seulement, `(C)` = LauruxConf seulement.
  Ces deux fichiers écrivent aussi `/Soc<XX>/Copie` = 0, jamais lu par `Prefs`.
- **Lecteurs** : `grep` des accès `"/Soc" & … & "/Clé"` et `["/Clé"]` hors `Prefs.class`, hors
  écritures de valeurs par défaut (Fmenu l.421-470, LauruxConf l.340-400). `…` = autres lignes
  dans le même fichier. `_aucun_` = clé écrite mais jamais lue ailleurs (voir PREFS-A06).
- Clés voisines **distinctes** à ne pas confondre : `/Soc<XX>/caisse/qt1` (Caisse/Preferences)
  n'est pas `/Soc<XX>/Qt1` ; `/dbase/Port` et `/dbase/Prefixe` ne sont pas `/Port` et
  `/Soc<XX>/Prefixe`.

| # | Clé | Contrôle (type) | Lu (ligne) | Écrit (ligne) | Mode | Défaut Prefs si absente | Défaut création | Lecteurs hors Prefs (fichier:ligne) |
|---|---|---|---|---|---|---|---|---|
| 1 | `/son` | `son` (CheckBox) | 206 | 610 | L | non définie (contrôle vide / `False`) | 0 | Start.module:120, Variables.module:3, Impart.class:86 |
| 2 | `/son2` | `son2` (CheckBox) | 207 | 611 | L | non définie (contrôle vide / `False`) | – | Syntheses.module:8 |
| 3 | `/Tips` | `Tip` (CheckBox) | 208 | 612 | L | non définie (contrôle vide / `False`) | 1 | Start.module:328, FTips.class:107 |
| 4 | `/Soc<XX>/Conditions` | `Conditions` (CheckBox) | 209 | 540 | G+L | non définie (contrôle vide / `False`) | 1 | Facturergbl.class:451, OptFac.class:127, ObjFac.class:213 |
| 5 | `/Soc<XX>/Tva550` | `Tva550` (CheckBox) | 210 | 541 | G+L | non définie (contrôle vide / `False`) | 0 | Facture.class:306 |
| 6 | `/Soc<XX>/Codetva` | `codetva` (ComboBox) | 213 | 542 | G+L | non définie (contrôle vide / `False`) | `" "` | Facture.class:308 |
| 7 | `/Soc<XX>/AdminG` | `AdminG` (CheckBox) | 220 | 532 | G | non définie (contrôle vide / `False`) | – | Fmenu.class:1176 |
| 8 | `/Soc<XX>/MdpPrefsG` | `Mdp2G` (TextBox) | 222 | 531 | G | non définie (contrôle vide / `False`) | – | MDP.class:32 (nom de clé dynamique) |
| 9 | `/Soc<XX>/Admin` | `Admin` (CheckBox) | 230 | 537 | G+L | non définie (contrôle vide / `False`) | – | Fmenu.class:634,690,829…, Prgm.class:7, Fsoc.class:400 |
| 10 | `/Soc<XX>/MdpPrefs` | `Mdp2` (TextBox) | 232,466 | 536 | G+L | non définie (contrôle vide / `False`) | – | Prgm.class:31, MDP.class:32 (nom de clé dynamique) |
| 11 | `/Soc<XX>/Slide` | `Slide` (CheckBox) | 236 | 609 | L | non définie (contrôle vide / `False`) | 1 (F) | Fmenu.class:114 |
| 12 | `/Soc<XX>/Tme` | `Tme` (CheckBox) | 237 | 608 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:47 |
| 13 | `/Soc<XX>/Taxe` | `Taxe` (TextBox) | 238 | 543 | G+L | `"Tva"` (Prefs l.239, `.form`) | `"TVA"` | Cstocks.class:298, Cdocuments.class:797,798,800…, Cdocuments2.class:683,684,686…, Carticles.class:459, Facture.class:448,449,450…, ObjFac.class:257, MvtProdcomp.class:273, Movr.class:69, Articles.class:170, Famille.class:66, ConsultArt.class:77 |
| 14 | `/Rep_Sauv` | `Sauves` (TextBox) | 240 | 613 | L | non définie (contrôle vide / `False`) | – | FRestore.class:33, SauvesAuto.module:9, FSauve.class:35, Expbase.class:46,48 |
| 15 | `/Soc<XX>/Fichiers` | `Chemin10` (TextBox) | 241 | 614 | L | non définie (contrôle vide / `False`) | – | LauruxMaj.module:6108,6110, Bordrx.class:324,327,328… |
| 16 | `/Soc<XX>/Entete` | `Entete` (CheckBox) | 242 | 539 | G+L | non définie (contrôle vide / `False`) | 1 | Facturergbl.class:450, OptFac.class:126, ObjFac.class:212 |
| 17 | `/Soc<XX>/Prefixe` | `Prefixe` (CheckBox) | 246 | 544 | G+L | non définie (contrôle vide / `False`) | – | Fsoc.class:95,115, LauruxConf.class:52,60,79 |
| 18 | `/Soc<XX>/Lcr` | `Lcr` (CheckBox) | 247 | 545 | G+L | non définie (contrôle vide / `False`) | – | Fmenu.class:104, Traites.class:11,81, Mreglement.class:47 |
| 19 | `/Soc<XX>/Devis` | `Valdevis` (TextBox) | 248 | 578,581 | G+L | non définie (contrôle vide / `False`) | – | ObjFac.class:264 |
| 20 | `/Soc<XX>/Libdevis` | `Libdevis` (CheckBox) | 249 | 579,582 | G+L | non définie (contrôle vide / `False`) | – | ObjFac.class:262 |
| 21 | `/Soc<XX>/Devis2` | `Valdevis2` (TextBox) | 250 | 580,583 | G+L | non définie (contrôle vide / `False`) | – | Cdocuments.class:1036, Cdocuments2.class:951,956, ObjFac.class:263 |
| 22 | `/Soc<XX>/Recap` | `Recap` (CheckBox) | 251 | 571 | G+L | non définie (contrôle vide / `False`) | – | Facturergbl.class:454, OptFac.class:124,135, ObjFac.class:210 |
| 23 | `/Soc<XX>/Impttc` | `Impttc` (CheckBox) | 252 | 572 | G+L | non définie (contrôle vide / `False`) | – | Facture.class:2524, ObjFac.class:211 |
| 24 | `/Soc<XX>/Faca` | `FacA` (CheckBox) | 253 | 573 | G+L | non définie (contrôle vide / `False`) | – | Fmenu.class:137,227, LauruxMaj.module:710, Facture.class:327, FClient.class:85 |
| 25 | `/Soc<XX>/Exp` | `Exp` (RadioButton) | 254 | 618 | L | non définie (contrôle vide / `False`) | 1 (C) | Fmenu.class:89 |
| 26 | `/Soc<XX>/Expmail` | `Expmail` (CheckBox) | 255 | 619 | L | non définie (contrôle vide / `False`) | – | ExportJdv.class:78, ExportA47.class:49 |
| 27 | `/Soc<XX>/Imp` | `Imp` (RadioButton) | 256 | 620 | L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 28 | `/Soc<XX>/Adr-export` | `Adrexport` (TextBox) | 257 | 622 | L | non définie (contrôle vide / `False`) | – | ExportJdv.class:77,265, ExportA47.class:48,221 |
| 29 | `/Soc<XX>/Chemin-import` | `Chmimp` (TextBox) | 258 | 623 | L | non définie (contrôle vide / `False`) | – | ImpSage.class:87, ImpJdv.class:88 |
| 30 | `/Soc<XX>/Chemin-export` | `Chmexport` (TextBox) | 259 | 621 | L | non définie (contrôle vide / `False`) | – | ExportJdv.class:75,266,991…, ExportA47.class:46,222,344 |
| 31 | `/Soc<XX>/Qt1` | `Qt1` (CheckBox) | 260 | 624 | L | non définie (contrôle vide / `False`) | 0 | _aucun_ |
| 32 | `/Soc<XX>/Cqte` | `Cqte` (CheckBox) | 261 | 625 | L | non définie (contrôle vide / `False`) | – | Facture.class:6603,6636,6719 |
| 33 | `/Soc<XX>/Adr-base` | `Adrbase` (TextBox) | 262 | 642 | L | non définie (contrôle vide / `False`) | – | Expbase.class:34 |
| 34 | `/Soc<XX>/Coef` | `Cof` (RadioButton) | 263 | 569 | G+L | `True` (radio `.form`) | – | _aucun_ |
| 35 | `/Soc<XX>/Tmq` | `Tq` (RadioButton) | 264 | 570 | G+L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 36 | `/Soc<XX>/Coul_fen` | `Gcf` (CheckBox) | 265 | 627 | L | non définie (contrôle vide / `False`) | 0 | FTips.class:45, Utils.module:1024, DataButtonList.class:77, Etiquettes.class:89,99, Eticli.class:903,913, FacturefmA.class:495, Facturefm.class:635, Facture.class:11461, ValidBR.class:515, Emailing.class:961,973, EmailingCarte.class:607,619, Banque.class:54, Glcr.class:29, Bordrx.class:72, Lcr.class:70, Attribution.class:65, Preparation.class:77, Movr.class:103,111,139…, Identite.class:151,163, Typec.class:148,160, Statut.class:141,153, Materiel.class:168, Articles.class:3815, FFournisseur.class:135,141, Centrales.class:139,151, FClient.class:254,260, Famille.class:326, ConsultArt.class:188, RelMoprod.class:722, Ccomptes.module:20, TriFac.class:65, TriFac2.class:89, Archives.class:251 |
| 37 | `/Soc<XX>/Infob` | `Infob` (CheckBox) | 266 | 628 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:196 |
| 38 | `/Soc<XX>/glogo` | `Lgo` (CheckBox) | 267 | 636 | L | non définie (contrôle vide / `False`) | – | Bordereaux.class:149, Cfacture.class:321, Cdocuments.class:110,287,308, Creleve.class:173, Cdocuments2.class:234,255, Clivre.class:175,196, Facturergbl.class:564, ObjFac.class:270, Edcom.class:237, RelvMo.class:375 |
| 39 | `/Soc<XX>/glogo3` | `Lgo3` (CheckBox) | 268 | 637 | L | non définie (contrôle vide / `False`) | – | Cdocuments.class:111,118,272, ObjFac.class:269 |
| 40 | `/Soc<XX>/glogo5` | `Lgo5` (CheckBox) | 269 | 638 | L | non définie (contrôle vide / `False`) | – | Cdocuments.class:114 |
| 41 | `/Soc<XX>/glogo6` | `Lgo6` (CheckBox) | 270 | 639 | L | non définie (contrôle vide / `False`) | – | Cdocuments.class:115,118 |
| 42 | `/Soc<XX>/Logo` | `Logo` (TextBox) | 273 | 640 | L | non définie (contrôle vide / `False`) | – | Bordereaux.class:150, Cfacture.class:322,323, Cdocuments.class:288,309,310, Editfac.class:71, Creleve.class:174,175, Cdocuments2.class:235,256,257, Clivre.class:176,197,198, Facturergbl.class:564, Edcom.class:237, Edart4.class:394, RelvMo.class:375 |
| 43 | `/Soc<XX>/Logo2` | `Logo2` (TextBox) | 274 | 641 | L | non définie (contrôle vide / `False`) | – | Cdocuments.class:273, Editfac.class:40 |
| 44 | `/Soc<XX>/Rglt` | `Rglt` (CheckBox) | 275 | 584 | G+L | non définie (contrôle vide / `False`) | – | Facture.class:11047, ObjFac.class:248 |
| 45 | `/Majver` | `Majver` (CheckBox) | 276 | 644 | L | non définie (contrôle vide / `False`) | – | Majversion.class:152 |
| 46 | `/Soc<XX>/Kgl` | `Kgl` (CheckBox) | 277 | – | lecture seule | non définie (contrôle vide / `False`) | – | Etigond.class:115 |
| 47 | `/Soc<XX>/Ctrlstk` | `Ctrlstk` (CheckBox) | 278 | 585 | G+L | non définie (contrôle vide / `False`) | 0 | Facture.class:4893,4903 |
| 48 | `/Soc<XX>/Btq` | `Btq` (CheckBox) | 279 | 646 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:91 |
| 49 | `/Soc<XX>/Adrbtq` | `Adrbtq` (TextBox) | 282 | 648 | L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 50 | `/Soc<XX>/Identifiant` | `Identifiant` (TextBox) | 283 | 649 | L | non définie (contrôle vide / `False`) | – | Btqart.class:57 |
| 51 | `/Soc<XX>/Adradminart` | `Adradminart` (TextBox) | 284 | 650 | L | non définie (contrôle vide / `False`) | – | Btqart.class:58 |
| 52 | `/Soc<XX>/Adradminphot` | `Adradminphot` (TextBox) | 285 | 651 | L | non définie (contrôle vide / `False`) | – | Btqart.class:59 |
| 53 | `/Soc<XX>/Mdpadmin` | `Mdpadmin` (TextBox) | 286 | 652 | L | non définie (contrôle vide / `False`) | – | Btqart.class:60 |
| 54 | `/Soc<XX>/Photart` | `Photart` (TextBox) | 287 | 653 | L | non définie (contrôle vide / `False`) | – | EdArt2.class:47, EdArt1.class:48, EdArt3.class:48, Materiel.class:79 |
| 55 | `/Soc<XX>/AutoEnt` | `AutoEnt` (CheckBox) | 288 | 550 | G+L | non définie (contrôle vide / `False`) | 0 | Cdocuments.class:517,524,536…, Cdocuments2.class:443,448,455…, Facturergbl.class:1147,1152, Facture.class:322,328, ObjFac.class:254, Edbr.module:45,50 |
| 56 | `/Soc<XX>/Franchise` | `Franchise` (CheckBox) | 289 | 551 | G+L | non définie (contrôle vide / `False`) | – | Cdocuments.class:517,524,536…, Cdocuments2.class:443,448,455…, Facture.class:329,334, ObjFac.class:255 |
| 57 | `/Soc<XX>/Pvcons` | `Pvconseille` (CheckBox) | 290 | 552 | G+L | non définie (contrôle vide / `False`) | – | Impart.class:94, EdMat.class:401, EdArt2.class:564, EdArt1.class:575, EdArt3.class:649, Articles.class:124 |
| 58 | `/Smtp` | `Smtp` (TextBox) | 300 | 629 | L | non définie (contrôle vide / `False`) | – | Gsm.class:42, Emailing.class:125, EnvMail.module:16, EmailingCarte.class:73 |
| 59 | `/Adrmail` | `Adrmail` (TextBox) | 301 | 631 | L | non définie (contrôle vide / `False`) | – | Gsm.class:42, Emailing.class:125, EnvMail.module:18,26, EmailingCarte.class:73 |
| 60 | `/Port` | `Port` (TextBox) | 302 | 630 | L | `"25"` (l.306, `.form`) | – | EnvMail.module:17 |
| 61 | `/Secumail` | `secumail` (ComboBox) | 303 | 632 | L | non définie (contrôle vide / `False`) | – | EnvMail.module:21 |
| 62 | `/Utilisateur` | `Utilisateur` (TextBox) | 304 | 633 | L | non définie (contrôle vide / `False`) | – | EnvMail.module:19 |
| 63 | `/MdpStmp` | `MdpStmp` (TextBox) | 305 | 634 | L | non définie (contrôle vide / `False`) | – | EnvMail.module:20 |
| 64 | `/Soc<XX>/Poids` | `Poids` (CheckBox) | 307 | 586 | G+L | non définie (contrôle vide / `False`) | – | Facture.class:366,1164, ObjFac.class:244, ConsultArt.class:73 |
| 65 | `/Soc<XX>/Materiel` | `Materiel` (CheckBox) | 308 | 546 | G+L | non définie (contrôle vide / `False`) | – | Fmenu.class:93, VerifNumfac.module:11,74, Facture.class:303, ObjFac.class:271, Edpaiement.class:43, Articles.class:117, FClient.class:84,746, StatComm.class:52, TBord.class:10, StatTypCli.class:52, Histovmo.class:59, StatComArt.class:51, StatClimo.class:52, TriArticles.class:53, Archives.class:120,213,436, RazHistoFac.class:6, RazDevis.class:6 |
| 66 | `/Soc<XX>/Depots` | `Depots` (CheckBox) | 309 | 547 | G+L | non définie (contrôle vide / `False`) | – | Fcaisses.class:64, Facture.class:372, ObjFac.class:256, Famille.class:93 |
| 67 | `/Soc<XX>/Ged` | `Ged` (CheckBox) | 310 | 548 | G+L | non définie (contrôle vide / `False`) | – | ValidBR.class:714, ValidBR1.class:340 |
| 68 | `/Soc<XX>/Taches` | `Taches` (CheckBox) | 311 | 549 | G+L | non définie (contrôle vide / `False`) | – | Fmenu.class:97,237, Facture.class:352,1971 |
| 69 | `/Soc<XX>/Fecran` | `Ecran` (TextBox) | 312 | 635 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:109,110,111… |
| 70 | `/Soc<XX>/Font` | `FontChooser1` (FontChooser) | 315 | 654 | L | `"Serif,9"` (l.317) | `"Serif,+1"` | Start.module:160,299 |
| 71 | `/Soc<XX>/Coupon` | `Coupon` (CheckBox) | 321 | 655 | L | non définie (contrôle vide / `False`) | – | LauruxMaj.module:1933, ObjFac.class:251 |
| 72 | `/Soc<XX>/Factchemin` | `Chemin` (TextBox) | 322 | 656 | L | non définie (contrôle vide / `False`) | – | LGed.class:454, ObjFac.class:266 |
| 73 | `/Soc<XX>/FactcheminF` | `Chemin2` (TextBox) | 323 | 657 | L | non définie (contrôle vide / `False`) | – | LGed.class:456 |
| 74 | `/Soc<XX>/FactcheminP` | `Chemin4` (TextBox) | 324 | 658 | L | non définie (contrôle vide / `False`) | – | LGed.class:460 |
| 75 | `/Soc<XX>/FactcheminV` | `Chemin3` (TextBox) | 325 | 659 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:274 |
| 76 | `/Soc<XX>/FactcheminA` | `Chemin5` (TextBox) | 326 | 660 | L | non définie (contrôle vide / `False`) | – | LGed.class:462 |
| 77 | `/Soc<XX>/FactcheminC` | `Chemin6` (TextBox) | 327 | 661 | L | non définie (contrôle vide / `False`) | – | LGed.class:458, ValidBR1.class:261, EcrAuto.class:574, BordereauxC.class:294,295,296… |
| 78 | `/Soc<XX>/Pdfchemin` | `Chemin7` (TextBox) | 328 | 662 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:277, EnvMail.module:8,89 |
| 79 | `/Soc<XX>/Bexpchemin` | `Chemin8` (TextBox) | 329 | 663 | L | non définie (contrôle vide / `False`) | – | EnvMail.module:141 |
| 80 | `/Soc<XX>/Bexpcheminpj` | `Chemin9` (TextBox) | 330 | 664 | L | non définie (contrôle vide / `False`) | – | Facture.class:8273, EnvMail.module:176 |
| 81 | `/Soc<XX>/Pdf` | `Pdf` (CheckBox) | 331 | 665 | L | non définie (contrôle vide / `False`) | – | Facture.class:1637, FClient.class:1726 |
| 82 | `/Soc<XX>/Pdf2` | `Pdf2` (CheckBox) | 332 | 666 | L | non définie (contrôle vide / `False`) | – | FFournisseur.class:1624 |
| 83 | `/Soc<XX>/Pdf5` | `Pdf5` (CheckBox) | 333 | 667 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:275 |
| 84 | `/Soc<XX>/Pdf6` | `Pdf6` (CheckBox) | 334 | 668 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:276 |
| 85 | `/Soc<XX>/Factdef` | `Factdef` (RadioButton) | 335 | 669 | L | non définie (contrôle vide / `False`) | – | Facture.class:453,1594,10208 |
| 86 | `/Soc<XX>/Bldef` | `Bldef` (RadioButton) | 336 | 670 | L | `True` (radio `.form`) | – | Facture.class:456,1597,10211 |
| 87 | `/Soc<XX>/Devisdef` | `Devisdef` (RadioButton) | 337 | 671 | L | non définie (contrôle vide / `False`) | – | Facture.class:459,1600,10214 |
| 88 | `/Soc<XX>/Prodef` | `Prodef` (RadioButton) | 338 | 672 | L | non définie (contrôle vide / `False`) | – | Facture.class:462,1603,10217 |
| 89 | `/Soc<XX>/Siret` | `Siret` (TextBox) | 339 | 565 | G+L | `"Siret"` (l.340, `.form`) | `"Siret"` | Bordereaux.class:146, Caisse.class:258,261, Fsoc.class:46, Facturergbl.class:594, ObjFac.class:259, FRelCompte.class:348, FEditrel.class:504, FRelFacture.class:365, Ligcli.class:245, ArchivesTck.class:592 |
| 90 | `/Soc<XX>/Prxdec` | `Prxdec` (CheckBox) | 341 | 566 | G+L | non définie (contrôle vide / `False`) | 0 | gridvi2.class:10, Facturergbl.class:760,764,768…, Facturefm.class:103, Facture.class:337, ObjFac.class:261, Edbr.module:67,90,95, TBord.class:312, Archives.class:131 |
| 91 | `/Soc<XX>/Totstring` | `Totstring` (CheckBox) | 342 | 673 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:250 |
| 92 | `/Soc<XX>/Pays` | `Pays` (ComboBox) | 343 | 558 | G+L | non définie (contrôle vide / `False`) | `"France"` (C) | FClient.class:157,450,629… |
| 93 | `/Soc<XX>/Expfact` | `Expfact` (ComboBox) | 344 | 559 | G+L | non définie (contrôle vide / `False`) | – | FClient.class:1722 |
| 94 | `/Soc<XX>/Ech` | `Ech` (ComboBox) | 345 | 560 | G+L | non définie (contrôle vide / `False`) | – | FClient.class:1724 |
| 95 | `/Soc<XX>/Typec` | `Typec` (ComboBox) | 346 | 561 | G+L | non définie (contrôle vide / `False`) | – | FClient.class:1725 |
| 96 | `/Soc<XX>/Caisse` | `Caisse` (CheckBox) | 347 | 562 | G+L | non définie (contrôle vide / `False`) | – | Start.module:322, Fmenu.class:95, Parametre.class:524, Articles.class:130 |
| 97 | `/Soc<XX>/Tp1` | `Tp1` (TextBox) | 348 | 563 | G+L | `"0,00"` (`.form`) | – | FClientcarte.class:174,674 |
| 98 | `/Soc<XX>/Tg1` | `Tg1` (TextBox) | 349 | 564 | G+L | `"0,00"` (`.form`) | – | FClientcarte.class:175,675 |
| 99 | `/Soc<XX>/Numdossier` | `Numdossier` (TextBox) | 350 | 567 | G+L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 100 | `/Soc<XX>/Nomdossier` | `Nomdossier` (TextBox) | 351 | 568 | G+L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 101 | `/Soc<XX>/Fht` | `sFht` (CheckBox) | 352 | 674 | L | non définie (contrôle vide / `False`) | – | Facture.class:313,1610,2113 |
| 102 | `/Soc<XX>/TxtF` | `TxtF` (CheckBox) | 353 | 675 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:246,273 |
| 103 | `/Soc<XX>/LTxtF` | `LTxtF` (TextBox) | 354 | 676 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:247 |
| 104 | `/Soc<XX>/Marge` | `Marge` (CheckBox) | 356 | 587 | G+L | non définie (contrôle vide / `False`) | – | Facture.class:1216,1339,4254 |
| 105 | `/Soc<XX>/MO` | `MO` (CheckBox) | 357 | 588 | G+L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 106 | `/Soc<XX>/CodeMO` | `codeMO` (ComboBox) | 360 | 592 | G+L | non définie (contrôle vide / `False`) | – | Suivi.class:81 |
| 107 | `/Soc<XX>/Refl` | `Refl` (CheckBox) | 364 | 589 | G+L | non définie (contrôle vide / `False`) | – | Facture.class:5308 |
| 108 | `/Soc<XX>/Impbl` | `Impbl` (CheckBox) | 365 | 677 | L | non définie (contrôle vide / `False`) | 0 (C) | LauruxMaj.module:3221,3275, ObjFac.class:252 |
| 109 | `/Soc<XX>/Affaire` | `Affaire` (CheckBox) | 366 | 678 | L | non définie (contrôle vide / `False`) | – | Facture.class:902,904,906… |
| 110 | `/Soc<XX>/Art` | `Art` (RadioButton) | 367 | 679 | L | `True` (radio `.form`) | – | Facture.class:1193 |
| 111 | `/Soc<XX>/MoArt` | `MoArt` (RadioButton) | 368 | 680 | L | non définie (contrôle vide / `False`) | – | Facture.class:526,1185,2232 |
| 112 | `/Soc<XX>/ComArt` | `Com` (RadioButton) | 369 | 681 | L | non définie (contrôle vide / `False`) | – | Facture.class:529,1189,2236 |
| 113 | `/Soc<XX>/Tmail` | `Tmail` (TextArea) | 370 | 682 | L | non définie (contrôle vide / `False`) | – | FClient.class:2387 |
| 114 | `/Soc<XX>/Tmail2` | `Tmail2` (TextBox) | 371 | 683 | L | non définie (contrôle vide / `False`) | – | FClient.class:2386 |
| 115 | `/Soc<XX>/Vendeurs` | `Vendeurs` (CheckBox) | 372 | 684 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:132,935,938… |
| 116 | `/Soc<XX>/Casier` | `Casier` (CheckBox) | 373 | 685 | L | non définie (contrôle vide / `False`) | – | Facture.class:9204 |
| 117 | `/Soc<XX>/Analytique` | `Analytique` (CheckBox) | 374 | 553 | G+L | non définie (contrôle vide / `False`) | – | Saisecrit.class:1913, FComptes.class:99 |
| 118 | `/Soc<XX>/Lettrage` | `Lettrage` (CheckBox) | 375 | 554 | G+L | non définie (contrôle vide / `False`) | 1 (C) | Tresor.class:445 |
| 119 | `/Soc<XX>/Decais` | `decais` (CheckBox) | 378 | 557 | G+L | non définie (contrôle vide / `False`) | – | LauruxMaj.module:5131, SaiReg.class:675, Mreglement.class:46 |
| 120 | `/Soc<XX>/Sage` | `Sage` (CheckBox) | 379 | 689 | L | non définie (contrôle vide / `False`) | – | FClient.class:158, ExportJdv.class:598,789 |
| 121 | `/Soc<XX>/Sauvauto` | `Sauvauto` (CheckBox) | 380 | 690 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:1228 |
| 122 | `/Soc<XX>/Envoiftp` | `Envoiftp` (CheckBox) | 381 | 691 | L | non définie (contrôle vide / `False`) | – | SauvesAuto.module:24 |
| 123 | `/Soc<XX>/Adrbase` | `Adrbase2` (TextBox) | 382 | 692 | L | non définie (contrôle vide / `False`) | – | SauvesAuto.module:25 |
| 124 | `/Soc<XX>/Idftp` | `IdFTP` (TextBox) | 383 | 694 | L | non définie (contrôle vide / `False`) | – | SauvesAuto.module:26 |
| 125 | `/Soc<XX>/Prgmail` | `PrgMail` (ComboBox) | 384 | 698 | L | non définie (contrôle vide / `False`) | – | EnvMail.module:50,51,91… |
| 126 | `/Soc<XX>/MdpFTP` | `MdpFTP` (TextBox) | 385 | 693 | L | non définie (contrôle vide / `False`) | – | SauvesAuto.module:27 |
| 127 | `/Soc<XX>/Adrbase3` | `Adrbase3` (TextBox) | 386 | 695 | L | non définie (contrôle vide / `False`) | – | FacturefmA.class:553,556,559 |
| 128 | `/Soc<XX>/Idftp3` | `IdFTP3` (TextBox) | 387 | 697 | L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 129 | `/Soc<XX>/MdpFTP3` | `MdpFTP3` (TextBox) | 388 | 696 | L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 130 | `/Soc<XX>/Depannage` | `Depannage` (CheckBox) | 389 | 577 | G+L | non définie (contrôle vide / `False`) | – | Facture.class:312,5041 |
| 131 | `/Soc<XX>/Afour` | `Afour` (CheckBox) | 390 | 702 | L | non définie (contrôle vide / `False`) | – | Facture.class:543,6724,7488 |
| 132 | `/Soc<XX>/AffArt` | `AffArt` (CheckBox) | 391 | 699 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:253 |
| 133 | `/Soc<XX>/AffMarge` | `MasqueMarge` (CheckBox) | 392 | 700 | L | non définie (contrôle vide / `False`) | – | Facture.class:343 |
| 134 | `/Soc<XX>/AffClient` | `AffClient` (CheckBox) | 393 | 701 | L | non définie (contrôle vide / `False`) | – | ObjFac.class:278 |
| 135 | `/Soc<XX>/prixRecpt` | `PxRecpt` (CheckBox) | 394 | 574 | G+L | non définie (contrôle vide / `False`) | – | Achat.class:61, commande1.class:42 |
| 136 | `/Soc<XX>/Rcptman` | `Rcptman` (CheckBox) | 395 | 575 | G+L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 137 | `/Soc<XX>/NumBr` | `NumBr` (CheckBox) | 396 | 576 | G+L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 138 | `/Soc<XX>/Sms` | `Sms` (CheckBox) | 397 | 703 | L | non définie (contrôle vide / `False`) | – | Fmenu.class:138, FFournisseur.class:84, FClient.class:86 |
| 139 | `/Soc<XX>/Support` | `Support` (ComboBox) | 399 | 704 | L | non définie (contrôle vide / `False`) | – | Gsm.class:46,181, Emailing.class:129 |
| 140 | `/Soc<XX>/Api` | `Api` (TextBox) | 400 | 705 | L | non définie (contrôle vide / `False`) | – | Gsm.class:48,182, Emailing.class:130 |
| 141 | `/Soc<XX>/Type` | `Type` (ComboBox) | 401 | 706 | L | non définie (contrôle vide / `False`) | – | Gsm.class:49,183, Emailing.class:131 |
| 142 | `/Soc<XX>/Expediteur` | `Expediteur` (TextBox) | 402 | 707 | L | non définie (contrôle vide / `False`) | – | Gsm.class:50,184, Emailing.class:132 |
| 143 | `/Soc<XX>/Sprix` | `Checkbox2` (CheckBox) | 406 | 708 | L | non définie (contrôle vide / `False`) | – | Variables.module:4 |
| 144 | `/Soc<XX>/SMajArt` | `MajArt` (CheckBox) | 408 | 712 | L | non définie (contrôle vide / `False`) | – | Variables.module:8 |
| 145 | `/Soc<XX>/SMajFour` | `MajFour` (CheckBox) | 409 | 713 | L | non définie (contrôle vide / `False`) | – | Variables.module:9 |
| 146 | `/Soc<XX>/SMajCli` | `MajCli` (CheckBox) | 410 | 714 | L | non définie (contrôle vide / `False`) | – | Variables.module:10 |
| 147 | `/Soc<XX>/Simport` | `Import` (RadioButton) | 411 | 709 | L | non définie (contrôle vide / `False`) | – | Variables.module:6 |
| 148 | `/Soc<XX>/Sexport` | `Export` (RadioButton) | 412 | 710 | L | non définie (contrôle vide / `False`) | – | Variables.module:5 |
| 149 | `/Soc<XX>/Schmprix` | `Chmprix` (TextBox) | 413 | 711 | L | non définie (contrôle vide / `False`) | – | Variables.module:7 |
| 150 | `/Soc<XX>/Replique` | `Replique` (CheckBox) | 414 | 715 | L | non définie (contrôle vide / `False`) | – | Start.module:112, Fmenu.class:652,669,761…, Facture.class:1520 |
| 151 | `/Soc<XX>/Breplique` | `Breplique` (CheckBox) | 415 | 716 | L | non définie (contrôle vide / `False`) | – | Start.module:112, Fmenu.class:652,669,761…, Facture.class:1520 |
| 152 | `/Soc<XX>/Impetiq` | `Impetiq` (ComboBox) | 422 | 687 | L | non définie (contrôle vide / `False`) | – | Etiqfbtarif.class:50,51,52, Etigond.class:99,100,101, EtiqPromo.class:32,33,34, EtiqRecpt.class:63,64,65, Etiqart.class:94,95,96, Etiqcasier.class:86,87,88 |
| 153 | `/Soc<XX>/IpZebra` | `IpZebra` (TextBox) | 426 | 688 | L | non définie (contrôle vide / `False`) | – | _aucun_ |
| 154 | `/Soc<XX>/nbfam` | `Textfam` (TextBox) | 428 | 596 | G+L | `"5"` (l.429) | `"5"` | LauruxMaj.module:4965,4967 |
| 155 | `/Soc<XX>/ipr` | `$check[] (Panelfam)` | 430 | 601 | G+L | `[5]` (afffam l.1398-1399) | `[5]` | LauruxMaj.module:4969, textfamille.class:22, Trifam.class:34, Articles.class:193 |
| 156 | `/Soc<XX>/pp` | `pp` (CheckBox) | 433 | 602 | G+L | non définie (contrôle vide / `False`) | False | LauruxMaj.module:4971,5501, Utils.module:1332,1333, Tregie.class:468, menuopt.class:26 |
| 157 | `/Soc<XX>/bois` | `bois` (CheckBox) | 434 | 603 | G+L | non définie (contrôle vide / `False`) | False | LauruxMaj.module:4972,5506, Utils.module:1331,1333, menuopt.class:11 |
| 158 | `/Soc<XX>/ServerLogIP` | `ServerLogIP` (ValueBox) | 436 | 593 | G+L | **`127.0.0.1`** (l.437) | – | DB_Connection.class:74 |
| 159 | `/Soc<XX>/ServerLogPort` | `ServerLogPort` (ValueBox) | 438 | 594 | G+L | **`6556`** (l.439, `.form`) | – | DB_Connection.class:75,76,77 |
| 160 | `/Soc<XX>/scandevice` | `ScanDevice` (TextBox) | 442 | 719 | L | non définie (contrôle vide / `False`) | – | LGed.class:867,906 |
| 161 | `/Soc<XX>/scangui` | `ScanGui` (TextBox) | 443 | 720 | L | non définie (contrôle vide / `False`) | – | LGed.class:873,883 |
| 162 | `/Soc<XX>/scanbatch` | `ScanBatch` (TextBox) | 445 | 721 | L | non définie (contrôle vide / `False`) | – | LGed.class:912,919, LScript.class:112 |
| 163 | `/Soc<XX>/scanconvert` | `ScanConvert` (TextBox) | 447 | 722 | L | non définie (contrôle vide / `False`) | – | LGed.class:887,891,924… |
