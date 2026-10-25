# ValidBR1 — Architecture

> Source : `.src/Gestion/Stock/ValidBR1.class` · Formulaire : `.src/Gestion/Stock/ValidBR1.form`

## Vue d'ensemble

`ValidBR1` est l'écran **« Validation des réceptions »** (Gestion › Stock, `Fmenu.Menu232_Click`,
et bouton « Valider les réceptions » de [commande1](../commande1.class/architecture.md)) : il
valide les bons de réception fournisseurs (`Fiches_Entrecpt.validee`) et, au choix, génère
l'écriture comptable d'achat correspondante par [EcrAuto](../../../Compta/Utils/EcrAuto.class/architecture.md).
Il a remplacé [ValidBR](../ValidBR.class/architecture.md) en 2022 (commit `a06ada7a`, « mise en
place des tarifs par date et validation comptable »).

Écran :
- deux grilles `TriGen` : fournisseurs (`lesfour`, totaux par fournisseur) et BR du fournisseur
  courant (`lesbr`) ; un clic sur un fournisseur le sélectionne (toutes ses BR filtrées sont
  sélectionnées par défaut), un clic sur une BR la (dé)sélectionne, un double-clic ouvre la
  réception dans `commande1` ;
- filtre par radio : `br` (`validee = 0`), `brval` (0 ou 2), `Valid` (2) ;
- date (`datej`) et libellé (`libel`, variables `LVar`) de l'écriture ;
- « Validation Seule » (`clot`) → `validee = 2` ; « Validation + Compta » (`Clotc`) →
  `validee = 1` + écriture comptable (journal `Fiches_Parametres.jrnal5`), une écriture par
  fournisseur, impression cumulée `~/tmp/EcrBr.pdf` ; ensuite proposition de scan GED de la
  facture si `/Soc<XX>/Ged` et `fo_copie`.

L'écriture : par ligne de réception, débit du compte d'achat de la famille (`compt3_fam`) pour
`prvt × qte` (`Consigne`, sous-classe de `Calculdroit1` ← `LPrix`), TVA (`Fiches_Tvaac`) sauf
fournisseur exonéré, consignes (option `B`/`T`, compte `consfou`), crédit du compte fournisseur
pour le total.

**Module complexe** (validation comptable des achats) : la liste des scénarios de test est à faire
valider par l'utilisateur avant la phase 2.

