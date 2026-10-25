# Emailing — Architecture

> Source : `.src/Gestion/Mails/Emailing.class`

## Vue d'ensemble

`Emailing` est l'écran d'**envoi groupé de courriels aux clients** (`Fiches_Cli`), avec une
variante **SMS groupés** prévue mais inopérante. Il est ouvert par `Fmenu` :
- `Menu175_Click` (« E-mailing ») : `New Emailing("mail")` ;
- `Menu320_Click` (« SMS › Envoi multiples », visible si `/Soc<XX>/Sms` ≠ 0) : `New Emailing("sms")`.

Sélection des destinataires (cadre `Frame2`) :
- **plage de codes** `Client1`…`Client2` (valeurs par défaut `41100001`…`4119999999`), avec grilles
  de recherche `Colcli`/`Colcli2` (F2 ou boutons) ;
- **filtre optionnel par type client** (`CheckType`, plage `Type`…`Type2`, grilles `ColType`/`ColType2`
  sur `Fiches_Typec`) ;
- **filtre optionnel par statut** (`bstatut` + combo `Statut` alimenté par `Fiches_Statut`) ;
- **case « code postal »** (`CheckCp`, plage `Cp1`…`Cp2`) : n'agit **que sur le tri**, la plage
  n'est jamais utilisée dans le SQL (EMAILING-A05) ;
- **ordre** : `RadioButton1` (code), `RadioButton2` (type), `RadioButton3` (code postal) ;
- **mode liste** (`Liste`) : saisie code par code dans une table de travail `Cli_Mailing`
  (créée/supprimée par `liste_Click`).

`Button2` (« Envoyer ») parcourt la sélection et appelle `EnvMail.Envoi` pour chaque client
(sujet `TextBox1`, texte `sText`, pièce jointe optionnelle `TextBox2` choisie par `btnopen`).

Nature globale : **mixte** ; toute la logique SQL est dans les handlers. Copie quasi identique
d'[`EmailingCarte`](../EmailingCarte.class/architecture.md) (cartes de fidélité) et
d'[`Eticli`](../../Etiquettes/Eticli.class/architecture.md) (étiquettes clients).

### Dépendances externes (mode SMS)

