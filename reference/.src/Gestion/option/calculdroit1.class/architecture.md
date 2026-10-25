# calculdroit1 — Architecture

> Source : `.src/Gestion/option/calculdroit1.class`

## Vue d'ensemble

`calculdroit1` est la **seconde version du calcul des droits sur les alcools** (option
« boissons »), construite sur l'objet prix [`LPrix`](../../../Utils/LPrix.class/architecture.md)
dont elle hérite (`Inherits LPrix`) : un objet `calculdroit1` est un prix unitaire (`Mnt`) ×
quantité (`Qte`) auquel `LecDra` rattache des taxes [`LTaxe`](../../../Utils/LTaxe.class/architecture.md)
de type `Regie` (droit), `SS` (cotisation sécurité sociale), `DA` (droits d'accise facturés) et
`TVA`. La classe sert de base à [`Consigne`](../Consigne.class/architecture.md) et est utilisée
directement par `Moulinage` (caisse) et `Achat` (réception, via `Consigne`).

L'ancienne version [`calculdroit`](../calculdroit.class/architecture.md) (calcul en `Float` sur la
quantité totale, 14 fichiers appelants) coexiste : voir « Duplication avec `calculdroit` ».

Règle métier telle que le code l'applique (paramétrage dans `Fiches_regie`, géré par
[`Tregie`](../Tregie.class/architecture.md)) :

