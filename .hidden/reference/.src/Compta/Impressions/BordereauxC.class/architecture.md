# BordereauxC — Architecture

> Source : `.src/Compta/Impressions/BordereauxC.class`

## Vue d'ensemble

`BordereauxC` est l'écran **« Bordereaux chèques (ancienne version) »** (menu Compta,
`Fmenu.Menu321_Click` → `BordereauxC.showmodal()`). Malgré son rangement dans `Impressions`, ce
n'est **pas** une simple édition : l'écran

1. affiche et permet de modifier la liste des chèques en attente de remise
   (`Fiches_BordereauxC` ; le moulinage de caisse [`Moulinage`](../../../Caisse/Moulinage.class/architecture.md)
   ne l'alimente plus depuis `d2a027d8`, 2020 : seules les saisies de cet écran l'alimentent) dans une
   `TableView` (`Grd1`) : sélection, ajout (clic droit), modification, suppression ;
2. imprime le bordereau de remise (`~/tmp/Bordereau.pdf`, classe `Cbordereaux`), le copie dans
   `<FactcheminC>/Bordereaux/<aaaa>/<mm>/Bordereau<N>.pdf` ;
3. si l'utilisateur confirme l'effacement des chèques remis, **génère l'écriture comptable de
   remise** dans `Fiches_Mvt` (une ligne crédit par client ou une ligne globale « Chèques caisse »,
   une ligne débit banque, une ligne de collectif), met à jour les soldes de comptes, calcule
   l'empreinte SHA-1 de l'écriture, puis supprime les chèques remis de `Fiches_BordereauxC`.

Toutes les écritures de l'étape 3 partagent le même numéro (`numecriture` + 1) et le même numéro
définitif (`numecriture2` + 1), réservés dans `Fiches_Parametres` **dès l'impression**. Aucune
transaction n'encadre la séquence.

La logique d'écriture (`Parametres`, `Ecritures`, `Maj_Collectif`) est une copie adaptée de
`Moulinage.class` (caisse), avec les mêmes défauts de calcul du solde collectif.

Nature globale : **mixte**, avec des effets de bord comptables importants.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Jnal` | var | Private |  | String | 3 |
| `numecr` | var | Private |  | String | 4 |
| `numr` | var | Private |  | String | 5 |
| `numr2` | var | Private |  | String | 6 |
| `colcpt` | var | Private |  | String | 7 |
| `Client` | var | Private |  | String | 8 |
| `Nclient` | var | Private |  | String | 9 |
| `Collectif` | var | Private |  | String | 10 |
| `$texte` | var | Private |  | String | 11 |
| `itn` | var | Private |  | Integer | 12 |
| `icol` | var | Private |  | Integer | 13 |
| `bnew` | var | Private |  | Boolean | 14 |
| `Posy` | var | Private |  | Integer | 15 |
| `iRow` | var | Private |  | Integer | 16 |
| `iColumn` | var | Private |  | Integer | 17 |
| `CoulFoc` | var | Private |  | Integer | 18 |
| `CoulCol` | var | Private |  | Integer | 19 |
| `pdf` | var | Private |  | Cbordereaux | 20 |
<!-- /AUTO:declarations -->

Variables utiles : `Jnal` (journal de banque = 2 premiers caractères de `Bq`), `numecr` (nom de
colonne de compteur), `numr`/`numr2` (numéros réservés), `Client` (compte client caisse),
`itn`/`icol`/`bnew` (état d'ajout de ligne dans la grille), `pdf`, `Posy`.
Inutiles : `Nclient`, `Colcpt`/`Collectif` (calculés dans `Parametres`, jamais lus), `$texte`,
`iRow`, `iColumn` (écrits, jamais lus), `CoulFoc`, `CoulCol` (couleurs lues dans la configuration,
jamais appliquées).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 22-41 | Public | 4 | 16 | 0 | handler GUI |
| `Recup_Cheques` | 43-94 | Public | 5 | 49 | 0 | portée réductible ? |
| `Grd1_Save` | 96-101 | Public | 2 | 4 | 0 | handler GUI |
| `Grd1_MouseUp` | 103-182 | Public | 20 | 76 | 0 | handler GUI |
| `Dateb_DblClick` | 184-192 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 194-199 | Public | 1 | 4 | 0 | handler GUI |
| `Button1_Click` | 201-205 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 207-222 | Public | 4 | 14 | 0 | handler GUI |
| `Imp_Bordereaux` | 224-382 | Public | 30 | 148 | 0 | portée réductible ? |
| `Maj_Collectif` | 384-417 | Public | 4 | 31 | 0 | portée réductible ? |
| `Parametres` | 422-457 | Public | 5 | 27 | 0 | portée réductible ? |
| `Ecritures` | 462-477 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button3_Click` | 479-485 | Public | 1 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Grille des chèques

- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. Lit `/Coul/Focus` et
  `/Coul/Znaff` (inutilisés), date du jour dans `Dateb`, remplit `Bq` avec les journaux de type
  trésorerie hors `53…` : `select * from Fiches_Journaux where type_jo = &1order by code_jo`
  (espace manquant avant `order`, accepté par le serveur une fois `&1` substitué ; nom en dur),
  puis `Recup_Cheques()`.
- **`Recup_Cheques()`** [portée : réductible] [nature : mixte]. Réinitialise `Grd1` (10 colonnes :
  0 `lind`, 1 sélection « 1 »/« 0 », 2 icône, 3 date, 4 montant, 5 code client, 6 nom, 7 n° de
  facture, 8 icône d'action, 9 `lind`), `select * from Fiches_BordereauxC order by dateremise`
  (nom en dur). Date affichée au format `"dd.mm.yyy"` (trois `y`, résultat à confirmer) ; montant
  affiché brut (point décimal de la base). Tous les chèques sont sélectionnés.
- **`Grd1_Save(Row, Column, Value)`** [portée : nécessaire (événement `Save` de la `TableView`,
  faux positif de `deps.py`)] [nature : GUI]. Recopie la valeur saisie et passe l'icône d'action à
  « save ».
- **`Grd1_MouseUp()`** (CC 20) [portée : nécessaire (handler)] [nature : mixte].
  Clic droit : propose d'ajouter une ligne (date = `Dateb`, sélectionnée, icône « save »).
  Clic gauche colonne 2 : bascule la sélection (texte barré/italique). Colonne 8 avec icône
  « save » : `INSERT INTO Fiches_BordereauxC (code, nom, montant, dateremise, banque, nfacture)`
  si la ligne n'a pas de `lind`, sinon `Update Fiches_BordereauxC … where lind = &7` (montant pris
  **tel que saisi**, date reconvertie depuis la colonne 3 par `Utils.Cdate_Dbase`, banque =
  `Left$(Bq.text, 2)`), puis rechargement. Colonne 8 avec icône « trash » : confirmation puis
  `Delete from Fiches_BordereauxC where lind = &1`. Autre colonne : passage en édition. Un
  `Catch` **vide** masque toute erreur (BORDEREAUXC-A09).
- **`Dateb_DblClick()`, `DateChooser1_Activate()`** [portée : nécessaire (handlers)] [nature : GUI].
  Calendrier pour la date du bordereau.
- **`Button1_Click()`** (Quitter), **`Button3_Click()`** (Rafraîchir : rechargement, masque
  `Tbgrd1`) [portée : nécessaire (handlers)] [nature : GUI].

### Impression et comptabilisation

- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Exige un numéro de
  bordereau et une banque, puis `Imp_Bordereaux()`.
