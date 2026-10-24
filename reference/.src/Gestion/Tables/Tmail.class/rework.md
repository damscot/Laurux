# Tmail — Rework

> Source : `.src/Gestion/Tables/Tmail.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Tmail.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 67 |
| Lignes de commentaire | 22 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 6 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 67 | 26 | 6 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TMAIL-001 — [documentation] En-tête complété : rôle (texte par défaut des courriels), lecteur
  `ObjFacB` et articulation avec ComMail (`Variables.sTexte`) · appelants : aucun · tests : aucun ·
  sources : [Tmail.class:21](../../../../../.src/Gestion/Tables/Tmail.class#L21)
- [ ] TMAIL-002 — [code mort] Supprimer `CleanChamps` (jamais appelée), `Lib_KeyPress` et
  `Lib_GotFocus` (groupe `Lib` absent), `Button3_Click` (handler inactif, bouton groupé `Btn`) ·
  appelants : aucun · tests : T01-T03 · sources : [Tmail.class:CleanChamps](../../../../../.src/Gestion/Tables/Tmail.class#L44-L48), [Tmail.class:Lib_KeyPress](../../../../../.src/Gestion/Tables/Tmail.class#L57-L73), [Tmail.class:Lib_GotFocus](../../../../../.src/Gestion/Tables/Tmail.class#L103-L107), [Tmail.class:Button3_Click](../../../../../.src/Gestion/Tables/Tmail.class#L126-L130)
- [ ] TMAIL-003 — [commonalisation] Fonctions « texte unique » partagées avec Tleg et LibelFac
  (voir TLEG-003) · appelants : aucun · tests : T01-T03 · sources : [Tmail.class:Form_Open](../../../../../.src/Gestion/Tables/Tmail.class#L35-L42), [Tmail.class:Button2_Click](../../../../../.src/Gestion/Tables/Tmail.class#L109-L124)
- [ ] TMAIL-004 — [séparation traitement/GUI] `EnregistreTmail(sTexte)` sans contrôle (si les
  fonctions communes ne sont pas retenues) · appelants : aucun · tests : T01-T03 · sources : [Tmail.class:Button2_Click](../../../../../.src/Gestion/Tables/Tmail.class#L109-L124)
- [ ] TMAIL-005 — [réduction de portée] `Refresh`, `Button2_Click`, `Button4_Click` → `Private` ·
  appelants : aucun · tests : T01-T03 · sources : [Tmail.class:Refresh](../../../../../.src/Gestion/Tables/Tmail.class#L50-L55), [Tmail.class:Button2_Click](../../../../../.src/Gestion/Tables/Tmail.class#L109-L124), [Tmail.class:Button4_Click](../../../../../.src/Gestion/Tables/Tmail.class#L132-L136)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TMAIL-A01 — [anomalie] Lecture de la première ligne mais écriture sur `lind = 1` (insertions
  invisibles si absente) ; le `Try` transforme une erreur SQL en `INSERT` · tests : T03 · sources : [Tmail.class:39](../../../../../.src/Gestion/Tables/Tmail.class#L39), [Tmail.class:115](../../../../../.src/Gestion/Tables/Tmail.class#L115)
- [ ] TMAIL-A02 — [anomalie] Texte vide non enregistrable ; `ReplaceLb` altère `"` et `&` ·
  tests : T02 · sources : [Tmail.class:113](../../../../../.src/Gestion/Tables/Tmail.class#L113)
