# ACom — Rework

> Source : `.src/Affichages/ACom.class` · Message de commit (phase 4) : `reference/.src/Affichages/ACom.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 65 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 6 (`DocCom`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 65 | 14 | 6 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ACOM-001 — [documentation] En-tête : rôle (détail d'une commande fournisseur), signification
  des paramètres du constructeur et des contrôles nommés « client »/« facture » hérités d'`AFacture` ·
  appelants : aucun · tests : T01 · sources : [ACom.class:_new](../../../../.src/Affichages/ACom.class#L5-L16)
- [ ] ACOM-002 — [code mort] `DocCom` : supprimer l'écriture de `Utils.CDec` en colonne 2 (écrasée),
  le `Nlgf.Text` de la boucle, le `If Not Error` sans `Try`, le `With Utils` ; `Codecli_KeyPress` :
  un seul test d'Échap · appelants : aucun · tests : T01, T03 · sources : [ACom.class:DocCom](../../../../.src/Affichages/ACom.class#L18-L68), [ACom.class:Codecli_KeyPress](../../../../.src/Affichages/ACom.class#L70-L74)
- [ ] ACOM-003 — [réduction de portée] `DocCom` → `Private` (aucun appelant externe, vérifié) · appelants : aucun · tests : T01 · sources : [ACom.class:DocCom](../../../../.src/Affichages/ACom.class#L18-L68)
- [ ] ACOM-004 — [séparation traitement/GUI] `LignesCommande(sNum, sFour) As Result` et
  `NomFournisseur(sFour) As String` ; `DocCom` n'affiche plus que le résultat · appelants : aucun ·
  tests : T01, T04 · sources : [ACom.class:DocCom](../../../../.src/Affichages/ACom.class#L18-L68)
- [ ] ACOM-005 — [commonalisation] Mise en page de `Colrcp3` et boucle de lignes vers le module
  `DetailDocument` partagé avec `AFacture` et `TriHistos` (voir TRIHISTOS-006) · appelants :
  `AFacture`, `TriHistos` (même commit) · tests : T01, AFACTURE-T01, TRIHISTOS-T03 · sources : [ACom.class:DocCom](../../../../.src/Affichages/ACom.class#L18-L68), [AFacture.class:DocVentes](../../../../.src/Affichages/AFacture.class#L17-L88)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ACOM-A01 — [anomalie] `DocCom` lit `Rcli!fo_nom` sans tester `Available` (fournisseur supprimé
  → erreur, alors que la liste de l'appelant utilise une jointure externe) et parcourt les lignes sans
  test `Available` (le `If Not Error` ne teste rien) · tests : T02 · sources : [ACom.class:45](../../../../.src/Affichages/ACom.class#L45), [ACom.class:47](../../../../.src/Affichages/ACom.class#L47)
- [ ] ACOM-A02 — [anomalie] Quantité non formatée : `Utils.CDec(art_dec, qte)` est écrit en colonne
  2 puis écrasé par la désignation ; la colonne 3 reçoit la quantité brute (même défaut
  qu'`AFacture` et `TriHistos`) · tests : T01 · sources : [ACom.class:53](../../../../.src/Affichages/ACom.class#L53), [ACom.class:55](../../../../.src/Affichages/ACom.class#L55)
