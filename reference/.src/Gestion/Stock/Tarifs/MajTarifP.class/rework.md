# MajTarifP — Rework

> Source : `.src/Gestion/Stock/Tarifs/MajTarifP.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/MajTarifP.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 350 |
| Lignes de commentaire | 44 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 112 |
| Complexité max (fonction) | 31 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 350 | 112 | 31 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJTARIFP-001 — [documentation] En-tête de classe en français : rôle, modes brut/net,
  ordre de la chaîne de calcul, variables de module ; commentaires `'''` sur les fonctions de
  calcul · appelants : aucun · tests : T01, T02 · sources : [MajTarifP.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L183-L263)
- [ ] MAJTARIFP-002 — [code mort] Supprimer `Prix_achat` (jamais appelée) et `Calc_Marge`
  (résultats jamais lus) avec les variables `Margem`, `Margep`, `Stocke` ; sans changement SQL ·
  appelants : aucun · tests : T01, T02 · sources : [MajTarifP.class:Prix_achat](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L320-L343), [MajTarifP.class:Calc_Marge](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L376-L389)
- [ ] MAJTARIFP-003 — [réduction de portée] `ChkPrx`, `fourMan`, `prix_base`, `PvTTcLF`, `TrC`,
  `Prix_achat`, `rTva`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`,
  `Maj_Etiqp`, `Maj_Etiqg` → `Private` (couverts par T01-T03) · appelants : aucun · tests : T01-T03 ·
  sources : [MajTarifP.class:ChkPrx](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L87-L95), [MajTarifP.class:Maj_Etiqg](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L466-L476)
- [ ] MAJTARIFP-004 — [commonalisation] Fonctions identiques à `MajFbtarif2` (`TrC`, `rTva`,
  `Tva_Calcul`, `PvTTC_arrondi`, `Calc_coeff`, `PvTTcLF`) déplacées dans `LTarifCalc`
  (MAJFBTARIF2-004, même lot) ; `prix_base` et `Calc_Percent` restent locales · appelants : aucun ·
  tests : T01, T02, T07 · sources : [MajTarifP.class:TrC](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L304-L318), [MajTarifP.class:PvTTcLF](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L292-L299), [MajFbtarif2.class:TrC](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L146-L160)
- [ ] MAJTARIFP-005 — [complexité] `Button2_Click` : partie commune des deux boucles (étiquettes,
  exports serveur) dans une procédure privée `MajEtiquettesExport(rArt)` ; même ordre de requêtes ;
  CC 31 → ≤ 12 · appelants : aucun · tests : T01, T02 · sources : [MajTarifP.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L183-L263)
- [ ] MAJTARIFP-006 — [commonalisation] `Maj_Etiqp`/`Maj_Etiqg` via le module `EtiqMaj`
  (MAJFBTARIF2-005, variante « gondole sans mise à jour ») ; garde d'export → `Serveur.Actif`
  (SERVEUR-008) · appelants : aucun · tests : T01, T02 · sources : [MajTarifP.class:Maj_Etiqp](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L452-L464), [MajTarifP.class:Maj_Etiqg](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L466-L476)
- [ ] MAJTARIFP-007 — [séparation traitement/GUI] Fonction `AppliquePourcentage(sFour, fPct,
  bBrut) As Integer` extraite de `Button2_Click` ; le handler garde messages, souris, son et
  question d'impression · appelants : aucun · tests : T01, T02, T05 · sources : [MajTarifP.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L183-L263)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJTARIFP-A01 — [anomalie] `arr` n'est jamais affecté : `PvTTC_arrondi` n'applique pas
  l'arrondi `art_cdarr` (même défaut que MAJFBTARIF2-A03) · tests : T02 · sources : [MajTarifP.class:PvTTC_arrondi](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L394-L431)
- [ ] MAJTARIFP-A02 — [anomalie] `Button2_KeyPress` lance la mise à jour pour toute touche, y
  compris Tab ou Échap, sans confirmation · tests : T04 · sources : [MajTarifP.class:Button2_KeyPress](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L81-L85)
- [ ] MAJTARIFP-A03 — [anomalie] `Button2_Click` sans `Catch` : une erreur SQL pendant la boucle
  laisse `LOCK TABLES` actif ; fournisseur vide accepté (articles sans fournisseur) · tests : T05 ·
  sources : [MajTarifP.class:189](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L189), [MajTarifP.class:192](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L192)
- [ ] MAJTARIFP-A04 — [anomalie] `Button4_Click` lit `Rfour` sans tester `Available` : erreur si
  aucun fournisseur · tests : T03 · sources : [MajTarifP.class:Button4_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L127-L152)
