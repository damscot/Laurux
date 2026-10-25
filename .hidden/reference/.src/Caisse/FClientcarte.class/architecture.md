# FClientcarte — Architecture

> Source : `.src/Caisse/FClientcarte.class` (+ `FClientcarte.form`)

## Vue d'ensemble

`FClientcarte` est l'écran de **gestion des cartes de fidélité** (table `Fiches_Carte`, clé
`Cbase` `TabCarte`) : liste filtrable et triable en haut (`Colcli`, GridView alimentée par
`Utils.Base` / `Utils.rs1`), fiche détaillée en bas, sur quatre onglets (identité, carte et règle
d'attribution des points, observations, historique des tickets).

L'écran est ouvert :
- depuis la gestion par `Fmenu.Menu238_Click` (`FClientcarte.ShowModal()`, **auto-instance**) ;
- depuis la caisse via `Tricartes.ClientsCartes` (touche F4 dans la liste des cartes,
  `New FClientcarte`).

L'en-tête de fichier est une copie de celui de `FClient` (« Fclient.class », « Gestion de la table
des clients ») ; le code dérive d'une version ancienne de [`FClient`](../../Gestion/Tables/FClient.class/architecture.md)
(mesure `dup.py` : 489 lignes communes sur 863, ratio 0,27 avec FClient ; 477 lignes, ratio 0,32
avec [`FFournisseur`](../../Gestion/Tables/FFournisseur.class/architecture.md)). Les fonctions de code
postal (`aff_cp`, `ChkCp`, `Colcp_Click`, `Colcp_KeyPress`) et de code-barres (`Calc_barre`) sont
**identiques** à celles de FFournisseur (ratio 1,00) ; les en-têtes de tri `C1`…`V1` (`*_GotFocus`,
`*_LostFocus`, `*_KeyPress`, `*_Dblclick`, `Dbclk`) sont identiques ou presque (≥ 0,95) dans les
trois écrans.

Fonctionnement :
- **Bouton « Créer »** (`Button2_Click`) : prochain code = dernier code + 1 sur 6 chiffres, code-barres
  interne `"299999" & code & clé EAN` (`Calc_barre`), date d'émission = aujourd'hui, fin de validité
  = +20 ans, règle de points par défaut `/Soc<XX>/Tp1` et `/Soc<XX>/Tg1`. Le bouton « Enregistrer »
  devient « Valider ».
- **« Enregistrer »/« Valider »** (`Button4_Click`) : `INSERT` (création) ou `UPDATE` (modification)
  de `Fiches_Carte`, puis ajout du couple CP/ville dans `Fiches_Cpostaux` (`Enrgcp.Ecp`).
- **« Supprimer »** (`Button3_Click`) : `DELETE` après confirmation.
- **Historique** (`Hisv_Click`, `Hisp_Click`) : tickets de caisse de la carte
  (`Fiches_HisEntTickets`/`Fiches_HisLigTickets`) et cumul des points.

Les boutons du bas (`Button7`, `Button1`, `Button12`, `Button2`, `Button3`, `Button4`, `Button5`)
appartiennent au groupe `Btn` : seul `Btn_Click` est levé par Gambas, il aiguille sur le `Tag`
(1 aide, 3 créer, 4 supprimer, 5 enregistrer, 6 quitter ; tags 2 et 7, boutons invisibles `Mail` et
`Etiquette`, sans effet). Les champs de saisie appartiennent au groupe `Cmpt` (tags 1 à 19).

