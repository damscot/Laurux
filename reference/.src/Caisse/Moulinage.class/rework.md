# Moulinage — Rework

> Source : `.src/Caisse/Moulinage.class` · Message de commit (phase 4) : `reference/.src/Caisse/Moulinage.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2430 |
| Lignes de commentaire | 218 |
| Fonctions | 33 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 622 |
| Complexité max (fonction) | 196 (`Livre_caisse`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 2430 | 622 | 196 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Gros fichier de traitement comptable : changements **minimaux et ciblés**, chacun couvert par les
replays de moulinage (MOULINAGE-T04 à T22).

- [ ] MOULINAGE-001 — [documentation] En-tête en français : rôle (moulinage, bibliothèque de la
  caisse via l'auto-instance, contrôle), chaîne des étapes, tables écrites, absence de transaction ;
  commentaire `'''` sur chaque fonction ; message de confirmation inchangé · appelants : aucun ·
  tests : aucun · sources : [Moulinage.class:Button1_Click](../../../../.src/Caisse/Moulinage.class#L71-L104), [Moulinage.class:Moulinage](../../../../.src/Caisse/Moulinage.class#L952-L1480), [Moulinage.class:Livre_caisse](../../../../.src/Caisse/Moulinage.class#L106-L748)
- [ ] MOULINAGE-002 — [code mort] Supprimer les variables d'instance inutiles (`Vic`, `Vichq`,
  `Vibonus`, `Vibachat`, `Vitresto`, `Viautre`, `Vicadeau`, `Nclient`, `Artdsg2`, `Paht`, `Ecot`,
  `Tcp`, `Decm`, `jnal3`, `marge`), la vingtaine de locales mortes de `Moulinage`, celles de
  `Livre_caisse` (`sFam*`, `sLFam`, `sMtfam`, `Enc`, `Boncaisse`, `totboncaisse`, `tcheque`,
  `tcarte`), l'étiquette `next_ticket:`, `sCompte` de `Verif` et les blocs commentés · appelants :
  aucun · tests : T04, T12, T20 · sources : [Moulinage.class:36-44](../../../../.src/Caisse/Moulinage.class#L36-L44), [Moulinage.class:Livre_caisse](../../../../.src/Caisse/Moulinage.class#L106-L748), [Moulinage.class:Moulinage](../../../../.src/Caisse/Moulinage.class#L952-L1480), [Moulinage.class:Verif](../../../../.src/Caisse/Moulinage.class#L2307-L2355)
- [ ] MOULINAGE-003 — [code mort] `Parametres` : supprimer la recherche du collectif (requête
  `coll = 1` et boucle), dont le résultat est toujours écrasé par `Maj_Compta` (« SQL modifié, dump
  identique ») · appelants : aucun · tests : T04, T20 · sources : [Moulinage.class:Parametres](../../../../.src/Caisse/Moulinage.class#L2235-L2269), [Moulinage.class:2397](../../../../.src/Caisse/Moulinage.class#L2397)
- [ ] MOULINAGE-004 — [code mort] Supprimer `Virements()` (table jamais alimentée) et
  `Virements` du `LOCK TABLES`, à condition que les tables de travail soient exclues du dump
  normalisé (décision phase 2 ; sinon le dump perd une table vide) · appelants : aucun ·
  tests : T04, T17 · sources : [Moulinage.class:Virements](../../../../.src/Caisse/Moulinage.class#L2189-L2201), [Moulinage.class:1009](../../../../.src/Caisse/Moulinage.class#L1009), [Moulinage.class:1064](../../../../.src/Caisse/Moulinage.class#L1064), [Moulinage.class:1520](../../../../.src/Caisse/Moulinage.class#L1520)
- [ ] MOULINAGE-005 — [commonalisation] Noms de tables par `Cbase.Table` avec la même valeur :
  `Sha1Calc.CalcSha1("Fiches_Mvt")` ×13 → `TabMvt`, `CalcSha1T("Fiches_EntTicketz")` →
  `TabEntTck`, `Fiches_Mvt` de `Controle_Moulinage` → `TabMvt`, `Fiches_Parametres` → `TabParam`,
  `Fiches_Caisses` → `TabCaisses`, `Fiches_Cli` → `TabCli`, `Fiches_ClientCaisse` →
  `TabCliCaisse`, `Fiches_LigTicketz`/`Fiches_EntTicketz`/`Fiches_Comptes` de `Maj_Tresorerie` et
  `genfac`, `Fiches_HistoFac`/`Fiches_HistoLigfac` (`TabHisFac`/`TabHisLigFac`), `Fiches_Art`,
  `Fiches_Tvaav`, `Tabe`/`Tabl`/`Tabx` de `Livre_caisse` ; `Fiches_FamDep` et `Fiches_Reglements`
  restent en dur (pas de clé `Cbase`) · appelants : aucun · tests : T04, T09, T13, T17, T20 · sources : [Moulinage.class:937](../../../../.src/Caisse/Moulinage.class#L937), [Moulinage.class:1046](../../../../.src/Caisse/Moulinage.class#L1046), [Moulinage.class:1758](../../../../.src/Caisse/Moulinage.class#L1758), [Moulinage.class:2533](../../../../.src/Caisse/Moulinage.class#L2533), [Moulinage.class:genfac](../../../../.src/Caisse/Moulinage.class#L2664-L2874), [Moulinage.class:141-143](../../../../.src/Caisse/Moulinage.class#L141-L143)
- [ ] MOULINAGE-006 — [complexité] `Livre_caisse` : helper privé `Imprime_Tickets(pdf, titre,
  rTkx, avec_client, Ba4)` pour les 4 blocs de détail des tickets et tableau des libellés des
  modes de règlement (CC 196 → ≤ 60 visé ; PDF identique) · appelants : `Caisse` (signature
  inchangée) · tests : T04, T12, T20 · sources : [Moulinage.class:Livre_caisse](../../../../.src/Caisse/Moulinage.class#L106-L748), [Moulinage.class:384-722](../../../../.src/Caisse/Moulinage.class#L384-L722)
- [ ] MOULINAGE-007 — [commonalisation] Helpers privés `Compte_Vente(fam, retro, depot)` et
  `Compte_Tva(code_tva)` pour les 5 résolutions famille/dépôt/TVA → compte et intitulé de
  `Moulinage` et `Controle_Moulinage` (même ordre de requêtes) · appelants : aucun · tests : T04,
  T09, T12, T17 · sources : [Moulinage.class:1133-1168](../../../../.src/Caisse/Moulinage.class#L1133-L1168), [Moulinage.class:1201-1236](../../../../.src/Caisse/Moulinage.class#L1201-L1236), [Moulinage.class:1565-1590](../../../../.src/Caisse/Moulinage.class#L1565-L1590), [Moulinage.class:1653-1678](../../../../.src/Caisse/Moulinage.class#L1653-L1678), [Moulinage.class:1721-1748](../../../../.src/Caisse/Moulinage.class#L1721-L1748)
- [ ] MOULINAGE-008 — [commonalisation] Helper privé `Insere_Mvt(jour, numero, compte, …)` pour
  les 12 `INSERT INTO Fiches_Mvt` à 17 colonnes (SQL identique) · appelants : aucun · tests : T04,
  T05, T06, T09, T17 · sources : [Moulinage.class:Moulinage_Acomptes_Avoir](../../../../.src/Caisse/Moulinage.class#L874-L949), [Moulinage.class:1329](../../../../.src/Caisse/Moulinage.class#L1329), [Moulinage.class:1382](../../../../.src/Caisse/Moulinage.class#L1382), [Moulinage.class:1902](../../../../.src/Caisse/Moulinage.class#L1902)
- [ ] MOULINAGE-009 — [complexité] `Moulinage()` découpé en fonctions privées par étape
  (contrôles, archivage d'un ticket, ventilation d'un ticket, règlement des BL, règlement des
  factures, suppression des tickets) en conservant l'ordre exact des requêtes (CC 126 → ≤ 30 par
  fonction visé) · appelants : aucun · tests : T04 à T18 · sources : [Moulinage.class:Moulinage](../../../../.src/Caisse/Moulinage.class#L952-L1480)
- [ ] MOULINAGE-010 — [complexité] Lire le dépôt de la caisse une fois par ticket au lieu de
  chaque ligne, et filtrer la date en SQL dans `Maj_Tresorerie` (`DATE(e.date) = &3`) (« SQL
  modifié, dump identique ») · appelants : aucun · tests : T04, T07, T12, T22 · sources : [Moulinage.class:1135](../../../../.src/Caisse/Moulinage.class#L1135), [Moulinage.class:1201](../../../../.src/Caisse/Moulinage.class#L1201), [Moulinage.class:Maj_Tresorerie](../../../../.src/Caisse/Moulinage.class#L2512-L2572)
- [ ] MOULINAGE-011 — [réduction de portée] `Moulinage_Acomptes_Avoir`, `Moulinage`,
  `Controle_Moulinage`, `Recup_Art`, `Remises_quantitatives`, `CalcTTC`, `Recup_Tva`, `Decimal`,
  `arrondi`, `Calc_Marge`, `Ventilation`, `Virements`, `Ecritures`, `Majnum`, `Parametres`,
  `Maj_Totalisation`, `Verif`, `Maj_Compta`, `Verif_Reglement_Caisse`, `Maj_Tresorerie`,
  `Maj_Collectif` → `Private` (aucun appelant externe ; `Generation_Bl`, `Livre_caisse`, `_new` et
  les handlers restent `Public`) ; T01-T03 passent alors par `Generation_Bl` ou sont réécrits ·
  appelants : aucun · tests : T01-T03, T04 à T20 · sources : [Moulinage.class:Moulinage_Acomptes_Avoir](../../../../.src/Caisse/Moulinage.class#L874-L949), [Moulinage.class:Recup_Art](../../../../.src/Caisse/Moulinage.class#L1934-L2019), [Moulinage.class:arrondi](../../../../.src/Caisse/Moulinage.class#L2116-L2151), [Moulinage.class:Maj_Collectif](../../../../.src/Caisse/Moulinage.class#L2618-L2659)
- [ ] MOULINAGE-012 — [séparation traitement/GUI] Date du moulinage passée en paramètre
  (`Moulinage_Date(dDate)`, `Controle_Moulinage(dDate)`, `Maj_Compta`, `Maj_Tresorerie`,
  `Maj_Collectif`, `genfac`) au lieu de lire `DateChooser1.Value` ; `Button1_Click`/`Button4_Click`
  passent la valeur du contrôle · appelants : aucun · tests : T04 à T18 · sources : [Moulinage.class:1025](../../../../.src/Caisse/Moulinage.class#L1025), [Moulinage.class:1517](../../../../.src/Caisse/Moulinage.class#L1517), [Moulinage.class:Maj_Compta](../../../../.src/Caisse/Moulinage.class#L2360-L2485), [Moulinage.class:Maj_Collectif](../../../../.src/Caisse/Moulinage.class#L2618-L2659), [Moulinage.class:genfac](../../../../.src/Caisse/Moulinage.class#L2664-L2874)
- [ ] MOULINAGE-013 — [séparation traitement/GUI] Confirmations isolées dans des fonctions
  d'interface (`Confirme_Ecart(sDif)`, `Confirme_Tickets_Alteres(liste)`), le traitement recevant
  la réponse ; mêmes textes et même séquence · appelants : aucun · tests : T11, T16, T17 · sources : [Moulinage.class:Verif](../../../../.src/Caisse/Moulinage.class#L2307-L2355), [Moulinage.class:1055-1059](../../../../.src/Caisse/Moulinage.class#L1055-L1059), [Moulinage.class:1797-1838](../../../../.src/Caisse/Moulinage.class#L1797-L1838)
- [ ] MOULINAGE-014 — [commonalisation] (transverse, phase 3) `Ecritures`, `Majnum`, `Parametres`
  et `Maj_Collectif` vers le service commun d'écritures partagé avec `BordereauxC`
  (BORDEREAUXC-009) et `Saisecrit`, à comportement **identique** (A01 non corrigée ici) ·
  appelants : `BordereauxC`, `Saisecrit` · tests : T04 à T06, T17, BORDEREAUXC-T04 · sources : [Moulinage.class:Ecritures](../../../../.src/Caisse/Moulinage.class#L2206-L2221), [Moulinage.class:Majnum](../../../../.src/Caisse/Moulinage.class#L2226-L2230), [Moulinage.class:Maj_Collectif](../../../../.src/Caisse/Moulinage.class#L2618-L2659), [BordereauxC.class:Maj_Collectif](../../../../.src/Compta/Impressions/BordereauxC.class#L384-L417)
- [ ] MOULINAGE-015 — [commonalisation] `arrondi` → fonction `Utils` unique partagée avec
  `Caisse.arrondi` (paramètres inversés) ; sorties identiques à l'octet, séparateur compris ·
  appelants : `Caisse` · tests : T01, T02 · sources : [Moulinage.class:arrondi](../../../../.src/Caisse/Moulinage.class#L2116-L2151), [Caisse.class:487](../../../../.src/Caisse/Caisse.class#L487)
- [ ] MOULINAGE-016 — [commonalisation] `Ventilation` : DDL de `Totalisation` partagé avec
  `Facturergbl.Ventilation` (helper des tables de travail, même SQL) ; ne plus l'appeler depuis
  `Livre_caisse` seulement si les tables de travail sont exclues du dump (sinon l'état de
  `Totalisation` après un ticket Z change) · appelants : `Caisse` (inchangé) · tests : T04, T20 · sources : [Moulinage.class:Ventilation](../../../../.src/Caisse/Moulinage.class#L2173-L2184), [Moulinage.class:145-146](../../../../.src/Caisse/Moulinage.class#L145-L146), [Facturergbl.class:Ventilation](../../../../.src/Gestion/Facturation/Facturergbl.class#L1023-L1038)
- [ ] MOULINAGE-017 — [commonalisation] Lecture du compte client caisse (`Parametres`,
  `Controle_Moulinage`) par le helper commun `CompteClientCaisse()` proposé dans `Fclientc`
  (également `BordereauxC`, `Cmenu`), même requête · appelants : aucun · tests : T04, T17 · sources : [Moulinage.class:Parametres](../../../../.src/Caisse/Moulinage.class#L2235-L2269), [Moulinage.class:1528](../../../../.src/Caisse/Moulinage.class#L1528)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MOULINAGE-A01 — [anomalie] `Maj_Collectif` : si une ligne de collectif existe pour
  l'écriture, le solde du collectif est modifié du **cumul** (`Mnt + montantc`) et non de
  l'incrément ; pour `Mnt ≤ 0`, `Mtd = Mnt + montantd` (signe) et l'`UPDATE` remet `montantc` à 0
  sans écrire `Mtd` ; la ligne de collectif est insérée dans le journal de trésorerie `Jnal` alors
  que l'écriture est en `Jnl`. Latent dans `Moulinage` (un `numr` neuf par appel), réel dans
  `BordereauxC` (BORDEREAUXC-A03) : correction commune (ou `Csolde.Solde_caisse`) · tests : T05,
  T06 · sources : [Moulinage.class:2629-2657](../../../../.src/Caisse/Moulinage.class#L2629-L2657), [Moulinage.class:2648](../../../../.src/Caisse/Moulinage.class#L2648), [BordereauxC.class:Maj_Collectif](../../../../.src/Compta/Impressions/BordereauxC.class#L384-L417)
- [ ] MOULINAGE-A02 — [anomalie, à confirmer] `LOCK TABLES` illusoire : liste incomplète
  (`Tmp_Caisse`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_ligregie`…), verrous remplacés
  par ceux de `DocActif` (`Ent_Bl`, FACTURERGBL-A03) ou libérés par le premier `Begin` (MySQL),
  non relâchés par le `Catch` ; un accès à une table non verrouillée avant libération lève une
  erreur (ex. `New ObjFacB` d'une facture non acquittée sans regroupement préalable). À remplacer
  par une transaction cohérente · tests : T09, T18 (multi-postes non testable) · sources : [Moulinage.class:1064](../../../../.src/Caisse/Moulinage.class#L1064), [Moulinage.class:1440](../../../../.src/Caisse/Moulinage.class#L1440), [Moulinage.class:1474-1478](../../../../.src/Caisse/Moulinage.class#L1474-L1478), [Facturergbl.class:Ent_Bl](../../../../.src/Gestion/Facturation/Facturergbl.class#L1238-L1317)
- [ ] MOULINAGE-A03 — [anomalie, à confirmer] Moulinage non transactionnel : une erreur laisse un
  état partiel (le message demande de restaurer la sauvegarde) ; pour une facture magasin sans
  article à droits, `ObjFacB.comptmat` laisse une transaction ouverte (OBJFACB-A02) et les
  `DELETE` des tickets s'exécutent sans `Commit` (tickets possiblement restaurés à la
  déconnexion → second moulinage et écritures en double) · tests : T13, T18 · sources : [Moulinage.class:2869-2870](../../../../.src/Caisse/Moulinage.class#L2869-L2870), [Moulinage.class:1446-1451](../../../../.src/Caisse/Moulinage.class#L1446-L1451), [ObjFacB.class:464](../../../../.src/Gestion/option/ObjFacB.class#L464)
- [ ] MOULINAGE-A04 — [anomalie, à confirmer] `Maj_Tresorerie` (et `Verif_Reglement_Caisse`) ne
  filtrent pas les tickets supprimés et joignent lignes et entêtes sur le seul numéro : les
  règlements d'un ticket supprimé sont passés en trésorerie, alors que ses ventes sont exclues de
  la ventilation (écart signalé) · tests : T08 · sources : [Moulinage.class:2533](../../../../.src/Caisse/Moulinage.class#L2533), [Moulinage.class:2498](../../../../.src/Caisse/Moulinage.class#L2498)
- [ ] MOULINAGE-A05 — [anomalie] `Controle_Moulinage` : filtre `left(date, 8) = "aaaammjj"` sur la
  colonne `datetime` de `Fiches_HisEntTickets` (`aaaa-mm-jj …`) : jamais vrai, le contrôle des
  tickets « oubliés » ne fait rien · tests : T17 · sources : [Moulinage.class:1691](../../../../.src/Caisse/Moulinage.class#L1691)
- [ ] MOULINAGE-A06 — [anomalie] `Controle_Moulinage` : `rlTck!fam` lu sur `Fiches_Ligbl` et
  `Fiches_HistoLigfac` (colonne absente) quand la famille est nulle → erreur « Unknown field » et
  arrêt du contrôle ; cinq `Return` anticipés laissent le curseur en attente ; les lignes de
  l'écriture de correction ne recalculent pas les soldes · tests : T17 · sources : [Moulinage.class:1559](../../../../.src/Caisse/Moulinage.class#L1559), [Moulinage.class:1647](../../../../.src/Caisse/Moulinage.class#L1647), [Moulinage.class:1770](../../../../.src/Caisse/Moulinage.class#L1770), [Moulinage.class:1902-1910](../../../../.src/Caisse/Moulinage.class#L1902-L1910)
- [ ] MOULINAGE-A07 — [anomalie] `Recup_Art` : `Artpu = Artbrut = "0"` affecte à `Artpu` le
  booléen de la comparaison ; une ligne de quantité nulle d'un ticket client en compte donne un
  `pu_ligbl` « True »/« False » dans le BL · tests : T02, T19 · sources : [Moulinage.class:1992](../../../../.src/Caisse/Moulinage.class#L1992)
- [ ] MOULINAGE-A08 — [anomalie] `Remises_quantitatives` : boucle `0 To Rms.Bounds[0] - 1`, la 6e
  tranche (`qte11`, `qte12`, `rem6`) n'est jamais appliquée (même défaut que FACTURE-A07 et
  `Caisse.Remises_quantitatives`) · tests : T02 · sources : [Moulinage.class:2029](../../../../.src/Caisse/Moulinage.class#L2029), [Caisse.class:1707](../../../../.src/Caisse/Caisse.class#L1707)
- [ ] MOULINAGE-A09 — [anomalie] `Livre_caisse` : cumuls (`totcaisse`, `totventes`, `tespece`,
  `itva`, `tmttc`) non remis à zéro entre caisses → livre multi-caisses du moulinage faux à partir
  de la 2e caisse ; `Dec Application.Busy` sans `Inc` ; `Update … as e set e.statut` non accepté
  par SQLite (ticket Z, à confirmer) · tests : T12, T20, T21 · sources : [Moulinage.class:186](../../../../.src/Caisse/Moulinage.class#L186), [Moulinage.class:200-206](../../../../.src/Caisse/Moulinage.class#L200-L206), [Moulinage.class:354](../../../../.src/Caisse/Moulinage.class#L354), [Moulinage.class:726](../../../../.src/Caisse/Moulinage.class#L726), [Moulinage.class:738](../../../../.src/Caisse/Moulinage.class#L738)
- [ ] MOULINAGE-A10 — [anomalie, à confirmer] Suppression des tickets moulinés par numéro seul
  (`DELETE … where numero = &1`, sans la date) : un ticket de même numéro d'une autre journée non
  moulinée et ses lignes sont aussi supprimés · tests : T08, T14 · sources : [Moulinage.class:1449-1450](../../../../.src/Caisse/Moulinage.class#L1449-L1450)
- [ ] MOULINAGE-A11 — [anomalie] Archivage d'une ligne `BL` : la famille enregistrée est celle de
  la ligne (ou du ticket) précédente (`Fam` non réinitialisée) · tests : T09 · sources : [Moulinage.class:1112](../../../../.src/Caisse/Moulinage.class#L1112)
- [ ] MOULINAGE-A12 — [anomalie] `Moulinage_Acomptes_Avoir` : `Error.Raise(msg, type)` à deux
  arguments → l'erreur levée est « Too many arguments » au lieu du message (cf. CALCULDROIT1-A02) ;
  les comptes `419100`, `419700`, `468700` sont en dur · tests : T18 · sources : [Moulinage.class:934](../../../../.src/Caisse/Moulinage.class#L934), [Moulinage.class:1268-1277](../../../../.src/Caisse/Moulinage.class#L1268-L1277)
- [ ] MOULINAGE-A13 — [anomalie, à confirmer] Règlement en caisse d'une facture non acquittée : la
  ligne du client caisse est écrite dans une **nouvelle** écriture `numr` du journal de vente
  (`fac.journal`) au lieu de compléter l'écriture de la facture comme pour les BL regroupés ; le
  lettrage ne traite que la première écriture trouvée ; `res!cli_nom` lu sans test `Available` ·
  tests : T09 · sources : [Moulinage.class:1382](../../../../.src/Caisse/Moulinage.class#L1382), [Moulinage.class:1339-1342](../../../../.src/Caisse/Moulinage.class#L1339-L1342), [Moulinage.class:1390-1393](../../../../.src/Caisse/Moulinage.class#L1390-L1393), [Moulinage.class:1356-1357](../../../../.src/Caisse/Moulinage.class#L1356-L1357)
- [ ] MOULINAGE-A14 — [anomalie, liée] Option boissons `B` : l'accise n'est pas retirée du HT de
  la facture magasin et `rem_ligfac` est calculée (conséquence de CALCULDROIT1-A01, à corriger dans
  le même commit) · tests : T13 · sources : [Moulinage.class:2812](../../../../.src/Caisse/Moulinage.class#L2812), [Moulinage.class:2825](../../../../.src/Caisse/Moulinage.class#L2825), [Moulinage.class:2838](../../../../.src/Caisse/Moulinage.class#L2838), [Moulinage.class:2860](../../../../.src/Caisse/Moulinage.class#L2860), [calculdroit1.class:33](../../../../.src/Gestion/option/calculdroit1.class#L33)
- [ ] MOULINAGE-A15 — [anomalie] Sauvegarde préalable : `mysqldump` avec le mot de passe en clair
  sur la ligne de commande, résultat non vérifié, tenté sous SQLite, fichier `<base>.sql<date>` ;
  message de confirmation « effacer les bordereaux de remises » obsolète (plus rien n'est effacé
  depuis `d2a027d8`) → `Utils.DumpBase` (UTILS-014) et message corrigé · tests : T04, T15, T21 · sources : [Moulinage.class:78](../../../../.src/Caisse/Moulinage.class#L78), [Moulinage.class:95](../../../../.src/Caisse/Moulinage.class#L95)
- [ ] MOULINAGE-A16 — [anomalie] `genfac` : prix unitaire d'un article inconnu = `SUM(pu)` des
  lignes ; article inconnu en option `B`/`T` → `res!art_cdarr` lu sans test `Available` (erreur
  fatale) ; client caisse lu sans test ; conversion `Replace(".", ",")` + `Val` dépendante de la
  locale · tests : T04, T13 · sources : [Moulinage.class:2781](../../../../.src/Caisse/Moulinage.class#L2781), [Moulinage.class:2851](../../../../.src/Caisse/Moulinage.class#L2851), [Moulinage.class:2803](../../../../.src/Caisse/Moulinage.class#L2803), [Moulinage.class:2768](../../../../.src/Caisse/Moulinage.class#L2768), [Moulinage.class:2718](../../../../.src/Caisse/Moulinage.class#L2718)
- [ ] MOULINAGE-A17 — [anomalie] `Maj_Compta` : `hResult!solde` lu sans test `Available` (compte
  de vente absent de `Fiches_Comptes` → erreur fatale en cours d'écriture), solde du collectif mis
  à jour avec une valeur `Sld` périmée si le collectif est absent ; soldes incrémentaux au lieu de
  `Csolde.Solde_caisse` · tests : T04, T18 · sources : [Moulinage.class:2403](../../../../.src/Caisse/Moulinage.class#L2403), [Moulinage.class:2415-2423](../../../../.src/Caisse/Moulinage.class#L2415-L2423), [Moulinage.class:2464-2471](../../../../.src/Caisse/Moulinage.class#L2464-L2471)
