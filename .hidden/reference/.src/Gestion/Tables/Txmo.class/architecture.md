# Txmo — Architecture

> Source : `.src/Gestion/Tables/Txmo.class`

## Vue d'ensemble

`Txmo` est l'écran de paramétrage des **taux de main-d'œuvre** (table `Fiches_Txtmo`, clé
`code_txtmo`) : code (2 caractères), libellé, taux horaire de vente (`tx_txtmo`, stocké en
`char(10)`), compte de vente 7xxxxx (`compt_txtmo`) et prix de revient horaire (`prvt_txtmo`).
Il est ouvert en **non modal** sur l'auto-instance depuis le menu Gestion (`Fmenu.Menu28_Click`,
`Txmo.Show`).

À l'enregistrement d'un taux dont le taux ou le prix de revient a changé, `MajMo` **répercute** le
nouveau taux, le prix de revient et la marge recalculée sur toutes les fiches de main-d'œuvre
(`Fiches_Mo`) qui utilisent ce code (`mo_txcd`). C'est le seul effet de bord hors de la table gérée.

Structure du formulaire : liste `Coltxmo` (ColumnView, 4 colonnes visibles + une 5ᵉ cachée qui
porte `prvt_txtmo`, voir plus bas), zones de saisie du groupe `Tmo` (tags 1 code, 2 libellé,
3 taux, 4 compte, 5 prix de revient), boutons du groupe `Btn` (tags 1 aide, 2 supprimer,
3 enregistrer, 4 fermer), bouton `Button4` (liste des comptes 7) et liste `Colcompt`.

Nature globale : **GUI** avec SQL embarqué ; seul `Calc_MargeMo` est un calcul (mais il lit les
contrôles et la base).

