# Suivi — Architecture

> Source : `.src/Gestion/Suivi.class` · Formulaire : `.src/Gestion/Suivi.form`

## Vue d'ensemble

`Suivi` est la fenêtre modale de **suivi d'affaire** (comparaison prévu / réalisé d'un devis) :
pour un document (devis ou facture) et un client, elle saisit et enregistre dans `Fiches_Suivis`
deux colonnes de chiffres :

- **prévu** (`Qte`, `Ach`, `Vtes`) : heures de main-d'œuvre, achats et ventes d'articles du devis ;
- **réalisé** (`Qte2`, `Ach2`, `Vtes2`) : mêmes grandeurs constatées ;

et calcule à l'écran : total MO (`qte × taux MO`), marge MO (`total − prix de revient MO × qte`),
marge articles (`ventes − achats`), marge totale, puis les **écarts** prévu/réalisé (`EmargeMO`,
`EmargeArt`, `EmargeTot`). Le taux et le prix de revient de la main-d'œuvre viennent de
`Fiches_Txtmo` pour le code `/Soc<XX>/CodeMO` des préférences.

Points d'entrée (touche F12) : `Facture.class:3331`, `5664`, `7865` (trois appels identiques depuis
l'écran devis/facture) et `Archives.class:1435` (consultation d'une facture archivée, recherche par
`numfac`). Les drapeaux du constructeur règlent l'éditabilité : sur une facture, le prévu est en
lecture seule ; sur une facture imprimée, tout est en lecture seule ; sur un devis, le cadre
« réalisé » (`Frame6`) est masqué.

