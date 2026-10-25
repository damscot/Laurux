# commande1 — Architecture

> Source : `.src/Gestion/Stock/commande1.class` · Formulaire : `.src/Gestion/Stock/commande1.form`

## Vue d'ensemble

`commande1` est l'écran **« Entrée des articles »** (Gestion › Achats/Réceptions,
`Fmenu.class:1021`, `Commande1.show()`) : commandes fournisseurs, bons de réception et lancement
de leur validation. Il orchestre trois objets incrustés :

- [`Achat`](../../Entrées/Achat.class/architecture.md) (`tbl`, `New Achat($prop, Panel2, panel3)
  As "Achat"`) : la grille de saisie (classe dérivée de `SaiTableau`), la lecture/écriture des
  documents (`LitCommande`, `EnrAch`, `SupAchat`, `CreRec`, `CreReliquat`, `CreMat`…) ;
- [`GesTar`](../../Entrées/GesTar.class/architecture.md) (`$gestarif`, onglet « Tarifs ») : les
  tarifs de vente de l'article de la ligne courante, enregistrés à la validation ;
- `artopt` (onglet « Options », si `Utils.Option() <> "N"`).

S'y ajoutent une **fenêtre de sélection** (`$win`) construite par code dans `Form_Open` : trois
radios (commandes, BR, BR validées) et une [`TriGen`](../../../Affichages/TriGen.class/architecture.md)
dont l'événement `MajSel` charge le document choisi.

