# Moulinage — Architecture

> Source : `.src/Caisse/Moulinage.class`

## Vue d'ensemble

`Moulinage` est le **passage en comptabilité de la caisse** (glossaire AGENTS.md) : pour une date
choisie dans `DateChooser1`, il transforme les tickets validés par un ticket Z
(`Fiches_EntTicketz`/`Fiches_LigTicketz`, `statut = "V"`) en écritures comptables
(`Fiches_Mvt`), archive les tickets (`Fiches_HisEntTickets`/`Fiches_HisLigTickets`), facture les BL
réglés en caisse, génère la **facture magasin** du jour (`Fiches_HistoFac`/`Fiches_HistoLigfac`),
passe les règlements en trésorerie (via `EcrReg`), imprime le livre de caisse, puis **efface** les
tickets traités.

Le fichier (2 902 lignes, 33 fonctions, CC 622) joue trois rôles :

1. **Écran** (`Moulinage.form` : `DateChooser1`, boutons Moulinage, Contrôle, Quitter, Aide),
   ouvert par `Fmenu.Menu215_Click` (`Moulinage.ShowModal`, après le contrôle du tunnel de
   réplication).
2. **Bibliothèque de la caisse** : `Caisse.class` appelle l'**auto-instance** du formulaire pour
   `Generation_Bl` (BL d'un ticket client en compte, `Caisse.class:6141`) et `Livre_caisse`
   (tickets X/Z, `Caisse.class:6915`). L'auto-instance exécute `_new` (lecture de
   `Fiches_Parametres`) sans afficher la fenêtre ; son état d'instance (`Artrm`, `Rms`, `Typec`…)
   persiste entre deux appels.
3. **Outil de contrôle a posteriori** (`Controle_Moulinage`, bouton Contrôle) : recalcule la
   ventilation attendue d'une journée déjà moulinée et peut créer une écriture de correction.

Chaîne du moulinage (`Button1_Click` → `Moulinage()`) :

```
Verif_Reglement_Caisse → confirmations → caisses déconnectées et Z tirés → mysqldump
Moulinage(): Virements/Ventilation (tables de travail) → Parametres → numéros d'écriture
  → contrôles (tickets V plus anciens, mois de facturation, SHA-1 des tickets)
  → creatmp (Tmp_Caisse) → LOCK TABLES
  → pour chaque ticket du jour : archivage, Totalisation (ventes HT, TVA, client caisse),
    acomptes/avoirs/crédits (Moulinage_Acomptes_Avoir), mouvements hors vente,
    BL réglés (Facturergbl.Ent_Bl + ObjFacB.editef + écritures), factures non acquittées
  → Verif (écart de ventilation) → Maj_Compta (écriture de ventes) → Maj_Tresorerie (EcrReg)
  → Maj_Parametres (dnbon) → genfac (facture magasin, comptmat) → UNLOCK TABLES
  → Livre_caisse (toutes caisses) → DELETE des tickets moulinés
```

L'ensemble n'est **pas transactionnel** : le `Catch` final affiche un message demandant de
restaurer la sauvegarde `mysqldump` faite au début (MOULINAGE-A03).

