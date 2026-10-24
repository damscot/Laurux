# Majversion — Architecture

> Source : `.src/Communs/Majversion.class`

## Vue d'ensemble

`Majversion` est à la fois :

1. l'écran **« Mise à jour de Laurux »** : il lit la page d'index HTTP
   `https://www.laurux.fr/<Application.Name>/`, propose les canaux (`Type`) et versions
   (`ListVersion`) publiés, compare la version web (`…/Stable/version.txt`, téléchargé par `wget`)
   à `Application.Version`, puis télécharge et extrait l'archive `Laurux.tar.gz` (`wget`, `tar`) ;
2. un **service de version** utilisé sans affichage, via l'auto-instance du formulaire :
   `RecupVersion` (version de la base, `Fiches_Parametres.version`, mémorisée dans la variable
   `Public Version`) et `RecupVersionApp` (`"majeur.mineur"` de l'exécutable). Ces deux fonctions
   servent au démarrage (`Fmenu.class:188`) et au contrôle d'échec des migrations
   (`LauruxMaj.module:1118`).

Composants : `gb.net.curl` (`HttpClient`), `gb.xml.html` (`HtmlDocument`), commandes externes
`wget` et `tar`. Fichiers temporaires dans `~/tmp` et `~`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hlb` | var | Private |  | Label | 3 |
| `hpb` | var | Private |  | ProgressBar | 4 |
| `Version` | var | Public |  | String | 5 |
| `siteurl` | var | Private |  | String | 6 |
| `wwwpath` | var | Private |  | String | 7 |
| `selpath` | var | Private |  | String | 8 |
| `version_file` | var | Private |  | String | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 12-16 | Public | 1 | 2 | 0 | méthode spéciale |
| `Form_Open` | 18-60 | Public | 6 | 32 | 0 | handler GUI |
| `Update_Type` | 62-128 | Public | 10 | 54 | 0 | portée réductible ? |
| `OK_Click` | 131-135 | Public | 1 | 3 | 0 | handler GUI |
| `Annuler_Click` | 138-142 | Public | 1 | 3 | 0 | handler GUI |
| `RecupVersion` | 145-156 | Public | 5 | 8 | 2 |  |
| `RecupVersionApp` | 159-170 | Public | 1 | 8 | 1 |  |
| `Verif_Maj` | 173-254 | Public | 21 | 70 | 0 | portée réductible ? |
| `Maj` | 256-315 | Public | 9 | 56 | 0 | portée réductible ? |
| `nversion` | 317-327 | Private | 1 | 8 | 0 |  |
| `Avancement` | 329-367 | Public | 11 | 35 | 0 | portée réductible ? |
| `Type_Click` | 370-374 | Public | 1 | 3 | 0 | handler GUI |
| `ListVersion_Click` | 376-382 | Public | 2 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Service de version (sans GUI)

- **`RecupVersion(Optional b_p_verifmaj = True) As String`** [portée : nécessaire (`Fmenu`,
  `LauruxMaj`)] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (nom en dur, sans test
  `Available`), `Version = rResult!version`, réinitialise `version_file`. Si `/Majver` est vrai,
  que l'exécutable n'est pas installé dans `/usr/bin` et que `b_p_verifmaj` : `Verif_Maj()`
  (contrôle réseau et proposition de mise à jour **à chaque démarrage**). Renvoie `Version`.
  Partie extractible : la lecture SQL (`LitVersionBase`).
- **`RecupVersionApp() As String`** [portée : nécessaire (`LauruxMaj`)] [nature : calcul].
  `"majeur.mineur"` d'`Application.Version` (ex. `3.69.0` → `3.69`). Même calcul recopié dans
  `Verif_Maj` (l. 183-185) et dans [`FRestore.Verif_Version`](../FRestore.class/architecture.md)
  (l. 186-187).
- **`Version`** (variable `Public`) : lue par `LauruxConf` (l. 190, 404) et `LauruxMaj` (l. 1042,
  1047) ; vide tant que `RecupVersion` n'a pas été appelé sur l'auto-instance.

### Écran de mise à jour

- **`_New()`** [portée : nécessaire (constructeur)] — corps vide (code mort).
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. Titre, `GET` synchrone
  (délai 5 s) de `wwwpath`, extraction des liens `<a>` (à partir du 2ᵉ, le premier étant le lien
  parent de l'index) dans `Type` ; puis `Update_Type` sur le canal courant. Sans réseau, `Type`
  reste vide et `Type.Current.Text` provoque probablement une erreur (aucun `Catch`, à confirmer,
  MAJVERSION-A04).
- **`Update_Type(wwwlpath, Type, Optional Ver) As String`** [portée : réductible] [nature : mixte].
  `GET` de `wwwlpath & Type`, liens contenant `/` → `ListVersion` (sélection de `Ver` si fourni),
  puis `RecupVersion()` (donc possible `Verif_Maj` réseau), affiche `VerAct`, appelle
  `Verif_Maj(chemin, False)` et affiche `VerWeb`. Renvoie le chemin de la version choisie. Si
  `Verif_Maj` renvoie `Null` (site injoignable), `VersionWebArr.Length` lève une erreur (A02).
- **`Verif_Maj(Optional wwwlpath = wwwpath, Optional Update = True) As String[]`** (CC 21, max du
  fichier) [portée : réductible] [nature : mixte]. Crée `~/tmp`, supprime `pb1.txt`, `ping.txt`,
  `version.txt` et `~/Laurux.tar.gz` ; teste l'accès à `wwwpath` (**pas** `wwwlpath`) ; échec →
  `Message.Error` et `Return` sans valeur (`Null`). Le fichier `ping.txt` n'est plus jamais créé :
  le test `InStr(txt, "1 received")` est toujours vrai (code mort). Télécharge
  `<wwwlpath>/Stable/version.txt` par `wget`, le découpe par `nversion` ; si `Update` : propose la
  mise à jour quand le **mineur** web > mineur local, ou mineurs égaux et correctif supérieur (le
  majeur est ignoré, A01 ; accès à `VersionWebArr[2]` hors bornes si la version web n'a que deux
  composants, A03). Renvoie le tableau de version ou `[]`. `Catch` → son + `Message.Error`.
- **`Maj(FullVersion, Optional wwwlpath = wwwpath)`** [portée : réductible] [nature : mixte].
  Construit dynamiquement une fenêtre de progression (`Label`, `ProgressBar` dans `hlb`/`hpb`),
  retélécharge `version.txt` dans `~`, demande confirmation, renomme `Laurux3.gambas` et `Laurux`
  du répertoire de l'application en `.old`, lance `wget …/Stable/<version>/Laurux.tar.gz` **sans
  attendre** (journal dans `~/tmp/pb1.txt`), suit la progression (`Avancement`), extrait l'archive
  dans `~` (`tar xvfz`), supprime l'archive et `version.txt`, propose de quitter (`Quit`).
  `Shell "cd " & User.Home` est sans effet. `Catch` → son `son/warning.ogg` (chemin relatif) +
  `Message.Error`.
- **`nversion(VersionWebFull) As String[]`** [Private] [nature : calcul]. Première ligne,
  suppression de `"<Application.Name> "`, `V` et `v`, découpe sur `.`.
- **`Avancement(hlb, hpb)`** [portée : réductible] [nature : mixte]. Attente **active** de
  l'apparition de `~/tmp/pb1.txt` (boucle sans `Wait`), puis relit le journal `wget` jusqu'à 100 % :
  ligne de 75 à 78 caractères avec `"K "` en colonne 7, pourcentage en colonne 63 (format du
  journal `wget` en points, dépendant de la version et de la langue de `wget`). Boucle infinie si
  le téléchargement n'atteint jamais 100 % (A05).
- **`OK_Click()`** [handler] : `Verif_Maj(selpath, True)`. **`Annuler_Click()`** [handler] :
  fermeture. **`Type_Click()`** / **`ListVersion_Click()`** [handlers] : `Update_Type` sur le canal
  ou la version sélectionnés. [nature : GUI]

## État global utilisé

- `Utils.db` (lecture `Fiches_Parametres`), `Start.LocalSettings["/Majver"]`, `Start.Musique`.
- `Application.Name`, `Application.Version`, `Application.Path`, `User.Home`.
- Fichiers : `~/tmp/pb1.txt`, `~/tmp/ping.txt`, `~/tmp/version.txt`, `~/version.txt`,
  `~/Laurux.tar.gz`, `<Application.Path>/Laurux3.gambas`, `<Application.Path>/Laurux`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Séparer le **service de version** (`RecupVersion`, `RecupVersionApp`, `Version`) de l'écran : un
  module `LVersion` éviterait d'instancier un formulaire pour lire une version. Déplacement hors
  périmètre de ce plan ; dans ce fichier, isoler `LitVersionBase()` sans GUI.
- `Form_Open` et `Update_Type` dupliquent le `GET` + extraction des liens : helper privé
  `ListeLiens(sUrl) As String[]`.
- `Verif_Maj` : supprimer la logique `ping.txt` morte, remplacer la cascade de comparaison par une
  fonction pure `CompareVersions(aWeb, aApp) As Integer` (comportement identique, majeur toujours
  ignoré tant que A01 n'est pas validée).
- `Avancement` : remplacer l'attente active par `Wait 0.1` dans la boucle (même résultat, CPU
  libéré) — classé en anomalie A05 car la temporisation change.

### Commonalisation avec d'autres fichiers

- Calcul `"majeur.mineur"` : `Verif_Maj` (l. 183-185) et
  [`FRestore.Verif_Version`](../FRestore.class/architecture.md) (l. 186-187) → `RecupVersionApp`.
- Lecture de `Fiches_Parametres.version` : aussi faite par `FRestore.Verif_Version` et
  `LauruxMaj.Verif_Version` ; `RecupVersion(False)` peut servir aux deux.
- `HttpClient` synchrone + `wget` : autres usages de téléchargement dans le projet à recenser lors
  des lots suivants (à confirmer).

### Réduction de portée

- `Update_Type`, `Verif_Maj`, `Maj`, `Avancement` : aucun appel externe (vérifié ; les
  `PB.Avancement` de `Moulinage`, `GedR`, `DB_Sanity` visent une autre classe) → `Private`.
  Couverture : replays de l'écran.

### Séparation traitement / GUI

- `Verif_Maj` : la décision « mise à jour disponible » (calcul pur) doit être séparée des
  `Message.Question`/`Message.Warning`.
- `RecupVersion` : lecture SQL pure + appel conditionnel de `Verif_Maj` dans l'appelant.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Parametres.version` est une chaîne `"3.69"` comparée textuellement ; un numéro de
  version entier (`369`) ou un triplet de colonnes simplifierait les comparaisons.
