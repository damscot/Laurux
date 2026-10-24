# RazArt — Rework

> Source : `.src/Utils/RazArt.class` · Message de commit (phase 4) : `reference/.src/Utils/RazArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 67 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 13 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 67 | 18 | 13 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZART-001 — [documentation] Documenter précisément les colonnes réellement modifiées par chaque
  case (écarts avec les libellés) · tests : aucun · sources : [RazArt.class:Button1_Click](../../../../.src/Utils/RazArt.class#L19-L72)
- [ ] RAZART-002 — [code mort] Supprimer les variables `pmp` affectées non lues et le handler vide
  `form_Open` · tests : T01-T03 · sources : [RazArt.class:form_Open](../../../../.src/Utils/RazArt.class#L9-L11), [RazArt.class:23](../../../../.src/Utils/RazArt.class#L23)
- [ ] RAZART-003 — [séparation traitement/GUI] Fonctions privées `RazStocks()`, `PmpEgalPrvt()`,
  `MarquerStocke(sVal)`, `RazCodesBarre(sFiltre)` sans contrôle · tests : T01-T06 · sources : [RazArt.class:Button1_Click](../../../../.src/Utils/RazArt.class#L19-L72)
- [ ] RAZART-004 — [commonalisation] `PmpEgalPrvt()` partagée avec `Papmp.run` (même boucle) ·
  appelants : `Prgm` (via `Papmp.run`, inchangé) · tests : T02, PAPMP-T01 · sources : [RazArt.class:34-41](../../../../.src/Utils/RazArt.class#L34-L41), [Papmp.class:run](../../../../.src/Utils/Papmp.class#L3-L23)
- [ ] RAZART-005 — [réarchitecture] `Cbase.Table` pour `Fiches_Art`/`Fiches_CdBarre` dans le bloc
  codes-barres ; `LIKE` paramétré par `&1` (même motif `%texte%`) · tests : T04, T05 · sources : [RazArt.class:57-62](../../../../.src/Utils/RazArt.class#L57-L62)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] RAZART-A01 — [anomalie] `Chk1` remet `art_stocke` à 0 au lieu de `art_qte` (libellé « stock
  réel ») · tests : T01 · sources : [RazArt.class:30](../../../../.src/Utils/RazArt.class#L30)
- [ ] RAZART-A02 — [anomalie] `Chk2` copie `art_prvt` (revient) alors que le libellé dit « Paht » ·
  tests : T02 · sources : [RazArt.class:39](../../../../.src/Utils/RazArt.class#L39)
- [ ] RAZART-A03 — [anomalie] Codes-barres : filtre « contient » au lieu de « commence par »
  annoncé ; `art_cbarre = " "` (espace) avec filtre et `""` sans filtre · tests : T04, T05 · sources : [RazArt.class:51](../../../../.src/Utils/RazArt.class#L51), [RazArt.class:57-61](../../../../.src/Utils/RazArt.class#L57-L61)
- [ ] RAZART-A04 — [anomalie] `Truncate Table` incompatible SQLite · tests : T07 · sources : [RazArt.class:62](../../../../.src/Utils/RazArt.class#L62)
- [ ] RAZART-A05 — [anomalie] « Non » à la 1ʳᵉ question affiche quand même « Traitement terminé » ;
  « Non » à la question codes-barres laisse le curseur en attente · tests : T06 · sources : [RazArt.class:25](../../../../.src/Utils/RazArt.class#L25), [RazArt.class:65](../../../../.src/Utils/RazArt.class#L65), [RazArt.class:70](../../../../.src/Utils/RazArt.class#L70)
