# EnvMail — Architecture

> Source : `.src/Gestion/Mails/EnvMail.module`

## Vue d'ensemble

`EnvMail` est le **module d'envoi de courriels** de Laurux. Il offre deux mécanismes distincts :

1. **Envoi direct SMTP** (`Envoi`) via `SmtpClient` (composant `gb.net.smtp`) : serveur, port,
   expéditeur, utilisateur, mot de passe (déchiffré par `hexdblKey.Crypt`) et chiffrement sont lus
   dans les préférences générales (`/Smtp`, `/Port`, `/Adrmail`, `/Utilisateur`, `/MdpStmp`,
   `/Secumail`). Utilisé pour l'envoi « silencieux » : ticket de caisse (`Caisse`), facture
   (`ObjFacB`), mailings (`Emailing`, `EmailingCarte`).
2. **Ouverture d'une fenêtre de composition** dans le client de messagerie de l'utilisateur
   (`Envoi2`, `Envoi3`, et les variantes mortes `Envoi2b`, `Envoi5`) : le programme est choisi par
   `/Soc<XX>/Prgmail` (`Thunderbird`, `Icedove`, `Evolution`, `Kmail`) et lancé par `Shell` (ligne
   de commande construite par concaténation) ou `Exec` (Evolution). L'envoi effectif est fait par
   l'utilisateur dans son client.

La fonction utilitaire `Extension` déduit un type MIME du nom d'un fichier (pièce jointe des mailings).

