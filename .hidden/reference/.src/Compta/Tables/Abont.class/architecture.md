# Abont — Architecture

> Source : `.src/Compta/Tables/Abont.class`

## Vue d'ensemble

Écran de création des **masques de saisie d'écritures** (« abonnements ») : un masque
(`Fiches_Numabon` : `numero` int clé, `intitule`, `type` `A` achat/vente ou `T` trésorerie, `typem`
format, toujours `"1"` = montant, `compteur` d'utilisation) et ses lignes (`Fiches_Ligabon` :
`compte`, `intitule`, `debit`/`credit` en `tinytext`, `lig`, `libelle`, `numDoc`, `numLot`, clé
`lind`). Les montants, libellés et numéros sont des **expressions** évaluées à l'utilisation par
`Saisecrit.LignAbt`/`Tresor.LignAbt` (variables `$montant`, `$annee4`, `$compteur`…, aide affichée
dans `TextArea1`).

Écran : liste des masques (`Colabt`), en-tête (numéro, libellé, type, compteur), saisie d'une ligne
(compte avec type Client/Fournisseur/Gestion/Bilan, montant, sens Débit/Crédit, libellé, n° de
document, n° de lot) et liste des lignes (`Colecr`, `lind` dans la colonne 5 de largeur 0).

Les lignes sont écrites **immédiatement** en base (`Button7_Click`), avant la validation du masque
(`Button3_Click`), qui réécrit l'en-tête et toutes les lignes.

Points d'entrée : `Fmenu.Menu198_Click` (`Abont.show()`) ; `Saisecrit.LignAbt` et
`Tresor.LignAbt` appellent `Abont.Compteur_Incr` sur l'**auto-instance** du formulaire.

Nature : **GUI** avec SQL dans les handlers ; `Compteur_Incr` est un pur traitement SQL.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 27 |
| `Dbl` | var | Private |  | String | 28 |
| `Type` | var | Private |  | String | 29 |
| `Type2` | var | Private |  | String | 30 |
| `b` | var | Private |  | String | 31 |
| `dnum` | var | Private |  | Integer | 32 |
| `Bsel` | var | Public |  | Boolean | 34 |
| `Bval` | var | Public |  | String | 35 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 37-82 | Public | 1 | 42 | 0 | méthode spéciale |
| `Cmpt_GotFocus` | 87-93 | Public | 1 | 5 | 0 | handler GUI |
| `Cmpt_Keypress` | 98-139 | Public | 12 | 35 | 0 | handler GUI |
| `ChkPrx` | 141-149 | Public | 7 | 7 | 0 | portée réductible ? |
| `Button4_Click` | 151-155 | Public | 1 | 3 | 0 | handler GUI |
| `FillColecr` | 159-182 | Public | 4 | 21 | 0 | portée réductible ? |
| `Colabt_Click` | 187-207 | Public | 5 | 18 | 0 | handler GUI |
| `Button2_Click` | 212-246 | Public | 6 | 32 | 0 | handler GUI |
| `button7_KeyPress` | 251-255 | Public | 4 | 3 | 0 | handler GUI |
| `Button7_Click` | 257-290 | Public | 4 | 29 | 0 | handler GUI |
| `Colecr_Activate` | 295-317 | Public | 16 | 18 | 0 | handler GUI |
| `Button3_Click` | 322-382 | Public | 12 | 58 | 0 | handler GUI |
| `Supprim_ligne` | 387-409 | Public | 4 | 21 | 0 | portée réductible ? |
| `Colecr_KeyPress` | 411-424 | Public | 6 | 11 | 0 | handler GUI |
| `Button5_Click` | 429-448 | Public | 3 | 17 | 0 | handler GUI |
| `Deb3` | 450-473 | Public | 5 | 21 | 0 | portée réductible ? |
| `Compteman` | 478-495 | Public | 3 | 15 | 0 | portée réductible ? |
| `Bclient_Click` | 497-512 | Public | 3 | 11 | 0 | handler GUI |
| `Bfournisseur_Click` | 514-529 | Public | 3 | 11 | 0 | handler GUI |
| `Bgestion_Click` | 531-546 | Public | 5 | 9 | 0 | handler GUI |
| `Bbilan_Click` | 548-563 | Public | 5 | 9 | 0 | handler GUI |
| `Button6_Click` | 568-580 | Public | 2 | 10 | 0 | handler GUI |
| `BA_Click` | 582-591 | Public | 5 | 8 | 0 | handler GUI |
| `BT_Click` | 593-602 | Public | 5 | 8 | 0 | handler GUI |
| `Button1_Click` | 607-611 | Public | 1 | 3 | 0 | handler GUI |
| `Intitule_KeyPress` | 613-617 | Public | 1 | 2 | 0 | handler GUI |
| `Compteur_Incr` | 619-623 | Public | 1 | 3 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et listes

