# ClotureF — Rework

> Source : `.src/Gestion/ClotureF.class` · Message de commit (phase 4) : `reference/.src/Gestion/ClotureF.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 32 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 8 (`Aff_date`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 153 | 27 | 8 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CLOTUREF-001 — [documentation] En-tête en français : étapes de la clôture (archivage des
  factures imprimées, avance de période, recalcul des soldes), tables touchées, absence de
  transaction ; commentaires `'''` sur `Maj_Archives` et `Calc_solde` · appelants : aucun ·
  tests : aucun · sources : [ClotureF.class:Maj_Archives](../../../../.src/Gestion/ClotureF.class#L116-L156), [ClotureF.class:Calc_solde](../../../../.src/Gestion/ClotureF.class#L161-L215)
- [ ] CLOTUREF-002 — [code mort] Supprimer les membres inutilisés (`Remmo`, `Remart`, `Nfac`,
  `borientation`, `$soption` et son affectation, `TotSldHP`), la requête `Parmt` inutile, les
  variables `Tab2` (`Button1_Click`), `i`, `Intit`, `p1` et les blocs `With Utils` sans usage du
  `.` · SQL modifié (un `SELECT` en moins), dump identique · appelants : aucun · tests : T01, T05 ·
  sources : [ClotureF.class:32](../../../../.src/Gestion/ClotureF.class#L32), [ClotureF.class:41](../../../../.src/Gestion/ClotureF.class#L41), [ClotureF.class:50](../../../../.src/Gestion/ClotureF.class#L50), [ClotureF.class:150](../../../../.src/Gestion/ClotureF.class#L150), [ClotureF.class:Calc_solde](../../../../.src/Gestion/ClotureF.class#L161-L215)
- [ ] CLOTUREF-003 — [complexité] Supprimer la condition toujours vraie l. 134 (chaîne non vide
  évaluée en booléen) ; comportement identique car `dtefac` est non nul dans le résultat ·
  appelants : aucun · tests : T01, T02 · sources : [ClotureF.class:134](../../../../.src/Gestion/ClotureF.class#L134)
- [ ] CLOTUREF-004 — [réarchitecture] Noms de tables par `Cbase.Table` (`TabParam`, `TabBl`,
  `TabBlM`, `TabComptes`, `TabMvt`) ; SQL émis identique · appelants : aucun · tests : T01 à T06 ·
  sources : [ClotureF.class:Aff_date](../../../../.src/Gestion/ClotureF.class#L60-L90), [ClotureF.class:Maj_Archives](../../../../.src/Gestion/ClotureF.class#L116-L156), [ClotureF.class:Calc_solde](../../../../.src/Gestion/ClotureF.class#L161-L215)
- [ ] CLOTUREF-005 — [commonalisation] `Calc_solde` : garder la boucle sur les comptes et la
  `ProgBar`, déléguer le corps à `Csolde.Solde_caisse(compt)` (SQL identique) ; supprimer les
  accumulateurs locaux `TotDeb`… · appelants : aucun · tests : T05 · sources : [ClotureF.class:Calc_solde](../../../../.src/Gestion/ClotureF.class#L161-L215), [Csolde.module:Solde_caisse](../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] CLOTUREF-006 — [séparation traitement/GUI] Extraire `ArchiveFactures(dFin, PB)` et
  `PeriodeSuivante(dtpc) As LDate` (pure) ; `Calc_solde` sans `Message`/`Me.Close`, la fin de
  traitement restant dans `Button1_Click` (même ordre des messages) · appelants : aucun ·
  tests : T01 à T08 · sources : [ClotureF.class:Maj_Archives](../../../../.src/Gestion/ClotureF.class#L116-L156), [ClotureF.class:Calc_solde](../../../../.src/Gestion/ClotureF.class#L161-L215), [ClotureF.class:Button1_Click](../../../../.src/Gestion/ClotureF.class#L98-L111)
- [ ] CLOTUREF-007 — [réduction de portée] `Aff_date`, `Maj_Archives`, `Calc_solde` → `Private`
  (aucun appelant externe, couverts par les replays) · appelants : aucun · tests : T01 à T07 ·
  sources : [ClotureF.class:Aff_date](../../../../.src/Gestion/ClotureF.class#L60-L90), [ClotureF.class:Maj_Archives](../../../../.src/Gestion/ClotureF.class#L116-L156), [ClotureF.class:Calc_solde](../../../../.src/Gestion/ClotureF.class#L161-L215)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CLOTUREF-A01 — [anomalie] Borne de date incohérente : `dtefac <= fin de mois` pour
  `Fiches_Bl` mais `dtefac < fin de mois` pour `Fiches_BlM` ; les factures « entretien » du dernier
  jour du mois ne sont pas archivées · tests : T02 · sources : [ClotureF.class:128](../../../../.src/Gestion/ClotureF.class#L128)
- [ ] CLOTUREF-A02 — [anomalie] Pas de transaction ni de contrôle de réussite : la période est
  avancée (`dtepp`/`dtepec`) même si des factures n'ont pas été transférées (facture déjà en
  archive, erreur dans `transblfac`) ; le filtre l. 134 suggère qu'un contrôle de période était
  prévu · tests : T03 · sources : [ClotureF.class:Maj_Archives](../../../../.src/Gestion/ClotureF.class#L116-L156), [ClotureF.class:134](../../../../.src/Gestion/ClotureF.class#L134), [ClotureF.class:151](../../../../.src/Gestion/ClotureF.class#L151)
- [ ] CLOTUREF-A03 — [anomalie] Bouton d'aide inactif : `Button2_Click` vide (`Doc.Open`
  commenté) · tests : aucun (manuel) · sources : [ClotureF.class:Button2_Click](../../../../.src/Gestion/ClotureF.class#L217-L220)
- [ ] CLOTUREF-A04 — [anomalie] Aucune pré-condition : pas de contrôle de caisse connectée, de
  ticket Z, de moulinage (contrairement à `Calcstock.Button2_Click`), ni de période future
  (clôture d'un mois postérieur à la date du jour possible) ; le contrôle du tunnel de
  réplication est absent quand l'écran est ouvert par `Fmenu.lblClm_MouseDown` · tests : T01 ·
  sources : [ClotureF.class:Button1_Click](../../../../.src/Gestion/ClotureF.class#L98-L111), [Fmenu.class:1554](../../../../.src/Communs/Fmenu.class#L1554), [Calcstock.class:Button2_Click](../../../../.src/Utils/Calcstock.class#L50-L111)
