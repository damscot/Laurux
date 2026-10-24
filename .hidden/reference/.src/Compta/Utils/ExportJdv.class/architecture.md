# ExportJdv — Architecture

> Source : `.src/Compta/Utils/ExportJdv.class` · Form : `ExportJdv.form`

## Vue d'ensemble

Fenêtre « Export du Jdv » (menu Comptabilité > Outils > Export des journaux, `Fmenu.Menu133_Click`,
visible si `/Exp`). Elle exporte les écritures **validées** d'un journal (`Fiches_Mvt`) sur une
période, ainsi que le fichier des clients, dans le répertoire `/Soc<XX>/Chemin-export`, sous l'un
des six formats de la liste `Tpj` :

| Code | Format | Fichier écritures | Contenu d'une ligne (hors lignes collectif) |
|---|---|---|---|
| 1 | Fichier texte | `ecritures<JJ>.csv` | `compte;intitulé;date;pièce;libellé;débit;crédit;solde;` |
| 2 | Quadra | `ecritures<JJ>.csv` | `date;compte;pièce intitulé;libellé;montant;montant` (largeurs fixes) |
| 3 | Ciel | `ecritures<JJ>.txt` | `compte;intitulé;date;pièce;libellé;débit;crédit;sens` (windows-1252) |
| 4 | CCMX Winner | `ecritures<JJ>.txt` | `n°;date;pièce;libellé;journal;compte;"pièce[5..10]";débit;crédit` — ⚠️ appel de `Donnees4` avec 9 arguments pour 8 paramètres (EXPORTJDV-A11) |
| 5 | Cador | `ecritures<JJ>.txt` | enregistrements à positions fixes `1` / `2…` / `3` par écriture |
| 6 | Sage | `ecritures<JJ>.pnm` | positions fixes (journal, date, `FC`, collectif, tiers, pièce, libellé, échéance, sens, montant) |

Le fichier des clients (`clients.txt`, ou `clients.pnc` à positions fixes pour Sage) contient tous
les clients ; avec `/Soc<XX>/Sage`, le code exporté est `cli_sage` s'il est renseigné. Les deux
fichiers commencent par l'intitulé de la société. Le format 1 est relu par
[`ImpJdv`](../ImpJdv.class/architecture.md) ; le format 6 est l'inverse d'[`ImpSage`](../ImpSage.class/architecture.md).

Effets de bord : `Fiches_Mvt.export = '1'` sur chaque écriture exportée ; table de travail
`centralisations` recréée et alimentée (jamais relue) ; réglages `/Soc<XX>/Dte_exprt`,
`Dte2_exprt`, `Numdoc_exprt` (et `Adr-export`, `Chemin-export` à la fermeture) ; copie
`JDV<JJMMAAAA>.<ext>` ; `chmod 666` ; envoi par courriel optionnel (`EnvMail`).

