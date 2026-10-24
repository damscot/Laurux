# LTaxe — Architecture

> Source : `.src/Utils/LTaxe.class`

## Vue d'ensemble

`LTaxe` est l'**objet valeur « taxe ou remise »** associé à [`LPrix`](../LPrix.class/architecture.md).
Une instance porte un montant (`Mnt`), fixe ou en pourcentage (`Pct`), un type (`TypeTaxe`, énumération
`Aucune … Marge, TxLast`), un compte de ventilation (`Compte`) et un libellé (`Libelle`).

Deux listes `Public` classent les types :
- `All_Taxes` : taxes appliquées entre le HT net et le TTC net (TVA, TEE, TEA, CopiePrivee, CSS, Fixe,
  Consigne, Deconsigne) ;
- `All_Remises` : remises ou frais appliqués entre le HT brut et le HT net (Remise, Frais, SS, DA,
  Regie, Marge).

`LPrix` range ses `LTaxe` dans un tableau indexé par `Ttx` (taille `TxLast`) et appelle
`LTaxe.Montant` dans `Conv_Brut_Net_HT_TTC` pour calculer chaque taxe.

La classe est `Create Static` et `Inherits Array`, comme `LPrix`. L'héritage d'`Array` n'est
utilisé nulle part. L'usage dominant est `New LTaxe(montant, LTaxe.<type>[, compte])` (calculdroit1,
GesTar, Achat, TarTypeCli, Consigne, ValidBR1, LPrix.Internal_Test).

