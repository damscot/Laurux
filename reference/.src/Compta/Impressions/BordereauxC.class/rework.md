# BordereauxC — Rework

> Source : `.src/Compta/Impressions/BordereauxC.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/BordereauxC.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 415 |
| Lignes de commentaire | 17 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 82 |
| Complexité max (fonction) | 30 (`Imp_Bordereaux`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 415 | 82 | 30 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BORDEREAUXC-001 — [documentation] En-tête en français : écran de remise de chèques
  (ancienne version) qui **comptabilise** la remise ; séquence des écritures produites, tables
  modifiées, colonnes de `Grd1` ; commentaires `'''` sur chaque fonction · appelants : aucun ·
  tests : aucun · sources : [BordereauxC.class:1-20](../../../../../.src/Compta/Impressions/BordereauxC.class#L1-L20), [BordereauxC.class:Imp_Bordereaux](../../../../../.src/Compta/Impressions/BordereauxC.class#L224-L382)
- [ ] BORDEREAUXC-002 — [code mort] Supprimer la première création du `pdf` (l. 256-258), `Tab`,
  `lg`, `bcheque`, `Nclient`, `$texte`, `iRow`, `iColumn`, `CoulFoc`/`CoulCol` et leur lecture de
  configuration, ainsi que la recherche du collectif de `Parametres` (`Colcpt`/`Collectif`, requête
  de lecture seule : SQL modifié, dump identique) · appelants : aucun · tests : T01, T03, T04 ·
  sources : [BordereauxC.class:256-258](../../../../../.src/Compta/Impressions/BordereauxC.class#L256-L258), [BordereauxC.class:259](../../../../../.src/Compta/Impressions/BordereauxC.class#L259), [BordereauxC.class:Form_Open](../../../../../.src/Compta/Impressions/BordereauxC.class#L22-L41), [BordereauxC.class:445-455](../../../../../.src/Compta/Impressions/BordereauxC.class#L445-L455)
- [ ] BORDEREAUXC-003 — [complexité] `Ecritures` lit la colonne passée en paramètre (`numecr2`)
  au lieu de la variable d'instance `numecr` (valeur identique à chaque appel) ; `nro` initialisé ·
  appelants : aucun · tests : T03, T04 · sources : [BordereauxC.class:Ecritures](../../../../../.src/Compta/Impressions/BordereauxC.class#L462-L477)
- [ ] BORDEREAUXC-004 — [complexité] Helpers privés `Insere_Ligne(...)` pour les trois `INSERT`
  de 17 colonnes et `Est_Lettre(sNlot, sCompte, fMontant)` pour les deux tests de lettrage (mêmes
  requêtes, même ordre) · appelants : aucun · tests : T04, T06 · sources : [BordereauxC.class:319-329](../../../../../.src/Compta/Impressions/BordereauxC.class#L319-L329), [BordereauxC.class:351-361](../../../../../.src/Compta/Impressions/BordereauxC.class#L351-L361), [BordereauxC.class:371](../../../../../.src/Compta/Impressions/BordereauxC.class#L371)
- [ ] BORDEREAUXC-005 — [complexité] `Grd1_MouseUp` découpé en `Ajoute_Ligne`,
  `Bascule_Selection`, `Enregistre_Ligne`, `Supprime_Ligne` (CC 20 → ≤ 6 par fonction), `Catch`
  vide conservé · appelants : aucun · tests : T02, T05 · sources : [BordereauxC.class:Grd1_MouseUp](../../../../../.src/Compta/Impressions/BordereauxC.class#L103-L182)
- [ ] BORDEREAUXC-006 — [séparation traitement/GUI] `Imp_Bordereaux` scindé en
  `Imprime_Bordereau(aCheques)` et `Comptabilise_Remise(aCheques, sJournal, sNumBord, sDate)` (liste
  de chèques passée en paramètre, aucune lecture de `Grd1`) ; le handler garde les dialogues ·
  appelants : aucun · tests : T03-T07, T10 · sources : [BordereauxC.class:Imp_Bordereaux](../../../../../.src/Compta/Impressions/BordereauxC.class#L224-L382)
- [ ] BORDEREAUXC-007 — [réduction de portée] `Recup_Cheques`, `Imp_Bordereaux`, `Maj_Collectif`,
  `Parametres`, `Ecritures` → `Private` (aucun appel externe) ; `Grd1_Save` reste `Public`
  (événement) · appelants : aucun · tests : T01-T07 · sources : [BordereauxC.class:Recup_Cheques](../../../../../.src/Compta/Impressions/BordereauxC.class#L43-L94), [BordereauxC.class:Maj_Collectif](../../../../../.src/Compta/Impressions/BordereauxC.class#L384-L417), [BordereauxC.class:Parametres](../../../../../.src/Compta/Impressions/BordereauxC.class#L422-L457), [BordereauxC.class:Ecritures](../../../../../.src/Compta/Impressions/BordereauxC.class#L462-L477)
- [ ] BORDEREAUXC-008 — [commonalisation] Tables par `Cbase.Table` (`TabJour`, `TabCliCaisse`,
  `TabParam`, `TabMvt` pour `Sha1Calc`) ; clé à créer dans `Cbase` pour `Fiches_BordereauxC`
  (appelant impacté : `Cbase`) · appelants : `Cbase` · tests : T01-T04 · sources : [BordereauxC.class:33](../../../../../.src/Compta/Impressions/BordereauxC.class#L33), [BordereauxC.class:70](../../../../../.src/Compta/Impressions/BordereauxC.class#L70), [BordereauxC.class:242](../../../../../.src/Compta/Impressions/BordereauxC.class#L242), [BordereauxC.class:374](../../../../../.src/Compta/Impressions/BordereauxC.class#L374), [BordereauxC.class:434](../../../../../.src/Compta/Impressions/BordereauxC.class#L434)
- [ ] BORDEREAUXC-009 — [commonalisation] (transverse, phase 3) Service commun de réservation de
  numéro d'écriture et de mise à jour de collectif avec `Moulinage` (`Ecritures`, `Parametres`,
  `Maj_Collectif`), à comportement **identique** (anomalies A02-A04 non corrigées dans ce rework) ;
  bascule du `DateChooser` et `Termine(pdf)` du socle des éditions · appelants : `Moulinage` ·
  tests : T04, T06, MOULINAGE (replays de moulinage) · sources : [BordereauxC.class:Maj_Collectif](../../../../../.src/Compta/Impressions/BordereauxC.class#L384-L417), [BordereauxC.class:Parametres](../../../../../.src/Compta/Impressions/BordereauxC.class#L422-L457), [Moulinage.class:Maj_Collectif](../../../../../.src/Caisse/Moulinage.class#L2618-L2659), [BordereauxC.class:Dateb_DblClick](../../../../../.src/Compta/Impressions/BordereauxC.class#L184-L192)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BORDEREAUXC-A01 — [anomalie] Libellé de la ligne de banque : `Bordereaux.Text` (titre vide du
  formulaire de caisse `Caisse/Bordereaux`, instancié en mémoire) au lieu de `Nbordereau.Text` →
  « Bordereau de chèque N° » sans numéro · tests : T04 · sources : [BordereauxC.class:370](../../../../../.src/Compta/Impressions/BordereauxC.class#L370)
- [ ] BORDEREAUXC-A02 — [anomalie] `Maj_Collectif` rappelé après la ligne de banque avec le dernier
  client et le dernier montant : le collectif clients est crédité deux fois du dernier chèque
  (écriture déséquilibrée) · tests : T04 · sources : [BordereauxC.class:373](../../../../../.src/Compta/Impressions/BordereauxC.class#L373)
- [ ] BORDEREAUXC-A03 — [anomalie] `Maj_Collectif` : le solde du collectif est diminué du
  **cumul** (`Mtc = Mnt + montantc`) à chaque chèque et non de l'incrément ; la branche
  `Mnt <= 0` calcule `Mtd` sans l'écrire (défaut partagé avec `Moulinage`, MOULINAGE-A01, latent
  côté caisse ; à confirmer par replay) · tests : T04 · sources : [BordereauxC.class:397-415](../../../../../.src/Compta/Impressions/BordereauxC.class#L397-L415), [Moulinage.class:Maj_Collectif](../../../../../.src/Caisse/Moulinage.class#L2618-L2659)
- [ ] BORDEREAUXC-A04 — [anomalie] Numéros d'écriture réservés à chaque impression, même sans
  comptabilisation (trous de numérotation) ; aucune transaction autour des écritures, soldes,
  SHA-1 et suppressions (état partiel en cas d'erreur) · tests : T03, T04 · sources : [BordereauxC.class:240](../../../../../.src/Compta/Impressions/BordereauxC.class#L240), [BordereauxC.class:Parametres](../../../../../.src/Compta/Impressions/BordereauxC.class#L422-L457), [BordereauxC.class:305-380](../../../../../.src/Compta/Impressions/BordereauxC.class#L305-L380)
- [ ] BORDEREAUXC-A05 — [anomalie] Chèques caisse : test de lettrage avec `Nlot` vide (toujours
  non lettré) ; `INSERT` avec `lettree` 0 puis `UPDATE` de toutes les lignes du numéro `numr` ·
  tests : T06 · sources : [BordereauxC.class:319](../../../../../.src/Compta/Impressions/BordereauxC.class#L319), [BordereauxC.class:331](../../../../../.src/Compta/Impressions/BordereauxC.class#L331)
- [ ] BORDEREAUXC-A06 — [anomalie] Message « chèque sans code client » : montant du chèque
  précédent (variable `Montant` non mise à jour) · tests : T07 · sources : [BordereauxC.class:366](../../../../../.src/Compta/Impressions/BordereauxC.class#L366)
- [ ] BORDEREAUXC-A07 — [anomalie] Copie du PDF par `Shell "cp …"` sans guillemets (échec
  silencieux si le chemin ou le n° de bordereau contient un espace) ; dossier daté par
  `DateChooser1.Value` et non par `Dateb` · tests : T09 · sources : [BordereauxC.class:297-301](../../../../../.src/Compta/Impressions/BordereauxC.class#L297-L301)
- [ ] BORDEREAUXC-A08 — [anomalie] Format `"dd.mm.yyy"` à l'affichage de `dateremise`, relu par
  `Cdate_Dbase` lors d'une mise à jour (date enregistrée potentiellement fausse) ; montant saisi
  avec virgule inséré tel quel dans `montant DECIMAL(12,2)` (à confirmer) · tests : T02 · sources : [BordereauxC.class:77](../../../../../.src/Compta/Impressions/BordereauxC.class#L77), [BordereauxC.class:146](../../../../../.src/Compta/Impressions/BordereauxC.class#L146), [BordereauxC.class:148](../../../../../.src/Compta/Impressions/BordereauxC.class#L148)
- [ ] BORDEREAUXC-A09 — [anomalie] `Catch` vide dans `Grd1_MouseUp` : toute erreur SQL
  d'enregistrement ou de suppression est silencieuse · tests : T02 · sources : [BordereauxC.class:180](../../../../../.src/Compta/Impressions/BordereauxC.class#L180)
