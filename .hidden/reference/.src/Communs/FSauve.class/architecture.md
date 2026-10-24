# FSauve — Architecture

> Source : `.src/Communs/FSauve.class`

## Vue d'ensemble

`FSauve` est l'écran **« Sauvegarde de la base »** (menu `Fmenu.Menu57_Click`). Il produit dans le
répertoire choisi (`Sauves`, prérempli par `/Rep_Sauv`) :

- `<rep>/<Utils.db.Name>.sql` : dump `mysqldump --lock-tables=0 … --add-drop-table` ;
- `<rep>/<Utils.db.Name>.sql.gz` : copie compressée (zlib, niveau max) si `Compb` est coché — le
  `.sql` est conservé ;
- `<rep>/Laurux.conf` : copie de `~/.config/gambas3/<Application.Name>.conf` (`Shell cp`).

Ces noms sont exactement ceux qu'attend [`FRestore`](../FRestore.class/architecture.md). Avant le
dump, le nombre de processus MySQL est contrôlé (`Mmysql.Process_List`) : 0 → mot de passe
invalide, > 7 → panneau `Hbox1` proposant un redémarrage de MySQL (`Mmysql.Init`).

Écran **GUI** avec traitement shell intégré ; MySQL/MariaDB uniquement (aucun cas SQLite).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `Lg` | var | Private |  | Integer | 28 |
| `txterror` | var | Private |  | String | 29 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 31-40 | Public | 3 | 7 | 0 | méthode spéciale |
| `Button3_Click` | 42-48 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 50-101 | Public | 12 | 48 | 0 | handler GUI |
| `Svs_Click` | 103-113 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 115-119 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 121-125 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 127-135 | Public | 1 | 7 | 0 | handler GUI |
| `Button6_Click` | 137-141 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Observateurs, `Sauves =
  /Rep_Sauv`, `Compb = /Compression` (`Try`), musique, centrage.
- **`Button3_Click()`** (Fermer) [portée : nécessaire (handler)] [nature : mixte]. Enregistre
  `/Compression = Compb.Value` (`Save`) puis ferme. C'est le **seul** endroit qui mémorise la case :
  une fermeture après sauvegarde réussie (`Me.Close` dans `Button2_Click`) ne l'enregistre pas.
- **`Button2_Click()`** (Sauvegarder, CC 12, max du fichier) [portée : nécessaire (handler, appelé
  aussi par `Button5_Click`)] [nature : mixte].
  1. Supprime `<rep>/<base>.sql` et `~/<base>.sql` (fichier d'un ancien emplacement, supprimé sans
     condition).
  2. `Mmysql.Process_List(0)` : 0 → « Mot de passe invalide ! » ; > 7 → `Hbox1` visible.
  3. Sinon `Shell mysqldump --lock-tables=0 -h <Host> -u <login> -p<mdp> <base> --add-drop-table >
     <rep>/<base>.sql` (mot de passe visible dans `ps`, port et tunnel ignorés, `stderr` non
     capturé).
  4. Si le fichier existe : `txterror` reçoit le **chemin** du fichier et le test
     `Left$(txterror, 9) = "mysqldump"` est toujours faux (branche d'erreur morte, FSAUVE-A01) ;
     `Shell cp` du fichier de configuration ; compression éventuelle (`cp.File`, sans `Try`) ; son,
     message « correctement sauvegardée », fermeture. Si le fichier n'existe pas (répertoire
     absent) : **aucun message** et le curseur reste en attente (FSAUVE-A02).
- **`Svs_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Choix du répertoire ;
  annulation → `User.Home`. Identique à `FRestore.Svs_Click`.
- **`Button1_Click()`** [handler] : aide `Doc.Open("Sauvegarde")`. **`Button4_Click()`** [handler] :
  `~/tmp/resultat` dans `Editeur`. **`Button5_Click()`** [handler] : `Mmysql.Init()`, relance
  `Button2_Click`, masque `Hbox1`. **`Button6_Click()`** [handler] : masque `Hbox1`. [nature : GUI]

## État global utilisé

- `Start.LocalSettings` (`/Rep_Sauv`, `/Compression` lu et écrit, `/dbase/Host`), `Start.Son`,
  `Start.Musique`.
- `Utils.db` (`Name`, `Login`, `Password`), `Utils.Observers`.
- `Mmysql.Process_List`, `Mmysql.Init`, `Editeur.Prog_Editeur`, `Doc.Open`.
- Variable d'instance `Lg` (utilisée comme locale) et `txterror`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Lg` et `txterror` → variables locales ; supprimer la branche morte `Left$(txterror, 9)` (ou la
  corriger, anomalie A01).
- `Shell cp` → `Copy` Gambas (gestion d'erreur différente : anomalie A03).

### Commonalisation avec d'autres fichiers

- **`mysqldump`** : 16 appels construits à la main dans le projet (`FSauve`,
  [`SauvesAuto`](../SauvesAuto.module/architecture.md), `LauruxMaj.module:5051`,
  `Caisse/Moulinage.class:95`, `Compta/Clotures/FClotureAn.class:663`, `Compta/Utils/ImpSage`,
  `ImpJdv`, `Epurjdv`, `Gestion/…/Validinv`, `ValidinvT`, `Archivages/RazHistoTk`, `RazRlvb`,
  `RazClientd`, `RazDevis`, `RazHistoFbl`, `RazHistoFac`). Helper commun
  `Utils.DumpBase(sFichier, Optional sOptions, Optional aTables)` bâti sur la ligne de commande
  MySQL d'UTILS-014 ([`Utils.module`](../../Utils/Utils.module/architecture.md)), options de chaque
  appelant conservées (`--lock-tables=0` ici, absent dans `SauvesAuto`).
- **Chemin de sauvegarde** : `Utils.FichierSauvegarde` (EXPBASE-004, voir
  [`Expbase`](../../Utils/Exports-Imports/Expbase.class/architecture.md)), partagé avec
  `FRestore`, `SauvesAuto`.
- **Écran jumeau de `FRestore`** : `Svs_Click`, `Button4_Click`, `Button5_Click`, `Button6_Click`
  et le contrôle `Process_List` → `Utils.ChoisirRepertoire`, `Mmysql.ControleProcessus`.

### Réduction de portée

- Aucune : toutes les méthodes sont des handlers ou le constructeur (deps.py confirme).

### Séparation traitement / GUI

- Extraire `SauveBase(sRep, bCompresse) As Boolean` (suppression, dump, copie de la
  configuration, compression) sans accès aux contrôles ; le handler garde les messages et sons.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la sauvegarde porte sur la base entière, sans dépendance au schéma.