Nature globale : **mixte** ; l'essentiel tient dans `Button2_Click` (427 lignes, CC 103).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Debhp` | var | Private |  | Float | 27 |
| `Credhp` | var | Private |  | Float | 28 |
| `totsldhp` | var | Private |  | Float | 29 |
| `TotDeb` | var | Private |  | Float | 30 |
| `TotCred` | var | Private |  | Float | 31 |
| `TotSld` | var | Private |  | Float | 32 |
| `debit` | var | Private |  | Float | 33 |
| `credit` | var | Private |  | Float | 34 |
| `solde` | var | Private |  | Float | 35 |
| `dte` | var | Private |  | String | 36 |
| `dte1` | var | Private |  | String | 37 |
| `dte2` | var | Private |  | String | 38 |
| `dte4` | var | Private |  | String | 39 |
| `Txt` | var | Private |  | String | 40 |
| `Filetxt` | var | Private |  | String | 41 |
| `Filetxt2` | var | Private |  | String | 42 |
| `jour` | var | Private |  | String | 43 |
| `hfile` | var | Private |  | File | 44 |
| `hfile2` | var | Private |  | File | 45 |
| `rResult` | var | Private |  | Result | 46 |
| `rrrResult` | var | Private |  | Result | 47 |
| `CliResult` | var | Private |  | Result | 48 |
| `type_jour` | var | Private |  | String | 49 |
| `Tab` | var | Private |  | String | 50 |
| `Tab0` | var | Private |  | String | 51 |
| `Db_ction` | var | Private |  | Float | 52 |
| `Cd_ction` | var | Private |  | Float | 53 |
| `Compt` | var | Private |  | String | 54 |
| `son` | var | Private |  | Integer | 55 |
| `Extension` | var | Private |  | String | 56 |
| `ChangeDte` | var | Private |  | String | 57 |
| `ChangeDate` | var | Private |  | String | 58 |
| `Changedate2` | var | Private |  | String | 59 |
| `Intitule_Soc` | var | Private |  | String | 60 |
| `bsage` | var | Private |  | Boolean | 61 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 63-112 | Public | 11 | 35 | 0 | méthode spéciale |
| `Ex1` | 114-147 | Public | 2 | 22 | 0 | portée réductible ? |
| `finmois` | 152-163 | Public | 2 | 9 | 0 | portée réductible ? |
| `Exo` | 165-183 | Public | 1 | 17 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 185-213 | Public | 4 | 27 | 0 | handler GUI |
| `Cmpt_KeyPress` | 215-252 | Public | 12 | 31 | 0 | handler GUI |
| `Btn_Click` | 254-270 | Public | 4 | 12 | 0 | handler GUI |
| `cpt_GotFocus` | 272-276 | Public | 1 | 3 | 0 | portée réductible ? |
| `cpt_LostFocus` | 278-282 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN0_GotFocus` | 284-290 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 292-317 | Public | 9 | 23 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 319-323 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 325-357 | Public | 12 | 31 | 0 | portée réductible ? |
| `Compdate` | 359-371 | Public | 3 | 11 | 0 | portée réductible ? |
| `compdate2` | 373-385 | Public | 3 | 11 | 0 | portée réductible ? |
| `coljour_Click` | 387-393 | Public | 1 | 5 | 0 | handler GUI |
| `coljour_KeyPress` | 398-416 | Public | 6 | 15 | 0 | handler GUI |
| `E0_Click` | 418-423 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 425-430 | Public | 1 | 4 | 0 | handler GUI |
| `donnees1` | 436-440 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 442-446 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees3` | 448-452 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees4` | 454-458 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees5` | 460-464 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees6` | 466-470 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees7` | 472-476 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees8` | 478-482 | Public | 1 | 3 | 0 | portée réductible ? |
| `Raz` | 484-497 | Public | 1 | 12 | 0 | portée réductible ? |
| `Button2_Click` | 502-934 | Public | 103 | 427 | 0 | portée réductible ? |
| `Controle` | 936-971 | Public | 9 | 33 | 0 | portée réductible ? |
| `Svs2_Click` | 973-983 | Public | 2 | 9 | 0 | handler GUI |
| `export` | 985-1012 | Public | 5 | 25 | 0 | portée réductible ? |
| `Button3_Click` | 1014-1018 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et période

- **`_New()`** [constructeur] [nature : mixte]. `SELECT * FROM Fiches_Parametres` → journal par
  défaut (`jrnal`) ; `SELECT * FROM Fiches_Societes` **sans `WHERE cd_sc`** ni test `Available`
  → intitulé (type + raison sociale, 30 car.) de la **première** société ; chemins et adresse
  d'export, case `Envoi` (`/Soc<XX>/Expmail`) ; texte rappelant le dernier export ; `E0_Click()`
  (période de l'exercice en cours). `Changedte`, `Changedate`, `Changedate2` sont affectés et
  jamais relus.
- **`Ex1()`** [portée : réductible] [nature : mixte]. Période de l'exercice en cours : début =
  `Utils.Calc_mois(dteclec)`, fin = aujourd'hui, ou `Exo()` si aujourd'hui précède le début.
- **`Exo()`** [portée : réductible] [nature : mixte]. Période de l'exercice précédent
  (`dteclec1` → `dteclec`). Mémorise les bornes dans `dte1`/`dte2`.
- **`finmois(Jrs)`** [portée : réductible] [nature : calcul]. Dernier jour du mois : **code mort**
  (seul appel dans un bloc commenté).
- **`E0_Click()` / `E1_Click()`** [handlers] : `Tab0 = "Fiches_Mvt"` puis `Ex1` / `Exo`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls membres.

### Saisie (GUI)

- **`Cmpt_KeyPress()`** [handler du groupe `Cmpt` : `DteN0` tag 1, `Dten1` tag 2, `Cpt` tag 3]
  (CC 12). Entrée/Tab : valide la date et passe au champ suivant ; F1 : aide ; F2 sur `Cpt` :
  liste des journaux.
- **`cpt_GotFocus()`, `dteN0_GotFocus()`, `dteN1_GotFocus()`** [handlers nominaux appelés
  explicitement] : fond vert.
- **`cpt_LostFocus()`** [handler nominal **inactif**] : `Cpt` est dans le groupe `Cmpt`, l'événement
  est donc levé sous le nom `Cmpt_LostFocus` (non défini) ; aucun appel explicite (`deps.py`,
  vérifié par `grep`) : code mort.
- **`dteN0_LostFocus()` / `dteN1_LostFocus()`** [handlers nominaux appelés depuis
  `Cmpt_KeyPress`] (CC 9 / 12). Complètent une date partielle (`JJ` ou `JJ.MM` avec l'année
  courante), `Utils.Cdate_calc`/`Cdate_aff`, puis contrôle des bornes de la période (la fin admet
  un an de plus : `Right$(dte2, 4) + 1`) et de l'ordre des dates → `Compdate`/`compdate2`/`Exo`.
  Les deux fonctions sont quasi identiques. Un clic souris hors du champ ne déclenche aucun contrôle.
- **`Compdate()` / `compdate2()`** [portée : réductible] [nature : GUI]. Message `Txt`, retour à
  l'exercice précédent (`Exo`, `E0.Value = True`) et focus. Identiques au champ près.
- **`ToggleButton3_Click()`, `coljour_Click()`, `coljour_KeyPress()`** [handlers] [nature :
  mixte]. Liste de **tous** les journaux (`SELECT * FROM Fiches_Journaux ORDER BY code_jo`) dans
  `Coljour`.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 1 aide, tag 2 `Button2_Click`, tag 4 sauvegarde
  `Adr-export` / `Chemin-export` et fermeture.
- **`Svs2_Click()`** [handler] : choix du répertoire ; annulation → `User.Home`.
- **`Button3_Click()`** [handler nominal appelé par `Btn_Click`/F1] : `Doc.Open("Export")`.

### Export (`Button2_Click`, CC 103)

[nature : mixte ; partie extractible : sélection SQL, formatage des lignes, cumuls, `UPDATE export`]

1. Choix de l'extension (`csv` pour 1-2, `txt` sinon, `.pnm` pour 6), suppression puis création de
   `ecritures<JJ>.<ext>` (erreur → message « chemin »).
2. Format 6 : `Controle()` (codes Sage manquants). Si `bsage` :
   - `DROP TABLE IF EXISTS centralisations` + `CREATE TABLE IF NOT EXISTS centralisations (...)`
     (table de travail hors `LauruxMaj`) ;
   - lignes 580-583 : `dte` affecté trois fois de suite (seule la dernière valeur, construite sur le
     membre `jour`, compte ; elle est ensuite écrasée dans la boucle) ;
   - **clients** : `SELECT * FROM Fiches_Cli ORDER BY cli_code` → `clients.txt` (31 champs `;`) ou
     `clients.pnc` (positions fixes), précédés de l'intitulé société (aussi écrit en tête du
     fichier des écritures) ;
   - **écritures** : `SELECT * FROM Fiches_Journaux WHERE code_jo = &1`, puis
     `SELECT * FROM Fiches_Mvt WHERE jour = &1 AND validee = &2 AND dte >= &3 AND dte <= &4 AND
     jour = &5 AND export <> &6 OR (… AND export IS NULL) ORDER BY dte, numero, compte` (non
     exportées, `RadioButton1`) ou la même sans filtre `export` (avec une clause `OR` redondante).
3. Boucle sur les lignes :
   - ligne **collectif** (`collectif` vrai) : non écrite dans le fichier, cumulée dans
     `centralisations` ; ligne normale : intitulé et type (`G`/`X`) du compte lus dans
     `Fiches_Comptes` (sans test `Available`) ;
   - cumuls `debit`/`credit`/`solde`/`totdeb`/`totcred` ; `solde` remis à 0 sur une ligne collectif
     (le bloc l.688-692 est mort : `p1` vaut toujours 0) ; `soldej` calculé et jamais lu ;
     `If InStr(Str(solde), "E")` neutralise la notation exponentielle ;
   - **ajustement d'arrondi** : si `|solde| < 0,03`, l'écart est reporté sur le débit ou le crédit
     exporté (les montants écrits peuvent différer de la base de quelques centimes) ;
   - date au format du logiciel cible (`Utils.Cdate_Ciel`, `Cdate_Cador`, `Cdate_Sage`,
     `Cdate_Aff`) ; écriture de la ligne via `donnees1`…`donnees6` ou `Print` direct (Sage) ;
     format 5 : enregistrements `1`/`3` à chaque changement de numéro ; format 4 : compteur
     `NbEcritures` décrémenté à chaque ligne écrite ; format 6 : code tiers Sage
     (`SELECT cli_collectif, cli_sage, cli_code FROM Fiches_Cli WHERE cli_code = &1`) ;
   - comptes hors 40/41 (journal non `OD`) et collectifs : cumul dans `centralisations` par
     `UPDATE`/`INSERT` **construits par concaténation** (l'`UPDATE` de la ligne normale n'ajoute pas
     le crédit) ;
   - `UPDATE Fiches_Mvt SET export = '1' WHERE numero = &1` **à chaque ligne**.
4. Fin : enregistrement `3` (Cador) ; si `NbEcritures <> 0` : contrôle d'équilibre
   **inopérant** (`totsld = totdeb - totdeb` vaut toujours 0), fermeture, `chmod 666` des deux
   fichiers, proposition d'ouvrir le fichier, envoi (`export()`), fermeture de la fenêtre ; sinon
   message « Aucune écriture » (fichier laissé ouvert).
5. Dans tous les cas où `bsage` est vrai (même journal inexistant ou code vide) : réglages
   `Dte_exprt`, `Dte2_exprt`, `Numdoc_exprt` (dernier `numdoc` lu, ou valeur précédente) et
   `Shell "cp ecritures<JJ>.<ext> JDV<JJMMAAAA>.<ext>"` (chemins non protégés ; pour Sage
   l'extension utilisée est `txt` alors que le fichier est `.pnm`).
6. `Catch` global : `Message.Error(Error.Text & Error.Where)`.

### Autres

- **`Controle()`** [portée : réductible] [nature : mixte]. Format Sage : pour chaque ligne de la
  période (`Cbase.Table("TabMvt")`), cherche le client ; s'il n'a pas de `cli_sage`, `bsage = False`
  et la ligne `code nom prénom` est écrite **dans le fichier des écritures** (`donnees8`), ouvert
  ensuite dans l'éditeur alors qu'il n'est ni fermé ni vidé ; message du nombre de clients.
- **`donnees1`…`donnees8`** [portée : réductible] [nature : traitement]. Écrivent une ligne dans
  `hFile` (champs joints par `;` pour 1-4, concaténation pour 6 et 8, valeur brute pour 5 et 7).
  `donnees7` est **code mort**.
- **`export()`** [portée : réductible] [nature : mixte]. Envoi par `EnvMail.Envoi3` (format 2 : deux
  pièces jointes) ou `Envoi2` (ecritures seulement) ; chemins relus dans `/Soc<XX>/Chemin-export`
  (pas `Chmexport.Text`), fichier clients toujours `clients.txt`. `Catch` → message d'échec.
  **Correction après le lot Gestion-2** : l'appel `Envoi3` (l. 1000) passe 5 arguments pour 4 et lève
  « Too many arguments » (vérifié sur un projet minimal), capté par ce `Catch` : le format 2 n'est
  jamais envoyé par courriel (ENVMAIL-A01, EXPORTJDV-A12).

## État global utilisé

- `Start.LocalSettings` : `/Soc<XX>/Chemin-export`, `Adr-export`, `Expmail`, `Dte_exprt`,
  `Dte2_exprt`, `Numdoc_exprt`, `Sage` ; `Start.Societe`, `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Calc_mois`, `Cdate_*`, `Accent`, `CSlash`, `Observers` ; `Cbase.Table`
  (`TabSoc`, `TabCli`, `TabJour`, `TabMvt`) mais noms en dur ailleurs (`Fiches_Parametres`,
  `Fiches_Journaux`, `Fiches_Comptes`, `Fiches_Mvt`).
- `Editeur.Prog_Editeur`, `EnvMail.Envoi2/Envoi3`, `Doc.Open`, commandes `chmod` et `cp`.
- Tables : `Fiches_Mvt` (lecture + `export`), `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Journaux`,
  `Fiches_Parametres`, `Fiches_Societes`, `centralisations` (travail).

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Button2_Click` : `OuvreFichiers`, `ExporteClients(sFichier, iFormat)`,
  `SelectionEcritures(sJournal, dDeb, dFin, bNonExportees) As Result`, une fonction **pure** par
  format `LigneFormat<n>(...) As String` (testable en gb.test), `AjusteArrondi`, `MarqueExportee`.
  Remplacer l'échelle de `If Left$(Tpj.Text, 1) = …` imbriqués (6 niveaux) par un `Select Case`
  sur le code format calculé une fois.