Nature globale : **mixte**, à dominante GUI ; le SQL est écrit directement dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `n` | var | Private |  | Integer | 28 |
| `Tri` | var | Private |  | String | 29 |
| `sel` | var | Private |  | String | 30 |
| `Clitable` | var | Private |  | New String[7] | 31 |
| `Enr` | var | Private |  | Integer | 32 |
| `son` | var | Private |  | Integer | 33 |
| `sKey` | var | Private |  | String | 34 |
| `Dbl` | var | Private |  | String | 35 |
| `CoulZnaf` | var | Private |  | Integer | 36 |
| `CoulFc` | var | Private |  | Integer | 37 |
| `Der` | var | Private |  | String | 38 |
| `Org` | var | Private |  | Integer | 39 |
| `Chkfocus` | var | Private |  | Boolean | 40 |
| `b` | var | Private |  | Integer | 41 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 43-65 | Public | 1 | 20 | 0 | méthode spéciale |
| `Colcli_Data` | 67-84 | Public | 5 | 16 | 0 | handler GUI |
| `Form_Open` | 86-93 | Public | 1 | 6 | 0 | handler GUI |
| `colcli_Click` | 95-109 | Public | 1 | 13 | 0 | handler GUI |
| `Tris` | 111-124 | Public | 1 | 12 | 0 | portée réductible ? |
| `Deb2` | 126-131 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 133-138 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Zones` | 140-178 | Public | 8 | 36 | 0 | portée réductible ? |
| `Button10_Click` | 180-193 | Public | 2 | 11 | 0 | handler GUI |
| `Refresh` | 195-199 | Public | 1 | 3 | 0 | portée réductible ? |
| `CleanChamps` | 201-233 | Public | 1 | 31 | 0 | portée réductible ? |
| `Cmpt_LostFocus` | 235-258 | Public | 7 | 20 | 0 | handler GUI |
| `Cmpt_KeyPress` | 260-385 | Public | 28 | 102 | 0 | handler GUI |
| `ChkPrx` | 387-395 | Public | 7 | 7 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 400-407 | Public | 1 | 6 | 0 | handler GUI |
| `C1_GotFocus` | 409-414 | Public | 2 | 4 | 0 | handler GUI |
| `C1_LostFocus` | 416-420 | Public | 2 | 3 | 0 | handler GUI |
| `N1_GotFocus` | 422-427 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 429-433 | Public | 2 | 3 | 0 | handler GUI |
| `A1_GotFocus` | 435-440 | Public | 2 | 4 | 0 | handler GUI |
| `A1_LostFocus` | 442-446 | Public | 2 | 3 | 0 | handler GUI |
| `cp1_GotFocus` | 448-453 | Public | 2 | 4 | 0 | handler GUI |
| `cp1_LostFocus` | 455-459 | Public | 2 | 3 | 0 | handler GUI |
| `V1_GotFocus` | 461-466 | Public | 2 | 4 | 0 | handler GUI |
| `V1_LostFocus` | 468-472 | Public | 2 | 3 | 0 | handler GUI |
| `Cb_GotFocus` | 474-478 | Public | 2 | 3 | 0 | portée réductible ? |
| `Cb_LostFocus` | 480-494 | Public | 5 | 13 | 0 | portée réductible ? |
| `codeBarre` | 499-520 | Public | 8 | 18 | 0 | portée réductible ? |
| `CtrlCbarre` | 526-543 | Public | 5 | 15 | 0 | portée réductible ? |
| `Btn_Click` | 545-566 | Public | 6 | 14 | 0 | handler GUI |
| `Button4_Click` | 568-617 | Public | 10 | 46 | 0 | portée réductible ? |
| `Button3_Click` | 619-654 | Public | 8 | 33 | 0 | portée réductible ? |
| `Button2_Click` | 656-687 | Public | 7 | 29 | 0 | portée réductible ? |
| `Button6_Click` | 689-699 | Public | 2 | 9 | 0 | handler GUI |
| `Button11_Click` | 701-711 | Public | 2 | 9 | 0 | handler GUI |
| `DateChooser1_Activate` | 713-726 | Public | 2 | 12 | 0 | handler GUI |
| `Dbclk` | 728-738 | Public | 2 | 9 | 0 | portée réductible ? |
| `C1_Click` | 740-752 | Public | 1 | 10 | 0 | handler GUI |
| `C1_Dblclick` | 754-758 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Click` | 760-772 | Public | 1 | 10 | 0 | handler GUI |
| `N1_Dblclick` | 774-778 | Public | 1 | 3 | 0 | handler GUI |
| `A1_Click` | 780-792 | Public | 1 | 10 | 0 | handler GUI |
| `A1_Dblclick` | 794-798 | Public | 1 | 3 | 0 | handler GUI |
| `Cp1_Click` | 800-812 | Public | 1 | 10 | 0 | handler GUI |
| `Cp1_Dblclick` | 814-818 | Public | 1 | 3 | 0 | handler GUI |
| `V1_Click` | 820-832 | Public | 1 | 10 | 0 | handler GUI |
| `V1_Dblclick` | 834-838 | Public | 1 | 3 | 0 | handler GUI |
| `Ref` | 840-847 | Public | 1 | 5 | 0 | portée réductible ? |
| `C1_KeyPress` | 849-861 | Public | 4 | 11 | 0 | handler GUI |
| `N1_KeyPress` | 863-875 | Public | 4 | 11 | 0 | handler GUI |
| `A1_KeyPress` | 877-889 | Public | 4 | 11 | 0 | handler GUI |
| `Cp1_KeyPress` | 891-903 | Public | 4 | 11 | 0 | handler GUI |
| `V1_KeyPress` | 905-917 | Public | 4 | 11 | 0 | handler GUI |
| `Cpman` | 920-933 | Public | 2 | 11 | 0 | portée réductible ? |
| `aff_cp` | 935-962 | Public | 4 | 25 | 0 | portée réductible ? |
| `Colcp_Click` | 964-973 | Public | 1 | 8 | 0 | handler GUI |
| `Colcp_KeyPress` | 978-999 | Public | 6 | 18 | 0 | handler GUI |
| `ChkCp` | 1001-1009 | Public | 7 | 7 | 0 | portée réductible ? |
| `ToggleButton5_Click` | 1011-1024 | Public | 2 | 11 | 0 | handler GUI |
| `Hisv_Click` | 1028-1080 | Public | 9 | 50 | 0 | handler GUI |
| `Hisp_Click` | 1082-1125 | Public | 5 | 41 | 0 | handler GUI |
| `Calc_barre` | 1130-1140 | Public | 1 | 8 | 0 | portée réductible ? |
| `Tp2_DblClick` | 1142-1146 | Public | 1 | 3 | 0 | handler GUI |
| `Tg2_KeyPress` | 1148-1152 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 1154-1158 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et liste

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`, centrage,
  lecture des couleurs `/Coul/Znaff` et `/Coul/Focus` dans `CoulZnaf`/`CoulFc` (**jamais relues**),
  `n = 1` (jamais relu), libellés d'en-tête `C1`…`V1`, civilités (`Utils.Fill_Civilite(CV)`).
- **`Form_Open()`** [handler] [GUI] : tri par `code`, filtre vide, `Tris()` puis `Deb2()`. Rappelée
  par `Refresh()`.
- **`Tris()`** [portée : réductible] [GUI] : 9 colonnes dans `Colcli`, largeurs des 7 premières
  calées sur les en-têtes.
- **`Deb2()` / `Deb3()`** [portée : réductible] [mixte] : `SELECT code, rs_soc, nom, pnm, adr1,
  cd_ptl, ville FROM Fiches_Carte WHERE <Tri> LIKE "%<sel>%" ORDER BY <Tri> [DESC]` via
  `Utils.Base(colcli, …)` (résultat dans `Utils.rs1`). Le filtre `sel` est **concaténé** dans le SQL
  (aucun filtrage des caractères, contrairement à `Tricartes.ChkInput`) : un `"` ou un `\` saisi
  produit une erreur SQL (voir FCLIENTCARTE-A05). Deux fonctions identiques au mot `desc` près.
