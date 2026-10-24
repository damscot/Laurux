# LDateC — Rework

> Source : `.src/Utils/LDateC.class` · Message de commit (phase 4) : `reference/.src/Utils/LDateC.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 30 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 3 (`Select`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 30 | 7 | 3 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LDATEC-001 — [documentation] En-tête : rôle, contrat de `Select` (objet modifié si
  `update`, objet inchangé si annulation) · appelants : aucun · tests : T01-T03 · sources : [LDateC.class:Select](../../../../.src/Utils/LDateC.class#L14-L33)
- [ ] LDATEC-002 — [code mort] Supprimer le constructeur commenté et la variable intermédiaire
  `newdate` · appelants : aucun · tests : T01 · sources : [LDateC.class:9-11](../../../../.src/Utils/LDateC.class#L9-L11), [LDateC.class:Select](../../../../.src/Utils/LDateC.class#L14-L33)
- [ ] LDATEC-003 — [complexité] Réinitialiser `Escape = False` en tête de `Select` (sans effet
  visible si l'auto-instance est détruite à la fermeture, ce que T02 vérifie) · appelants :
  `TextReg` (inchangé) · tests : T02 · sources : [LDateC.class:Select](../../../../.src/Utils/LDateC.class#L14-L33)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LDATEC-A01 — [anomalie] Le sélecteur s'ouvre en mode date-heure même pour un champ date
  seule (`TextReg` ne passe pas `mode`) ; correction dans `TextReg` (passer `DateChooser.Date`) ·
  appelants : `TextReg` · tests : T01 · sources : [TextReg.class:144](../../../../.src/Utils/TextReg.class#L144), [LDateC.class:14](../../../../.src/Utils/LDateC.class#L14)
