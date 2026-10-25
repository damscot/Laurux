# Edmo — Architecture

> Source : `.src/Gestion/Impressions/Edmo.class` · Formulaire : `.src/Gestion/Impressions/Edmo.form`

## Vue d'ensemble

`Edmo` est l'écran d'**impression de la liste des mains d'oeuvre** (menu « Main d'oeuvre »,
`Fmenu.Menu59_Click` → `Edmo.Show`). Plages main d'oeuvre `Mo`–`Mo2` et famille `Fam`–`Fam2`
(défauts `00000`–`ZZZZZ`), tri par code (`RadioButton1`, défaut) ou par famille puis code. 
**Imprimer** produit `~/tmp/MO.pdf` avec `Carticles` (`Level1MO`, `Level2MO`) : code, intitulé,
famille, fournisseur, code tarif (`mo_txcd`), quantité (`mo_montant`), montant HT, code TVA,
montant TTC, indicateur temps/montant (`mo_tempmont`). Le montant HT vaut `mo_valeurht`, ou
`mo_txht × mo_montant` quand `mo_tempmont = 1` ; le TTC est recalculé avec le taux de
`Fiches_Tvaav` (`Valeur2TTC_Calcul`), sans relire `mo_valeurttc`.

Structure copiée des éditions d'articles (41 % avec [`EdArt1`](../EdArt1.class/architecture.md),
40 % avec [`EdStk`](../EdStk.class/architecture.md)) : 4 listes `ColumnView` (main d'oeuvre ×2,
famille ×2), mêmes `Btn_*`/`Cmpt_*`.