- **`Colcli_Data(Row, Column)`** [handler] [GUI] : remplit `Clitable` (7 noms de colonne) **à
  chaque cellule**, puis `Utils.rs1.MoveTo(Row)` et lit la colonne. Les colonnes 7 et 8 de la grille
  provoquent un dépassement d'indice absorbé par `Try` ; le test `Column = 8` (alignement) n'est donc
  jamais atteint après un succès : code inopérant.
- **`colcli_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] : vide la
  fiche, `Maj_Zones()`, remet les libellés d'en-tête, focus sur la civilité.
- **`Maj_Zones()`** [portée : réductible] [mixte] : `SELECT * FROM Fiches_Carte WHERE code = &1`
  (code de la ligne courante) sous `Try`, puis recopie de 25 colonnes dans les contrôles **sans
  test `Available`** (si la requête a échoué, `Clitab` est nul et la lecture lève une erreur non
  gérée). Points par défaut repris de `/Soc<XX>/Tp1`/`Tg1` si la valeur lue est vide.
  Partie extractible : la lecture (`LitCarte(code) As Result`).
- **`Refresh()`** [portée : à conserver `Public`] [GUI] : rappelle `Form_Open()`. Le nom masque la
  méthode `Refresh` héritée de `Control` : ne pas le passer en `Private` ni le renommer.
- **`CleanChamps()`** [portée : réductible] [GUI] : vide la fiche, points à `"0"`, décoche les cases.
- **`Ref()`** : **code mort** (jamais appelée ; les appels `'ref()` sont commentés).
- **`Dbclk()`** [portée : réductible] [GUI] : bascule tri croissant/décroissant (`Dbl` String
  `"1"`/`""`).
