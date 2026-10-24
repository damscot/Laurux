# Tleg — Rework

> Source : `.src/Gestion/Tables/Tleg.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Tleg.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 67 |
| Lignes de commentaire | 22 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 23 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 67 | 23 | 6 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TLEG-001 — [documentation] En-tête corrigé (« Comment.class » → Tleg), rôle (réserve de
  propriété sur les factures), lecteurs (`ObjFac`, `Facturergbl`) · appelants : aucun · tests :
  aucun · sources : [Tleg.class:21](../../../../../.src/Gestion/Tables/Tleg.class#L21)
- [ ] TLEG-002 — [code mort] Supprimer `CleanChamps` (jamais appelée), `Lib_KeyPress` et
  `Lib_GotFocus` (groupe `Lib` absent du `.form`), `Button3_Click` (handler inactif, bouton groupé
  `Btn`) · appelants : aucun · tests : T01-T03 · sources : [Tleg.class:CleanChamps](../../../../../.src/Gestion/Tables/Tleg.class#L44-L48), [Tleg.class:Lib_KeyPress](../../../../../.src/Gestion/Tables/Tleg.class#L57-L73), [Tleg.class:Lib_GotFocus](../../../../../.src/Gestion/Tables/Tleg.class#L103-L107), [Tleg.class:Button3_Click](../../../../../.src/Gestion/Tables/Tleg.class#L126-L130)
- [ ] TLEG-003 — [commonalisation] `LitTexteUnique`/`EcritTexteUnique` partagés avec Tmail et
  LibelFac (SQL inchangé) · appelants : aucun · tests : T01-T03, TMAIL-T01-T03, LIBELFAC-T01-T03 ·
  sources : [Tleg.class:Form_Open](../../../../../.src/Gestion/Tables/Tleg.class#L35-L42), [Tleg.class:Button2_Click](../../../../../.src/Gestion/Tables/Tleg.class#L109-L124), [Tmail.class:Button2_Click](../../../../../.src/Gestion/Tables/Tmail.class#L109-L124), [LibelFac.class:Button2_Click](../../../../../.src/Gestion/Tables/LibelFac.class#L66-L82)
- [ ] TLEG-004 — [séparation traitement/GUI] `EnregistreTleg(sTexte)` sans contrôle (si les
  fonctions communes ne sont pas retenues) · appelants : aucun · tests : T01-T03 · sources : [Tleg.class:Button2_Click](../../../../../.src/Gestion/Tables/Tleg.class#L109-L124)
- [ ] TLEG-005 — [réduction de portée] `Refresh`, `Button2_Click`, `Button4_Click` → `Private` ·
  appelants : aucun · tests : T01-T03 · sources : [Tleg.class:Refresh](../../../../../.src/Gestion/Tables/Tleg.class#L50-L55), [Tleg.class:Button2_Click](../../../../../.src/Gestion/Tables/Tleg.class#L109-L124), [Tleg.class:Button4_Click](../../../../../.src/Gestion/Tables/Tleg.class#L132-L136)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TLEG-A01 — [anomalie] Lecture de la première ligne sans `WHERE` mais écriture sur `lind = 1` :
  si cette ligne n'existe pas, chaque enregistrement insère une ligne invisible (écran et
  factures inchangés) · tests : T03 · sources : [Tleg.class:39](../../../../../.src/Gestion/Tables/Tleg.class#L39), [Tleg.class:115](../../../../../.src/Gestion/Tables/Tleg.class#L115)
- [ ] TLEG-A02 — [anomalie] Impossible d'enregistrer un texte vide (la mention ne peut pas être
  supprimée) ; `ReplaceLb` altère `"` et `&` · tests : T01, T02 · sources : [Tleg.class:113](../../../../../.src/Gestion/Tables/Tleg.class#L113), [Tleg.class:114](../../../../../.src/Gestion/Tables/Tleg.class#L114)
- [ ] TLEG-A03 — [anomalie] L'aide ouvre la page `Commentaires` · tests : aucun · sources : [Tleg.class:134](../../../../../.src/Gestion/Tables/Tleg.class#L134)