- `dteN0_LostFocus`/`dteN1_LostFocus` → helper privé `NormaliseDate(sTexte) As String` ;
  `Compdate`/`compdate2` → une fonction paramétrée par le champ.
- Sélection du code client exporté (l.598-606 et l.789-797, identiques) → `CodeClientExport(r)`.
- SQL : supprimer les clauses `OR` redondantes et le double test `jour` (résultat identique) ;
  `UPDATE export` une fois par numéro d'écriture (dump identique).
- Noms de tables via `Cbase.Table` partout.

### Commonalisation avec d'autres fichiers

- Liste des journaux (`ToggleButton3_Click`, `coljour_Click`, `coljour_KeyPress`) : même code
  dans [`ImpJdv`](../ImpJdv.class/architecture.md) (journaux `VE`) et
  [`Intjdv`](../Intjdv.class/architecture.md) → `RemplitJournaux(hVue, Optional sType)`.
- `Svs2_Click` : socle `ImpExp` proposé dans
  [`Impclient`](../../../Utils/Exports-Imports/Impclient.class/architecture.md)
  (`ChoisirRepertoire(sDefautAnnulation)` : ici l'annulation renvoie `User.Home`).
- Format 1 ↔ `ImpJdv`, format 6 ↔ `ImpSage` : constantes de format partagées (ordre des 31 champs
  client, positions Sage).
- Envoi par courriel : `EnvMail.Envoi2/Envoi3` comme
  [`Expbase`](../../../Utils/Exports-Imports/Expbase.class/architecture.md), dont l'en-tête est une
  copie de celui d'ExportJdv.
- Saisie de dates partielles : candidates à [`LDate`](../../../Utils/LDate.class/architecture.md)
  (notes transverses : `Utils.Cdate_*` ↔ `LDate`).

### Réduction de portée

- `Ex1`, `Exo`, `finmois`, `Compdate`, `compdate2`, `donnees1`…`donnees8`, `Raz`, `Controle`,
  `export` → `Private` (seul `Fmenu` ouvre la fenêtre, vérifié par `grep -rn "ExportJdv\." .src`).
  Les handlers (`*_Click`, `*_GotFocus`, `*_LostFocus`, `*_KeyPress`) gardent nom et portée.

### Séparation traitement / GUI

- Cœur `ExporteJournal(sJournal, dDeb, dFin, iFormat, sRep, bNonExportees, bSage) As Integer`
  (nombre de lignes, fichiers produits) sans accès aux contrôles ni messages ; `Button2_Click`
  garde la lecture des contrôles, les messages, l'éditeur, les réglages et l'envoi.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `centralisations` : table de travail persistante jamais relue ; à supprimer (ou table
  temporaire) — sa disparition change le dump, d'où l'anomalie EXPORTJDV-A08.
- `Fiches_Mvt.export` (`char(1)`, NULL ou `'1'`) : un booléen non nul avec la date d'export
  permettrait de retrouver un lot d'export et d'annuler un export raté.
- Les réglages d'export (`Dte_exprt`, `Numdoc_exprt`…) sont locaux au poste : les stocker en base
  (`Fiches_Parametres`) les partagerait entre postes.
