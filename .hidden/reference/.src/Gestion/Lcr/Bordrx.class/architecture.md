# Bordrx — Architecture

> Source : `.src/Gestion/Lcr/Bordrx.class`

## Vue d'ensemble

Écran **« Gestion des bordereaux »** (menu Gestion › LCR, `Fmenu.MenuGbrd_Click`), dernière étape de
la chaîne LCR (voir [`Lcr`](../Lcr.class/architecture.md)). Il liste les bordereaux de
`Fiches_Bordereaux` créés par [`Preparation`](../Preparation.class/architecture.md) — non envoyés
(`etat = 0`, radio `N`, défaut) ou envoyés (`etat = 1`, radio `A`) — et, pour le bordereau choisi
dans `ColBrd`, affiche ses LCR (`ColLcr`, `Fiches_Lcr.bordereau = n°`). Actions :

- **Imprimer** le bordereau (PDF `<Fichiers>/Lcr<société><n°>.pdf`, [`CLcr`](../CLcr.class/architecture.md)
  `Level1B`…`Level4B`) ;
- **Envoyer** (`Button3`) : générer le **fichier bancaire** `<Fichiers>/LCR<société><code banque>`
  au format « LCR magnétique » CFONB 160 caractères (enregistrements `0360` en-tête remise, `0660`
  ligne LCR, `1660` adresse du tiré facultative, `0860` total), passer le bordereau à `etat = 1`,
  puis envoyer le PDF et le fichier par mail à la banque (`EnvMail.Envoi2`) ;
- **Réinjecter** un bordereau non envoyé (LCR remises à `bordereau = 0`, bordereau supprimé) ;
- **Supprimer** un bordereau envoyé et ses LCR.

`<Fichiers>` = `Start.LocalSettings["/Soc<XX>/Fichiers"]`. L'écran appelle `Utils.Observers(Me)`.
Aucune écriture comptable : la comptabilisation de la remise n'est pas faite ici (contrairement à
[`BordereauxC`](../../../Compta/Impressions/BordereauxC.class/architecture.md) pour les chèques).

Nature : écran **mixte** ; la génération du fichier bancaire (`Button3_Click`, CC 21) est le cœur
métier du lot.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 28 |
| `tab` | var | Private |  | String | 29 |
| `rs1` | var | Private |  | Result | 30 |
| `sel` | var | Private |  | String | 31 |
| `txt` | var | Private |  | String | 32 |
| `Brdtable` | var | Private |  | New String[10] | 33 |
| `B` | var | Private |  | Integer | 34 |
| `rResult` | var | Private |  | Result | 35 |
| `son` | var | Private |  | Integer | 36 |
| `sKey` | var | Private |  | String | 37 |
| `Dbl` | var | Private |  | String | 38 |
| `CoulB` | var | Private |  | Integer | 39 |
| `CoulF` | var | Private |  | Integer | 40 |
| `Fnt` | var | Private |  | String | 41 |
| `CoulZns` | var | Private |  | Integer | 42 |
| `CoulZnaf` | var | Private |  | Integer | 43 |
| `Coulfc` | var | Private |  | Integer | 44 |
| `Coulfond` | var | Private |  | New String[] | 45 |
| `nv` | var | Private |  | Boolean | 46 |
| `Dte1` | var | Private |  | Integer | 47 |
| `Type` | var | Private |  | String | 48 |
| `Bsel` | var | Public |  | Boolean | 49 |
| `sCmpt` | var | Public |  | String | 50 |
| `sdesg` | var | Public |  | String | 51 |
| `PosX` | var | Private |  | Integer | 52 |
| `PosY` | var | Private |  | Integer | 53 |
| `rBq` | var | Private |  | Result | 54 |
| `Nb` | var | Public |  | Integer | 55 |
| `sDate` | var | Public |  | Boolean | 56 |
| `iLind` | var | Public |  | Integer | 57 |
| `ControleCombobox` | var | Public |  | Boolean | 58 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 60-77 | Public | 2 | 15 | 0 | méthode spéciale |
| `Form_Open` | 79-102 | Public | 1 | 22 | 0 | handler GUI |
| `Tris` | 104-118 | Public | 1 | 13 | 0 | portée réductible ? |
| `Entete` | 120-132 | Public | 1 | 11 | 0 | portée réductible ? |
| `ColBrd_Data` | 134-160 | Public | 17 | 24 | 0 | handler GUI |
| `Deb` | 162-166 | Public | 1 | 3 | 0 | portée réductible ? |
| `Deb2` | 168-172 | Public | 1 | 3 | 0 | portée réductible ? |
| `ColBrd_Click` | 177-203 | Public | 5 | 24 | 0 | handler GUI |
| `Button10_Click` | 208-240 | Public | 9 | 30 | 0 | handler GUI |
| `Button2_Click` | 245-271 | Public | 7 | 24 | 0 | handler GUI |
| `Button4_Click` | 273-277 | Public | 1 | 3 | 0 | handler GUI |
| `Button9_Click` | 279-283 | Public | 1 | 3 | 0 | handler GUI |
| `Gen_Bordereau` | 285-387 | Public | 7 | 98 | 0 | portée réductible ? |
| `Button3_Click` | 390-539 | Public | 21 | 143 | 0 | handler GUI |
| `A_Click` | 541-547 | Public | 1 | 5 | 0 | handler GUI |
| `N_Click` | 549-555 | Public | 1 | 5 | 0 | handler GUI |
| `Button1_Click` | 560-564 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et listes

