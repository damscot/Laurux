# LPrix — Architecture

> Source : `.src/Utils/LPrix.class`

## Vue d'ensemble

`LPrix` est l'**objet valeur « prix »** de Laurux : un montant unitaire flottant (`Mnt`) associé à une
quantité (`Qte`), à une règle d'arrondi (`Arrondi` + `Precision` dérivée), à un compte de ventilation
(`Compte`) et à une liste optionnelle de taxes et remises (`Taxe As LTaxe[]`, indexée par `LTaxe.Ttx`).

Il expose le montant **total** (`Mnt * Qte`) sous plusieurs formats via des propriétés :
`.L` (affichage Laurux, virgule), `.D` (base de données, point), `.G` (Float Gambas arrondi),
`.Q`/`.QD` (quantité). Il calcule aussi les déclinaisons **Brut/Net × HT/TTC**, en unitaire (`Pu*`)
et en total (`Tot*`), à partir des taxes rattachées (`Conv_Brut_Net_HT_TTC`).

La classe est déclarée `Create Static` et `Inherits Array`. L'appel `LPrix(…)` passe par `_call`
sur l'auto-instance statique et renvoie une nouvelle instance ; c'est la forme d'usage dominante
dans le projet (22 fichiers appelants). L'héritage d'`Array` et les surcharges `_get`/`_put`
ne sont utilisés nulle part (les collections de prix sont des `LPrix[]` natifs).