- **En-têtes de tri** `C1_Click`, `N1_Click`, `A1_Click`, `Cp1_Click`, `V1_Click` [GUI] : remettent
  les libellés des autres en-têtes, vident le filtre, fixent `Tri` (`code`, `nom`, `adr1`, `cd_ptl`,
  `ville`) et rechargent. Ce sont des `TextBox` : `Click` n'est pas un événement de `TextBox`, ces
  méthodes ne sont appelées que par les `*_GotFocus` correspondants (5 copies quasi identiques).
  `C2` et `P1` n'ont pas de handler.
- **`*_GotFocus` / `*_LostFocus`** (C1, N1, A1, cp1, V1) [handler] : journalisation
  `Utils.ObsGotf`/`ObsLstf`, puis appel du `*_Click`.
- **`*_KeyPress`** (C1, N1, A1, Cp1, V1) [handler] : ajoute la touche au filtre `sel` (ou retire le
  dernier caractère sur Retour arrière) et recharge par `Deb2()` ; 5 copies identiques, équivalentes
  à `Utils.Obstch`.
- **`*_Dblclick`** (C1, N1, A1, Cp1, V1) [handler] : `Dbclk()`.

### Saisie de la fiche

- **`Cmpt_KeyPress()`** [handler] [GUI] (CC 28, max du fichier) : Entrée/Tab font avancer le focus
  selon le `Tag` (1 civilité → 2 nom → … → 17 points → 18 gains) ; tag 2 refuse la saisie tant que
  le code est vide (message « cliquer sur Créer ») ; tag 6 (code postal) appelle `Cpman()` ; les
  libellés sont normalisés par `Utils.Remplace`. Hors Entrée/Tab, les tags 15 à 18 (deux dates et
  deux zones de points) passent par `ChkPrx()`. F1 ouvre l'aide (`Button7_Click`).
- **`ChkPrx()`** [portée : réductible] [GUI] : n'accepte que `0-9 , .` et les touches d'édition
  (copie de `SupprArt.ChkPrx`/`Suivi.Chkinput`, voir les notes transverses).
- **`Cmpt_GotFocus()`** [handler] : couleur d'édition (`Utils.SetEditColor`) et sélection.
- **`Cmpt_LostFocus()`** [handler] [mixte] : tag 8 contrôle du courriel (`Utils.chkEmail`) ; tag 19
  (code-barres) retire un `*` initial, appelle `Utils.Find_cbarre` **dont le résultat est ignoré**
  (deux `SELECT` inutiles sur `Fiches_CdBarre`/`Fiches_Art`), puis `codeBarre()` et `CtrlCbarre()` ;
  en cas d'erreur (`b = 1`) remet le focus sur le code-barres.
- **`Cb_GotFocus()` / `Cb_LostFocus()`** : **handlers inactifs** — `CB` appartient au groupe `Cmpt`,
  seul `Cmpt_*` est levé. `Cb_LostFocus` duplique la branche tag 19 de `Cmpt_LostFocus` (sans remise
  à zéro de `b`). Code mort.
- **`codeBarre()`** [portée : réductible] [mixte] : longueur 8 ou 13 exigée ; pour 13 caractères,
  vérifie la clé `Utils.Calcode(Left$(cb, 12))` ; avertissements, `b = 1`. N'accepte pas de vérifier
  la clé d'un EAN-8 (même lacune que FFournisseur, FFOURNISSEUR-A06).
- **`CtrlCbarre()`** [portée : réductible] [mixte] : `SELECT * FROM Fiches_Carte WHERE cb = &1` ; si
  le code-barres appartient à une autre carte, bulle d'avertissement et `b = 1`.
  [`FFournisseur.CtrlCbarre`](../../Gestion/Tables/FFournisseur.class/architecture.md) en est une copie
  non adaptée (elle cherche aussi dans `Fiches_Carte`, FFOURNISSEUR-A06).
