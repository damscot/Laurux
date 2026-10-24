# FTvav — Architecture

> Source : `.src/Compta/Tables/FTvav.class`

## Vue d'ensemble

Écran de la **table des codes TVA sur ventes** (`Fiches_Tvaav` : `code_tva` char(2) clé,
`taux_tva` varchar(5), `cc_tva`). Même formulaire et même logique que
[FTvac](../FTvac.class/architecture.md), avec deux différences :

- un compte de TVA ne peut pas être attribué à deux codes (contrôle dans `Button1_Click`) ;
- quand le taux d'un code change, l'écran propose de **recalculer les données** (`Recalcul`) :
  taux des familles, TTC des lignes des documents clients non facturés (`Fiches_Ligbl`,
  `Fiches_LigblM`), prix TTC des articles et des main-d'œuvre, avec la règle d'arrondi de l'article.

Ouvert par `Fmenu.Menu112_Click` (`Show`) et par `Parametre` (`ShowModal` de l'auto-instance, l.248,
282, 567) quand un code TVA saisi n'existe pas.

Nature : **GUI** pour la table, **traitement de masse** pour `Recalcul`/`arrondi` (sans accès aux
contrôles, sauf la lecture de `Cdtva.Text` et `Txtva.Text`).

### Contrôles en groupe

`Cdtva`, `Txtva`, `Tvacc` sont dans le groupe `tva` : `Cdtva_GotFocus`, `Txtva_LostFocus`,
`Tvacc_GotFocus` ne sont jamais déclenchés par Gambas, mais sont appelés explicitement. Il n'existe
pas de `Tvacc_LostFocus` : `Tvaman` n'est appelée nulle part, `Enr` reste à 0 et Entrée sur le
compte ramène toujours le focus sur `Tvacc` (même défaut que FTvac, anomalie FTVAV-A03).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dne` | var | Private |  | String | 29 |
| `Enr` | var | Private |  | Integer | 30 |
| `son` | var | Private |  | Integer | 31 |
| `Txtva2` | var | Private |  | String | 32 |
| `rResult3` | var | Private |  | Result | 33 |
| `arr` | var | Private |  | String | 34 |
| `nbdec` | var | Private |  | String | 35 |
| `Pvttc` | var | Private |  | String | 36 |
| `b` | var | Private |  | Boolean | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 39-57 | Public | 1 | 16 | 0 | méthode spéciale |
| `Form_Open` | 59-75 | Public | 5 | 14 | 0 | handler GUI |
| `Refresh` | 77-87 | Public | 1 | 8 | 0 | portée réductible ? |
| `Maj_Zones` | 89-106 | Public | 3 | 15 | 0 | portée réductible ? |
| `Cleanchamps` | 108-114 | Public | 1 | 5 | 0 | portée réductible ? |
| `Tva_GotFocus` | 119-131 | Public | 2 | 10 | 0 | handler GUI |
| `Tva_KeyPress` | 133-179 | Public | 16 | 40 | 0 | handler GUI |
| `Btn_KeyPress` | 181-190 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 192-218 | Public | 7 | 20 | 0 | handler GUI |
| `Cdtva_GotFocus` | 220-224 | Public | 1 | 3 | 0 | portée réductible ? |
| `Txtva_LostFocus` | 226-240 | Public | 2 | 12 | 0 | portée réductible ? |
| `Tvacc_GotFocus` | 242-246 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tvalist_Click` | 248-252 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 254-286 | Public | 6 | 30 | 0 | portée réductible ? |
| `Button3_Click` | 288-309 | Public | 5 | 19 | 0 | portée réductible ? |
| `Button4_Click` | 311-343 | Public | 5 | 30 | 0 | handler GUI |
| `Tvavlist_Click` | 345-352 | Public | 1 | 6 | 0 | handler GUI |
| `Tvavlist_KeyPress` | 357-379 | Public | 6 | 19 | 0 | handler GUI |
| `Button5_Click` | 381-385 | Public | 1 | 3 | 0 | handler GUI |
| `Tvaman` | 387-403 | Public | 3 | 14 | 0 | portée réductible ? |
| `Recalcul` | 405-504 | Public | 25 | 93 | 0 | portée réductible ? |
| `arrondi` | 509-547 | Public | 11 | 34 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste et zones