Nature globale : **calcul pur**, à deux exceptions près : `Message.Error` dans `Arrondi_Conv`
(couplage GUI) et l'événement `change`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Arr_1` | enum | Public | oui |  | 6 |
| `Arr_05` | enum | Public | oui |  | 6 |
| `Arr_01` | enum | Public | oui |  | 6 |
| `Arr_005` | enum | Public | oui |  | 6 |
| `Arr_001` | enum | Public | oui |  | 6 |
| `Arr_0005` | enum | Public | oui |  | 6 |
| `Arr_0001` | enum | Public | oui |  | 6 |
| `Arr_00005` | enum | Public | oui |  | 6 |
| `Arr_00001` | enum | Public | oui |  | 6 |
| `Brut_to_Brut` | enum | Public | oui |  | 7 |
| `Net_to_Net` | enum | Public | oui |  | 7 |
| `Brut_to_Net` | enum | Public | oui |  | 7 |
| `Net_to_Brut` | enum | Public | oui |  | 7 |
| `HT_to_HT` | enum | Public | oui |  | 8 |
| `TTC_to_TTC` | enum | Public | oui |  | 8 |
| `HT_to_TTC` | enum | Public | oui |  | 8 |
| `TTC_to_HT` | enum | Public | oui |  | 8 |
| `Mnt` | var | Public |  | Float | 10 |
| `Qte` | var | Public |  | Float | 11 |
| `Taxe` | var | Private |  | LTaxe[] | 13 |
| `Compte` | var | Private |  | String | 14 |
| `Precision` | var | Private |  | Integer | 15 |
| `Arrondi` | var | Private |  | Integer | 16 |
| `L` | property | Public |  | String | 18 |
| `G` | property | Public |  | Float | 19 |
| `D` | property | Public |  | String | 20 |
| `Cpt` | property | Public |  | String | 21 |
| `Q` | property | Public |  | String | 23 |
| `QD` | property | Public |  | String | 24 |
| `Arr` | property | Public |  | Variant | 26 |
| `PuBHT` | property | Public |  | LPrix | 28 |
| `PuBTC` | property | Public |  | LPrix | 29 |
| `PuNHT` | property | Public |  | LPrix | 30 |
| `PuNTC` | property | Public |  | LPrix | 31 |
| `TotBHT` | property | Public |  | LPrix | 33 |
| `TotBTC` | property | Public |  | LPrix | 34 |
| `TotNHT` | property | Public |  | LPrix | 35 |
| `TotNTC` | property | Public |  | LPrix | 36 |
| `change` | event | Public |  |  | 38 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 44-74 | Public | 7 | 27 | 0 | méthode spéciale |
| `_call` | 76-83 | Public | 1 | 5 | 14 | méthode spéciale |
| `_put` | 85-92 | Public | 2 | 6 | 0 | méthode spéciale |
| `_get` | 94-102 | Public | 2 | 7 | 0 | méthode spéciale |
| `Precision_Calc` | 108-112 | Private | 1 | 3 | 0 |  |
| `Arrondi_Conv` | 114-162 | Private | 17 | 45 | 0 |  |
| `Arrondi_Calc` | 164-198 | Private | 7 | 29 | 0 |  |
| `L_Read` | 205-209 | Private | 1 | 3 | 0 |  |
| `L_Write` | 211-226 | Private | 3 | 14 | 0 |  |
| `D_Read` | 228-242 | Private | 2 | 13 | 0 |  |
| `D_Write` | 244-253 | Private | 2 | 8 | 0 |  |
| `G_Read` | 255-259 | Private | 1 | 3 | 0 |  |
| `G_Write` | 261-270 | Private | 2 | 8 | 0 |  |
| `Cpt_Read` | 272-276 | Private | 1 | 3 | 0 |  |
| `Cpt_Write` | 278-287 | Private | 1 | 4 | 0 |  |
| `Q_Read` | 289-294 | Private | 1 | 3 | 0 |  |
| `Q_Write` | 297-302 | Private | 1 | 4 | 0 |  |
| `QD_Read` | 304-318 | Private | 2 | 13 | 0 |  |
| `QD_Write` | 320-325 | Private | 1 | 4 | 0 |  |
| `Arr_Write` | 327-333 | Private | 1 | 5 | 0 |  |
| `Arr_Read` | 335-356 | Private | 8 | 20 | 0 |  |
| `PuBHT_Write` | 360-365 | Private | 1 | 4 | 0 |  |
| `PuBHT_Read` | 367-371 | Private | 1 | 3 | 0 |  |
| `PuBTC_Write` | 373-382 | Private | 1 | 6 | 0 |  |
| `PuBTC_Read` | 384-392 | Private | 1 | 5 | 0 |  |
| `PuNHT_Write` | 394-403 | Private | 1 | 6 | 0 |  |
| `PuNHT_Read` | 405-413 | Private | 1 | 5 | 0 |  |
| `PuNTC_Write` | 415-424 | Private | 1 | 6 | 0 |  |
| `PuNTC_Read` | 426-434 | Private | 1 | 5 | 0 |  |
| `TotBHT_Write` | 439-444 | Private | 1 | 4 | 0 |  |
| `TotBHT_Read` | 446-450 | Private | 1 | 3 | 0 |  |
| `TotBTC_Write` | 452-461 | Private | 1 | 6 | 0 |  |
| `TotBTC_Read` | 463-471 | Private | 1 | 5 | 0 |  |
| `TotNHT_Write` | 473-482 | Private | 1 | 6 | 0 |  |
| `TotNHT_Read` | 484-492 | Private | 1 | 5 | 0 |  |
| `TotNTC_Write` | 494-503 | Private | 1 | 6 | 0 |  |
| `TotNTC_Read` | 505-513 | Private | 1 | 5 | 0 |  |
| `Conv_Brut_Net_HT_TTC` | 520-575 | Public | 21 | 48 | 0 | portée réductible ? |
| `Arrondi_New` | 577-589 | Public | 1 | 8 | 0 | portée réductible ? |
| `Add` | 591-596 | Public | 1 | 4 | 4 |  |
| `AddA` | 598-603 | Public | 1 | 4 | 0 | portée réductible ? |
| `Sub` | 605-610 | Public | 1 | 4 | 3 |  |
| `SubA` | 612-617 | Public | 1 | 4 | 0 | portée réductible ? |
| `Sum` | 619-628 | Public | 2 | 7 | 0 | portée réductible ? |
| `SumA` | 630-639 | Public | 2 | 7 | 0 | portée réductible ? |
| `Add_Taxe` | 641-651 | Public | 2 | 8 | 6 |  |
| `Del_Taxe` | 653-666 | Public | 3 | 11 | 0 | portée réductible ? |
| `Abs` | 669-673 | Public | 1 | 3 | 2 |  |
| `Lit_Taxe` | 675-681 | Public | 3 | 5 | 0 | portée réductible ? |
| `Internal_Test` | 685-781 | Public | 5 | 71 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Méthodes spéciales

- **`_New(Montant, Quantite, Arr, Cpt)`** [portée : nécessaire] [nature : calcul].
  Convertit `Montant` et `Quantite` (String via `Utils.FloatParse`, Float, ou autre via `CFloat`) ;
  une valeur fausse (0, "", Null) donne 0. Fixe ensuite `Cpt`, `Arrondi` et `Precision`.
  ⚠️ Ligne 63 : teste `TypeOf(Montant)` au lieu de `TypeOf(Quantite)`. Effet nul en pratique,
  car `CFloat` donne le même résultat.
