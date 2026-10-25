# FClientcarte — Rework

> Source : `.src/Caisse/FClientcarte.class` · Message de commit (phase 4) : `reference/.src/Caisse/FClientcarte.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 863 |
| Lignes de commentaire | 47 |
| Fonctions | 65 |
| Fonctions Public | 65 |
| Complexité cyclomatique totale | 216 |
| Complexité max (fonction) | 28 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 863 | 216 | 28 | 0 | 65 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCLIENTCARTE-001 — [documentation] En-tête de classe corrigé (le fichier se présente comme
  « Fclient.class / table des clients ») : rôle (cartes de fidélité `Fiches_Carte`), points d'entrée
  (Fmenu, Tricartes F4), groupes `Btn`/`Cmpt` et signification des tags, commentaires `'''` sur les
  méthodes · appelants : aucun · tests : T01-T09 · sources : [FClientcarte.class:_New](../../../../.src/Caisse/FClientcarte.class#L43-L65), [FClientcarte.class:Btn_Click](../../../../.src/Caisse/FClientcarte.class#L545-L566), [FClientcarte.class:Cmpt_KeyPress](../../../../.src/Caisse/FClientcarte.class#L260-L385)
- [ ] FCLIENTCARTE-002 — [code mort] Supprimer les handlers inactifs `Cb_GotFocus`/`Cb_LostFocus`
  (`CB` est dans le groupe `Cmpt`, logique déjà dans `Cmpt_LostFocus`), les fonctions jamais
  appelées `Ref`, `aff_cp`, `ChkCp`, les variables écrites mais jamais lues `n`, `Enr`, `CoulZnaf`,
  `CoulFc`, `Chkfocus` (et les lectures `Utils.FColr` associées de `_New`), `Tab`/`Suppr` de
  `Button3_Click` · appelants : aucun · tests : T01-T06 · sources : [FClientcarte.class:Cb_GotFocus](../../../../.src/Caisse/FClientcarte.class#L474-L478), [FClientcarte.class:Cb_LostFocus](../../../../.src/Caisse/FClientcarte.class#L480-L494), [FClientcarte.class:Ref](../../../../.src/Caisse/FClientcarte.class#L840-L847), [FClientcarte.class:aff_cp](../../../../.src/Caisse/FClientcarte.class#L935-L962), [FClientcarte.class:ChkCp](../../../../.src/Caisse/FClientcarte.class#L1001-L1009), [FClientcarte.class:_New](../../../../.src/Caisse/FClientcarte.class#L43-L65), [FClientcarte.class:625](../../../../.src/Caisse/FClientcarte.class#L625)
- [ ] FCLIENTCARTE-003 — [code mort] `Colcp_Click`/`Colcp_KeyPress` : `Colcp` est invisible dans le
  `.form` et seul `aff_cp` (mort) l'affichait ; handlers inatteignables. À supprimer **dans le même
  commit** que FCLIENTCARTE-002 si l'utilisateur confirme (le contrôle reste dans le `.form`) ;
  sinon `Colcp_Click` reste `Public` (rejeu `Object.Call`) · appelants : aucun · tests : T07 · sources : [FClientcarte.class:Colcp_Click](../../../../.src/Caisse/FClientcarte.class#L964-L973), [FClientcarte.class:Colcp_KeyPress](../../../../.src/Caisse/FClientcarte.class#L978-L999)
- [ ] FCLIENTCARTE-004 — [complexité] `Deb2`/`Deb3` → `Charge(bDesc)` (texte SQL identique) ; les
  cinq `*_Click` d'en-tête → `TriColonne(sTri, hEntete)` ; les cinq `*_KeyPress` d'en-tête →
  `SaisieFiltre()` ; handlers conservés et réduits à un appel · appelants : aucun · tests : T06 · sources : [FClientcarte.class:Deb2](../../../../.src/Caisse/FClientcarte.class#L126-L131), [FClientcarte.class:Deb3](../../../../.src/Caisse/FClientcarte.class#L133-L138), [FClientcarte.class:C1_Click](../../../../.src/Caisse/FClientcarte.class#L740-L752), [FClientcarte.class:V1_Click](../../../../.src/Caisse/FClientcarte.class#L820-L832), [FClientcarte.class:C1_KeyPress](../../../../.src/Caisse/FClientcarte.class#L849-L861), [FClientcarte.class:V1_KeyPress](../../../../.src/Caisse/FClientcarte.class#L905-L917)
- [ ] FCLIENTCARTE-005 — [complexité] `Cmpt_KeyPress` : table `tag → contrôle suivant` et cas
  particuliers explicites (tag 2 sans code, tag 6 code postal, tag 19 → date, F1) (CC 28 → ≤ 8) ;
  `Colcli_Data` : `Clitable` initialisé une fois dans `_New` · appelants : aucun · tests : T01, T02,
  T06 · sources : [FClientcarte.class:Cmpt_KeyPress](../../../../.src/Caisse/FClientcarte.class#L260-L385), [FClientcarte.class:Colcli_Data](../../../../.src/Caisse/FClientcarte.class#L67-L84)
- [ ] FCLIENTCARTE-006 — [complexité] `Cmpt_LostFocus` (tag 19) : supprimer l'appel
  `Utils.Find_cbarre(Cb.Text)` dont le résultat est ignoré (deux `SELECT` en moins, **SQL modifié,
  dump identique**) · appelants : aucun · tests : T04 · sources : [FClientcarte.class:245](../../../../.src/Caisse/FClientcarte.class#L245)
- [ ] FCLIENTCARTE-007 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `CleanChamps`, `ChkPrx`, `codeBarre`, `CtrlCbarre`, `Dbclk`, `Cpman`, `Calc_barre` → `Private` (aucun appelant externe, vérifié par grep ; couverts par les replays T01-T07). `Refresh` reste `Public` (masque `Control.Refresh`) · appelants : aucun · tests : T01-T07 · sources : [FClientcarte.class:Tris](../../../../.src/Caisse/FClientcarte.class#L111-L124), [FClientcarte.class:Maj_Zones](../../../../.src/Caisse/FClientcarte.class#L140-L178), [FClientcarte.class:Calc_barre](../../../../.src/Caisse/FClientcarte.class#L1130-L1140)
- [ ] FCLIENTCARTE-008 — [séparation traitement/GUI] Extraire `LitCarte(code) As Result`
  (`Maj_Zones`), `EnregistreCarte(bNouveau, …)` (INSERT/UPDATE **tels quels**, y compris l'ordre actuel
  des téléphones de l'UPDATE, + `Enrgcp.Ecp`), `HistoVentes(carte)`/`HistoPoints(carte)`
  (`Hisv_Click`/`Hisp_Click`) ; les handlers gardent messages et remplissage des contrôles ·
  appelants : aucun · tests : T01, T02, T08 · sources : [FClientcarte.class:Maj_Zones](../../../../.src/Caisse/FClientcarte.class#L140-L178), [FClientcarte.class:Button4_Click](../../../../.src/Caisse/FClientcarte.class#L568-L617), [FClientcarte.class:Hisv_Click](../../../../.src/Caisse/FClientcarte.class#L1028-L1080), [FClientcarte.class:Hisp_Click](../../../../.src/Caisse/FClientcarte.class#L1082-L1125)
- [ ] FCLIENTCARTE-009 — [commonalisation] `ProchainCodeCarte() As String` (dernier code + 1 sur 6
  chiffres, même requête) utilisé par `Button2_Click` et par `Caisse.Enrg_Clientd` (même calcul
  recopié) · appelants : `Caisse` (même commit) · tests : T01, CAISSE (client divers) · sources : [FClientcarte.class:Button2_Click](../../../../.src/Caisse/FClientcarte.class#L656-L687), [Caisse.class:Enrg_Clientd](../../../../.src/Caisse/Caisse.class#L7298-L7318)
- [ ] FCLIENTCARTE-010 — [commonalisation] Code-barres interne : `Calc_barre` et la clé EAN de
  `codeBarre` vers les helpers purs prévus par FFOURNISSEUR-006 (`GenereCodeBarre`/`CleEan`, à placer
  dans `Utils`), messages inchangés dans l'écran · appelants : `FFournisseur` (même commit que
  FFOURNISSEUR-006) · tests : T04, T10 · sources : [FClientcarte.class:Calc_barre](../../../../.src/Caisse/FClientcarte.class#L1130-L1140), [FClientcarte.class:codeBarre](../../../../.src/Caisse/FClientcarte.class#L499-L520), [FFournisseur.class:Calc_barre](../../../../.src/Gestion/Tables/FFournisseur.class#L827-L837)
- [ ] FCLIENTCARTE-011 — [commonalisation] Noms de tables de l'historique via
  `Cbase.Table("TabHisEntTck")`/`Cbase.Table("TabHisLigTck")` (texte SQL identique) · appelants :
  aucun · tests : T08 · sources : [FClientcarte.class:1056](../../../../.src/Caisse/FClientcarte.class#L1056), [FClientcarte.class:1060](../../../../.src/Caisse/FClientcarte.class#L1060), [FClientcarte.class:1106](../../../../.src/Caisse/FClientcarte.class#L1106)
- [ ] FCLIENTCARTE-012 — [commonalisation] Après FCLIENT-011..013 : utiliser les services
  transverses du socle `FicheTiers` (`ClauseRecherche`, helpers d'en-tête de tri, `ChercheCP`) ;
  FClientcarte ne reprend **pas** le socle complet (ni contacts, ni mails, ni GED) · appelants :
  aucun · tests : T06, T07 · sources : [FClientcarte.class:Deb2](../../../../.src/Caisse/FClientcarte.class#L126-L131), [FClientcarte.class:Cpman](../../../../.src/Caisse/FClientcarte.class#L920-L933), [FClient.class:Deb2](../../../../.src/Gestion/Tables/FClient.class#L290-L320)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCLIENTCARTE-A01 — [anomalie] `Button4_Click` (modification) : `tel_dom = &{10}, tel_bur =
  &{11}` reçoivent `Telbur`, `Teldom` → **les téléphones domicile et bureau sont inversés à chaque
  enregistrement d'une carte existante** (l'INSERT est correct) · tests : T02 · sources : [FClientcarte.class:597](../../../../.src/Caisse/FClientcarte.class#L597), [FClientcarte.class:585](../../../../.src/Caisse/FClientcarte.class#L585)
- [ ] FCLIENTCARTE-A02 — [anomalie] Sélection du code postal cassée : `Cpman` ouvre
  `Tricp("Client")`, qui écrit dans l'auto-instance de `FClient` (instanciée en mémoire) alors que
  l'écran lit `Variables.*`, jamais remis à `False` (valeur périmée d'une sélection `Facture`
  recopiée) ; `ToggleButton5_Click` ouvre `Tricp("Clientcarte")`, qui fait `FClientcarte.Bsel = True`
  sur un membre inexistant → erreur « Unknown symbol » au clic. Correction : origine `"Facture"`
  (retour par `Variables`) + `Variables.Bsel = False` avant l'ouverture, ou retour par
  `Object.SetProperty` (avec `Tricp`) · tests : T07 · sources : [FClientcarte.class:924](../../../../.src/Caisse/FClientcarte.class#L924), [FClientcarte.class:1015](../../../../.src/Caisse/FClientcarte.class#L1015), [Tricp.class:140](../../../../.src/Affichages/Tricp.class#L140), [Tricp.class:131](../../../../.src/Affichages/Tricp.class#L131)
- [ ] FCLIENTCARTE-A03 — [anomalie] Création : les points `Tp1`/`Tp2`/`Tg1`/`Tg2` sont insérés en
  texte brut (`"1,50"`) dans des colonnes `decimal(12,3)` → MySQL non strict (sql_mode forcé par
  Laurux) tronque à `1`, SQLite stocke le texte ; la modification passe, elle, par
  `Val(Utils.cpoint(…))` · tests : T01 · sources : [FClientcarte.class:585](../../../../.src/Caisse/FClientcarte.class#L585), [FClientcarte.class:597](../../../../.src/Caisse/FClientcarte.class#L597)
- [ ] FCLIENTCARTE-A04 — [anomalie] Prochain code : `ORDER BY code` lexical sur `char(13)` +
  `MoveLast` + `Val + 1` ; un code non normalisé (saisi ailleurs, ex. `Caisse.Enrg_Clientd`) ou la
  création simultanée en caisse donnent un code faux ou en doublon (erreur de clé primaire) ;
  correction : `SELECT MAX(CAST(code AS …))` ou équivalent, avec Caisse · tests : T01 · sources : [FClientcarte.class:662](../../../../.src/Caisse/FClientcarte.class#L662), [FClientcarte.class:666](../../../../.src/Caisse/FClientcarte.class#L666), [Caisse.class:7307](../../../../.src/Caisse/Caisse.class#L7307)
- [ ] FCLIENTCARTE-A05 — [anomalie] Filtre de la liste concaténé dans le SQL (`LIKE "%<sel>%"`) :
  un `"` ou un `\` saisi dans un en-tête provoque une erreur SQL ; paramétrer par `&1` change le
  comportement de ces cas (même résultat sinon) · tests : T06 · sources : [FClientcarte.class:128](../../../../.src/Caisse/FClientcarte.class#L128), [FClientcarte.class:135](../../../../.src/Caisse/FClientcarte.class#L135)
- [ ] FCLIENTCARTE-A06 — [anomalie] `Maj_Zones` lit `Clitab` sans tester `Available` ni l'erreur du
  `Try` : une carte supprimée entre-temps (autre poste, caisse) lève une erreur non gérée au clic ·
  tests : T02 · sources : [FClientcarte.class:146](../../../../.src/Caisse/FClientcarte.class#L146), [FClientcarte.class:148](../../../../.src/Caisse/FClientcarte.class#L148)
- [ ] FCLIENTCARTE-A07 — [anomalie] Suppression d'une carte sans contrôle de l'historique
  (`Fiches_HisEntTickets.carte`) : tickets orphelins, historique et statistiques (`HitCarte`)
  incomplets ; à décider (refus, avertissement ou conservation) · tests : T03 · sources : [FClientcarte.class:636](../../../../.src/Caisse/FClientcarte.class#L636)