Nature globale : **mixte**. Le calcul (SQL, ventilation) est entremêlé de `Message.*`, de
`ProgBar` et de lectures de `DateChooser1.Value` dans presque toutes les fonctions.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Jnl` | var | Private |  | String | 3 |
| `numr` | var | Private |  | Integer | 4 |
| `numr2` | var | Private |  | Integer | 5 |
| `numecr` | var | Private |  | String | 6 |
| `client` | var | Private |  | String | 7 |
| `Nclient` | var | Private |  | String | 8 |
| `collectif` | var | Private |  | String | 9 |
| `typec` | var | Private |  | String | 10 |
| `Artdsg` | var | Private |  | String | 11 |
| `Artdsg2` | var | Private |  | String | 12 |
| `Artfam` | var | Private |  | String | 13 |
| `Nbd` | var | Private |  | String | 14 |
| `Nbdec` | var | Private |  | String | 15 |
| `Paht` | var | Private |  | String | 16 |
| `Pmp` | var | Private |  | String | 17 |
| `Artpu` | var | Private |  | String | 18 |
| `Artbrut` | var | Private |  | String | 19 |
| `Artnet` | var | Private |  | String | 20 |
| `Arttc` | var | Private |  | String | 21 |
| `Artrm` | var | Private |  | String | 22 |
| `Rms` | var | Private |  | New String[6, 3] | 23 |
| `Qte` | var | Private |  | String | 24 |
| `Decq` | var | Private |  | String | 25 |
| `Ttva` | var | Private |  | Float | 26 |
| `Tx` | var | Private |  | Float | 27 |
| `Arttx` | var | Private |  | String | 28 |
| `Arr` | var | Private |  | String | 29 |
| `Decm` | var | Private |  | String | 30 |
| `Ecot` | var | Private |  | String | 31 |
| `Tcp` | var | Private |  | String | 32 |
| `marge` | var | Private |  | String | 33 |
| `Datem` | var | Private |  | String | 34 |
| `CptCaisse` | var | Private |  | String | 35 |
| `Vic` | var | Private |  | String | 36 |
| `Vichq` | var | Private |  | String | 37 |
| `Vibonus` | var | Private |  | String | 38 |
| `Vibachat` | var | Private |  | String | 39 |
| `Vitresto` | var | Private |  | String | 40 |
| `Viautre` | var | Private |  | String | 41 |
| `Vicadeau` | var | Private |  | String | 42 |
| `jnal` | var | Private |  | String | 43 |
| `jnal3` | var | Private |  | String | 44 |
| `RegroupBL` | var | Private |  | Facturergbl | 45 |
| `$nfour` | var | Private |  | String | 46 |
| `$resdif` | var | Private |  | Result | 47 |
<!-- /AUTO:declarations -->

Variables d'instance **inutiles** (vérifié par `grep -w`) : `Vic`, `Vichq`, `Vibonus`,
`Vibachat`, `Vitresto`, `Viautre`, `Vicadeau` (jamais référencées) ; `Nclient`, `Artdsg2`,
`Paht`, `Ecot`, `Tcp`, `Decm`, `jnal3` (écrites, jamais lues) ; `marge` (masquée par la locale
de `Generation_Bl`) ; `collectif` est calculé par `Parametres` mais toujours réécrit (`""`/`"1"`)
par `Maj_Compta` avant usage.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 49-53 | Public | 1 | 3 | 0 | méthode spéciale |
| `form_Open` | 56-61 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 64-68 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 71-104 | Public | 7 | 31 | 0 | handler GUI |
| `Livre_caisse` | 106-748 | Public | 196 | 600 | 1 |  |
| `Generation_Bl` | 750-871 | Public | 15 | 107 | 1 |  |
| `Moulinage_Acomptes_Avoir` | 874-949 | Public | 13 | 57 | 0 | portée réductible ? |
| `Moulinage` | 952-1480 | Public | 126 | 434 | 0 | portée réductible ? |
| `Button4_Click` | 1483-1487 | Public | 1 | 3 | 0 | handler GUI |
| `Controle_Moulinage` | 1489-1930 | Public | 79 | 363 | 0 | portée réductible ? |
| `Recup_Art` | 1934-2019 | Public | 30 | 74 | 0 | portée réductible ? |
| `Remises_quantitatives` | 2024-2060 | Public | 10 | 32 | 0 | portée réductible ? |
| `CalcTTC` | 2065-2074 | Public | 2 | 8 | 0 | portée réductible ? |
| `Recup_Tva` | 2079-2089 | Public | 2 | 8 | 0 | portée réductible ? |
| `Decimal` | 2094-2111 | Public | 4 | 16 | 0 | portée réductible ? |
| `arrondi` | 2116-2151 | Public | 11 | 30 | 0 | portée réductible ? |
| `Calc_Marge` | 2153-2168 | Public | 5 | 13 | 0 | portée réductible ? |
| `Ventilation` | 2173-2184 | Public | 1 | 10 | 0 | portée réductible ? |
| `Virements` | 2189-2201 | Public | 1 | 10 | 0 | portée réductible ? |
| `Ecritures` | 2206-2221 | Public | 3 | 13 | 0 | portée réductible ? |
| `Majnum` | 2226-2230 | Public | 1 | 3 | 0 | portée réductible ? |
| `Parametres` | 2235-2269 | Public | 9 | 31 | 0 | portée réductible ? |
| `Maj_Totalisation` | 2274-2305 | Public | 8 | 27 | 0 | portée réductible ? |
| `Verif` | 2307-2355 | Public | 11 | 43 | 0 | portée réductible ? |
| `Maj_Compta` | 2360-2485 | Public | 20 | 116 | 0 | portée réductible ? |
| `Verif_Reglement_Caisse` | 2489-2509 | Public | 4 | 15 | 0 | portée réductible ? |
| `Maj_Tresorerie` | 2512-2572 | Public | 10 | 53 | 0 | portée réductible ? |
| `majsld` | 2574-2594 | Private | 4 | 18 | 0 |  |
| `majecr` | 2596-2615 | Private | 1 | 16 | 0 |  |
| `Maj_Collectif` | 2618-2659 | Public | 5 | 39 | 0 | portée réductible ? |
| `genfac` | 2664-2874 | Private | 37 | 187 | 0 |  |
| `creatmp` | 2877-2893 | Private | 2 | 15 | 0 |  |
| `Button3_Click` | 2898-2902 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Écran et événements

- **`_new()`** [portée : nécessaire] [nature : calcul]. `SELECT cptrplus, cptrmoins FROM
  Fiches_Parametres` (nom en dur) gardé dans `$resdif` (comptes d'écart de caisse). Exécuté aussi
  par l'auto-instance utilisée par la caisse.
- **`form_Open()`** [portée : nécessaire, handler] [nature : calcul]. `Parametres()` puis
  `Ventilation()` (recréation de la table de travail `Totalisation`).
- **`Button2_Click()`** [handler] [GUI]. Ferme l'écran.
- **`Button3_Click()`** [handler] [GUI]. `Doc.Open("Moulinage")`.
- **`Button4_Click()`** [handler] [GUI]. Lance `Controle_Moulinage()`.
- **`Button1_Click()`** [handler] [mixte]. Garde-fous puis moulinage :
  `Verif_Reglement_Caisse()` ; confirmation « effacer les bordereaux de remises » (message
  **obsolète** : depuis `d2a027d8`, 2020, le moulinage n'écrit plus ni n'efface
  `Fiches_BordereauxC`, MOULINAGE-A15) ; refus si une caisse est connectée
  (`Fiches_Caisses.connecte = 1`) ou si un ticket Z n'est pas tiré (`tkz = 0`) ; seconde
  confirmation ; `mysqldump` vers `~/Sauve/<base>.sql<aaaammjj>` par `Shell … Wait` avec le mot de
  passe en clair sur la ligne de commande, sans contrôle du résultat, tenté aussi sous SQLite
  (MOULINAGE-A15) ; puis `Moulinage()`.

### Livre de caisse (`Livre_caisse`, CC 196, 600 lignes)

**`Livre_caisse(Ncaisse, Statut, Validate, p_date, Format, Filename) As Boolean`** [portée :
nécessaire — `Caisse.Defaut_Ticketxz` (`Caisse.class:6915`) et `Moulinage()`] [nature : mixte,
PDF].
- Appelle d'abord `Ventilation()` et `Parametres()`, sans utilité pour l'édition : chaque ticket X
  ou Z de la caisse **supprime et recrée** la table de travail `Totalisation`.
- PDF `Cfacture` (A4 ou ticket) dans `~/Caisse/Livre_caisse<caisse>_<date>.pdf` (ou `Filename`).
- Pour chaque caisse (`Fiches_Caisses`, filtrée par `Ncaisse` si non vide) et les tickets
  `Fiches_EntTicketz` du `Statut` demandé (filtre `DATE(e.date)` si `p_date`) : totaux de ventes
  (avoirs en négatif, clients en compte exclus), fond de caisse, tickets annulés, totaux par mode
  de règlement (`GROUP BY l.type, DATE(e.date)`, 17 libellés codés en dur), panier moyen (si
  `Validate`), récapitulatif TVA, total général `fndtotg`, ventes HT par famille, puis le détail
  des tickets en 4 blocs **quasi identiques** (supprimés, encaissés, clients en compte, en erreur ;
  ~70 lignes chacun, 2 colonnes en A4).
- Si `Validate` (ticket Z) : `Update Fiches_EntTicketz as e set e.statut = "V" …` (alias qualifié
  dans `SET` : non accepté par SQLite, à confirmer) puis `UPdate Fiches_Caisses SET fndc, dtefm,
  tkz = 1`.
- ⚠️ Les cumuls `totcaisse`, `totventes`, `tespece`, `itva` (et `tmttc` si la somme est nulle) ne
  sont **pas remis à zéro entre deux caisses** : le livre multi-caisses imprimé par le moulinage
  (`Ncaisse = Null`) cumule les caisses précédentes (MOULINAGE-A09). `Dec Application.Busy` sans
  `Inc` préalable. Variables mortes : `sFam`, `sFam2`, `sLFam`, `sMtfam`, `Enc`, `Boncaisse`,
  `totboncaisse`, `tcheque`, `tcarte`, `sintitule` (écrite).
- Requête des tickets en erreur (l. 640) : arguments `"E", 0, caisse` pour `&1`/`&3` (le `&2` est
  ignoré).

### BL client en compte (appel depuis la caisse)

**`Generation_Bl(Ntk, Client, Bande_Z_Valide) As String`** [portée : nécessaire —
`Caisse.class:6141`] [nature : calcul].
- Lit le ticket (`statut` `"V"` ou `"0"`), réserve un numéro de BL par
  `Utils.db.LockIncrement("dnbon", Fiches_Parametres)`, lit le client (`Fiches_Cli`), insère
  l'entête `Fiches_Bl` (25 colonnes), une ligne commentaire d'origine, puis pour chaque ligne :
  article `A` (avec saut des lignes éco-taxe `O` et lecture de la remise `S` suivante, puis
  retour) → `Recup_Art` + `Calc_Marge` → `INSERT Fiches_Ligbl` ; éco-taxe `O`
  (`" Dont Eco-taxe"`) → ligne `E` ; commentaire `C` → ligne `C`. Met à jour les totaux de
  l'entête. Renvoie le numéro de BL, ou `Null`.
- Sans transaction. Dépend de l'état d'instance (`Typec`, `Artrm` lus ici et utilisés par
  `Recup_Art`). La navigation `MoveNext`/`MovePrevious` suppose qu'un article n'est jamais la
  dernière ligne du ticket (à confirmer : lecture d'un enregistrement hors résultat sinon).

### Moulinage (traitement principal)

- **`Moulinage() As Boolean`** [portée : réductible] [nature : mixte, CC 126]. Voir la chaîne
  ci-dessus. Points notables :
  - Numéros d'écriture : `numr = Ecritures("numecriture") + 1`, `numr2 = …("numecriture2") + 1`
    (sans verrou, cf. SAISECRIT-A01) ; `numbon` lu dans `dnbon` puis incrémenté localement pour
    chaque regroupement de BL, réécrit par `RegroupBL.Maj_Parametres(numbon)` en fin de traitement.
  - Contrôles : ticket `V` plus ancien que la date → message et arrêt ; date au-delà du mois de
    facturation `dtepec` → message et arrêt ; SHA-1 de chaque ticket
    (`Sha1Calc.CalcSha1T("Fiches_EntTicketz", …, False)`) → liste des tickets altérés et choix
    OK/ANNULER (le retour `ANNULER` laisse le curseur en attente).
  - `LOCK TABLES` de 26 tables (l. 1064), relâché par `UNLOCK TABLES` (l. 1440/1456) ; **pas**
    dans le `Catch`. La liste omet des tables écrites ensuite (`Tmp_Caisse`, `Fiches_HistoFac`,
    `Fiches_HistoLigfac`, `Fiches_ligregie`…) ; sous MySQL, le premier `LOCK TABLES` de
    `DocActif` appelé par `Facturergbl.Ent_Bl` (FACTURERGBL-A03) ou le premier `Begin` (`genfac`,
    `ObjFacB`) **libère** ces verrous : la protection est illusoire, et un accès à une table non
    verrouillée avant cette libération lèverait une erreur (MOULINAGE-A02, à confirmer).
  - Ticket dont le numéro a déjà été traité (doublon après crash) → `statut = "E"`, ignoré.
  - Pour chaque ticket : copie de l'entête dans `Fiches_HisEntTickets` ; si `type = "0"` (client
    caisse) : en-tête « Ticket supprimé! » si `suppr` ; `Maj_Totalisation(client caisse, TTC)` sauf
    supprimé ou avoir ; archivage des lignes (`Fiches_HisLigTickets` ; une ligne `BL` reçoit la
    famille `Fam` de la ligne **précédente**, MOULINAGE-A11) ; ventilation des lignes :
    - `BL` réglé : pour chaque ligne article du BL, compte de vente de la famille (avec
      `compt5_fam` si rétrocession, compte du dépôt de la caisse dans `Fiches_FamDep`) et compte de
      TVA ;
    - `A`/`M`/`S`/`T`/`L`/`C` : idem sur la ligne du ticket (HT de la ligne, TVA de la ligne `T`
      ou `M` associée), avoir en négatif ;
    - `Z`, `EZ`, `W`, `RA`/`EA` → `Moulinage_Acomptes_Avoir` avec les comptes **en dur** `419700`
      (avoirs), `468700` (crédits), `419100` (acomptes) ;
    - `EH`/`SH` (entrée/sortie de caisse) → `cptrplus`/`cptrmoins`.
  - BL réglés par le ticket et regroupés par client : `RegroupBL.Ent_Bl(…)` (instance invisible de
    `Facturergbl`, créée à chaque moulinage : son `_New` lance `lpc status`, `Utils.Observers` et
    `Music.Load`), `New ObjFacB(numbon, ObjFac.facture, date).editef()` (facture sans saisie de
    règlement), ligne client caisse ajoutée à l'écriture de facture `fac.numeroecr`, `UPDATE
    Fiches_Bl` (facturé, acquitté, « Caisse »), lettrage (seule la **première** écriture non
    lettrée trouvée est lettrée, toutes lignes confondues, à confirmer), deux lignes de règlement
    dans le journal de trésorerie `Jnal`, `Csolde.Solde_caisse(client)`.
  - Factures déjà émises non acquittées réglées par le ticket : même schéma, mais la ligne client
    caisse est écrite dans une **nouvelle** écriture `numr` du journal de vente (et non dans
    l'écriture de la facture, MOULINAGE-A13, à confirmer).
  - Clients en compte (`type = "1"`) : archivage des lignes seulement (le BL a été créé à la
    saisie par `Generation_Bl`).
  - Fin : `Verif()` → `Maj_Compta()` → `Maj_Tresorerie()` → `Maj_Parametres` → `genfac()` →
    `UNLOCK` → `Livre_caisse(Null, "V", False, date)` → `DELETE` des tickets du jour (`V` et `E`)
    **par numéro seul**, sans la date (MOULINAGE-A10).
  - ~20 variables locales mortes (`cvclibl`, `nmclibl`, `pnmclibl`, `adr1bl`, `adr2bl`, `cpbl`,
    `villebl`, `rmobl`, `bloc`, `Exo`, `origine`, `Remart`, `totalht`, `totalttc`, `dnfac`,
    `snfac`, `msg_err`, `mrg`, `respar`, `scli`, `code`) et étiquette `next_ticket:` inutilisée.
- **`Moulinage_Acomptes_Avoir(Type, jour, CptCli, CptCaisse, Ntk, mnt, libelac, date_moulinage,
  cpt_avac)`** [portée : réductible] [nature : calcul]. Intitulés des trois comptes ;
  `Error.Raise` si le compte d'acompte/avoir n'existe pas ; deux lignes `Fiches_Mvt` (client /
  compte d'acompte, sens selon `RA`/`Z`, `EA`/`EZ` ou `W`), `Maj_Totalisation` du compte
  d'acompte et, selon le cas, de la caisse, `Maj_Collectif` du client, SHA-1, puis
  `Csolde.Solde_caisse` des trois comptes et incrément de `numr`/`numr2`. Le dernier
  `Error.Raise(msg, type)` a **deux arguments** : l'erreur levée est « Too many arguments »
  (MOULINAGE-A12, même défaut que CALCULDROIT1-A02). Le paramètre `CptCaisse` reçoit en fait le
  client caisse (`Client`).
- **`Verif() As Boolean`** [portée : réductible] [nature : mixte]. Somme des débits (comptes 411,
  TTC) et des crédits (autres comptes, HT) de `Totalisation` via `Utils.arrondi(…, 2)` ; un écart
  positif alimente `cptrmoins`, un écart négatif `cptrplus` ; au-delà de 0,05 €, confirmation
  `Message.Error` OK/Annuler (Annuler → `False`). `sCompte` sert seulement à vérifier qu'une ligne
  non 411 existe.
- **`Maj_Compta() As Float`** [portée : réductible] [nature : calcul]. Une écriture `numr` du
  journal de vente `Jnl` (« Caisse du jj.mm.aaaa », `numdoc`/`numlot` = `jjmmaaaa`,
  `cloturee = 1`) : pour un compte 411, ligne de collectif (`coll_cc`, `collectif = 1`) avec mise à
  jour **incrémentale** du solde du collectif (`solde + Mtd - Mtc`, valeur `Sld` périmée si le
  collectif est absent), puis ligne du compte ; comptes de vente/remise (709 en sens inverse) et
  de TVA (445) au crédit ou au débit selon le signe. Après chaque ligne : SHA-1, solde du compte
  `solde + Mtd - Mtc` (`hResult!solde` lu **sans** test `Available`, erreur fatale si le compte
  n'existe pas, MOULINAGE-A17), suppression de la ligne de `Totalisation`. Avertit si la somme
  débit - crédit n'est pas nulle. `Majnum()`. Renvoie le total TTC des comptes 411.
- **`Maj_Tresorerie(Verif_Caisse)`** [portée : réductible] [nature : mixte]. Pour chaque mode de
  règlement de caisse de `Mreglement.RegCais` (1 à 9 : espèces, rendu, carte, chèque, bon d'achat,
  chèque cadeau, autres, bonus, ticket restaurant ; auto-instance du formulaire `Mreglement`) :
  lit **tous** les tickets `V` ayant une ligne de ce type (requête en dur, jointure sur le numéro
  seul, **sans filtre `suppr`**, MOULINAGE-A04) et ne garde en Gambas que ceux du jour ; regroupe
  par client (`regroup` de `Fiches_Reglements`) dans des `VarEcr` (`majecr`, `majsld`) et passe
  chaque écriture par `New EcrReg(code, journal, var).ecriture` ; avertit si le total ne
  correspond pas à `Verif_Caisse`. Un mode sans `Fiches_Reglements.caisse` est compté mais non
  comptabilisé (écart signalé).
- **`majsld(var, slde)`** / **`majecr(cpt, datem, intitul, i, tot)`** [Private] [calcul].
  Cumul d'un montant au débit/crédit d'une `VarEcr` (compensation des sens) ; construction d'une
  ligne de trésorerie `VarEcr.Treso`, état `L_caisse`, libellé « <mode> <date> ».
- **`Maj_Collectif(Cpt, intit, libel, Mnt)`** [portée : réductible] [nature : calcul]. Collectif
  `coll_cc` du compte (lu sans test `Available`) ; si une ligne de collectif existe déjà pour
  (`coll`, `numr`, `numr2`) : `Mtc = Mnt + montantc` (ou `Mtd = Mnt + montantd`, avec `Mnt`
  négatif) puis `UPDATE … set montantc = Mtc` — pour `Mnt ≤ 0` cela **remet `montantc` à 0** sans
  écrire `Mtd` ; sinon `INSERT` d'une ligne `collectif = 1` dans le journal de **trésorerie**
  `Jnal` (les autres lignes de l'écriture sont dans `Jnl`). Le solde du collectif est ensuite
  augmenté de `Mtd - Mtc`, c'est-à-dire du **cumul** et non de l'incrément en cas de mise à jour
  (MOULINAGE-A01). Même défaut que
  [`BordereauxC.Maj_Collectif`](../../Compta/Impressions/BordereauxC.class/architecture.md)
  (BORDEREAUXC-A03), en plus grave (effacement de `montantc`). Vérifié : dans `Moulinage`, chaque
  appel (`Moulinage_Acomptes_Avoir`) utilise un `numr` neuf, la branche de mise à jour n'est donc
  atteinte que si le collectif est lui-même l'un des deux comptes de l'écriture : défaut **latent**
  ici, réel dans `BordereauxC` (plusieurs chèques par écriture).
- **`Verif_Reglement_Caisse() As Boolean`** [portée : réductible] [nature : mixte]. Pour chaque
  mode de caisse utilisé par un ticket `V`, exige une liaison avec un mode de `Fiches_Reglements`
  (`Mreglement.Laision_Reg`), sinon `Message.Error`.
- **`genfac()`** [Private] [nature : calcul, CC 37]. Facture magasin du jour pour le client caisse :
  `Tmp_Caisse` alimentée dans une transaction avec les lignes article (`A`, signe inversé pour un
  ticket avoir) et hors vente (`EH`/`SH`) des tickets non supprimés de type `0` ; pas de facture si
  aucune ligne. Puis, dans une seconde transaction : entête `Fiches_HistoFac` (numéro
  `année + dnfac+1`, totaux de `Tmp_Caisse`, client caisse lu sans test `Available`),
  `UPDATE Fiches_Parametres SET dnfac`, ligne commentaire et une ligne `Fiches_HistoLigfac` par
  (code, famille, type, intitulé). Option boissons `B`/`T` : `Calculdroit1` recalcule le HT hors
  accise si `drsurfac` ; avec CALCULDROIT1-A01, `opt` vaut `True` en option `B`, l'accise **n'est
  pas retirée** (l. 2812, 2825, 2838) et `rem_ligfac` est renseignée (l. 2860) : constat confirmé
  côté Moulinage (MOULINAGE-A14). Enfin `New ObjFacB(snfac, ObjFac.magasin).comptmat(snfac, True)` :
  pour une facture magasin **sans article à droits** (`art_dra`), `comptmat` sort après
  `Utils.db.Begin` sans `Commit` (OBJFACB-A02, confirmé par lecture : branche `magasin` sans ligne
  puis `If Not $borientation Then Return`) ; les `DELETE` de tickets qui suivent s'exécutent alors
  dans une transaction non validée (MOULINAGE-A03, à confirmer). Un article inconnu en option
  `B`/`T` lit `res!art_cdarr` sans test `Available` (l. 2803) ; `SUM(pu)` donne le prix unitaire
  d'un article inconnu comme **somme** des prix (l. 2851) ; conversion `Replace(".", ",")` + `Val`
  dépendante de la locale.
- **`creatmp()`** [Private] [calcul]. `DROP`/`CREATE TABLE Tmp_Caisse` (table de travail).

### Contrôle du moulinage

**`Controle_Moulinage() As Boolean`** [portée : réductible] [nature : mixte, CC 79].
Reconstitue dans `Totalisation` la ventilation attendue de la journée à partir :
1. des BL facturés réglés en caisse non archivés (`Fiches_Bl`, `dtefac` du jour) ;
2. des factures archivées réglées en caisse ou du client caisse (`Fiches_HistoFac`), avec les
   mouvements `EH`/`SH` (copie du bloc 1, champs renommés) ;
3. des tickets archivés d'un autre client (`Fiches_HisEntTickets`) — filtre
   `left(date, 8) = "aaaammjj"` sur une colonne `datetime` (`aaaa-mm-jj …`) : **jamais vrai**,
   bloc sans effet (MOULINAGE-A05).

Puis compare aux écritures du jour (`Fiches_Mvt` en dur, journal `Jnl`, libellé « Caisse du … »,
hors règlements de BL) : écart sur le client caisse (acomptes 4191, avoirs 4197, crédits 4687
déduits) → proposition d'écriture d'erreur `707999`/`445999` (taux de TVA du code `445999`) ;
écarts par compte → écriture de correction `numr` (lignes dont le solde n'est pas recalculé,
« TODO ») si la balance est nulle, puis `Majnum()`. Quand la famille d'une ligne est nulle et
l'article absent, lit `rlTck!fam`, **colonne absente** de `Fiches_Ligbl`/`Fiches_HistoLigfac`
(l. 1559, 1647 : erreur, MOULINAGE-A06). Cinq `Return` anticipés laissent le curseur en attente.
Les blocs 1 et 2 ne tiennent pas compte du dépôt (commentaire « Hélas »).

### Ventilation d'un article (pour `Generation_Bl`)

- **`Recup_Art(numero, ligne, code, qtea, mht, mttc, tva)`** [portée : réductible] [nature :
  mixte]. Lit l'article (`Fiches_Art`) dans les variables d'instance (`Artdsg`, `Artfam`, `Nbd`,
  `Decq`, `Pmp`, `Artpu`, `Artbrut`, `arr`, `Arttx`, `Rms`…), applique la remise par type de
  client (`Fiches_RemTypec`), recalcule PU et brut depuis la caisse, `Remises_quantitatives`,
  `Decimal`, puis compare au TTC de la caisse : écart > 1 centime par unité → `Message.Warning`,
  sinon ajustement du brut et du net. ⚠️ Quantité nulle : `Artpu = Artbrut = "0"` affecte à
  `Artpu` le **booléen** de la comparaison (« True »/« False »), écrit ensuite dans `pu_ligbl`
  (MOULINAGE-A07). Paramètre `tva` inutilisé.
- **`Remises_quantitatives()`** [réductible] [calcul]. Première tranche `Rms` contenant la quantité
  → ajout à `Artrm` ; `Artnet` et `CalcTTC()`. Boucle `0 To Rms.Bounds[0] - 1` : la 6e tranche
  n'est jamais lue (MOULINAGE-A08, même défaut que FACTURE-A07).
- **`CalcTTC()`** [réductible] [calcul]. `Recup_Tva`, TTC arrondi (`arrondi(Arttc, arr)`), net
  recalculé depuis le TTC sauf remise nulle.
- **`Recup_Tva()`** [réductible] [calcul]. `taux_tva` de `Fiches_Tvaav` pour `Arttx`.
- **`Decimal()`** [réductible] [calcul]. Formate `qte` selon `Decq` (0, 2 ou 3 décimales).
- **`arrondi(montant, arrond) As String`** [réductible] [calcul pur]. Arrondi « caisse » au 0,05
  (par inspection du dernier caractère), 0,10, 0,50, 1,00 ; copie de `Caisse.arrondi`
  (`Caisse.class:487`, paramètres inversés) ; résultats mixtes `"2,45"` / `"2.5"` selon la branche.
- **`Calc_Marge() As Float`** [réductible] [calcul]. Sans PMP : `Artnet / coef_fam`
  (lu sans test `Available`) ; sinon `Artnet - Pmp × qte`.

### Tables de travail et paramètres

- **`Ventilation()`** [réductible] [calcul]. `DROP TABLE IF EXISTS Totalisation` puis `CREATE`
  (compte, intitulé, totalttc, totalht, totaltva en `Char`). Même DDL que
  `Facturergbl.Ventilation`.
- **`Virements()`** [réductible] [calcul]. `DROP`/`CREATE TABLE Virements` : la table n'est
  **jamais alimentée** (vestige d'avant `d2a027d8`), mais figure dans le `LOCK TABLES`.
- **`Ecritures(numecr2) As String`** [réductible] [calcul]. `SELECT <numecr> FROM
  Fiches_Parametres` avec la **variable d'instance** `numecr` dans le SQL et le paramètre pour la
  lecture (les appelants affectent `numecr` juste avant : cohérent, mais fragile ; même idiome que
  `BordereauxC.Ecritures`, BORDEREAUXC-003).
- **`Majnum()`** [réductible] [calcul]. `UPDATE Fiches_Parametres set numecriture, numecriture2`.
- **`Parametres()`** [réductible] [calcul]. Journaux `Jnl` (`jrnal4`, sinon `jrnal`), `Jnal3`,
  `Jnal` (`jrnal2`, trésorerie) ; client caisse (`Fiches_ClientCaisse`) ; recherche d'un collectif
  de même préfixe (résultat jamais utilisé).
- **`Maj_Totalisation(cpt, intit, montant)`** [réductible] [calcul]. Cumule dans `Totalisation` :
  `totalttc` pour un 411, `totalht` sinon (`Try` sur le cas général) ; insertion si absent (sauf
  compte `Null`).

## État global utilisé

- `Utils.db` (≈ 210 appels), `Cbase.Table` (144 usages), noms en dur : `Fiches_Parametres`,
  `Fiches_Caisses`, `Fiches_FamDep`, `Fiches_Cli`, `Fiches_ClientCaisse`, `Fiches_Mvt`,
  `Fiches_EntTicketz`, `Fiches_LigTicketz`, `Fiches_Comptes`, `Fiches_Reglements`,
  `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Art`, `Fiches_Tvaav`, tables de travail
  `Totalisation`, `Virements`, `Tmp_Caisse`.
- `Utils.cpoint`, `Utils.arrondi`, `Utils.Cdate_Dbase`, `Utils.PointBase`, `Utils.Find_nbdec`,
  `Utils.Option`, `Utils.Bip`, `Utils.MouseProcessing`/`MouseDefault`.
- `Start.LocalSettings["/dbase/Host"]` (sauvegarde), `User.home` (`~/Sauve`, `~/Caisse`).
- Auto-instances de formulaires : `Mreglement` (référentiel des modes), `Moulinage` lui-même
  (appelé par `Caisse`).
- `Sha1Calc` (empreinte des écritures et des tickets), `Csolde.Solde_caisse`, `LDate`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Livre_caisse` : un helper privé `Imprime_Tickets(pdf, titre, rTkx, avec_client, Ba4)` remplace
  les 4 blocs de détail (≈ 280 lignes) ; un tableau des libellés de modes de règlement remplace la
  cascade de 17 `Else If`.
