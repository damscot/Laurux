# Caisse — Rework

> Source : `.src/Caisse/Caisse.class` · Message de commit (phase 4) : `reference/.src/Caisse/Caisse.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 7303 |
| Lignes de commentaire | 397 |
| Fonctions | 242 |
| Fonctions Public | 240 |
| Complexité cyclomatique totale | 2102 |
| Complexité max (fonction) | 77 (`Art_man`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 7303 | 2102 | 77 | 0 | 240 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Fichier legacy à haut risque de régression (AGENTS.md règle 21) : chaque étape est **minimale et
ciblée**, sans réécriture de la saisie (`Art_man`, `Valid_Cart`, `Cart_KeyPress`) ni de
l'enregistrement (`Enrg_Tk`). Les replays CAISSE-T01 à T22 (à valider par l'utilisateur avant la
phase 2, voir test.md) doivent donner un dump identique. Les handlers (`Objet_Evenement`) gardent
leur nom et leur portée `Public`.

- [ ] CAISSE-001 — [documentation] En-tête de classe en français : rôle, cycle d'un ticket
  (`Ent_tk` → saisie → paiement → `Aff_bastk` → impression → `Enrg_Tk` → `Dupli`, bande Z par
  `Moulinage.Livre_caisse`), colonnes 0-12 de `LigTk`, types de ligne (`A`, `S`, `T`, `O`, `C`, `MT`,
  `EZ`, `EA`, `EH`, `SH`, `BL`, `L`, `BH`, `BA`, `BC`, `BB`, `M`, `K`) et codes de règlement de
  `ColumnView1` (`N`, `Q`, `U`, `V`, `W`, `X`, `Y`, `Z`, `E`, `1`, `B`, `RA`), zones de saisie,
  drapeaux implicites ; commentaires `'''` sur `Enrg_Tk`, `Aff_bastk`, `Ajout_Reg_Bl`,
  `Button30_click`, `Valid_Mdp` · appelants : aucun · tests : aucun (commentaires seuls) · sources :
  [Caisse.class:Form_Open](../../../../.src/Caisse/Caisse.class#L197-L325), [Caisse.class:Ent_tk](../../../../.src/Caisse/Caisse.class#L419-L482), [Caisse.class:Aff_bastk](../../../../.src/Caisse/Caisse.class#L5631-L5817), [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226)
- [ ] CAISSE-002 — [documentation] Tableau des raccourcis clavier en tête de `Cart_KeyPress`,
  `Qte_KeyPress`, `Inpm_KeyPress` (F1-F12, Ctrl+F1-F12, Ctrl+M/N/R/T/X, Alt+V) et des codes `org` du
  mot de passe administrateur · appelants : aucun · tests : aucun · sources :
  [Caisse.class:Cart_KeyPress](../../../../.src/Caisse/Caisse.class#L895-L1082), [Caisse.class:Qte_KeyPress](../../../../.src/Caisse/Caisse.class#L1141-L1205), [Caisse.class:Inpm_KeyPress](../../../../.src/Caisse/Caisse.class#L5567-L5593), [Caisse.class:Valid_Mdp](../../../../.src/Caisse/Caisse.class#L5425-L5525)
- [ ] CAISSE-003 — [code mort] Supprimer les fonctions jamais appelées (vérifié par `grep` sur `.src`
  et sur le `.form`) : `Imp_Cheque1` (`unused`), `margeart` (`unused`, `Private`),
  `Button44b_click` et `Button50_Click` (aucun contrôle de ce nom dans `Caisse.form`),
  `Efface_Click` (`handlers_inactifs` : `Efface` est dans le groupe `Clav`, `.form` l. 878 ; son
  traitement est fait par `Numerique`/`Alpha`), `Entree2_Click` (vide, aucun contrôle). `InitBA6X`
  (`unused`) est conservé jusqu'à la décision sur CAISSE-A09 · appelants : aucun · tests : tous les
  replays · sources : [Caisse.class:Imp_Cheque1](../../../../.src/Caisse/Caisse.class#L5118-L5204), [Caisse.class:margeart](../../../../.src/Caisse/Caisse.class#L6886-L6903), [Caisse.class:Button44b_click](../../../../.src/Caisse/Caisse.class#L7923-L7934), [Caisse.class:Button50_Click](../../../../.src/Caisse/Caisse.class#L7953-L7957), [Caisse.class:Efface_Click](../../../../.src/Caisse/Caisse.class#L8011-L8116), [Caisse.class:Entree2_Click](../../../../.src/Caisse/Caisse.class#L8476-L8478)
- [ ] CAISSE-004 — [code mort] Supprimer le code mort interne : 3e boucle d'`Enrg_Tk` (recalcule
  `smontant`/`smontantht`/`smrem` sans jamais les écrire), branche `org = "Credit"` de `Valid_Mdp`
  (jamais affecté), `Case "Espece2"` d'`Echap_Click` (la zone s'appelle `Especes2`), variables
  locales inutilisées (`Materiel`, `pmp` d'`Art_man` ; `rJnl`, `CptCaisse` de `Maj_Acomptes` ;
  `Tiketx`, `MntFam`, `QteFam`, `Totp`/`Totg` locaux redondants d'`Enrg_Tk` à vérifier ; `Lignes`
  d'`imp_ligtk`) et blocs commentés · appelants : aucun · tests : T01, T04, T15, T17 · sources :
  [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226), [Caisse.class:Valid_Mdp](../../../../.src/Caisse/Caisse.class#L5425-L5525), [Caisse.class:Echap_Click](../../../../.src/Caisse/Caisse.class#L8492-L8649), [Caisse.class:Art_man](../../../../.src/Caisse/Caisse.class#L527-L819), [Caisse.class:Maj_Acomptes](../../../../.src/Caisse/Caisse.class#L4573-L4587)
- [ ] CAISSE-005 — [commonalisation] Promotion du jour de `Form_Open` (l. 218) remplacée par
  `ArtPromo.PromoDuJour()` (même requête, même règle « première ligne ») · appelants : aucun ·
  prérequis : ARTPROMO-004 · tests : T20 · sources : [Caisse.class:218](../../../../.src/Caisse/Caisse.class#L218), [ArtPromo.module:art_Promo](../../../../.src/Gestion/Tables/ArtPromo.module#L5-L14)
- [ ] CAISSE-006 — [commonalisation] `arrondi` remplacé par la fonction commune d'arrondi au pas
  retenue en phase 3 (ARTICLES-011 `ArrondiPvTTC` / FACTURE-008 `ArrondiPas`), **seulement si** la
  comparaison cas par cas (pas `0,05`, `0,10`, `0,50`, `1,00`, montants négatifs, derniers chiffres
  0-9) donne des résultats identiques ; sinon `arrondi` reste locale · appelants : aucun · tests :
  T02, T23 · sources : [Caisse.class:arrondi](../../../../.src/Caisse/Caisse.class#L487-L522), [Facture.class:arrondi](../../../../.src/Gestion/Facturation/Facture.class#L7621-L7662)
- [ ] CAISSE-007 — [commonalisation] Tables nommées en dur → `Cbase.Table` : `"Fiches_EntTicketz"`
  (`TabEntTck`), `"Fiches_LigTicketz"` (`TabLigTck`), `"Fiches_Caisses"` (`TabCaisses`, `Enrg_Tk`),
  `"Fiches_Cli"` (`TabCli`, `entremail`), `"Fiches_LibelAvoirs"` (`TabLibelAvoirs`, `Form_Open`),
  `"Fiches_StkDepots"` (`TabStkDepots`, `Maj_QteDep`) — même nom physique (pour `Fiches_LibelAvoirs`, voir aussi le socle « texte unique » TLEG-003), **sans changement SQL** ·
  appelants : aucun · tests : T01, T09, T13, T14, T16 · sources : [Caisse.class:Button8_Click](../../../../.src/Caisse/Caisse.class#L2241-L2276), [Caisse.class:ColTka_Click](../../../../.src/Caisse/Caisse.class#L2288-L2396), [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226), [Caisse.class:Valid_Nticket](../../../../.src/Caisse/Caisse.class#L6346-L6406), [Caisse.class:Serial_Facture](../../../../.src/Caisse/Caisse.class#L6564-L6637), [Caisse.class:Defaut_Facture](../../../../.src/Caisse/Caisse.class#L6639-L6769), [Caisse.class:entremail](../../../../.src/Caisse/Caisse.class#L4643-L4711), [Caisse.class:Maj_QteDep](../../../../.src/Caisse/Caisse.class#L7436-L7475)
- [ ] CAISSE-008 — [complexité] Les dix `*_KeyPress` des modes de paiement (`Especes`, `carte`,
  `Cheque`, `credit`, `Bachat`, `Bavoir`, `Chequecad`, `Bautre`, `Tresto`, `Bonus`, `Bacompte`) et
  `Inpm_KeyPress` délèguent l'aiguillage F1-F12 à un helper privé `ToucheModePaiement(iCode,
  sExclus)` qui reproduit **exactement** les touches actuelles de chaque handler (trous compris :
  F12 absent de `Bachat`, `Bavoir`, `Chequecad` ; F7 de `Inpm`) ; les handlers gardent leur nom et
  leur `Catch` (CC ≈ 22 → ≤ 6 chacun) · appelants : aucun · tests : T04, T05, T06, T07 · sources :
  [Caisse.class:Especes_KeyPress](../../../../.src/Caisse/Caisse.class#L2658-L2686), [Caisse.class:carte_KeyPress](../../../../.src/Caisse/Caisse.class#L2897-L2925), [Caisse.class:Cheque_KeyPress](../../../../.src/Caisse/Caisse.class#L3020-L3048), [Caisse.class:credit_KeyPress](../../../../.src/Caisse/Caisse.class#L3133-L3161), [Caisse.class:Bachat_KeyPress](../../../../.src/Caisse/Caisse.class#L3249-L3277), [Caisse.class:Bavoir_KeyPress](../../../../.src/Caisse/Caisse.class#L3423-L3451), [Caisse.class:Chequecad_KeyPress](../../../../.src/Caisse/Caisse.class#L3570-L3599), [Caisse.class:Bautre_KeyPress](../../../../.src/Caisse/Caisse.class#L3676-L3704), [Caisse.class:Tresto_KeyPress](../../../../.src/Caisse/Caisse.class#L3782-L3810), [Caisse.class:Bonus_KeyPress](../../../../.src/Caisse/Caisse.class#L3897-L3925), [Caisse.class:Bacompte_KeyPress](../../../../.src/Caisse/Caisse.class#L4204-L4232), [Caisse.class:Inpm_KeyPress](../../../../.src/Caisse/Caisse.class#L5567-L5593)
- [ ] CAISSE-009 — [complexité] Fin commune des validations de règlement : helper privé
  `SoldeAtteint(bQuestionRendu, bBasDeTicket)` (question « rendre la monnaie » → tiroir + `pointsF`
  + focus `Button15`, ou `ColumnView1_Delete(False)`, ou retour à `Inpm`) appelé par
  `Valid_Especes`, `Valid_Carte`, `Valid_Cheque`, `Valid_Credit`, `Valid_Bachat`, `Valid_Chequecad`,
  `Valid_Bautre`, `Valid_Tresto`, `Valid_Bonus`, `Valid_Bavoir`, `Valid_Bacompte` (variantes
  actuelles conservées, y compris l'erreur de CAISSE-A11) · appelants : aucun · tests : T04, T05,
  T06, T07, T12 · sources : [Caisse.class:Valid_Credit](../../../../.src/Caisse/Caisse.class#L3163-L3226), [Caisse.class:Valid_Bachat](../../../../.src/Caisse/Caisse.class#L3279-L3339), [Caisse.class:Valid_Bautre](../../../../.src/Caisse/Caisse.class#L3706-L3766), [Caisse.class:Valid_Tresto](../../../../.src/Caisse/Caisse.class#L3812-L3872), [Caisse.class:Valid_Bonus](../../../../.src/Caisse/Caisse.class#L3927-L3991), [Caisse.class:Valid_Bavoir](../../../../.src/Caisse/Caisse.class#L3453-L3529), [Caisse.class:Valid_Bacompte](../../../../.src/Caisse/Caisse.class#L4234-L4308)
- [ ] CAISSE-010 — [complexité] Helpers privés pour les copies internes : `ChangeVendeur()` (deux
  copies dans `Cart_KeyPress`), `ChargeTranches(Rarts)` (18 `Try Rms…` d'`Art_man` et de
  `Valid_Cart`, échecs actuels conservés tant que CAISSE-A02 n'est pas validée), boucle sur les 18
  `Try Tbrem…` de `RemqShow`, `EnteteSociete() As String` (`Ent_tk`, `Ent_tk2`, `Valid_Nticket`,
  `impressionbon`, sans changer le texte), `FermeSaisieClientDivers()` (`Nmc4/5/6_KeyPress`),
  `Son()` (≈ 105 « `If Start.son Then Music.Play` », souvent imbriqués deux fois) ; regroupement des
  11 branches identiques d'`Echap_Click` en un seul `Case` · appelants : aucun · tests : T01, T03,
  T14, T17, T22 · sources : [Caisse.class:Cart_KeyPress](../../../../.src/Caisse/Caisse.class#L895-L1082), [Caisse.class:Art_man](../../../../.src/Caisse/Caisse.class#L527-L819), [Caisse.class:Valid_Cart](../../../../.src/Caisse/Caisse.class#L1320-L1485), [Caisse.class:RemqShow](../../../../.src/Caisse/Caisse.class#L1559-L1589), [Caisse.class:Ent_tk2](../../../../.src/Caisse/Caisse.class#L6545-L6562), [Caisse.class:impressionbon](../../../../.src/Caisse/Caisse.class#L6408-L6443), [Caisse.class:Nmc4_KeyPress](../../../../.src/Caisse/Caisse.class#L6455-L6472), [Caisse.class:Echap_Click](../../../../.src/Caisse/Caisse.class#L8492-L8649)
- [ ] CAISSE-011 — [complexité] `Cart_KeyPress` : remplacer la cascade de huit `Else If` des touches
  sans Ctrl (F2-F12) par un `Select Case Key.Code` dans le même ordre, et `Clav_click`/`Efface`
  /`Button43_Click` par un `Select Case Zone` (doublon `Especes` supprimé) — même comportement ·
  appelants : aucun · tests : T01, T17 · sources : [Caisse.class:Cart_KeyPress](../../../../.src/Caisse/Caisse.class#L895-L1082), [Caisse.class:Clav_click](../../../../.src/Caisse/Caisse.class#L8118-L8246), [Caisse.class:Button43_Click](../../../../.src/Caisse/Caisse.class#L7880-L7921)
- [ ] CAISSE-012 — [complexité] Itérateur privé de bloc partagé par `Aff_bastk` et `Recalc_Tottk`
  (parcours « ligne `A` puis lignes du même bloc », message « Unsupported line » conservé) ; aucun
  changement des cumuls ni de la table `Tottva` · appelants : aucun · tests : T02, T03, T11 ·
  sources : [Caisse.class:Aff_bastk](../../../../.src/Caisse/Caisse.class#L5631-L5817), [Caisse.class:Recalc_Tottk](../../../../.src/Caisse/Caisse.class#L7631-L7710)
- [ ] CAISSE-013 — [séparation traitement/GUI] `Enrg_Tk` : extraire sans accès aux contrôles
  `ConsommeAvoir(sLind, sMontant) As Boolean`, `ConsommeAcompte(sLind, sMontant) As Boolean`,
  `EnregistreLigneTicket(…)`, `EnregistreEnteteTicket(…)`, `MajTotauxCaisse(sCaisse, fTtc,
  fAcomptes)` et la conversion pure `ConvertitPoints(fPoints, fSeuil, fBonus, fGain)` ; mêmes
  requêtes dans le même ordre (**sans changement SQL**) · appelants : aucun · tests : T01, T04, T05,
  T06, T09, T10, T12, T23 · sources : [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226)
- [ ] CAISSE-014 — [séparation traitement/GUI] Stock et encours : `MouvementStockArticle(sCode,
  fQte, bAvoir)` extrait de `Maj_Quantite` (même SQL, même verrou), `EncoursClient(sCode) As Float`
  extrait de `Recup_Client` (solde comptable + BL non facturés) · appelants : aucun · tests : T01,
  T05, T10, T18 · sources : [Caisse.class:Maj_Quantite](../../../../.src/Caisse/Caisse.class#L7388-L7429), [Caisse.class:Recup_Client](../../../../.src/Caisse/Caisse.class#L7186-L7243)
- [ ] CAISSE-015 — [séparation traitement/GUI] Formatage pur des lignes imprimées
  `FormateLigneTicket(sLibelle, sMontant, sQte, iLargeur) As String` (`imp_ligtk` 23 colonnes,
  `imp_ligtk2` 21 colonnes, mêmes troncatures) et lecture SQL `LitTva(sCode) As String[]` pour
  `Calc_Tva` (affectations de `Tva`/`TxTva` inchangées) · appelants : aucun · tests : T23, T25 ·
  sources : [Caisse.class:imp_ligtk](../../../../.src/Caisse/Caisse.class#L4938-L4990), [Caisse.class:imp_ligtk2](../../../../.src/Caisse/Caisse.class#L4992-L5035), [Caisse.class:Calc_Tva](../../../../.src/Caisse/Caisse.class#L1921-L1933)
- [ ] CAISSE-016 — [réduction de portée] Passer en `Private` les fonctions non-handlers sans
  appelant externe (liste d'architecture.md, « Réduction de portée ») et le membre `Clicode`, si la
  couverture par replay est confirmée (PLAN §6). Restent `Public` : handlers, `ColTka_Click`,
  `Cavoirs_Click`, `Cacomptes_Click` (rejeu), `SPort2_Read`, `Bsel`, `Bval`, `$Vendeur`, `Ba4`,
  `origine`, `Codearticle` · appelants : aucun · tests : tous les replays · sources :
  [Caisse.class:Art_man](../../../../.src/Caisse/Caisse.class#L527-L819), [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226), [Caisse.class:Aff_bastk](../../../../.src/Caisse/Caisse.class#L5631-L5817), [Caisse.class:horsven_evkeypress](../../../../.src/Caisse/Caisse.class#L4386-L4399), [Caisse.class:Maj_Quantite](../../../../.src/Caisse/Caisse.class#L7388-L7429)

- [ ] CAISSE-017 — [commonalisation] Numéro de carte suivant d'`Enrg_Clientd` (dernier code + 1 sur
  `Fiches_Carte`, format `000000`) → helper partagé `ProchainCodeCarte()` avec
  `FClientcarte.Button2_Click` ; lecture d'une carte (`RecupClientd`, `RecupCarte`) à rapprocher
  de `Tricartes`/`FClientcarte` · appelants : aucun · tests : T12, T14 · sources :
  [Caisse.class:Enrg_Clientd](../../../../.src/Caisse/Caisse.class#L7298-L7318), [Caisse.class:RecupClientd](../../../../.src/Caisse/Caisse.class#L7276-L7296), [Caisse.class:RecupCarte](../../../../.src/Caisse/Caisse.class#L7354-L7382)
- [ ] CAISSE-018 — [commonalisation] `Numerique`/`Alpha` (construction de `$saisie` depuis
  `Last.name`) dupliquent `Clavier.Numerique`/`Alpha` : fonction pure commune `ToucheVirtuelle`
  (CLAVIER-005/006), appelée avec `Last.name`, `Zone` et `$saisie` · appelants : `Clavier` (même
  commit) · tests : T17, T23 · sources : [Caisse.class:Numerique](../../../../.src/Caisse/Caisse.class#L8248-L8262), [Caisse.class:Alpha](../../../../.src/Caisse/Caisse.class#L8264-L8294)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CAISSE-A01 — [anomalie] `Imp_Cheque` appelle `numtostring.nbtostring`, absente du module
  compilé : `Utils/Numtostring.module` et `Caisse/numtostring.module` sont homonymes à la casse près
  et seul le premier est compilé (`.gambas/NUMTOSTRING` : `Convertir`, `Num2Text`, vérifié) →
  impression des chèques en caisse en erreur. Correction : `Numtostring.Convertir` (ou renommer le
  module Caisse) ; à coordonner avec la doc de `Utils/Numtostring` · tests : T04 · sources :
  [Caisse.class:Imp_Cheque](../../../../.src/Caisse/Caisse.class#L5037-L5116), [Caisse.class:5064](../../../../.src/Caisse/Caisse.class#L5064), [Caisse.class:5069](../../../../.src/Caisse/Caisse.class#L5069)
- [ ] CAISSE-A02 — [anomalie] `Rms As New String[]` (une dimension) utilisé en `Rms[i, j]` : les
  affectations échouent dans des `Try`, `Rms.Bounds[0]` vaut 0 (vérifié avec `gbs3`) → les remises
  quantitatives ne sont jamais appliquées ni affichées en caisse. Correction : `New String[6, 3]`
  (comme `Facture`) · tests : T03 · sources : [Caisse.class:70](../../../../.src/Caisse/Caisse.class#L70), [Caisse.class:Remises_quantitatives](../../../../.src/Caisse/Caisse.class#L1702-L1720), [Caisse.class:RemqShow](../../../../.src/Caisse/Caisse.class#L1559-L1589)
- [ ] CAISSE-A03 — [anomalie, critique] `Maj_QteDep` lit `rStk!art_qte` dans `Fiches_StkDepots`, qui
  n'a que `coded`, `codea`, `qte` → erreur non interceptée après l'impression, ticket non
  enregistré, `LOCK TABLES` non relâché, pour toute caisse rattachée à un dépôt (à confirmer en
  replay) · tests : T18 · sources : [Caisse.class:Maj_QteDep](../../../../.src/Caisse/Caisse.class#L7436-L7475), [Caisse.class:7452](../../../../.src/Caisse/Caisse.class#L7452)
- [ ] CAISSE-A04 — [anomalie] `Svendeur` écrit `Caisse.$Vendeur` sur l'**auto-instance** alors que la
  caisse est ouverte par `New Caisse` (`Cmenu.class:253`) : `$Vendeur` lu par `Cart_KeyPress` reste
  faux, le changement de vendeur (Ctrl+X, Alt+V) n'est jamais appliqué. Correction : retour par
  `Start.$Cai` seul ou `Object.SetProperty` sur l'appelant · tests : T22 · sources :
  [Caisse.class:Cart_KeyPress](../../../../.src/Caisse/Caisse.class#L895-L1082), [Svendeur.class:Button2_Click](../../../../.src/Caisse/Svendeur.class#L42-L52)
- [ ] CAISSE-A05 — [anomalie, à confirmer] `Cfacture` lit `Caisse.Ba4` sur l'auto-instance (toujours
  faux, et instanciation d'un second formulaire caché) : la mise en page A4 des tickets et
  facturettes PDF utilise les positions 80 mm ; `Ba4` est positionné dans `Defaut_Tk` et `Defaut_Facture` · lien : CFACTURE-A01 · tests : T14, T16 · sources : [Caisse.class:Defaut_Tk](../../../../.src/Caisse/Caisse.class#L5206-L5308), [Caisse.class:Defaut_Facture](../../../../.src/Caisse/Caisse.class#L6639-L6769), [Cfacture.class:121](../../../../.src/Caisse/Reports/Cfacture.class#L121)
- [ ] CAISSE-A06 — [anomalie] `button29_Click` passe `Caisse.Codearticle` (auto-instance, toujours
  vide) à `Enrg_Clientd` → chaque facturette avec `/caisse/histocli` crée un nouveau client divers ;
  `Enrg_Clientd` passe des objets `LDate(Now)` comme paramètres SQL (erreur probable, à confirmer)
  · tests : T14 · sources : [Caisse.class:6522](../../../../.src/Caisse/Caisse.class#L6522), [Caisse.class:Enrg_Clientd](../../../../.src/Caisse/Caisse.class#L7298-L7318)
- [ ] CAISSE-A07 — [anomalie] `ClientsDivers` (Ctrl+N, F2 de la facturette) ouvre
  `New Tricartes(-1)` sans objet de retour : `Bsel` n'est jamais écrit, `RecupClientd` jamais appelé
  (et recevrait `Codearticle` au lieu de `Bval`) → la recherche de client divers est sans effet ·
  lien : TRICARTES-A01 · tests : T14 · sources : [Caisse.class:ClientsDivers](../../../../.src/Caisse/Caisse.class#L7249-L7271), [Caisse.class:7259](../../../../.src/Caisse/Caisse.class#L7259), [Tricartes.class:_new](../../../../.src/Caisse/Affichages/Tricartes.class#L13-L38)
- [ ] CAISSE-A08 — [anomalie] `Cacomptes_Click` : si le reste à payer est ≤ 0, la liste est vidée
  puis le code continue et lit `Cacomptes.Item[…]` (erreur probable) · tests : T06 · sources :
  [Caisse.class:Cacomptes_Click](../../../../.src/Caisse/Caisse.class#L4310-L4343)
- [ ] CAISSE-A09 — [anomalie] Afficheur USB BA63 : `InitBA6X` n'est jamais appelée, `BA6X` reste
  `Null` ; avec `/caisse/affusbwn`, chaque `Aff_viseur` appelle `PrintBA6X` sur un objet nul et
  `Form_Close` fait `Close #BA6X` (erreurs). Correction : appeler `InitBA6X` dans `Form_Open` (adresse
  et port à paramétrer) ou supprimer la fonctionnalité · tests : T25 · sources :
  [Caisse.class:InitBA6X](../../../../.src/Caisse/Caisse.class#L169-L183), [Caisse.class:PrintBA6X](../../../../.src/Caisse/Caisse.class#L185-L195), [Caisse.class:Aff_viseur](../../../../.src/Caisse/Caisse.class#L839-L853), [Caisse.class:Form_Close](../../../../.src/Caisse/Caisse.class#L401-L417)
- [ ] CAISSE-A10 — [anomalie] Libellé « Prix total » : `Valid_Remtot` et `imp_ligtk` testent
  `Space$(15) & "Prix total "` alors qu'`Art_man` écrit `Space$(3) & "\tPrix total"` → les lignes `T`
  ne sont pas remisées par la remise sur total (montant `Fiches_LigTicketz` non réduit) et leur
  formatage d'impression spécifique n'est jamais utilisé · tests : T03 · sources :
  [Caisse.class:Valid_Remtot](../../../../.src/Caisse/Caisse.class#L2017-L2142), [Caisse.class:imp_ligtk](../../../../.src/Caisse/Caisse.class#L4938-L4990), [Caisse.class:Art_man](../../../../.src/Caisse/Caisse.class#L527-L819)
- [ ] CAISSE-A11 — [anomalie] `Valid_Bautre` l. 3734 : copier-coller, modifie `Chequecad.Text` au lieu
  de `Bautre.Text` lors du cumul d'un second « autre règlement » négatif · tests : T04 · sources :
  [Caisse.class:3734](../../../../.src/Caisse/Caisse.class#L3734)
- [ ] CAISSE-A12 — [anomalie, à confirmer] `cacomptes_keyPress` (Entrée sur la liste des acomptes)
  ne renseigne ni `lindacompte`, ni `numacompte`, ni `cliacompte` (contrairement à
  `Cacomptes_Click`) → « Acompte introuvable » ou consommation de l'acompte précédemment choisi ·
  tests : T06 · sources : [Caisse.class:cacomptes_keyPress](../../../../.src/Caisse/Caisse.class#L4185-L4202), [Caisse.class:Cacomptes_Click](../../../../.src/Caisse/Caisse.class#L4310-L4343)
- [ ] CAISSE-A13 — [anomalie] Mot de passe administrateur : `org = "EF3"` (hors vente) ouvre `Frame2`
  au lieu de `Frame5` ; `org = "EF12"` (dépassement d'encours dans `Recup_Client`) n'est pas traité
  par `Valid_Mdp` et `Recup_Client` continue → le bon de caisse est accepté sans mot de passe ·
  tests : T08, T10, T15 · sources : [Caisse.class:Valid_Mdp](../../../../.src/Caisse/Caisse.class#L5425-L5525), [Caisse.class:Recup_Client](../../../../.src/Caisse/Caisse.class#L7186-L7243)
- [ ] CAISSE-A14 — [anomalie] `Button30_click` : avec un avoir en cours, le message d'erreur n'est
  pas suivi d'un `Return` → la sélection de bon de caisse ou de BL continue · tests : T10 ·
  sources : [Caisse.class:Button30_click](../../../../.src/Caisse/Caisse.class#L7122-L7181)
- [ ] CAISSE-A15 — [anomalie] `Ticketz` sur imprimante série : `Defaut_Ticketxz(…, False)` produit un
  ticket X (pas de validation du livre de caisse) mais `Fiches_Caisses.tkz = 1` est écrit comme si la
  bande Z était faite · tests : T13 · sources : [Caisse.class:Ticketz](../../../../.src/Caisse/Caisse.class#L6819-L6880)
- [ ] CAISSE-A16 — [anomalie] Archives PDF : `Dupli` est appelée après `Serial_Tk` et `suppr_Tk`
  sans PDF produit → copie le `~/Ticket.pdf` du ticket précédent sous le nouveau numéro ; `DupliZ`
  crée le répertoire `ChmZ` absent mais ne copie pas la bande Z, et son message contient le texte
  littéral `& Chemin'` ; chemins non protégés dans `Shell` · tests : T13, T16 · sources :
  [Caisse.class:Dupli](../../../../.src/Caisse/Caisse.class#L6950-L6963), [Caisse.class:DupliZ](../../../../.src/Caisse/Caisse.class#L6925-L6948), [Caisse.class:Serial_Tk](../../../../.src/Caisse/Caisse.class#L4895-L4936), [Caisse.class:suppr_Tk](../../../../.src/Caisse/Caisse.class#L2420-L2475)
- [ ] CAISSE-A17 — [anomalie] `TabTva` recrée à chaque bas de ticket la table **partagée** `Tottva`
  (`DROP`/`CREATE`, non temporaire) : deux caisses simultanées mélangent leurs TVA ; la clause
  `ENGINE = MYISAM` n'est pas traduite pour SQLite (erreur probable). Correction : cumul en
  `Collection` (SQL modifié, dump identique hors table de travail) · tests : T03, T21 · sources :
  [Caisse.class:TabTva](../../../../.src/Caisse/Caisse.class#L5615-L5625), [Caisse.class:Aff_bastk](../../../../.src/Caisse/Caisse.class#L5631-L5817)
- [ ] CAISSE-A18 — [anomalie, à confirmer l'impact] `Enrg_Tk` : `smtva` prend la valeur de la
  **dernière** ligne `BA` → `Fiches_EntTicketz.mtva` faux dès que le ticket comporte plusieurs taux
  de TVA (les lignes restent justes) · tests : T02, T03 · sources : [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226)
- [ ] CAISSE-A19 — [anomalie] `Delete_Reglements_Tk` : `Left(…, 2) = "E"` n'est jamais vrai (lignes
  « autre règlement » `E` conservées lors du recalcul du bas de ticket) et la 1re ligne n'est jamais
  examinée ; `ColumnView1_Delete` : même parcours, le verrou `DocActif` du premier règlement `RA`/`Z`
  n'est pas libéré (à confirmer) · tests : T04, T05, T06 · sources :
  [Caisse.class:Delete_Reglements_Tk](../../../../.src/Caisse/Caisse.class#L7525-L7553), [Caisse.class:ColumnView1_Delete](../../../../.src/Caisse/Caisse.class#L7572-L7608)
- [ ] CAISSE-A20 — [anomalie, à confirmer] `init_paiement` remet `iavoir` (même variable que
  `iAvoir`) à 0 : un ticket d'avoir dont le total n'est pas positif passe par un mode de paiement et
  perd son statut d'avoir (pas d'`INSERT` dans `Fiches_Avoirs`, sens du stock inversé) · tests : T05
  · sources : [Caisse.class:init_paiement](../../../../.src/Caisse/Caisse.class#L5530-L5562), [Caisse.class:Button6_Click](../../../../.src/Caisse/Caisse.class#L2145-L2188)
- [ ] CAISSE-A21 — [anomalie] `Maj_Acomptes` date l'acompte avec `LDate.DT` de l'**auto-instance**
  (date de première utilisation de `LDate` dans la session) au lieu de l'instant présent · tests :
  T06 · sources : [Caisse.class:Maj_Acomptes](../../../../.src/Caisse/Caisse.class#L4573-L4587)
- [ ] CAISSE-A22 — [anomalie, à confirmer] `Button15_Click`/`Button37_Click` appellent `Defaut_Tk`
  pour un avoir ou un bon de caisse quelle que soit l'imprimante : sur imprimante série, `pdf` n'est
  jamais créé (erreur sur objet nul) · tests : T16 · sources : [Caisse.class:Button15_Click](../../../../.src/Caisse/Caisse.class#L4754-L4795), [Caisse.class:Button37_Click](../../../../.src/Caisse/Caisse.class#L4797-L4826), [Caisse.class:Defaut_Tk](../../../../.src/Caisse/Caisse.class#L5206-L5308)
- [ ] CAISSE-A23 — [anomalie] `impressionbon("")` (Esc/F12 dans les coordonnées de facturette)
  appelle toujours `Serial_Facture`, même sur imprimante PDF (port série non ouvert → message
  d'erreur) · tests : T14 · sources : [Caisse.class:impressionbon](../../../../.src/Caisse/Caisse.class#L6408-L6443)
- [ ] CAISSE-A24 — [anomalie] `Init_Art` : refus de supprimer la remise sur total → `Return True`
  sans ajouter la ligne ; `Valid_Qte`/`Valid_Cart` cumulent quand même `calc_total` (`Totalht`
  faux, enregistré pour un ticket mis en attente) · tests : T03 · sources : [Caisse.class:Init_Art](../../../../.src/Caisse/Caisse.class#L1591-L1614), [Caisse.class:Valid_Qte](../../../../.src/Caisse/Caisse.class#L1207-L1238)
- [ ] CAISSE-A25 — [anomalie] `Init_sport` : échec d'ouverture du port imprimante → `Quit`
  (fermeture immédiate de toute l'application, sans libérer `cutk` ni le verrou de caisse) ·
  tests : T25 · sources : [Caisse.class:Init_sport](../../../../.src/Caisse/Caisse.class#L5311-L5333)
- [ ] CAISSE-A26 — [anomalie] Lectures de `Result` sans `Available` (erreur au lieu d'un message) :
  client caisse, société et vendeur (`Form_Open`), vendeur (`Cart_KeyPress`), ticket rappelé
  (`ColTka_Click`), client en compte (`Recup_Client`, `Defaut_Tk`, `Valid_Nticket`), caisse et
  famille (`Enrg_Tk`) · tests : T09, T10, T14 · sources : [Caisse.class:Form_Open](../../../../.src/Caisse/Caisse.class#L197-L325), [Caisse.class:ColTka_Click](../../../../.src/Caisse/Caisse.class#L2288-L2396), [Caisse.class:Recup_Client](../../../../.src/Caisse/Caisse.class#L7186-L7243), [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226)
- [ ] CAISSE-A27 — [anomalie] `Btn_Valid_HorsEnc_KeyPress` valide le mouvement hors vente sur
  **n'importe quelle** touche (Tab, Esc…) · tests : T08 · sources :
  [Caisse.class:Btn_Valid_HorsEnc_KeyPress](../../../../.src/Caisse/Caisse.class#L4521-L4525)
- [ ] CAISSE-A28 — [anomalie, à confirmer] `Calc_Tva` remplace le code TVA par le taux dans `Tva` ;
  les appels suivants (`calc_HT` après `Calc_TTC` ou `Calc_Tva` dans `Art_man`) cherchent
  `code_tva = <taux>` : sans effet tant qu'aucun code TVA n'égale un taux · tests : T02, T19 ·
  sources : [Caisse.class:Calc_Tva](../../../../.src/Caisse/Caisse.class#L1921-L1933), [Caisse.class:calc_HT](../../../../.src/Caisse/Caisse.class#L1935-L1942), [Caisse.class:Art_man](../../../../.src/Caisse/Caisse.class#L527-L819)
- [ ] CAISSE-A29 — [anomalie] Ordre et atomicité de la validation : le stock est mouvementé
  (`Maj_Quantite`) avant `Enrg_Tk`, qui peut abandonner (ticket déjà présent dans la ticketz) en
  vidant l'écran sans rien enregistrer ; aucune transaction autour des ~20 écritures d'`Enrg_Tk` ·
  tests : T01, T09 · sources : [Caisse.class:Serial_Tk](../../../../.src/Caisse/Caisse.class#L4895-L4936), [Caisse.class:Defaut_Tk](../../../../.src/Caisse/Caisse.class#L5206-L5308), [Caisse.class:Enrg_Tk](../../../../.src/Caisse/Caisse.class#L5822-L6226)
- [ ] CAISSE-A30 — [anomalie] `Recalc_Tottk` ignore les lignes `EH`/`SH` : après une suppression de
  ligne ou une remise sur total, le total du ticket perd les entrées/sorties hors vente · tests :
  T08 · sources : [Caisse.class:Recalc_Tottk](../../../../.src/Caisse/Caisse.class#L7631-L7710), [Caisse.class:Ligtk_Delete](../../../../.src/Caisse/Caisse.class#L7714-L7782)
- [ ] CAISSE-A31 — [anomalie] `Defaut_Tk` n'a pas de `Catch` : un logo absent ou invalide
  (`Cfacture.Logo2`) interrompt l'impression **après** le paiement, sans mouvement de stock ni
  enregistrement du ticket · lien : CFACTURE-A03 · tests : T16 · sources : [Caisse.class:Defaut_Tk](../../../../.src/Caisse/Caisse.class#L5206-L5308)
