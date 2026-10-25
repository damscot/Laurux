# Edcom — Architecture

> Source : `.src/Gestion/Impressions/Edcom.class` (+ `Edcom.form`)

## Vue d'ensemble

Écran « Réimpression d'une commande fournisseur » (menu `Menu92`, `Fmenu.class:1046`). L'utilisateur
choisit une commande dans la liste `Colcom` (toutes les commandes `Fiches_Entcom`, triées par
fournisseur) ou tape son numéro dans `Ncom`, puis imprime `~/tmp/Commande.pdf` (classe
`Cdocuments` : en-tête société, adresse fournisseur, lignes, total).

Le fichier porte l'en-tête recopié d'`Edregul` (« Impression des Bl fournisseurs ») et conserve
cinq routines `Draw` d'une ancienne mise en page (`Level1`…`Level4`, `Level3bis`), toutes mortes.
Le PDF n'est ni copié dans `~/Impressions` ni archivé en GED (contrairement à la commande créée par
`commande1`), bien que `Cfac` (`fo_copie`) et `Piece` soient calculés.

Groupes : `Ncom` dans `Cmpt` (tag 1). Boutons sans handler : `Button1` (aide), `Button6`.

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `hfile` | var | Private |  | File | 31 |
| `jour` | var | Private |  | String | 32 |
| `dater` | var | Private |  | String | 33 |
| `son` | var | Private |  | Integer | 34 |
| `Pays` | var | Private |  | String | 35 |
| `PosY` | var | Private |  | Integer | 36 |
| `Coulfond` | var | Private |  | New String[] | 37 |
| `Piece` | var | Private |  | String | 38 |
| `Codefour` | var | Private |  | String | 39 |
| `pdf` | var | Private |  | Cdocuments | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-50 | Public | 1 | 6 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 55-69 | Public | 5 | 10 | 0 | handler GUI |
| `ToggleButton1_Click` | 74-113 | Public | 5 | 37 | 0 | handler GUI |
| `Colcom_KeyPress` | 118-134 | Public | 5 | 15 | 0 | handler GUI |
| `Colcom_click` | 139-146 | Public | 1 | 6 | 0 | handler GUI |
| `Cmpt_GotFocus` | 151-157 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 162-296 | Public | 23 | 131 | 0 | handler GUI |
| `Level1` | 299-306 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level2` | 309-329 | Public | 1 | 19 | 0 | portée réductible ? |
| `Level3` | 332-345 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level3bis` | 347-354 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level4` | 357-367 | Public | 1 | 9 | 0 | portée réductible ? |
| `Button3_Click` | 369-374 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : `Utils.Observers(Me)`, `filename = ~/tmp/Edcom.kdf`, `Music.Load`.
- **`Cmpt_KeyPress()`** [handler] : Entrée/Tab dans `Ncom` → reste sur `Ncom` (sélection).
- **`ToggleButton1_Click()`** [handler] [mixte] : bascule `Colcom` ; `SELECT * FROM Fiches_Entcom
  order by four` puis, par commande, `SELECT * FROM Fiches_Four where fo_code = &1` (N+1, sans test
  `Available` : un fournisseur supprimé provoque une erreur, EDCOM-A03). ⚠️ À chaque ligne,
  `dater` reçoit la date de la commande lue : à la fin, `dater` est la date de la **dernière**
  commande de la liste, et c'est elle qui sera imprimée (EDCOM-A02).
- **`Colcom_KeyPress()`** [handler] : Entrée → copie le numéro dans `Ncom` et ferme la liste
  **sans** renseigner `Codefour` (EDCOM-A01) ; Échap/F2 → ferme.
- **`Colcom_click()`** [handler ; `replay_dynamic` : reste `Public`] : `Ncom` et `Codefour` depuis
  la ligne courante, ferme la liste.
- **`Cmpt_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Button2_Click()`** (CC 23) [handler] [mixte] :
  - `SELECT * FROM Fiches_Societes where cd_sc = &1` (`Start.Societe`, sans test `Available`) et
    construction des 14 libellés d'en-tête société (bloc `If Rsoc!xxx Then …`, même bloc que dans
    les relances et `Facturergbl`) ;
  - ouvre `filename` en écriture (`Edcom.kdf` au premier passage, **`Commande.pdf`** aux suivants,
    puisque `Filename` est réaffecté plus bas) : fichier jamais écrit ni fermé (fuite de
    descripteur, code mort) ;
  - `SELECT * FROM Fiches_Ligcom WHERE numcom = &1 and four = &2` (`Ncom.Text`, `Codefour`) : un
    numéro saisi au clavier ne trouve rien tant que `Codefour` est vide (A01) ;
  - fournisseur (`Fiches_Four`), logo (`/Soc<XX>/glogo`, `Logo` lu mais jamais utilisé) ;
  - PDF : `Entete` (19 arguments), `Entete2`, `Level1("Commande n° … du <dater>", "Code : … Tel :
    …")`, `Level2(True)`, `level3` par ligne (`totht = paht * qte` : multiplication d'une chaîne,
    conversion implicite à confirmer), saut de page à 280 (en-têtes répétés, sans pied de page),
    `level4(total)`, `Output`, `Visualiseur.Prog` ; `Piece` affecté, jamais lu.
- **`Level1`, `Level2`, `Level3`, `Level3bis`, `Level4`** [code mort] : routines `Draw` jamais
  appelées (les appels `pdf.Level1…` visent `Cdocuments`). `deps.py` ne signale que `Level3bis`
  comme `unused` et classe les quatre autres en « portée réductible » : faux négatif, aucun appel
  nu ni `Me.` n'existe (grep).
- **`Button3_Click()`** [handler] : supprime `~/tmp/Edcom.kdf`, ferme.

## État global utilisé

- `Start.Societe`, `Start.LocalSettings["/Soc<XX>/glogo"]`, `["/Soc<XX>/Logo"]`, `Start.Son`.
- Membres : `Filename` (double usage `.kdf`/`.pdf`), `hfile`, `dater`, `Codefour`, `Piece`, `Pays`,
  `Coulfond` (inutilisé), `Tab`, `Tab2`, `jour`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les routines `Draw`, `hfile`/`Edcom.kdf`, `Piece`, `Logo`, `Cfac`, `Coulfond`, `p`.
- Jointure `Fiches_Entcom LEFT JOIN Fiches_Four` pour la liste (SQL modifié, affichage identique
  tant que le fournisseur existe).

### Commonalisation avec d'autres fichiers

- **En-tête société** : bloc identique à celui des relances (`Ligcli`, `FEditrel`, `FRelCompte`,
  `FRelFacture`), de `Facturergbl` et `RelvMo` → `Creleve.EnteteSociete` (LIGCLI-004, voir
  [Ligcli](../../../Compta/Relances/Ligcli.class/architecture.md)) ; EDCOM-005.
- **Impression d'une commande** : `commande1` produit la même commande à la validation (avec GED) ;
  une procédure commune d'impression de commande éviterait deux mises en page (à vérifier en
  phase 3, voir [commande1](../../Stock/commande1.class/architecture.md)).
- Liste des documents fournisseur (BR dans `Edbl`, commandes ici) : même schéma de liste.

### Réduction de portée

- Les `Level*` sont à supprimer (code mort) plutôt qu'à réduire.

### Séparation traitement / GUI

- `LignesCommande(numcom, four) As Result` et `EnteteSociete()` séparées de l'impression.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `paht`/`qte` textuels dans `Fiches_Ligcom` : un type numérique éviterait les conversions.