- **`_New()`** [portée : nécessaire] [nature : mixte] : son, centrage, observateurs, colonnes de
  `Colabt` (4) et `Colecr` (9), format `"1- Montant"`, `type = "F"`, `type2 = "AC"`, `Deb3()`.
- **`Deb3()`** [portée : réductible] [nature : mixte] : `SELECT * FROM <TabNumabon>` (sans tri) →
  `Colabt` ; type affiché « Achat » ou « Trésorerie » ; `typem <> "1"` → `Message.Erreur(…)`, qui
  **n'existe pas** dans `Message` (erreur d'exécution, anomalie A01).
- **`FillColecr(codeabn)`** [portée : réductible] [nature : mixte] : `SELECT * FROM <TabLigabon>
  Where numero = &1 order by lig asc` → `Colecr` (vidée seulement s'il y a des lignes ; colonnes 2 à
  8 remplies seulement si le format est `"1- Montant"`).
- **`Colabt_Click()`** [handler] : relit le masque (`<TabNumabon> Where numero = &1`), remplit
  l'en-tête, `Message.Erreur` si `typem <> "1"`, puis `FillColecr`.

### Saisie d'une ligne

- **`Cmpt_GotFocus()`** [handler, groupe `Cmpt`] : `Utils.SetEditColor`.
- **`Cmpt_Keypress()`** (CC 12) [handler] : Entrée/Tab : libellé (tag 2) → compte ; compte (tag 3)
  → `Compteman()` puis montant si trouvé ; montant (tag 4) → bouton Enregistrer ligne. F5 :
  calculatrice `FCalc` (résultat formaté `0.00`) ; F2 sur le compte : `Button6_Click`.
- **`ChkPrx()`** [portée : réductible, **code mort**] : filtre de frappe numérique, appel commenté.
- **`Compteman()`** [portée : réductible] [nature : mixte] : `SELECT * FROM <TabComptes> WHERE
  compte_cc = &1 and coll <> &2 and type_cc = &3` (1, `type`) ; masque de trésorerie : en plus
  `comptr_cc = &4` (0). Trouvé → intitulé, `b = 0` ; sinon avertissement, `b = 1`.
- **`Button6_Click()`** [handler] : `New TriCpt(Type, TriCpt.Sans_Solde, Me)` modal ; si `Bsel`
  (écrit par `TriCpt` via `Object.SetProperty`), compte = `Bval` et `Compteman()`.
- **`Bclient_Click`, `Bfournisseur_Click`, `Bgestion_Click`, `Bbilan_Click`** [handlers] : fixent
  `Type` (`C`, `F`, `G`, `B`) et le sens par défaut (Débit/Crédit) selon le type de masque et
  `Type2` ; `Bgestion_Click` et `Bbilan_Click` sont identiques au type près.
- **`BA_Click` / `BT_Click`** [handlers] : `Type2` = `"AC"`/`"TR"`, rejouent le clic du type de
  compte coché, liste de formats réduite à `"1- Montant"`.
- **`button7_KeyPress()`** [handler] : Entrée/Tab → `Button7_Click`.
- **`Button7_Click()`** [nature : mixte] — **enregistre la ligne** : numéro de ligne =
  `Colecr.count + 1` ; si une ligne `(numero, lig)` existe déjà → UPDATE par `lind`, sinon INSERT
  (`debit`/`credit` = montant saisi et `LPrix(0).L`, soit `"0,00"`). Puis `FillColecr`. Code vide →
  `Message.Error`.
- **`Colecr_Activate()`** (CC 16, max du fichier) [handler] — **modifier une ligne** : recopie la
  ligne dans les zones, **supprime aussitôt la ligne en base** (`Supprim_ligne`), puis coche le type
  de compte selon le premier chiffre (1 à 5 → Bilan, 6-7 → Gestion, 411 → Client, 401 → Fournisseur).
  Si l'utilisateur abandonne, la ligne est perdue ; si il réenregistre, elle revient en dernière
  position. La locale `rResult` est inutilisée.
