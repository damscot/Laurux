# gridvi — Rework

> Source : `.src/Utils/gridvi.class` · Message de commit (phase 4) : `reference/.src/Utils/gridvi.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 493 |
| Lignes de commentaire | 12 |
| Fonctions | 13 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 80 |
| Complexité max (fonction) | 25 (`bouton_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 493 | 80 | 25 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GRIDVI-001 — [documentation] En-tête de classe en français : rôle, tableau des types
  (`A`, `M`, `F`/`S`, `C`, `T`), disposition des 12 colonnes, sources de données ; commentaires `'''`
  sur `razcol`, `bouton_Click`, `code`, `dec` · appelants : aucun · tests : T01-T08 · sources : [gridvi.class:_new](../../../../.src/Utils/gridvi.class#L15-L93)
- [ ] GRIDVI-002 — [code mort] `bouton_Click` : supprimer `smoiscour`, `smoisprec`, `scle`, le
  premier calcul de `datesup` (ligne 149), le second `razcol` (ligne 118) et le test
  `IsNull($grdv[j, i].Text)` toujours faux après `razcol` ; variables `k` inutilisées de `requete`
  et `affdon`, `res` de `grdv_MouseUp` réutilisé · appelants : aucun · tests : T01-T06 · sources : [gridvi.class:bouton_Click](../../../../.src/Utils/gridvi.class#L96-L245), [gridvi.class:149](../../../../.src/Utils/gridvi.class#L149), [gridvi.class:118](../../../../.src/Utils/gridvi.class#L118), [gridvi.class:175-179](../../../../.src/Utils/gridvi.class#L175-L179)
- [ ] GRIDVI-003 — [complexité] `bouton_Click` : remplacer les deux `Select $stype` (12 couples
  `req`/`cond`) par une fonction privée `CritereStat(source)` qui produit le même SQL
  (CC 25 → ≤ 8 visé) · appelants : `Articles`, `Famille`, `Movr` (inchangés) · tests : T01-T04, T06, T08 · sources : [gridvi.class:bouton_Click](../../../../.src/Utils/gridvi.class#L96-L245)
- [ ] GRIDVI-004 — [commonalisation] `grdv_MouseUp` : factoriser les 4 requêtes `UNION ALL`
  identiques dans une fonction privée `DetailArticle(art, deb, fin) As Result` ; ajouter l'espace
  manquant avant `UNION ALL` (même résultat) · appelants : aucun · tests : T05 · sources : [gridvi.class:grdv_MouseUp](../../../../.src/Utils/gridvi.class#L332-L517), [gridvi.class:451-508](../../../../.src/Utils/gridvi.class#L451-L508)
- [ ] GRIDVI-005 — [réarchitecture] Noms de tables via `Cbase.Table("TabHisFac" …)` (11 tables,
  mapping identité, SQL inchangé) · appelants : aucun · tests : T01-T06 · sources : [gridvi.class:bouton_Click](../../../../.src/Utils/gridvi.class#L96-L245), [gridvi.class:grdv_MouseUp](../../../../.src/Utils/gridvi.class#L332-L517)
- [ ] GRIDVI-006 — [séparation traitement/GUI] Extraire `calcanne` et le calcul des bornes
  (`dateinf`, `datesup`, `d1`..`d6`) de `grdv_MouseUp` dans une fonction pure
  `BornesDetail(dteclec, dtepec, ideb, ifin) As Date[]` (Public pour gb.test) · appelants : aucun ·
  tests : T05, T07, T09 · sources : [gridvi.class:calcanne](../../../../.src/Utils/gridvi.class#L561-L574), [gridvi.class:368-402](../../../../.src/Utils/gridvi.class#L368-L402)
- [ ] GRIDVI-007 — [séparation traitement/GUI] `requete` et `affdon` : lecture SQL renvoyant les
  trois sommes (`Float[]`), écriture et formatage des cellules dans une routine GUI séparée ·
  appelants : aucun · tests : T01-T06 · sources : [gridvi.class:requete](../../../../.src/Utils/gridvi.class#L264-L279), [gridvi.class:affdon](../../../../.src/Utils/gridvi.class#L519-L559)
- [ ] GRIDVI-008 — [complexité] Désignations de la fenêtre de détail : remplacer les 2 requêtes par
  article (`Fiches_Art` puis `Fiches_Mo`) par une lecture groupée ou un cache local, même repli
  « INCONNU » · appelants : aucun · tests : T05, T10 · sources : [gridvi.class:436-442](../../../../.src/Utils/gridvi.class#L436-L442)
- [ ] GRIDVI-009 — [commonalisation] Après suppression de `gridvi2` et `gridv` (GRIDVI2-001,
  GRIDV-001) : extraire `affent` et le dessin des lignes de mois dans un helper partagé avec
  `Tregie.affent` (module à créer en phase 3, voir architecture.md) · appelants : `Tregie` ·
  tests : T07, replays de `Tregie` · sources : [gridvi.class:affent](../../../../.src/Utils/gridvi.class#L281-L311), [Tregie.class:affent](../../../../.src/Gestion/option/Tregie.class#L42-L99)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GRIDVI-A01 — [anomalie] Type `S` (sous-familles, défaut de `Famille`) : `LOCATE(&1, fam_…) = 1`
  n'est pas traduit pour SQLite (`bouton_Click:160,194`) → erreur SQL sur base SQLite ; correction
  proposée `fam_… LIKE CONCAT(&1, '%')` ou traduction dans `DB_Connection` · tests : T03, T08 · sources : [gridvi.class:160](../../../../.src/Utils/gridvi.class#L160), [gridvi.class:194](../../../../.src/Utils/gridvi.class#L194)
- [ ] GRIDVI-A02 — [anomalie] `bouton_Click:121` : retour anticipé si `Fiches_Parametres` est vide
  sans rétablir le curseur ni le titre « TABLEAU COMPARATIF ANNUEL » · tests : T01 · sources : [gridvi.class:121](../../../../.src/Utils/gridvi.class#L121)
- [ ] GRIDVI-A03 — [anomalie] `affdon:545-553` : la branche `margem` est inatteignable (filtre
  `IN ('A','M')`) ; les lignes de main d'œuvre du détail client cumulent `mrgart` au lieu de
  `mrgmo`, contrairement au tableau principal (`mrgart + mrgmo`) — à confirmer avec l'utilisateur ·
  tests : T05 · sources : [gridvi.class:545-553](../../../../.src/Utils/gridvi.class#L545-L553)
- [ ] GRIDVI-A04 — [anomalie] `grdv_MouseUp:368-369` : lecture de `res!dteclec` sans test
  `Available` (erreur si `Fiches_Parametres` est vide) ; `_new:26` réutilise l'onglet courant
  quand le `TabStrip` n'a qu'un onglet (titre écrasé) · tests : T05, T07 · sources : [gridvi.class:368-369](../../../../.src/Utils/gridvi.class#L368-L369), [gridvi.class:26](../../../../.src/Utils/gridvi.class#L26)
