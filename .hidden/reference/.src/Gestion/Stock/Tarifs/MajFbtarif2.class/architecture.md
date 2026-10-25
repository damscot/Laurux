# MajFbtarif2 — Architecture

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif2.class`

## Vue d'ensemble

Écran **« Maj future base tarif »** (menu Gestion > Stock > Tarif > Future base tarif,
`Fmenu.Menu246_Click`, `ShowModal`). Pour une date saisie, il applique à tous les articles dont
`art_datefbt` vaut cette date le **futur prix de base** `art_pbfbt` (importé auparavant par
[`Impart`](../Impart.class/architecture.md), option « Maj future base tarif ») : recalcul de
toute la chaîne de prix (prix net, prix d'achat, prix de revient, PV HT, PV TTC, coefficient),
mise à jour de `Fiches_Art`, puis préparation des étiquettes produit et gondole.

Deux modes (boutons radio) : `Tbrut` (« Travail avec prix brut HT », par défaut) traite
`art_pbfbt` comme un prix de base auquel on applique la remise fournisseur (`prix_base`) ;
`Tnet` le traite comme un prix net d'achat (`Prix_achat`).

Le calcul s'appuie sur **18 variables de module de type `String`** (prix formatés, `nbdec`…)
partagées entre les fonctions, à l'image de l'écran voisin
[`Etiqfbtarif`](../../../Etiquettes/Etiqfbtarif.class/architecture.md) (aperçu des étiquettes de
la future base, mêmes fonctions de calcul) et de [`MajTarifP`](../MajTarifP.class/architecture.md).

Nature globale : **mixte**. `Button2_Click` mêle SQL, calcul et messages ; les fonctions de
calcul n'accèdent à aucun contrôle (sauf `Message.Error` dans les `Catch`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Nbdec` | var | Private |  | String | 3 |
| `PbHT` | var | Private |  | String | 4 |
| `PaHT` | var | Private |  | String | 5 |
| `Txconv` | var | Private |  | String | 6 |
| `Paua` | var | Private |  | String | 7 |
| `Prvt` | var | Private |  | String | 8 |
| `Pvht` | var | Private |  | String | 9 |
| `Pvttc` | var | Private |  | String | 10 |
| `Pmp` | var | Private |  | String | 11 |
| `Stocke` | var | Private |  | String | 12 |
| `Margem` | var | Private |  | String | 13 |
| `Margep` | var | Private |  | String | 14 |
| `arr` | var | Private |  | String | 15 |
| `Remise` | var | Private |  | String | 16 |
| `Coeff` | var | Private |  | String | 17 |
| `Percent` | var | Private |  | String | 18 |
| `Mtva` | var | Private |  | String | 19 |
| `Frais` | var | Private |  | String | 20 |
| `son` | var | Private |  | Integer | 21 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 23-29 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button3_Click` | 31-35 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 37-87 | Public | 15 | 48 | 0 | handler GUI |
| `ToggleButton2_Click` | 89-97 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 99-104 | Public | 1 | 4 | 0 | handler GUI |
| `prix_base` | 109-129 | Public | 3 | 19 | 0 | portée réductible ? |
| `PvTTcLF` | 134-141 | Public | 1 | 5 | 0 | portée réductible ? |
| `TrC` | 146-160 | Public | 4 | 13 | 0 | portée réductible ? |
| `Prix_achat` | 162-185 | Public | 5 | 22 | 0 | portée réductible ? |
| `rTva` | 190-199 | Public | 2 | 7 | 0 | portée réductible ? |
| `Tva_Calcul` | 204-213 | Public | 3 | 8 | 0 | portée réductible ? |
| `Calc_Marge` | 218-231 | Public | 6 | 12 | 0 | portée réductible ? |
| `PvTTC_arrondi` | 236-273 | Public | 10 | 33 | 0 | portée réductible ? |
| `Calc_Percent` | 278-282 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff` | 287-291 | Public | 2 | 3 | 0 | portée réductible ? |
| `Maj_Etiqp` | 294-309 | Public | 2 | 11 | 0 | portée réductible ? |
| `Maj_Etiqg` | 312-325 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button1_Click` | 330-334 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Handlers (portée `Public` obligatoire)

- **`_new()`** [GUI] : `Utils.Observers(Me)` une fois, son, centrage.
- **`Button3_Click()`** [GUI] : fermeture. **`Button1_Click()`** [GUI] : `Doc.Open("Majtarif")`.
- **`ToggleButton2_Click()`**, **`DateChooser1_Activate()`** [GUI] : choix de la date
  (`dd.mm.yyyy`). Le champ `date` est **vide** à l'ouverture (pas de valeur par défaut).
- **`Button2_Click()`** (CC 15) [mixte] :
  1. `SELECT * FROM Fiches_Art WHERE art_datefbt = &1` avec `Utils.Cdate_Dbase(date.text)`.
  2. `Message.Warning` puis `LOCK TABLES Fiches_Art WRITE, Fiches_Tvaav WRITE` (neutralisé sous
     SQLite par `DB_Connection.Exec`).
  3. Pour chaque article : `Paua = art_pbfbt`, `nbdec = Find_nbdec(art_nbd)`, remise, taux de
     conversion, frais, coefficient, code TVA ; `rTva` ; `prix_base` ou `Prix_achat` ;
     `Calc_Percent` ; `Calc_coeff` ; puis
     `UPdate Fiches_Art SET art_pbht, art_tr, art_pauaht, art_pvht, art_pvttc, art_prvt, art_paht,
     art_coef, art_pbfbt = '', art_datefbt = '', art_ddatefbt = aujourd'hui`.
  4. Étiquettes : `Maj_Etiqp` si `art_etiq`, `Maj_Etiqg` si stock > 0 ; exports
     `Serveur.Pass("Etiq", …)` et `Serveur.Pass("Art", "M", …)` si les drapeaux `Variables.Sprix/
     Sexport/SMajArt` sont vrais.
  5. `UNLOCK TABLES`, message de fin avec le nombre d'articles.
  ⚠️ **Tables non verrouillées** : `Maj_Etiqp`/`Maj_Etiqg` lisent et écrivent `Fiches_EtiProd` /
  `Fiches_EtiGond`, absentes du `LOCK TABLES` : sous MySQL, la requête échoue (« table was not
  locked with LOCK TABLES »), l'erreur remonte hors de `Button2_Click` (aucun `Catch`) après la
  mise à jour du premier article concerné, et `UNLOCK TABLES` n'est jamais exécuté
  (MAJFBTARIF2-A02, à confirmer par T02). `MajTarifP` verrouille bien ces deux tables.
  ⚠️ **Date vide** : `Cdate_Dbase("")` = `""`. Les articles déjà traités ont reçu
  `art_datefbt = ''` et `art_pbfbt = ''` (stockés `0000-00-00`/`0` en MySQL non strict, `''` en
  SQLite) : ils sont **resélectionnés** et leurs prix recalculés à partir d'un prix de base nul
  (MAJFBTARIF2-A01, à confirmer par T04). Laurux force `sql_mode = NO_ENGINE_SUBSTITUTION`
  (`Utils.module:1525`, `Fmenu.class:175`) : les chaînes vides sont acceptées avec avertissement.