- **`Supprim_ligne(codeabon, lind)`** [portée : réductible] [nature : mixte] : `DELETE … where lind
  = &1`, suppression de l'item courant, **renumérotation** des lignes restantes (`UPdate … set lig =
  &2 where lind = &1`, une requête par ligne), puis `FillColecr(Code.Text)` (et non `codeabon`).
- **`Colecr_KeyPress()`** [handler] : Suppr + confirmation → `Supprim_ligne` ; Entrée → `Colecr_Activate`.
- **`Intitule_KeyPress()`** [handler] : vide (la zone `Intitule` est en lecture seule).

### Masque

- **`Button2_Click()`** [handler] — **Créer** : confirmation si des lignes sont affichées ;
  numéro = dernier `numero` + 1 (1 si la table est vide, via `Try`) ; zones vidées (sauf le libellé
  du masque), `Bfournisseur.Value = True`.
- **`Button3_Click()`** (CC 12) [handler] — **Valider** : type `A`/`T`, format ; `UPdate` ou
  `INSERT` de `<TabNumabon>` ; pour chaque ligne de `Colecr`, UPDATE par `lind` ou INSERT ; puis
  remise à zéro (`type = "A"`, puis `Bfournisseur_Click()` qui remet `F`), rechargement de `Colabt`
  et resélection. `sKey = Colabt.Current.Key` : erreur si le masque existe mais qu'aucune ligne de
  `Colabt` n'est sélectionnée.
- **`Button5_Click()`** [handler] — **Supprimer** : sans confirmation, `DELETE` du masque et de ses
  lignes ; remise à zéro avec `type = "A"` (type de compte inexistant : le contrôle de compte échoue
  ensuite tant qu'un type n'est pas recliqué).
- **`Button4_Click()`** : fermeture. **`Button1_Click()`** : `Doc.Open("Abonnements")`.

### Utilisé de l'extérieur

- **`Compteur_Incr(Numabon)`** [portée : nécessaire, `Saisecrit.LignAbt`, `Tresor.LignAbt`]
  [nature : calcul] : `UPdate <TabNumabon> set compteur = compteur + 1 where numero = &1`. Appelée sur
  l'**auto-instance** du formulaire : le premier appel crée une instance cachée d'`Abont` (`_New` :
  `Deb3`, `Utils.Observers`…).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.Bip`, `Cbase.Table` (`TabNumabon`,
  `TabLigabon`, `TabComptes`), `LPrix`, `FCalc.Resultat`, `TriCpt` ; `Start.Musique`.
- Membres : `Type`/`Type2` (types de compte et de masque), `b` (String utilisé comme entier),
  `dnum`, `Tri` et `Dbl` (affectés, jamais lus), `Bsel`/`Bval` (écrits par `TriCpt`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Reinit()` pour le bloc de remise à zéro dupliqué dans `Button3_Click` et `Button5_Click`.
- `Bgestion_Click` et `Bbilan_Click` → une procédure commune paramétrée par le type.
- `Colecr_Activate` : table de correspondance premier chiffre → type de compte (CC 16 → ≤ 5).

### Commonalisation avec d'autres fichiers

- `Compteur_Incr` relève d'un module de données des masques (avec la lecture des lignes faite par
  [Saisecrit](../../Saisecrit.class/architecture.md) et [Tresor](../../Tresor.class/architecture.md)
  dans `LignAbt`) : la sortir du formulaire évite l'instanciation cachée (voir A06).
- Sélection d'un compte par `TriCpt` + `Object.SetProperty` sur `Bsel`/`Bval` : même idiome que
  [FComptes](../FComptes.class/architecture.md) et [Lettrage](../../Lettrages/Lettrage.class/architecture.md).

### Réduction de portée

`ChkPrx` supprimée ; `FillColecr`, `Supprim_ligne`, `Deb3`, `Compteman` → `Private`.
`Compteur_Incr`, `Bsel`, `Bval` restent `Public`.

### Séparation traitement / GUI

`ProchainNumero() As Integer`, `EnregistreMasque(...)`, `SupprimeMasque(sCode)`,
`SupprimeLigne(sCode, iLind)` (DELETE + renumérotation) sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Ligabon.numero` est `varchar(15)` alors que `Fiches_Numabon.numero` est `int` : types à
  aligner, avec une clé étrangère et un index `(numero, lig)`.
- `debit`/`credit` en `tinytext` (expressions) : à documenter comme tel dans `db_control.csv`.
