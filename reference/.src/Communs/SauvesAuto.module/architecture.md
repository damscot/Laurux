# SauvesAuto — Architecture

> Source : `.src/Communs/SauvesAuto.module`

## Vue d'ensemble

`SauvesAuto` réalise la **sauvegarde automatique** de la base courante à la fermeture de la
fenêtre principale (`Fmenu.form_close`, `Fmenu.class:1228`), si `/Soc<XX>/Sauvauto` et
`/dbase/Maj` sont actifs. Une seule fonction, `Sauvegarde(Menu)` :

1. `mysqldump … --add-drop-table > <Rep_Sauv>/<base>.sql` (sans `--lock-tables=0`, contrairement
   à [`FSauve`](../FSauve.class/architecture.md)) ;
2. compression en `<Rep_Sauv>/<base><WeekDay(Now)>.sql.gz` (rotation sur 7 jours, 0 = dimanche) ;
3. envoi facultatif de l'archive par **FTP** (`/Soc<XX>/Envoiftp`, `/Adrbase`, `/Idftp`,
   `/MdpFTP` chiffré avec la clé `Laurux`).

Le fichier `<base>.sql` non compressé est conservé : c'est lui que
[`FRestore`](../FRestore.class/architecture.md) peut restaurer.

Nature : **mixte** (shell, fichiers, FTP et messages/souris de la fenêtre passée en paramètre).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Sauvegarde` | 6-43 | Public | 10 | 35 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Sauvegarde(Menu As Form)`** [portée : nécessaire (`Fmenu`)] [nature : mixte].
  - `/Rep_Sauv` vide → `Message.Warning` « Aucun chemin n'est défini… ».
  - Sinon curseur d'attente sur `Menu`, `Try Mkdir` du répertoire (un seul niveau), suppression de
    `<rep>/<base>.sql`, `Shell mysqldump -h <Host> -u <login> -p<mdp> <base> --add-drop-table >
    <rep>/<base>.sql` (`Wait` ; mot de passe visible dans `ps` ; port et tunnel ignorés ; code
    retour et `stderr` ignorés).
  - `Try cp.File(…)` vers `<base><jour>.sql.gz` ; erreur → `Message.Error(Error.Text)` (curseur
    laissé en attente).
  - Si `/Soc<XX>/Envoiftp` : URL = `/Adrbase & "/" & <base><jour>.sql.gz` (jamais nulle, donc le
    message « URL du serveur FTP n'est pas renseignée » est inatteignable), utilisateur, mot de
    passe déchiffré, `hftp.Put(<fichier>)` **sans `Try`** ; le `If Error` suivant teste l'erreur du
    `Try cp.File` précédent (toujours faux à ce stade) → « Sauvegarde terminée ! » affiché par
    `Message.Warning`. Une erreur FTP lève une exception non interceptée pendant la fermeture de
    l'application. Le mode synchrone ou asynchrone de `FtpClient.Put` (objet local détruit en fin
    de fonction) est à confirmer.
  - Sans FTP : aucun message de fin et le curseur de `Menu` n'est pas restauré (fenêtre en cours
    de fermeture).

## État global utilisé

- `Start.LocalSettings` : `/Rep_Sauv`, `/dbase/Host`, `/Soc<XX>/Envoiftp`, `/Soc<XX>/Adrbase`,
  `/Soc<XX>/Idftp`, `/Soc<XX>/MdpFTP` ; `Start.Societe`.
- `Utils.db` (`Name`, `Login`, `Password`), `hexdblKey.Crypt`.
- Composants `gb.compress` (`Compress`) et `gb.net.curl` (`FtpClient`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Calculer une seule fois le nom `<rep>/<base><jour>.sql.gz` (répété 4 fois, `WeekDay(Now)`
  réévalué à chaque fois : un passage à minuit entre deux appels donnerait des noms différents).
- Supprimer la branche « URL non renseignée » inatteignable, ou tester `/Adrbase` (anomalie A03).

### Commonalisation avec d'autres fichiers

- **`mysqldump`** : helper commun `Utils.DumpBase(sFichier, sOptions)` (créé ici, voir
  SAUVESAUTO-003) utilisé par [`FSauve`](../FSauve.class/architecture.md) et, à terme, par les 14
  autres appels du projet (`LauruxMaj`, `Moulinage`, `FClotureAn`, `ImpSage`, `ImpJdv`, `Epurjdv`,
  `Validinv`, `ValidinvT`, `Raz*`), sur la base de la ligne de commande MySQL d'UTILS-014
  ([`Utils.module`](../../Utils/Utils.module/architecture.md)).
- **Chemin de sauvegarde** : `Utils.FichierSauvegarde` (EXPBASE-004, voir
  [`Expbase`](../../Utils/Exports-Imports/Expbase.class/architecture.md)) avec `FSauve`,
  `FRestore`.
- **Envoi FTP** : `Prefs` gère aussi `/Adrbase3`, `/MdpFTP3` (deuxième destination, non utilisée
  ici, à confirmer) ; un helper `Utils.EnvoiFtp(sFichier, sUrl, sUser, sMdpChiffre)` serait
  réutilisable.

### Réduction de portée

- Aucune : `Sauvegarde` est appelée par `Fmenu`.

### Séparation traitement / GUI

- Extraire `SauveAuto(sRep) As String` (dump + compression, renvoie le fichier ou l'erreur) et
  `EnvoiFtp(...) As Boolean` ; `Sauvegarde(Menu)` garde le curseur et les messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : sauvegarde de la base entière, indépendante du schéma.
