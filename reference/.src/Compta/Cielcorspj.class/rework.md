# Cielcorspj — Rework

> Source : `.src/Compta/Cielcorspj.class` · Message de commit (phase 4) : `reference/.src/Compta/Cielcorspj.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 192 |
| Lignes de commentaire | 45 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 8 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 192 | 47 | 8 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CIELCORSPJ-001 — [documentation] En-tête en français : rôle, table `Ciel_Lrx_Jo`,
  différences avec `Cielcorsp` (doublon Laurux autorisé) · appelants : aucun · tests : aucun ·
  sources : [Cielcorspj.class:_New](../../../../.src/Compta/Cielcorspj.class#L31-L64), [Cielcorspj.class:183-184](../../../../.src/Compta/Cielcorspj.class#L183-L184)
- [ ] CIELCORSPJ-002 — [code mort] Supprimer `ChkInput`, le second `Me.Center`, `params`, la
  ligne commentée de `Button1_Click` · appelants : aucun · tests : T01, T02 ·
  sources : [Cielcorspj.class:ChkInput](../../../../.src/Compta/Cielcorspj.class#L245-L253), [Cielcorspj.class:34](../../../../.src/Compta/Cielcorspj.class#L34), [Cielcorspj.class:40](../../../../.src/Compta/Cielcorspj.class#L40)
- [ ] CIELCORSPJ-003 — [commonalisation] Utiliser le module commun `CielCorresp` créé par
  CIELCORSP-003 (même commit), paramétré pour les journaux ; handlers et `.form` inchangés, SQL
  identique · appelants : aucun · tests : T01-T06, CIELCORSP-T01-T06 ·
  sources : [Cielcorspj.class:Button2_Click](../../../../.src/Compta/Cielcorspj.class#L171-L212), [Cielcorspj.class:Cpt_man](../../../../.src/Compta/Cielcorspj.class#L217-L243), [Cielcorsp.class:Button2_Click](../../../../.src/Compta/Cielcorsp.class#L177-L217)
- [ ] CIELCORSPJ-004 — [commonalisation] `Cbase.Table("TabJour")` pour `Fiches_Journaux` (SQL
  identique) · appelants : aucun · tests : T02, T05 ·
  sources : [Cielcorspj.class:73](../../../../.src/Compta/Cielcorspj.class#L73), [Cielcorspj.class:221](../../../../.src/Compta/Cielcorspj.class#L221)
- [ ] CIELCORSPJ-005 — [réduction de portée] `Cpt_man`, `Compte_delete` → `Private` ·
  appelants : aucun · tests : T02, T06 · sources : [Cielcorspj.class:Cpt_man](../../../../.src/Compta/Cielcorspj.class#L217-L243), [Cielcorspj.class:Compte_delete](../../../../.src/Compta/Cielcorspj.class#L276-L283)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CIELCORSPJ-A01 — [anomalie] Double-clic : correspondance supprimée en base dès la recopie
  dans les zones de saisie (même défaut que CIELCORSP-A01, à corriger ensemble) · tests : T06 ·
  sources : [Cielcorspj.class:Listecompte_Activate](../../../../.src/Compta/Cielcorspj.class#L267-L274)
