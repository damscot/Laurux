# EcrAuto — Architecture

> Source : `.src/Compta/Utils/EcrAuto.class`

## Vue d'ensemble

`EcrAuto` est le **moteur d'écritures comptables automatiques**. On le construit avec un journal et
un [`VarEcr`](../VarEcr.class/architecture.md) (conteneur de lignes), puis `ecriture()` enregistre
l'écriture dans `Fiches_Mvt` :

- contrôle d'équilibre (`Vecr.somme() = 0`) et d'au moins deux lignes ;
- numérotation : `numecriture` (et, pour une **vente**, `numecriture2` = numéro définitif et `dnfac`
  = numéro de facture) par `Utils.db.LockIncrement` sur `Fiches_Parametres` ;
- pour chaque ligne selon son `etat` : ajout (`L_ajou`, `L_valide`, `L_caisse`), modification
  (`L_modif` : copie de l'ancienne ligne dans `Fiches_MvtM` puis réécriture) ou suppression
  (`L_sup` : copie dans `Fiches_MvtM` marquée `supprimee`, puis `DELETE`) ;
- effets de chaque ajout : solde du compte (`Fiches_Comptes.solde`), lettrage automatique (avec
  écriture de régularisation si l'écart est sous le seuil paramétré), traite (LCR) pour un client en
  vente, ligne de **collectif** si le compte en a un (`coll_cc`) ;
- clé d'intégrité chaînée (`Sha1Calc.CalcSha1`), libération du verrou `DocActif`, archivage GED d'un
  PDF de l'écriture (si `/Soc<XX>/FactcheminC`).

`Impression`/`FinImp` construisent un `Report` (gb.report) listant les lignes, utilisé par les
appelants pour imprimer les écritures passées. [`EcrReg`](../EcrReg.class/architecture.md) hérite
d'`EcrAuto` pour les écritures de règlement.

Appelants : `ObjFac` (factures de vente), `ValidBR1` (réceptions fournisseurs), `SaiReg` et
`Moulinage` (règlements, via `EcrReg`), et `EcrAuto` lui-même (régularisation de lettrage).

La classe est déclarée `Create Static`, mais aucun accès statique n'existe (et l'auto-instance ne
pourrait pas être construite : `_new` exige un `VarEcr`).

Nature globale : **traitement** (SQL, règles comptables), avec des `Message.Error`/`Message.Info`
bloquants au milieu des transactions et une partie **GUI** (`Report`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `resjou` | var | Public |  | Result | 5 |
| `Vecr` | var | Public |  | VarEcr | 6 |
| `numecr` | var | Public |  | Integer | 7 |
| `numerodef` | var | Public |  | Integer | 8 |
| `numfac` | var | Public |  | String | 9 |
| `$rescomp` | var | Private |  | Result | 11 |
| `$imp` | var | Private |  | Report | 12 |
| `Imp` | property | Public |  | Report | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 17-31 | Public | 4 | 12 | 0 | méthode spéciale |
| `Impression` | 33-235 | Public | 8 | 195 | 2 |  |
| `FinImp` | 237-256 | Public | 1 | 16 | 2 |  |
| `ecriture` | 258-343 | Public | 22 | 77 | 4 |  |
| `facnum` | 345-387 | Private | 8 | 38 | 0 |  |
| `ajout` | 389-462 | Private | 18 | 67 | 0 |  |
| `modif` | 464-499 | Private | 2 | 31 | 0 |  |
| `sup` | 501-511 | Private | 1 | 8 | 0 |  |
| `solde` | 513-526 | Private | 4 | 11 | 0 |  |
| `collectif` | 528-540 | Private | 4 | 11 | 0 |  |
| `traite` | 542-562 | Private | 7 | 17 | 0 |  |
| `ged` | 565-595 | Private | 5 | 28 | 0 |  |
| `Lettrage` | 598-637 | Private | 6 | 35 | 0 |  |
| `DLettrage` | 639-662 | Private | 5 | 18 | 0 |  |
| `diff` | 664-689 | Private | 2 | 22 | 0 |  |
| `Imp_Read` | 691-695 | Private | 1 | 3 | 0 |  |
| `Imp_Write` | 697-701 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(Optional njo, Ve)`** [spéciale] [traitement]. Si `njo` est vide et que l'écriture est une
  vente : journal `jrnal` de `Fiches_Parametres` (sans `Available`). Charge `resjou`
  (`SELECT * FROM Fiches_Journaux WHERE code_jo=&1`) ; `Error.Raise("Journal innexistant …")` si
  absent. `Vecr = ve`. Paramètre optionnel suivi d'un paramètre obligatoire (accepté par Gambas,
  l'appelant passe toujours les deux).

### Impression (GUI, gb.report)

- **`Impression(imp) As Report`** [portée : nécessaire, `ValidBR1`, `SaiReg`] [GUI] (203 lignes).
  Si `imp` est nul : nouveau `Report` paysage, bandeau « Impression des écritures du : <date> » et
  ligne d'en-têtes de 12 colonnes. Puis une ligne par `VarEcr` non collectif : journal, état
  (« Provisoire » si `numecr = 0`, sinon « Création »/« supprime »/« Modifie »), date, n° d'écriture,
  n° définitif, compte, intitulé (45 car.), libellé (45 car.), document, lot, débit, crédit. Chaque
  cellule est un `New ReportLabel` suivi de 4 à 6 affectations identiques (bordure, hauteur, largeur,
  police, alignement, texte) : ~25 blocs dupliqués. Police `"Serif, Blod, 12"` : « Blod » est une
  faute de frappe (le gras n'est probablement pas appliqué, à confirmer).
- **`FinImp(imp) As Report`** [portée : nécessaire, `ValidBR1`, `SaiReg`] [GUI]. Pied « Impression
  demandée par : <utilisateur> ».
- **Propriété `Imp`** (`Imp_Read`/`Imp_Write`) [portée : nécessaire] : `Report` cumulatif ; seule
  `Lettrage` y ajoute (impression des écritures de régularisation) ; les appelants la lisent et
  l'écrivent pour chaîner les impressions.

### Écriture

- **`ecriture() As Boolean`** [portée : nécessaire] [traitement] (CC 22). Renvoie `True` en cas
  d'abandon.
  1. Contrôle `somme() <> 0 Or nb() < 2` → `Message.Error` et abandon.
  2. Numéro : `LockIncrement("numecriture")` pour un ajout ; sinon `numecr = Val(Vecr.numero)` et
     `DocActif.Get_Lock("Reglement", numecr)`.
  3. Vente : `LockIncrement("numecriture2")`, `facnum()` (abandon si annulé, **après** avoir consommé
     les numéros d'écriture et définitif) ; libellé calculé par `LVar` à partir du libellé de la
     première ligne et de `Fiches_Comptes.libel_def` du client
     (`SELECT * FROM Fiches_Comptes left join Fiches_Cli On cli_code = &2 WHERE compte_cc Like &3 And
     coll <> &1`), variables `$numfac`, `$numerodef`, `$numecr`, `$date`, tronqué à 50 caractères.
  4. Pour chaque ligne : `utils.db.Begin`, puis selon `etat` : ajout (`Create9("Fiches_Mvt")` +
     `ajout`), modification (`modif` + `Edit` + `ajout` + `DLettrage`) ou suppression (`sup` +
     `DLettrage`). Un échec d'`ajout` arrête la boucle (les lignes déjà écrites restent).
  5. `LOCK TABLES Fiches_Mvt, Fiches_MvtM` ; `Sha1Calc.CalcSha1("Fiches_Mvt", numecr)` ; `UNLOCK`.
  6. Libère le verrou `DocActif` ; `ged()`.
- **`facnum() As String`** [Private] [mixte]. `LockIncrement("dnfac")`, préfixe `yymm` ou `yyyy`
  selon `Fiches_Parametres.nfac` ; vérifie l'absence du numéro dans `Fiches_Bl`, `Fiches_BlM`,
  `Fiches_HistoFac`, `Fiches_HistoFacM` ; en cas de doublon, `Message.Error` à deux boutons
  (« Annuler » → `""`, « N° suivant » → appel récursif).
- **`ajout(var) As Boolean`** [Private] [traitement] (CC 18). `LOCK TABLES Fiches_Comptes,
  Fiches_Mvt, Fiches_MvtM WRITE` ; contrôle du compte (`Fiches_Comptes`) — **en cas d'échec,
  `Message.Error` et retour `True` sans `UNLOCK TABLES` ni `Rollback`** (EcrAuto-A01) ; remplit
  `$rescomp` (journal, numéro, compte, intitulé 40 car., date, échéance, document/lot — `numfac` en
  vente —, libellé 50 car., débit ou crédit arrondi à 2 décimales, `cloturee`/`dteval`/`numerodef`
  en vente, `datee` et `tresorerie` en trésorerie, `pointee`/`lettree` faux, `relance = 0`,
  `validee`, `collectif` si `coll = 1`) ; `Update` ; `Commit` ; `solde` ; `UNLOCK TABLES`. Ensuite :
  `Lettrage` si le compte est lettrable ; `traite` si vente sur compte client ; ligne de collectif
  (`collectif`) si `coll_cc` et état `L_ajou`/`L_caisse` (en cas d'échec : abandon, sauf en vente où
  la facture est quand même créée après un `Message.Info`).
- **`modif(ind, Optional sup)`** [Private] [traitement]. Copie la ligne `lind = ind` de `Fiches_Mvt`
  dans `Fiches_MvtM` (`lind2`, `datem`, `supprimee` si `sup`) sous `LOCK TABLES` ; `Commit`.
- **`sup(ind, num)`** [Private] [traitement]. `modif(ind, True)` puis `Utils.db.Delete("Fiches_Mvt",
  "lind=&1")` et `solde(num)`.
- **`solde(num)`** [Private] [mixte]. `SELECT SUM(montantd), SUM(montantc) FROM Fiches_Mvt WHERE
  compte=&1 AND provisoire=False` ; si une somme est nulle → `Message.Error` ; sinon
  `UPDATE Fiches_Comptes SET solde=&1`. Même calcul que `Csolde`/`Calcsolde` (voir Commonalisation).
- **`collectif(var, cpt) As Boolean`** [Private] [traitement]. Échange `var.compte` et `cpt`, crée la
  ligne (branche `Edit` inatteignable : n'est appelée que pour `L_ajou`/`L_caisse`), appelle `ajout`
  récursivement, puis rétablit le compte — **sauf en cas d'échec** (le `VarEcr` garde le compte
  collectif).
- **`traite(var)`** [Private] [traitement]. Pour un montant débiteur, si le mode de règlement du
  client prévoit une LCR (`Mreglement.sans_lcr`/`lcr_acc`) : `insert into Fiches_Traites (…) value
  (…)` — mot-clé **`VALUE`** accepté par MySQL mais **pas par SQLite** (EcrAuto-A04).
- **`ged()`** [Private] [mixte]. Si `/Soc<XX>/FactcheminC` est renseigné : `Impression` + `FinImp`
  dans `~/tmp/Ecriture.pdf`, puis séquence GED `LGed.Search` → `New LGed` si absent → `PDFDupli`
  → `Supprime(False)` si échec → `AddTags(comptes)`.
- **`Lettrage(var)`** [Private] [traitement]. `New Listextcpt(compte, -8 ans, +8 ans, "t")` ; en
  trésorerie, reporte le lot sur les lignes de `var.Tlettrage` (`letcpt`). Si le lot n'est pas soldé
  (`Controle = 0`) et que l'écart est sous `Fiches_Parametres.ecart` : écriture de régularisation sur
  le journal `jrnod` (`diff` sur le compte, contrepartie `cptrsplus`/`cptrsmoins`) passée par un
  `New EcrAuto(…).ecriture()` récursif et ajoutée à `$imp`. **`var.compte` est modifié** (compte de
  régularisation) et n'est pas restauré : `ajout` poursuit ensuite avec ce compte pour `traite` et
  `collectif`, et l'impression montre le mauvais compte (EcrAuto-A02). Si le lot est soldé :
  `letgroupe` (lettrage).
- **`DLettrage(var)`** [Private] [traitement]. Après modification/suppression : si les lignes
  lettrées du lot `Vecr.numlot` (racine, pas `var.numlot`) ne sont plus soldées, délettrage du groupe
  (la question de confirmation est commentée). Variable `i` inutilisée.
- **`diff(cpt, var, ecart, jour) As VarEcr`** [Private] [calcul]. Construit une ligne de
  régularisation (`L_ajou`, `Autre`) au débit ou au crédit selon le signe.

## État global utilisé

- `Utils.db` (`Exec`, `LockIncrement`, `Create9`, `Edit`, `Delete`, `Begin`, `Commit`), `Utils.arrondi`.
- `Start.LocalSettings["/Soc<XX>/FactcheminC"]`, `Start.Societe`, `User.Name`, `User.Home`.
- `DocActif` (verrou « Reglement »), `Sha1Calc`, `LGed`, `LVar`, `LDate`, `Listextcpt`, `Mreglement`.
- Tables (toutes en dur) : `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Comptes`, `Fiches_Cli`,
  `Fiches_Journaux`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_Traites`, `Fiches_Bl`,
  `Fiches_BlM`, `Fiches_HistoFac`, `Fiches_HistoFacM`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Impression` : helper privé `Cellule(pan, largeur, texte, gras, alignement, bordure)` ; les ~25
  blocs deviennent une ligne chacun (rendu identique ; ~200 → ~60 lignes).
- `ecriture` : extraire `LibelleVente(var)` (bloc `LVar`) et `NumeroteEcriture()` ; CC 22 → ≤ 10.
- `facnum` : vérification d'existence en une requête `UNION` sur les 4 tables (SQL modifié, aucun
  effet sur la base) ; boucle au lieu de la récursion.
- Supprimer `Create Static` (aucun accès statique), la branche `Edit` inatteignable de `collectif`,
  la variable `i` de `DLettrage`, `resext`/`i` inutilisés de `Lettrage`.

### Commonalisation avec d'autres fichiers

- **Archivage GED** : la séquence de `ged()` est répétée dans `ObjFac:913-934`, `commande1:644-663`,
  `Edbr:230-249` → `LGed.Archive(type, origine, code, compte, pdf, nom, tags[])` proposé dans
  [LGed — Architecture](../../../Utils/LGed.class/architecture.md).
- **Libellé calculé par `LVar`** : séquence `New LVar` → `AddDate` → `ParseResult` → `Evaluate`
  répétée dans `Saisecrit`, `Tresor`, `ValidBR`, `ValidBR1` → helper `LVar.Calcule(…)` proposé dans
  [LVar — Architecture](../../../Utils/LVar.class/architecture.md).
- **Solde de compte** : `solde()` duplique `Csolde` / `Calcsolde` / `Recalcsolde`
  ([Csolde](../../../Utils/Csolde.module/architecture.md),
  [Calcsolde](../../../Utils/Calcsolde.class/architecture.md),
  [Recalcsolde](../Recalcsolde.module/architecture.md)). Attention : filtres différents (`provisoire=False` ici, `validee = 1` dans `Csolde.Solde_caisse`) ; une fonction commune doit garder le filtre en paramètre.
- **Nom de table en dur passé à `Sha1Calc.CalcSha1`** (`"Fiches_Mvt"`) : même constat que `Tresor`,
  `Saisecrit`, `Moulinage`, `Ecritures` → `Cbase.Table("TabMvt")`.
- **Numérotation de facture** (`facnum`) : à rapprocher de `Facture` / `ObjFac` (numérotation
  `dnfac`) en phase 3.

### Réduction de portée

- Rien : `Impression`, `FinImp`, `ecriture`, `Imp`, `resjou`, `Vecr`, `numecr`, `numerodef`, `numfac`
  ont des utilisateurs externes (`ObjFac`, `ValidBR1`, `SaiReg`, `EcrReg`).

### Séparation traitement / GUI

- Les `Message.Error`/`Message.Info` d'`ecriture`, `ajout`, `solde`, `facnum` interrompent une
  transaction ouverte (et des tables verrouillées) en attendant l'utilisateur. Proposition : les
  fonctions de traitement renvoient un code et un texte d'erreur (`$erreur`), affichés par une
  fonction unique en fin d'`ecriture` ; même texte, mais **moment d'affichage différent** : à
  traiter comme anomalie (EcrAuto-A05) car l'ordre des dialogues change.
- `Impression`/`FinImp` (GUI pure) pourraient sortir dans une classe d'impression dédiée (hors
  périmètre du plan : préparation seulement).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les compteurs `numecriture`, `numecriture2`, `dnfac` de `Fiches_Parametres` sont consommés avant
  la validation : une table de séquences avec réservation/annulation éviterait les trous de
  numérotation (exigence de continuité de la numérotation des factures).
- `LOCK TABLES` (MySQL) valide implicitement la transaction en cours : `Begin`/`Commit` autour sont
  sans effet réel. Une transaction InnoDB avec `SELECT … FOR UPDATE` (ou des compteurs atomiques)
  remplacerait les verrous de table.
- Le solde de compte recalculé par `SUM` complet à chaque ligne : un solde incrémental (ou une vue)
  réduirait le coût sur les gros comptes.
- `Fiches_Traites` : colonne nommée `date` (mot réservé) ; à renommer lors d'une migration.