Nature globale : **GUI** ; SQL et calcul TTC dans `Button2_Click` (CC 11) et `Valeur2TTC_Calcul`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `PosY` | var | Private |  | Integer | 30 |
| `son` | var | Private |  | Integer | 31 |
| `Tva` | var | Private |  | String | 32 |
| `Txht` | var | Private |  | String | 33 |
| `montant` | var | Private |  | String | 34 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-49 | Public | 1 | 11 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 54-86 | Public | 5 | 30 | 0 | handler GUI |
| `Colmo_KeyPress` | 91-110 | Public | 6 | 16 | 0 | handler GUI |
| `ToggleButton2_Click` | 115-147 | Public | 5 | 30 | 0 | handler GUI |
| `ColMo2_KeyPress` | 152-172 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton3_Click` | 177-209 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam_KeyPress` | 214-234 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 239-271 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam2_KeyPress` | 276-296 | Public | 6 | 17 | 0 | handler GUI |
| `Colmo_Click` | 301-309 | Public | 1 | 7 | 0 | handler GUI |
| `ColMo2_Click` | 314-322 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam_Click` | 327-335 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 340-347 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 349-365 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 367-376 | Public | 4 | 8 | 0 | handler GUI |
| `Cmpt_KeyPress` | 378-409 | Public | 9 | 26 | 0 | handler GUI |
| `Cmpt_GotFocus` | 414-420 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 422-497 | Public | 11 | 73 | 0 | portée réductible ? |
| `Valeur2TTC_Calcul` | 502-516 | Public | 2 | 12 | 0 | portée réductible ? |
| `Button1_Click` | 518-522 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et listes

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)`, son,
  centrage, plages par défaut, focus sur `Mo`.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : mixte]. Listes `ColMo`/`ColMo2` : `SELECT * FROM Fiches_Mo order by mo_code` (en dur),
  colonnes code / `mo_design`.
- **`ToggleButton3_Click()` / `ToggleButton4_Click()`** [portée : nécessaire (handler)]
  [nature : mixte]. Listes `Colfam`/`Colfam2` : `SELECT * FROM Fiches_Fam order by code_fam`.
- **`Colmo_KeyPress()`, `ColMo2_KeyPress()`, `Colfam_KeyPress()`, `Colfam2_KeyPress()`**
  [portée : nécessaire (handlers)] [nature : GUI]. Entrée → clic ; F1 aide ; Échap/F2 fermeture
  (sans vider la liste pour `ColMo`). `Colfam2` : focus `fam`, sélection `fam2` (l. 291-292).
- **`Colmo_Click()`, `ColMo2_Click()`, `Colfam_Click()`, `Colfam2_Click()`** [portée : nécessaire
  (handlers, rejeu dynamique)] [nature : GUI]. Copient le code. ⚠️ `ColMo2_Click` renvoie le focus
  sur `Mo` (1ᵉʳ champ) au lieu de `Fam` ; commentaires « fournisseur » erronés sur les listes de
  familles.

### Navigation et boutons

- **`Btn_Click()`** (tag 2 impression, tag 3 suppression du PDF et fermeture, tag 1 inatteignable),
  **`Btn_KeyPress()`** (impression sur Entrée/Retour seulement, contrairement aux autres écrans du
  lot), **`Cmpt_GotFocus()`** (`SetEditColor`), **`Button1_Click()`** (`Doc.Open("Edmo")`) [portée :
  nécessaire (handlers)] [nature : GUI].
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI] (CC 9). Champ suivant ; le
  tag 4 (`Fam2`) renvoie sur `Mo` au lieu du bouton Imprimer ; F1 aide ; pas de F2.

### Impression et calcul

- **`Button2_Click()`** [portée : réductible (`Button2` dans le groupe `btn`)] [nature : mixte]
  (CC 11). `Shell "cd ~"` (sans effet), `New CArticles`, `Entete("Impression de la main d'oeuvre")`,
  `Level1MO` (la colonne TVA porte le libellé `/Soc<XX>/Taxe`), `PosY = 30`. `SELECT * FROM
  Fiches_Mo WHERE mo_code BETWEEN … AND mo_fam BETWEEN … order by mo_code | mo_fam, mo_code`. Par
  ligne : `Try txht = Format$(mo_valeurht, "0.00")` ; en erreur `Message.Warning("Veuillez verifier
  le taux horaire …")` puis **`Return`** (curseur laissé en attente, PDF non produit) ; si
  `mo_tempmont = 1`, `txht = mo_txht × mo_montant` (même traitement d'erreur) ; `Valeur2TTC_Calcul` ;
  `Level2MO` ; saut à 280 mm. Sans ligne : son, message, puis **`Draw.End`** sans `Draw.Begin`
  (l. 493 : erreur d'exécution probable, à confirmer).
- **`Valeur2TTC_Calcul()`** [portée : réductible] [nature : calcul]. Lit les membres `Tva` et
  `Txht`, `SELECT * FROM Fiches_Tvaav WHERE code_tva = &1` (`Cbase.Table("TabTvav")`), `Montant =
  Txht × (1 + taux/100)` formaté `"0.00"` (après un premier `Format$` sans format). Effet de bord :
  écrit le membre `Montant`. Une requête TVA par ligne.

## État global utilisé

- `Start.Musique`, `Start.Son`, `Start.Societe`, `Start.LocalSettings` (`/Soc<XX>/Taxe` via
  `Carticles.Level1MO`).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.cpoint`,
  `Cbase.Table("TabTvav")`, `Visualiseur.Prog`, `Doc.Open`, `Draw`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Valeur2TTC_Calcul` → fonction pure `MontantTTC(txht As String, taux As Float) As String` et
  lecture du taux mise en cache par code TVA (une requête par code au lieu d'une par ligne : SQL
  modifié, PDF identique).
- Supprimer `Nbpage`, `dte`, `Shell`, `With Utils`, `Case 1` de `Btn_Click`.

### Commonalisation avec d'autres fichiers

- Listes famille et main d'oeuvre : socle `EdSelection.ListeCodes`
  ([EdArt1/architecture.md](../EdArt1.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- Calcul TTC à partir d'un code TVA : `Valeur2TTC_Calcul` existe sous le même nom dans
  [`Movr`](../../Tables/Movr.class/architecture.md) (seule autre définition, grep) et
  `LPrix`/`LTaxe` fournissent la conversion HT → TTC : à converger vers `LPrix` (phase 3, équivalence
  d'arrondi à prouver).

### Réduction de portée

- `Button2_Click`, `Valeur2TTC_Calcul` : aucun appelant externe (grep `Edmo.`, seul
  `Fmenu.class:823`) → `Private`.

### Séparation traitement / GUI

- `Button2_Click` : `SelectMo(bornes, tri) As Result` + `LigneMo(r) As String[]` (HT, TTC) pure ;
  messages et PDF dans le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `mo_valeurttc` existe en base mais n'est pas utilisé : soit le supprimer, soit l'imprimer au
  lieu de recalculer le TTC.
