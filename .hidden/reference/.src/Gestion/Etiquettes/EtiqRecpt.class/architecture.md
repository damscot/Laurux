# EtiqRecpt — Architecture

> Source : `.src/Gestion/Etiquettes/EtiqRecpt.class`

## Vue d'ensemble

Écran d'impression des **étiquettes préparées** (« étiquettes réception ») : il imprime les files
d'attente `Fiches_EtiProd` (étiquettes produit et casier) et `Fiches_EtiGond` (étiquettes gondole),
alimentées par les réceptions et les mises à jour de tarifs (`GesTar`, `MajTarifM`, `MajTarifP`,
`MajFbtarif2`, `Impart`), puis propose de **vider** la file imprimée.

Ouverture non modale de l'auto-instance (`EtiqRecpt.Show`) depuis `Fmenu.Menu164_Click`
(« Étiquettes préparées »), `GesTar:526`, `Impart:1316`, `MajTarifM:1404`, `MajTarifP:255`.

Trois types (`Etiprod`, `Etigond`, `Eticas` — défaut casier), trois imprimantes (A4 selon le
format, Dymo `dymog` 88 × 35 ou `dymoc` 25 × 25, Zebra non gérée). Les mises en page reprennent
celles d'[`Etiqart`](../Etiqart.class/architecture.md) (produit),
[`Etigond`](../Etigond.class/architecture.md) (gondole simplifiée) et
[`Etiqcasier`](../Etiqcasier.class/architecture.md) (casier) — le commentaire du code le reconnaît
(« il faudrait plutôt s'appuyer sur les classes Etiqart/Etigond/Eticasier »). `pos_Etiq` variante
**V2** (identique à `Etigond.pos_Etiq`).

Sortie : `~/tmp/EtiqRecpt.pdf`.

Tables `Fiches_EtiProd`/`Fiches_EtiGond` : clé `code` = code article (ou référence fournisseur,
voir `Button2_Click`) ; `Articles.art_Suppr` ne les purge pas (ARTICLES-A05), d'où des **orphelins**
qui font échouer l'impression (ETIQRECPT-A02).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Nbetiq` | var | Private |  | Integer | 27 |
| `txtBarcode` | var | Private |  | String | 28 |
| `txtPosX` | var | Private |  | Integer | 29 |
| `txtPosY` | var | Private |  | Integer | 30 |
| `SorP` | var | Private |  | Boolean | 31 |
| `CoulZns` | var | Private |  | Integer | 32 |
| `CoulZnaf` | var | Private |  | Integer | 33 |
| `CoulFc` | var | Private |  | Integer | 34 |
| `son` | var | Private |  | Integer | 35 |
| `i2` | var | Private |  | Integer | 36 |
| `Nblargeur` | var | Private |  | String | 37 |
| `Nbhauteur` | var | Private |  | String | 38 |
| `Largeur` | var | Private |  | Float | 39 |
| `Hauteur` | var | Private |  | Float | 40 |
| `Mrghaut` | var | Private |  | Float | 41 |
| `Mrgauche` | var | Private |  | Float | 42 |
| `Esplargeur` | var | Private |  | Float | 43 |
| `Esphauteur` | var | Private |  | Float | 44 |
| `Filename` | var | Private |  | String | 45 |
| `pdf` | var | Private |  | Cetiquettes | 46 |
| `Page` | var | Private |  | String | 47 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 49-70 | Public | 4 | 18 | 0 | méthode spéciale |
| `init_ComboBox` | 72-88 | Public | 5 | 14 | 0 | portée réductible ? |
| `Calc_Etiq` | 90-119 | Public | 5 | 27 | 0 | portée réductible ? |
| `Button2_Click` | 121-310 | Public | 36 | 178 | 0 | handler GUI |
| `pos_Etiq` | 312-344 | Public | 6 | 31 | 0 | portée réductible ? |
| `Btn_Click` | 346-350 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 352-372 | Public | 7 | 18 | 0 | handler GUI |
| `Button1_Click` | 374-378 | Public | 1 | 3 | 0 | handler GUI |
| `Etiprod_Click` | 380-384 | Public | 1 | 3 | 0 | handler GUI |
| `Etigond_Click` | 386-390 | Public | 1 | 3 | 0 | handler GUI |
| `Eticas_Click` | 392-396 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Couleurs (jamais relues),
  `Utils.Observers(Me)` (une fois), imprimante selon `/Soc<XX>/Impetiq`, `init_ComboBox`,
  `Calc_Etiq`.
- **`init_ComboBox()`** [réductible] [nature : mixte]. Liste `Fiches_Etiquettes`, libellé
  `"<code> - <libellé> (<page>)"` (identique à EtiqPromo et Etiqfbtarif).
- **`Calc_Etiq()`** [réductible] [nature : mixte]. `SELECT * FROM Fiches_EtiProd order by code` et
  `… Fiches_EtiGond …` (littéraux ; clés `Cbase` `TabEtiqp`/`TabEtiqg` existantes) : somme des
  `nombre` dans `Nbetip`, `Nbetic` (même somme : casiers et produits partagent la file) et `Nbetig`.
  Utilise `retiq.count` sans `Available`.
- **`Button2_Click()`** (Imprimer, CC 36, max du fichier) [portée : nécessaire (handler, contrôle
  `Button2` hors groupe)] [nature : mixte]. Étapes :
  1. modèle obligatoire ; `SELECT * FROM Fiches_Etiquettes WHERE code = &1` (**sans** la page) ;
  2. si `Posetiq > 1` : `Posetiq - 2` itérations (une de moins que les autres écrans) de
     `pos_Etiq` + `pdf.Code("")` **avant** la création du PDF (« Null object » au premier passage,
     écriture dans l'ancien PDF ensuite, ETIQRECPT-A01) ;
  3. `Shell "cd ~"`, `Kill` du PDF, création A4 / Dymo (`dymoc` si type casier) ; Zebra → pas de
     PDF, erreur à `pdf.Open()` ;
  4. file `Fiches_EtiProd` (produit, casier) ou `Fiches_EtiGond` ; pour chaque ligne : `SELECT *
     FROM Fiches_Art WHERE art_code = &1`, à défaut `WHERE art_cfour = &1` (référence
     fournisseur), **sans** test `Available` ; taux de TVA (`TabTvav`) sans test ;
  5. pour `nombre` étiquettes : `pos_Etiq`, ratio `Largeur/100`, puis dessin produit (comme
     Etiqart, prix TTC si `EtiqPrix`), gondole (code, intitulés, EAN13, TVA, cadre, PV HT et TTC) ou
     casier (A4 comme Etiqcasier à un décalage près, Dymo identique) ;
  6. `Output`, `Visualiseur.Prog`, son, **`Button4_Click`** (proposition de vider la file),
     `EtiqRecpt.visible = True` (auto-instance) ; sinon message « Aucun article ».
- **`pos_Etiq()`** [réductible] [nature : calcul]. Variante V2.
- **`Button4_Click()`** (Effacer la file) [portée : nécessaire (handler, appelé aussi par
  `Button2_Click`)] [nature : mixte]. Confirmation, puis **un `DELETE FROM <file> WHERE code = &1`
  par ligne** lue, et `Calc_Etiq`. Pour le type casier, la file vidée est `Fiches_EtiProd` (les
  étiquettes produit en attente sont aussi effacées).
- **`Btn_Click()`** (groupe `Btn`, bouton Quitter) [handler] : `Me.Close`.
- **`Button1_Click()`** [handler] : `Doc.Open("Etiqrcpt")`.
- **`Etiprod_Click` / `Etigond_Click` / `Eticas_Click`** [handlers] [nature : GUI]. Affichent la case
  `EtiqPrix` pour le type produit seulement.

## État global utilisé

- `Start.*` (couleurs, `Impetiq`, son), `Utils.db`, `Utils.Find_nbdec`, `Utils.FColr`,
  `Utils.Observers`, `Cbase.Table("TabTvav")`, `Visualiseur`, `Doc`, `CEtiquettes`.
- Fichier `~/tmp/EtiqRecpt.pdf`.
- Membre `pdf` conservé entre deux impressions (réutilisé par l'étape 2).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` (CC 36) : `LitArticle(code)` (avec repli sur `art_cfour`), une procédure de dessin
  par type, une boucle ; `Button4_Click` : un seul `DELETE FROM <file>` (SQL modifié, dump
  identique) ; `Calc_Etiq` : `SELECT SUM(nombre)` (SQL modifié, affichage identique).
- `Cbase.Table("TabEtiqp"/"TabEtiqg"/"TabEtiq"/"TabArt")` pour les littéraux.

### Commonalisation avec d'autres fichiers

- Dessins produit / gondole / casier : à partager avec Etiqart, Etigond, Etiqcasier via
  `PlancheEtiquettes` (voir
  [Etiqart › Commonalisation](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers)),
  sous réserve de PDF identiques (coordonnées légèrement différentes : stock casier, absence de prix
  au kg et de références fournisseur en gondole).
- `pos_Etiq` V2 identique à `Etigond.pos_Etiq` ; `init_ComboBox` identique à EtiqPromo et
  Etiqfbtarif.
- Les écrivains des files (`GesTar`, `MajTarifM`, `MajTarifP`, `MajFbtarif2`, `Impart`) répètent
  l'« upsert » `(code, nombre)` : un helper `FileEtiquettes.Ajoute(type, code, nombre)` les unifierait
  (lots Entrées / Stock).

### Réduction de portée

- `init_ComboBox`, `Calc_Etiq`, `pos_Etiq` → `Private` (grep : aucun usage externe ; les
  appelants n'utilisent que `Show`).

### Séparation traitement / GUI

- `CompteFile(table) As Integer`, `ViderFile(table)`, `LitArticle(code)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une seule table de file d'impression avec un type (produit, casier, gondole) éviterait que
  produit et casier partagent `Fiches_EtiProd` (et soient effacés ensemble).
- Clé étrangère `code` → `Fiches_Art.art_code` avec `ON DELETE CASCADE` (orphelins, ARTICLES-A05) ;
  le repli sur `art_cfour` suggère que certaines files contiennent des références fournisseur :
  colonne dédiée.
