# LScript — Rework

> Source : `.src/Utils/LScript.class` · Message de commit (phase 4) : `reference/.src/Utils/LScript.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 3 |
| Fonctions | 6 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 8 (`Run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 88 | 20 | 8 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LSCRIPT-001 — [documentation] En-tête : rôle, modes shell/exec, programmes spéciaux
  `debug`/`debug2`, sémantique du code de retour (erreur de lancement, pas code de sortie) ·
  appelants : aucun · tests : aucun · sources : [LScript.class:Run](../../../../.src/Utils/LScript.class#L28-L60)
- [ ] LSCRIPT-002 — [code mort] Supprimer `Internal_Test` une fois converti en gb.test (phase 2) et
  retirer `LScript` de `Load_Classes` dans `Start.Start_Test` · appelants : `Start.module` · tests : T01 à T08 · sources : [LScript.class:Internal_Test](../../../../.src/Utils/LScript.class#L90-L134)
- [ ] LSCRIPT-003 — [code mort] Supprimer `Inherits Array` (aucun usage indexé, vérifié par grep) ·
  appelants : aucun · tests : tous · sources : [LScript.class:3](../../../../.src/Utils/LScript.class#L3)
- [ ] LSCRIPT-004 — [séparation traitement/GUI] `TexteArguments()` pur utilisé par `Show` (même texte) ·
  appelants : aucun · tests : T06 · sources : [LScript.class:Show](../../../../.src/Utils/LScript.class#L75-L86)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LSCRIPT-A01 — [anomalie] `Run` ignore le code de sortie du programme (`/bin/false` → succès) ;
  `RunA` poursuit donc après un échec réel · tests : T03, T05 · sources : [LScript.class:Run](../../../../.src/Utils/LScript.class#L28-L60), [LScript.class:RunA](../../../../.src/Utils/LScript.class#L62-L72)
- [ ] LSCRIPT-A02 — [anomalie] `Run` modifie `$arguments` (tableau de l'appelant) : un second `Run`
  insère le programme deux fois · tests : T07 · sources : [LScript.class:42](../../../../.src/Utils/LScript.class#L42)
- [ ] LSCRIPT-A03 — [anomalie] Mode shell : arguments joints sans quotage (espaces, métacaractères) ·
  tests : T04 · sources : [LScript.class:45](../../../../.src/Utils/LScript.class#L45)