États (`$etat`, énumération d'`Achat`) : `Sans`, `CreaCommande`, `EnCommande`, `Reception`,
`Validee`. Le bouton `rececp` change de rôle selon l'état (`ChangVal`) :
- `Sans` → ouvre [`ValidBR1`](../ValidBR1.class/architecture.md) (validation groupée) ;
- `CreaCommande`/`EnCommande` → **réception** de la commande (`rececp_Click`, CC 29) ;
- `Reception` → « Valider les factures » : enregistre puis `ValidBR1.Ecritures`.

Appelé aussi avec un document (`New Commande1(Null, num, four, date, etat)`, `Null` = `Parent`
car tous les paramètres de `_new` sont optionnels) par `ValidBR1.TriBr_Activate`,
`Stockmvt.GridView1_Activate` et l'ancien `ValidBR` (mort) : mode `$validBR` (fermeture directe).

**Transaction partagée** (rework conjoint avec `Achat` et `GesTar`) : `commande1` ouvre
`Utils.db.Begin`, `Achat.SupAchat` fait `Rollback` en cas d'erreur, **`Achat.EnrAch` fait
`Commit` en plein flux** (`Achat.class:895`) puis met à jour stock et PAMP hors transaction ;
ensuite `GesTar.EnrTar`/`EnrArt`/`EnrEtiqu` écrivent les tarifs et la fiche article **hors
transaction**, et `ValCom` refait un `Commit` sans `Begin` correspondant. `GesTar.Enreg_Click`
ouvre lui-même une transaction et lève `EnrTar`, dont le handler `Tarif_EnrTar` refait
`Begin`/`Commit` (GESTAR-A07). Une erreur après `EnrAch` laisse donc un document enregistré avec
des tarifs partiels.

**Module complexe** (achats, réceptions, stock et tarifs) : la liste des scénarios de `test.md`
est à faire valider par l'utilisateur avant la phase 2.

Nature globale : **mixte** ; **pas d'appel à `Utils.Observers`** (ni ici, ni dans `Achat`/`GesTar`) :
écran non instrumenté pour le log/replay (COMMANDE1-A08).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$opt` | var | Private |  | String | 5 |
| `$req` | var | Private |  | String | 6 |
| `$win` | var | Private |  | Window | 7 |
| `$panel` | var | Private |  | Panel | 8 |
| `tr` | var | Private |  | TriGen | 9 |
| `Col` | var | Private |  | Collection | 10 |
| `$etat` | var | Private |  | Integer | 11 |
| `$prop` | var | Private |  | New ObjProp[] | 12 |
| `$cond` | var | Private |  | String | 13 |
| `$numlock` | var | Private |  | String | 14 |
| `$validBR` | var | Private |  | Boolean | 15 |
| `$Apdf` | var | Private |  | Boolean | 16 |
| `$rd` | var | Private |  | RadioButton | 17 |
| `$Bval` | var | Private |  | Variant | 18 |
| `$gestarif` | var | Private |  | GesTar | 19 |
| `$artopt` | var | Private |  | Artopt | 20 |
| `Bsel` | var | Public |  | Boolean | 22 |
| `Bval` | var | Public |  | Variant | 23 |
| `tbl` | var | Public |  | Achat | 24 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 27-86 | Public | 5 | 51 | 0 | méthode spéciale |
| `Form_Open` | 88-126 | Public | 2 | 36 | 0 | handler GUI |
| `form_Close` | 128-147 | Public | 9 | 18 | 0 | handler GUI |
| `Window_Close` | 149-164 | Public | 7 | 14 | 0 | handler GUI |
| `fcode_LostFocus` | 166-170 | Public | 2 | 3 | 0 | handler GUI |
| `fcode_KeyPress` | 172-176 | Public | 2 | 3 | 0 | handler GUI |
| `com_LostFocus` | 178-182 | Public | 2 | 3 | 0 | handler GUI |
| `nbl_LostFocus` | 184-188 | Public | 2 | 3 | 0 | handler GUI |
| `ncom_LostFocus` | 190-194 | Public | 2 | 3 | 0 | handler GUI |
| `TabStrip1_Click` | 196-209 | Public | 10 | 11 | 0 | handler GUI |
| `dte_LostFocus` | 211-215 | Public | 2 | 3 | 0 | handler GUI |
| `Achat_Ajou` | 217-239 | Public | 2 | 20 | 0 | handler GUI |
| `Achat_LecArt` | 241-245 | Public | 1 | 3 | 0 | handler GUI |
| `LPrix_change` | 247-271 | Public | 8 | 22 | 0 | handler GUI |
| `Update_Req` | 274-316 | Public | 1 | 37 | 0 | portée réductible ? |
| `ColTri_KeyPress` | 318-322 | Public | 2 | 3 | 0 | handler GUI |
| `ColTri_MajSel` | 324-373 | Public | 15 | 47 | 0 | handler GUI |
| `commande_click` | 376-390 | Public | 3 | 13 | 0 | handler GUI |
| `reception_click` | 392-407 | Public | 3 | 14 | 0 | handler GUI |
| `Valide_click` | 409-424 | Public | 3 | 14 | 0 | handler GUI |
| `FourMan` | 426-444 | Private | 3 | 16 | 0 |  |
| `creation_Click` | 448-467 | Public | 3 | 17 | 0 | handler GUI |
| `imprime_Click` | 469-481 | Public | 4 | 10 | 0 | handler GUI |
| `mail_Click` | 483-488 | Public | 3 | 4 | 0 | handler GUI |
| `generer_Click` | 490-499 | Public | 5 | 8 | 0 | handler GUI |
| `suppr_Click` | 501-517 | Public | 5 | 14 | 0 | handler GUI |
| `annul_Click` | 519-574 | Public | 7 | 50 | 0 | handler GUI |
| `ValideS_Click` | 576-585 | Public | 2 | 8 | 0 | handler GUI |
| `ValCom` | 587-625 | Private | 17 | 34 | 0 |  |
| `ged` | 627-668 | Private | 6 | 35 | 0 |  |
| `rececp_Click` | 671-835 | Public | 29 | 150 | 0 | handler GUI |
| `Etarif_Click` | 837-850 | Public | 5 | 11 | 0 | handler GUI |
| `tardt_Click` | 852-859 | Public | 1 | 5 | 0 | handler GUI |
| `Import_Click` | 861-865 | Public | 5 | 3 | 0 | handler GUI |
| `Tarif_EnrTar` | 867-876 | Public | 1 | 7 | 0 | handler GUI |
| `Achat_EnrTarTemp` | 878-882 | Public | 1 | 3 | 0 | handler GUI |
| `Tarif_CoulBout` | 884-888 | Public | 1 | 3 | 0 | handler GUI |
| `VerSai` | 890-937 | Private | 12 | 44 | 0 |  |
| `BlqSai` | 939-947 | Private | 1 | 7 | 0 |  |
| `ChangVal` | 949-974 | Private | 5 | 19 | 0 |  |
| `Bavec_click` | 976-980 | Public | 1 | 3 | 0 | handler GUI |
| `Bsans_click` | 982-986 | Public | 1 | 3 | 0 | handler GUI |
| `Ecraban_click` | 988-992 | Public | 1 | 3 | 0 | handler GUI |
| `Babandon_click` | 994-999 | Public | 1 | 4 | 0 | handler GUI |
| `Bvalide_click` | 1001-1005 | Public | 1 | 3 | 0 | handler GUI |
| `sortie_Click` | 1007-1011 | Public | 1 | 3 | 0 | handler GUI |
| `RecFo_Click` | 1014-1027 | Public | 2 | 11 | 0 | handler GUI |
| `Achat_gotfocus` | 1029-1041 | Public | 2 | 10 | 0 | handler GUI |
| `Achat_lostfocus` | 1043-1047 | Public | 1 | 3 | 0 | handler GUI |
| `affstk` | 1049-1068 | Private | 9 | 17 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction, ouverture, fermeture

- **`_new(Optional num, nfour, dt, etat = Achat.Reception)`** [portée : nécessaire] [mixte].
  Onglet options (`artopt`, 8 arguments dont le `Parent`), masquage des onglets tarifs/options si
  `/Soc<XX>/prixRecpt` est faux, types des `TextReg`, chaînage, création de `tbl` et
  `$gestarif`. Avec `nfour` : clé `$Bval` (`Fiches_Entrecpt.four/numrecpt/ddate`), `$etat`,
  `$validBR = True`. Prépare deux requêtes (`Utils.db.Prepare("requ_cli"/"requ_typ")`) utilisées
  par `GesTar` (tarifs client et type client, avec `Fiches_TarTemp`).
- **`Form_Open()`** [handler] [GUI]. Fenêtre `$win` (radios `commande`, `reception`, `valide`),
  puis `ColTri_MajSel($Bval)` si un document est passé, puis `rd.Value = True` sur le dernier
  radio (« BR validées ») → `Valide_click` (ignoré si des lignes sont chargées). ⚠️ Dans
  `ColTri_MajSel`, `$Bval = Bval` (membre `Public` encore `Null`) **écrase** la clé passée par
  `_new` : les appels suivants à `tbl.SupAchat($etat, $Bval, …)` reçoivent `Null` (A02).
- **`form_Close()`** [handler] [mixte]. Libère le verrou de document (`DocActif.free_lock`) ;
  saisie en cours : confirmation, puis `annul_Click` — mais `$validBR` vient d'être mis à `True`,
  donc `annul_Click` ne fait que `Me.Close` (réentrant pendant la fermeture, à confirmer) ;
  ferme `$win`, vide `Col` et `$prop`.
- **`Window_Close()`** [handler de `$win`] [GUI]. Fermer la fenêtre de sélection ferme l'écran
  (avec confirmation si saisie en cours).
- **`sortie_Click()`** [handler] : `Me.Close`.

### Zones d'en-tête

- **`fcode_LostFocus` / `fcode_KeyPress` (F2) / `RecFo_Click`** [handlers] [mixte]. Fournisseur :
  `FourMan`, ou sélection par `TriCpt(Fournisseur, Sans_Solde, Me)` (écrit `Bsel`/`Bval`, aussi
  utilisés par la `TriGen`).
- **`FourMan(four)`** [Private] [mixte]. `SELECT * FROM Fiches_Four` : nom, `$Apdf = fo_copie`,
  bouton « Générer » ; inconnu → message. Propage `tbl.fourisseur`.
- **`com_LostFocus` / `nbl_LostFocus` / `ncom_LostFocus` / `dte_LostFocus`** [handlers] [GUI].
  Recopient commentaire, numéro (BR ou commande) et date dans `tbl`.
- **`TabStrip1_Click()`** [handler] [GUI]. Onglet tarifs : `$gestarif.ligachat = ligne
  courante` ; onglet options : article courant dans `artopt`.

### Événements d'`Achat` et de `GesTar`

- **`Achat_Ajou(Value)`** [handler] [GUI]. Nouvelle ligne : dernier champ (`Rem` ou `Frais`),
  retire `Px_Net`/`Px_Rev` (et `Frais` avec options) du chaînage, efface les zones de stock, et
  observe le prix de la ligne (`New Observer(Value.prx) As "LPrix"`). Locales `gt`, `opt`
  inutilisées.
- **`Achat_LecArt(Value)`** [handler] : `$gestarif.LecArt = Value`.
- **`LPrix_change(lp)`** [handler] [calcul + affichage]. Recalcule frais, HT articles, HT, TTC
  (consignes comprises en options `B`/`T`), quantité, et `tbl.TotHt`/`TotTtc` (affectés dans la
  boucle).
- **`Achat_EnrTarTemp(...)`** [handler] : `$gestarif.EnrTarTemp(...)` (tarif temporaire).
- **`Achat_gotfocus` / `Achat_lostfocus`** [handlers] [GUI]. `affstk` ; positionne `Panel3`
  (bouton de recherche) sur la ligne si le focus est sur le code.
- **`affstk()`** [Private] [mixte]. Quantité en commande (`SUM(qte)` de `Fiches_Ligcom`), stocks
  mini/maxi, commande minimum, stock, quantité à commander `/ CFloat(art_txconv)` (division par
  zéro si `art_txconv` est nul ou vide, A07).
- **`Tarif_EnrTar()`** [handler de `GesTar.EnrTar`] [calcul]. `Begin`, `EnrTar` de la ligne
  courante, `Commit` (imbriqué dans la transaction de `GesTar.Enreg_Click`, GESTAR-A07).
- **`Tarif_CoulBout()`** [handler] : bouton `Etarif` en rouge (tarifs modifiés non enregistrés).

### Sélection de document

- **`Update_Req()`** [portée : réductible, appelée par les trois radios] [mixte]. Colonnes
  `ObjProp` (fournisseur, nom, numéro, date, HT, TTC, commentaire) et `New TriGen($panel, Col,
  Res, $req, 20, Me) As "ColTri"`.
- **`commande_click` / `reception_click` / `Valide_click`** [handlers des radios créés par code]
  [mixte]. Refusés si une saisie est en cours ; requête (`Fiches_Entcom` ou `Fiches_Entrecpt`),
  état, `Update_Req`, filtre `validee`.
- **`ColTri_KeyPress()`** [handler] : Échap ignoré.
- **`ColTri_MajSel(val)`** (CC 15) [handler de `TriGen.MajSel`] [mixte]. `Stop Event` (la
  `TriGen` reste ouverte) ; construit `$cond` par `Utils.db.Subst` (clés de colonnes), `FourMan`,
  `tbl.LitCommande($cond, $etat)`, `Wait 0.1`, verrou `DocActif.get_lock("Achat", ndoc)` (échec →
  `annul_Click`), recopie des zones, déblocage de la date en réception, désactive `$win`. La
  locale `col` masque le membre `Col` (identifiants insensibles à la casse).

### Boutons

- **`creation_Click()`** [handler] [GUI]. Nouvelle commande (`tbl.ajout`, état `CreaCommande`).
- **`imprime_Click()`** [handler] [mixte]. `tbl.imprime()` → `~/tmp/BonReception.pdf`,
  visualiseur, GED en réception si `fo_copie`.
- **`mail_Click()`** [handler] : `tbl.mail` (pas en création).
- **`generer_Click()`** [handler] [mixte]. Sans ligne : création ; sinon génération des besoins
  (`tbl.generer`).
- **`suppr_Click()`** [handler] [mixte]. `Begin`, **`$gestarif.SupTarTemp()` une fois par ligne**
  alors que `SupTarTemp` supprime les tarifs temporaires de l'article courant de `GesTar`
  (`$resart`) : les autres articles gardent des tarifs temporaires orphelins (GESTAR-A01) ;
  `tbl.SupAchat($etat, $Bval, True)` (`Rollback` si échec), `Commit`, `annul_Click`. Pas de
  confirmation dans `commande1`.
- **`annul_Click()`** [handler] [GUI]. Mode `$validBR` : `Me.Close`. Sinon : détache les prix
  des lignes, **`Object.Detach($gestarif)`** puis `tbl.Delete`/`$gestarif.Delete`, remise à blanc,
  libération du verrou, `tr.Update`, état `Sans`. ⚠️ `$gestarif` n'est jamais rattaché ni recréé :
  après la première annulation (donc après chaque enregistrement), `Tarif_EnrTar` et
  `Tarif_CoulBout` ne sont plus reçus pour la suite de la session (A03, à confirmer). Contient
  du code de débogage : `Print Object.Count(tbl)` ×2 et `Shell "free"` ×2.
- **`ValideS_Click()`** [handler] : `ValCom`, puis `annul_Click` si succès.
- **`ValCom()`** (CC 17) [Private] [mixte]. Refus en état `Validee` ; `VerSai` ; `Begin` ;
  matériels (`ContMat`/`CreMat`, **retour sans `Rollback`** si abandon, A04) ; `SupAchat` de
  l'ancien document (sauf création) ; `EnrAch` (**`Commit` interne**) ; en réception, pour chaque
  ligne dont il n'existe pas de réception plus récente, `EnrTar` + `EnrArt` hors transaction ;
  `Commit` ; impression et `ged`.
- **`ged()`** [Private] [mixte]. Archivage du PDF : `LGed.Search` ou `New LGed`, `DTE`, montants,
  `PDFDupli` (`ret = 1` → `Supprime`), `DelAllTag`, tags (document, fournisseur, `tag_def` lu par
  `"… WHERE fo_code = " & fcode.Text`, concaténé sans quotes, A05).
- **`rececp_Click()`** (CC 29, max du fichier) [handler] [mixte]. Selon `Last.Tag` :
  - `Sans` : `ValidBR1.Showmodal` (auto-instance) ;
  - `Reception` : fenêtre modale construite par code (date d'écriture, « Avec/Sans écriture
    comptable », « Abandon » → handlers `Bavec`/`Bsans`/`Ecraban`), `ValCom`,
    `ValidBR1.Ecritures(dtv, date, nbl, four, choix, TotHt, TotTtc)`, `annul_Click` ;
  - `CreaCommande`/`EnCommande` : `VerSai(Reception)` (alloue un n° de BR, et en création un n°
    de commande), refus si le n° de BR existe, avertissement de date (`VerifDate.DateCom`),
    `tbl.CreRec()` (fenêtre réception/reliquat) ; options `B`/`T` : contrôle de clôture des
    droits et **vignette** (fenêtre modale, `LOCK TABLES Fiches_Parametres`, `nvign + 1`,
    `UNLOCK`) ; `Begin`, `CreMat` (retour sans `Rollback`), `SupAchat` de la commande, `EnrAch`
    (résultat **ignoré**, A04), puis pour chaque ligne `EnrTar`/`EnrArt`/`EnrEtiqu` hors
    transaction ; PDF, `ged`, `annul_Click`, puis `tbl.CreReliquat()` **après** `tbl.Delete`
    (ACHAT-A08). La condition `$etat = Achat.Reception And Not dra` est inatteignable dans ce
    `Case`.
- **`Bavec_click` / `Bsans_click` / `Ecraban_click` / `Babandon_click` / `Bvalide_click`**
  [handlers des boutons créés par code] [GUI]. `Last.Tag.Close(n)` (la fenêtre est dans `Tag`) ;
  `Babandon` fait aussi `UNLOCK TABLES`.
- **`Etarif_Click()`** [handler] [calcul]. `Begin`, `EnrTar` de toutes les lignes, `Commit`.
- **`tardt_Click()`** [handler] : `New DateTar(Null, fcode.Text).Showmodal` (tarifs par date).
- **`Import_Click()`** [handler] : `tbl.Import()` (inventaire portable).

### Contrôles

- **`VerSai(etat)`** (CC 12) [Private] [mixte]. Lignes non vides (`Netoyage`), fournisseur, n° de
  BR auto (`LockIncrement("dnbr")`) en réception, date, n° de commande auto
  (`LockIncrement("dncom")`) et unicité en création (teste `$etat`, pas le paramètre), n° de
  commande obligatoire, doublons (`tbl.Doublon`). Les numéros alloués sont perdus si un contrôle
  suivant échoue.
- **`BlqSai(Value)`** [Private] [GUI]. (Dé)verrouille l'en-tête.
- **`ChangVal(etat)`** [Private] [GUI]. Texte, icône et `Tag` de `rececp`.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/prixRecpt"]`, `Start.Societe`.
- `Utils.db` (`Exec`, `Prepare`, `Subst`, `Begin`, `Commit`, `Rollback`, `LockIncrement`),
  `Utils.Option`, `Cbase.Table("TabFour")`, `DocActif` (verrous de document), `Visualiseur`,
  `LGed`, `LPrix`, `LDate`, `VerifDate`.
- `Bsel`, `Bval` `Public` : écrits par `TriGen` et `TriCpt` (`Object.SetProperty`) — partagés par
  les deux mécanismes de sélection.
- `tbl` `Public` (signalé « portée réductible » ; aucun accès externe trouvé, mais à conserver
  tant que `Achat` et ses événements ne sont pas reworkés).
- `Create Static` sur un formulaire : `Fmenu` utilise l'auto-instance (`Commande1.show()`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `rececp_Click` (CC 29) : une fonction privée par état (`ValideFactures`, `ReceptionCommande`)
  et une fonction `DemandeVignette() As String` ; la fenêtre « avec/sans écriture » dans
  `DemandeModeEcriture()`.
- Supprimer le code de débogage d'`annul_Click` (sortie console uniquement).
- `ValCom` et `rececp_Click` dupliquent `Begin`/`CreMat`/`SupAchat`/`EnrAch`/boucle tarifs/PDF/GED.
- **Rework conjoint de la transaction** (`commande1`, `Achat`, `GesTar`) : déplacer le `Commit`
  d'`EnrAch` à la fin de la séquence de l'appelant (tarifs et fiche article inclus), un seul
  `Begin`/`Commit`/`Rollback` par action utilisateur. Change le comportement en cas d'erreur
  (atomicité) → anomalie (A04), à faire avec `ACHAT` et `GESTAR-A07`.

### Commonalisation avec d'autres fichiers

- **Archivage GED** (`ged`) : séquence `Search/New/PDFDupli/Supprime/DelAllTag/AddTag(s)` commune
  avec [ObjFac](../../Facturation/ObjFac.class/architecture.md) (`CopieGedFac`), `Edbr`,
  `EcrAuto` → `LGed.Archive` (LGED-007 ; même démarche que OBJFAC-008).
- **Fenêtres modales construites par code** (date/choix, vignette) : helper commun avec
  [Achat](../../Entrées/Achat.class/architecture.md) (`CreFen`, ACHAT-009).
- **Vignette** : même séquence que `Mvtex.atvig` (MVTEX-009).
- Lecture des tags par défaut du fournisseur : même défaut dans `ValidBR1.scanged`, `ObjFac`,
  `Edbr`.

### Réduction de portée

- `Update_Req` → `Private` (appelée seulement par les trois radios). `tbl` reste `Public` par
  prudence (voir ci-dessus). Tous les handlers (y compris ceux des contrôles créés par code :
  `commande_click`, `Bavec_click`…, et des objets `Achat_*`, `Tarif_*`, `LPrix_change`,
  `ColTri_*`, `Window_Close`) restent `Public`.

### Séparation traitement / GUI

- `affstk` : calcul des quantités dans une fonction qui renvoie les valeurs, affichage séparé.
- `VerSai` : contrôles purs (`VerifieDocument(...) As String` message) d'un côté, focus et
  messages de l'autre.
- `LPrix_change` : calcul des totaux dans `Totaux(tbl) As Float[]`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Numéros `dnbr`/`dncom` alloués avant validation : une séquence attribuée au `Commit` éviterait
  les trous.
- `Fiches_Parametres.nvign` à déclarer dans le schéma de référence (`db_control.csv`).
- Clé de réception (`four`, `numrecpt`, `ddate`) : un identifiant technique simplifierait
  `$cond`/`$Bval` et les verrous `DocActif`.