### Chaîne de calcul (portée réductible, nature calcul)

Toutes ces fonctions travaillent sur les variables de module (`String`), avec `Val`/`Format$`
localisés et `Utils.cpoint` (remplacement du point par la virgule).

- **`prix_base()`** : `pbht = PaUA` formaté, `TrC` (prix net), `paht = PaUA / Txconv`,
  `Prvt = paht + Frais`, `Pvht = Prvt × Coeff`, `Tva_Calcul`, `PvTTC_arrondi`, `PvTTcLF`
  (PV HT recalculé depuis le TTC), `Calc_Marge`. `Catch` → `Message.Error`.
- **`TrC()`** : remise normalisée (`0.00`), `PaUA = PbHT − PbHT × remise / 100`.
- **`Prix_achat()`** : mode net ; `pbht = PaUA / (1 − remise/100)` puis même chaîne que
  `prix_base`. ⚠️ `Val(Txconv)`, `Val(Frais)`, `Val(Coeff)` sans `Utils.cpoint` (valeurs lues en
  base, converties en chaîne avec un point) : résultat dépendant de la locale, à confirmer par T03 ;
  `Val(PaUA) <> "0"` compare un Float à une chaîne.
- **`PvTTcLF()`** : `Pvht = PvTTC / (1 + Mtva/100)`.
- **`rTva()`** : `SELECT * FROM Fiches_Tvaav WHERE code_tva = Mtva` → `Mtva = taux_tva` (garde le
  code si absent). Même requête que [`CPrix.CTva`](../../../../Utils/CPrix.module/architecture.md),
  qui renvoie `""` si absent.
- **`Tva_Calcul()`** : `PvTTC = Pvht × (1 + Mtva/100)`.
- **`Calc_Marge()`** : calcule `Margem`/`Margep` à partir de `Pmp`/`Stocke`, **jamais lus** ni
  enregistrés ; `Pmp` n'est jamais réinitialisé (reste le prix de revient du premier article) et
  `Stocke` jamais affecté : fonction sans effet observable (code mort fonctionnel).