- **`_call(...)`** [portée : nécessaire] [nature : calcul]. Fabrique `New LPrix(Montant, Qte, Arr, Cpt)`.
  ⚠️ **Anomalie** ligne 80 : passe `Qte`, le membre de l'auto-instance statique (1 par défaut, sauf
  modification), au lieu du paramètre `Quantite`. `LPrix(x, n)` ignore donc `n`. Appelant touché :
  `LTaxe.Montant` (`LTaxe.class:137`), et par lui tous les calculs de taxes sur quantité ≠ 1.
- **`_put(value, i)` / `_get(i)`** [portée : nécessaire (spéciale)] [nature : calcul] — **code mort**
  (aucun usage de `LPrix` comme tableau). Bornes erronées : `_get` exclut le dernier élément
  (`Max > i`) ; `_put` provoque un dépassement d'indice si `Count = i`.

### Arrondi (privé)

- **`Precision_Calc(arrond)`** : `Fix(Floor(-arrond/2))`. Transforme l'énumération `Arr_*` en nombre
  de décimales négatif (Arr_001 → -2).
- **`Arrondi_Conv(arrond)`** (CC 17) : accepte une énumération entière, un Float ou une String
  (`"0,05"`) et renvoie l'énumération `Arr_*`. Le `Select Case` compare des Float par égalité
  stricte (0.0001, 0.005…), ce qui est fragile. Erreurs : `Message.Error` puis repli sur `Arr_001`.
  [nature : mixte, la partie GUI se réduit au `Message.Error`]
