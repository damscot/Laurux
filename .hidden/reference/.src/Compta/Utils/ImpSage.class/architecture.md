# ImpSage — Architecture

> Source : `.src/Compta/Utils/ImpSage.class` · Form : `ImpSage.form`

## Vue d'ensemble

Fenêtre « Import écritures Sage » (2013, menu Comptabilité > Outils, `Fmenu.Menu286_Click`). Copie
adaptée d'[`ImpJdv`](../ImpJdv.class/architecture.md) pour deux fichiers Sage à **positions fixes**
placés dans `/Soc<XX>/Chemin-import` (la 1re ligne de chacun est ignorée) :

- `clients.pnc` (tiers) : code Sage 1-13, nom 14-37, collectif 51-53 (`411`, `401`, `403`),
  adresse 1 64-87, adresse 2 88-111, CP 112-119, ville 120-145 ;
- `ecritures.pnm` : journal 1-3, date 4-9 (`JJMMAA`), type de pièce 10-11, compte général 12-19,
  type de compte 25 (`X` = tiers), compte tiers 26-33, n° de pièce 39-51, libellé 52-76, sens 84
  (`D`/`C`), montant 85-104, n° de ligne/lot 106-112.

La table `Corsage` (`acode` → `ncode`) mémorise la correspondance code Sage → code Laurux.

