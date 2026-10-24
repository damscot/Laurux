# FRestore — Architecture

> Source : `.src/Communs/FRestore.class`

## Vue d'ensemble

`FRestore` est l'écran **« Restauration de la base »**. À partir d'un répertoire (`SauveB`,
prérempli par `/Rep_Sauv`), il restaure le fichier `<Utils.db.Name>.sql` (ou `.sql.gz` si
`/Compression` est actif) produit par [`FSauve`](../FSauve.class/architecture.md) :

1. détection MariaDB/MySQL (`Shell mysql … show variables like "version"`) ;
2. décompression éventuelle (`Uncompress` zlib) vers `<rep>/<base>.sql` ;
3. lecture du propriétaire et de la date du fichier par analyse de la sortie `ls -1 -g` ;
4. contrôle du nombre de processus MySQL (`Mmysql.Process_List`) : 0 → mot de passe invalide,
   > 7 → panneau proposant de redémarrer MySQL (`Mmysql.Init`) ;
5. confirmation, puis `Utils.Clear_DataBase` (DROP DATABASE), `Utils.Create_DataBase`,
   `Utils.Fill_DataBase` (import `mysql`), `TRUNCATE` de `Fiches_Docactif` ;
6. `Verif_Version` : contrôle de la version de la base restaurée et restauration facultative du
   fichier de préférences `Laurux.conf` sauvegardé à côté ; arrêt de Laurux si nécessaire.

Écran **GUI** avec traitements shell et SQL intégrés ; MySQL/MariaDB uniquement. Ouvert par
`Fmenu.Menu65_Click` (après mot de passe `MDP` si `/Soc<XX>/Admin`) et par la reprise sur erreur de
démarrage de `Fmenu` (l. 280).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `Content` | var | Private |  | String | 28 |
| `Compb` | var | Private |  | Boolean | 29 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 31-39 | Public | 3 | 6 | 0 | méthode spéciale |
| `Button3_Click` | 41-45 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 47-152 | Public | 30 | 103 | 0 | handler GUI |
| `Process_Read` | 154-164 | Public | 3 | 7 | 0 | portée réductible ? |
| `Svs_Click` | 166-176 | Public | 2 | 9 | 0 | handler GUI |
| `Verif_Version` | 178-211 | Public | 8 | 31 | 0 | portée réductible ? |
| `Button4_Click` | 213-217 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 219-227 | Public | 1 | 7 | 0 | handler GUI |
| `Button6_Click` | 229-233 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 235-239 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `SauveB = /Rep_Sauv`,
  `Compb = /Compression` (`Try`), musique, centrage. Pas d'`Utils.Observers` (contrairement à
  `FSauve`).
