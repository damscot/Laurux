# Achat — Architecture

> Source : `.src/Gestion/Entrées/Achat.class`

## Vue d'ensemble

`Achat` est la **grille de saisie des achats fournisseurs** (commandes et bons de réception). Elle
hérite de [`SaiTableau`](../../../Utils/SaiTableau.class/architecture.md) (`Inherits SaiTableau`,
ligne 3) : chaque ligne est une [`Sailig`](../../../Utils/Sailig.class/architecture.md) dont les
colonnes sont décrites par des `ObjProp` construits dans `_new` (Code, bouton Rech, Désignation,
Pal/Col en options B/T, Qte, Px_Brut, TX_Conv, Rem, Px_Net, Frais, Px_Rev).

Elle n'a **pas de `.form`** : elle est instanciée par l'écran
[`commande1`](../../Stock/commande1.class/architecture.md) (`commande1:63`,
`New Achat($prop, Panel2, panel3) As "Achat"`), qui reçoit ses événements `ajou`, `LecArt`,
`EnrTarTemp` et les événements hérités `gotfocus`/`lostfocus`.

Responsabilités, dans l'ordre du fichier :

1. **Saisie d'une ligne** : lecture de l'article (`ligne_LecCode`, `Utils.db.RecArt`), calcul du
   prix par cascade [`LPrix`](../../../Utils/LPrix.class/architecture.md) +
   [`LTaxe`](../../../Utils/LTaxe.class/architecture.md) (TVA, remise, frais) dans `calcul`, mise à
   jour du prix net et du prix de revient par l'événement `LPrix_change`, consignes et droits
   (options B/T, objet `Consigne`).
2. **Cycle de vie du document** : lecture (`LitCommande`), génération automatique (`generer`),
   import d'un inventaire portable (`Import`), suppression (`SupAchat`), enregistrement (`EnrAch`,
   `EnrRec`, `EnrConsigne`), contrôle des doublons (`Doublon`).
3. **Édition** : bon de commande / réception en `Report` (`imprime`, `ChoixCode`), envoi par mail
   (`mail`).
4. **Fenêtres secondaires** construites par code : saisie des numéros de série (`CreMat`,
   `valider_click`, table `mat`), réception et reliquats (`CreRec`, `Reliquat_lostfocus`,
   `CreReliquat`, table `rec`).

Les événements des contrôles des lignes sont rattachés à l'instance par
`SaiTableau.evenement` (`Object.Attach(obj, Me, Utils.Accent(obj.name))`, `SaiTableau:229`), et
`lg.prx` est rattaché sous le nom `LPrix` (`SaiTableau:231`). Les procédures `Code_*`, `Rech_click`,
`qte_lostfocus`, `Pal_*`, `Col_*`, `rem_lostfocus`, `TX_Conv_lostfocus`, `Px_Brut_lostfocus`,
`Frais_lostfocus`, `LPrix_change`, `ligne_*` et `RadioButton*_click` sont donc des **handlers
dynamiques** : `deps.py` les annonce à tort « jamais référencés » et « portée réductible ».

État de document : `$etat` prend les valeurs de l'énumération publique `CreaCommande`,
`EnCommande`, `Reception`, `Validee`, `Sans` (utilisées aussi par `commande1`, `ValidBR1`,
`Stockmvt`). La seconde énumération (`Tarif`, `Frais`, `Materiel`, `Consignes`, `FicheArt`,
`ObjFin`) indexe le tableau `Sailig.AutresObj` de chaque ligne (`VarMajTar`, objet `boisson`,
fiche article `Result`…), lu aussi par [`GesTar`](../GesTar.class/architecture.md).

