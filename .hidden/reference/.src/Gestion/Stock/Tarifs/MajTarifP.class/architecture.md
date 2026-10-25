# MajTarifP — Architecture

> Source : `.src/Gestion/Stock/Tarifs/MajTarifP.class`

## Vue d'ensemble

Écran **« Maj tarif en % »** (Gestion > Stock > Tarif, `Fmenu.Menu248_Click`, `Show`) : applique
une hausse (ou baisse) en pourcentage à **tous les articles d'un fournisseur**, puis recalcule la
chaîne de prix et met à jour `Fiches_Art` et les étiquettes à imprimer. Deux modes :

- `Tbrut` (« Travail avec prix base HT », par défaut) : `art_pbht` augmenté du pourcentage, puis
  remise, prix d'achat, prix de revient, PV HT = prix de revient × coefficient, PV TTC, et
  coefficient recalculé (`prix_base`, `Calc_Percent`, `Calc_coeff`) ;
- `Tnet` (« Travail avec prix vente HT ») : `art_pvht` augmenté du pourcentage, PV TTC, puis
  coefficient recalculé depuis le prix de revient existant.

Comme [`MajFbtarif2`](../MajFbtarif2.class/architecture.md), le calcul repose sur des variables
de module `String` et des fonctions copiées ; la plupart sont identiques ligne à ligne.

Nature globale : **mixte** (handlers GUI ; `Button2_Click` mêle SQL, calcul et messages).

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
| `b` | var | Private |  | Integer | 21 |
| `Etiqb` | var | Private |  | Boolean | 22 |
| `son` | var | Private |  | Integer | 23 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 25-31 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button3_Click` | 33-37 | Public | 1 | 3 | 0 | handler GUI |
| `Cmpt_GotFocus` | 42-49 | Public | 1 | 6 | 0 | handler GUI |
| `Cmpt_keyPress` | 51-79 | Public | 12 | 25 | 0 | handler GUI |
| `Button2_KeyPress` | 81-85 | Public | 1 | 3 | 0 | handler GUI |
| `ChkPrx` | 87-95 | Public | 7 | 7 | 0 | portée réductible ? |
| `fourMan` | 100-122 | Public | 7 | 20 | 0 | portée réductible ? |
| `Button4_Click` | 127-152 | Public | 3 | 23 | 0 | handler GUI |
| `fourList_Click` | 157-164 | Public | 1 | 6 | 0 | handler GUI |
| `fourList_KeyPress` | 169-181 | Public | 5 | 11 | 0 | handler GUI |
| `Button2_Click` | 183-263 | Public | 31 | 78 | 0 | handler GUI |
| `prix_base` | 268-287 | Public | 3 | 18 | 0 | portée réductible ? |
| `PvTTcLF` | 292-299 | Public | 1 | 5 | 0 | portée réductible ? |
| `TrC` | 304-318 | Public | 4 | 13 | 0 | portée réductible ? |
| `Prix_achat` | 320-343 | Public | 5 | 22 | 0 | portée réductible ? |
| `rTva` | 348-357 | Public | 2 | 7 | 0 | portée réductible ? |
| `Tva_Calcul` | 362-371 | Public | 3 | 8 | 0 | portée réductible ? |
| `Calc_Marge` | 376-389 | Public | 6 | 12 | 0 | portée réductible ? |
| `PvTTC_arrondi` | 394-431 | Public | 10 | 33 | 0 | portée réductible ? |
| `Calc_Percent` | 436-440 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff` | 445-449 | Public | 2 | 3 | 0 | portée réductible ? |
| `Maj_Etiqp` | 452-464 | Public | 2 | 10 | 0 | portée réductible ? |
| `Maj_Etiqg` | 466-476 | Public | 2 | 8 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Handlers et saisie (portée `Public` obligatoire pour les handlers)

- **`_new()`** [GUI] : `Utils.Observers(Me)` une fois, son, centrage.
- **`Button3_Click()`** [GUI] : fermeture.
- **`Cmpt_GotFocus()`** [GUI] : `Utils.SetEditColor` et sélection du texte.
- **`Cmpt_keyPress()`** [mixte] : groupe `Cmpt` (`Four` tag 1, `Pourcent` tag 2). Tag 1 + Entrée/Tab :
  `fourMan`, puis focus sur `Four` (erreur) ou `Pourcent`. Tag 2 : filtre `ChkPrx`, puis à
  Entrée/Tab formatage `0.00` et focus sur `Button2` si le pourcentage est > 0.
- **`Button2_KeyPress()`** [GUI] : appelle `Button2_Click` pour **toute** touche (Tab compris) :
  une simple tabulation sur le bouton lance la mise à jour (MAJTARIFP-A02).
- **`ChkPrx()`** [portée : réductible] [GUI] : bloque les touches non numériques (`Stop Event`).
  Identique à `MajTarifM.ChkPrx`.
- **`fourMan()`** [portée : réductible] [mixte] : `SELECT * FROM Fiches_Four WHERE fo_code`,
  remplit `fournom` ou avertit (`b = 1`).
- **`Button4_Click()`** [mixte] : liste des fournisseurs ; ⚠️ pas de test `Available` (table vide :
  erreur). **`fourList_Click()`** [GUI] (`replay_dynamic`, doit rester `Public`),
  **`fourList_KeyPress()`** [GUI].