Nature globale : **mixte** (`ValideSaisie` mêle `Edit` de la base, calcul de l'écriture et lecture
de `libel`/`datej`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 3 |
| `Bval` | var | Public |  | Variant | 4 |
| `$four` | var | Private |  | String | 6 |
| `$trfo` | var | Private |  | TriGen | 7 |
| `$trbr` | var | Private |  | TriGen | 8 |
| `$colfour` | var | Private |  | Collection | 9 |
| `$colbr` | var | Private |  | Collection | 10 |
| `$selfo` | var | Private |  | New Variant[] | 11 |
| `$listbr` | var | Private |  | New Collection | 12 |
| `$Apdf` | var | Private |  | Boolean | 13 |
| `$ht` | var | Private |  | Float | 14 |
| `$ttc` | var | Private |  | Float | 15 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 17-100 | Public | 1 | 69 | 0 | méthode spéciale |
| `TriFou_majsel` | 102-124 | Public | 2 | 20 | 0 | handler GUI |
| `TriFou_data` | 126-152 | Public | 6 | 24 | 0 | handler GUI |
| `TriBr_majsel` | 154-175 | Public | 3 | 19 | 0 | handler GUI |
| `TriBr_data` | 177-192 | Public | 6 | 14 | 0 | handler GUI |
| `TriBr_Activate` | 194-207 | Public | 2 | 11 | 0 | handler GUI |
| `selall` | 209-236 | Private | 7 | 24 | 0 |  |
| `Ecritures` | 239-274 | Public | 9 | 33 | 1 |  |
| `valide` | 276-316 | Private | 7 | 38 | 0 |  |
| `validefin` | 318-332 | Private | 2 | 12 | 0 |  |
| `scanged` | 334-368 | Private | 8 | 30 | 0 |  |
| `ValideSaisie` | 370-446 | Private | 15 | 72 | 0 |  |
| `ajouligne` | 448-492 | Private | 5 | 42 | 0 |  |
| `br_Click` | 494-505 | Public | 3 | 10 | 0 | handler GUI |
| `brval_Click` | 507-518 | Public | 3 | 10 | 0 | handler GUI |
| `Valid_Click` | 520-531 | Public | 3 | 10 | 0 | handler GUI |
| `clot_Click` | 533-537 | Public | 1 | 3 | 0 | handler GUI |
| `Clotc_Click` | 539-543 | Public | 1 | 3 | 0 | handler GUI |
| `quit_Click` | 545-549 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et sélection

- **`_new()`** [portée : nécessaire] [mixte]. Construit les deux `TriGen` (colonnes `ObjProp`,
  requêtes `SELECT … FROM Fiches_Entrecpt JOIN Fiches_Four`, `ExtraSel(validee = 0)`,
  `GroupBy`), centre les panneaux, prépare `libel` avec `LVar` (`ParseResult` d'un
  `SELECT * FROM Fiches_Comptes, Fiches_Entrecpt, Fiches_Four LIMIT 1`, produit cartésien
  servant à lister les champs). `Dim ch As Chainage` inutilisé. **Pas d'appel à
  `Utils.Observers`** : écran non instrumenté pour le log/replay (les `TriGen` incrustés dans des
  `Panel` ne l'appellent pas non plus).
- **`TriFou_majsel(Value)`** [handler d'événement `TriGen.MajSel`] [GUI]. Ajoute ou retire le
  fournisseur de `$selfo`, applique le filtre des BR (`selall`), `Stop Event` (la `TriGen` ne se
  ferme pas), remet `Bsel`/`Bval`. ⚠️ `Panel1.Enabled = False` (radios de filtre) n'est jamais
  rétabli : le filtre ne peut plus changer jusqu'à la fermeture.
- **`TriFou_data(id, key, Data)`** [handler] [GUI]. Surligne les fournisseurs sélectionnés et
  affiche la somme HT/TTC des BR retenues (`$listbr`). ⚠️ `Dim s As Float[]` reçoit des tableaux
  créés par `[montant, mttc, date]` (types mixtes → `Variant[]`) : conversion à confirmer en
  phase 2 (erreur de type possible).
- **`TriBr_majsel(value)`** [handler] [GUI]. (Dé)sélectionne une BR, clé = `numrecpt` seul
  (deux BR de même numéro à des dates différentes se confondent). `Dim i As Float` inutilisé.
- **`TriBr_data(id, key, Data)`** [handler] [GUI]. Surligne les BR sélectionnées et **réécrit**
  `$listbr[four][id][0|1]` avec le texte affiché (montant formaté).
- **`TriBr_Activate(Value)`** [handler] [GUI]. `New Commande1(Null, numrecpt, $four, date,
  etat)` : `Null` est le `Parent` (tous les paramètres de `commande1._new` sont optionnels),
  `etat = Validee` si radio `Valid`, sinon `Reception`.
- **`selall(Value)`** [Private] [mixte]. Filtre `ExtraSel` selon le radio, puis, au premier
  passage pour ce fournisseur, remplit `$listbr[Value]` avec **toutes** les BR filtrées
  (`GetAllFiltered`, `Repeat` sans test `Available`).
- **`br_Click` / `brval_Click` / `Valid_Click`** [handlers] [GUI]. Filtre des fournisseurs si
  aucun n'est sélectionné, sinon `Stop Event` (sans effet sur un `RadioButton`).

### Validation

- **`clot_Click` / `Clotc_Click`** [handlers] : `valide(False)` / `valide(True)`.
- **`valide(compta)`** [Private] [mixte]. `ProgBar` ; pour chaque fournisseur de `$selfo` :
  `ValideSaisie` pour chaque BR, puis (si compta) `New EcrAuto(jrnal5, vecr)`, `ecriture()`,
  impression cumulée ; `scanged` ; enfin `validefin`. ⚠️ `$selfo`/`$listbr` ne sont pas vidés
  après validation : une seconde validation retraite les mêmes BR (`ValideSaisie` ne filtre pas
  sur `validee`) → écritures en double (A03, à confirmer).
- **`validefin(pg, imp, ecr)`** [Private] [GUI]. Termine et affiche `~/tmp/EcrBr.pdf`,
  ferme la `ProgBar`, rafraîchit les grilles.
- **`ValideSaisie(dteecr, dtebon, num, four, vecr, compta, nump)`** (CC 15, max du fichier)
  [Private] [mixte]. `fo_exo`, `fo_copie` (→ `$Apdf`), `Utils.db.Edit("Fiches_Entrecpt", …)` ;
  cumule `$ht`/`$ttc` ; libellé (`LVar` : défaut « Réception n° … du … », `libel.Text`, puis
  `libel_def` du fournisseur prioritaire), tronqué à 50 ; si compta : en-tête `vecr` puis, par
  ligne `Fiches_Ligrecpt`, ligne d'achat (`lpx.TotNHT.G`, compte de famille), TVA
  (`LTaxe.Montant(lpx).PuBHT.G`, l. 419 : sensible à LTAXE-A01/LPRIX-A01, à corriger ensemble),
  consignes (option `B`/`T`) ; `validee = 1` (compta) ou `2` ; `Update`. Si la BR est absente,
  ne renvoie rien (`vecr` perdu pour l'appelant).
- **`ajouligne(vecr, montant, cpt)`** [Private] [calcul]. Ajoute ou cumule une ligne de compte
  (`VarEcr`), solde débit/crédit, total de contrepartie ; `Error.Raise` si le compte n'existe pas.
- **`Ecritures(dteecr, dtebon, num, four, m, ht, ttc)`** [portée : **nécessaire**,
  `commande1:733`] [mixte]. Validation d'**une** BR depuis `commande1` (« Valider les
  factures ») : `m = 1` sans compta, `m = 2` avec compta (autre valeur : sans compta).
  Appelée sur la **classe** (`ValidBR1.Ecritures`) : c'est l'auto-instance du formulaire qui est
  créée (`_new` exécuté, TriGen construits, fenêtre jamais affichée) ; `datej` et `libel` de
  cette instance cachée sont vides → libellé par défaut et date GED vide (A05, à confirmer).
  Bloc `If $Apdf And … Then Endif` vide.
- **`scanged(compta, Ecr, num, four, ht, ttc)`** [Private] [GUI]. Si GED active et `fo_copie` :
  question puis `New LGed(…)` (comptabilité ou fournisseurs), tags du fournisseur lus par
  `"… WHERE fo_code = " & four` (concaténation sans quotes, même défaut que OBJFAC-A05), tags,
  montants **inversés** (`TTC = LPrix(ht)`, `HT = LPrix(ttc)`, A02), date `datej`,
  `ShowModal`.
- **`quit_Click`** [handler] : `Me.Close`.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Ged"]`, `["/Soc<XX>/FactcheminC"]`, `Start.Societe`.
- `Utils.db` (`Exec`, `Edit`, `Subst`), `Utils.Option`, `Cbase.Table("TabFour")`.
- `Bsel`/`Bval` `Public` : écrits par `TriGen` (`Object.SetProperty`), doivent rester `Public`.
- Membres d'état de sélection `$selfo`, `$listbr`, `$four` ; cumuls `$ht`, `$ttc` ; `$Apdf`
  (dernier fournisseur lu).

## Propositions d'amélioration

### Réécriture / refactorisation

- `ValideSaisie` : séparer `ValideBR(four, num, date, valeur)` (mise à jour de `validee`) et
  `LignesEcriture(…) As VarEcr` (calcul) ; extraire `LibelleEcriture(…)`.
- `valide` et `Ecritures` partagent la séquence `EcrAuto` + impression + `scanged` : helper
  privé commun.

### Commonalisation avec d'autres fichiers

- Libellé d'écriture par `LVar` (New/AddDate/ParseResult/Evaluate) : helper
  [LVar](../../../Utils/LVar.class/architecture.md) `Calcule` (LVAR-004), aussi pour `Saisecrit`,
  `Tresor`, `EcrAuto`.
- Archivage/scan GED avec tags du fournisseur : séquence proche de `commande1.ged`, `ObjFac`,
  `Edbr` → [LGed](../../../Utils/LGed.class/architecture.md) (LGED-007).
- Génération d'écriture d'achat : l'ancien [ValidBR](../ValidBR.class/architecture.md) faisait le
  même travail par une table de travail `Totalisation` (code mort).

### Réduction de portée

- Rien à réduire : `Ecritures` est appelée par `commande1`, les autres fonctions `Public` sont des
  handlers (`TriFou_*`, `TriBr_*` sont des événements de `TriGen`).

### Séparation traitement / GUI

- `ValideSaisie` lit `libel.Text` et `datej.dte` : passer ces valeurs en paramètres (la valeur
  passée par `Ecritures` et `valide` restant identique à la lecture actuelle des contrôles).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `validee` (`0`/`1`/`2`) mériterait une énumération documentée ou une colonne « comptabilisée »
  distincte.
- Une table de liaison BR ↔ écriture comptable (`numecr`) éviterait les doubles validations.
