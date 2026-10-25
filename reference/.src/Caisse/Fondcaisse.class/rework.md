# Fondcaisse — Rework

> Source : `.src/Caisse/Fondcaisse.class` · Message de commit (phase 4) : `reference/.src/Caisse/Fondcaisse.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 335 |
| Lignes de commentaire | 4 |
| Fonctions | 28 |
| Fonctions Public | 28 |
| Complexité cyclomatique totale | 98 |
| Complexité max (fonction) | 12 (`Qte_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 335 | 98 | 12 | 0 | 28 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FONDCAISSE-001 — [documentation] En-tête en français : deux modes (`tkz`), formule du fond
  théorique (`N` − `Q` des tickets non validés), lien avec le ticket Z de `Moulinage`, absence de
  lien avec `Csolde.Solde_caisse` · appelants : aucun · tests : T01-T08 · sources : [Fondcaisse.class:_new](../../../../.src/Caisse/Fondcaisse.class#L16-L69), [Fondcaisse.class:Calc_FdcTheo](../../../../.src/Caisse/Fondcaisse.class#L71-L86)
- [ ] FONDCAISSE-002 — [code mort] Supprimer `PictureBox6_MouseDown` (vide, jamais levé :
  `PictureBox6` est dans le groupe `btn`), `Form_Close` (vide), le membre `Mon` (jamais relu) et
  les variables locales inutilisées de `_new`, `TotalFDC`, `Qte_KeyPress` · appelants : aucun ·
  tests : T01, T03, T07 · sources : [Fondcaisse.class:PictureBox6_MouseDown](../../../../.src/Caisse/Fondcaisse.class#L347-L349), [Fondcaisse.class:Form_Close](../../../../.src/Caisse/Fondcaisse.class#L108-L111), [Fondcaisse.class:178](../../../../.src/Caisse/Fondcaisse.class#L178), [Fondcaisse.class:Qte_KeyPress](../../../../.src/Caisse/Fondcaisse.class#L246-L277)
- [ ] FONDCAISSE-003 — [documentation] `"Fiches_Parametres"` en dur → `Cbase.Table("TabParam")`
  (SQL identique) · appelants : aucun · tests : T01 · sources : [Fondcaisse.class:61](../../../../.src/Caisse/Fondcaisse.class#L61)
- [ ] FONDCAISSE-004 — [complexité] `Form_Open` : boucle sur un tableau de noms d'images ;
  `Qte_KeyPress`/`Qte_GotFocus` : indice par `ListQteBox.Find(Last)` au lieu des boucles par `Tag`
  (même comportement, CC `Qte_KeyPress` 12 → ≤ 8 visé) · appelants : aucun · tests : T03, T07 ·
  sources : [Fondcaisse.class:Form_Open](../../../../.src/Caisse/Fondcaisse.class#L88-L106), [Fondcaisse.class:Qte_KeyPress](../../../../.src/Caisse/Fondcaisse.class#L246-L277), [Fondcaisse.class:Qte_GotFocus](../../../../.src/Caisse/Fondcaisse.class#L281-L305)
- [ ] FONDCAISSE-005 — [séparation traitement/GUI] Extraire `FdcTheorique(sCaisse, fInitial) As
  Float` (SQL + somme), `TotalCoupures(aQte) As Float[]` et `EnregistreFdc(sCaisse, sMontant)`
  (les deux `UPDATE fndc`), sans accès aux contrôles · appelants : aucun · tests : T01, T03, T04,
  T05, T09, T10 · sources : [Fondcaisse.class:Calc_FdcTheo](../../../../.src/Caisse/Fondcaisse.class#L71-L86), [Fondcaisse.class:TotalFDC](../../../../.src/Caisse/Fondcaisse.class#L216-L244), [Fondcaisse.class:Button2_Click](../../../../.src/Caisse/Fondcaisse.class#L327-L345), [Fondcaisse.class:FDC_Ini_Update](../../../../.src/Caisse/Fondcaisse.class#L404-L421)
- [ ] FONDCAISSE-006 — [commonalisation] Requête des espèces théoriques partagée avec la section
  « Mouvements » du ticket Z de `Moulinage` (`EspecesTheoriques(sCaisse, sFiltre)`), le filtre
  `e.date = l.date` restant propre à `Moulinage` (SQL identique pour chaque appelant) ·
  appelants : `Moulinage` · tests : T01, T08, T09, tests du ticket Z de MOULINAGE · sources : [Fondcaisse.class:Calc_FdcTheo](../../../../.src/Caisse/Fondcaisse.class#L71-L86), [Moulinage.class:239](../../../../.src/Caisse/Moulinage.class#L239)
- [ ] FONDCAISSE-007 — [réarchitecture] Appeler la fonction déplacée `Rvdr` (OUVERTURE-003) au
  lieu de l'auto-instance d'`Ouverture` (SQL modifié : deux `SELECT` de moins, dump identique) ·
  appelants : aucun · tests : T01, T05 · sources : [Fondcaisse.class:30](../../../../.src/Caisse/Fondcaisse.class#L30)
- [ ] FONDCAISSE-008 — [commonalisation] `ChkFDC` et `Fcaisses.Chkcaisse` → helper de filtre de
  touches paramétré par les caractères admis · appelants : `Fcaisses` · tests : T02, T04,
  FCAISSES-T02 · sources : [Fondcaisse.class:ChkFDC](../../../../.src/Caisse/Fondcaisse.class#L206-L214), [Fcaisses.class:Chkcaisse](../../../../.src/Caisse/Fcaisses.class#L340-L348)
- [ ] FONDCAISSE-009 — [commonalisation] Survol des boutons via `SurvolBoutons` (voir CMENU-008) ·
  appelants : aucun · tests : T01 · sources : [Fondcaisse.class:SetObservers](../../../../.src/Caisse/Fondcaisse.class#L114-L126), [Fondcaisse.class:Obs_Enter](../../../../.src/Caisse/Fondcaisse.class#L128-L134), [Fondcaisse.class:Obs_Leave](../../../../.src/Caisse/Fondcaisse.class#L136-L142)
- [ ] FONDCAISSE-010 — [réduction de portée] `Calc_FdcTheo`, `SetObservers`, `ChkFDC`, `TotalFDC`,
  `FDC_Ini_Update` → `Private` (aucun appelant externe, vérifié par `grep`) · appelants : aucun ·
  tests : T01-T07 · sources : [Fondcaisse.class:Calc_FdcTheo](../../../../.src/Caisse/Fondcaisse.class#L71-L86), [Fondcaisse.class:SetObservers](../../../../.src/Caisse/Fondcaisse.class#L114-L126), [Fondcaisse.class:ChkFDC](../../../../.src/Caisse/Fondcaisse.class#L206-L214), [Fondcaisse.class:TotalFDC](../../../../.src/Caisse/Fondcaisse.class#L216-L244), [Fondcaisse.class:FDC_Ini_Update](../../../../.src/Caisse/Fondcaisse.class#L404-L421)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FONDCAISSE-A01 — [anomalie] `_new` lit `rResult!tkz` sans tester `Available` et sans
  `Catch` : si la caisse de `Ncai` n'existe pas (ou est tronquée à un caractère, OUVERTURE-A01),
  `New Fondcaisse` lève une erreur non interceptée dans `Cmenu`/`Caisse`. De plus la comparaison
  `tkz = 1` est fausse si le pilote renvoie un `Boolean` (à confirmer) · appelants : `Cmenu`,
  `Caisse` · tests : T05, T06 · sources : [Fondcaisse.class:31](../../../../.src/Caisse/Fondcaisse.class#L31), [Fondcaisse.class:35](../../../../.src/Caisse/Fondcaisse.class#L35)
- [ ] FONDCAISSE-A02 — [anomalie, à confirmer] Fond théorique différent de celui du ticket Z :
  `Calc_FdcTheo` somme les lignes `N` − `Q` sans le filtre `e.date = l.date`, alors que `Moulinage`
  calcule le fond final à partir des en-têtes (`mespeces`) ; un écart affiché peut ne pas
  correspondre à l'écart réel du ticket Z · appelants : `Moulinage` · tests : T08 · sources : [Fondcaisse.class:77](../../../../.src/Caisse/Fondcaisse.class#L77), [Moulinage.class:239](../../../../.src/Caisse/Moulinage.class#L239)
- [ ] FONDCAISSE-A03 — [anomalie] `Qte_KeyPress` : `Suppr` recule le curseur d'une position ;
  `Retour arrière` en début de champ supprime le **dernier** caractère (`Mid$(…, 1, -1)`) et fixe
  `Pos = -1` · tests : T07 · sources : [Fondcaisse.class:261](../../../../.src/Caisse/Fondcaisse.class#L261), [Fondcaisse.class:265](../../../../.src/Caisse/Fondcaisse.class#L265)
- [ ] FONDCAISSE-A04 — [anomalie] Correction du fond initial : `IsNumber` refuse le point décimal
  (`12.50`) alors que `ChkFDC` l'autorise ailleurs, et chaque perte de focus d'une saisie invalide
  réaffiche le message en reprenant le focus (impossible de sortir sans valeur valide) ·
  tests : T04 · sources : [Fondcaisse.class:FDC_Ini_Update](../../../../.src/Caisse/Fondcaisse.class#L404-L421), [Fondcaisse.class:FDC_Ini_LostFocus](../../../../.src/Caisse/Fondcaisse.class#L432-L439)
- [ ] FONDCAISSE-A05 — [anomalie, à confirmer] Images chargées depuis `Icones/<devise>/` : seul
  `Icones/Euros` existe ; une autre devise dans `Fiches_Parametres` ferait échouer `Form_Open` ·
  tests : à ajouter (devise `Dollars`) · sources : [Fondcaisse.class:Form_Open](../../../../.src/Caisse/Fondcaisse.class#L88-L106)
- [ ] FONDCAISSE-A06 — [anomalie] « annuler » supprime `~/Caisse.lock`, fichier jamais créé (les
  verrous sont `~/Caisse<n>.lock`) : instruction sans effet, ou suppression d'un fichier étranger
  s'il existe ; à supprimer ou à remplacer par le module `VerrouCaisse` (TESTCAISSES) · tests : T05 · sources : [Fondcaisse.class:322](../../../../.src/Caisse/Fondcaisse.class#L322)
