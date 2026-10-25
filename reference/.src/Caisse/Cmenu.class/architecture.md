# Cmenu — Architecture

> Source : `.src/Caisse/Cmenu.class`

## Vue d'ensemble

`Cmenu` est la **fenêtre d'accueil du point de vente** (« Accueil Laurux-Pos »). Elle est créée :

- par `Start.Lancement` quand Laurux est lancé avec `-p` (`Menu = New Cmenu`, [Start.module:307](../../../../.src/Start.module#L307)) :
  c'est alors la fenêtre principale (`Start.MainWindow`) ;
- par `Fmenu.Menu332_Click` en mode Gestion (`CMenu = New Cmenu`, [Fmenu.class:2541](../../../../.src/Communs/Fmenu.class#L2541)).

Elle propose quatre actions : **connexion de la caisse** (`Button1` → `Ouverture`), **saisie du
fond de caisse** (`Button10` → `Fondcaisse`), **saisie caisse** (`Button11` → `New Caisse`) et
**déconnexion** (`Button2` → fermeture, gérée dans `form_close`). Elle gère aussi l'accès
administrateur (`Alt+P` → `Preferences`, `Alt+L` → `DB_Log`), protégé par un mot de passe d'un
vendeur `admin` si `/Soc<XX>/caisse/admin2` est actif, et l'attribution des touches (`F12` → `Attrib`).

En mode `-p`, `_new` ouvre elle-même la connexion à la base (lecture de la configuration, tunnel
SSH, `Utils.db.Open`), à la manière de `Fmenu._new`/`Form_Open` mais sans le garde MySQL.

La fermeture de la fenêtre **déconnecte la caisse** : `UPDATE Fiches_Caisses` (`dtefm`,
`connecte = 0`, `vdr_code = ''`), suppression du fichier `~/Caisse<n>.lock`, remise à vide de
`/Soc<XX>/caisse/Ncai`. C'est la moitié « fermeture » du cycle ouverture/fermeture de caisse
(l'ouverture est dans [`Ouverture`](../Ouverture.class/architecture.md), le ticket Z dans
[`Moulinage`](../Moulinage.class/architecture.md)) : **module complexe** au sens de PLAN.md §0.

Nature globale : **GUI**, avec du SQL et des effets de bord fichiers/paramètres dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Soc` | var | Public |  | String | 9 |
| `intitule` | var | Public |  | String | 10 |
| `hForm` | var | Private |  | Fondcaisse | 11 |
| `Ncaisse` | var | Private |  | String | 12 |
| `Efface` | var | Private |  | Integer | 13 |
| `OCaisse` | var | Private |  | Object | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-94 | Public | 16 | 67 | 0 | méthode spéciale |
| `SetObservers` | 96-108 | Public | 4 | 10 | 0 | portée réductible ? |
| `Obs_Enter` | 110-115 | Public | 1 | 4 | 0 | handler GUI |
| `Obs_Leave` | 117-122 | Public | 1 | 4 | 0 | handler GUI |
| `Button1_Click` | 124-158 | Public | 8 | 32 | 0 | handler GUI |
| `Button2_Click` | 160-164 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_KeyPress` | 166-172 | Public | 5 | 5 | 0 | handler GUI |
| `ControleCai` | 174-182 | Public | 2 | 7 | 0 | portée réductible ? |
| `form_close` | 184-216 | Public | 12 | 30 | 0 | handler GUI |
| `Button10_Click` | 218-230 | Public | 3 | 11 | 0 | handler GUI |
| `Button10_KeyPress` | 232-238 | Public | 5 | 5 | 0 | handler GUI |
| `Button11_Click` | 240-257 | Public | 4 | 15 | 0 | handler GUI |
| `Button11_KeyPress` | 259-265 | Public | 5 | 5 | 0 | handler GUI |
| `Config` | 267-271 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_KeyPress` | 273-281 | Public | 6 | 7 | 0 | handler GUI |
| `Form_KeyPress` | 283-296 | Public | 8 | 12 | 0 | handler GUI |
| `mdp_admin2` | 298-308 | Public | 2 | 9 | 0 | portée réductible ? |
| `mdp_admin3` | 310-323 | Public | 2 | 11 | 0 | portée réductible ? |
| `Mdp_KeyPress` | 330-374 | Public | 11 | 42 | 0 | handler GUI |
| `init_ecole` | 376-409 | Public | 5 | 22 | 0 | portée réductible ? |
| `Label1_MouseDown` | 411-415 | Public | 1 | 3 | 0 | handler GUI |
| `Label2_MouseDown` | 417-421 | Public | 1 | 3 | 0 | handler GUI |
| `Label4_MouseDown` | 423-427 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 429-433 | Public | 1 | 3 | 0 | handler GUI |
| `Label3_MouseDown` | 435-439 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et connexion

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] (CC 16).
  - Instrumente l'écran (`Utils.Observers(Me)`), plein écran (`Screens[0]`), titre
    `Application.Name v<version>`, sha1/branche (`Start.version_sha1`, `Start.version_branch`).
  - ⚠️ `titre = fmenu.text` (ligne 29) puis `Fmenu.text = …` (ligne 64) : accès à
    l'**auto-instance** de `Fmenu`, qui n'est ni la fenêtre principale en mode `-p` (c'est `Cmenu`),
    ni la fenêtre `New Fmenu` du mode Gestion. L'accès crée une instance cachée de `Fmenu`
    (exécution de `Fmenu._new`, donc `Utils.Observers` sur une fenêtre invisible) et le titre
    modifié n'est jamais visible (FMENU-A13, anomalie CMENU-A01).
  - Lit `/Soc<XX>/caisse/intitule` dans `intitule`, valeur jamais utilisée ensuite (code mort).
  - `SetObservers(Me, Me)` : survol des boutons.
  - Si la base n'est pas ouverte : `Utils.glb()`, tunnel SSH si `/dbase/Con-ssh`
    (`Utils.monteTunnel`), `Utils.db.Open`, puis `ALTER DATABASE <nom> DEFAULT COLLATE
    utf8mb4_unicode_ci` et `SET NAMES utf8mb4 COLLATE …` **sans test du type de base**.
  - Si la base est ouverte : `SET NAMES 'utf8mb4'` (encore sans garde MySQL), puis
    `SELECT * FROM <TabSoc> WHERE cd_sc = &1` pour afficher la société.
  - ⚠️ Sous SQLite, `SET NAMES`/`ALTER DATABASE` ne sont pas traduits par `DB_Connection.Exec`
    et l'erreur est propagée (`Error.Propagate`) : le `Catch` de `_new` affiche le message puis
    ouvre `LauruxConf` (à confirmer à l'exécution, CMENU-A02). `Fmenu` garde ces requêtes par
    `Utils.db.IsType(Utils.db.type_mysql)` ([Fmenu.class:168](../../../../.src/Communs/Fmenu.class#L168)).
  - `Catch` : son, puis message selon le début de `Error.Text` (« Driver name missing », « type
    mismatch », « Cannot open database: Acces… », « …Unknown database ») et `Config()`. La cascade
    de `If` imbriqués porte la complexité.
  - Différences avec `Fmenu` : pas de `SET SESSION sql_mode`, pas de `Start.Restore_Args`, pas de
    contrôle de version de base (migrations `LauruxMaj` non jouées en mode `-p`, à confirmer).
- **`Config()`** [portée : réductible] [nature : GUI] : `LauruxConf.ShowModal()` (auto-instance).

### Survol des boutons

- **`SetObservers(hClass, hCont)`** [portée : réductible] [nature : GUI] : parcours récursif des
  conteneurs ; un `Observer` « OBS » par `Button`. Le paramètre `hClass` est inutilisé. Copie
  identique dans `Ouverture`, `Fondcaisse`, `Preferences` et 12 autres classes.
- **`Obs_Enter()` / `Obs_Leave()`** [portée : nécessaire (handler d'`Observer`)] [nature : GUI] :
  police grasse et fond éclairci au survol, rétablis à la sortie.

### Actions du menu

- **`Button1_Click()`** (Connexion caisse) [handler] [nature : mixte] :
  `SELECT * FROM <TabCaisses> WHERE poste = &1` (`System.Host`) ; aucune caisse → message
  « Il faut d'abord créer vos caisses… » ; puis `SELECT * FROM Fiches_ClientCaisse` (**nom de
  table en dur**, clé `TabCliCaisse` existante) ; aucun client caisse → message ; sinon, si une
  saisie caisse est déjà ouverte (`OCaisse`) → message, sinon `Ouverture.ShowModal()`
  (auto-instance). La variable `b` ne sert qu'à court-circuiter, sa valeur finale est inutilisée.
- **`Button10_Click()`** (Fond de caisse) [handler] [nature : GUI] : refuse si
  `/Soc<XX>/caisse/Ncai` est vide, sinon `New Fondcaisse` modal (membre `hForm`, inutile hors de
  la fonction).
- **`Button11_Click()`** (Saisie caisse) [handler] [nature : GUI] : refuse si une saisie est déjà
  ouverte ou si la caisse n'est pas connectée ; sinon `OCaisse = New Caisse` et
  `Object.Call(OCaisse, "Show")` (appel dynamique, ligne 254). La saisie affichée n'est donc pas
  l'auto-instance de `Caisse` : `Svendeur`, qui écrit `Caisse.$Vendeur`, vise la mauvaise instance
  (SVENDEUR-A01, CAISSE-A04).
- **`Button2_Click()`** (Déconnexion) [handler] [nature : GUI] : `Me.Close` → `form_close`.
- **`Button1_KeyPress` / `Button2_KeyPress` / `Button10_KeyPress` / `Button11_KeyPress`**
  [handlers] [nature : GUI] : `F1` → aide `Laurux.PosIndexParCategories` (avec `Ctrl` pour
  `Button1` seulement), `F12` → `ControleCai`, `Entrée` → clic du bouton. Quatre copies.
- **`Form_KeyPress()`** [handler] [nature : GUI] : `Ctrl+F1` aide, `F12` (sans `Ctrl`, alors que
  `Label3` affiche « CTRL + F12 ») → `ControleCai`, `Alt+P` (code 80) → `mdp_admin2`, `Alt+L`
  (code 76) → `mdp_admin3`.
- **`Label1_MouseDown`, `Label2_MouseDown`, `Label3_MouseDown`, `Label4_MouseDown`,
  `Button3_Click`** [handlers] [nature : GUI] : raccourcis souris vers l'aide, `mdp_admin2`,
  `ControleCai`, `mdp_admin3`.
- **`ControleCai()`** [portée : réductible] [nature : GUI] : `Attrib.ShowModal()` si
  `Start.$tcai` n'est pas nul (il vaut `"0"` quand le choix des touches est désactivé, ce qui
  ouvre aussi `Attrib`), sinon message.

### Accès administrateur

- **`mdp_admin2()`** [portée : réductible] [nature : GUI] : si `/Soc<XX>/caisse/admin2`, affiche
  `Frame8` (saisie du mot de passe) ; sinon `Preferences.ShowModal()`.
- **`mdp_admin3()`** [portée : réductible] [nature : GUI] : même test ; sans protection,
  `New DB_Log(Utils.db).Show()`. Avec protection, il affiche le même `Frame8` que `mdp_admin2` :
  le mot de passe validé ouvre **toujours `Preferences`**, jamais `DB_Log` (CMENU-A03).
- **`Mdp_KeyPress()`** [handler] [nature : mixte] : sur `Entrée`,
  `SELECT * FROM <TabVendeurs> WHERE admin = &1` (`"-1"`, valeur stockée pour un `Boolean` vrai),
  déchiffre chaque `mdp` (`hexdblKey.crypt("de", …, "Laurux")`) et compare au texte saisi ; succès
  → `Preferences.ShowModal()` ; échec → message ; aucun administrateur → message et masquage.
  `Échap` → masquage. Partie extractible : `EstMotDePasseAdmin(texte) As Boolean`.

### Fermeture : déconnexion de la caisse

- **`form_close()`** [handler] [nature : mixte] (CC 12).
  - `Ncaisse = Split(/Soc<XX>/caisse/Ncai, ";")[0]` : si le paramètre est vide, `Split` renvoie
    un tableau vide (vérifié avec `gbs3`) et l'indice `[0]` lève une erreur ; le `Catch` appelle
    `Start.UnLock()` (mode `-p`) et la fenêtre se ferme sans question. La branche `Else` (l. 210-212)
    n'est donc atteinte que pour un paramètre de la forme `";…"`.
  - `SELECT * FROM <TabCaisses> WHERE code = &1`, puis question « Voulez-vous déconnecter la
    caisse n° … ». Lecture de `Cai!ecole` **sans test `Available`**.
  - Caisse école (`Cai!ecole = True` ; vrai si la colonne vaut `-1`, valeur écrite par
    `Fcaisses`) → `init_ecole()`.
  - Si `Efface = 1` : suppression de `~/Caisse<n>.lock`,
    `UPdate <TabCaisses> SET dtefm = &1, connecte = &2, vdr_code = &3 WHERE code = &4`
    (`LDate(Now).DT`, `0`, `""`), `/Soc<XX>/caisse/Ncai = ""` et `Save`, message d'au revoir.
  - Puis `Start.UnLock()` en mode `-p`. Réponse « Non » → `Stop Event` (la fenêtre reste ouverte).
- **`init_ecole()`** [portée : réductible] [nature : mixte] : question de confirmation ; « Oui » →
  `UPDATE <TabCaisses> SET tkz = 1, fndc = 0, dtefm, connecte = 0`, message « TODO pb avec les
  caisses ecoles », puis **`Quit 1`** : l'application s'arrête et les lignes 397-403 (`UPDATE
  Fiches_EntTicketz SET statut = 'E'`, suppression du verrou, message final) sont **inatteignables**.
  Le fichier `~/Caisse<n>.lock`, le paramètre `Ncai` et le verrou applicatif restent en place.
  « Non » → `Efface = 0` et `Stop Event` ; `Efface` n'est jamais remis à 1 : les fermetures
  suivantes ne déconnectent plus la caisse, et `form_close` appelle `Start.UnLock()` alors que la
  fenêtre reste ouverte (CMENU-A04).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/caisse/{intitule,Ncai,admin2}"]`, `/dbase/Con-ssh` ;
  `Start.Societe`, `Start.son`, `Start.Arg_Pos`, `Start.$tcai`, `Start.version_sha1`,
  `Start.version_branch`, `Start.UnLock()`.
- `Utils.db` (ouverture, `Exec`), `Utils.glb`, `Utils.monteTunnel`, `Utils.Observers`.
- Auto-instances : `Fmenu` (titre), `Ouverture`, `Preferences`, `Attrib`, `LauruxConf`.
- Fichiers : `~/Caisse<n>.lock` (créé par `Ouverture`, supprimé ici).
- Tables : `Fiches_Societes` (`TabSoc`), `Fiches_Caisses` (`TabCaisses`, lecture et mise à jour),
  `Fiches_ClientCaisse` (en dur), `Fiches_Vendeurs` (`TabVendeurs`), `Fiches_EntTicketz` (en dur,
  instruction inatteignable).

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : extraire l'ouverture de la connexion dans une fonction privée `OuvreConnexion()` et
  remplacer la cascade de `If` du `Catch` par un `Select`/table de correspondance
  préfixe → message (mêmes messages).
- Les quatre `ButtonN_KeyPress` : helper privé `ToucheBouton(bCtrlF1 As Boolean)` renvoyant
  l'action, en conservant la différence de `Button1` (`Ctrl+F1`).
- `form_close` : remplacer `Split(…)[0]` + `Catch` par un test explicite du paramètre (même
  comportement : fermeture sans question si `Ncai` est vide).

### Commonalisation avec d'autres fichiers

- **Ouverture de connexion** : la séquence `Utils.glb` / tunnel / `Open` / `SET NAMES` est
  dupliquée avec [`Fmenu`](../../Communs/Fmenu.class/architecture.md) (`_new`/`Form_Open`) et
  [`Fsoc`](../../Communs/Fsoc.class/architecture.md). Un helper `Utils.OuvreConnexion()` n'est
  possible qu'après décision sur CMENU-A02 (garde MySQL absente ici).
- **Survol des boutons** (`SetObservers`/`Obs_Enter`/`Obs_Leave`) : copie identique dans
  [`Ouverture`](../Ouverture.class/architecture.md), [`Fondcaisse`](../Fondcaisse.class/architecture.md),
  [`Preferences`](../Preferences.class/architecture.md), `Caisse` et 11 autres classes → classe
  helper `SurvolBoutons` (observateurs et handlers déplacés ; aucun contrôle ni handler du `.form`
  touché).
- **Mot de passe vendeur/administrateur** : `hexdblKey.crypt("de", mdp)` + comparaison, comme
  [`Ouverture.Caissiere_Click`](../Ouverture.class/architecture.md) et
  [`ConVendeurs`](../../Gestion/Facturation/ConVendeurs.class/architecture.md) → helper commun
  `LVendeur` (proposé par CONVENDEURS-005).
- **Compte client caisse** : la lecture de `Fiches_ClientCaisse` (nom en dur) de `Button1_Click`
  est dupliquée dans [`Fclientc`](../Fclientc.class/architecture.md), `Moulinage` (l. 1528) et
  `BordereauxC` (l. 242) → fonction `CompteClientCaisse()` proposée par FCLIENTC-005.
- **Déconnexion de caisse** : la mise à jour `Fiches_Caisses` (`connecte`, `dtefm`, `vdr_code`)
  fait pendant à celle d'`Ouverture.Button1_Click` (`dteov`, `connecte = 1`) → module
  `CaisseEtat` (connecter/déconnecter, verrou fichier, paramètre `Ncai`).

### Réduction de portée

`SetObservers`, `ControleCai`, `Config`, `mdp_admin2`, `mdp_admin3`, `init_ecole` et les variables
`Soc`, `intitule` : aucun appelant externe (seuls `New Cmenu` et `Object.Call(…, "Show")`),
aucun nom cité en chaîne (vérifié par `grep`). Les handlers restent `Public`.

### Séparation traitement / GUI

- `DeconnecteCaisse(sCaisse)` : `UPDATE` + suppression du verrou + remise à vide de `Ncai`, sans
  contrôle ; `form_close` garde les questions et messages.
- `CaisseDisponible() As String` : les deux `SELECT` de `Button1_Click`, renvoyant le message
  d'erreur éventuel.
- `EstMotDePasseAdmin(sMdp) As Boolean` pour `Mdp_KeyPress`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- L'état « caisse connectée » est porté à la fois par `Fiches_Caisses.connecte`, un fichier
  `~/Caisse<n>.lock` local à l'utilisateur et le paramètre `/Soc<XX>/caisse/Ncai`. Un état unique
  en base (poste, vendeur, date, pid) éviterait les incohérences après un arrêt brutal.
- Le statut « école » d'un ticket n'existe pas dans le schéma (commentaire de `init_ecole`) : une
  colonne `ecole` sur `Fiches_EntTicketz`/`Fiches_HisEntTickets`, prise en compte par le chaînage
  et les statistiques, est un préalable aux caisses école.