Nature globale : **mixte** ; les calculs de marge lisent et écrivent directement les `TextBox`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rResult` | var | Private |  | Result | 27 |
| `PrMo` | var | Private |  | String | 28 |
| `Devis` | var | Private |  | Boolean | 29 |
| `Fac` | var | Private |  | Boolean | 30 |
| `son` | var | Private |  | Integer | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 33-125 | Public | 14 | 83 | 0 | méthode spéciale |
| `Button3_Click` | 127-131 | Public | 1 | 3 | 0 | handler GUI |
| `Qte_KeyPress` | 133-144 | Public | 5 | 10 | 0 | handler GUI |
| `Qte_GotFocus` | 146-150 | Public | 2 | 3 | 0 | handler GUI |
| `Qte_LostFocus` | 152-166 | Public | 6 | 13 | 0 | handler GUI |
| `Ach_KeyPress` | 168-179 | Public | 5 | 10 | 0 | handler GUI |
| `Ach_GotFocus` | 181-185 | Public | 2 | 3 | 0 | handler GUI |
| `Ach_LostFocus` | 187-195 | Public | 3 | 7 | 0 | handler GUI |
| `Vtes_KeyPress` | 197-208 | Public | 5 | 10 | 0 | handler GUI |
| `Vtes_GotFocus` | 210-214 | Public | 2 | 3 | 0 | handler GUI |
| `Vtes_LostFocus` | 216-224 | Public | 3 | 7 | 0 | handler GUI |
| `Qte2_KeyPress` | 226-235 | Public | 4 | 8 | 0 | handler GUI |
| `Qte2_GotFocus` | 237-241 | Public | 2 | 3 | 0 | handler GUI |
| `Qte2_LostFocus` | 243-249 | Public | 2 | 5 | 0 | handler GUI |
| `Ach2_KeyPress` | 251-260 | Public | 4 | 8 | 0 | handler GUI |
| `Ach2_GotFocus` | 262-266 | Public | 2 | 3 | 0 | handler GUI |
| `Ach2_LostFocus` | 268-274 | Public | 2 | 5 | 0 | handler GUI |
| `Vtes2_KeyPress` | 276-290 | Public | 5 | 13 | 0 | handler GUI |
| `Vtes2_GotFocus` | 292-296 | Public | 2 | 3 | 0 | handler GUI |
| `Vtes2_LostFocus` | 298-304 | Public | 2 | 5 | 0 | handler GUI |
| `Chkinput` | 306-314 | Public | 7 | 7 | 0 | portée réductible ? |
| `Calc_MargeMo` | 316-323 | Public | 1 | 6 | 0 | portée réductible ? |
| `Calc_MargeArt` | 325-331 | Public | 1 | 5 | 0 | portée réductible ? |
| `Calc_MargeTotale` | 333-339 | Public | 1 | 5 | 0 | portée réductible ? |
| `Calc_MargeMo2` | 341-348 | Public | 1 | 6 | 0 | portée réductible ? |
| `Calc_MargeArt2` | 350-356 | Public | 1 | 5 | 0 | portée réductible ? |
| `Calc_MargeTotale2` | 358-364 | Public | 1 | 5 | 0 | portée réductible ? |
| `Calc_Emarge` | 366-387 | Public | 3 | 20 | 0 | portée réductible ? |
| `Button2_Click` | 389-402 | Public | 2 | 11 | 0 | handler GUI |
| `Button1_Click` | 404-414 | Public | 3 | 9 | 0 | handler GUI |
| `Button4_Click` | 419-423 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et chargement

- **`_new(cod, Cv, Nm, Pnm, Num, Datej, NumF, DateF, bdevis, bFacture, Impfac)`** [portée :
  nécessaire, 4 appelants] [nature : mixte] (l. 33-125, CC 14).
  - Règle l'éditabilité selon `bdevis`, `bFacture`, `Impfac` (fond `&D4D0C8&`) ; `DateF` est
    inutilisé.
  - Si `cod` est renseigné : code client, nom (`Cv Nm Pnm`), n° et date du document.
  - `SELECT * FROM Cbase.Table("TabTxmo") WHERE code_txtmo = /Soc<XX>/CodeMO` : taux (`PUmo`,
    `PUmo2`) et prix de revient `PrMo`. Absent : avertissement « taux de MO non défini ».
  - ⚠️ Si le prix de revient est nul, avertissement **et le suivi enregistré n'est pas chargé**
    (le `SELECT` sur `Fiches_Suivis` est dans la branche `Else`, l. 86-118) : l'utilisateur voit
    un écran vide et un enregistrement écraserait les valeurs existantes (SUIVI-A01).
  - Sinon `SELECT * FROM Cbase.Table("TabSuivis") WHERE numdev = &1 AND code = &2` (ou
    `WHERE numfac = &1 AND code = &2` si `NumF` est fourni, cas `Archives`) et remplit les 18
    champs, puis `Calc_MargeArt` et `Calc_MargeArt2` (la marge MO est relue telle qu'enregistrée).
  - Le test `Val(cpoint(PrMo)) = 0 Or If IsNull(PrMo)` évalue `Val` avant le test de nullité.

### Saisie (handlers)

- **`Qte|Ach|Vtes|Qte2|Ach2|Vtes2_KeyPress`** [handlers] [GUI] : filtrage des caractères
  (`Chkinput`) et passage au champ suivant sur Tab/Entrée ; la colonne « prévu » n'est active que
  pour un devis ; `Vtes2` reboucle sur `Qte` (devis) ou `Qte2`.
- **`…_GotFocus`** [handlers] [GUI] : `Utils.ObsGotf` (couleur de focus).
- **`…_LostFocus`** [handlers] [mixte] : `Utils.Formattage`, `Utils.ObsLstf`, puis recalcul
  (`Calc_MargeMo[2]` ou `Calc_MargeArt[2]`). `Qte_LostFocus` refuse une quantité nulle par
  `Message.Error` (pas `Qte2_LostFocus`).
- **`Chkinput()`** [portée : réductible] [nature : GUI] : n'accepte que `0-9 , .` et les touches de
  navigation. Copie exacte de `SupprArt.ChkPrx` (code mort là-bas).

### Calculs de marge (mixtes : calcul + écriture des TextBox)

- **`Calc_MargeMo()` / `Calc_MargeMo2()`** [réductibles] : `TotMo = qte × PUmo`,
  `MargeMo = TotMo − PrMo × qte`, coloration (`Utils.Coulfonds`), puis marge totale.
- **`Calc_MargeArt()` / `Calc_MargeArt2()`** [réductibles] : `MargeArt = Vtes − Ach`.
- **`Calc_MargeTotale()` / `Calc_MargeTotale2()`** [réductibles] : `TotMarge = MargeMo +
  MargeArt`, puis `Calc_Emarge`.
- **`Calc_Emarge()`** [réductible] (l. 366-387) : par branches et préfixe `"-"`, calcule en fait
  `EmargeMO = MargeMo − MargeMo2` (prévu − réalisé) mais `EmargeArt = MargeArt2 − MargeArt`
  (réalisé − prévu) : **conventions de signe opposées** pour la MO et les articles, et
  `EmargeTot` additionne les deux (SUIVI-A02). Les variantes `…2` sont des copies des fonctions
  « prévu » avec d'autres contrôles.

  Toutes les conversions passent par `Val(Utils.cpoint(x))` : un champ vide donne `Null`
  (comportement de l'arithmétique sur `Null` à confirmer par les tests).

### Enregistrement et suppression

- **`Button2_Click()`** [handler] [nature : mixte] (l. 389-402) : `SELECT … WHERE numdev = &1` (sans
  le code client) puis `UPdate … WHERE numdev = &3` ou `INSERT INTO Cbase.Table("TabSuivis")`
  des 18 colonnes (montants `Val(cpoint(...))`, dates `Utils.Cdate_Dbase`). Clé incohérente avec le
  chargement et la suppression (`numdev` + `code`) : deux clients avec le même n° de devis
  s'écraseraient (SUIVI-A03). Aucun message de confirmation.
- **`Button1_Click()`** [handler] [mixte] : confirmation, `DELETE FROM TabSuivis WHERE numdev = &1
  AND code = &2`, fermeture.
- **`Button3_Click()`** : fermeture. **`Button4_Click()`** : `Doc.Open("Suivi")`.

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/CodeMO"]`, `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Aff`, `Utils.Cdate_Dbase`, `Utils.Formattage`,
  `Utils.ObsGotf`, `Utils.ObsLstf`, `Utils.Coulfonds`, `Cbase.Table("TabTxmo" | "TabSuivis")`.