Le module n'accède **pas** à la base de données. Il est sans état (aucune variable de module).
Nature globale : **mixte** (traitement d'envoi + `Message.Error`/`Message.Warning`).

### Dépendances externes

| Dépendance | Fonction | Remarque |
|---|---|---|
| `gb.net.smtp` (`SmtpClient`) | `Envoi` | serveur SMTP réel ; `Debug = True` (dialogue SMTP sur la sortie d'erreur) |
| `thunderbird -compose` | `Envoi2`, `Envoi2b`, `Envoi3`, `Envoi5` | `Shell` (interprété par `/bin/sh`) |
| `icedove -compose` | `Envoi2`, `Envoi2b`, `Envoi3` | `Shell` ; Icedove est l'ancien nom Debian de Thunderbird |
| `evolution mailto:` | `Envoi2`, `Envoi2b`, `Envoi3` | `Exec` (sans shell) |
| `kmail` | `Envoi2`, `Envoi2b`, `Envoi3` | `Shell` |
| `hexdblKey.Crypt` | `Envoi` | déchiffrement du mot de passe SMTP stocké dans `Laurux.conf` |

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Envoi` | 3-46 | Public | 9 | 40 | 4 |  |
| `Envoi2b` | 48-85 | Public | 7 | 32 | 0 | portée réductible ? |
| `Envoi3` | 87-122 | Public | 6 | 29 | 1 |  |
| `Envoi5` | 124-153 | Public | 7 | 29 | 0 | portée réductible ? |
| `Envoi2` | 155-206 | Public | 13 | 47 | 9 |  |
| `Extension` | 208-276 | Public | 56 | 61 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Envoi SMTP direct

- **`Envoi(Email, sujet, Txt, piece, chemin, TypeM, FileN) As Boolean`** [portée : nécessaire]
  [nature : mixte]. Appelants : `Caisse.class:4631`, `ObjFacB.class:674`, `Emailing.class:848/862`,
  `EmailingCarte.class:534/546`.
  - Ne fait rien si `Email` est vide (`IsNull`) et renvoie `False`.
  - Configure `SmtpClient` : `Debug = True`, `Host = /Smtp`, `Port = /Port`, `From = /Adrmail`,
    `User = /Utilisateur`, `Password = hexdblKey.Crypt("de", /MdpStmp, "Laurux")`,
    `Encrypt` selon `/Secumail` (`Sans`/`SSL`/`TLS` ; une valeur absente donne `Null`, à confirmer :
    conversion en `Net.None`), authentification automatique, corps `text/plain` sans alternative.
  - Ajoute **toujours** l'expéditeur en copie cachée : `.Bcc.Add(Settings["/Adrmail"])`. ⚠️ lit
    l'objet `Settings` par défaut de Gambas (fichier `~/.config/gambas3/Laurux.conf`) et non
    `Start.LocalSettings` : avec un fichier de configuration passé par `-c`, la copie cachée part à
    l'adresse du fichier par défaut (ou à une adresse vide).
  - Pièces jointes, seulement si `piece = True` : le fichier `chemin & FileN` (type `TypeM`), puis,
    si `/Soc<XX>/Pdfchemin` est renseigné, ce second fichier (conditions générales de vente, type
    `TypeM` réutilisé quel que soit son format). Le nom affiché de la seconde pièce est la fin du
    chemin (`spiece2`). Les deux branches `If` dupliquent le même premier `.Add`.
  - `File.Load` n'est **pas** protégé : un fichier absent lève une erreur propagée à l'appelant.
  - `Try .Send()` ; en cas d'échec : `Message.Error(Error.Text & Error.Where …)` puis `Return True`.
    Aucun appelant n'exploite la valeur renvoyée.
  - ⚠️ Contrat implicite : `chemin` est un **répertoire** terminé par `/` et `FileN` le nom du
    fichier (`Caisse`, `ObjFacB`). `Emailing` et `EmailingCarte` passent le chemin **complet** dans
    `chemin` **et** le nom dans `FileN` : la pièce jointe d'un mailing est introuvable (voir
    EMAILING-A02, EMAILINGCARTE-A02).

### Ouverture du client de messagerie

Les quatre fonctions suivantes partagent le même schéma : lecture de `/Soc<XX>/Prgmail`, puis
`Select Case` sur le programme ; `Message.Warning` si le programme n'est pas défini. Pour
Thunderbird et Icedove, le corps est « encodé » à la main : `,`→`%2C`, `\n`→`%0A`, `(`→`{`,
`)`→`}`, `'`→espace, `;`→`%2C` (bloc de 6 `Replace$` copié **8 fois** dans le module). Ni
l'adresse, ni le sujet, ni les chemins ne sont échappés ; `"`, `$`, `` ` `` et `\` du corps ne le
sont pas non plus : le texte est interprété par `/bin/sh` (risque d'injection de commande, voir
ENVMAIL-A04).

- **`Envoi2(Email, sujet, Corps, piece, Optional piece2, Optional piece3 As String[])`**
  [portée : nécessaire] [nature : mixte]. Fonction la plus utilisée (11 appels, 9 fichiers :
  `Expbase`, `ObjFacB`, `Achat`, `Bordrx`, `FClient`, `FFournisseur`, `ExportA47`, `Ligcli` ×2,
  `ExportJdv`). Thunderbird : une ou deux pièces jointes (`piece`, `piece2`) ; si `piece3` est
  fourni, ajoute `/Soc<XX>/Bexpcheminpj/<piece3[i]>` (lu via `Settings` et non
  `Start.LocalSettings`). **Aucun appelant ne passe `piece3`** : la branche est morte en pratique.
  Icedove, Evolution, Kmail : `piece2` est **ignorée** (une seule pièce jointe). Evolution reçoit
  `"\\&body="` : le `\` littéral est transmis à Evolution par `Exec` (pas de shell), il finit
  probablement dans le sujet (à confirmer).
- **`Envoi3(Email, sujet, Corps, piece)`** [portée : nécessaire] [nature : mixte]. Comme `Envoi2`,
  mais la seconde pièce jointe est toujours `/Soc<XX>/Pdfchemin` (CGV). Unique appelant :
  `ExportJdv.class:1000`, qui passe **5 arguments** (`Email, stext, sText2, Fle1, Fle2`) : erreur
  d'exécution « Too many arguments » (vérifié sur un projet minimal : `gbc3` compile, `gbx3` lève
  l'erreur), interceptée par le `Catch` de `ExportJdv.export` qui affiche « Le fichier n'a pas pu
  être envoyé ». `Envoi3` ne s'exécute donc **jamais** ; l'intention de l'appelant (joindre
  `clients.txt` et le fichier d'écritures) correspond à `Envoi2(…, Fle1, Fle2)` (ENVMAIL-A01).
- **`Envoi2b(Email, sujet, Corps, piece, Optional piece2)`** [portée : réductible] [nature : mixte]
  — **code mort** (aucun appelant, vérifié par `grep -rn Envoi2b .src`). Variante ancienne
  d'`Envoi2` (Icedove sans guillemets).
- **`Envoi5(Email, sujet, Corps, piece, Optional piece2 As String[])`** [portée : réductible]
  [nature : mixte] — **code mort** (aucun appelant). Thunderbird seulement ; `piece2.Count` sur un
  tableau absent lèverait une erreur ; boucle à partir de l'indice 1 ; chemin `/Bexpchemin` lu via
  `Settings`. Variables `Pjointe` inutilisées (aussi dans `Envoi2`).

### Utilitaire

- **`Extension(FileN) As String`** [portée : nécessaire] [nature : calcul]. Appelants :
  `Emailing.btnopen_Click`, `EmailingCarte.btnopen_Click`. Découpe le nom sur `.` et teste les
  segments **1 et 2** (pas le dernier) contre une liste d'extensions (`html`, `pdf`, `odt`…) ;
  renvoie le type MIME, ou `""`.
  - ⚠️ Un nom sans point (`"doc"`) ou avec un seul point et une extension inconnue (`"a.docx"`)
    lève « Out of bounds » sur `Ext[1]`/`Ext[2]` (vérifié) : l'appelant affiche « Impossible
    d'ouvrir le fichier » et la pièce jointe n'est pas retenue.
  - Un nom à plusieurs points (`facture.2024.pdf`) est reconnu par le segment 2, mais
    `a.b.c.pdf` ne l'est pas.
  - Incohérences : `rtf` est d'abord `application/rtf` puis écrasé par `application/msword` ;
    `wav` donne `video/wav` ; `ods/odp/odt` donnent `application/x-zip` ; casse du type non
    normalisée (`text/HTML` si l'extension est en majuscules). Une vingtaine de `If` par itération (CC 56, maximum du fichier).

## État global utilisé

- `Start.LocalSettings` : `/Smtp`, `/Port`, `/Adrmail`, `/Utilisateur`, `/MdpStmp`, `/Secumail`,
  `/Soc<XX>/Pdfchemin`, `/Soc<XX>/Prgmail` (écrits par `Prefs`).
- `Settings` (objet par défaut de Gambas, **différent** de `Start.LocalSettings` quand `-c` est
  utilisé) : `/Adrmail` (copie cachée, `Envoi`), `/Soc<XX>/Bexpchemin` (`Envoi5`),
  `/Soc<XX>/Bexpcheminpj` (`Envoi2`).
- `Start.Societe`.
- `hexdblKey.Crypt` (déchiffrement du mot de passe SMTP).

## Sécurité (relevé)

- **Mot de passe SMTP** : stocké chiffré de façon réversible avec une clé fixe (`"Laurux"`) dans
  `Laurux.conf` ; `SmtpClient.Debug = True` écrit le dialogue SMTP sur la sortie d'erreur. Avec une
  authentification `PLAIN`/`LOGIN`, la ligne `AUTH` contient l'identifiant et le mot de passe en
  base64, donc lisibles dans la console ou dans un journal qui capture `stderr` (à confirmer selon
  la version de `gb.net.smtp` ; ENVMAIL-A03).
- **Chiffrement** : `/Secumail = Sans` envoie identifiants et contenu en clair sur le réseau.
- **Injection de commande** : `Envoi2/2b/3/5` construisent une ligne de commande `Shell` avec
  l'adresse (fiche client ou fournisseur), le sujet, le corps (textes `Tmail`/`ComMail`,
  `Variables.sTexte`) et les chemins sans échappement (ENVMAIL-A04).
- **Divulgation** : la copie cachée systématique peut partir vers une adresse inattendue avec `-c`
  (ENVMAIL-A02).

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire le bloc des 6 `Replace$` dans une fonction privée `EncodeCorps(corps) As String`
  (8 copies identiques).
- Extraire la construction de la commande Thunderbird `ComposeThunderbird(Email, sujet, corps,
  pieces As String[])` : elle sert à `Envoi2`, `Envoi3` (et aux variantes mortes).
- `Envoi` : regrouper les deux branches de pièce jointe (`.Add` du premier fichier commun, puis
  `If Not IsNull(piece2)`) sans changer l'ordre des pièces.
- `Extension` : table de correspondance (`Collection` extension → type) indexée par la
  **dernière** extension ; à comportement constant il faut garder le parcours des segments 1 et 2
  et l'erreur « Out of bounds » (la correction est l'anomalie ENVMAIL-A05).

### Commonalisation avec d'autres fichiers

- La copie de mail par client de messagerie est aussi réalisée en ligne par
  [`Bordrx`](../../Lcr/Bordrx.class/architecture.md) (commentaire `xdg-email` l. 520) : une
  bascule vers `xdg-email` (`Exec`, sans shell) unifierait tous les clients (changement de
  comportement, hors rework).
- Les modules SMS ([`Gsm`](../../SMS/Gsm.class/architecture.md),
  [`Emailing`](../Emailing.class/architecture.md)) partagent la même technique `Shell` + fichier
  `~/tmp/sms.txt` : un module d'envoi SMS distinct est proposé dans Gsm (GSM-005).

### Réduction de portée

- `Envoi2b`, `Envoi5` : code mort, à supprimer (ENVMAIL-002) plutôt qu'à réduire.
- `Envoi3` : reste `Public` tant que l'anomalie ENVMAIL-A01 n'est pas tranchée.

### Séparation traitement / GUI

- `Envoi` : isoler la préparation et l'envoi (`EnvoiSmtp(…) As String` qui renvoie le texte
  d'erreur) ; `Envoi` garde `Message.Error` (même message).
- `Envoi2`/`Envoi3` : séparer la construction de la ligne de commande (fonction pure
  `CommandeMail(programme, Email, sujet, corps, pieces) As String`, testable en gb.test) du
  `Shell` et du `Message.Warning`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : le module n'accède pas à la base. Les tables `Mails_Cli` / `Mails_Four` (adresses
  multiples par tiers) ne sont pas exploitées par `EnvMail` : seule l'adresse unique de la fiche
  (`cli_email`) est utilisée par les appelants.