Déroulement (`Import_Sage`) : dump (`Sauve`), lecture des derniers numéros client/fournisseur
(`dnc`, `dnf`) et calcul des prochains (`Compteur`, `Compteurf`), recherche des collectifs client
(`41*`) et fournisseur (`40*`), confirmation, création des tiers inconnus (client ou fournisseur +
compte + correspondance `Corsage` + ligne PDF), contrôle des comptes (`Controle`, sans effet),
création automatique des comptes généraux manquants (`ControleS`), puis import des écritures
(`ComptaS`) : nouveau numéro d'écriture à chaque changement de n° de pièce, ligne collectif + ligne
tiers pour les comptes `411`/`401` de type `X`, ligne simple pour les autres, mise à jour des soldes.

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 29 |
| `Tab` | var | Private |  | String | 30 |
| `Filename` | var | Private |  | String | 31 |
| `rResult` | var | Private |  | Result | 32 |
| `ParaResult` | var | Private |  | Result | 33 |
| `CliResult` | var | Private |  | Result | 34 |
| `SageResult` | var | Private |  | Result | 35 |
| `rnum` | var | Private |  | Result | 36 |
| `code` | var | Private |  | String | 37 |
| `Cv` | var | Private |  | String | 38 |
| `nom` | var | Private |  | String | 39 |
| `Prenom` | var | Private |  | String | 40 |
| `adr1` | var | Private |  | String | 41 |
| `adr2` | var | Private |  | String | 42 |
| `cp` | var | Private |  | String | 43 |
| `ville` | var | Private |  | String | 44 |
| `Email` | var | Private |  | String | 45 |
| `Telbur` | var | Private |  | String | 46 |
| `Teldom` | var | Private |  | String | 47 |
| `Poste` | var | Private |  | String | 48 |
| `Portable` | var | Private |  | String | 49 |
| `Fax1` | var | Private |  | String | 50 |
| `Fax2` | var | Private |  | String | 51 |
| `Encours` | var | Private |  | String | 52 |
| `codebanque` | var | Private |  | String | 53 |
| `codeguichet` | var | Private |  | String | 54 |
| `Cle` | var | Private |  | String | 55 |
| `numcompte` | var | Private |  | String | 56 |
| `num` | var | Private |  | String | 57 |
| `numf` | var | Private |  | String | 58 |
| `Dom` | var | Private |  | String | 59 |
| `Cent` | var | Private |  | String | 60 |
| `Cacc` | var | Private |  | String | 61 |
| `Tire` | var | Private |  | String | 62 |
| `Idtva` | var | Private |  | String | 63 |
| `Relcompte` | var | Private |  | String | 64 |
| `Relfacture` | var | Private |  | String | 65 |
| `obs` | var | Private |  | String | 66 |
| `collectif` | var | Private |  | String | 67 |
| `colcpt` | var | Private |  | String | 68 |
| `colcptf` | var | Private |  | String | 69 |
| `rmo` | var | Private |  | String | 70 |
| `rart` | var | Private |  | String | 71 |
| `hfile3` | var | Private |  | File | 72 |
| `Jnl` | var | Private |  | String | 73 |
| `Nfac` | var | Private |  | String | 74 |
| `numecr` | var | Private |  | String | 75 |
| `numr` | var | Private |  | Integer | 76 |
| `Ctrl` | var | Private |  | String | 77 |
| `PosY` | var | Private |  | Integer | 78 |
| `Coulfond` | var | Private |  | New String[] | 79 |
| `pdf` | var | Private |  | Cclients | 80 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 82-90 | Public | 2 | 7 | 0 | méthode spéciale |
| `Btn_Click` | 92-107 | Public | 6 | 11 | 0 | handler GUI |
| `Svs2_Click` | 109-119 | Public | 2 | 8 | 0 | handler GUI |
| `Import_Sage` | 121-271 | Public | 32 | 141 | 0 | portée réductible ? |
| `Sauve` | 273-282 | Public | 2 | 7 | 0 | portée réductible ? |
| `Creation_Fournisseur` | 284-302 | Public | 2 | 16 | 0 | portée réductible ? |
| `Creation_Client` | 304-322 | Public | 4 | 16 | 0 | portée réductible ? |
| `Maj_Client` | 324-346 | Public | 5 | 20 | 0 | portée réductible ? |
| `Controle` | 348-430 | Public | 13 | 77 | 0 | portée réductible ? |
| `ControleS` | 432-507 | Public | 22 | 69 | 0 | portée réductible ? |
| `ComptaS` | 509-691 | Public | 50 | 172 | 0 | portée réductible ? |
| `Controle_tiers` | 694-702 | Public | 2 | 6 | 0 | portée réductible ? |
| `Controle_journal` | 705-725 | Public | 7 | 18 | 0 | portée réductible ? |
| `Parametres` | 730-740 | Public | 2 | 7 | 0 | portée réductible ? |
| `Ecritures` | 745-756 | Public | 2 | 9 | 0 | portée réductible ? |
| `Maj_Parametres` | 761-771 | Public | 1 | 7 | 0 | portée réductible ? |
| `Majnum` | 776-781 | Public | 1 | 4 | 0 | portée réductible ? |
| `header` | 783-794 | Public | 1 | 10 | 0 | portée réductible ? |
| `content1` | 796-800 | Public | 1 | 3 | 0 | portée réductible ? |
| `content0` | 802-806 | Public | 1 | 3 | 0 | portée réductible ? |
| `footer` | 808-812 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button3_Click` | 814-818 | Public | 1 | 3 | 0 | portée réductible ? |
| `Compteur` | 823-839 | Public | 6 | 15 | 0 | portée réductible ? |
| `Compteurf` | 844-860 | Public | 6 | 15 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Handlers

- **`_New()`** [constructeur] : `Utils.Coulfd()` (résultat inutilisé), chemin d'import.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 1 aide, tag 2 `Import_Sage`, tag 3 suppression
  du PDF et fermeture. **Identique** à `ImpJdv.Btn_Click` (au nom `Import` près).
- **`Svs2_Click()`** [handler] : `Dialog.SelectDirectory` (identique à ImpJdv).
- **`Button3_Click()`** [handler nominal appelé par `Btn_Click`] : `Doc.Open("Export")`.

### Orchestration

- **`Import_Sage()`** [portée : réductible] [nature : mixte, CC 32]. `Shell "cd ~"` (sans effet),
  PDF `~/tmp/Edclients.pdf` (`Cclients`), `Sauve()` avant toute vérification ; `SELECT * FROM
  Fiches_Parametres` → `Num` (`dnc`), `Numf` (`dnf`) ; `Compteur()`, `Compteurf()` ; deux fois
  `SELECT * FROM Fiches_Comptes WHERE coll = '1' ORDER BY cast(compte_cc AS char)` pour le
  **premier** collectif `41*` et le **premier** `40*` (à défaut : le dernier collectif lu, quel
  qu'il soit). Pour chaque tiers de `clients.pnc` :
  - `SELECT * FROM Corsage WHERE acode = &1` ; si absent :
    - `411` : `Try INSERT INTO Corsage (acode, ncode)` avec `num`, puis si `num` absent de
      `Fiches_Cli` : `Creation_Client` + `pdf.Level2S` ;
    - `401` et `403` (deux blocs identiques) : idem avec `numf`, mais l'existence est testée dans
      **`Fiches_Cli`** au lieu de `Fiches_Four` ; `Creation_Fournisseur` ;
    - dans tous les cas `Inc Nbc` et ligne de séparation PDF (même pour un code d'un autre collectif) ;
  - si présent : **`num = Sageresult!ncode`** : le compteur de prochain client est écrasé par un
    code existant (voir IMPSAGE-A01).
  Puis message, `footer()` (vestige Kugar écrit dans le fichier PDF), `Controle`, `ControleS`,
  `ComptaS` (la branche `bcpt <> "0"` est inatteignable), sortie PDF.
- **`Sauve()`** [portée : réductible] [nature : traitement]. Même `mysqldump` qu'`ImpJdv.Sauve`
  (fichier `Laurux_dump.sql<JJMMAAAA>`, suppression de `Laurux_dump.sql`).

### Tiers

- **`Compteur()` / `Compteurf()`** [portée : réductible] [nature : calcul]. Prochain code :
  `Null` ou ≤ `411000` → `411001` ; `411999` → `4111000` ; `4119999` → `41110000` ; sinon + 1
  (idem en `401…` pour les fournisseurs). `Compteur` est **identique** à
  [`Impclient.Compteur`](../../../Utils/Exports-Imports/Impclient.class/architecture.md).
- **`Creation_Client()`** [portée : réductible] [nature : traitement]. `SELECT dnc`, `Try INSERT
  INTO Fiches_Cli (34 colonnes)` avec le code Laurux `num`, le nom, les adresses et
  `cli_obs` = code Sage (les autres champs, membres jamais affectés, sont vides ; même décalage
  d'arguments RIB qu'ImpJdv, sans effet ici car vides) ; `Try INSERT INTO Fiches_Comptes` (type `C`,
  collectif `colcpt`) ; `UPDATE Fiches_Parametres SET dnc` si besoin ; `Inc num`.
- **`Creation_Fournisseur()`** [portée : réductible] [nature : traitement]. `SELECT dnf`, `INSERT
  INTO Fiches_Four (31 colonnes)` **sans `Try`** (`fo_obs` = code Sage, `fo_collectif` =
  `colcptf`), `INSERT INTO Fiches_Comptes` (type `F`), `UPDATE … dnf`, `Inc numf`.
- **`Maj_Client()`** [portée : réductible] : **code mort** (aucun appel, vérifié par `grep`),
  identique à `ImpJdv.Maj_Client` ; écrase de plus le membre `Colcpt`.

### Contrôles

- **`Controle(Ctrl2)`** [portée : réductible] [nature : mixte]. Copie de `ImpJdv.Controle` avec un
  découpage manuel des champs, mais la variable locale `Filetxt2` n'est **jamais affectée** : la
  boucle de contrôle ne s'exécute pas (si `Exist("")` est faux, à confirmer). Effet réel :
  `DROP`/`CREATE Nvcompte` et un `Nvcomptes.txt` vide.
- **`ControleS(Ctrl2)`** [portée : réductible] [nature : mixte, CC 22]. Recrée `Nvcompte`, puis pour
  chaque ligne de `ecritures.pnm` dont le compte général ne commence ni par `4110` ni par `4010` :
  si absent de `Fiches_Comptes`, **le crée** (`Try INSERT`, intitulé `" "`, type `B` si le compte
  commence par 1-5, `G` si 6-7, sinon la valeur précédente ; trésorerie si `512`/`530`) et écrit
  « Compte créé » dans `Nvcomptes.txt`, ouvert ensuite dans l'éditeur. La valeur renvoyée est
  ignorée par l'appelant.

### Écritures

- **`ComptaS()`** [portée : réductible] [nature : mixte, CC 50, max du fichier]. Pour chaque ligne :
  journal via `Controle_journal`, date `20AAMMJJ`, compte général, type de compte ; nouveau numéro
  d'écriture (`numr + 1`, `Majnum`) quand `Val(n° pièce)` diffère de la pièce précédente
  (comparaison nombre / chaîne, à confirmer pour les pièces alphanumériques) ; compte tiers converti
  par `Controle_tiers` (`Corsage`) pour `411`/`401`/`403` de type `X`. Doublon testé par `SELECT …
  WHERE compte, numdoc, jour, libelle` (5 arguments pour 4 paramètres : le montant est ignoré).
  - tiers `411`/`401` de type `X` : ligne collectif (`coll_cc` lu sans test `Available`) + solde,
    ligne tiers (`dateech` = date) + solde ;
  - puis, si le compte ne commence ni par `4110` ni par `4010` : ligne simple + solde — ce qui
    **réinsère** la ligne d'un tiers dont le code Laurux ne commence pas par `4110`/`4010`
    (dès `411100` / `401100`, voir IMPSAGE-A03) ;
  - sinon, pour les `41*`/`40*` : ligne « écriture créée » dans `rejets.txt` ; doublon : « écriture
    rejetée ».
  `intitule` n'est jamais affecté (colonne vide) ; `Nbe2` jamais incrémenté ; message final
  « Traitement terminé ! ». Montants : `Val(cpoint())` ou `cpoint(Val())` selon la branche (ordre
  inversé l.651, l.661). Aucune transaction.
- **`Controle_tiers(cpt)`** [portée : réductible] [nature : traitement]. `SELECT * FROM Corsage
  WHERE acode = &1` → `ncode` (sinon `Null`).
- **`Controle_journal(jnal)`** [portée : réductible] [nature : calcul]. Correspondance en dur :
  `ACH`→60, `VTE`→70, `BQ1`→50, `RAN`→90, `OD `→10, `CAI`→53, sinon `""`.
- **`Parametres()`** : relit `jrnal` dans `Jnl` (jamais relu) ; **`Ecritures(numecr2)`**,
  **`Majnum(numecr2, numr2)`** : identiques à ImpJdv ; **`Maj_Parametres()`** : code mort (aucun
  appel ici ; c'est elle qui écrase `dnfac` dans ImpJdv).
- **`header()`, `content1()`, `content0()`** : code mort ; **`footer()`** : vestige Kugar appelé.

## État global utilisé

- `Start.LocalSettings` (`/Soc<XX>/Chemin-import`, `/dbase/Host`), `Start.Societe`, `Start.Son`,
  `Start.Musique` ; `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Utils.Coulfd`,
  `Utils.Observers` ; `Cclients`, `Visualiseur`, `Editeur`, `Doc`.
- Tables : `Corsage`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Comptes` (INSERT, `solde`),
  `Fiches_Mvt`, `Fiches_Parametres` (`dnc`, `dnf`, `numecriture`), `Nvcompte` ; noms en dur.

