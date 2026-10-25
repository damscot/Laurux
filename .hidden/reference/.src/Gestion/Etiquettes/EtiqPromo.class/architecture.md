# EtiqPromo — Architecture

> Source : `.src/Gestion/Etiquettes/EtiqPromo.class`

## Vue d'ensemble

Écran d'impression des **étiquettes de promotion** : pour une promotion choisie dans la liste
`Colpromo` (`Fiches_Promo`), il imprime une étiquette de gondole par article de la promotion
(`Fiches_ArtPromo`), avec le prix **promotionnel** (`Deb` « Début de promotion », défaut) ou le
prix normal de l'article (« Fin de promotion »). Ouverture modale de l'auto-instance depuis
`Fmenu.Menu225_Click` (`Fmenu.class:1939`).

Mise en page : ancienne version de la gondole (code, deux intitulés, EAN13, TVA, prix au kg/l,
cadre, PV HT/TTC, variantes « P » des prix pour la promotion). En A4, chaque article est imprimé
**3 fois** (`nombretiq = 3` codé en dur), en Dymo une fois. `pos_Etiq` variante **V5**
(espacement compté une fois, seuil `i2 > Nbhauteur`). Zebra : branche morte (`Connect` jamais
appelée) et aucun PDF créé.

Sortie : `~/tmp/EtiqGond.pdf` (même nom qu'Etigond et Etiqfbtarif).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 3 |
| `Rect` | var | Private |  | String | 4 |
| `intitule` | var | Private |  | String | 5 |
| `intitule2` | var | Private |  | String | 6 |
| `Nblargeur` | var | Private |  | String | 7 |
| `Nbhauteur` | var | Private |  | String | 8 |
| `Largeur` | var | Private |  | Integer | 9 |
| `Hauteur` | var | Private |  | Integer | 10 |
| `Mrghaut` | var | Private |  | Integer | 11 |
| `Mrgauche` | var | Private |  | Integer | 12 |
| `Esplargeur` | var | Private |  | Integer | 13 |
| `Esphauteur` | var | Private |  | Integer | 14 |
| `Filename` | var | Private |  | String | 15 |
| `i2` | var | Private |  | Integer | 16 |
| `Nbetiq` | var | Private |  | Integer | 17 |
| `txtBarcode` | var | Private |  | String | 18 |
| `txtPosX` | var | Private |  | Integer | 19 |
| `txtPosY` | var | Private |  | Integer | 20 |
| `SorP` | var | Private |  | Boolean | 21 |
| `Nb` | var | Private |  | Boolean | 22 |
| `pdf` | var | Private |  | Cetiquettes | 23 |
| `IpZebra` | var | Private |  | String | 24 |
| `ConnZbr` | var | Private |  | Boolean | 25 |
| `MySock` | var | Private |  | Socket | 26 |
| `Page` | var | Private |  | String | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-48 | Public | 4 | 18 | 0 | méthode spéciale |
| `Form_Open` | 50-65 | Public | 3 | 13 | 0 | handler GUI |
| `init_ComboBox` | 67-83 | Public | 5 | 14 | 0 | portée réductible ? |
| `Colpromo_Click` | 85-93 | Public | 2 | 7 | 0 | handler GUI |
| `Button2_Click` | 95-156 | Public | 13 | 59 | 0 | handler GUI |
| `Init` | 158-187 | Public | 6 | 27 | 0 | portée réductible ? |
| `fin_impression` | 189-199 | Public | 2 | 9 | 0 | portée réductible ? |
| `Imprime` | 202-293 | Public | 20 | 81 | 0 | portée réductible ? |
| `pos_Etiq` | 295-326 | Public | 6 | 30 | 0 | portée réductible ? |
| `Connect` | 328-347 | Public | 6 | 17 | 0 | portée réductible ? |
| `Button3_Click` | 349-353 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 358-362 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)` (une
  fois), imprimante selon `/Soc<XX>/Impetiq`, colonnes de `ColPromo`, `init_ComboBox`.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. `SELECT * FROM
  Cbase.Table("TabPromo") order by code` → `ColPromo` (code, libellé, dates via `Utils.Cdate_Aff`).
- **`init_ComboBox()`** [réductible] [nature : mixte]. Liste `Fiches_Etiquettes` (libellé avec la
  page), identique à EtiqRecpt et Etiqfbtarif.
- **`Colpromo_Click()`** [portée : nécessaire (handler ; rejeu `Object.Call`)] [nature : GUI].
  Recopie code et dates dans `Code`, `Date1`, `date2`.
- **`Button2_Click()`** (Imprimer, CC 13) [portée : nécessaire (handler, contrôle hors groupe)]
  [nature : mixte]. Modèle obligatoire ; `SELECT * FROM TabEtiq WHERE code = &1` (sans la page) ;
  `Shell "cd ~"`, `Kill` ; PDF A4 (format de la page) ou Dymo `dymog` (dimensions de la base) ;
  **rien en Zebra** → `pdf.Open()` sur `Null` (l. 130). `select * FROM TabArtPromo WHERE code_promo
  = &1` ; sauts `Posetiq - 1` (`Inc Nbetiq`, `pos_Etiq`, `nb = True`) ; `Imprime` par article
  (paramètres `pht`/`pttc` transmis mais ignorés) ; `fin_impression` ou message.
- **`Init()`** [portée : réductible] — **code mort** (`unused`, grep) : ancienne version du
  chargement du format et des sauts (`code = ""` y vise le TextBox `Code`, `rect` calculé selon
  `Nblargeur` et jamais lu).
- **`Imprime(Cpos, pht, pttc, nb)`** (CC 20) [portée : réductible] [nature : mixte]. `SELECT * FROM
  TabArt left join TabArtPromo on code = art_code WHERE art_code = &1` : la jointure ne filtre
  **pas** sur `code_promo` (un article présent dans plusieurs promotions prend les prix d'une ligne
  quelconque, ETIQPROMO-A02) ; pas de test `Available`. Prix promo (`pht`/`pttc`) ou article
  (`art_pvht`/`art_pvttc`) selon `Deb`, prix au kg/l `pvttc / art_poids2`. Boucle de 3 (A4) ou 1
  (Dymo) étiquettes, positionnement avant (`nb` faux) ou après (`nb` vrai) le dessin ; le membre
  `Nb` reste vrai d'une impression à l'autre. Branche Zebra morte, qui passerait le **TextBox**
  `Code` comme code article (ETIQPROMO-A05).
- **`pos_Etiq()`** [réductible] [nature : calcul]. Variante V5 : `X = 2 + Mrgauche + Largeur ×
  (n-1) + Esplargeur`, saut de page si `i2 > Nbhauteur` (une rangée de plus que la planche), pas de
  retour en haut quand `Nbetiq = 1` ; Dymo : nouvelle page par étiquette.
- **`fin_impression()`** [réductible] [nature : mixte]. `Output`, `Visualiseur.Prog`, son, message,
  remise à vide du modèle.
- **`Connect()`** [réductible] — **code mort** (`unused`) : connexion Zebra (ZEBRA-A01).
- **`Button3_Click()`** (Quitter) / **`Button1_Click()`** (aide `Doc.Open("Promo")`) [handlers].

## État global utilisé

- `Start.*` (`Impetiq`, son, `Son` copié dans le membre `son`), `Utils.db`, `Utils.Cdate_Aff`,
  `Utils.Find_nbdec`, `Utils.cpoint`, `Utils.Observers`, `Cbase.Table` (`TabPromo`, `TabEtiq`,
  `TabArtPromo`, `TabArt`), `Visualiseur`, `Doc`, `CEtiquettes`, `Zebra`.
- Fichier `~/tmp/EtiqGond.pdf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Init`, `Connect` (selon ZEBRA-A01), les paramètres ignorés `pht`/`pttc` d'`Imprime`
  (fonction interne), les membres `Rect`, `SorP`, `Filename` initial, `Shell "cd ~"`.
- `Imprime` : lecture de l'article séparée du dessin, constante nommée pour les 3 exemplaires A4.

### Commonalisation avec d'autres fichiers

- Socle `PlancheEtiquettes` (variante V5, `init_ComboBox`, format, sortie) : voir
  [Etiqart › Commonalisation](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers).
- Dessin gondole : version ancienne de celui d'[`Etigond`](../Etigond.class/architecture.md) et
  proche de celui d'[`Etiqfbtarif`](../Etiqfbtarif.class/architecture.md) (125 lignes communes,
  ratio 0,37 avec Etiqfbtarif) ; `fin_impression` identique à celle d'Etiqfbtarif (plus la remise à
  vide du modèle).
- Recherche de la promotion d'un article : la logique « promotion du jour » existe dans `Articles`,
  `Caisse`, `Facture` (notes transverses, `ArtPromo.PromoDuJour`) ; ici, la promotion est imposée
  par l'écran, seul le filtre `code_promo` manque.

### Réduction de portée

- `init_ComboBox`, `fin_impression`, `Imprime`, `pos_Etiq` → `Private` ; `Init` et `Connect` :
  code mort / anomalie.

### Séparation traitement / GUI

- `ArticlesPromo(code) As Result` et `ValeursEtiquette(rArt, debut)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Nombre d'exemplaires par article (3) à stocker dans `Fiches_Promo` ou `Fiches_Etiquettes`.