| Dépendance | Fonction | Remarque |
|---|---|---|
| `curl` + API HTTP Spot-Hit (`http://www.spot-hit.fr/api/credits/`, `/api/envoyer/sms`) | `Label7_GotFocus`, `EnvoiSms` | clé API dans l'URL, en **HTTP** non chiffré, sur la ligne de commande (`ps`) |
| `gammu sendsms` (clé 3G Huawei / Nokia, port série ou USB du modem) | `EnvoiSms` | support `1-` ; non appelé (code mort) |
| fichier `~/tmp/sms.txt` | `Label7_GotFocus`, `EnvoiSms` | sortie de `curl`/`gammu`, partagé avec `Gsm`, `Psms`, `Prefs` |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TypeM` | var | Private |  | String | 27 |
| `FileN` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `rCli` | var | Private |  | Result | 31 |
| `rCli2` | var | Private |  | Result | 32 |
| `son` | var | Private |  | Integer | 33 |
| `CoulZns` | var | Private |  | Integer | 34 |
| `CoulZnaf` | var | Private |  | Integer | 35 |
| `CoulFoc` | var | Private |  | Integer | 36 |
| `Clitable` | var | Private |  | New String[3] | 37 |
| `Sens` | var | Private |  | String | 38 |
| `Tri` | var | Private |  | String | 39 |
| `Piece` | var | Private |  | Boolean | 40 |
| `Adr_Mail` | var | Private |  | String | 41 |
| `$type` | var | Private |  | String | 42 |
| `$gsm` | var | Private |  | String | 43 |
| `mesg` | var | Private |  | String | 44 |
| `$Txt` | var | Private |  | String | 45 |
| `Support` | var | Private |  | String | 46 |
| `$contrat` | var | Private |  | String | 47 |
| `Api` | var | Private |  | String | 48 |
| `Expediteur` | var | Private |  | String | 49 |
| `ilettre` | var | Private |  | Integer | 50 |
| `premium` | var | Private |  | String | 51 |
| `lowcost` | var | Private |  | String | 52 |
| `credit` | var | Private |  | Boolean | 53 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 55-113 | Public | 9 | 55 | 0 | méthode spéciale |
| `Form_Show` | 115-119 | Public | 2 | 3 | 0 | handler GUI |
| `Label7_GotFocus` | 121-157 | Public | 14 | 35 | 0 | handler GUI |
| `CheckType_Click` | 159-170 | Public | 3 | 10 | 0 | handler GUI |
| `CheckCp_Click` | 172-183 | Public | 3 | 10 | 0 | handler GUI |
| `Tris` | 187-197 | Public | 1 | 9 | 0 | portée réductible ? |
| `Tris2` | 199-209 | Public | 1 | 9 | 0 | portée réductible ? |
| `Colcli_Data` | 211-221 | Public | 3 | 8 | 0 | handler GUI |
| `Colcli2_Data` | 223-233 | Public | 3 | 8 | 0 | handler GUI |
| `Colcli_ColumnClick` | 235-244 | Public | 1 | 7 | 0 | handler GUI |
| `Colcli2_ColumnClick` | 246-255 | Public | 1 | 7 | 0 | handler GUI |
| `colinit` | 257-275 | Public | 4 | 17 | 0 | portée réductible ? |
| `AffClients` | 280-290 | Public | 1 | 8 | 0 | portée réductible ? |
| `AffClients2` | 295-305 | Public | 1 | 8 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 310-326 | Public | 2 | 14 | 0 | handler GUI |
| `ColCli_Click` | 331-344 | Public | 2 | 12 | 0 | handler GUI |
| `Cli_Man` | 349-377 | Public | 6 | 26 | 0 | portée réductible ? |
| `ColCli_KeyPress` | 382-403 | Public | 7 | 18 | 0 | handler GUI |
| `ToggleButton2_Click` | 408-424 | Public | 2 | 14 | 0 | handler GUI |
| `ColCli2_KeyPress` | 429-450 | Public | 7 | 18 | 0 | handler GUI |
| `ColCli2_Click` | 455-463 | Public | 1 | 7 | 0 | handler GUI |
| `ToggleButton3_Click` | 469-501 | Public | 5 | 30 | 0 | handler GUI |
| `ColType_KeyPress` | 506-526 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 531-563 | Public | 5 | 30 | 0 | handler GUI |
| `ColType2_KeyPress` | 568-588 | Public | 6 | 17 | 0 | handler GUI |
| `ColType_Click` | 593-601 | Public | 1 | 7 | 0 | handler GUI |
| `ColType2_Click` | 606-614 | Public | 1 | 7 | 0 | handler GUI |
| `Btn_Click` | 616-631 | Public | 4 | 10 | 0 | handler GUI |
| `Btn_KeyPress` | 633-640 | Public | 2 | 6 | 0 | handler GUI |
| `liste_Click` | 642-681 | Public | 4 | 37 | 0 | handler GUI |
| `ChkInput` | 683-691 | Public | 7 | 7 | 0 | portée réductible ? |
| `Etiq_KeyPress` | 693-780 | Public | 25 | 72 | 0 | handler GUI |
| `sText_KeyPress` | 782-795 | Public | 3 | 12 | 0 | handler GUI |
| `Button2_Click` | 797-900 | Public | 37 | 102 | 0 | portée réductible ? |
| `EnvoiSms` | 902-939 | Public | 10 | 36 | 0 | portée réductible ? |
| `btnopen_Click` | 941-957 | Public | 4 | 15 | 0 | handler GUI |
| `OBS_GotFocus` | 959-969 | Public | 6 | 9 | 0 | handler GUI |
| `OBS_LostFocus` | 971-979 | Public | 4 | 7 | 0 | handler GUI |
| `SetObservers` | 981-993 | Public | 4 | 10 | 0 | portée réductible ? |
| `bstatut_Click` | 995-1003 | Public | 2 | 7 | 0 | handler GUI |
| `Button1_Click` | 1005-1013 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New(sType)`** [portée : nécessaire] [nature : mixte]. Mode SMS si `sType = "sms"` : masque
  sujet et pièce jointe, libellés SMS, compteur `TextLabel1`. Charge la musique et les couleurs
  (`Utils.FColr`), appelle **deux fois** `Utils.Observers(Me)` (l. 84 et 102 : observateurs de
  rejeu probablement cumulés), `SetObservers(Me, Me)`, masque les panneaux type/CP, pose les
  valeurs par défaut des plages, remplit `Statut` (`SELECT * FROM Cbase.Table("TabStatut")`) et
  ajoute un élément vide en tête. `CoulZnaf` est calculé mais jamais utilisé.
