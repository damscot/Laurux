# SaisieInvT — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class`

## Vue d'ensemble

Écran de **saisie des comptages de l'inventaire tournant** (menu 96,
[`Fmenu.class:1097`](../../../../../Communs/Fmenu.class/architecture.md), `SaisieinvT.Show`), sur
la table `Fiches_InvT` créée par [GeninvT](../GeninvT.class/architecture.md).

C'est une **copie à 93 %** de [SaisieInv](../../Fin-annee/SaisieInv.class/architecture.md)
(389 lignes communes, 19 fonctions homonymes sur 20) : la description fonctionnelle (modes de
saisie, groupes `Btn`/`Rcpt`, cumul/remplacement, rappel, suppression, import portable) y est
détaillée et vaut ici. Seules les **différences** sont décrites ci-dessous.

| Point | SaisieInv | SaisieInvT |
|---|---|---|
| Table | `TabInv` / `Fiches_Inv` | `TabInvT` / `Fiches_InvT` |
| Écart en lecture (`Saisie_Inv`) | `Try` + repli si `inv_qtecomptee` Null | sans `Try` |
| `Nseq_LostFocus` | `SELECT art_code, art_design, art_qte, art_dec FROM Cbase.Table("TabArt")` | `SELECT * FROM Fiches_Art` (littéral) |
| `Colinv_Activate` | lit `Colinv.Current[…]` | lit `Colinv.Item[…]` (curseur interne, pas forcément la ligne activée) |
| Entrée dans la grille | rappelle la ligne | sans effet (seul le double-clic rappelle) |
| `Nl_Click`/`Ca_Click` | — | repositionnent `Cart` (`X`, `Width`) |
| Import : fichier absent | message + `Return` | **aucun contrôle** : `Eof(Null)` → erreur |
| Import : quantité vide | `cle <> ""` | `cle <> 0` (comparaison chaîne/entier, à confirmer) |
| `Button3_Click` | absent | présent mais **jamais levé** (`Button3` est dans le groupe `btn`) |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hfil` | var | Private |  | File | 3 |
| `Lig` | var | Private |  | String | 4 |
| `iPos` | var | Private |  | Integer | 5 |
| `son` | var | Private |  | Integer | 6 |
| `Dcem` | var | Private |  | String | 7 |
| `Lgrappel` | var | Private |  | Boolean | 8 |
| `filename` | var | Private |  | String | 9 |
<!-- /AUTO:declarations -->

Identiques à SaisieInv (`hfil`, `Lig`, `iPos` à rendre locaux ; `Dcem`, `Lgrappel`, `filename`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 14-48 | Public | 1 | 29 | 0 | méthode spéciale |
| `Saisie_Inv` | 53-93 | Public | 9 | 38 | 0 | portée réductible ? |
| `Btn_Click` | 98-133 | Public | 10 | 31 | 0 | handler GUI |
| `Btn_KeyPress` | 138-147 | Public | 5 | 8 | 0 | handler GUI |
| `Rcpt_GotFocus` | 152-158 | Public | 1 | 5 | 0 | handler GUI |
| `Nseq_LostFocus` | 163-188 | Public | 3 | 20 | 0 | portée réductible ? |
| `Cart_LostFocus` | 190-201 | Public | 2 | 10 | 0 | portée réductible ? |
| `Art_man` | 206-245 | Public | 9 | 37 | 0 | portée réductible ? |
| `qtecomptee_LostFocus` | 250-268 | Public | 4 | 17 | 0 | handler GUI |
| `Rcpt_KeyPress` | 270-307 | Public | 11 | 32 | 0 | handler GUI |
| `Valigne` | 312-363 | Public | 6 | 43 | 0 | portée réductible ? |
| `Colinv_Activate` | 368-390 | Public | 1 | 19 | 0 | handler GUI |
| `Colinv_Keypress` | 395-415 | Public | 6 | 17 | 0 | handler GUI |
| `RadioButton1_Click` | 417-421 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton2_Click` | 423-427 | Public | 1 | 3 | 0 | handler GUI |
| `Nl_Click` | 429-439 | Public | 1 | 9 | 0 | handler GUI |
| `Ca_Click` | 441-451 | Public | 1 | 9 | 0 | handler GUI |
| `Button2_Click` | 453-457 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 459-463 | Public | 1 | 3 | 0 | portée réductible ? |
| `Import_Portable` | 468-546 | Public | 23 | 75 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

Pour `_New`, `Saisie_Inv`, `Btn_Click`, `Btn_KeyPress`, `Rcpt_GotFocus`, `Nseq_LostFocus`,
`Cart_LostFocus`, `Art_man`, `qtecomptee_LostFocus`, `Rcpt_KeyPress`, `Valigne`,
`Colinv_Activate`, `Colinv_Keypress`, `RadioButton1_Click`, `RadioButton2_Click`, `Nl_Click`,
`Ca_Click`, `Import_Portable` et `Button2_Click` : voir
[SaisieInv](../../Fin-annee/SaisieInv.class/architecture.md) (mêmes étiquettes de portée et de
nature, même SQL sur `Fiches_InvT`), avec les différences du tableau ci-dessus.

- **`Saisie_Inv(Type)`** [réductible] [mixte] : écart calculé sans `Try` (l. 78).
- **`Nseq_LostFocus()`** [réductible — non levé] [mixte] : `SELECT *` sur `Fiches_Art` (littéral).
- **`Colinv_Activate()`** [handler] [mixte] : recopie `Colinv.Item[0..4]` mais supprime
  `Colinv.Current` ; si le curseur interne n'est pas sur la ligne activée, les champs reçoivent une
  autre ligne que celle retirée et remise à 0 (SAISIEINVT-A08, à confirmer).
- **`Colinv_Keypress()`** [handler] [mixte] : Suppr / F1 seulement.
- **`Nl_Click()` / `Ca_Click()`** [handlers] [GUI] : déplacent et redimensionnent `Cart`.
- **`Button3_Click()`** [portée : réductible — **code mort**] [GUI] : `Import_Portable()` ; jamais
  levé car `Button3` appartient au groupe `btn` (l'import passe par `Btn_Click`, Tag 4). Signalé
  `unused` et `handlers_inactifs` par `deps.py` : confirmé.
- **`Import_Portable()`** [réductible] [mixte] : pas de test d'erreur après `Try HFil = Open`
  (l. 483) ; test de quantité `cle <> 0` (l. 514) ; message de rejet « Code produit absent de
  l'inventaire ou code barre inexistant ».

## État global utilisé

Identique à SaisieInv ; table `Fiches_InvT`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Mêmes propositions que SaisieInv (`Split`, `MajComptage`, variables locales).

### Commonalisation avec d'autres fichiers

- Module `Inventaire` (voir [Geninv](../../Fin-annee/Geninv.class/architecture.md)) partagé avec
  [SaisieInv](../../Fin-annee/SaisieInv.class/architecture.md) : tout le SQL et l'import,
  paramétrés par `"T"`. Une fois les deux classes réduites à leurs handlers, les divergences
  accidentelles ci-dessus disparaissent d'elles-mêmes — mais celles qui changent un comportement
  visible sont des anomalies à valider (A08-A10).
- Parseur portable commun avec `Achat`, `Facture`, `Majcasier` (voir SaisieInv).

### Réduction de portée

- `Saisie_Inv`, `Nseq_LostFocus`, `Cart_LostFocus`, `Art_man`, `Valigne`, `Import_Portable` →
  `Private` (aucun appelant externe ; vérifié par grep).

### Séparation traitement / GUI

- Comme SaisieInv.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir SaisieInv (index `inv_code`, historique des comptages).