- **`_New()`**, **`Form_Open()`**, **`Refresh()`**, **`Maj_Zones()`** : comme dans FTvac
  (`SELECT * FROM Fiches_Tvaav`, sans `ORDER BY`). `Maj_Zones` mémorise en plus le taux affiché dans
  `Txtva2`. [portée : réductible pour `Refresh`/`Maj_Zones`] [nature : GUI].
- **`Cleanchamps()`** : **code mort** (aucun appel).
- **`Tva_GotFocus()`** [handler] : `SetEditColor` ; sur le taux (tag 2), `b = False` et
  `Txtva2 = Txtva.Text`.
- **`Tva_KeyPress()`** (CC 16) [handler] : comme FTvac ; sur le taux, `Txtva_LostFocus()` est
  appelé explicitement avant de passer au compte.
- **`Cdtva_GotFocus` / `Tvacc_GotFocus`** : coloration (appels explicites).
- **`Txtva_LostFocus()`** [nature : calcul + GUI] : taux non numérique → `"0.00"`, sinon reformaté
  `Format$(…, "0.00")` (virgule en locale française).
- **`Tvaman()`** : contrôle d'existence du compte ; **jamais appelée**.

### Boutons

- **`Btn_Click()`** [handler, groupe `Btn`] (CC 7) : tag 1 supprimer ; tag 2 : `Txtva_LostFocus()`,
  puis si le taux diffère de `Txtva2`, `Message.Warning(… "Oui", "Non")` : Non → taux restauré ;
  Oui → `Recalcul()` sous curseur d'attente. Ensuite `If b = False Then Button1_Click()` (`b` vaut
  toujours `False`). ⚠️ `Recalcul` s'exécute **avant** les contrôles de `Button1_Click` et même si
  le code est vide (anomalie A01). Tag 3 : fermeture.
- **`Btn_KeyPress()`** [handler] : toute touche sur Enregistrer appelle `Button1_Click` **sans**
  proposer le recalcul (A02).
- **`Button1_Click()`** [nature : mixte] : si le compte de TVA est déjà attribué à un autre code
  (`SELECT … WHERE cc_tva = &1`), `Message.Question(…, "Ok")` et sortie ; sinon même logique que
  FTvac (UPDATE/INSERT par concaténation, recopie paramétrée du taux dans
  `Fiches_Comptes.taux_tvente`), puis `Refresh`.
- **`Button3_Click()`** : suppression contrôlée par `Fiches_Comptes.code_tvente`, sur
  `Tvalist.Current[0]` (même défaut que FTvac).
- **`Button4_Click`, `Tvavlist_Click`, `Tvavlist_KeyPress`** : liste des comptes `445…` (identique à
  FTvac, contrôle `Tvavlist`).
- **`Tvalist_Click()`** : `Maj_Zones`. **`Button5_Click()`** : `Doc.Open("Tvaventes")`.

### Recalcul des données (traitement)