- **`Button2_Click()`** (Restaurer, CC 30, max du fichier) [portée : nécessaire (handler, appelé
  aussi par `Button5_Click`)] [nature : mixte].
  - `Shell mysql -h <Host> -u <login> -p<mdp> -e "show variables like \"version\"" > ~/tmp/resultat`
    puis `bmariadb` si la 2ᵉ ligne contient `MariaDB` (mot de passe visible dans `ps`, port ignoré).
  - Si `Compb` : `Try Uncp.File(<rep>/<base>.sql.gz → <rep>/<base>.sql)` ; échec → `Compb = False`.
  - Fichier `<rep>/<base>.sql` absent → `Message.Error`.
  - Sinon `ls -1 -g` du fichier (`.sql` ou `.sql.gz`) → `~/tmp/resultat`, découpe manuelle en
    champs : x = 3 → `Utilisateur` (avec `-g`, c'est en fait le **groupe**), 5 et 6 → date
    (« jour mois »), 7 → heure. Format dépendant de la langue et de l'âge du fichier (année au lieu
    de l'heure au-delà de 6 mois).
  - `Mmysql.Process_List(0)` : 0 → « Mot de passe invalide ! » ; > 7 → `Panel1` visible ; sinon
    question de confirmation, puis `Clear_DataBase`, `Create_DataBase`, `Fill_DataBase` (sortie de
    `mysql` dans `txterror`).
  - **Détection d'erreur** (l. 132) : `InStr(txterror, "Using a password") <> 18 And Not bmariadb
    Or If Not IsNull(txterror) And bmariadb`. Pour MySQL, seul l'avertissement « mysql: [Warning]
    Using a password… » en tête (position 18) vaut succès, même suivi d'une vraie erreur ; pour
    MariaDB, toute sortie vaut échec. La priorité relative de `And` et `Or If` en Gambas est à
    confirmer (FRESTORE-A02).
  - Succès : `Try TRUNCATE Fiches_Docactif` (`Cbase.Table("TabActif")`, documents ouverts),
    message, `Verif_Version`, fermeture. Échec : son (joué deux fois), `Message.Error`.
  - `Utilisateur` est initialisé par `Recup.Utilisateur()` puis écrasé par l'analyse de `ls`.
- **`Verif_Version()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres`
  (nom en dur) ; colonne `version` absente → avertissement « très ancienne » et arrêt
  (`Utils.Exit(False)`) ; version ≠ `"majeur.mineur"` d'`Application.Version` → avertissement et
  arrêt. `Utils.Exit` envoie `SIGINT` et **rend la main** : l'exécution continue. Si
  `<rep>/Laurux.conf` existe et que l'utilisateur accepte : `Kill` puis `Copy` sur
  `Start.LocalSettings.Path`, puis arrêt. Le fichier de préférences en mémoire peut être réécrit
  à la fermeture (`Fmenu.form_close` fait `Start.LocalSettings.Save`), à confirmer (A03).
- **`Process_Read()`** [portée : réductible] [nature : calcul] — **code mort** : aucun appel ; lit
  `~/tmp/resultat` ligne à ligne dans `Content` (seule la dernière ligne reste) sans fermer le
  fichier.
- **`Svs_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Choix du répertoire
  (`Dialog.SelectDirectory`) ; annulation → `User.Home`. Copie exacte de `FSauve.Svs_Click`.
- **`Button4_Click()`** [handler] : ouvre `~/tmp/resultat` dans `Editeur` (liste des processus).
  **`Button5_Click()`** [handler] : `Mmysql.Init()` (redémarrage MySQL par `gksu`/`kdesu`) puis
  relance `Button2_Click`, masque `Panel1`. **`Button6_Click()`** [handler] : masque `Panel1`.
  **`Button1_Click()`** [handler] : aide `Doc.Open("Restauration")`. **`Button3_Click()`**
  [handler] : fermeture. [nature : GUI]

## État global utilisé

- `Start.LocalSettings` (`/Rep_Sauv`, `/Compression`, `/dbase/Host`, `.Path`), `Start.Son`,
  `Start.Musique`, `Start.UnLock`.
- `Utils.db` (`Name`, `Login`, `Password`, `Exec`, `Close`), `Utils.Clear_DataBase`,
  `Create_DataBase`, `Fill_DataBase`, `Utils.fermeTunnel`, `Utils.Exit`.
- `Mmysql.Process_List`, `Mmysql.Init`, `Recup.Utilisateur`, `Editeur.Prog_Editeur`,
  `Syntheses.Message`, `Doc.Open`.
- Fichiers : `~/tmp/resultat` (partagé avec `Mmysql` et `FSauve`), `<rep>/<base>.sql[.gz]`,
  `<rep>/Laurux.conf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire l'analyse de la sortie `ls` dans une fonction pure `AnalyseLs(sLigne) As String[]`
  (même algorithme) ; à terme `Stat()` donnerait propriétaire et date (anomalie A01).
- Extraire la détection MariaDB dans `EstMariaDB() As Boolean`.
- Supprimer `Process_Read`/`Content` (code mort) et les doubles `Me.Mouse = Mouse.Default`.

### Commonalisation avec d'autres fichiers

- **Chemin du fichier de sauvegarde** `/Rep_Sauv` + `Utils.db.Name` + `.sql`/`.sql.gz` : calculé
  aussi par [`FSauve`](../FSauve.class/architecture.md), [`SauvesAuto`](../SauvesAuto.module/architecture.md)
  et [`Expbase`](../../Utils/Exports-Imports/Expbase.class/architecture.md) → helper
  `Utils.FichierSauvegarde(sRep, bCompresse)` (EXPBASE-004).
- **Ligne de commande `mysql`** (l. 68) : helper commun UTILS-014
  ([`Utils.module`](../../Utils/Utils.module/architecture.md)), comme `Fill_DataBase`,
  `Clear_DataBase`, `Create_DataBase`, `ControlTunnel`, `Mmysql.Process_List`.
- **Écran jumeau de `FSauve`** : `Svs_Click`, `Button4_Click`, `Button5_Click`, `Button6_Click`
  sont identiques (au nom du panneau près : `Panel1` / `Hbox1`) ; le contrôle `Process_List`
  (0 / > 7) est dupliqué. Helpers communs `Utils.ChoisirRepertoire(sDefaut)` et
  `Mmysql.ControleProcessus() As Integer`.
- **Version applicative** `"majeur.mineur"` (l. 186-187) : `Majversion.RecupVersionApp`
  (MAJVERSION-004).

### Réduction de portée

- `Verif_Version` → `Private` (appel interne uniquement) ; `Process_Read` supprimé.

### Séparation traitement / GUI

- `Button2_Click` : extraire `RestaureBase(sFichier) As String` (Clear/Create/Fill/TRUNCATE,
  renvoie la sortie d'erreur) et `ErreurImport(sSortie, bMariaDB) As Boolean` (condition de la
  l. 132 telle quelle) ; le handler garde les questions, messages et sons.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Docactif` (verrous de documents ouverts) est vidée après restauration : une table de
  verrous hors base société (ou en mémoire serveur) éviterait de la sauvegarder et restaurer.