- **`PvTTC_arrondi()`** : arrondi du PV TTC au 0,05/0,10/0,50/1,00 par découpage de chaîne selon
  `arr`. ⚠️ `arr` n'est **jamais affecté** dans la classe : seule la normalisation `cpoint` est
  appliquée, l'arrondi `art_cdarr` de l'article est ignoré (MAJFBTARIF2-A03).
- **`Calc_Percent()`** : taux de marque `(Pvht − Prvt) / Pvht × 100`.
- **`Calc_coeff()`** : `Coeff = 1 / (1 − Percent/100)` : le coefficient enregistré est recalculé
  depuis les prix arrondis.
- **`Maj_Etiqp(Cart, Stk)`** [nature : calcul, SQL] : `Fiches_EtiProd` (nom en dur, clé `Cbase`
  `TabEtiqp` existante) : `UPDATE … nombre = Stk` si la ligne existe, sinon `INSERT`. Le stock
  `Double` est tronqué en `Integer`.
- **`Maj_Etiqg(Cart)`** : `Fiches_EtiGond` (en dur, clé `TabEtiqg`) : `nombre = 1` (UPDATE ou INSERT).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.Observers`, `Utils.db`, `Utils.cpoint`, `Utils.Find_nbdec`,
  `Utils.Cdate_Dbase`, `Cbase.Table("TabArt"/"TabTvav")`.
- `Variables.Sprix`, `Variables.Sexport`, `Variables.SMajArt`, `Serveur.Pass`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Calc_Marge` et les variables `Margem`, `Margep`, `Pmp`, `Stocke` (aucun effet
  observable).
- `Maj_Etiqp`/`Maj_Etiqg` : `Cbase.Table("TabEtiqp"/"TabEtiqg")` au lieu des noms en dur (même
  nom physique).

### Commonalisation avec d'autres fichiers

- **Chaîne de calcul de tarif** : `prix_base`, `TrC`, `rTva`, `Tva_Calcul`, `Calc_Marge`,
  `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `PvTTcLF` sont **identiques ligne à ligne** dans
  [`Etiqfbtarif`](../../../Etiquettes/Etiqfbtarif.class/architecture.md) ; `TrC`, `Prix_achat`,
  `rTva`, `Tva_Calcul`, `PvTTC_arrondi`, `Calc_coeff`, `PvTTcLF` le sont dans
  [`MajTarifP`](../MajTarifP.class/architecture.md) (vérifié par `diff`). Proposition phase 3 :
  une classe d'état `LTarifCalc` (à créer dans `.src/Utils`) portant les variables (`PbHT`,
  `Remise`, `Txconv`, `Frais`, `Coeff`, `Mtva`, `nbdec`, `arr`…) et ces méthodes **copiées sans
  modification** ; chaque écran garde ses variantes divergentes (`MajTarifP.prix_base`,
  `MajTarifP.Calc_Percent`, `Etiqfbtarif.Prix_achat`). Rend la chaîne testable en gb.test.
- `PvTTC_arrondi` ≡ `Impart.PvTTC_arrondi` ≡ `MajTarifM.arrondi2` (sur des contrôles) : candidat
  à la fonction commune `ArrondiPvTTC(sPvttc, sArr, sFormat)` proposée par ARTICLES-011/012
  ([`Articles`](../../../Tables/Articles.class/architecture.md)), après comparaison ligne à ligne.
- `Maj_Etiqp`/`Maj_Etiqg` : même code dans [`Impart`](../Impart.class/architecture.md) ; variante
  (gondole sans mise à jour si la ligne existe) dans `MajTarifP` et `MajTarifM`. Un module commun
  `EtiqMaj.Produit(code, nb)` / `EtiqMaj.Gondole(code, bForce)` reproduirait les deux variantes.
- Garde d'export → `Serveur.Actif` (SERVEUR-008).

### Réduction de portée

- `prix_base`, `PvTTcLF`, `TrC`, `Prix_achat`, `rTva`, `Tva_Calcul`, `Calc_Marge`,
  `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `Maj_Etiqp`, `Maj_Etiqg` → `Private` (aucun
  appelant externe, vérifié par `grep`). Couverture par replay de `Button2_Click`.

### Séparation traitement / GUI

- Extraire de `Button2_Click` une fonction `AppliqueFutureBase(sDateDb, bBrut) As Integer`
  (SQL + calcul, renvoie le nombre d'articles) ; le handler garde les messages, la souris et le
  son.
- Les `Catch` des fonctions de calcul affichent `Message.Error` : à remonter dans l'appelant.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remettre `art_pbfbt`/`art_datefbt` à `NULL` (et non `''`) suppose seulement un changement de
  code (anomalie A01) ; une table d'historique des bases tarif (`Fiches_TarifFutur`) permettrait
  de conserver plusieurs échéances.