- **`_New()`** [portée : nécessaire (spéciale)] : couleurs, `Utils.Observers(Me)`, fond, musique,
  `Entete()`.
- **`Form_Open()`** [événement] : 6 colonnes de `ColLcr`, `Tri = "bordereau"`, `Tris()`, `Deb()`.
- **`Tris()`**, **`Entete()`** [portée : réductible] [GUI] : 8 colonnes de `ColBrd` et titres.
- **`ColBrd_Data(Row, Column)`** [événement] [nature : mixte] (CC 17) : lit `Utils.rs1` ; colonne
  banque : une requête `Fiches_Banques` par cellule pour ajouter le nom ; dates : `Str(date)`, `/` →
  `.`, 10 caractères. `Str` d'une date dépend de la locale (`25/10/2026` en `fr_FR`, `10/25/2026` en
  `C`, vérifié) : les dates du fichier bancaire, extraites de ce texte, en dépendent.
- **`Deb()`** / **`Deb2()`** [portée : réductible] : `Utils.base(ColBrd, "SELECT * FROM
  Fiches_Bordereaux where etat = 0|1 order by bordereau")`.
- **`N_Click()`**, **`A_Click()`** [événements] : vident les deux grilles, `Deb`/`Deb2`.
- **`ColBrd_Click()`** [événement, `replay_dynamic` : doit rester `Public`] [nature : mixte] : remplit
  `ColLcr` avec les LCR du bordereau (`code`, `nom`, dates `LDate.L`, n° facture, montant brut) et
  écrit `Item[6] = acceptee` alors que la vue n'a que 6 colonnes (0 à 5) ; ce texte est relu comme
  **code d'acceptation** du fichier bancaire (comportement de `ColumnView` hors bornes à confirmer).

### Réinjection et suppression

- **`Button10_Click()`** [événement] [nature : mixte] : si `N` : confirmation, puis, **pour chaque
  LCR du bordereau**, le même `UPdate Fiches_Lcr SET bordereau = "0" where bordereau = <n°>` (répété
  N fois), `DELETE FROM Fiches_Bordereaux WHERE bordereau = <n°>`, `Form_Open`. Sinon message
  « bordereau envoyé ». Les LCR gardent leur `codeentree`.
- **`Button2_Click()`** [événement] [nature : mixte] : si `A` (envoyés) : confirmation, `DELETE` des
  LCR puis du bordereau. Sinon message.

### Impression du bordereau