- Tables : `Fiches_Txtmo` (lecture), `Fiches_Suivis` (lecture, INSERT, UPDATE, DELETE ; clé
  primaire `lind` auto-incrémentée, aucune unicité sur `numdev`/`code`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Calc_Emarge` : remplacer les branches par deux soustractions directes formatées
  (`Format$(a − b, "0.00")`), **résultat textuel identique** (à vérifier par SUIVI-T04, y compris
  l'écart nul).
- Factoriser les paires `Calc_MargeMo`/`Calc_MargeMo2`, `Calc_MargeArt`/`Calc_MargeArt2`,
  `Calc_MargeTotale`/`Calc_MargeTotale2` en fonctions paramétrées par colonne (prévu/réalisé).
- Factoriser les 6 `…_GotFocus` et les 6 `…_LostFocus` quasi identiques (helpers privés), sans
  toucher aux noms des handlers.
- Factoriser l'éditabilité (`ReadOnly` + fond) répétée 9 fois dans `_new`.

### Commonalisation avec d'autres fichiers

- `Chkinput` = `SupprArt.ChkPrx` (et motif fréquent dans le projet) → helper
  `Utils.FiltreNumerique()` à créer en phase 3.
- Les trois appels `New Suivi(…)` de [`Facture`](../Facturation/Facture.class/architecture.md)
  (l. 3331, 5664, 7865) sont identiques : à factoriser côté `Facture` (gros fichier legacy, rework
  minimal).

### Réduction de portée

- `Chkinput`, `Calc_*` (8 fonctions) : aucun appelant externe (grep) → `Private`, couverts par les
  replays.

### Séparation traitement / GUI

- Extraire des fonctions pures `MargeMo(qte, pu, prmo) As Float`, `MargeArt(vtes, ach)`,
  `Ecart(prevu, realise)` testables en gb.test ; les `Calc_*` ne font plus que lire/écrire les
  contrôles.
- Extraire `ChargeSuivi(numdev, code, numfac) As Result` et `EnregistreSuivi(valeurs)` (SQL sans
  contrôle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique `(numdev, code)` sur `Fiches_Suivis` (actuellement seule `lind` est clé) pour
  garantir un suivi par devis et par client.
- Le prix de revient MO pourrait être historisé dans `Fiches_Suivis` (aujourd'hui relu à chaque
  ouverture dans `Fiches_Txtmo`, ce qui change la marge MO recalculée d'un suivi ancien).