- **`Form_Show`** [GUI] : en mode SMS, `Label7.SetFocus`.
- **`Label7_GotFocus`** [GUI, mixte]. Mode SMS : supprime `~/tmp/sms.txt`, vérifie `/Smtp`,
  `Port`, `/Adrmail` (inutile pour des SMS ; `Port` sans `/` équivaut à `/Port`, vérifié), lit
  `/Soc<XX>/Support`, `/Api`, `/Type`, `/Expediteur`, puis interroge les crédits Spot-Hit par
  `Shell "curl …?key=<Api>"` et découpe la réponse JSON à la main (`Mid$`/`InStr`). Affiche le
  solde premium/lowcost ou « clé API mauvaise » et ferme. ⚠️ `Label7` est un `Label` : il ne
  prend probablement jamais le focus, donc ce contrôle de crédit ne s'exécuterait pas (à
  confirmer en replay). La requête est faite même si le support est la clé GSM (`1-`).
- **`CheckType_Click`**, **`CheckCp_Click`** [GUI] : affichent ou masquent `RadioButton2`/`Panel3`
  et `RadioButton3`/`Panel2`. Le bouton radio masqué reste éventuellement sélectionné (voir
  EMAILING-A06).

### Grilles de recherche des clients et des types

- **`Tris`**, **`Tris2`** [portée : réductible] [GUI] : colonnes « Code / Nom » de `colcli` /
  `colcli2` (deux copies).
- **`Colcli_Data`**, **`Colcli2_Data`** [GUI] : affichage virtuel depuis `Utils.rs1` (global
  partagé par les deux grilles et par les autres écrans qui utilisent `Utils.Base`).
- **`Colcli_ColumnClick`**, **`Colcli2_ColumnClick`** → **`colinit(Col, Coln)`** [portée :
  réductible] [GUI] : inverse le sens et retrie par `cli_code` ou `cli_nom`. ⚠️ appelle
  `AffClients` dans les deux cas : pour `Colcli2`, ce sont les colonnes de `colcli` qui sont
  reconfigurées et le focus part sur `Colcli` masquée (EMAILING-A07).
- **`AffClients(tri2, sens2, col)`**, **`AffClients2`** [portée : réductible] [mixte] :
  `Utils.Base(col, "select * from Fiches_Cli order by <tri> <sens>")` (nom de table en dur, tri
  et sens issus de valeurs internes) puis focus sur la grille.
- **`ToggleButton1_Click`**, **`ToggleButton2_Click`** [GUI] : ouvrent/ferment `Colcli`/`Colcli2`
  triées par code.
- **`ColCli_Click`** [GUI, rejeu dynamique] : recopie le code dans `Client1` ; en mode liste,
  appelle `Cli_Man` (ajout à la liste).
