# MvtProdcomp — Rework

> Source : `.src/Gestion/Stock/MvtProdcomp.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/MvtProdcomp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 408 |
| Lignes de commentaire | 78 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 14 (`Rcpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 408 | 89 | 14 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MVTPRODCOMP-001 — [documentation] En-tête en français (l'actuel cite « Receipt.class »,
  « Régularisation du stock ») : écriture immédiate à chaque saisie, rôle de `Num`/`mind`, sens
  des mouvements produit/composants, tables lues par `Cstock`/`Stockmvt`, défauts A01-A05 ·
  appelants : aucun · tests : aucun · sources : [MvtProdcomp.class:_New](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L35-L58), [MvtProdcomp.class:Maj_colrcp](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L439-L494)
- [ ] MVTPRODCOMP-002 — [code mort] Supprimer `RazBl` (jamais appelée ; son `Comment.clear` vise
  l'auto-instance du formulaire `Comment`, sans méthode `Clear`), `Quantite`, le membre `B` et
  l'affectation inutile `Tab2` · appelants : aucun · tests : T01-T08 · sources : [MvtProdcomp.class:RazBl](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L75-L81), [MvtProdcomp.class:78](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L78), [MvtProdcomp.class:Quantite](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L351-L373), [MvtProdcomp.class:209](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L209)
- [ ] MVTPRODCOMP-003 — [complexité] Fusionner `Maj_qte`/`Maj_qtem` (signe en paramètre) et
  `Maj_qtec`/`Maj_qtemc` (SQL identiques) · appelants : aucun · tests : T01-T04 · sources : [MvtProdcomp.class:Maj_qte](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L396-L409), [MvtProdcomp.class:Maj_qtem](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L414-L428), [MvtProdcomp.class:Maj_qtec](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L534-L550), [MvtProdcomp.class:Maj_qtemc](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L555-L571)
- [ ] MVTPRODCOMP-004 — [séparation traitement/GUI] Fonction `EnregistreLot(code, q, entree,
  dte, num, stockAffiche)` sans accès aux contrôles, reproduisant les écritures actuelles (mêmes
  requêtes, même ordre) ; `Maj_colrcp` garde la grille et le `Catch` · appelants : aucun ·
  tests : T01, T02, T08 · sources : [MvtProdcomp.class:Maj_colrcp](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L439-L494), [MvtProdcomp.class:Maj_Composants](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L499-L529)
- [ ] MVTPRODCOMP-005 — [complexité] `Maj_Composants` : lire `qte` dans `Cmpts` au lieu de
  relire la ligne (`rPrdc`) — SQL modifié (un `SELECT` de moins par composant), dump identique ·
  appelants : aucun · tests : T01, T02 · sources : [MvtProdcomp.class:513-514](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L513-L514)
- [ ] MVTPRODCOMP-006 — [réduction de portée] `CleanChamps`, `art_man`, `SelectionArt`,
  `qterecue_LF`, `Maj_qte`, `Maj_qtem`, `Maj_colrcp`, `Maj_Composants`, `Maj_qtec`, `Maj_qtemc` →
  `Private` ; `Colart_Click` et les handlers restent `Public` (rejeu) · appelants : aucun ·
  tests : T01-T08 · sources : [MvtProdcomp.class:CleanChamps](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L63-L70), [MvtProdcomp.class:art_man](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L204-L243), [MvtProdcomp.class:SelectionArt](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L248-L304), [MvtProdcomp.class:qterecue_LF](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L378-L391), [MvtProdcomp.class:Maj_colrcp](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L439-L494), [MvtProdcomp.class:Maj_Composants](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L499-L529)
- [ ] MVTPRODCOMP-007 — [réarchitecture] `Cbase.Table("TabArt")` dans `art_man`, `SelectionArt`
  (`Tab = "Fiches_Art"`), nom physique identique · appelants : aucun · tests : T05, T06 ·
  sources : [MvtProdcomp.class:208](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L208), [MvtProdcomp.class:252](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L252)
- [ ] MVTPRODCOMP-008 — [commonalisation] Saisie d'article stocké commune avec `Mvtex`,
  `MvtDepots`, `Sdepots` (voir MVTEX-008, à faire dans le même lot de phase 3) · appelants :
  aucun · tests : T05, MVTEX-T06 · sources : [MvtProdcomp.class:art_man](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L204-L243), [Mvtex.class:art_man](../../../../../.src/Gestion/Stock/Mvtex.class#L221-L258)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MVTPRODCOMP-A01 — [anomalie] Ressaisie « cumuler » : stock du produit augmenté (même en
  sortie, `Maj_qte` toujours en plus) sans ligne `Fiches_Mvtexpdc` ni mise à jour des composants
  → stock et historique divergents (`Cstock` recalculera autre chose) · tests : T03 · sources : [MvtProdcomp.class:466-478](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L466-L478)
- [ ] MVTPRODCOMP-A02 — [anomalie] Ressaisie « remplacer » : le retrait de l'ancienne quantité
  (`Artstock -= …`) est écrasé par `Maj_qte`, qui relit la base : stock compté deux fois, ni
  mouvement ni composants · tests : T04 · sources : [MvtProdcomp.class:480-490](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L480-L490)
- [ ] MVTPRODCOMP-A03 — [anomalie] Le `Catch` de `Maj_colrcp` traite toute erreur comme un
  doublon ; un produit sans composant (ou un article simple) fait échouer `Maj_Composants`
  (`Repeat` sans `Available`) après l'écriture du stock et de la ligne `P` → écritures partielles
  et question trompeuse. Aucune transaction · tests : T05 · sources : [MvtProdcomp.class:Maj_colrcp](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L439-L494), [MvtProdcomp.class:511-512](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L511-L512)
- [ ] MVTPRODCOMP-A04 — [anomalie, à confirmer] `Maj_qtec`/`Maj_qtemc` : `UPdate Fiches_Mvtexpdc
  SET qtep|qtem = <stock total>` exécuté avant l'`INSERT` du mouvement ; sans effet normalement,
  mais corrompt un mouvement `(Num, Codec)` existant (lot concurrent) · tests : T01 · sources : [MvtProdcomp.class:546](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L546), [MvtProdcomp.class:567](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L567)
- [ ] MVTPRODCOMP-A05 — [anomalie] `Num` = `MAX(mind)` lu à l'ouverture puis incrémenté
  localement : deux postes ouverts en même temps produisent des lots de même `mind` ; `art_qte`
  est écrit avec une valeur calculée côté client (lecture-modification-écriture non atomique) ·
  tests : T08 · sources : [MvtProdcomp.class:54-56](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L54-L56), [MvtProdcomp.class:453](../../../../../.src/Gestion/Stock/MvtProdcomp.class#L453)
