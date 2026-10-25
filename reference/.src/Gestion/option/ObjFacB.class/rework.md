# ObjFacB — Rework

> Source : `.src/Gestion/option/ObjFacB.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/ObjFacB.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 930 |
| Lignes de commentaire | 39 |
| Fonctions | 30 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 226 |
| Complexité max (fonction) | 56 (`calcul`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 930 | 226 | 56 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] OBJFACB-001 — [documentation] En-tête en français : rôle, relation avec `ObjFac`
  (redéfinition de `calcul`, masquage de `verifdat`), codes d'option N/B/P/T, structure des
  tableaux `aimprimer` (8 valeurs) et `decons` (6 valeurs) ; commentaires `'''` des méthodes
  publiques · appelants : aucun · tests : aucun · sources : [ObjFacB.class:_new](../../../../../.src/Gestion/option/ObjFacB.class#L44-L48), [ObjFacB.class:calcul](../../../../../.src/Gestion/option/ObjFacB.class#L61-L280)
- [ ] OBJFACB-002 — [code mort] Supprimer `_call` (aucun appel, seul usage commenté
  `ClotureF:135`), les propriétés `totht` et `clotmat` (aucun lecteur) avec `$ftotht`, les privés
  `$cdrt` (et les `Add` commentés), `$num`, `$slstnum`, `$clot`, le `Me.reslig.MoveTo` inutile de
  `borientation` et les variables locales inutilisées · appelants : aucun (vérifié par `grep`) ·
  tests : T01-T05, T10 · sources : [ObjFacB.class:_call](../../../../../.src/Gestion/option/ObjFacB.class#L50-L59), [ObjFacB.class:totht_Read](../../../../../.src/Gestion/option/ObjFacB.class#L577-L581), [ObjFacB.class:clotmat_Read](../../../../../.src/Gestion/option/ObjFacB.class#L609-L613), [ObjFacB.class:21](../../../../../.src/Gestion/option/ObjFacB.class#L21), [ObjFacB.class:397](../../../../../.src/Gestion/option/ObjFacB.class#L397)
- [ ] OBJFACB-003 — [complexité] Découper `calcul` (CC 56) en `ConsignesLignes`,
  `DroitsEdites`, `DroitsNonEdites`, `Deconsignes`, `EcrituresConsignes`, `RecalculTva`, sans
  changer l'ordre ni le texte des requêtes (CC ≤ 12 visé) · appelants : aucun · tests : T01-T07,
  T18 · sources : [ObjFacB.class:calcul](../../../../../.src/Gestion/option/ObjFacB.class#L61-L280)
- [ ] OBJFACB-004 — [commonalisation] Helpers privés `CumulTvaDroit` et `EcritureDroit` pour
  `cassise`/`cdroits` (4 blocs quasi identiques), comportement **identique** (mutation de
  `Me.lignetva` et double `Add` conservés tant que A03 n'est pas validée) · appelants : aucun ·
  tests : T03, T04, T06 · sources : [ObjFacB.class:cassise](../../../../../.src/Gestion/option/ObjFacB.class#L282-L317), [ObjFacB.class:cdroits](../../../../../.src/Gestion/option/ObjFacB.class#L319-L386)
- [ ] OBJFACB-005 — [commonalisation] `TexteCourriel(num)` privé pour le texte dupliqué de
  `editefm`/`mail`, puis lecture via `LitTexteUnique` (prérequis TLEG-003), SQL identique ·
  appelants : aucun · tests : T15, T16 · sources : [ObjFacB.class:662-668](../../../../../.src/Gestion/option/ObjFacB.class#L662-L668), [ObjFacB.class:876-885](../../../../../.src/Gestion/option/ObjFacB.class#L876-L885), [Tleg.class:Form_Open](../../../../../.src/Gestion/Tables/Tleg.class#L35-L42)
- [ ] OBJFACB-006 — [commonalisation] `ImprimeExemplaires(avecPdf, pdfSiJoint)` privé pour les
  trois blocs d'impression de `editefm`, `editef`, `editebl` (variantes paramétrées à
  l'identique) · appelants : aucun · tests : T13-T15 · sources : [ObjFacB.class:677-685](../../../../../.src/Gestion/option/ObjFacB.class#L677-L685), [ObjFacB.class:728-736](../../../../../.src/Gestion/option/ObjFacB.class#L728-L736), [ObjFacB.class:775-780](../../../../../.src/Gestion/option/ObjFacB.class#L775-L780)
- [ ] OBJFACB-007 — [commonalisation] `VerrouilleBl()`/`LibereVerrous()` privés pour les boucles
  `DocActif` de `editefm` (même ordre d'appels) · appelants : aucun · tests : T15 · sources : [ObjFacB.class:editefm](../../../../../.src/Gestion/option/ObjFacB.class#L616-L696)
- [ ] OBJFACB-008 — [complexité] Helper `Fmt2(v)` pour les propriétés `consigne`, `deconsigne`,
  `droit`, `secu`, `ascise` · appelants : `EditfacB` (inchangé) · tests : T03 · sources : [ObjFacB.class:consigne_Read](../../../../../.src/Gestion/option/ObjFacB.class#L547-L551), [ObjFacB.class:ascise_Read](../../../../../.src/Gestion/option/ObjFacB.class#L571-L575)
- [ ] OBJFACB-009 — [réarchitecture] `Cbase.Table` pour les tables qui ont une clé (`TabArt`,
  `TabParam`, `TabComptes`, `TabFam`, `TabTvav`, `TabBl[M]`, `TabLigbl[M]`, `TabHisFac[m]`,
  `TabHisLigFac[m]`, `TabCli`, `TabMat`, `TabSdepots`, `TabHisEntm`), avec correspondance
  explicite pour le suffixe `M`/`m` ; SQL identique · appelants : aucun · tests : T01-T12 ·
  sources : [ObjFacB.class:calcul](../../../../../.src/Gestion/option/ObjFacB.class#L61-L280), [ObjFacB.class:transblfac](../../../../../.src/Gestion/option/ObjFacB.class#L948-L1100), [ObjFacB.class:poid](../../../../../.src/Gestion/option/ObjFacB.class#L525-L539)
- [ ] OBJFACB-010 — [séparation traitement/GUI] `calcul` : contrôle du compte de consignes sans
  `Message.Error` (message dans `calcul`, texte identique) ; `mail` : `ClientsSansCourriel()` et
  `ObjetCourriel(choix, imp)` sans GUI ; `editefm` : `BlEnAttenteMoulinage()` · appelants :
  aucun · tests : T03, T15, T16 · sources : [ObjFacB.class:241-251](../../../../../.src/Gestion/option/ObjFacB.class#L241-L251), [ObjFacB.class:mail](../../../../../.src/Gestion/option/ObjFacB.class#L809-L893), [ObjFacB.class:637-643](../../../../../.src/Gestion/option/ObjFacB.class#L637-L643)
- [ ] OBJFACB-011 — [réarchitecture] Exposer `$borientation` par une propriété en lecture
  (`estBoisson`) et l'utiliser dans `EditfacB._new` au lieu de rappeler `borientation()` (SQL
  modifié : requêtes en moins, dump identique) · appelants : `EditfacB` (même commit, EDITFACB-005)
  · tests : T02, T13, EDITFACB-T01-T04 · sources : [ObjFacB.class:borientation](../../../../../.src/Gestion/option/ObjFacB.class#L388-L412), [EditfacB.class:32](../../../../../.src/Gestion/option/EditfacB.class#L32)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] OBJFACB-A01 — [anomalie] `transblfac`, sorties de dépôt : lit `Me.reslig!typel` et
  `Me.reslig!dtefac`, colonnes inexistantes de `Fiches_Ligbl` (`typel_ligbl`, date de
  `Fiches_Bl`) → erreur d'exécution dès que `cdep` est renseigné (multi-dépôt), transaction non
  validée, archivage interrompu · tests : T12 · sources : [ObjFacB.class:1077](../../../../../.src/Gestion/option/ObjFacB.class#L1077), [ObjFacB.class:1081](../../../../../.src/Gestion/option/ObjFacB.class#L1081)
- [ ] OBJFACB-A02 — [anomalie, à confirmer] `comptmat` ouvre une transaction et sort sans
  `Commit` si `$borientation` est faux : toute facture non boisson éditée par `editef`/`editefm`,
  et toute facture magasin sans alcool (`Moulinage`) ; effet réel selon l'imbrication gb.db et les
  validations implicites MySQL · tests : T08, T09 · sources : [ObjFacB.class:422](../../../../../.src/Gestion/option/ObjFacB.class#L422), [ObjFacB.class:464](../../../../../.src/Gestion/option/ObjFacB.class#L464)
- [ ] OBJFACB-A03 — [anomalie] TVA des droits et de la sécu (`cassise`, `cdroits`) : quand le
  code TVA de la régie est absent de `tva`, l'objet `Me.lignetva` existant est modifié sans
  `New Ltva` (corrompt une autre ligne de TVA), `num` reçoit un compte et `taux` un taux en
  fraction (ou un code TVA pour la sécu) ; droit et sécu non nuls → second `tva.Add` de la même
  clé (erreur) avec les montants du droit ; `calcul` réécrit ensuite `tva[lg.num]` sous une autre
  clé pendant le parcours · tests : T06 · sources : [ObjFacB.class:306-311](../../../../../.src/Gestion/option/ObjFacB.class#L306-L311), [ObjFacB.class:359-364](../../../../../.src/Gestion/option/ObjFacB.class#L359-L364), [ObjFacB.class:377-382](../../../../../.src/Gestion/option/ObjFacB.class#L377-L382), [ObjFacB.class:258](../../../../../.src/Gestion/option/ObjFacB.class#L258)
- [ ] OBJFACB-A04 — [anomalie] `editef`/`editebl` : sorties `Return True` après
  `Application.Busy += 1` sans décrément (curseur occupé) · tests : T14 · sources : [ObjFacB.class:704](../../../../../.src/Gestion/option/ObjFacB.class#L704), [ObjFacB.class:765](../../../../../.src/Gestion/option/ObjFacB.class#L765), [ObjFacB.class:767](../../../../../.src/Gestion/option/ObjFacB.class#L767)
- [ ] OBJFACB-A05 — [anomalie] `editefm` : verrous `DocActif` des clients précédents jamais
  libérés (seuls ceux du dernier client le sont), ni en cas d'erreur (`ProgBar` non fermée l. 641) ;
  `Repeat … Until get_lock` boucle en réaffichant l'avertissement si un autre poste détient le
  verrou · tests : T15 · sources : [ObjFacB.class:641](../../../../../.src/Gestion/option/ObjFacB.class#L641), [ObjFacB.class:645-648](../../../../../.src/Gestion/option/ObjFacB.class#L645-L648), [ObjFacB.class:691-694](../../../../../.src/Gestion/option/ObjFacB.class#L691-L694)
- [ ] OBJFACB-A06 — [anomalie] `editefm` appelle `verifdat` avant tout `calcul` : `$borientation`
  est faux, la clôture des droits (`datebl`) n'est jamais contrôlée en fin de mois ; la branche
  prévue lit d'ailleurs tous les BL de la table `Bl` sans filtre client · tests : T17 · sources : [ObjFacB.class:624](../../../../../.src/Gestion/option/ObjFacB.class#L624), [ObjFacB.class:909-917](../../../../../.src/Gestion/option/ObjFacB.class#L909-L917)
- [ ] OBJFACB-A07 — [anomalie] `mail` : en fin de mois `choix` est remis à `0` (`ch` jamais
  affecté) ; courriel vide → `Message.Error` sans `Return`, l'envoi se poursuit sans adresse ·
  tests : T16 · sources : [ObjFacB.class:850-852](../../../../../.src/Gestion/option/ObjFacB.class#L850-L852), [ObjFacB.class:890](../../../../../.src/Gestion/option/ObjFacB.class#L890)
- [ ] OBJFACB-A08 — [anomalie, à confirmer] `transblfac` : la ligne `TD` (total en lettres,
  `doclet`) produit un `Create9` + `Update` sans aucun champ (clé primaire nulle) ; le contenu
  archivé dépend des options d'édition (lignes `T` absentes si `ligne2`, composants `O` selon
  `art_impdetail`, lignes « Bon n° » si `nblfac`) · tests : T12 · sources : [ObjFacB.class:1003-1011](../../../../../.src/Gestion/option/ObjFacB.class#L1003-L1011)
- [ ] OBJFACB-A09 — [anomalie, à confirmer] Matériels : `Edit` + `Update` ne met à jour que le
  premier matériel du BL portant le même `mat_code` (plusieurs numéros de série d'un même article
  → les suivants gardent le n° de BL) ; rapprochement sur `mat_code` alors que `Facture:8190/8348`
  rapprochent le code de la ligne « Numéro de série » de `mat_serie` (MATERIEL-A11) ;
  `Fiches_HisentMat.numfac` reçoit le n° de BL · tests : T12 · sources : [ObjFacB.class:997](../../../../../.src/Gestion/option/ObjFacB.class#L997), [ObjFacB.class:1062](../../../../../.src/Gestion/option/ObjFacB.class#L1062), [Facture.class:8190](../../../../../.src/Gestion/Facturation/Facture.class#L8190), [Facture.class:8348](../../../../../.src/Gestion/Facturation/Facture.class#L8348), [Materiel.class:1982](../../../../../.src/Gestion/Tables/Materiel.class#L1982)
- [ ] OBJFACB-A10 — [anomalie, à confirmer] Droits d'une facture non éditée calculés sur toute
  ligne qui a un code (composants `O`, MO), alors que les consignes ne le sont que sur les lignes
  `A` ; `comptmat` enregistre de même des lignes de régie pour les composants · tests : T03 ·
  sources : [ObjFacB.class:171](../../../../../.src/Gestion/option/ObjFacB.class#L171), [ObjFacB.class:95](../../../../../.src/Gestion/option/ObjFacB.class#L95), [ObjFacB.class:478-481](../../../../../.src/Gestion/option/ObjFacB.class#L478-L481)
- [ ] OBJFACB-A11 — [anomalie, à confirmer] Cumuls `$stotcons`/`$stotdecons` formatés
  `",0.00"` (séparateur de milliers) puis relus par `Val` : résultat à caractériser au-delà de
  1 000 € ; mélange `Str`/`Val` pour `$stotdr`, `$stotss`, `$stotasc` · tests : T07 · sources : [ObjFacB.class:112](../../../../../.src/Gestion/option/ObjFacB.class#L112), [ObjFacB.class:236](../../../../../.src/Gestion/option/ObjFacB.class#L236), [ObjFacB.class:154](../../../../../.src/Gestion/option/ObjFacB.class#L154)
- [ ] OBJFACB-A12 — [anomalie, à confirmer] Vignette : hors magasin, écrite si `$stotdr <> 0`
  (25 zéros si aucun numéro attribué ; absente pour une bière suspendue cumulée en accises) ; en
  magasin, si un numéro a été attribué · tests : T08, T09 · sources : [ObjFacB.class:454](../../../../../.src/Gestion/option/ObjFacB.class#L454), [ObjFacB.class:502](../../../../../.src/Gestion/option/ObjFacB.class#L502)
- [ ] OBJFACB-A13 — [anomalie, à confirmer] Tables sans suffixe `tab` : `poid` (`Fiches_Ligbl`,
  `Fiches_HistoLigfac`), `datebl` (`Fiches_Ligbl`) : poids et contrôle de dates faux pour les
  documents d'entretien (`M`), comme OBJFAC-A06 · tests : T10, T17 · sources : [ObjFacB.class:532](../../../../../.src/Gestion/option/ObjFacB.class#L532), [ObjFacB.class:534](../../../../../.src/Gestion/option/ObjFacB.class#L534), [ObjFacB.class:934](../../../../../.src/Gestion/option/ObjFacB.class#L934)
- [ ] OBJFACB-A14 — [anomalie] `transblfac` supprime BL, lignes et adresse de livraison après le
  `Commit`, hors transaction : une erreur entre les deux laisse le BL et sa facture archivée ·
  tests : T11 · sources : [ObjFacB.class:1090-1098](../../../../../.src/Gestion/option/ObjFacB.class#L1090-L1098)
- [ ] OBJFACB-A15 — [anomalie, à confirmer] `win_close` rappelle `$sreg.Form_Close()` alors que
  Gambas l'exécute déjà pour le `Close` de `SaiReg` : question « Voulez vous valider la saisie ? »
  posée deux fois · tests : T13, SAIREG-T09 · sources : [ObjFacB.class:win_close](../../../../../.src/Gestion/option/ObjFacB.class#L749-L754)
- [ ] OBJFACB-A16 — [anomalie, à confirmer] Options `P`/`T` : `transblfac` lit
  `numagri_ligbl`/`numadr_ligbl`, jamais écrites ailleurs et créées par `modfichier` avec
  `COLLATE` sur un entier (création possiblement refusée, voir MODFICHIER-A04) → erreur « champ
  inconnu » possible · tests : T12 · sources : [ObjFacB.class:990-992](../../../../../.src/Gestion/option/ObjFacB.class#L990-L992), [modfichier.module:164-167](../../../../../.src/Gestion/option/modfichier.module#L164-L167)
