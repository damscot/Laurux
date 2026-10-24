# SetColors — Rework

> Source : `.src/Utils/SetColors.class` · Message de commit (phase 4) : `reference/.src/Utils/SetColors.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 1 |
| Fonctions | 12 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 9 (`Coul_DblClick`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 88 | 33 | 9 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SETCOLORS-001 — [documentation] En-tête en français : rôle, convention `Tag` = clé
  `/Coul/…`, correspondance onglets/panneaux, clés RVB dérivées lues par `Start.Coul` ·
  appelants : aucun · tests : T01-T05 · sources : [SetColors.class:Form_Open](../../../../.src/Utils/SetColors.class#L88-L95)
- [ ] SETCOLORS-002 — [complexité] `Button2_Click`/`Button3_Click` : table
  `[contrôle, clé, valeur]` parcourue en boucle, chaînes conservées à l'identique · appelants :
  aucun · tests : T04, T05 · sources : [SetColors.class:Button2_Click](../../../../.src/Utils/SetColors.class#L103-L116), [SetColors.class:Button3_Click](../../../../.src/Utils/SetColors.class#L118-L127)
- [ ] SETCOLORS-003 — [commonalisation] `Coul_DblClick` et `InitTxtB` : utiliser
  `CFormat.Applique` (CFORMAT-004) · appelants : aucun · tests : T01-T03 · sources : [SetColors.class:Coul_DblClick](../../../../.src/Utils/SetColors.class#L39-L66), [SetColors.class:InitTxtB](../../../../.src/Utils/SetColors.class#L68-L86)
- [ ] SETCOLORS-004 — [séparation traitement/GUI] Extraire `RVBTexte(couleur)` (pure, Public pour
  gb.test) et la correspondance `Tag → clé RVB` de `Coul_DblClick` · appelants : aucun ·
  tests : T03, T06 · sources : [SetColors.class:Coul_DblClick](../../../../.src/Utils/SetColors.class#L39-L66), [SetColors.class:57-63](../../../../.src/Utils/SetColors.class#L57-L63)
- [ ] SETCOLORS-005 — [commonalisation] Constantes de couleurs par défaut partagées avec
  `Start.module` et `Fmenu` (en conservant chaque chaîne exacte) · appelants : `Start`, `Fmenu` ·
  tests : T04, T05, replays de `Fmenu` · sources : [SetColors.class:Button2_Click](../../../../.src/Utils/SetColors.class#L103-L116), [Start.module:132-149](../../../../.src/Start.module#L132-L149), [Fmenu.class:437-450](../../../../.src/Communs/Fmenu.class#L437-L450)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SETCOLORS-A01 — [anomalie] `Button3_Click:120-125` : les triplets RVB enregistrés
  (`255;254;212`, `229;233;255`) ne correspondent pas aux fonds affichés (`&FFEE81&`, `&FFE0B8&`) ;
  et le format des valeurs diffère de `Start`/`Fmenu` (décimal au lieu de `&H…&`) · tests : T05 · sources : [SetColors.class:120-125](../../../../.src/Utils/SetColors.class#L120-L125)
- [ ] SETCOLORS-A02 — [anomalie] `Button2_Click`/`Button3_Click` n'appellent pas
  `Start.LocalSettings.Save` (contrairement à `Coul_DblClick`) : enregistrement différé à la
  sortie du programme, perdu en cas d'arrêt brutal (à confirmer) · tests : T04, T05 · sources : [SetColors.class:Button2_Click](../../../../.src/Utils/SetColors.class#L103-L116), [SetColors.class:Button3_Click](../../../../.src/Utils/SetColors.class#L118-L127)