- **`Arrondi_Calc(Mnt, larr, lprec)`** : arrondi « au 5 » pour les énumérations impaires (Arr_005,
  Arr_05…). Le montant est découpé en chaîne (`Split(mnt, ".")`) puis le dernier chiffre est
  inspecté (`[34567]` → 5, `[012]` → 0, sinon on monte d'un cran). Pour les énumérations paires,
  rien n'est fait : la `Precision` tronque à l'affichage. Cette conversion Float → String est
  fragile pour les très petits montants (notation exponentielle).

### Propriétés de format

| Propriété | Lecture | Écriture |
|---|---|---|
| `L` | total arrondi, format `0.00` localisé | `Mnt = FloatParse(v) / Qte` (0 si `Qte = 0`) |
| `D` | total arrondi, séparateur `.` forcé | idem, sans test de Null |
| `G` | total arrondi en Float | `Mnt = v / Qte` |
| `Q` | `Qte` arrondie à 4 décimales | `Qte = FloatParse(v)` |
| `QD` | `Qte` avec `.`, 4 décimales | ⚠️ **écrit `Mnt`** au lieu de `Qte` (anomalie) |
| `Cpt` | `Compte` | `Compte = v` (le contrôle 707/607 est commenté) |
| `Arr` | libellé `"0,01"`… | `Arrondi_Conv` + `Precision_Calc` |

⚠️ `Arr_Read` ne gère ni `Arr_00005` ni `Arr_00001` et renvoie alors `""`. Toute copie d'un prix
qui a cet arrondi (`New LPrix(…, Me.Arr, …)`) déclenche `Message.Error` dans `Arrondi_Conv("")`.
⚠️ `QD_Read` teste `Precision < 0` (précision du **montant**) pour formater la **quantité**, et la
variable `$qte` est inutilisée.

### Propriétés Brut/Net × HT/TTC (privé)

Huit propriétés en lecture/écriture (`PuBHT`, `PuBTC`, `PuNHT`, `PuNTC`, `TotBHT`, `TotBTC`,
`TotNHT`, `TotNTC`). Chacune délègue à `Conv_Brut_Net_HT_TTC` avec une quantité (1 ou `Qte`) et
deux sens de conversion, puis recopie `$out.Mnt` dans `Me.Mnt`. Les 14 accesseurs suivent le même
schéma : forte duplication. `TotBHT_Write` divise par `Qte` sans protéger le cas `Qte = 0`.

### Méthodes publiques

- **`Conv_Brut_Net_HT_TTC(prix, Qte, Conv_Brut_Net, Conv_HT_TTC, ignore_taxe)`** (CC 21, max du
  fichier) [portée : réductible, usage interne et tests seulement] [nature : calcul]. Applique
  successivement : retrait des taxes (TTC→HT), puis ajout ou retrait des remises (`LTaxe.All_Remises`),
  puis ajout des taxes (HT→TTC), en sautant les types de `ignore_taxe`. Les trois boucles `For Each`
  sont quasi identiques (filtre `ignore_taxe` dupliqué trois fois).
- **`Arrondi_New(prix, larr)`** [portée : réductible] : copie de `prix` avec la quantité de `Me`
  et un arrondi appliqué au Float.
- **`Add`/`AddA`/`Sub`/`SubA`/`Sum`/`SumA`** : cumulent `±Alp.Mnt * Alp.Qte` (variantes
  `*A` : `Alp.G`, c'est-à-dire la valeur arrondie de l'élément). `Add`, `Sub` et `Abs` sont utilisés
  par `Saisecrit`. `AddA`, `SubA`, `Sum` et `SumA` ne sont utilisés qu'en interne ou dans
  `Internal_Test` [portée : réductible ou code mort].
- **`Add_Taxe`/`Del_Taxe`/`Lit_Taxe`** : gèrent le tableau `Taxe` (taille `LTaxe.TxLast`, un slot
  par type). `Add_Taxe` est utilisé par `calculdroit1`, `TarTypeCli` et `VarMajTar`.
- **`Abs()`** : valeur absolue de `Mnt` ; ⚠️ ne lève pas `change`, contrairement aux autres mutateurs.
- **`Internal_Test`** : affiche des valeurs (`Print`) **sans aucune assertion** (`err` n'est jamais
  incrémenté). À convertir en gb.test (phase 2).

## État global utilisé

- `Utils.FloatParse` (lecture des chaînes « 1 234,56 » / « -3.15 »).
- `LTaxe.All_Taxes`, `LTaxe.All_Remises`, `LTaxe.TxLast` (listes statiques de `LTaxe`).
- Auto-instance statique de `LPrix` (via `Create Static`) : son `Qte` fuit dans `_call` (anomalie).
- `Mnt` et `Qte` sont `Public` et modifiables sans lever `change`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les 14 accesseurs `Pu*`/`Tot*` autour d'un helper privé
  `Conv(prix, qte, sens_bn, sens_ht) As LPrix`.
- Factoriser les trois boucles de `Conv_Brut_Net_HT_TTC` : un itérateur privé `TaxesActives(liste,
  ignore_taxe)` qui renvoie les `LTaxe` filtrées, puis trois boucles d'une ligne.
- Factoriser `Add`/`AddA`/`Sub`/`SubA`/`Sum`/`SumA` en `Cumul(alp, signe, avec_arrondi)`.
- Remplacer le `Select Case` Float d'`Arrondi_Conv` par une table de correspondance (tableau
  `[0.0001, 0.0005, …]` indexé par l'énumération, comparaison avec tolérance) ; la même table
  servirait à `Arr_Read` et corrigerait les cas manquants.
- `Arrondi_Calc` : calculer la décimale par arithmétique entière (`Round(Mnt * 10^n)`) plutôt que
  par découpage de chaîne.

### Commonalisation avec d'autres fichiers

- [`LTaxe`](../LTaxe.class/architecture.md) duplique l'idiome du constructeur (Variant → Float via
  `FloatParse`/`CFloat`) et `Inherits Array` / `Create Static`. Un helper commun
  `Utils.VariantToFloat(v)` servirait aux deux classes.
- `D_Read`/`QD_Read` réimplémentent un formatage avec séparateur décimal point. À comparer avec
  `Utils.cpoint` (859 usages) pour un formatage DB unique.

### Réduction de portée

- `Conv_Brut_Net_HT_TTC`, `Arrondi_New`, `AddA`, `SubA`, `Sum`, `SumA`, `Del_Taxe`, `Lit_Taxe` :
  aucun appelant externe. Ils passent en `Private` si les tests gb.test les couvrent via les
  propriétés `Pu*`/`Tot*` (règle de portée de PLAN.md §6).
- `Mnt`/`Qte` : variables `Public` utilisées directement par `Achat`, `GesTar`, `LTaxe` et
  `commande1`. On les conserve, ou on les convertit en `Property` pour lever `change`
  (changement de comportement observable, donc hors rework autonome).

### Séparation traitement / GUI

- Seul couplage : `Message.Error` dans `Arrondi_Conv`. Proposition : isoler la conversion dans une
  fonction pure qui renvoie `-1` en cas d'erreur, l'appelant gardant le `Message.Error` (même
  comportement visible).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : `LPrix` n'accède pas à la base. Les montants sont stockés en base sous forme textuelle
  `.D` ; un passage en `DECIMAL(15,4)` uniformisé simplifierait `D_Read`.