- un article porte un code de régie (`art_dra`), un volume en cl (`art_volm`) et un degré
  (`art_deg`) ; la régie fixe `tauxa` (droit, en € par hl, d'où `/100` pour un litre), `tauxss`
  (cotisation sécurité sociale), `degres` (seuil de degré au-delà duquel la cotisation s'applique),
  `ap` (assiette en alcool pur plutôt qu'en volume), `suspendu` (droits en suspension), `drfac`
  (droits d'accise payés mais différenciés sur la facture), `ttva` (code TVA), `cdcompt` (compte) ;
- **volume** (`volume_total`) : brut = `vol / 100` litres par unité ; net = brut × degré %
  (remise de `100 − deg` %) = litres d'alcool pur ;
- **droit** (`taxe_droit`) = volume unitaire (net si `ap`, brut sinon) × `tauxa / 100` ;
- **sécurité sociale** (`secu_droit`) = même assiette × `tauxss / 100`, seulement si
  `degres` est renseigné et `deg > degres` ;
- **accise différenciée** (`accise_droit`) = droit, si `drfac` ;
- en régime **suspendu**, droit et sécu sont ajoutés comme taxes du prix ; la TVA de la régie
  s'applique au prix ; la TVA de la sécu est `Fiches_Parametres.tvass`.

Les montants sont **unitaires** (une unité de l'article) : les totaux s'obtiennent par les
propriétés `Tot*` de `LPrix` (× `Qte`).

Nature globale : **calcul + SQL** ; aucune GUI (erreurs par `Error.Raise`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$resdr` | var | Private |  | Result | 5 |
| `$restva` | var | Private |  | Result | 6 |
| `$respar` | var | Private |  | Result | 7 |
| `$vol` | var | Private |  | Float | 8 |
| `$deg` | var | Private |  | Float | 9 |
| `opt` | var | Public |  | Boolean | 11 |
| `famille` | var | Public |  | String | 12 |
| `droit` | property | Public |  | LPrix | 14 |
| `secu` | property | Public |  | LPrix | 15 |
| `accise` | property | Public |  | LPrix | 16 |
| `suspendu` | property | Public |  | Boolean | 17 |
| `drsurfac` | property | Public |  | Boolean | 18 |
| `code` | property | Public |  | String | 20 |
| `volume` | property | Public |  | Float | 21 |
| `degre` | property | Public |  | Float | 22 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 25-36 | Public | 4 | 9 | 0 | méthode spéciale |
| `LecDra` | 38-70 | Private | 7 | 30 | 0 |  |
| `volume_total` | 72-82 | Public | 1 | 8 | 1 |  |
| `taxe_droit` | 84-97 | Public | 3 | 11 | 0 | portée réductible ? |
| `secu_droit` | 99-114 | Public | 6 | 13 | 1 |  |
| `accise_droit` | 116-125 | Public | 3 | 7 | 1 |  |
| `droit_Read` | 127-140 | Private | 2 | 11 | 0 |  |
| `secu_Read` | 142-155 | Private | 2 | 11 | 0 |  |
| `accise_Read` | 158-171 | Private | 2 | 11 | 0 |  |
| `suspendu_Read` | 173-181 | Private | 4 | 7 | 0 |  |
| `drsurfac_Read` | 183-191 | Private | 4 | 7 | 0 |  |
| `code_Read` | 193-200 | Private | 4 | 6 | 0 |  |
| `code_Write` | 202-207 | Private | 2 | 4 | 0 |  |
| `volume_Read` | 209-213 | Private | 1 | 3 | 0 |  |
| `volume_Write` | 215-221 | Private | 2 | 5 | 0 |  |
| `degre_Read` | 223-227 | Private | 1 | 3 | 0 |  |
| `degre_Write` | 229-235 | Private | 2 | 5 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et lecture de la régie

- **`_new(Optional dra, vol, deg, fam)`** [portée : nécessaire] [nature : calcul]. Les 4
  paramètres de `LPrix._New` sont consommés avant. Mémorise `famille`, `$vol`, `$deg` ; lit
  `Utils.Option()` puis ⚠️ **ligne 33** `If op <> "T" And opt <> "B" Then opt = True` : la seconde
  comparaison porte sur le membre `opt` (Boolean `False`) au lieu de la variable `op`. Vérifié avec
  `gbs3` : `False <> "B"` vaut `True`, donc `opt` passe à `True` pour **toute option autre que
  `T`**, y compris `B` (boissons seules) : les droits ne sont calculés qu'en option `T`
  (CALCULDROIT1-A01). Appelle `LecDra(dra)` si `dra` est renseigné.
- **`LecDra(dra)`** (privée) [nature : calcul]. Sort si `opt`. `SELECT * FROM Fiches_regie WHERE
  code = &1` ; `SELECT * FROM Fiches_Tvaav WHERE code_tva = &1` (TVA de la régie) ;
  `SELECT taux_tva FROM Fiches_Parametres, Fiches_Tvaav WHERE code_tva = tvass` (TVA sécu).
  Erreurs : `Error.Raise` si TVA de régie absente (l. 47), TVA sécu absente (l. 51) ou régie
  absente (l. 54). ⚠️ Lignes 51 et 54 : `Error.Raise(msg, "OK")` à **deux** arguments ; vérifié avec
  `gbs3` : l'erreur levée est « Too many arguments » et non le message prévu (CALCULDROIT1-A02).
  Puis `Me.Cpt = cdcompt`, ajout des taxes `Regie` et `SS` si `suspendu`, `DA` si `Me.accise` n'est
  pas `Null` (toujours, hors `opt`), `TVA` de la régie. Les taxes déjà présentes du même type sont
  remplacées (`LPrix.Add_Taxe`). Effet de bord : `$resdr`, `$restva`, `$respar`.

### Calculs Public

- **`volume_total() As LPrix`** [portée : nécessaire, `Achat.class:967-970`, `:1220`] [nature : calcul].
  `New LPrix($vol / 100, Me.Qte, Arr_0001)` + `LTaxe(100 − deg %, Remise)` : `PuBHT` = litres par
  unité, `PuNHT` = litres d'alcool pur, `Tot*` × quantité. ⚠️ `Achat.EnrRec` (`Achat.class:967`)
  multiplie encore `TotBHT` par la quantité (`volume` = vol × qte², à confirmer, à reporter dans
  Achat) alors que `volumeap` utilise `TotNHT` sans le refaire.
- **`taxe_droit() As LTaxe`** [portée : réductible (aucun appel externe, vérifié par `grep`)]
  [nature : calcul]. `LTaxe(0, Regie)` si `opt` ; sinon `PuNHT` (si `ap`) ou `PuBHT` de
  `volume_total` × `tauxa / 100`. ⚠️ Accède à `$resdr!ap` sans test : erreur si aucune régie lue
  (`dra` vide).
- **`secu_droit() As LTaxe`** [portée : nécessaire, `Achat.class:970`] [nature : calcul]. Même
  assiette × `tauxss / 100` si `degres` non nul et `$deg > degres` ; sinon 0.
- **`accise_droit() As LTaxe`** [portée : nécessaire, `Moulinage.class:2804`] [nature : calcul].
  `LTaxe(droit, DA)` si `drfac`, sinon 0. `Moulinage` retire ce montant du prix TTC de caisse
  avant de recréer l'objet (`Moulinage.class:2803-2804`).

### Propriétés

- **`droit`** (`droit_Read`) [portée : aucun lecteur externe ni interne (vérifié par `grep` sur
  les variables typées `calculdroit1`/`Consigne`) : candidat code mort] [nature : calcul]. `Null` si `opt` ; sinon `LPrix(Mnt, Qte, Arr_0001)` + taxe **`DA`** du droit +
  TVA de la régie. Le type `DA` (et non `Regie`) est à confirmer.
- **`secu`** (`secu_Read`) [portée : aucun lecteur trouvé, candidat code mort] : `LPrix(Mnt, Qte)`
  + taxe `SS` + TVA sécu (`$respar`).
- **`accise`** (`accise_Read`) : `LPrix(Mnt, Qte)` + `LTaxe(accise)` **sans type** (type
  `LTaxe.Aucune` par défaut) + TVA de la régie. Utilisée par `LecDra` comme booléen (`If
  Me.accise`).
- **`suspendu`**, **`drsurfac`** (`*_Read`) : colonnes `suspendu`/`drfac` de la régie, `False` si
  aucune régie lue. `drsurfac` lu par `Moulinage` (`:2804`, `:2812`, `:2825`, `:2838`).
- **`code`** (`code_Read`/`code_Write`) [portée : nécessaire, `Achat.class:958`, `:965`, `:617`,
  `:217` via `AutresObj`]. Lecture : `Null` si `opt` ou pas de régie. Écriture : `LecDra(Value)` (relit la
  régie et recalcule les taxes), ignorée si `opt`.
- **`volume`**, **`degre`** (`*_Read`/`*_Write`) [portée : nécessaire, `Achat.class:216`, `:218`,
  `:968`]. Écriture : met à jour `$vol`/`$deg` puis `LecDra($resdr!code)`. ⚠️ Si aucune régie n'a
  été lue (`$resdr` `Null`, article sans `art_dra`), l'écriture lève « Null object » ; c'est le cas
  dans `Achat` (`Achat.class:216`) quand l'objet de la ligne a été créé pour un article sans régie
  puis réutilisé (à confirmer en replay, CALCULDROIT1-A03).
- **`opt`**, **`famille`** (membres `Public`). `opt` lu par `Moulinage` (`:2812`, `:2825`, `:2838`,
  `:2860`) et par `Consigne`. `famille` n'est lu nulle part (réductible, mais c'est une variable :
  conserver ou supprimer avec le paramètre `fam`, voir rework).

## État global utilisé

- `Utils.Option()` (lit `Start.LocalSettings["/Soc<XX>/bois"]` et `["/Soc<XX>/pp"]`).
- `Utils.db.Exec`.
- Tables : `Fiches_regie` (créée par `modfichier.fichierboisson`, absente de `db_control.csv`),
  `Fiches_Tvaav`, `Fiches_Parametres` (colonne `tvass` ajoutée par `modfichier`). Noms en dur
  (clés `Cbase` disponibles : `TabTvav`, `TabParam`).

## Duplication avec `calculdroit`

Mesure : après normalisation (indentation, lignes vides, `End`/`Endif`/`Else`), `calculdroit`
compte 126 lignes significatives et `calculdroit1` 135 ; **7 lignes seulement sont communes**
(déclarations `suspendu`/`drsurfac`/`code`, `$vol`). La duplication est **sémantique et non
textuelle** :

| Élément | `calculdroit` | `calculdroit1` |
|---|---|---|
| Lecture régie + TVA régie + TVA sécu | 3 `SELECT` identiques dans `_new` | mêmes 3 `SELECT` dans `LecDra` |
| Assiette | quantité totale × vol × deg | volume unitaire (`LPrix` + remise) |
| Droit, sécu | `Float` total arrondi à 2 décimales | `LTaxe` unitaire, totaux par `LPrix.Tot*` |
| Seuil `degres`, `ap`, `drfac`, `suspendu` | même règle | même règle |
| Erreurs | `Message.Error` (GUI) | `Error.Raise` |
| Option boissons | non testée | drapeau `opt` (bogué, A01) |

Une commonalisation crédible porte sur la **lecture de la régie** (fonction `Static` renvoyant les
trois `Result` ou une structure) et sur la **formule d'assiette** ; la fusion des deux classes
changerait les arrondis (2 décimales par total contre 4 décimales unitaires) et n'est pas
proposée sans tests d'équivalence.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : remplacer `opt <> "B"` par `op <> "B"` est une **anomalie** (changement de comportement,
  A01), pas un rework.
- `LecDra` : `Cbase.Table("TabTvav")`, `Cbase.Table("TabParam")` (SQL identique).

### Commonalisation avec d'autres fichiers

- Lecture régie/TVA commune avec [`calculdroit`](../calculdroit.class/architecture.md) (`_new`) et
  [`Tregie`](../Tregie.class/architecture.md) (`verifie` relit `Fiches_Tvaav`).
- Cascade `LPrix` + liste de `LTaxe` : même construction dans `GesTar`, `DateTar`, `VarMajTar`,
  `TarTypeCli`, `Achat` (voir [Achat](../../Entrées/Achat.class/architecture.md)).
- `droit_Read`, `secu_Read`, `accise_Read` : même squelette (prix + taxe + TVA) → helper privé.

### Réduction de portée

`taxe_droit` → `Private` (aucun appelant externe ; couvert par `droit`, `secu_droit`,
`accise_droit` et les tests T03-T05). `famille` (variable) : suppression possible (jamais lue).

### Séparation traitement / GUI

Sans objet (aucun accès GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_regie`, `Fiches_ligregie` et les colonnes `art_dra`, `art_volm`, `art_deg`,
  `art_montdr`, `art_montss`, `Fiches_Parametres.tvass` dans `db_control.csv` et les bases de
  référence.
- `cdcompt integer` alors que les comptes sont des `varchar` ailleurs : aligner le type.
- Stocker le taux de TVA de la sécu dans `Fiches_regie` plutôt que dans `Fiches_Parametres`.