## Propositions d'amélioration

### Réécriture / refactorisation

- Fusionner les trois blocs `411`/`401`/`403` d'`Import_Sage` (un seul bloc paramétré par le
  compteur et la fonction de création), en conservant l'existence testée dans `Fiches_Cli`.
- `ControleS`/`ComptaS` : remplacer les chaînes de `Or` sur le premier caractère par
  `InStr("12345", sCar)` ; extraire le découpage d'une ligne `.pnm` dans une fonction pure
  `LigneSage(sLig) As String[]` (testable) et l'insertion dans un helper.
- `Controle_journal` : table de correspondance constante (`Collection`), même résultat.
- `Cbase.Table` pour `Fiches_*` ; `Corsage` n'a pas de clé `Cbase` (en ajouter une sans changer le
  nom physique).

### Commonalisation avec d'autres fichiers

- Avec [`ImpJdv`](../ImpJdv.class/architecture.md) : `Btn_Click`, `Svs2_Click`, `Sauve`,
  `Parametres`, `Ecritures`, `Majnum`, `Maj_Parametres`, `Maj_Client`, `header`/`content*`/`footer`,
  `Button3_Click` (identiques ou quasi), `Controle`, `Creation_Client`, insertion d'écriture + solde
  (`ComptaS` ↔ `Compta`) → module commun d'import comptable.
