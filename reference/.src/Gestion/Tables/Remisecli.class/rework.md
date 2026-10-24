# Remisecli — Rework

> Source : `.src/Gestion/Tables/Remisecli.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Remisecli.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 351 |
| Lignes de commentaire | 37 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 86 |
| Complexité max (fonction) | 12 (`Rem_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 351 | 86 | 12 | 0 | 32 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] REMISECLI-001 — [documentation] En-tête en français : table `Fiches_RemCliFam`, lecteurs
  (`TarArt`, `Facture`), grille virtuelle sur `Utils.rs1`, en-têtes interactifs, groupe `rem`,
  handlers `Cdf_*` inactifs signalés · appelants : aucun · tests : aucun · sources : [Remisecli.class:_New](../../../../../.src/Gestion/Tables/Remisecli.class#L38-L52), [Remisecli.class:Deb2](../../../../../.src/Gestion/Tables/Remisecli.class#L64-L72), [Remisecli.class:Cdf_GotFocus](../../../../../.src/Gestion/Tables/Remisecli.class#L440-L450)
- [ ] REMISECLI-002 — [code mort] Supprimer `CoulZns`/`CoulfOC` et leur calcul ; supprimer
  `Cdf_GotFocus`, `Cdf_Dblclick`, `Cdf_KeyPress` (jamais levés, `Cdf` du groupe `rem`) **si
  REMISECLI-A01 est refusée** ; sinon cette partie est absorbée par A01 · appelants : aucun ·
  tests : T05, T06 · sources : [Remisecli.class:29](../../../../../.src/Gestion/Tables/Remisecli.class#L29), [Remisecli.class:30](../../../../../.src/Gestion/Tables/Remisecli.class#L30), [Remisecli.class:Cdf_GotFocus](../../../../../.src/Gestion/Tables/Remisecli.class#L440-L450), [Remisecli.class:Cdf_Dblclick](../../../../../.src/Gestion/Tables/Remisecli.class#L452-L461), [Remisecli.class:Cdf_KeyPress](../../../../../.src/Gestion/Tables/Remisecli.class#L463-L475)
- [ ] REMISECLI-003 — [complexité] `Deb2`/`Deb3` fusionnées (`Liste(ordre)`, même texte SQL) ;
  `Clitable` initialisé une fois ; remise à zéro commune des handlers `Co_*` · appelants : aucun ·
  tests : T05 · sources : [Remisecli.class:Deb2](../../../../../.src/Gestion/Tables/Remisecli.class#L64-L72), [Remisecli.class:Deb3](../../../../../.src/Gestion/Tables/Remisecli.class#L74-L78), [Remisecli.class:Tabcli_Data](../../../../../.src/Gestion/Tables/Remisecli.class#L91-L101), [Remisecli.class:Co_GotFocus](../../../../../.src/Gestion/Tables/Remisecli.class#L403-L413)
- [ ] REMISECLI-004 — [réduction de portée] `Deb2`, `Deb3`, `Tris`, `Maj_Zones`, `CleanChamps`,
  `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise`, `entete`, `Dbclk`, `Ref` → `Private` (aucun appel
  externe, vérifié par `grep -rn`) ; `Colcli_Click`, `Colfam_Click` (`replay_dynamic`) inchangés ·
  appelants : aucun · tests : T01-T05 · sources : [Remisecli.class:Tris](../../../../../.src/Gestion/Tables/Remisecli.class#L80-L89), [Remisecli.class:Dbclk](../../../../../.src/Gestion/Tables/Remisecli.class#L477-L487), [Remisecli.class:Ref](../../../../../.src/Gestion/Tables/Remisecli.class#L489-L495)
- [ ] REMISECLI-005 — [séparation traitement/GUI] `EnregistreRemise(client, famille, remise)`,
  `SupprimeRemise(client, famille)`, `RequeteListe(tri, filtre, ordre)` sans contrôle ·
  appelants : aucun · tests : T01, T02, T04, T05 · sources : [Remisecli.class:Button3_Click](../../../../../.src/Gestion/Tables/Remisecli.class#L331-L357), [Remisecli.class:Button2_Click](../../../../../.src/Gestion/Tables/Remisecli.class#L305-L323), [Remisecli.class:Deb2](../../../../../.src/Gestion/Tables/Remisecli.class#L64-L72)
- [ ] REMISECLI-006 — [commonalisation] Gabarit de saisie commun avec `Remisec` et `CoefTypeC`
  (phase 3, même lot que REMISEC-005 et COEFTYPEC-006) · appelants : aucun · tests : T01-T04 ·
  sources : [Remisecli.class:Quitte_Cdf](../../../../../.src/Gestion/Tables/Remisecli.class#L261-L285), [Remisecli.class:ToggleButton2_Click](../../../../../.src/Gestion/Tables/Remisecli.class#L196-L223), [Remisec.class:Quitte_Cdf](../../../../../.src/Gestion/Tables/Remisec.class#L223-L249)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] REMISECLI-A01 — [anomalie] Tri / filtre par famille inexistant : `Cdf_GotFocus`,
  `Cdf_Dblclick`, `Cdf_KeyPress` visent la zone de saisie `Cdf` (groupe `rem`, jamais levés) au
  lieu de l'en-tête `FA`, qui n'a aucun handler. Correction : les renommer `FA_GotFocus`,
  `FA_Dblclick`, `FA_KeyPress` (nouveau comportement visible) · tests : T06 · sources : [Remisecli.class:Cdf_GotFocus](../../../../../.src/Gestion/Tables/Remisecli.class#L440-L450), [Remisecli.class:Cdf_Dblclick](../../../../../.src/Gestion/Tables/Remisecli.class#L452-L461), [Remisecli.class:Cdf_KeyPress](../../../../../.src/Gestion/Tables/Remisecli.class#L463-L475)
- [ ] REMISECLI-A02 — [anomalie] `Deb2`/`Deb3` concatènent le filtre saisi dans le SQL entre
  guillemets doubles (`"` casse la requête ; sous SQLite, chaîne interprétée comme identifiant si
  une colonne porte ce nom). Correction : `like &1` paramétré · tests : T05, T07 · sources : [Remisecli.class:70](../../../../../.src/Gestion/Tables/Remisecli.class#L70), [Remisecli.class:76](../../../../../.src/Gestion/Tables/Remisecli.class#L76)
- [ ] REMISECLI-A03 — [anomalie] `Button3_Click` enregistre même si `Quitte_*` ont signalé un client
  ou une famille inexistants ou une remise invalide · tests : T03 · sources : [Remisecli.class:337](../../../../../.src/Gestion/Tables/Remisecli.class#L337), [Remisecli.class:340](../../../../../.src/Gestion/Tables/Remisecli.class#L340)
- [ ] REMISECLI-A04 — [anomalie] Repositionnement : `Button2_Click` appelle `Tabcli.MoveTo(skey, 0)`
  sans `Try` sur l'ancien numéro de ligne (dernière ligne supprimée → erreur probable, à
  confirmer) ; `Button3_Click` passe le code client comme numéro de ligne · tests : T01, T04 ·
  sources : [Remisecli.class:320](../../../../../.src/Gestion/Tables/Remisecli.class#L320), [Remisecli.class:347](../../../../../.src/Gestion/Tables/Remisecli.class#L347), [Remisecli.class:349](../../../../../.src/Gestion/Tables/Remisecli.class#L349)
