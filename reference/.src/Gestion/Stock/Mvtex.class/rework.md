# Mvtex — Rework

> Source : `.src/Gestion/Stock/Mvtex.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Mvtex.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 589 |
| Lignes de commentaire | 66 |
| Fonctions | 22 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 16 (`Enrgbl`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 589 | 97 | 16 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MVTEX-001 — [documentation] En-tête en français (le commentaire actuel cite
  « Receipt.class ») : rôle, tags des groupes `Rcpt`/`Btn`, tables écrites, place dans le calcul
  du stock (`Cstock`, `Stockmvt`), option boissons, défauts A01-A04 · appelants : aucun · tests :
  aucun · sources : [Mvtex.class:_New](../../../../../.src/Gestion/Stock/Mvtex.class#L40-L71), [Mvtex.class:Enrgbl](../../../../../.src/Gestion/Stock/Mvtex.class#L453-L548)
- [ ] MVTEX-002 — [code mort] Supprimer `Quantite` (jamais appelée), les membres `p`, `Tri`, `B`
  (écrit, jamais lu), l'affectation inutile `Tab2 = "Fiches_Tvaav"` et le second test
  `If res.Available` d'`Enrgbl` · appelants : aucun · tests : T01-T08 · sources : [Mvtex.class:Quantite](../../../../../.src/Gestion/Stock/Mvtex.class#L285-L307), [Mvtex.class:27-34](../../../../../.src/Gestion/Stock/Mvtex.class#L27-L34), [Mvtex.class:226](../../../../../.src/Gestion/Stock/Mvtex.class#L226), [Mvtex.class:486](../../../../../.src/Gestion/Stock/Mvtex.class#L486)
- [ ] MVTEX-003 — [complexité] Fonction privée `AjouteLigne()` pour le cas tag 1 de
  `Btn_KeyPress`/`Btn_Click` ; helper `EcritQte(qte)` pour les trois écritures entrée/sortie de
  `Maj_colrcp` (CC 15 → ≤ 9 visé) · appelants : aucun · tests : T01-T04 · sources : [Mvtex.class:Btn_KeyPress](../../../../../.src/Gestion/Stock/Mvtex.class#L156-L176), [Mvtex.class:Btn_Click](../../../../../.src/Gestion/Stock/Mvtex.class#L178-L207), [Mvtex.class:Maj_colrcp](../../../../../.src/Gestion/Stock/Mvtex.class#L340-L401)
- [ ] MVTEX-004 — [séparation traitement/GUI] `Enrgbl` : extraire
  `EnregistreMouvements(dte, lignes)` et `EnregistreRegie(dte, lignes, vignette)` sans accès aux
  contrôles (SQL et ordre identiques, verrous conservés), le handler gardant la lecture de la
  grille, `imprim` et `RazBl` · appelants : aucun · tests : T01-T07 · sources : [Mvtex.class:Enrgbl](../../../../../.src/Gestion/Stock/Mvtex.class#L453-L548), [Mvtex.class:Maj_qte](../../../../../.src/Gestion/Stock/Mvtex.class#L321-L329)
- [ ] MVTEX-005 — [réduction de portée] `CleanChamps`, `RazBl`, `art_man`, `SelectionArt`,
  `qterecue_LF`, `Maj_qte`, `Maj_colrcp`, `Enrgbl` → `Private` ; `Bsel`/`Bval` restent `Public`
  (`TriArticles`) · appelants : aucun · tests : T01-T08 · sources : [Mvtex.class:CleanChamps](../../../../../.src/Gestion/Stock/Mvtex.class#L76-L83), [Mvtex.class:RazBl](../../../../../.src/Gestion/Stock/Mvtex.class#L88-L94), [Mvtex.class:art_man](../../../../../.src/Gestion/Stock/Mvtex.class#L221-L258), [Mvtex.class:SelectionArt](../../../../../.src/Gestion/Stock/Mvtex.class#L260-L280), [Mvtex.class:qterecue_LF](../../../../../.src/Gestion/Stock/Mvtex.class#L312-L316), [Mvtex.class:Maj_qte](../../../../../.src/Gestion/Stock/Mvtex.class#L321-L329), [Mvtex.class:Maj_colrcp](../../../../../.src/Gestion/Stock/Mvtex.class#L340-L401), [Mvtex.class:Enrgbl](../../../../../.src/Gestion/Stock/Mvtex.class#L453-L548)
- [ ] MVTEX-006 — [réarchitecture] `Cbase.Table("TabArt")` et `Cbase.Table("TabMvtexp")` dans
  `art_man`, `Enrgbl` et `imprim` (y compris le texte des `LOCK TABLES`, noms identiques) ·
  appelants : aucun · tests : T01, T07 · sources : [Mvtex.class:art_man](../../../../../.src/Gestion/Stock/Mvtex.class#L221-L258), [Mvtex.class:465](../../../../../.src/Gestion/Stock/Mvtex.class#L465), [Mvtex.class:469](../../../../../.src/Gestion/Stock/Mvtex.class#L469)
- [ ] MVTEX-007 — [complexité] `imprim` : helper privé de création de cellule de rapport
  (texte, police, largeur, alignement, bordure), PDF identique · appelants : aucun · tests : T01,
  T07 · sources : [Mvtex.class:imprim](../../../../../.src/Gestion/Stock/Mvtex.class#L573-L747)
- [ ] MVTEX-008 — [commonalisation] Saisie d'article stocké (`art_man`, `CleanChamps`,
  `SelectionArt`, `*code-barre`) partagée avec `MvtProdcomp`, `MvtDepots`, `Sdepots` (phase 3,
  comportement identique par écran à prouver par leurs replays) · appelants : aucun · tests :
  T06, MVTPRODCOMP-T05, MVTDEPOTS-T04/T05 · sources : [Mvtex.class:art_man](../../../../../.src/Gestion/Stock/Mvtex.class#L221-L258), [MvtProdcomp.class:art_man](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L204-L243), [MvtDepots.class:art_man](../../../../../.src/Gestion/Depots/MvtDepots.class#L243-L295)
- [ ] MVTEX-009 — [commonalisation] Helper unique « vignette suivante » (`LOCK`, lecture, `UPDATE`
  de `nvign` sur 25 chiffres) pour `atvig` et `commande1.rececp_Click` (comportements identiques à
  conserver : `commande1` affiche le numéro avant validation) · appelants : `commande1` · tests :
  T07, COMMANDE1-T09 · sources : [Mvtex.class:atvig](../../../../../.src/Gestion/Stock/Mvtex.class#L550-L569), [commande1.class:778-803](../../../../../.src/Gestion/Stock/commande1.class#L778-L803)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MVTEX-A01 — [anomalie] `rcppt_keypress` (faute de frappe, groupe `Rcpt`) n'est jamais levé :
  F1 (aide) et F2 (sélection d'article) inopérants. Correction : renommer en `Rcpt_KeyPress`
  (nouveau comportement) ou supprimer (code mort), décision utilisateur · tests : T09 · sources : [Mvtex.class:rcppt_keypress](../../../../../.src/Gestion/Stock/Mvtex.class#L136-L151)
- [ ] MVTEX-A02 — [anomalie] `Enrgbl` sans transaction : `INSERT` des mouvements et mise à jour
  de `art_qte` non atomiques (verrous seulement, neutralisés sous SQLite) ; une erreur laisse
  une saisie partielle · tests : T01, T02 · sources : [Mvtex.class:465-477](../../../../../.src/Gestion/Stock/Mvtex.class#L465-L477)
- [ ] MVTEX-A03 — [anomalie, à confirmer] Option boissons : numéro de régie choisi hors verrou
  (concurrence entre postes) ; `LOCK TABLES` suivi de `Begin` (MySQL libère les verrous au
  `START TRANSACTION`) ; une seule vignette pour toutes les lignes à droits · tests : T07 ·
  sources : [Mvtex.class:493-497](../../../../../.src/Gestion/Stock/Mvtex.class#L493-L497), [Mvtex.class:504-505](../../../../../.src/Gestion/Stock/Mvtex.class#L504-L505), [Mvtex.class:533](../../../../../.src/Gestion/Stock/Mvtex.class#L533)
- [ ] MVTEX-A04 — [anomalie, à confirmer] `imprim` inverse le signe de la quantité par rapport à
  `Enrgbl` pour `Calculdroit` (volumes négatifs pour les entrées sur l'édition) · tests : T07 ·
  sources : [Mvtex.class:710-714](../../../../../.src/Gestion/Stock/Mvtex.class#L710-L714), [Mvtex.class:470-474](../../../../../.src/Gestion/Stock/Mvtex.class#L470-L474)