- `Compteur` = [`Impclient.Compteur`](../../../Utils/Exports-Imports/Impclient.class/architecture.md)
  (IMPCLIENT-008, helper `ProchainCodeClient`) ; `Compteurf` est la même règle avec le préfixe
  `401` → helper unique `ProchainCodeTiers(sDernier, sPrefixe)`. Une forme voisine existe dans
  `Facture.class:1841-1847`.
- Collectif client : même boucle (premier `41*`) dans `Impclient` l.91-97 ; ImpJdv prend le dernier.
- `Sauve` → `Utils.DumpBase` (SAUVESAUTO-003, voir
  [SauvesAuto](../../../Communs/SauvesAuto.module/architecture.md)).
- Export Sage symétrique : [`ExportJdv`](../ExportJdv.class/architecture.md) type « 6- Sage »
  produit `ecritures<JJ>.pnm` / `clients.pnc` ; une description commune des positions fixes
  servirait aux deux sens (à confirmer : les positions ne sont pas strictement identiques).

### Réduction de portée

- Toutes les fonctions non handler (`Import_Sage`, `Sauve`, `Creation_*`, `Controle`, `ControleS`,
  `ComptaS`, `Controle_tiers`, `Controle_journal`, `Parametres`, `Ecritures`, `Majnum`, `footer`,
  `Compteur`, `Compteurf`) → `Private` : seul `Fmenu` ouvre la fenêtre (`ShowModal`).

### Séparation traitement / GUI

- `ImporteTiers(sFichier) As Integer`, `CreeComptesManquants(sFichier) As String[]`,
  `ImporteEcritures(sFichier, bCloture) As Integer` sans accès aux contrôles ; `Import_Sage` garde
  souris, confirmation, messages, PDF et éditeur.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Corsage.acode` est en `char(8)` alors que le code Sage lu fait 13 caractères : un `varchar(13)`
  éviterait troncatures et collisions.
- `Corsage` figure dans `db_control.csv` mais sans clé `Cbase` ; une clé étrangère vers
  `Fiches_Cli`/`Fiches_Four` garantirait la cohérence de la correspondance.
- `Nvcompte` (table de travail persistante) → table temporaire.