- `Moulinage()` (CC 126) : découpage en sous-fonctions privées par étape (`Controle_Tickets`,
  `Archive_Ticket`, `Ventile_Ticket`, `Regle_BL`, `Regle_Factures`, `Supprime_Tickets`) en gardant
  l'ordre exact des requêtes.
- Résolution « famille → compte de vente (rétrocession, dépôt) → intitulé » et « code TVA →
  compte → intitulé » répétée 5 fois (l. 1133-1168, 1201-1236, 1565-1590, 1653-1678, 1721-1748) →
  `Compte_Vente(fam, retro, depot)` et `Compte_Tva(code)` privés.
- `INSERT INTO Fiches_Mvt (…17 colonnes…)` répété 12 fois → `Insere_Mvt(...)` privé (même SQL).
- `Fiches_Caisses`/`Fiches_FamDep` relus pour **chaque ligne** du ticket : lecture du dépôt une
  fois par ticket (« SQL modifié, dump identique »).
- `Maj_Tresorerie` : filtrer la date en SQL (`DATE(e.date) = &3`) au lieu de lire tous les tickets
  `V` (« SQL modifié, dump identique »).

### Commonalisation avec d'autres fichiers

- **Écritures comptables** : `Ecritures`, `Majnum`, `Parametres`, `Maj_Collectif` sont copiés dans
  [`BordereauxC`](../../Compta/Impressions/BordereauxC.class/architecture.md) (BORDEREAUXC-009) ;
  `Ecritures`/`Majnum` existent aussi dans [`Saisecrit`](../../Compta/Saisecrit.class/architecture.md)
  (SAISECRIT-A01 : lecture/écriture sans verrou) et `Facture` ;
  `Utils.db.LockIncrement` (déjà utilisé par `Generation_Bl`) donnerait un service unique.