- **`Recalcul()`** (CC 25, max du fichier) [portée : réductible] [nature : calcul, lit `Cdtva`/`Txtva`].
  1. Familles : `select * from <TabFam> where cdtva_fam = &1`, puis **un UPDATE par famille**
     `SET txtva_fam = PointBase(taux) WHERE code_fam = &2`.
  2. Documents clients non facturés (`<TabBl>` : `type <> 'F' or type = 'F' and imp = 0`) : pour
     chaque document, lignes `<TabLigbl>` de type `A` (article) ou `M` (main-d'œuvre) ayant ce code :
     - `A` : lecture de l'article (`art_nbd` → format via `Utils.Find_nbdec`, `art_cdarr`),
       `Pvttc = netht × (1 + taux/100)`, `arrondi()`, `UPdate … SET nettc_ligbl = &1` (chaîne
       formatée, virgule) ;
     - `M` : lecture inutile de `<TabMo>`, `Pvttc` calculé **sans arrondi ni format** (conversion
       Float → String implicite) puis UPDATE.
  3. Même traitement pour `<TabBlM>`/`<TabLigblM>` (bons d'entretien), mais la ligne article y est lue
     **sans test `Available`** (erreur si l'article a été supprimé).
  4. Articles (`art_tva = code`) : `art_pvttc = Val(Pvttc)` arrondi selon l'article.
  5. Main-d'œuvre (`mo_tva = code`, `mo_valeurht` non nul) : `mo_valeurttc`, format `0.00`.
  Aucune transaction ; une requête par ligne de document (N+1).
- **`arrondi()`** (CC 11) [portée : réductible] [nature : calcul sur l'état membre `Pvttc`/`arr`/`Nbdec`].
  `Utils.cpoint`, puis selon `arr` : `"0,01"` format ; `"0,05"` dernier caractère `[34567]` → `5`,
  sinon arrondi au dixième ; `"0,10"` arrondi au dixième ; `"0,50"` découpage par chaîne
  (≤ ,25 → ,00 ; ≤ ,75 → ,50 ; ≥ ,76 → unité supérieure) ; `"1,00"` arrondi à l'unité. Même famille
  d'algorithmes que `Utils.arrondi` et `LPrix.Arrondi_Calc`, mais **pas le même code** : les
  résultats peuvent différer (à figer par test).

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Utils.Find_nbdec`, `Utils.SetEditColor`,
  `Utils.Observers` ; `Cbase.Table` (`TabComptes`, `TabFam`, `TabBl`, `TabLigbl`, `TabBlM`,
  `TabLigblM`, `TabArt`, `TabMo`) ; `Start.Son`, `Start.Musique`.
- Membres d'état : `Tab`, `Dne`, `Enr`, `Txtva2`, `b` (toujours `False`), et pour le recalcul
  `rResult3`, `arr`, `nbdec`, `Pvttc` (état partagé entre `Recalcul` et `arrondi`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Recalcul` : une fonction `RecalculLignes(sTabEnt, sTabLig, bTestArticle)` pour les deux blocs
  documents (même ordre de requêtes) ; un seul `UPdate <TabFam> SET txtva_fam = &1 WHERE cdtva_fam = &2`
  à la place de la boucle (**SQL modifié, dump identique**) ; suppression des `SELECT` inutiles sur
  `<TabMo>` (SQL modifié, dump identique).
- `arrondi` → fonction pure `ArrondiPrix(sPrix, sArr, sNbdec) As String`, sans état membre.

### Commonalisation avec d'autres fichiers

- [FTvac](../FTvac.class/architecture.md) : module commun pour la table TVA (voir FTVAC-006).
- Arrondi au 0,05 par chaîne : [Utils.arrondi](../../../Utils/Utils.module/architecture.md),
  [LPrix.Arrondi_Calc](../../../Utils/LPrix.class/architecture.md), Caisse, Moulinage, Facture,
  Articles, Movr, Materiel. Une fonction unique ne peut être adoptée ici qu'après des tests de
  caractérisation montrant des résultats identiques (sinon : anomalie).
- Calcul du TTC d'une ligne de document : à rapprocher des calculs de [ObjFac](../../../Gestion/Facturation/ObjFac.class/architecture.md)
  (phase 3).

### Réduction de portée

`Refresh`, `Maj_Zones`, `Recalcul`, `arrondi` → `Private` ; `Cleanchamps` et le membre `b` supprimés.
`Tvaman` est conservée jusqu'à la décision sur A03.

### Séparation traitement / GUI

`Recalcul(sCode As String, sTaux As String)` avec paramètres au lieu de lire `Cdtva`/`Txtva` ;
`ArrondiPrix` pure (testable en gb.test).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `nettc_ligbl`/`netht_ligbl` en `varchar(12)` : un type `DECIMAL` éviterait les conversions de
  chaîne et l'ambiguïté du séparateur décimal.
- `Fiches_Fam.txtva_fam` et `Fiches_Comptes.taux_tvente` dupliquent `Fiches_Tvaav.taux_tva` : une
  jointure sur le code supprimerait le recalcul en masse.