Nature globale : **mixte**, fortement couplée à la GUI (toutes les valeurs sont lues dans les
contrôles des lignes au moment de l'enregistrement). Module complexe au sens de PLAN.md : la liste
des scénarios de test (test.md) est à valider par l'utilisateur avant la phase 2.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `NbCol` | var | Private |  | Integer | 6 |
| `NbUnit` | var | Private |  | Integer | 7 |
| `ccd` | var | Private |  | Consigne | 8 |
| `commentaire` | var | Public |  | String | 11 |
| `OptAr` | var | Public |  | Artopt | 13 |
| `mat` | var | Public |  | SaiTableau | 14 |
| `rec` | var | Public |  | SaiTableau | 15 |
| `TotHt` | var | Public |  | Float | 16 |
| `TotTtc` | var | Public |  | Float | 17 |
| `Bsel` | var | Public |  | Boolean | 19 |
| `Bval` | var | Public |  | String | 20 |
| `$code` | var | Private |  | String | 22 |
| `$PxRec` | var | Private |  | Boolean | 23 |
| `$Mat` | var | Private |  | Boolean | 24 |
| `$LtRem` | var | Private |  | New LTaxe | 25 |
| `$LtTva` | var | Private |  | New LTaxe | 26 |
| `$LtFrais` | var | Private |  | New LTaxe | 27 |
| `$dte` | var | Private |  | LDate | 28 |
| `$fournisseur` | var | Private |  | String | 29 |
| `$ndoc` | var | Private |  | String | 30 |
| `$etat` | var | Private |  | Integer | 31 |
| `$reli` | var | Private |  | Integer | 32 |
| `$mail` | var | Private |  | String | 33 |
| `$ressup` | var | Private |  | Result | 34 |
| `$sup` | var | Private |  | Boolean | 35 |
| `ajou` | event | Public |  |  | 37 |
| `LecArt` | event | Public |  |  | 38 |
| `EnrTarTemp` | event | Public |  |  | 39 |
| `CreaCommande` | enum | Public | oui |  | 41 |
| `EnCommande` | enum | Public | oui |  | 41 |
| `Reception` | enum | Public | oui |  | 41 |
| `Validee` | enum | Public | oui |  | 41 |
| `Sans` | enum | Public | oui |  | 41 |
| `Tarif` | enum | Public | oui |  | 42 |
| `Frais` | enum | Public | oui |  | 42 |
| `Materiel` | enum | Public | oui |  | 42 |
| `Consignes` | enum | Public | oui |  | 42 |
| `FicheArt` | enum | Public | oui |  | 42 |
| `ObjFin` | enum | Public | oui |  | 42 |
| `RelQte` | enum | Private | oui |  | 43 |
| `RelArt` | enum | Private | oui |  | 43 |
| `RelFin` | enum | Private | oui |  | 43 |
| `date` | property | Public |  | LDate | 45 |
| `fourisseur` | property | Public |  | String | 46 |
| `ndoc` | property | Public |  | String | 47 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 50-170 | Public | 11 | 105 | 0 | méthode spéciale |
| `ligne_LecCode` | 172-236 | Public | 14 | 61 | 0 | portée réductible ? |
| `Code_gotfocus` | 238-242 | Public | 1 | 3 | 0 | portée réductible ? |
| `Code_lostfocus` | 244-253 | Public | 4 | 8 | 0 | portée réductible ? |
| `Code_KeyPress` | 255-260 | Public | 3 | 4 | 0 | portée réductible ? |
| `Rech_click` | 262-283 | Public | 8 | 19 | 0 | portée réductible ? |
| `qte_lostfocus` | 285-293 | Public | 4 | 7 | 0 | portée réductible ? |
| `Pal_gotfocus` | 295-299 | Public | 4 | 3 | 0 | portée réductible ? |
| `Pal_lostfocus` | 301-309 | Public | 4 | 7 | 0 | portée réductible ? |
| `Col_gotfocus` | 311-315 | Public | 4 | 3 | 0 | portée réductible ? |
| `Col_lostfocus` | 317-325 | Public | 4 | 7 | 0 | portée réductible ? |
| `rem_lostfocus` | 327-331 | Public | 1 | 3 | 0 | portée réductible ? |
| `TX_Conv_lostfocus` | 333-337 | Public | 1 | 3 | 0 | portée réductible ? |
| `Px_Brut_lostfocus` | 339-343 | Public | 1 | 3 | 0 | portée réductible ? |
| `Frais_lostfocus` | 345-349 | Public | 1 | 3 | 0 | portée réductible ? |
| `LPrix_change` | 351-357 | Public | 1 | 4 | 0 | portée réductible ? |
| `calcul` | 359-391 | Private | 11 | 30 | 0 |  |
| `ligne_RetLigne` | 393-404 | Public | 4 | 10 | 0 | portée réductible ? |
| `ligne_InsLig` | 406-418 | Public | 4 | 10 | 0 | portée réductible ? |
| `ligne_Suplig` | 420-425 | Public | 1 | 4 | 0 | portée réductible ? |
| `RadioButton1_click` | 427-435 | Public | 2 | 7 | 0 | portée réductible ? |
| `RadioButton2_click` | 437-445 | Public | 2 | 7 | 0 | portée réductible ? |
| `RadioButton3_click` | 447-455 | Public | 2 | 7 | 0 | portée réductible ? |
| `radioBchange` | 457-469 | Private | 3 | 10 | 0 |  |
| `ajout` | 471-483 | Public | 3 | 12 | 1 |  |
| `Show` | 485-493 | Public | 1 | 7 | 1 |  |
| `Delete` | 495-502 | Public | 4 | 6 | 1 |  |
| `Doublon` | 504-555 | Public | 10 | 47 | 1 |  |
| `BtDbl_Click` | 557-561 | Public | 1 | 3 | 0 | handler GUI |
| `LitCommande` | 564-639 | Public | 18 | 71 | 1 |  |
| `generer` | 641-681 | Public | 9 | 38 | 1 |  |
| `Rech` | 683-692 | Private | 3 | 7 | 0 |  |
| `Import` | 695-770 | Public | 19 | 70 | 1 |  |
| `SupAchat` | 772-836 | Public | 16 | 55 | 1 |  |
| `EnrAch` | 839-923 | Public | 16 | 76 | 1 |  |
| `EnrRec` | 925-981 | Private | 10 | 53 | 0 |  |
| `EnrConsigne` | 983-999 | Private | 2 | 14 | 0 |  |
| `verifdrt` | 1001-1015 | Private | 5 | 12 | 0 |  |
| `imprime` | 1017-1251 | Public | 18 | 229 | 1 |  |
| `ChoixCode` | 1253-1289 | Private | 4 | 32 | 0 |  |
| `ButT_click` | 1291-1295 | Public | 1 | 3 | 0 | handler GUI |
| `mail` | 1297-1352 | Public | 6 | 51 | 1 |  |
| `mail_change` | 1354-1358 | Public | 1 | 3 | 0 | handler GUI |
| `mail_click` | 1360-1364 | Public | 1 | 3 | 0 | handler GUI |
| `date_Read` | 1366-1370 | Private | 1 | 3 | 0 |  |
| `date_Write` | 1372-1376 | Private | 1 | 3 | 0 |  |
| `fourisseur_Read` | 1378-1382 | Private | 1 | 3 | 0 |  |
| `fourisseur_Write` | 1384-1388 | Private | 1 | 3 | 0 |  |
| `ndoc_Read` | 1390-1394 | Private | 1 | 3 | 0 |  |
| `ndoc_Write` | 1396-1400 | Private | 1 | 3 | 0 |  |
| `ContMat` | 1407-1416 | Public | 3 | 7 | 1 |  |
| `CreMat` | 1418-1493 | Public | 10 | 69 | 1 |  |
| `abandon_click` | 1495-1500 | Public | 1 | 4 | 0 | handler GUI |
| `valider_click` | 1502-1580 | Public | 17 | 73 | 0 | handler GUI |
| `CreFen` | 1582-1617 | Private | 1 | 32 | 0 |  |
| `CreRec` | 1621-1716 | Public | 7 | 86 | 1 |  |
| `Reliquat_lostfocus` | 1718-1723 | Public | 1 | 4 | 0 | handler GUI |
| `CreReliquat` | 1725-1741 | Public | 4 | 13 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(Panel3)`** [portée : nécessaire (spéciale)] [nature : GUI]. Arguments réels :
  `(prop, parent)` pour `SaiTableau` puis `Panel3` (conteneur de la recherche d'article).
  Fixe `$etat = EnCommande`, lit `/Soc<XX>/prixRecpt` (`$PxRec`, prix saisis en réception) et
  `/Soc<XX>/ma` (`$Mat`, **jamais relu** : code mort). Exécute
  `SELECT * FROM Fiches_Art, Fiches_Tvaav WHERE art_tva=code_tva LIMIT 1` uniquement pour obtenir
  les `Fields` des colonnes (base vide d'articles : `res.Fields` sur un résultat vide, à confirmer).
  Les largeurs dépendent de la police du parent, de l'option de licence (`Me.opt` B/T : colonnes
  Pal et Col) et de `$PxRec` (colonnes de prix masquées).

### Saisie d'une ligne (handlers dynamiques)

- **`ligne_LecCode(ligne)`** (CC 14) [portée : réductible, appels internes seulement]
  [nature : mixte]. `ligne` est soit la `Sailig`, soit le code (String). Lit l'article par
  `Utils.db.RecArt(code)` ; remplit chaque contrôle dont l'`ObjProp` a un nom de champ, ajoute
  `%` à la remise, crée l'objet `boisson` et la `Consigne` (options B/T), applique la TVA
  (`New LTaxe(taux_tva & "%", LTaxe.TVA)`), l'arrondi `art_cdarr`, puis `calcul`. Article absent :
  `Message.Error("Aricle innexitant")`, vide le code, `Stop Event`.
  ⚠️ Ligne 198 : `obj.NomControl = "art_frais"` n'est jamais vrai (le contrôle s'appelle `Frais`) :
  toutes les colonnes, Frais compris, reçoivent `nbdec = art_nbd`.
- **`Code_gotfocus` / `Code_lostfocus` / `Code_KeyPress`** [handlers dynamiques] [GUI].
  Mémorise le code ; à la sortie, si le code a changé, `ligne_LecCode` puis `Raise LecArt`
  (→ `commande1.Achat_LecArt` → `GesTar.LecArt`) et `Raise lostfocus` (en plus du
  `ligne_lostfocus` de `SaiTableau` : double levée possible, à confirmer). F2 : `Rech_click` ;
  F3 : `articles.ShowModal()` (auto-instance du formulaire `Articles`).
- **`Rech_click`** [handler dynamique] [mixte]. Ouvre `TriArticles` (option « Fournisseur » ou
  « Centrale » selon les boutons radio), qui renseigne `Bsel`/`Bval` par `Object.SetProperty` :
  ces deux variables **doivent rester `Public`**.
- **`qte_lostfocus`, `Pal_gotfocus/lostfocus`, `Col_gotfocus/lostfocus`, `rem_lostfocus`,
  `TX_Conv_lostfocus`, `Px_Brut_lostfocus`, `Frais_lostfocus`** [handlers dynamiques] [GUI].
  Recalculent la ligne (`calcul`) ; Pal/Col dérivent le nombre de colis et de bouteilles des
  conditionnements de l'article (`NbCol`, `NbUnit`). `qte_lostfocus` affecte d'abord
  `prx.Qte = Pal` (écrasé ensuite par `calcul`).
- **`LPrix_change(Data)`** [handler dynamique, événement `change` de `lg.prx`] [GUI].
  `Px_Net = PuBHT.Mnt + remise` (`$LtRem.Montant(Data, True)`) et `Px_Rev = PuNHT.Mnt`.
  `commande1.LPrix_change` reçoit le même événement (observateur posé dans `Achat_Ajou`).
- **`calcul()`** (privé, CC 11) [nature : mixte]. `TX_Conv` à 1 si nul ; `prx.Qte = Qte × TX_Conv`,
  `prx.Mnt = Px_Brut / TX_Conv` ; remise lue dans le texte `Rem` (`%` ou valeur), frais en
  `LTaxe.Frais`. Les quatre branches de remise produisent la même construction
  (`New LTaxe(…, LTaxe.Remise)`) : factorisable. Toujours sur la ligne courante `Me.ind`.
- **`ligne_RetLigne` / `ligne_InsLig` / `ligne_Suplig`** [handlers redéfinis de `SaiTableau`]
  [GUI]. Recalculent puis délèguent à `Super` ; `ligne_InsLig` réinitialise les consignes et
  retire la ligne du chaînage des tableaux (`chain.tableaux.Extract(1)`).
- **`RadioButton1/2/3_click` + `radioBchange(cond)`** [handlers des boutons radio créés par
  `SaiTableau.show`] [GUI]. Changent la colonne de recherche du code (`art_cfour`, `art_code`,
  `art_refcentrale`).

### Gestion du tableau

- **`ajout(etat)`** [portée : nécessaire, `commande1:462,495`] [GUI]. `Super.ajout`, crée
  `AutresObj` (`New Variant[ObjFin]`) avec un `VarMajTar` en `Tarif`, arrondi `Arr_0001`,
  supprime `Px_Brut` du chaînage si `$PxRec` est faux.
- **`Show()`** [portée : nécessaire, `commande1:65`] [GUI]. Libellés des boutons radio.
- **`Delete()`** [portée : nécessaire, `commande1:540`] [GUI]. `Try OptAr.Delete` (**`OptAr` n'est
  jamais affecté** : instruction morte), `mat`, `rec`, puis `Super.Delete`.
- **`Doublon()`** [portée : nécessaire, `commande1:936`] [mixte]. Double boucle `For Each` (O(n²))
  sur les lignes : codes identiques dont la mise à jour de tarif est demandée deux fois
  (`IgnoreTarif`, nom inversé : vrai = mettre à jour). Affiche une fenêtre de la liste
  (`BtDbl_Click` la ferme) et renvoie `True`.

### Documents

- **`LitCommande(where, etat)`** (CC 18) [portée : nécessaire, `commande1:347`] [mixte].
  `where` est un fragment SQL construit par `commande1.ColTri_MajSel` (`Utils.db.Subst`) ; pour
  une commande, `numrecpt` y est remplacé par `numcom`. SQL :
  `SELECT * FROM Fiches_Entcom JOIN Fiches_Ligcom … WHERE <where> ORDER BY nligne` ou
  `Fiches_Entrecpt JOIN Fiches_Ligrecpt`. Recrée chaque ligne (`ajout`, `ligne_LecCode`, valeurs
  du document), relit palettes/colis par `Consigne.recuppalette/recupcol` en réception, puis
  bloque code/quantité/conversion si une ligne porte des droits (`dra`).
  ⚠️ `pg` n'est créée que si le résultat est disponible, mais `pg.Close` (ligne 637) est
  inconditionnel : document sans ligne → erreur « objet nul ».
- **`generer(four)`** [portée : nécessaire, `commande1:496`] [mixte]. Articles du fournisseur sous
  le stock mini (`art_qte < art_stkmin`), quantité = `stkmax − qte − déjà commandé`
  (`SELECT SUM(qte) FROM Fiches_Ligcom WHERE code = &1`, une requête par article), minimum de
  commande, conversion. `Rech(code)` (privé) renvoie **vrai si le code est absent** (nom trompeur).
  Une ligne vide est ajoutée après la dernière.
- **`Import()`** (CC 19, max du fichier) [portée : nécessaire, `commande1:863`] [mixte]. Lit
  `~/Portable/inventaire.txt` (`codebarre;quantité`), convertit par `Utils.Find_cbarre`, ajoute
  une ligne par enregistrement et journalise les rejets dans `~/tmp/ImpT.txt` (ouvert ensuite par
  `Editeur.Prog_Editeur`). `Shell "cd " & User.Home` et `With utils` sont sans effet.
  ⚠️ `Code` n'est pas réinitialisé entre deux lignes : un code-barre vide ou inconnu réutilise le
  code de la ligne précédente (ou ajoute une ligne avec un code vide) ; les lignes rejetées sont
  quand même ajoutées et comptées.
- **`SupAchat(etat, Cle, stock, supmat)`** (CC 16) [portée : nécessaire, `commande1:510,604,813`]
  [mixte]. `Cle` est la sélection de `TriGen` (`"Fiches_Entcom.four"`, `"Fiches_Entcom.numrecpt"`
  — alias de `numcom` —, `"Fiches_Entrecpt.*"`). Commande : `Utils.db.Delete` de `Fiches_Entcom`
  et `Fiches_Ligcom`. Réception : lit les lignes dans `$ressup`, supprime les matériels si
  `supmat`, puis, si aucune ligne n'a de droits (`verifdrt`), supprime `Fiches_Entrecpt`,
  `Fiches_Ligrecpt`, les consignes (`Fiches_ligcons`, options B/T) et décrémente stock et PAMP
  (`Utils.db.Lockstock(…, "-", True, paht)`) si `stock` ; sinon positionne `$sup` pour que
  `EnrAch` décrémente après réécriture. `Catch` : message, `Utils.db.Rollback`, renvoie `True`.
  ⚠️ Ligne 799 : `IsNull(matvendu)` est **toujours faux** pour un `String[]` créé par `New`
  (vérifié avec `gbs3`) : dès qu'une réception a des matériels, `Error.Raise` est levée avec une
  liste vide → suppression refusée et rollback. ⚠️ `Application.Busy = 1` n'est jamais remis à 0
  hors erreur (l'appelant s'en charge, à confirmer).
- **`EnrAch(etat, dte, num, four, vignette)`** (CC 16) [portée : nécessaire, `commande1:605,816`]
  [mixte]. Crée l'en-tête (`Utils.db.Create9("Fiches_Entcom")`) et les lignes (`Fiches_Ligcom`) pour
  une commande ; pour une réception, modifie (`Utils.db.Edit`) ou crée `Fiches_Entrecpt` et ses
  lignes `Fiches_Ligrecpt`. Montants `TotHt`/`TotTtc` fournis par `commande1`. **`Utils.db.Commit`**
  ligne 895 valide la transaction ouverte par l'appelant ; ensuite seulement, en réception, met à
  jour stock et PAMP (`Lockstock "+"`), après avoir décrémenté l'ancienne réception si `$sup`.
  ⚠️ Les dates des lignes utilisent `$dte` (propriété `date`) mais la recherche de la réception
  existante utilise le paramètre `dte` : cohérent tant que `commande1` affecte `tbl.date`
  (à confirmer).
- **`EnrRec(reslig, sl, dte, num, four, vignette, modif)`** (privé) [mixte]. Recopie les contrôles
  de la ligne dans le `Result` ; remise = valeur avant `%` ou, sans `%`,
  `(Px_Brut − Px_Net) / Px_Brut × 100` (⚠️ division par zéro si `Px_Brut = 0`, ligne 940) ;
  `paht = Px_Net × TX_Conv` ; `pattc = prx.PuNTC.G`. Lève `EnrTarTemp` (→ `GesTar.EnrTarTemp`).
  Options B/T et création : ligne de régie `Fiches_ligregie` si l'article a un code de droits
  (`numlig = Format(sl.Ind, "000")`, alors que les autres tables utilisent `Ind + 1`, à
  confirmer), puis trois `EnrConsigne` (palette, colis, unité).
- **`EnrConsigne(code, nb, nlig, cdd, dte, num, four)`** (privé) [calcul]. Ligne de
  `Fiches_ligcons` (type `E`, `bloc = dte.L & num & four`, clé reprise par `SupAchat`).
- **`verifdrt(res)`** (privé) [calcul]. Vrai si un article des lignes porte `art_dra`
  (`SELECT art_dra FROM Fiches_Art WHERE art_code = &1` sans test `Available`). Toujours faux en
  options N/P.

### Édition et envoi

- **`imprime(ChCo, chiffre)`** (229 lignes, CC 18) [portée : nécessaire, `commande1:474,617,823`]
  [mixte]. `Netoyage("Code")`, lit le fournisseur (`Fiches_Four`), demande le code à imprimer
  (`ChoixCode`), construit un `Report` (en-tête, tableau, total, pied) avec la couleur du thème
  (`Start.R/G/B`). Chaque cellule répète 5 à 7 affectations identiques. Polices
  `"Serif,Blod,…"` (faute de frappe : jamais en gras).
- **`ChoixCode()`** (privé) [GUI]. Fenêtre modale à trois boutons radio ; `ButT_click` la ferme.
- **`mail()`** [portée : nécessaire, `commande1:486`] [mixte]. Fenêtre « chiffrée / non chiffrée »
  et liste des adresses (`Mails_Four`, **un seul** contact de `Fiches_ContactF`) ; `mail_change`
  / `mail_click` mémorisent l'adresse. Imprime en PDF (`~/tmp/BonCommande.pdf`) puis
  `EnvMail.Envoi2`. Pour un contact (`nom pnm | mail`), l'adresse retenue est `tMail[1]`, avec
  l'espace qui suit le `|` (à confirmer : `EnvMail` le supprime-t-il ?).
- **Propriétés `date`, `fourisseur` (sic), `ndoc`** [portée : nécessaire, `commande1`]
  [calcul]. Accesseurs triviaux de `$dte`, `$fournisseur`, `$ndoc`.

### Matériels (numéros de série)

- **`ContMat()`** [portée : nécessaire, `commande1:600,808`] [calcul]. Vrai si une ligne concerne
  un matériel (`AutresObj[Materiel]`).
- **`CreMat()`** [portée : nécessaire, `commande1:601,809`] [mixte]. Fenêtre (`CreFen`) et
  `SaiTableau` `mat` (Code, Désignation, Série) : une ligne par unité, numéros existants relus
  dans `Fiches_Materiels` (désactivés si vendus). Renvoie `False` si abandon.
- **`abandon_click` / `valider_click`** [handlers des boutons de `CreFen`] [mixte].
  `valider_click` (CC 17) : contrôle des numéros vides (question) et des doublons, supprime les
  numéros non vendus de la réception, recrée les numéros saisis (`Create9("Fiches_Materiels")`,
  29 champs recopiés de la fiche article, dont 4 affectés deux fois).
  ⚠️ Lignes 1520-1522 : le contrôle de doublon utilise `mat.ligne[mat.ind]` (ligne courante) au
  lieu de `lig` : seule la ligne qui a le focus est contrôlée, N fois. `ligart` reste la dernière
  ligne si aucun code ne correspond.
- **`CreFen(ByRef pan)`** (privé) [GUI]. Fenêtre sans bordure, panneau de saisie, boutons
  « Abandon »/« Valider » (`Tag` = fenêtre).

### Réception et reliquats

- **`CreRec()`** [portée : nécessaire, `commande1:754`] [mixte]. Fenêtre `rec` : quantités
  commandée / reçue / reliquat par ligne ; observateurs `As "Reliquat"` sur deux colonnes
  (`Reliquat_lostfocus`). À la validation, recopie les quantités reçues et recalcule ; demande
  la génération d'une commande de reliquat (`$reli`, 1 oui / 2 non).
- **`Reliquat_lostfocus()`** [handler d'observateur] [calcul]. `Reliquat = Qte_Comm − Qte_Reçu`.
- **`CreReliquat()`** [portée : nécessaire, `commande1:829`] [mixte]. Si `$reli = 1`, ajoute une
  ligne par reliquat positif dans la grille (vidée au préalable par `commande1.annul_Click`) et
  repasse en `CreaCommande`.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/prixRecpt"]`, `["/Soc<XX>/ma"]`, `Start.Societe`, `Start.R/G/B`.
- `Utils.db` : `Exec`, `RecArt`, `Create9`, `Edit`, `Delete`, `Lockstock`, `Commit`, `Rollback`.
- `Utils.Find_cbarre`, `Utils.cpoint`, `Utils.Accent` (via `SaiTableau`), `Me.opt` (option de
  licence lue par `SaiTableau._new`).
- Tables (toutes en dur, aucune via `Cbase`) : `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Entcom`,
  `Fiches_Ligcom`, `Fiches_Entrecpt`, `Fiches_Ligrecpt`, `Fiches_Materiels`, `Fiches_ligcons`,
  `Fiches_ligregie`, `Fiches_Four`, `Mails_Four`, `Fiches_ContactF`.
- Fichiers : `~/Portable/inventaire.txt`, `~/tmp/ImpT.txt`, `~/tmp/BonCommande.pdf`.
- Variables `Public` exposées : `commentaire`, `TotHt`, `TotTtc` (écrites par `commande1`),
  `Bsel`/`Bval` (écrites par `TriArticles`), `OptAr`, `mat`, `rec` (usage interne seulement).

## Propositions d'amélioration

### Réécriture / refactorisation

- `imprime` : helper privé `Cellule(conteneur, texte, largeur, alignement, bordure)` pour les
  ~25 blocs `ReportLabel` identiques ; même `Report` produit.
- `calcul` : helper `RemiseDepuisTexte(txt) As LTaxe` pour les quatre branches ; le même parsing
  existe dans `EnrRec` (lignes 936-941).
- `Doublon` : une `Collection` indexée par code au lieu de la double boucle (même liste de
  doublons, même ordre d'insertion à vérifier par test).
- `generer` : la quantité déjà commandée peut venir d'une seule requête
  `SELECT code, SUM(qte) … GROUP BY code` (SQL modifié, dump identique).
- `valider_click` : supprimer les affectations en double (`mat_dfour`, `mat_dpa`, `mat_cequ`,
  `mat_eco`) et extraire la recopie fiche article → matériel.
- `Import` : supprimer `Shell "cd …"` et `With utils` (sans effet).

### Commonalisation avec d'autres fichiers

- Cascade de prix `LPrix` + `LTaxe` : même construction dans
  [`GesTar`](../GesTar.class/architecture.md) (`Coef_lostfocus`, `affichetarif`, `EnrTarArt`),
  [`DateTar`](../DateTar.class/architecture.md) (`EnrTouTar`),
  [`VarMajTar`](../../Stock/VarMajTar.class/architecture.md),
  [`TarTypeCli`](../../Tables/TarTypeCli.class/architecture.md) et
  [`calculdroit1`](../../option/calculdroit1.class/architecture.md). Un constructeur commun
  (`LPrix` + liste de `LTaxe`) est proposé en phase 3, voir GesTar.
- Méthodes redéfinies de [`SaiTableau`](../../../Utils/SaiTableau.class/architecture.md)
  (`ajout`, `Delete`, `ligne_RetLigne`, `ligne_InsLig`, `ligne_Suplig`) : vérifier en phase 3 ce
  qui peut remonter dans la classe de base.
- Fenêtres construites par code (`Doublon`, `ChoixCode`, `mail`, `CreFen`) : patron « fenêtre
  modale + bouton dont le `Tag` est la fenêtre » répété 4 fois ; aussi dans `commande1`
  (vignette, date d'écriture).
- Stock et PAMP : `Utils.db.Lockstock` (voir
  [DB_Connection](../../../Utils/DB_Connection.class/architecture.md)), à rapprocher de
  `Cstock`/`Validinv` (note transverse « Stock »).

### Réduction de portée

- Handlers dynamiques (`Code_*`, `Rech_click`, `qte_lostfocus`, `Pal_*`, `Col_*`,
  `rem_lostfocus`, `TX_Conv_lostfocus`, `Px_Brut_lostfocus`, `Frais_lostfocus`, `LPrix_change`,
  `ligne_*`, `RadioButton*_click`) : **restent `Public`** (faux positifs de `deps.py`).
- `ligne_LecCode` : appels internes seulement (vérifié par `grep -rn`), réductible en `Private`.
- `OptAr` (jamais affecté), `mat`, `rec` : usage interne seulement → `Private`.
- `Bsel`/`Bval` : restent `Public` (`Object.SetProperty` depuis `TriArticles`).

### Séparation traitement / GUI

- `EnrRec` : lire une fois les valeurs de la ligne (`ValeursLigne(sl) As Collection` ou
  structure) puis écrire le `Result` sans accès aux contrôles.
- `SupAchat` : la partie SQL (suppression + décrément de stock) est déjà sans contrôle, sauf
  `Me.opt` ; isoler `Message.Error` dans l'appelant avec un code retour.
- `generer` : calcul des quantités à commander dans une fonction pure (liste code → quantité),
  puis ajout des lignes.
- `imprime` : séparer la collecte des lignes (texte par colonne) de la construction du `Report`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Ligrecpt.nligne` et `Fiches_ligcons.numlig` en texte (`Format(Ind + 1, "000")`) : un
  entier éviterait les formats ; `Fiches_ligregie.numlig` utilise `Ind` sans `+1`.
- Clé de consigne `bloc = date & numéro & fournisseur` concaténée : des colonnes séparées
  permettraient une clé étrangère vers `Fiches_Entrecpt`.
- `Fiches_Materiels` recopie 20 colonnes de `Fiches_Art` : une jointure sur `mat_code` suffirait
  pour les attributs non historisés.