- **`Calc_barre()`** [portée : réductible] [calcul + écriture d'un contrôle] : `Cb = "299999" & Cd &
  Utils.Calcode("299999" & Cd)`. Identique à `FFournisseur.Calc_barre`. Le préfixe `299999` est
  reconnu à la lecture par `Caisse` (`Caisse.class:1337`, longueur 14 et `Mid$(…, 2, 6)`, à
  confirmer avec un lecteur réel : un code-barres carte fait 13 caractères).
- **`Button6_Click` / `Button11_Click`** [handler] : affichent ou masquent `DateChooser1` pour la date
  d'émission (`Org = 1`) ou de fin (`Org = 2`) ; **`DateChooser1_Activate`** recopie la date.
- **`Tp2_DblClick` / `Tg2_KeyPress`** [handler] : déverrouillent les compteurs « points totalisés »
  et « gains » (lecture seule par défaut). `Tg2_KeyPress` déverrouille au premier appui de touche,
  donc sans effet visible (la touche elle-même est ignorée tant que la zone est en lecture seule).

### Enregistrement

- **`Btn_Click()`** [handler] : aiguillage par `Tag` (voir vue d'ensemble).
- **`Button2_Click()`** — « Créer » [portée : réductible, méthode du groupe `Btn`] [mixte] :
  `SELECT code FROM Fiches_Carte ORDER BY code`, `MoveLast`, `Val(code) + 1` formaté `000000`
  (ordre **lexical** sur `char(13)` : un code non normalisé fausse le maximum ; même calcul dans
  `Caisse.Enrg_Clientd`). Puis `Calc_barre`, dates (aujourd'hui, +20 ans par concaténation de
  chaîne), règle de points par défaut, `enr = "1"` (Integer affecté d'une chaîne), compteurs
  déverrouillés. Partie extractible : `ProchainCodeCarte() As String`.
- **`Button4_Click()`** — « Enregistrer » [réductible] [mixte] (CC 10) : normalise les libellés,
  exige nom et code ; selon le texte du bouton (`"Valider"` / `"V&alider"`) :
  - **création** : `INSERT INTO Fiches_Carte (26 colonnes) VALUES (&1 … &{26})` ; les zones de points
    `Tp1`…`Tg2` sont transmises **en texte brut** (`"1,50"`) ;
  - **modification** : `UPDATE Fiches_Carte SET … WHERE code = &1` ; les points passent par
    `Val(Utils.cpoint(…))`. ⚠️ Les marqueurs `&{10}`/`&{11}` sont affectés à `tel_dom`/`tel_bur` alors
    que les valeurs transmises sont `Telbur`, `Teldom` : **les deux téléphones sont inversés à chaque
    modification** (FCLIENTCARTE-A01, ligne 597 ; l'`INSERT` ligne 585 est correct).
  Puis `Enrgcp.Ecp(cp, ville)` (`INSERT` dans `Fiches_Cpostaux` si le couple est nouveau),
  rafraîchissement et repositionnement dans la liste. `Catch` : son + `Message.Error`.
  Partie extractible : `EnregistreCarte(bNouveau, …)` sans accès aux contrôles.
- **`Button3_Click()`** — « Supprimer » [réductible] [mixte] : confirmation,
  `SELECT` puis `DELETE FROM Fiches_Carte WHERE code = &1`. Variables `Tab = "Fiches_Cartes"`
  (table inexistante, jamais utilisée) et `Suppr` (toujours 1) : code mort. L'historique des tickets
  (`Fiches_HisEntTickets.carte`) n'est ni contrôlé ni nettoyé.
- **`Button10_Click()`** [handler] : `xdg-open` sur Google Maps avec l'adresse. **`Button7_Click()`**
  [réductible, méthode du groupe `Btn`] : aide HTML `Ecrans/Tablesclients&fournisseurs.html` (celle
  des clients/fournisseurs).

### Code postal

- **`Cpman()`** [réductible] [GUI] : ouvre `New Tricp("Client", Cp.Text)` puis lit
  `Variables.Bsel`/`Variables.Codepostal`/`Variables.Bureaudistributeur`. ⚠️ Avec l'origine
  `"Client"`, [`Tricp.colco_Click`](../../Affichages/Tricp.class/architecture.md) écrit dans
  `FClient.Bsel`/`FClient.codepostal` (auto-instance d'un **autre** écran, instanciée pour l'occasion)
  et jamais dans `Variables` : le code postal choisi n'est pas repris ; `Variables.Bsel` n'est pas
  remis à `False` avant l'appel, donc une valeur restée vraie après une sélection dans `Facture`
  recopie un ancien code postal (même défaut que MATERIEL-A09 pour `TriCpt`). FCLIENTCARTE-A02.
- **`ToggleButton5_Click()`** [handler] [GUI] : `New Tricp("Clientcarte", "")`. ⚠️ `Tricp.colco_Click`
  exécute alors `FClientcarte.Bsel = True` (`Tricp.class:140`, hors `Try`) : `FClientcarte` n'a pas
  de membre `Bsel` → erreur d'exécution « Unknown symbol 'Bsel' in class 'FClientcarte' » au choix
  d'un code postal (mécanisme vérifié avec `gbs3` : la compilation passe, l'erreur survient à
  l'exécution). FCLIENTCARTE-A02.
- **`aff_cp()`** : **code mort** (jamais appelée). SQL par concaténation (`cp LIKE '<cp>%'`). C'est
  la seule fonction qui rend `Colcp` (et `Button5`) visibles.
- **`Colcp_Click()` / `Colcp_KeyPress()`** [handler ; `Colcp_Click` rejoué par `Object.Call`] [GUI] :
  recopie CP/ville depuis `Colcp`. `Colcp` est invisible dans le `.form` et seul `aff_cp` (mort)
  l'affiche : ces handlers sont **inatteignables** (non détecté par `deps.py`).
- **`ChkCp()`** : **code mort** (filtre de saisie numérique, jamais appelé). Identique à
  `FClient.ChkCp`, `FFournisseur.ChkCp`, `Depots`, `Marques`, `Cpostaux`, `Facture`.

### Historique

- **`Hisv_Click()`** [handler] [mixte] (CC 9) : historique des ventes. `SELECT * FROM
  Fiches_HisEntTickets WHERE carte = &1 AND suppr != 1 ORDER BY numero`, puis **une requête par
  ticket** `SELECT * FROM Fiches_HisLigTickets WHERE numero = &1 ORDER BY cast(numlig as unsigned)`
  (N+1 requêtes ; noms de table en dur, sans `Cbase.Table("TabHisEntTck")`). `CAST(… AS unsigned)`
  est accepté par SQLite (affinité numérique), à confirmer en phase 2.
- **`Hisp_Click()`** [handler] [mixte] : historique des points, même entête, cumul `points` affiché
  ligne par ligne (`Totpoint`). Les tickets dont `suppr` est `NULL` sont exclus par `suppr != 1`
  (comportement SQL standard, à figer).
- `Histo` (ColumnView) n'a pas de `Histo_Click` : un clic rejoué dans l'historique ferait
  `Object.Call` d'une méthode inexistante (`replay_missing`, REPLAYOBSERVER-A06).

## État global utilisé

- `Start.Son` (initialiseur `son`), `Start.LocalSettings` : `/Coul/Znaff`, `/Coul/Focus`,
  `/Soc<XX>/Tp1`, `/Soc<XX>/Tg1` ; `Start.Societe`.
- `Utils.rs1` (via `Utils.Base`) : résultat partagé de la liste, **global** ; tout écran ouvert par
  dessus qui appelle `Utils.Base` le remplace.
- `Variables.Bsel`, `Variables.Codepostal`, `Variables.Bureaudistributeur` (lus, jamais remis à zéro).
- `Music` (son d'erreur), `Balloon.Delay` (modifié globalement à 1500 ms dans `_New`).
- Variables d'instance écrites mais jamais lues : `n`, `Enr`, `CoulZnaf`, `CoulFc`, `Chkfocus`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Une seule méthode de chargement `Charge(bDesc)` pour `Deb2`/`Deb3` (texte SQL inchangé).
- Un helper `TriColonne(sTri, hEntete)` pour les 5 `*_Click` d'en-tête et un helper
  `SaisieFiltre()` pour les 5 `*_KeyPress` (même effet, `sel` identique).
- `Cmpt_KeyPress` : table `tag → contrôle suivant` (CC 28 → ≤ 8), en gardant les cas particuliers
  (tag 2 sans code, tag 6 code postal, tag 19 → date).
- `Colcli_Data` : initialiser `Clitable` une fois (dans `_New`).
- `Cmpt_LostFocus` : supprimer l'appel à `Utils.Find_cbarre` dont le résultat est ignoré (SQL modifié,
  dump identique).

### Commonalisation avec d'autres fichiers

- **Socle `FicheTiers`** ([FClient](../../Gestion/Tables/FClient.class/architecture.md), FCLIENT-011 à
  014, et [FFournisseur](../../Gestion/Tables/FFournisseur.class/architecture.md), FFOURNISSEUR-010 à
  013) : `FClientcarte` n'a **ni** contacts, **ni** mails, **ni** ventilations, **ni** GED, **ni**
  étiquettes ; elle ne partage avec le socle que des briques d'écran (en-têtes de tri, filtre, code
  postal, code-barres). Elle n'est donc **pas** candidate au socle complet ; elle consommerait seulement
  les services transverses que le socle prévoit : `ChercheCP`, `ClauseRecherche(sTri, sSel, bDesc)` et
  les helpers d'en-tête de tri. Gain estimé : ~120 LOC (en-têtes, filtre, code postal, code-barres).
- **Code-barres interne** : `Calc_barre` (identique dans FFournisseur), `codeBarre` (clé EAN-13) et la
  reconnaissance du préfixe `299999` par [`Caisse`](../Caisse.class/architecture.md) → un module
  commun (ex. `Utils.CodeBarreInterne(code)`, `Utils.CleEanValide(cb)`), sans changer les messages.
  `Utils.Calcode` est déjà partagé avec FClient et Articles.
- **Code postal** : `Cpman`/`ChkCp`/`aff_cp`/`Colcp_*` existent aussi dans FClient, FFournisseur,
  Depots, Facture, Marques, Cpostaux (notes transverses) ; le retour de sélection de
  [`Tricp`](../../Affichages/Tricp.class/architecture.md) par auto-instance (`FClient.Bsel`…) devrait
  passer par `Object.SetProperty(ob, "Bsel"/"Bval")` comme `Tricartes`/`TriArticles` (après A02).
- **Prochain code carte** : `Button2_Click` et `Caisse.Enrg_Clientd` (`Caisse.class:7307-7314`)
  calculent le même `MAX + 1` → `ProchainCodeCarte()` commun (dans ce fichier, `Public`, appelé par
  Caisse) ; à rapprocher de `ProchainCode` de FClient (FCLIENT-007).
- **Liste des cartes** : `EmailingCarte` (sélection de destinataires, EMAILING-006 /
  EMAILINGCARTE-004), [`Tricartes`](../Affichages/Tricartes.class/architecture.md) et `HitCarte`
  lisent la même table avec chacun sa requête ; une fonction `LitCarte(code)` partagée servirait
  `Maj_Zones`, `Caisse.RecupClientd`, `EmailingCarte.Cli_Man` et `HitCarte`.

### Réduction de portée

- `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `CleanChamps`, `ChkPrx`, `codeBarre`, `CtrlCbarre`, `Dbclk`,
  `Cpman`, `Calc_barre` : aucun appelant externe (vérifié par `grep -rn`) → `Private`.
- `Button2_Click`, `Button3_Click`, `Button4_Click`, `Button7_Click` ne sont jamais levés par Gambas
  (boutons du groupe `Btn`) : ce sont de simples méthodes appelées par `Btn_Click`. On les laisse
  `Public` par convention de nommage (forme de handler).
- `Refresh` reste `Public` (masque `Control.Refresh`).

### Séparation traitement / GUI

- `Button4_Click` → `EnregistreCarte(…)` (INSERT/UPDATE + `Enrgcp.Ecp`) appelé par le handler.
- `Button2_Click` → `ProchainCodeCarte()` + `CodeBarreCarte(code)` (calcul pur, testable en gbtest).
- `Hisv_Click`/`Hisp_Click` → `HistoVentes(carte) As Result`, `HistoPoints(carte) As Result`.
- `Maj_Zones` → `LitCarte(code) As Result`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique sur `Fiches_Carte.cb` (unicité du code-barres, aujourd'hui contrôlée par `CtrlCbarre`).
- Clé étrangère ou index sur `Fiches_HisEntTickets.carte` (historique et suppression de carte).
- Colonne `code` en entier auto-incrémenté (ou séquence) au lieu du `MAX + 1` lexical sur `char(13)`.
- `rem`, `promo`, `divers` : booléens stockés en `tinyint` avec `-1` (valeur Gambas de `CheckBox`)
  ou `1` selon l'écrivain ; un domaine `0/1` unique simplifierait les lectures.
