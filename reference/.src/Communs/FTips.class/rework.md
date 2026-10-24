# FTips — Rework

> Source : `.src/Communs/FTips.class` · Message de commit (phase 4) : `reference/.src/Communs/FTips.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 87 |
| Lignes de commentaire | 5 |
| Fonctions | 11 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 8 (`GetNextTip`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 87 | 22 | 8 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FTIPS-001 — [documentation] En-tête en français (format de `tips/tips.fr`, clés `/LastTip` et
  `/Tips`, membres statiques partagés) · appelants : aucun · tests : aucun · sources : [FTips.class:_init](../../../../.src/Communs/FTips.class#L24-L38), [FTips.class:_new](../../../../.src/Communs/FTips.class#L40-L57)
- [ ] FTIPS-002 — [code mort] Supprimer le calcul inutilisé de `/Coul/Btns` dans `_new` · appelants :
  aucun · tests : T01 · sources : [FTips.class:48](../../../../.src/Communs/FTips.class#L48)
- [ ] FTIPS-003 — [séparation traitement/GUI] Fonctions statiques pures `IndiceSuivant(i, n, bPrev)`
  et `TexteAstuce(sContenu, sNom)` ; `GetNextTip` garde la lecture et le `Message.Error` ·
  appelants : aucun · tests : T01, T02, T04, T05 · sources : [FTips.class:GetNextTip](../../../../.src/Communs/FTips.class#L66-L103)
- [ ] FTIPS-004 — [complexité] Charger le contenu du fichier une seule fois dans `_init` (fermeture
  explicite du fichier) au lieu de `File.Load` à chaque astuce · appelants : aucun · tests : T01,
  T02 · sources : [FTips.class:_init](../../../../.src/Communs/FTips.class#L24-L38), [FTips.class:86](../../../../.src/Communs/FTips.class#L86)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FTIPS-A01 — [anomalie] `_init` sans gestion d'erreur : `tips/tips.fr` absent ou illisible →
  erreur au chargement de la classe, au démarrage de l'application · tests : manuel · sources : [FTips.class:29](../../../../.src/Communs/FTips.class#L29)
- [ ] FTIPS-A02 — [anomalie] `/LastTip` supérieur au nombre d'astuces : « Précédent » sort du tableau
  (message d'erreur au lieu de revenir dans les bornes) · tests : T04 · sources : [FTips.class:73-75](../../../../.src/Communs/FTips.class#L73-L75), [FTips.class:87](../../../../.src/Communs/FTips.class#L87)
