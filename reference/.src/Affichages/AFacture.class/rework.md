# AFacture — Rework

> Source : `.src/Affichages/AFacture.class` · Message de commit (phase 4) : `reference/.src/Affichages/AFacture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 82 |
| Lignes de commentaire | 5 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 12 (`DocVentes`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 82 | 20 | 12 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] AFACTURE-001 — [documentation] En-tête : rôle (détail des lignes d'un document de vente, repli
  sur l'archive `Fiches_LigblM`), paramètres, appelants · appelants : aucun · tests : T01, T02 ·
  sources : [AFacture.class:_new](../../../../.src/Affichages/AFacture.class#L5-L15), [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88)
- [ ] AFACTURE-002 — [code mort] `DocVentes` : supprimer l'écriture de `Utils.CDec` en colonne 2
  (écrasée), le `Nlgf.Text` de la boucle, les lignes commentées, le `With Utils` ; un seul test
  d'Échap dans `Codecli_KeyPress` ; `Cbase.Table("TabLigblM")` au lieu du nom en dur (même SQL) ·
  appelants : aucun · tests : T01, T02 · sources : [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88), [AFacture.class:48](../../../../.src/Affichages/AFacture.class#L48), [AFacture.class:Codecli_KeyPress](../../../../.src/Affichages/AFacture.class#L90-L94)
- [ ] AFACTURE-003 — [réduction de portée] `DocVentes` → `Private` (aucun appelant externe, vérifié) · appelants : aucun · tests : T01 · sources : [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88)
- [ ] AFACTURE-004 — [séparation traitement/GUI] `LignesDocument(sNum) As Result` et
  `TotalLignes(…) As Float` ; `DocVentes` ne garde que l'affichage · appelants : aucun · tests : T01,
  T05 · sources : [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88)
- [ ] AFACTURE-005 — [commonalisation] Module commun `DetailDocument` (mise en page de `Colrcp3`,
  boucle des lignes de vente) partagé avec `TriHistos.DocVentes` et `ACom.DocCom` (voir
  TRIHISTOS-006) · appelants : `TriHistos`, `ACom` (même commit) · tests : T01, T04,
  TRIHISTOS-T03, ACOM-T01 · sources : [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88), [TriHistos.class:DocVentes](../../../../.src/Affichages/TriHistos.class#L492-L597), [ACom.class:DocCom](../../../../.src/Affichages/ACom.class#L18-L68)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] AFACTURE-A01 — [anomalie] Document sans ligne (ni dans `Fiches_Ligbl` ni dans
  `Fiches_LigblM`) : `Button3_Click` ferme la fenêtre mais `DocVentes` continue et lit
  `Rcli!typel_ligbl` sur un résultat vide (le `If Not Error` ne teste rien) → erreur, puis `ShowModal`
  de l'appelant sur une fenêtre fermée. Correction : `Return` après la fermeture et test
  `Available` · tests : T03 · sources : [AFacture.class:49](../../../../.src/Affichages/AFacture.class#L49), [AFacture.class:54](../../../../.src/Affichages/AFacture.class#L54), [AFacture.class:57](../../../../.src/Affichages/AFacture.class#L57)
- [ ] AFACTURE-A02 — [anomalie] Quantité non formatée : `Utils.CDec(art_dec, qte)` écrit en colonne
  2 puis écrasé par la désignation ; la colonne 3 reçoit la quantité brute (même défaut qu'`ACom` et
  `TriHistos`) · tests : T01 · sources : [AFacture.class:62](../../../../.src/Affichages/AFacture.class#L62), [AFacture.class:64](../../../../.src/Affichages/AFacture.class#L64)