- **`Button2_Click()`** (CC 31, max) [mixte] :
  1. `SELECT * FROM Fiches_Art WHERE art_four = Four.Text` (un fournisseur vide sélectionne les
     articles sans fournisseur ; le pourcentage n'est pas revalidé).
  2. `LOCK TABLES Fiches_Art, Fiches_Tvaav, Fiches_EtiProd, Fiches_EtiGond WRITE`.
  3. Mode brut : `Pbht × (1 + % / 100)`, lecture remise, PMP, taux de conversion, frais,
     coefficient, TVA ; `rTva`, `prix_base`, `Calc_Percent`, `Calc_coeff` ; étiquettes
     (`Maj_Etiqp` si stock > 0 et `art_etiq`, `Maj_Etiqg` si stock > 0) **avant** l'`UPDATE` de
     `art_pbht, art_tr, art_pauaht, art_pvht, art_pvttc, art_prvt, art_paht, art_coef, art_ddatefbt`.
  4. Mode net : `Pvht × (1 + % / 100)`, `rTva`, `Tva_Calcul`, `PvTTC_arrondi`, `PvTTcLF`,
     `Calc_Marge`, `Calc_Percent`, `Calc_coeff`, étiquettes, `UPDATE art_pvht, art_pvttc,
     art_prvt, art_coef, art_ddatefbt`.
  5. `UNLOCK TABLES`, message, proposition d'imprimer les étiquettes (`EtiqRecpt.Show`).
  Aucun `Catch` : une erreur SQL laisse les tables verrouillées.

### Chaîne de calcul (portée réductible, nature calcul)

- **`prix_base()`** : comme `MajFbtarif2.prix_base` sauf la première ligne (le prix de base est
  déjà dans `pbht`). **`TrC()`**, **`Prix_achat()`**, **`rTva()`**, **`Tva_Calcul()`**,
  **`PvTTC_arrondi()`**, **`Calc_coeff()`**, **`PvTTcLF()`** : identiques ligne à ligne à
  `MajFbtarif2` (vérifié par `diff`).
- **`Prix_achat()`** : **jamais appelée** (`unused`, vérifié par `grep`) : code mort.
- **`Calc_Marge()`**, **`Calc_Percent()`** : variantes avec `Utils.cpoint` ; `Margem`/`Margep`
  jamais lus, `Stocke` jamais affecté : `Calc_Marge` est sans effet observable.
- ⚠️ `arr` n'est jamais affecté : `PvTTC_arrondi` n'arrondit pas (MAJTARIFP-A01).
- **`Maj_Etiqp(Cart, nb)`** : `Cbase.Table("TabEtiqp")`, `UPDATE nombre = nb` ou `INSERT` ;
  `Etiqb = True`. **`Maj_Etiqg(Cart, nb)`** : `INSERT nombre = 1` seulement si absent
  (variante différente de `MajFbtarif2`/`Impart`, identique à `MajTarifM` au nom de variable près).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.db`,
  `Utils.cpoint`, `Utils.Find_nbdec`, `Cbase.Table`, `Variables.Sprix/Sexport/SMajArt`,
  `Serveur.Pass`, `EtiqRecpt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Prix_achat` (mort) et `Calc_Marge` (sans effet) avec les variables `Margem`,
  `Margep`, `Stocke`.
- Factoriser les deux boucles de `Button2_Click` : la partie étiquettes + export est identique
  (CC 31 → ≤ 12).

### Commonalisation avec d'autres fichiers

- Classe d'état `LTarifCalc` proposée par MAJFBTARIF2-004 ([`MajFbtarif2`](../MajFbtarif2.class/architecture.md),
  [`Etiqfbtarif`](../../../Etiquettes/Etiqfbtarif.class/architecture.md)) : `TrC`, `rTva`,
  `Tva_Calcul`, `PvTTC_arrondi`, `Calc_coeff`, `PvTTcLF` identiques ; `prix_base` et
  `Calc_Percent` restent des variantes locales.
- `ChkPrx`, liste fournisseurs (`Button4_Click`, `fourList_*`) : mêmes codes dans
  [`MajTarifM`](../MajTarifM.class/architecture.md), [`Impart`](../Impart.class/architecture.md).
- `Maj_Etiqp`/`Maj_Etiqg` : module `EtiqMaj` (MAJFBTARIF2-005), variante « gondole sans mise à jour ».
- `rTva` ≈ [`CPrix.CTva`](../../../../Utils/CPrix.module/architecture.md) (renvoie `""` si absent :
  différence à conserver).
- Garde d'export → `Serveur.Actif` (SERVEUR-008).

### Réduction de portée

- `ChkPrx`, `fourMan`, `prix_base`, `PvTTcLF`, `TrC`, `Prix_achat`, `rTva`, `Tva_Calcul`,
  `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `Maj_Etiqp`, `Maj_Etiqg` →
  `Private` (aucun appelant externe ; `grep` vérifié).

### Séparation traitement / GUI

- Extraire `AppliquePourcentage(sFour, fPct, bBrut) As Integer` de `Button2_Click` (SQL et calcul),
  le handler gardant messages, souris et question d'impression.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un historique des hausses tarifaires (`Fiches_HistoTarif`) permettrait d'annuler une mise à
  jour en pourcentage, aujourd'hui irréversible.
