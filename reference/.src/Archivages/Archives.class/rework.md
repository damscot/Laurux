# Archives — Rework

> Source : `.src/Archivages/Archives.class` · Message de commit (phase 4) : `reference/.src/Archivages/Archives.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1202 |
| Lignes de commentaire | 63 |
| Fonctions | 70 |
| Fonctions Public | 70 |
| Complexité cyclomatique totale | 307 |
| Complexité max (fonction) | 35 (`Recup_ligbl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1202 | 307 | 35 | 0 | 70 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ARCHIVES-001 — [documentation] En-tête en français : rôle, modes de liste, rôle des zones
  d'en-tête, recherche `Blcom`, réimpression par `OptFac`/`ObjFacB`, anomalies · appelants :
  aucun · tests : aucun · sources : [Archives.class:_New](../../../../.src/Archivages/Archives.class#L100-L207), [Archives.class:Button9_Click](../../../../.src/Archivages/Archives.class#L1460-L1468)
- [ ] ARCHIVES-002 — [code mort] Supprimer `Maj_Zones` (vide) et `Refresh` (jamais appelée ; masque
  `Control.Refresh`, aucun appel sur cette fenêtre) · appelants : aucun · tests : T01 · sources : [Archives.class:Maj_Zones](../../../../.src/Archivages/Archives.class#L1046-L1048), [Archives.class:Refresh](../../../../.src/Archivages/Archives.class#L1050-L1054)
- [ ] ARCHIVES-003 — [code mort] Supprimer les 21 membres privés jamais lus ni écrits ou écrits une
  seule fois sans effet (`n`, `typeL`, `Tp`, `cpt`, `Intit`, `Ttva`, `Nbl`, `Txtleg`, `Txtleg2`,
  `jour`, `Ardi`, `nbdec`, `PosY`, `Visudoc`, `Ctva`, `Txtva`, `spiece`, `ImpAuto`, `Franchise`,
  `pdf`, `Ty`) · appelants : aucun · tests : T01-T08 · sources : [Archives.class:26-95](../../../../.src/Archivages/Archives.class#L26-L95)
- [ ] ARCHIVES-004 — [code mort] Supprimer les membres écrits mais jamais relus (`Cv`, `Txmo`,
  `Txpieces`, `Pnm`, `adr1`, `adr2`, `cp`, `Burd`, `dateech`, `reglt`, `Pays`, `Coulfond`,
  `Devises`, `chkfocus`, `$sfrais`, `$borientation`, `$snum`, `Filename`) avec les lectures qui ne
  servent qu'à eux (`SELECT * FROM <TabParam>`, `Fiches_ligcons`/`Fiches_ligregie`,
  `Utils.orientation`, `Kill filename`) et la trace `Print rLib.count` (SQL modifié, dump identique ;
  `TvaCli` conservé, voir A05) · appelants : aucun · tests : T01, T06, T07, T09, T10 · sources : [Archives.class:109](../../../../.src/Archivages/Archives.class#L109), [Archives.class:1277-1287](../../../../.src/Archivages/Archives.class#L1277-L1287), [Archives.class:1371-1373](../../../../.src/Archivages/Archives.class#L1371-L1373), [Archives.class:946](../../../../.src/Archivages/Archives.class#L946), [Archives.class:Button5_Click](../../../../.src/Archivages/Archives.class#L1452-L1458)
- [ ] ARCHIVES-005 — [réduction de portée] `Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Debcom`, `Tris`,
  `Titre`, `Dbclk`, `Colfac_com`, `Colfac_art`, `Colfac_libel`, `CleanChamps`, `Deplacement`,
  `Recup_ligbl`, `CalculTotal` → `Private` (aucun appelant externe, vérifié ; couverts par les
  replays) · appelants : aucun · tests : T01-T09 · sources : [Archives.class:Deb2](../../../../.src/Archivages/Archives.class#L280-L314), [Archives.class:Deb3b](../../../../.src/Archivages/Archives.class#L349-L380), [Archives.class:Colfac_com](../../../../.src/Archivages/Archives.class#L887-L926), [Archives.class:Recup_ligbl](../../../../.src/Archivages/Archives.class#L1254-L1410), [Archives.class:CalculTotal](../../../../.src/Archivages/Archives.class#L1412-L1428)
- [ ] ARCHIVES-006 — [séparation traitement/GUI] Fonction pure `RequeteFactures(…) As String`
  produisant exactement les 24 textes SQL actuels (préfixe de l'union compris, A04 conservée) ;
  `Deb2`, `Deb2b`, `Deb3`, `Deb3b` réduites à un appel `Utils.Base` · appelants : aucun · tests :
  T01-T05 · sources : [Archives.class:Deb2](../../../../.src/Archivages/Archives.class#L280-L314), [Archives.class:Deb2b](../../../../.src/Archivages/Archives.class#L316-L347), [Archives.class:Deb3](../../../../.src/Archivages/Archives.class#L382-L413), [Archives.class:Deb3b](../../../../.src/Archivages/Archives.class#L349-L380)
- [ ] ARCHIVES-007 — [complexité] `Recup_ligbl` (CC 35) : extraire l'ajout d'une ligne de détail
  (`AjouteLigne`) et le calcul des totaux (`CalculTotal` rendue pure : ligne → cumuls) ; écritures
  `Coldetail.Item[10..13]` conservées tant que leur effet n'est pas confirmé · appelants : aucun ·
  tests : T06, T07 · sources : [Archives.class:Recup_ligbl](../../../../.src/Archivages/Archives.class#L1254-L1410), [Archives.class:CalculTotal](../../../../.src/Archivages/Archives.class#L1412-L1428)
- [ ] ARCHIVES-008 — [complexité] `Colbl_Data` : lire les couleurs `/Coul/Facts` et la police une
  seule fois (au chargement de la liste) au lieu de chaque cellule ; `/Coul/Avs` (inutilisée)
  supprimée · appelants : aucun · tests : T01, T02 · sources : [Archives.class:Colbl_Data](../../../../.src/Archivages/Archives.class#L221-L278)
- [ ] ARCHIVES-009 — [commonalisation] Largeurs `/Soc<XX>/Col/LcolH` lues par `Utils.LitLargeurs`
  et écrites par `Utils.SauveLargeurs` (SAISECRIT-010) dans `_New`, `Descendre_KeyPress`,
  `Remonter_KeyPress`, `Button5_Click` (format de clé identique) · prérequis : SAISECRIT-010 ·
  appelants : aucun · tests : T15 · sources : [Archives.class:142-179](../../../../.src/Archivages/Archives.class#L142-L179), [Archives.class:Descendre_KeyPress](../../../../.src/Archivages/Archives.class#L1159-L1168), [Archives.class:Button5_Click](../../../../.src/Archivages/Archives.class#L1452-L1458)
- [ ] ARCHIVES-010 — [commonalisation] Pagination (`Colbl_MouseWheel`, `Descendre_*`, `Remonter_*`,
  flèches de `Colbl_KeyPress`) vers `PaginationListe` (TRICARTES-005), `Deplacement` gardant sa
  logique de rechargement (A02 conservée) · prérequis : TRICARTES-005 · appelants : aucun · tests :
  T04, T05 · sources : [Archives.class:Colbl_MouseWheel](../../../../.src/Archivages/Archives.class#L1068-L1077), [Archives.class:Descendre_Click](../../../../.src/Archivages/Archives.class#L1105-L1115), [Archives.class:Remonter_Click](../../../../.src/Archivages/Archives.class#L1117-L1125), [ArchivesTck.class:Descendre_Click](../../../../.src/Archivages/ArchivesTck.class#L450-L460)
- [ ] ARCHIVES-011 — [complexité] `Colfac_com`/`Colfac_art`/`Colfac_libel` → une aide privée
  `RechercheLignes(sColonne, sTypeLigne, sDDL, bCommentaire)` qui reproduit chaque DDL et chaque
  insertion actuels (A01 conservée) · appelants : aucun · tests : T09 · sources : [Archives.class:Colfac_com](../../../../.src/Archivages/Archives.class#L887-L926), [Archives.class:Colfac_art](../../../../.src/Archivages/Archives.class#L928-L966), [Archives.class:Colfac_libel](../../../../.src/Archivages/Archives.class#L968-L1005)
- [ ] ARCHIVES-012 — [réarchitecture] `NbEnregTot` par `SELECT COUNT(*)` au lieu de rapatrier tous
  les numéros de facture (SQL modifié, même valeur) · appelants : aucun · tests : T05 · sources : [Archives.class:203-204](../../../../.src/Archivages/Archives.class#L203-L204)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ARCHIVES-A01 — [anomalie] Table de travail `Blcom` : `Colfac_com`/`Colfac_libel` la créent
  **permanente** (partagée entre postes, recréée à chaque recherche), `Colfac_art` la crée
  **temporaire sans `DROP`** (échec au 2e appel ou après `Facture.creblcom`, dont la `Blcom`
  temporaire a une autre structure). Correction : table temporaire supprimée puis recréée partout,
  ou résultat en mémoire · tests : T09 · sources : [Archives.class:895-904](../../../../.src/Archivages/Archives.class#L895-L904), [Archives.class:936-944](../../../../.src/Archivages/Archives.class#L936-L944), [Archives.class:976-985](../../../../.src/Archivages/Archives.class#L976-L985)
- [ ] ARCHIVES-A02 — [anomalie, à confirmer] Pagination après un filtre par date : `Deplacement`
  recharge par `Deb2` avec `sel` (chiffres saisis) au lieu de `Deb2b` avec `sel2` → page vide ;
  avec l'ordre inversé et `Dat = 0`, aucun rechargement · tests : T04 · sources : [Archives.class:Deplacement](../../../../.src/Archivages/Archives.class#L1127-L1157)
- [ ] ARCHIVES-A03 — [anomalie] Facture suivante / précédente : bornes de page codées en dur (26 et
  25) au lieu de `lg` ; `Deplacement` borne `NbEnreg` à `NbEnregTot` (factures hors entretien seules,
  sans retrancher `lg`) → dernière page vide possible · tests : T05, T08 · sources : [Archives.class:1473](../../../../.src/Archivages/Archives.class#L1473), [Archives.class:1488](../../../../.src/Archivages/Archives.class#L1488), [Archives.class:1130](../../../../.src/Archivages/Archives.class#L1130)
- [ ] ARCHIVES-A04 — [anomalie] Mode « Toutes les factures » : la partie entretien de l'union
  filtre par préfixe (`like "<sel>%"`) et la partie normale par sous-chaîne (`"%<sel>%"`) ·
  tests : T03 · sources : [Archives.class:307](../../../../.src/Archivages/Archives.class#L307), [Archives.class:309](../../../../.src/Archivages/Archives.class#L309), [Archives.class:406](../../../../.src/Archivages/Archives.class#L406), [Archives.class:408](../../../../.src/Archivages/Archives.class#L408)
- [ ] ARCHIVES-A05 — [anomalie, à confirmer] `rmail!cli_id_tva` lu sans test `Available` : pour une
  facture dont le client a été supprimé, erreur attrapée par `Catch` et détail non affiché ;
  `TvaCli` n'est d'ailleurs jamais relu · tests : T12 · sources : [Archives.class:1225-1232](../../../../.src/Archivages/Archives.class#L1225-L1232)
- [ ] ARCHIVES-A06 — [anomalie] Filtres et recherches construits par concaténation
  (`like "%<saisie>%"`) : un `"` provoque une erreur SQL, `%`/`_` élargissent le filtre.
  Correction : `LIKE &1` (SQL modifié) · tests : T13 · sources : [Archives.class:293](../../../../.src/Archivages/Archives.class#L293), [Archives.class:905](../../../../.src/Archivages/Archives.class#L905), [Archives.class:945](../../../../.src/Archivages/Archives.class#L945), [Archives.class:986](../../../../.src/Archivages/Archives.class#L986)
- [ ] ARCHIVES-A07 — [anomalie, à confirmer] SQLite : `order by abs(lpad(…))` est traduit par
  `DB_Connection` en SQL invalide (DB_CONNECTION-A03) → l'ouverture de l'écran (mode `dat = 0`)
  échoue ; à corriger dans `DB_Connection` · tests : T14 · sources : [Archives.class:293](../../../../.src/Archivages/Archives.class#L293), [DB_Connection.class:423](../../../../.src/Utils/DB_Connection.class#L423)
- [ ] ARCHIVES-A08 — [anomalie, à confirmer] Bouton d'aide `Button7` (groupe `Btn`) sans
  `Btn_Click` : inerte (constat commun à de nombreux formulaires) · tests : aucun · sources : [Archives.class:_New](../../../../.src/Archivages/Archives.class#L100-L207)
- [ ] ARCHIVES-A09 — [anomalie, à confirmer] `Recup_ligbl` écrit `Coldetail.Item[10..13]` alors que
  la vue a 9 colonnes (valeurs perdues ou erreur selon l'implémentation de `ColumnView`) et lit le
  matériel `Fiches_HisentMat` même pour une facture hors entretien ; totaux HT/TTC repris de la
  ligne de liste et non des lignes · tests : T06, T07 · sources : [Archives.class:1351-1358](../../../../.src/Archivages/Archives.class#L1351-L1358), [Archives.class:1289](../../../../.src/Archivages/Archives.class#L1289), [Archives.class:1369-1370](../../../../.src/Archivages/Archives.class#L1369-L1370)
- [ ] ARCHIVES-A10 — [anomalie, à confirmer] Recherche par commentaire / code / libellé : le
  critère n'est pris en compte que s'il est affiché par la ComboBox `NM` au moment où elle prend le
  focus (pas de `NM_Click`) ; sinon la frappe filtre par nom. Les recherches ignorent les factures
  entretien · tests : T09 · sources : [Archives.class:NM_Gotfocus](../../../../.src/Archivages/Archives.class#L809-L850), [Archives.class:NM_KeyPress](../../../../.src/Archivages/Archives.class#L858-L885)