- **`Button9_Click()`** → **`Gen_Bordereau(1)`**.
- **`Gen_Bordereau(Org As String)`** [portée : réductible] [nature : mixte] : rien si aucun
  bordereau sélectionné ; `filename2` calculé sous `Try` puis `Print Error, Error.Text` (trace de
  débogage sur la sortie standard), `filename2` inutilisé ; `Shell "cd …"` inutile ; PDF
  `<Fichiers>/Lcr<société><n°>.pdf` : en-tête banque (`Level1B`) avec des arguments **décalés**
  (la ligne « Emetteur : » reçoit raison sociale + domiciliation, la ligne de domiciliation reçoit
  « Emetteur <n°> », « Code entrée : » sans valeur), tableau (`Level2B`), une ligne `Level3B` par LCR
  (adresse = raison sociale, nom, prénom, CP, ville ; `rCli` lu **sans** test `Available`), total
  `Level4B` (date de remise = date du jour, CLCR-A02). Puis `Org = "1"` → `Visualiseur.Prog` ;
  sinon (`Org = 2`, depuis l'envoi) **l. 383 `Impression.Prog_Editeur(… Start.Soc …)`** : ni
  `Impression.Prog_Editeur` ni `Start.Soc` n'existent (`Impression.module` n'a pas cette méthode ;
  l'éditeur est `Editeur.Prog_Editeur`, la société `Start.Societe`) → **erreur à l'exécution**,
  non interceptée (IMPRESSION-A03).

### Génération du fichier bancaire et envoi

- **`Button3_Click()`** [événement] [nature : mixte] (CC 21, max) : si `ColLcr` n'est pas vide :
  - dates de remise et de valeur `jjmmaa` découpées dans le texte de `ColBrd` ;
  - lecture de la banque (`Fiches_Banques` par code) : émetteur sur 6, raison sociale et
    domiciliation sur 24 (troncature sous `Try`), code guichet et code banque sur 5, SIREN
    **complété à 5**, référence tireur sur 10 (écrasée plus loin), n° de compte sur 11, mail, fin
    d'enregistrement ; adresses imprimées si `banques_adr = "O"`, ou `"C"` avec code entrée > 4 ;
  - ouverture de `<Fichiers>/LCR<société><code banque>` en écriture (écrase le fichier précédent de
    la même banque) ; fin d'enregistrement : `Ws` → fins de ligne Windows, autre valeur non vide →
    `" " & valeur` ajouté **en texte** à chaque enregistrement (la valeur proposée par `Banque.form`
    est `$0D0A$`, écrite littéralement) ;
  - enregistrement `0360` + n° séquentiel 8 chiffres + émetteur + date de remise + raison sociale +
    domiciliation + code entrée + `E` + code banque + guichet + compte + date de valeur + SIREN +
    référence de remise ;
  - pour chaque LCR : client (`Cbase.Table("TabCli")`, sans test `Available`) : référence tireur sur
    10, nom et domiciliation sur 24 en majuscules sans accents (`Utils.Replace`), code
    d'acceptation (`Item[6]`, `0` par défaut), RIB du tiré, montant en centimes sur 12
    (`Format$(Val(montant) * 100, …)` **sans** `Utils.cpoint`), échéance et date de création `jjmmaa`,
    n° de facture comme référence (sur 10, sans troncature) → enregistrement `0660` ; si adresses,
    enregistrement `1660` (adresse 1, adresse 2, CP + ville sur 32) ;
  - enregistrement `0860` avec le total ; fermeture ;
  - `UPdate Fiches_Bordereaux SET etat = True` **avant** la vérification du mail ;
  - si la banque a un mail : `Gen_Bordereau(2)` (qui échoue l. 383), puis `EnvMail.Envoi2(mail,
    sujet, corps, "<Fichiers>/Lcr<société>.pdf", fichier bancaire)` — la pièce PDF ne porte pas le
    n° de bordereau et ne correspond pas au fichier produit ; sinon message d'erreur.
  - Les complétions `String$(n - Len(x), " ")` lèvent « Bad argument » si `x` dépasse `n`
    (vérifié : `String$(-2, " ")` → erreur) : SIREN de 9 chiffres, adresses de 33 à 35 caractères,
    CP + ville > 32. Aucun `Catch` : erreur non interceptée, fichier partiel.
  - Variables locales inutilisées : `rBrd`, `TxtMail` ; `Numero` (n° séquentiel) commence à 1.
- **`Button1_Click()`** (`Doc.Open("LCR")`), **`Button4_Click()`** (fermeture).

## État global utilisé

- `Start.LocalSettings` (`/Coul/*`, `/Soc<XX>/Coul_fen`, `/Soc<XX>/Fichiers`), `Start.Societe`,
  `Start.Soc` (inexistant), `Start.Musique`.
- `Utils.base`/`Utils.rs1`, `Utils.db`, `Utils.cpoint`, `Utils.Replace`, `Utils.Coulfd`,
  `Utils.FColr`, `Utils.Observers`, `Cbase.Table("TabCli")`, `LDate`, `CLcr`, `Visualiseur.Prog`,
  `Impression.Prog_Editeur` (inexistant), `EnvMail.Envoi2`, `Doc.Open`.
- Tables : `Fiches_Bordereaux`, `Fiches_Lcr`, `Fiches_Banques` (en dur), `Fiches_Cli`.
- Fichiers : PDF et fichier bancaire sous `/Soc<XX>/Fichiers`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire la génération du fichier bancaire dans une fonction pure
  `FichierLcr(bordereau, banque, lignes) As String[]` (enregistrements de 160 caractères), testable
  en `gbtest` octet par octet, et un helper `Cadre(x, n)` (compléter / tronquer) remplaçant les
  `String$(n - Len(x))` — à comportement constant, le helper doit reproduire l'erreur actuelle
  quand `x` dépasse `n`, d'où une correction séparée (BORDRX-A04).
- `Button10_Click` : un seul `UPdate` au lieu d'une répétition par LCR (SQL modifié, dump identique).
- Supprimer le `Print Error, Error.Text`, `filename2`, `Shell "cd …"`.

### Commonalisation avec d'autres fichiers

- Lecture des coordonnées de la banque : même requête dans `Gen_Bordereau` et `Button3_Click` →
  fonction privée commune (et avec `Preparation.Button10_Click` pour `banques_ref`).
- Comparaison avec [`BordereauxC`](../../../Compta/Impressions/BordereauxC.class/architecture.md)
  (bordereaux de remise de chèques) : même cycle « liste des remises → impression d'un bordereau →
  marquage remis », mais tables, PDF (`Cbordereaux` vs `CLcr`), sortie (écritures comptables vs
  fichier CFONB + mail) différents. Commonalisation réaliste limitée à l'en-tête banque/société du
  PDF ; une commonalisation plus large n'est pas recommandée (logiques métier distinctes).
- Envoi d'un bordereau par mail : `EnvMail.Envoi2` est aussi utilisé par d'autres écrans d'envoi
  (lot Mails).

### Réduction de portée

- `Tris`, `Entete`, `Deb`, `Deb2`, `Gen_Bordereau` → `Private` ; `sCmpt`, `sdesg`, `Nb`, `sDate`,
  `iLind`, `ControleCombobox`, `Bsel` : membres `Public` jamais utilisés → suppression (vérifié par
  `grep -rn "Bordrx\." .src` : seul `Bordrx.Show`).
- `ColBrd_Click` et les handlers restent `Public`.

### Séparation traitement / GUI

- `Button3_Click` : séparer (1) lecture des données, (2) construction des enregistrements (pur),
  (3) écriture du fichier, (4) mise à jour de l'état, (5) mail.
- `Gen_Bordereau` : séparer la sélection des données du rendu PDF.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker dans `Fiches_Bordereaux` le nom du fichier bancaire et la date d'envoi ; le nom de
  fichier par banque est aujourd'hui écrasé à chaque envoi.
- Contraindre les longueurs des champs bancaires (`banques_numsiren` 9, adresses 32) au format
  CFONB.
