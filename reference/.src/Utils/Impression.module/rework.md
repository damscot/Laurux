# Impression — Rework

> Source : `.src/Utils/Impression.module` · Message de commit (phase 4) : `reference/.src/Utils/Impression.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 44 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 7 (`Facture`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 44 | 11 | 7 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPRESSION-001 — [documentation] Commentaires : clés de réglage lues par chaque fonction
  (caisse vs globales), effet de `/choiximp2` · appelants : aucun · tests : aucun · sources : [Impression.module:Ticket](../../../../.src/Utils/Impression.module#L3-L24), [Impression.module:Facture](../../../../.src/Utils/Impression.module#L27-L57)
- [ ] IMPRESSION-002 — [code mort] Supprimer les `Shell "cd " & User.Home` sans effet et la
  construction de commande inutilisée de la branche `/choiximp2` ; fonctions déclarées `Sub` ·
  appelants : aucun changement de code · tests : T01, T02 · sources : [Impression.module:7](../../../../.src/Utils/Impression.module#L7), [Impression.module:32](../../../../.src/Utils/Impression.module#L32), [Impression.module:42-43](../../../../.src/Utils/Impression.module#L42-L43)
- [ ] IMPRESSION-003 — [commonalisation] Helper privé de construction de la commande
  (`<cmd> [-P imprimante] [-# nb] fichier`) partagé par `Ticket` et `Facture`, commandes identiques ·
  appelants : aucun · tests : T01, T02, T03 · sources : [Impression.module:Ticket](../../../../.src/Utils/Impression.module#L3-L24), [Impression.module:Facture](../../../../.src/Utils/Impression.module#L27-L57)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] IMPRESSION-A01 — [anomalie, à confirmer] `Facture` lit `/FACpdf`, `/CmdImp`, `/choiximp2`,
  `/Cimp` en clés globales alors que `Caisse/Preferences` les enregistre sous `/Soc<XX>/caisse/` : les
  préférences d'impression des factures saisies en caisse sont ignorées · appelants : `Caisse`,
  `Facturergbl`, `EdPrep`, `ObjFacB` · tests : T02 · sources : [Impression.module:33-48](../../../../.src/Utils/Impression.module#L33-L48)
- [ ] IMPRESSION-A02 — [anomalie, à confirmer] `/choiximp2` activé : la facture n'est jamais
  imprimée (commande construite mais non lancée) · tests : T02 · sources : [Impression.module:42-43](../../../../.src/Utils/Impression.module#L42-L43)
- [ ] IMPRESSION-A03 — [anomalie] `Bordrx.class:383` appelle `Impression.Prog_Editeur` (inexistante)
  avec `Start.Soc` (inexistant) : erreur à l'exécution ; correction attendue dans `Bordrx`
  (`Editeur.Prog_Editeur`, `Start.Societe`) · tests : replay `Bordrx` · sources : [Bordrx.class:383](../../../../.src/Gestion/Lcr/Bordrx.class#L383)