- **`ColCli2_Click`** [GUI, rejeu dynamique] : recopie dans `Client2`, focus sur `Type`.
- **`ColCli_KeyPress`**, **`ColCli2_KeyPress`** [GUI] : F1 aide, Entrée = clic, Échap/F2 ferme.
- **`ToggleButton3_Click`**, **`ToggleButton4_Click`** [mixte] : remplissent `ColType`/`ColType2`
  par `SELECT * FROM Fiches_Typec order by code` (nom en dur via `Tab`). Deux copies.
- **`ColType_Click`**, **`ColType2_Click`** [GUI, rejeu dynamique] : recopient le code dans
  `Type`/`Type2`. **`ColType_KeyPress`**, **`ColType2_KeyPress`** [GUI] : Entrée, F1, Échap/F2.

### Saisie et navigation

- **`Cli_Man`** [portée : réductible] [mixte]. Vérifie l'existence de `Client1` dans
  `Fiches_Cli` (en dur). En mode liste, `INSERT INTO Cli_Mailing (code)` ; une clé dupliquée
  donne « Ce client a déjà été saisi ! ». Sinon avertissement « compte existant ».
- **`liste_Click`** [mixte]. Bascule le mode liste. Désactivé : `DROP TABLE IF EXISTS
  Cli_Mailing`. Activé : désactive type et CP, masque statut, puis `DROP` + `CREATE TABLE
  Cli_Mailing (code Char(15) NOT NULL, PRIMARY KEY (code))` + `Utils.db.Engine()`. Table de
  travail **hors `Cbase`**, hors `db_control.csv`, **partagée** avec `EmailingCarte` et par tous
  les postes connectés à la même base (EMAILING-A08). Bascule `Statut.Visible` : ici `Statut`
  est le **ComboBox** du formulaire (contrairement à `EmailingCarte`).
- **`ChkInput`** [portée : réductible] [GUI] : bloque les caractères non numériques. Appelé pour
  les tags 7 et 8 d'`Etiq_KeyPress`, qu'aucun contrôle ne porte : **jamais effectif**.
- **`Etiq_KeyPress`** [GUI] (CC 25) : navigation Entrée/Tab entre `Client1` (tag 1), `Client2`
  (2), `Type` (3), `Type2` (4), `Cp1` (5) ; F2 ouvre la grille correspondante ; F1 aide. Les
  branches `Case 8` (Entrée) et `Case 7/8` (`ChkInput`) sont inatteignables (aucun tag 7/8 ;
  `Cp2` porte le tag 6, non traité).
- **`sText_KeyPress`** [GUI] : compteur de caractères SMS par **frappes** (incrémenté pour toute
  touche hors Retour arrière, y compris flèches ; collage non compté) ; la limite de 160 n'est
  pas imposée.
- **`btnopen_Click`** [mixte] : `Dialog.OpenFile`, `FileN = File.Name(chemin)`,
  `TypeM = EnvMail.Extension(FileN)`, `TextBox2 = chemin complet`. Une extension non reconnue
  (« Out of bounds », ENVMAIL-A05) aboutit au `Catch` : « Impossible d'ouvrir le fichier ».