- **`Imp_Bordereaux()`** (CC 30) [portée : réductible] [nature : mixte].
  1. `Parametres()` : réserve les numéros d'écriture (**écriture en base**, même si la
     comptabilisation est refusée ensuite, BORDEREAUXC-A04).
  2. `select * from Fiches_ClientCaisse` → compte et nom du client caisse ;
     `select * from Fiches_Journaux where code_jo = &1` → titre et compte de banque
     (`cde_banque`).
  3. PDF : `New Cbordereaux` **deux fois** (le premier objet est abandonné), `Entete`, `TitreB`,
     `Level6`, une ligne `Level7` par chèque sélectionné, `Level8` (nombre et total). `Output`,
     `Visualiseur.Prog`.
  4. Copie : création des répertoires `<FactcheminC>/Bordereaux/<aaaa>/<mm>` (année et mois de
     `DateChooser1.Value`, pas de `Dateb`) puis `Shell "cp <pdf> <chemin>/Bordereau<N>.pdf" Wait`
     sans guillemets (BORDEREAUXC-A07). Sans chemin : `Message.Warning`.
  5. Sur « Oui » à « Voulez-vous effacer les chèques remis à la banque ? » :
     - **chèques du client caisse** : total ; si > 0, test de lettrage
       `select sum(replace(montantd, ',', '.')) …, sum(replace(montantc, ',', '.')) … from Fiches_Mvt
       where numlot = &1 and compte = &2` avec `Nlot` **encore vide** (BORDEREAUXC-A05),
       `INSERT INTO Fiches_Mvt` (17 colonnes : crédit du client caisse, journal `Jnal`, numéro
       `numr`, `numdoc`/`numlot` = n° de bordereau, `validee` 1, `tresorerie` 1, `lettree` 0,
       `Cloturee` 1, `numerodef` `numr2`), `UPDATE Fiches_Mvt set lettree = &1 Where numero = &2`
       (toute l'écriture), `Csolde.Solde_caisse`, `Maj_Collectif` ;
     - **chèques clients** (code ≠ client caisse) : pour chacun, `Nlot` = n° de facture ou de
       bordereau, test de lettrage sur ce lot, `INSERT` crédit (libellé « <nom> 'B<N> »),
       `Csolde.Solde_caisse(client)`, `Maj_Collectif` ; un chèque sans code client déclenche
       `Message.Error` avec le montant du chèque **précédent** (BORDEREAUXC-A06) ;
     - **ligne de banque** : `INSERT` débit du total sur `cde_banque`, libellé
       « Bordereau de chèque N° » & `Bordereaux.Text` — `Bordereaux` est le **formulaire de caisse**
       `.src/Caisse/Bordereaux.form` (auto-instance, titre vide), pas le champ `Nbordereau`
       (BORDEREAUXC-A01) ; `numdoc`/`numlot` = dernier `Nlot` ; `Csolde.Solde_caisse(banque)` ;
       puis `Maj_Collectif(cptcli, …, montant, blettree)` avec le **dernier client et le dernier
       montant** : le collectif est crédité une seconde fois du dernier chèque (BORDEREAUXC-A02) ;
     - `Sha1Calc.CalcSha1("Fiches_Mvt", numr)` (nom en dur) ;
     - `DELETE FROM Fiches_BordereauxC WHERE lind = &1` pour chaque chèque sélectionné ;
       rechargement ; `Message.Info("Traitement terminé !")`.
  Variables inutiles : `Tab` (`Fiches_LigTicketz`), `lg`, `bcheque`.
- **`Maj_Collectif(Cpt, intit, libel, Mnt, lettree)`** [portée : réductible] [nature : calcul].
  Collectif `coll_cc` du compte ; s'il existe déjà une ligne de collectif pour (`coll`, `numr`,
  `numr2`) : `UPDATE … set montantc = Mnt + montantc existant, lettree` (la branche `Mnt <= 0`
  calcule `Mtd` sans l'écrire) ; sinon `INSERT` d'une ligne `collectif = 1` (`numdoc`/`numlot` =
  date du `DateChooser1` en `ddmmyyyy`). Puis `UPDATE Fiches_Comptes set solde = solde + Mtd - Mtc`
  sur le collectif : en cas de mise à jour, `Mtc` est le **cumul** et non l'incrément, le solde du
  collectif est donc diminué plusieurs fois des chèques précédents (BORDEREAUXC-A03, à confirmer ;
  défaut identique dans `Moulinage.Maj_Collectif`). Pas de test `Available` sur les lectures de
  `Fiches_Comptes`.
- **`Parametres()`** [portée : réductible] [nature : calcul]. `numr = Ecritures("numecriture") + 1`,
  `numr2 = Ecritures("numecriture2") + 1`, `UPDATE Fiches_Parametres set numecriture = &1,
  numecriture2 = &2` (nom en dur) ; journal ; client caisse (`Cbase.Table("TabCliCaisse")`) ;
  recherche d'un collectif de même préfixe (requête et boucle sans effet utile).
- **`Ecritures(numecr2)`** [portée : réductible] [nature : calcul]. `SELECT <numecr> FROM
  Fiches_Parametres` : utilise la **variable d'instance** `numecr` dans le SQL et le **paramètre**
  `numecr2` pour lire le champ (même valeur à chaque appel) ; renvoie "0" si nul (variable `nro`
  non initialisée si la table est vide).

## État global utilisé

- `Utils.db`, `Utils.FColr`, `Utils.cpoint`, `Utils.Cdate_Dbase` ; `Csolde.Solde_caisse` ;
  `Sha1Calc.CalcSha1` ; `Cbase.Table("TabMvt"|"TabComptes"|"TabParam"|"TabCliCaisse")`.
- `Start.LocalSettings["/Coul/Focus"]`, `["/Coul/Znaff"]`, `["/Soc<XX>/FactcheminC"]`,
  `Start.Societe`.
- Auto-instance du formulaire de caisse `Bordereaux` (`Bordereaux.Text`).
- Noms en dur : `Fiches_Journaux`, `Fiches_BordereauxC`, `Fiches_ClientCaisse`,
  `Fiches_Parametres`, `"Fiches_Mvt"` (SHA-1).
- Fichiers : `~/tmp/Bordereau.pdf`, copie sous `FactcheminC`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la double création du `pdf` et les variables mortes ; `Ecritures` lit la colonne
  passée en paramètre.
- Helper privé `Insere_Ligne(compte, intitule, numdoc, numlot, libelle, debit, credit, lettree)`
  pour les trois `INSERT` de 17 colonnes ; helper `Est_Lettre(sNlot, sCompte, fMontant) As
  Boolean` pour les deux tests de lettrage identiques.
- `Grd1_MouseUp` (CC 20) découpé en `Ajoute_Ligne`, `Bascule_Selection(iRow)`,
  `Enregistre_Ligne(iRow)`, `Supprime_Ligne(iRow)` ; le `Catch` vide est conservé tant que A09
  n'est pas validée.

### Commonalisation avec d'autres fichiers

- `Parametres`/`Ecritures`/`Maj_Collectif` sont des variantes de
  [`Moulinage`](../../../Caisse/Moulinage.class/architecture.md) (`Moulinage.class:2206`, `2235`,
  `2618`) ; `Ecritures` existe aussi dans `ValidBR` et `Facture`. Un service commun « réservation
  de numéro d'écriture » et « mise à jour de collectif » (module `Cecrit` ?
  [Cecrit](../../Cecrit.module/architecture.md)) est à étudier en phase 3, **sans** corriger les
  anomalies en même temps.
- Socle commun des éditions (voir [FTVA](../FTVA.class/architecture.md#commonalisation-avec-dautres-fichiers)) :
  `Termine(pdf, fichier)`, bascule du `DateChooser` (identique dans
  [Echeancier](../Echeancier.class/architecture.md)).
- Le bordereau de caisse [`Caisse/Bordereaux`](../../../Caisse/Bordereaux.class/architecture.md)
  produit un PDF voisin avec la même classe `Cbordereaux`.

### Réduction de portée

- `Recup_Cheques`, `Imp_Bordereaux`, `Maj_Collectif`, `Parametres`, `Ecritures` → `Private`
  (`grep -rn "BordereauxC\." .src` : seul `Fmenu:2427` appelle `showmodal`). `Grd1_Save` reste
  `Public` (événement `Save` de la `TableView`).

### Séparation traitement / GUI

- `Imp_Bordereaux` se scinde en `Imprime_Bordereau(aCheques)` (PDF + copie) et
  `Comptabilise_Remise(aCheques, sJournal, sNumBord, sDate)` (SQL seul, liste de chèques passée
  en paramètre au lieu de lire `Grd1`) ; le handler enchaîne les deux et garde les dialogues.
- `Enregistre_Ligne` : SQL d'insertion/mise à jour isolé de la lecture de la grille.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_BordereauxC.banque` est un `int(1)` alors que l'écran y range un code journal de deux
  caractères ; la colonne `bordereau` (n° de remise) et `etat` ne sont jamais renseignées par cet
  écran : elles permettraient de conserver l'historique des remises au lieu de supprimer les lignes.
- Les compteurs `numecriture`/`numecriture2` de `Fiches_Parametres` devraient être réservés de
  façon atomique (séquence ou `UPDATE … RETURNING`).
