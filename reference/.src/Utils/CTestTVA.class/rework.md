# CTestTVA — Rework

> Source : `.src/Utils/CTestTVA.class` · Message de commit (phase 4) : `reference/.src/Utils/CTestTVA.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 7 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 6 (`isIntraComValide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 29 | 7 | 6 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CTESTTVA-001 — [documentation] Commentaires `'''` : formule de la clé, format attendu, limite
  au pays FR · tests : aucun · sources : [CTestTVA.class:CleTVAIntra](../../../../.src/Utils/CTestTVA.class#L6-L10), [CTestTVA.class:isIntraComValide](../../../../.src/Utils/CTestTVA.class#L13-L48)
- [ ] CTESTTVA-002 — [commonalisation] `isIntraComValide` réutilise `CleTVAIntra` · tests : T01, T03 · sources : [CTestTVA.class:44](../../../../.src/Utils/CTestTVA.class#L44)
- [ ] CTESTTVA-003 — [séparation traitement/GUI] `Message.Warning` déplacé hors du calcul (même
  message, même condition) · appelants : `Fsoc`, `FFournisseur` · tests : T03, T05 · sources : [CTestTVA.class:36-39](../../../../.src/Utils/CTestTVA.class#L36-L39)
- [ ] CTESTTVA-004 — [réarchitecture] Conversion en `.module` (membres statiques uniquement, appels
  inchangés) · appelants : `Fsoc`, `FFournisseur` (inchangés) · tests : T01-T05 · sources : [CTestTVA.class:CleTVAIntra](../../../../.src/Utils/CTestTVA.class#L6-L10), [CTestTVA.class:isIntraComValide](../../../../.src/Utils/CTestTVA.class#L13-L48)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CTESTTVA-A01 — [anomalie] Clé < 10 : `Fsoc` produit `FR5123456789` (clé sur un chiffre) ;
  formater la clé sur 2 chiffres (`Format$(clé, "00")`) · tests : T01, T05 · sources : [CTestTVA.class:CleTVAIntra](../../../../.src/Utils/CTestTVA.class#L6-L10), [Fsoc.class:307](../../../../.src/Communs/Fsoc.class#L307)
- [ ] CTESTTVA-A02 — [anomalie] SIREN non numérique dans `isIntraComValide` → erreur `CInt` non
  interceptée par les appelants · tests : T02, T03 · sources : [CTestTVA.class:44](../../../../.src/Utils/CTestTVA.class#L44)
- [ ] CTESTTVA-A03 — [anomalie] Comparaison chaîne/entier de la clé (`"05"` = 5) : à confirmer par
  T03 · tests : T03 · sources : [CTestTVA.class:45](../../../../.src/Utils/CTestTVA.class#L45)
