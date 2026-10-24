# Csolde — Rework

> Source : `.src/Utils/Csolde.module` · Message de commit (phase 4) : `reference/.src/Utils/Csolde.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 53 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 3 (`Recalc_solde`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 53 | 6 | 3 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CSOLDE-001 — [documentation] Commentaires : écritures prises en compte (`Fiches_Mvt`,
  `validee = 1`), table mise à jour, coût de `Recalc_solde` · appelants : aucun · tests : aucun · sources : [Csolde.module:Recalc_solde](../../../../.src/Utils/Csolde.module#L11-L28), [Csolde.module:Solde_caisse](../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] CSOLDE-002 — [code mort] Supprimer `TotSldHP` et passer `TotDeb`, `TotCred`, `TotSld`,
  `debit`, `credit`, `Compt` en variables locales (même cumul, même ordre) · appelants : aucun ·
  tests : T01, T02 · sources : [Csolde.module:3-9](../../../../.src/Utils/Csolde.module#L3-L9), [Csolde.module:Solde_caisse](../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] CSOLDE-003 — [complexité] `Solde_caisse` : `SELECT montantd, montantc`, idiome
  `Repeat … Until MoveNext()`, `Cbase.Table("TabMvt")`/`("TabComptes")`, suppression du `With Utils`
  (`Utils.PointBase` explicite) ; une seule instruction `UPdate` · appelants : aucun · tests : T01, T02 · sources : [Csolde.module:Solde_caisse](../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] CSOLDE-004 — [commonalisation] Après accord sur T03 : `Csolde` devient l'implémentation unique
  du recalcul de solde, `Recalcsolde.Calc` l'appelle (ou est supprimé s'il est confirmé mort) ·
  appelants : `Recalcsolde.module` · tests : T01-T03 · sources : [Csolde.module:Recalc_solde](../../../../.src/Utils/Csolde.module#L11-L28), [Recalcsolde.module:Calc](../../../../.src/Compta/Utils/Recalcsolde.module#L13-L57), [Calcsolde.class:Calcul](../../../../.src/Utils/Calcsolde.class#L97-L129)