- **`bstatut_Click`** [GUI] : affiche/masque le combo `Statut`.
- **`Btn_Click`** [GUI] : groupe `Btn` (`Button2` tag 2, `Button3` tag 3) ; tag 1 → aide (aucun
  bouton du groupe ne porte le tag 1 : `Button1` n'est pas groupé). **`Btn_KeyPress`** [GUI] :
  **toute touche** sur `Button2` lance `Button2_Click` (EMAILING-A04).
- **`Button1_Click`** [GUI] : aide `Doc.Open("Sms")` ou `Doc.Open("Emailing")`.
- **`OBS_GotFocus`**, **`OBS_LostFocus`**, **`SetObservers`** [portée : réductible pour
  `SetObservers`] [GUI] : coloration du champ actif ; `SetObservers` attache récursivement un
  `Observer` `"OBS"` à chaque `TextBox` (paramètre `hClass` inutilisé). Copie dans 16 fichiers.

### Envoi

- **`Button2_Click`** [portée : réductible : appelé seulement par `Btn_Click`/`Btn_KeyPress`,
  `Button2` étant dans le groupe `btn`] [nature : mixte] (CC 37, maximum du fichier).
  1. Exige un sujet (`TextBox1`) puis un texte (`Stext`). ⚠️ En mode SMS, `TextBox1` est masqué
     et vide : le message « veuillez saisir le sujet » s'affiche toujours, **aucun SMS ne part**
     (EMAILING-A01).
  2. Hors mode liste : **14 variantes** de `SELECT * FROM Cbase.Table("TabCli") WHERE
     cast(cli_code AS char) BETWEEN &1 AND &2 [AND cli_typec BETWEEN &3 AND &4] [AND cli_statut
     = &n] ORDER BY …` selon `CheckType`, `bstatut`, `RadioButton1/2/3` et `CheckCp` (tri
     seulement). Si aucune combinaison ne correspond (bouton radio masqué resté sélectionné),
     `rCli` n'est pas affecté : erreur `Null` ou réutilisation de la sélection précédente
     (EMAILING-A06).
  3. Mode liste : `SELECT * FROM Cli_Mailing` puis, pour chaque code, relecture de la fiche
     (`Try`) et envoi ; pas de test `Available` sur `rcli2` (liste vide → erreur → `Catch`).
  4. Pour chaque client : `Adr_Mail = cli_email`, `piece = True` dès que `TextBox2` est rempli
     (**jamais remis à `False`**), affichage du client dans `Panel4`, `Wait 1` (hors mode
     liste), puis `EnvMail.Envoi(Adr_mail, sujet, texte, piece, TextBox2.Text, TypeM, FileN)`.
     ⚠️ `TextBox2.Text` est le **chemin complet** et `EnvMail.Envoi` charge `chemin & FileN` :
     le fichier est introuvable, l'erreur remonte au `Catch` et le mailing s'arrête au premier
     client (EMAILING-A02).
  5. « Traitement terminé » ; `Catch` : `Message.Error(Error.Text & Error.Where)`.
  Chaque échec SMTP affiche un `Message.Error` modal par destinataire (dans `EnvMail.Envoi`).
- **`EnvoiSms`** [portée : réductible] [mixte] — **code mort** (aucun appel, vérifié). Envoi par
  `gammu sendsms TEXT <$gsm> -text <mesg>` (support `1-`) ou `curl` Spot-Hit (premium ou
  lowcost, décrément local des crédits) ; `$gsm` et `mesg` ne sont **jamais affectés** dans le
  fichier ; `credit` n'est jamais relu. Voir [`Gsm.Button2_Click`](../../SMS/Gsm.class/architecture.md),
  qui contient la version utilisée de cette logique.

## État global utilisé

- `Start.LocalSettings` : `/Coul/Znaff`, `/Coul/Focus`, `/Coul/Znss`, `/Soc<XX>/Coul_fen`,
  `/Smtp`, `Port`, `/Adrmail`, `/Soc<XX>/Support`, `/Api`, `/Type`, `/Expediteur`.
- `Start.Son`, `Start.Musique`, `Start.Societe`.
- `Utils.db`, `Utils.rs1` (via `Utils.Base`), `Utils.FColr`, `Utils.Observers`.
- Tables : `Fiches_Cli` (`Cbase` dans `Button2_Click`, en dur ailleurs), `Fiches_Typec` (en dur),
  `Fiches_Statut` (`Cbase`), table de travail `Cli_Mailing`.

## Sécurité (relevé)

- Clé API Spot-Hit transmise en **HTTP clair** et visible dans la liste des processus (`curl`
  sur la ligne de commande) ; réponse stockée dans `~/tmp/sms.txt` (EMAILING-A09).
- `EnvoiSms` (mort) insère le texte du SMS non échappé dans une commande `Shell` : à ne pas
  réactiver sans correction (voir GSM-A02).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` : construire `WHERE` et `ORDER BY` à partir des critères (plage, type, statut,
  tri) en produisant **exactement** les mêmes chaînes SQL que les 14 variantes actuelles ;
  extraire la boucle d'envoi commune aux modes plage et liste.
- Fusionner `Tris`/`Tris2`, `AffClients`/`AffClients2`, `ToggleButton3/4_Click`,
  `ColType_KeyPress`/`ColType2_KeyPress` (paramètre grille cible) en conservant le comportement
  actuel de `colinit` (anomalie A07 figée).
- Remplacer les noms de table en dur `Fiches_Cli`, `Fiches_Typec` par `Cbase.Table("TabCli")`,
  `Cbase.Table("TabTypec")` (SQL émis identique).
- Supprimer les blocs `With Utils … End With` sans usage.

### Commonalisation avec d'autres fichiers

- [`EmailingCarte`](../EmailingCarte.class/architecture.md) et
  [`Eticli`](../../Etiquettes/Eticli.class/architecture.md) : mêmes fonctions (`Tris`, `Tris2`,
  `colinit`, `AffClients*`, `Cli_Man`, `ColCli*`, `liste_Click`, `ChkInput`, `Etiq_KeyPress`,
  `SetObservers`, `OBS_*`). Proposition : une classe de sélection de destinataires (plage,
  liste, type, statut, CP) paramétrée par la table (`TabCli`/`TabCarte`) et le préfixe des
  colonnes (`cli_`/aucun), utilisée par les trois écrans.
- `SetObservers` / `OBS_GotFocus` / `OBS_LostFocus` : 16 copies dans le projet (dont
  [`Statut`](../../Tables/Statut.class/architecture.md), [`Typec`](../../Tables/Typec.class/architecture.md)) ;
  candidat à un helper `Utils` (voir les propositions de Typec).
- Contrôle de crédit Spot-Hit : même code dans [`Gsm`](../../SMS/Gsm.class/architecture.md)
  (`TextLabel1_GotFocus`), [`Psms`](../../SMS/Psms.class/architecture.md) (`api_LostFocus`) et
  [`Prefs`](../../../Communs/Prefs.class/architecture.md) (l. 1328) → module SMS commun (GSM-005).

### Réduction de portée

- `Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`,
  `SetObservers` → `Private` (aucun appelant externe ; `Button2_Click` n'est pas un handler levé
  car `Button2` appartient au groupe `btn`). `EnvoiSms` : code mort.
- Les handlers (`ColCli_Click`, `ColCli2_Click`, `ColType_Click`, `ColType2_Click` appelés par le
  rejeu via `Object.Call`, `bstatut_Click`, `Label7_GotFocus`…) restent `Public`.

### Séparation traitement / GUI

- `SelectionClients(critères) As Result` : construction et exécution du `SELECT` sans accès aux
  contrôles ; `Button2_Click` lit les contrôles, appelle la fonction et pilote l'affichage.
- `AjouteListe(code) As Boolean` (insertion dans `Cli_Mailing`) et `CreeListe()` / `SupprimeListe()`
  extraits de `Cli_Man` et `liste_Click`.
- `CreditsSms(api) As String[]` (appel `curl` et découpage de la réponse) extrait de
  `Label7_GotFocus`, mutualisable avec `Gsm`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer la table de travail `Cli_Mailing` (partagée entre postes et entre écrans) par une
  table temporaire de session (`CREATE TEMPORARY TABLE`) ou une liste en mémoire.
- Exploiter `Mails_Cli` (adresses multiples par client) pour les mailings, avec un indicateur
  de consentement (RGPD) qui n'existe pas aujourd'hui dans `Fiches_Cli`.
- `cast(cli_code AS char)` empêche l'usage de l'index sur `cli_code` ; un type `CHAR` homogène
  rendrait la conversion inutile.