Nature globale : **calcul pur**, avec deux `Message.Error` (couplage GUI) dans `Cpt_Write` et
`Ttx_Write`. Aucun accès à la base.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Mnt` | var | Private |  | Float | 6 |
| `Pct` | var | Private |  | Boolean | 7 |
| `Libelle` | var | Private |  | String | 8 |
| `TypeTaxe` | var | Private |  | Integer | 9 |
| `Compte` | var | Private |  | String | 11 |
| `Aucune` | enum | Public | oui |  | 13 |
| `Remise` | enum | Public | oui |  | 13 |
| `TVA` | enum | Public | oui |  | 13 |
| `TEE` | enum | Public | oui |  | 13 |
| `TEA` | enum | Public | oui |  | 13 |
| `CopiePrivee` | enum | Public | oui |  | 13 |
| `CSS` | enum | Public | oui |  | 13 |
| `Fixe` | enum | Public | oui |  | 13 |
| `Frais` | enum | Public | oui |  | 13 |
| `SS` | enum | Public | oui |  | 13 |
| `DA` | enum | Public | oui |  | 13 |
| `Regie` | enum | Public | oui |  | 13 |
| `Consigne` | enum | Public | oui |  | 13 |
| `Deconsigne` | enum | Public | oui |  | 13 |
| `Marge` | enum | Public | oui |  | 13 |
| `TxLast` | enum | Public | oui |  | 13 |
| `All_Taxes` | var | Public |  | Integer[] | 14 |
| `All_Remises` | var | Public |  | Integer[] | 15 |
| `Ttx` | property | Public |  | Integer | 16 |
| `Cpt` | property | Public |  | String | 17 |
| `Lib` | property | Public |  | String | 18 |
| `change` | event | Public |  |  | 20 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 26-47 | Public | 5 | 19 | 0 | méthode spéciale |
| `Cpt_Read` | 58-62 | Private | 1 | 3 | 0 |  |
| `Cpt_Write` | 64-74 | Private | 4 | 9 | 0 |  |
| `Lib_Read` | 76-80 | Private | 1 | 3 | 0 |  |
| `Lib_Write` | 82-86 | Private | 1 | 3 | 0 |  |
| `Ttx_Read` | 88-92 | Private | 1 | 3 | 0 |  |
| `Ttx_Write` | 94-106 | Private | 5 | 11 | 0 |  |
| `Montant` | 112-139 | Public | 5 | 23 | 3 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Méthode spéciale

- **`_New(Montant, Type, Cpt)`** [portée : nécessaire] [nature : calcul].
  Conversion d'entrée identique à `LPrix._New` : une valeur fausse (0, "", Null) donne 0 ; une String
  est lue par `Utils.FloatParse` après retrait d'un éventuel `%` (qui positionne `Pct = True`) ; un
  Float est repris tel quel ; tout autre type passe par `CFloat`. Puis `Me.Ttx = Type` (qui peut
  inverser le signe, voir `Ttx_Write`) et `Me.Cpt = Cpt` (qui contrôle le compte si TVA). L'ordre
  Ttx puis Cpt est significatif : `Cpt_Write` lit `TypeTaxe`.

### Propriétés (privé)

- **`Cpt_Read`/`Cpt_Write`** [nature : mixte]. En écriture, si le type est `TVA` et que le compte est
  non vide et ne commence pas par `445`, affiche `Message.Error` et vide le compte ; sinon mémorise
  le compte et lève `change`. Partie GUI extractible : le `Message.Error`.
- **`Lib_Read`/`Lib_Write`** [nature : calcul]. Accesseur trivial de `Libelle`. La propriété `Lib`
  n'est lue ni écrite nulle part dans le projet (vérifié par `grep`).
- **`Ttx_Read`/`Ttx_Write`** [nature : mixte]. En écriture, un type hors `[0, TxLast[` affiche
  `Message.Error` et force `Aucune`. Pour `Remise` et `Deconsigne`, **le montant est négativé**
  (`Mnt = -Mnt`) : une remise est donc stockée en négatif.
  ⚠️ L'inversion est faite à **chaque** écriture : affecter deux fois `Ttx = LTaxe.Remise` rend le
  montant à nouveau positif. Aujourd'hui seul `_New` écrit `Ttx` (aucune écriture externe trouvée),
  donc le défaut est latent. `change` n'est pas levé.

### Méthode publique

- **`Montant(HT, ignore_quantite, TTC)`** [portée : nécessaire] [nature : calcul].
  Calcule la valeur de la taxe appliquée au prix `HT` :
  - quantité `qte` = `HT.Qte`, ou 1 si `ignore_quantite` ;
  - en pourcentage : `HT.Mnt × Mnt / 100 × qte` ; si `TTC` (le prix fourni est TTC et on extrait la
    taxe) : `HT.Mnt × (1 − 1 / (1 + Mnt/100)) × qte` (0 si `Mnt = 0`) ;
  - montant fixe : `Mnt × qte` (le drapeau `TTC` est ignoré).
  Renvoie `LPrix(val, qte, HT.Arr, Me.Cpt)`.
  ⚠️ **Couplage avec l'anomalie LPRIX-A01** (ligne 137) : `val` est déjà le **total** (× `qte`).
  Comme `LPrix._call` ignore son paramètre quantité et utilise `Qte` de l'auto-instance (1), le
  `LPrix` renvoyé a `Mnt = total` et `Qte = 1`, ce qui donne le bon total via `.G`/`.L`. Si l'on
  corrige `LPrix._call` seul, la quantité serait appliquée **deux fois** (`val × qte`). Les deux
  corrections doivent être faites ensemble (LPRIX-A01 + LTAXE-A01) : passer `val / qte` (ou `1` comme
  quantité) pour garder le même total.
  Appelants avec `ignore_quantite = False` (donc sensibles) : `ValidBR1.class:419`
  (`ltx.Montant(lpx).PuBHT.G`) et `Achat.class:994` (`Montant()` sans argument, quantité 1).
  La valeur par défaut `LPrix(0)` du paramètre `HT` est évaluée à chaque appel sans argument.

## État global utilisé

- `Utils.FloatParse` (lecture des chaînes « 20 % », « 1 234,5 »).
- `LPrix._call` (fabrique), `LPrix.Arr`, `LPrix.Qte`, `LPrix.Mnt`.
- Auto-instance statique de `LTaxe` (via `Create Static`) : non utilisée directement par le code
  (seules les énumérations et les listes `All_*` sont lues de façon statique).
- `All_Taxes` et `All_Remises` sont des **variables `Public` d'instance** initialisées à chaque
  `New LTaxe` (deux tableaux alloués par instance) alors qu'elles ne sont lues que via
  l'auto-instance (`LTaxe.All_Taxes`) depuis `LPrix`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Isoler le calcul de `Montant` dans une fonction privée pure `Calcul(base, qte, ttc) As Float`,
  lisible et testable par cas (pourcentage HT, pourcentage TTC, fixe).
- `All_Taxes`/`All_Remises` : en faire des constantes de classe (`Static Public` initialisées une
  fois) pour éviter deux allocations par instance ; comportement identique pour les lecteurs
  (`LTaxe.All_Taxes`). À confirmer par `gbc3` (un `Static Public` reste accessible par
  `LTaxe.All_Taxes`).
- Supprimer `Inherits Array` (aucun usage tableau de `LTaxe`) : à confirmer par `grep` sur
  `LTaxe[` hors déclarations `LTaxe[]`.

### Commonalisation avec d'autres fichiers

- **`Utils.VariantToFloat(v)`** (LPRIX-009) : le bloc de conversion Variant → Float de `_New`
  (l. 28-42) est le même que celui de [`LPrix._New`](../LPrix.class/architecture.md) (l. 47-57),
  à l'exception du traitement du `%`. Proposition : `Utils.VariantToFloat(v)` dans
  [`Utils.module`](../Utils.module/architecture.md), `LTaxe` retirant le `%` avant l'appel.
- La validation du compte TVA (`Left(Cpt, 3) = "445"`) se retrouve dans `LPrix.Cpt_Write`
  (commentée) et dans `Saisecrit` (`Left$($cpt, 3) = "445"`, l. 3096). Un prédicat commun
  `Utils.EstCompteTVA(cpt)` est envisageable (faible gain, à évaluer en phase 3).

### Réduction de portée

- Propriété `Lib` : aucun usage externe ni interne → candidat code mort (suppression de `Libelle`,
  `Lib_Read`, `Lib_Write`). La propriété fait partie de l'API publique : on la supprime seulement
  si `grep -rn "\.Lib\b"` reste vide au moment du rework.
- Événement `change` : aucun observateur (`New LTaxe … As "…"` introuvable). Conservé
  (coût nul), documenté.

### Séparation traitement / GUI

- `Cpt_Write` et `Ttx_Write` : extraire les validations dans des fonctions pures
  (`CompteValide(type, cpt) As Boolean`, `TypeValide(type) As Boolean`), le `Message.Error`
  restant dans l'accesseur avec le même texte.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : `LTaxe` n'accède pas à la base. Les taux sont lus par les appelants dans
  `Fiches_Tvaav`/`Fiches_Parametres` sous forme texte puis concaténés avec `"%"` ; un champ
  numérique typé `DECIMAL` éviterait le passage par chaîne.