- **Solde des comptes** : `Maj_Compta`/`Maj_Collectif` mettent à jour `solde` par incrément alors
  que `Moulinage_Acomptes_Avoir` et les règlements de BL utilisent
  [`Csolde.Solde_caisse`](../../Utils/Csolde.module/architecture.md) (recalcul complet) ; copies
  voisines : `Recalcsolde`, `Calcsolde`, `Calc_solde` de `ClotureF`/`Visreglements`/`TresorFac`.
  Passer à `Csolde.Solde_caisse` corrigerait MOULINAGE-A01 : c'est une anomalie, pas un rework.
- **`Sha1Calc.CalcSha1("Fiches_Mvt", …)`** en dur (13 appels) : même constat que
  [`Saisecrit`](../../Compta/Saisecrit.class/architecture.md) (SAISECRIT-004), `Tresor`,
  `EcrAuto`, `Ecritures`, `BordereauxC` → `Cbase.Table("TabMvt")`.
- **Arrondi au 0,05 par chaîne** : `arrondi` = `Caisse.arrondi` (`Caisse.class:487`) ; voisins
  `Utils.arrondi`, [`LPrix.Arrondi_Calc`](../../Utils/LPrix.class/architecture.md), `Facture`,
  `Articles`, `Movr`, `Materiel`, `FTvav` → une fonction `Utils` unique (pas d'arrondi, montant).
- **Ventilation d'un article** : `Recup_Art`, `Remises_quantitatives`, `CalcTTC`, `Recup_Tva`,
  `Decimal`, `Calc_Marge` sont des variantes de `Facture` (l. 5194, 5963, 7499, 7584, 7603) et de
  `Caisse` (l. 1679, 1702) sans les contrôles.
- **Table `Totalisation`** : DDL identique à `Facturergbl.Ventilation` ; helper commun de création
  des tables de travail (cf. FACTUREFM-007 pour `Facturefm`/`Bl`).
- **Règlement de BL en caisse** : `Facturergbl.Ent_Bl` est appelé via un formulaire instancié
  ([Facturergbl](../../Gestion/Facturation/Facturergbl.class/architecture.md), FACTURERGBL-004) ;
  à terme un service sans formulaire (pas de `lpc status`, pas d'`Observers`).
- **Référentiel des modes de règlement** : `Mreglement` en `Static` (MREGLEMENT-002, syntaxe
  d'appel inchangée ici).
- **Écritures de trésorerie** : `majecr`/`majsld` préparent des `VarEcr` comme `SaiReg` ; voir
  [EcrReg](../../Compta/Utils/EcrReg.class/architecture.md) et
  [VarEcr](../../Compta/Utils/VarEcr.class/architecture.md).
- **Sauvegarde `mysqldump`** : `Utils.DumpBase` (UTILS-014, SAUVESAUTO-003, `Validinv`).
- **Compte du client caisse** : lecture de `Fiches_ClientCaisse` dupliquée dans `Parametres`
  (`Cbase.Table("TabCliCaisse")`) et `Controle_Moulinage` (l. 1528, nom en dur), ainsi que dans
  `Fclientc`, `BordereauxC:242` et `Cmenu:128` → helper `CompteClientCaisse()` proposé par
  [Fclientc](../Fclientc.class/architecture.md).
- **Pré-contrôles** (caisses connectées, Z tirés) : `Utils.ControlePreCloture` proposé dans
  [FClotureAn](../../Compta/Clotures/FClotureAn.class/architecture.md).
- **Édition PDF** : le livre de caisse utilise `Cfacture` (Caisse/Reports) avec le même squelette
  (`Entete`, `Level*`, `BasPage`) que les éditions comptables `Ccompta` (lot Reports).

### Réduction de portée

- 21 membres `Public` sans appelant externe (vérifié par `grep -rn "Moulinage\." .src` : seuls
  `Caisse` → `Generation_BL`, `Livre_caisse` et `Fmenu` → `ShowModal`) → `Private` :
  `Moulinage_Acomptes_Avoir`, `Moulinage`, `Controle_Moulinage`, `Recup_Art`,
  `Remises_quantitatives`, `CalcTTC`, `Recup_Tva`, `Decimal`, `arrondi`, `Calc_Marge`,
  `Ventilation`, `Virements`, `Ecritures`, `Majnum`, `Parametres`, `Maj_Totalisation`, `Verif`,
  `Maj_Compta`, `Verif_Reglement_Caisse`, `Maj_Tresorerie`, `Maj_Collectif`. Aucun n'est cité en
  chaîne (pas d'appel dynamique). `Generation_Bl`, `Livre_caisse`, `_new` et les handlers restent
  `Public`. Règle PLAN §6 : la couverture passe par les replays de moulinage.

### Séparation traitement / GUI

- `DateChooser1.Value` est lu dans `Moulinage`, `Controle_Moulinage`, `Maj_Compta`,
  `Maj_Tresorerie`, `Maj_Collectif`, `genfac` : passer la date en paramètre (`Moulinage_Date(d)`
  appelé par `Button1_Click`) rend le traitement pilotable sans l'écran.
- Les confirmations (`Message.Question`/`Error` avec choix) de `Moulinage`, `Verif`,
  `Controle_Moulinage` restent dans des fonctions d'interface ; le traitement reçoit la réponse
  (ou un callback) : même séquence de boîtes, même SQL.
- `Livre_caisse` : séparer le calcul des totaux (requêtes) de la mise en page.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Montants des tickets en `char(12)` avec virgule (`replace(mttc, ',', '.')`, `cast … decimal`) :
  un type `DECIMAL(12,2)` supprimerait les conversions dans toutes les requêtes du livre de caisse.
- Tables de travail `Totalisation`, `Virements`, `Tmp_Caisse` créées/détruites à chaque appel (et
  par la caisse) : tables temporaires de session (`CREATE TEMPORARY TABLE`) ou structures en
  mémoire ; `Virements` peut disparaître.
- Comptes d'acompte, d'avoir et de crédit (`419100`, `419700`, `468700`) et comptes d'erreur
  (`707999`, `445999`) en dur : colonnes de paramétrage dans `Fiches_Parametres`.
- Clé (`numero`, `date`) sur `Fiches_EntTicketz`/`Fiches_LigTicketz` et jointures sur ce couple
  (les suppressions et la trésorerie n'utilisent que `numero`).
- Colonne `numerodef`/numéros d'écriture : séquence dédiée au lieu de `numecriture` lu/écrit.