⚠️ Les zones `Txtmo`, `Prvt`, `Codecompt` appartiennent au groupe `Tmo` : Gambas lève donc
`Tmo_LostFocus` (inexistant) et **jamais** `txtmo_LostFocus`, `Prvt_LostFocus` ni
`codecompt_LostFocus`. Ces trois fonctions ne sont que des **pseudo-handlers**, appelés
explicitement par `Tmo_KeyPress` : quitter une zone à la souris ne contrôle ni ne formate rien
(TXMO-A03).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 30 |
| `b` | var | Private |  | Integer | 31 |
| `Montante` | var | Private |  | String | 32 |
| `Montantp` | var | Private |  | String | 33 |
| `MargeMo` | var | Private |  | Float | 34 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-54 | Public | 1 | 16 | 0 | méthode spéciale |
| `Form_Open` | 56-74 | Public | 3 | 15 | 0 | handler GUI |
| `Refresh` | 76-83 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 85-95 | Public | 2 | 9 | 0 | portée réductible ? |
| `Cleanchamps` | 97-105 | Public | 1 | 7 | 0 | portée réductible ? |
| `Btn_Click` | 107-125 | Public | 5 | 12 | 0 | handler GUI |
| `Button1_Click` | 127-178 | Public | 11 | 48 | 0 | portée réductible ? |
| `MajMo` | 180-194 | Public | 3 | 12 | 0 | portée réductible ? |
| `Calc_MargeMo` | 196-226 | Public | 3 | 21 | 0 | portée réductible ? |
| `Coltxmo_Click` | 228-233 | Public | 1 | 4 | 0 | handler GUI |
| `Button3_Click` | 235-258 | Public | 5 | 21 | 0 | portée réductible ? |
| `Button4_Click` | 260-289 | Public | 4 | 27 | 0 | handler GUI |
| `Colcompt_Click` | 291-299 | Public | 1 | 7 | 0 | handler GUI |
| `Colcompt_KeyPress` | 304-325 | Public | 6 | 18 | 0 | handler GUI |
| `Tmo_GotFocus` | 330-343 | Public | 3 | 11 | 0 | handler GUI |
| `codecompt_LostFocus` | 345-350 | Public | 1 | 4 | 0 | portée réductible ? |
| `txtmo_LostFocus` | 352-375 | Public | 5 | 21 | 0 | portée réductible ? |
| `Prvt_LostFocus` | 377-404 | Public | 6 | 25 | 0 | portée réductible ? |
| `Tmo_KeyPress` | 406-466 | Public | 14 | 51 | 0 | handler GUI |
| `compteGman` | 471-486 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button5_Click` | 491-495 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture, liste, zones

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI] : `Utils.Observers(Me)`, son,
  centrage, colonnes de `Coltxmo` (`Columns.Count = 4`).
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM <TabTxmo> order by code_txtmo` et
  remplissage de `Coltxmo`. Le prix de revient est rangé dans `Item[4]`, au-delà des 4 colonnes
  déclarées (colonne cachée ; fonctionnement à confirmer, il est relu par `Maj_Zones` sous `Catch`).
  `Else` vide et appel `Maj_Zones` commenté.
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide la liste, `Cleanchamps`, `Form_Open`,
  puis `Maj_Zones` (sans élément courant après rechargement : l'erreur est absorbée par le `Catch`).
- **`Maj_Zones()`** [portée : réductible] [nature : GUI] : recopie la ligne courante dans les
  zones ; `Catch` vide.
- **`Cleanchamps()`** [portée : réductible] [nature : GUI] : vide les zones, `Prvt = "0,00"`.
- **`Coltxmo_Click()`** [handler, rejeu dynamique] : `Cleanchamps` + `Maj_Zones`.

### Boutons

- **`Btn_Click()`** [handler, groupe `Btn`] : aiguillage par tag (1 `Button5_Click`, 2
  `Button3_Click`, 3 `Button1_Click`, 4 fermeture). `Button1/3/5` sont dans le groupe : leurs
  `_Click` nominaux ne sont jamais levés par Gambas (pseudo-handlers).
- **`Button1_Click()`** (CC 11) [pseudo-handler] [nature : mixte] — enregistrement :
  1. `compteGman()` : avertit et met `b = 1` si le compte n'existe pas dans `Fiches_Comptes` ;
  2. si `b <> 1` et code ou compte vide : `Message.Question("VOUS DEVEZ D'ABORD REMPLIR…")`,
     ⚠️ **puis le traitement continue** (TXMO-A01) ;
  3. sinon `SELECT` sur `Fiches_Txtmo` (nom en dur) puis `UPdate` (tous les champs, clé `&1`) ou
     `INSERT`, paramétrés ; le taux passe par `Val(Utils.cpoint(…))`, le prix de revient par
     `Val(Prvt.Text)` ;
  4. si le taux ou le prix de revient diffère de la valeur mémorisée au `GotFocus`
     (`Montante`/`Montantp`) : `MajMo()`. Les deux membres valent `""` tant que la zone n'a pas
     eu le focus : le premier enregistrement de la session appelle donc toujours `MajMo` ;
  5. `Refresh`, `Cleanchamps`, repositionnement sur `sKey` (code saisi ou clé courante).
  Si `b = 1` : retour sur le compte.
- **`MajMo()`** [portée : réductible] [nature : calcul + SQL, lit `CdTx`/`txtmo`/`Prvt`] :
  `SELECT * FROM <TabMo> WHERE mo_txcd = &1`, puis pour chaque MO `Calc_MargeMo(code)` et
  `UPdate <TabMo> SET mo_txht, mo_prvt, mo_marge WHERE mo_code = &1`. Une requête de lecture
  supplémentaire par MO (N+1) ; pas de transaction. ⚠️ Le prix de revient propre de chaque MO
  (saisi dans `Movr`) est remplacé par celui du taux (règle métier à confirmer, TXMO-A04).
  `mo_valeurht`/`mo_valeurttc` ne sont pas recalculés : pour une MO « temps », la valeur est
  calculée à la facturation ; pour un forfait, elle reste fixe et seule la marge change.
- **`Calc_MargeMo(Code)`** [portée : réductible] [nature : calcul, lit la base et les zones] :
  relit la MO (**sans test `Available`**). MO « temps » (`mo_tempmont = "1"`) :
  `marge = (taux − prvt) × mo_montant` ; forfait : `tx = mo_valeurht / taux`, puis
  `marge = (taux − prvt) × tx`. Toute erreur (taux nul, MO absente) donne `MargeMo = 0` (`Catch`).
  Même formule que [Movr.Calc_MargeMo](../Movr.class/architecture.md), écrite sur des zones
  différentes.
- **`Button3_Click()`** [pseudo-handler] [nature : mixte] — suppression : confirmation, refus si un
  code MO utilise ce taux (`<TabMo>.mo_txcd`), sinon `DELETE FROM Fiches_Txtmo WHERE code_txtmo =
  Coltxmo.Current[0]` : ⚠️ le contrôle porte sur `CdTx.Text` mais la suppression sur la **ligne
  sélectionnée** (TXMO-A02). `Me.Raise` final.
- **`Button4_Click()`** [handler] [nature : mixte] : bascule l'affichage de `Colcompt` et la
  remplit avec les comptes de classe 7 (`left(compte_cc,1) = '7' order by cast(compte_cc AS
  char)`, table `Fiches_Comptes` en dur ; `left` est traduit pour SQLite par `DB_Connection`).
- **`Colcompt_Click()`** / **`Colcompt_KeyPress()`** [handlers, `Colcompt_Click` rejeu
  dynamique] : recopie du compte ; Entrée sélectionne, F1 aide, Échap/F2 ferme.
- **`Button5_Click()`** [pseudo-handler] : `Doc.Open("Txmo")`.

### Saisie (groupe `Tmo`)

- **`Tmo_GotFocus()`** [handler] : `Utils.SetEditColor` ; mémorise `Montante` (tag 3) et
  `Montantp` (tag 5).
- **`Tmo_KeyPress()`** (CC 14, max du fichier) [handler] : Entrée/Retour/Tab font avancer de zone
  en appelant explicitement `txtmo_LostFocus` (tag 3), `codecompt_LostFocus` (tag 4),
  `Prvt_LostFocus` (tag 5) ; F1 aide ; F2 sur le compte ouvre la liste.
- **`codecompt_LostFocus()`** [pseudo-handler] : couleur de fond puis `compteGman`.
- **`txtmo_LostFocus()`** / **`Prvt_LostFocus()`** [pseudo-handlers] [nature : mixte] :
  `Utils.cpoint`, contrôle `Val(…) = Null`, formatage `0.00` ; message si vide. `Prvt_LostFocus`
  positionne `b = 1` en cas d'erreur, `txtmo_LostFocus` non (pas de retour sur la zone).
- **`compteGman()`** [portée : réductible] [nature : mixte] : `SELECT * FROM Fiches_Comptes WHERE
  compte_cc = &1` ; si absent, message et `b = 1`.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.Observers`, `Utils.SetEditColor` ; `Cbase.Table("TabTxmo")`,
  `Cbase.Table("TabMo")` ; noms en dur `Fiches_Txtmo` (Button1/3) et `Fiches_Comptes`.
- `Start.Son`, `Start.Musique` (via `son`, `Music`).
- Membres : `b` (drapeau d'erreur partagé entre zones), `Montante`/`Montantp` (valeurs avant
  saisie), `MargeMo` (résultat de `Calc_MargeMo`, passé par état membre).

## Propositions d'amélioration

### Réécriture / refactorisation

- `MajMo` : lire les colonnes utiles une seule fois dans la boucle et passer les valeurs à un calcul
  pur (suppression du `SELECT` par MO : **SQL modifié, dump identique**).
- `Button1_Click` : sortir la partie SQL dans `EnregistreTaux(sCode, sLibelle, sCompte, fTaux,
  fPrvt) As String` (renvoie la clé à resélectionner).
- `Calc_MargeMo` → fonction pure `MargeMo(sTempMont, fMontant, fValeurHt, fTaux, fPrvt) As Float`
  (même gestion d'erreur : 0).

### Commonalisation avec d'autres fichiers

- Calcul de marge MO identique dans [Movr.Calc_MargeMo](../Movr.class/architecture.md) : fonction
  commune (module partagé de la main-d'œuvre), à figer par TXMO-T06 et MOVR-T08 avant fusion.
- Liste des comptes de classe 7 (`Button4_Click`/`Colcompt`) : même motif que les listes de
  comptes de [FTvac](../../../Compta/Tables/FTvac.class/architecture.md) et
  [FTvav](../../../Compta/Tables/FTvav.class/architecture.md) (sélecteur de comptes commun, phase 3).

### Réduction de portée

`Refresh`, `Maj_Zones`, `Cleanchamps`, `MajMo`, `Calc_MargeMo`, `compteGman` → `Private`
(aucun appelant externe, vérifié par `grep`). Les pseudo-handlers (`Button1_Click`,
`Button3_Click`, `Button5_Click`, `codecompt_LostFocus`, `txtmo_LostFocus`, `Prvt_LostFocus`)
gardent nom et portée par prudence (forme de handler, voir PLAN §0) ; seule leur logique est
déplacée.

### Séparation traitement / GUI

`EnregistreTaux`, `MajMo(sCode, fTaux, fPrvt)` et `MargeMo` sans accès aux contrôles ; les
handlers ne font que lire les zones et afficher les messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `tx_txtmo` est un `char(10)` alors que `mo_txht` est un `double` : un type `DECIMAL` éviterait
  les conversions de chaîne.
- `Fiches_Mo.mo_txht`, `mo_prvt` et `mo_marge` dupliquent des données dérivées de `Fiches_Txtmo` :
  une jointure sur `mo_txcd` supprimerait la répercussion en masse de `MajMo`.
- Clé étrangère `Fiches_Mo.mo_txcd` → `Fiches_Txtmo.code_txtmo` (refus de suppression géré par la
  base).
