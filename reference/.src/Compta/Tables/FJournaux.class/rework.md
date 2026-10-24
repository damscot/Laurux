# FJournaux — Rework

> Source : `.src/Compta/Tables/FJournaux.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FJournaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 275 |
| Lignes de commentaire | 50 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 13 (`Jo_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 275 | 71 | 13 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FJOURNAUX-001 — [documentation] En-tête en français : table gérée, règles (code numérique,
  compte obligatoire pour `TR`), stockage de type et compte dans `Item[2]`/`Item[3]` · appelants :
  aucun · tests : aucun · sources : [FJournaux.class:_New](../../../../../.src/Compta/Tables/FJournaux.class#L30-L42), [FJournaux.class:Form_Open](../../../../../.src/Compta/Tables/FJournaux.class#L44-L62)
- [ ] FJOURNAUX-002 — [code mort] Supprimer `Cleanchamps`, le `Else` vide de `Form_Open`,
  l'affectation `b = 1` redondante de `Jo_KeyPress`, l'affectation `b = 0` écrasée de `cptman` et le
  paramètre `0` inutilisé de `Button4_Click` (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [FJournaux.class:Cleanchamps](../../../../../.src/Compta/Tables/FJournaux.class#L81-L88), [FJournaux.class:125](../../../../../.src/Compta/Tables/FJournaux.class#L125), [FJournaux.class:368](../../../../../.src/Compta/Tables/FJournaux.class#L368), [FJournaux.class:300](../../../../../.src/Compta/Tables/FJournaux.class#L300)
- [ ] FJOURNAUX-003 — [commonalisation] `CodeValide() As Boolean` pour le contrôle numérique répété
  dans `Jo_KeyPress`, `Btn_KeyPress`, `Btn_Click` (même message, même focus) · appelants : aucun ·
  tests : T05 · sources : [FJournaux.class:97](../../../../../.src/Compta/Tables/FJournaux.class#L97), [FJournaux.class:153](../../../../../.src/Compta/Tables/FJournaux.class#L153), [FJournaux.class:176](../../../../../.src/Compta/Tables/FJournaux.class#L176)
- [ ] FJOURNAUX-004 — [réarchitecture] `Cbase.Table("TabJour")`/`Cbase.Table("TabComptes")` à la
  place des noms en dur (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [FJournaux.class:Form_Open](../../../../../.src/Compta/Tables/FJournaux.class#L44-L62), [FJournaux.class:Button1_Click](../../../../../.src/Compta/Tables/FJournaux.class#L205-L247), [FJournaux.class:Button4_Click](../../../../../.src/Compta/Tables/FJournaux.class#L281-L315), [FJournaux.class:cptman](../../../../../.src/Compta/Tables/FJournaux.class#L358-L393)
- [ ] FJOURNAUX-005 — [séparation traitement/GUI] `EnregistreJournal(...)` et `SupprimeJournal(sCode)`
  sans contrôle (SQL concaténé et `Try` conservés jusqu'à A01) · appelants : aucun · tests : T01-T05 · sources : [FJournaux.class:Button1_Click](../../../../../.src/Compta/Tables/FJournaux.class#L205-L247), [FJournaux.class:Button3_Click](../../../../../.src/Compta/Tables/FJournaux.class#L261-L276)
- [ ] FJOURNAUX-006 — [réduction de portée] `ColjoRefresh`, `Maj_Zones`, `cptman` → `Private` ·
  appelants : aucun · tests : T01-T05 · sources : [FJournaux.class:ColjoRefresh](../../../../../.src/Compta/Tables/FJournaux.class#L64-L69), [FJournaux.class:Maj_Zones](../../../../../.src/Compta/Tables/FJournaux.class#L71-L79), [FJournaux.class:cptman](../../../../../.src/Compta/Tables/FJournaux.class#L358-L393)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FJOURNAUX-A01 — [anomalie] SQL par concaténation sous `Try` : un libellé avec apostrophe
  (« Journal d'achats ») fait échouer l'enregistrement sans message · tests : T04 · sources : [FJournaux.class:225](../../../../../.src/Compta/Tables/FJournaux.class#L225), [FJournaux.class:227](../../../../../.src/Compta/Tables/FJournaux.class#L227), [FJournaux.class:229](../../../../../.src/Compta/Tables/FJournaux.class#L229), [FJournaux.class:270](../../../../../.src/Compta/Tables/FJournaux.class#L270)
- [ ] FJOURNAUX-A02 — [anomalie] L'UPDATE vise la ligne sélectionnée (`coljo.Current.key`) et non
  le code saisi : sélection différente → tentative de renommage et conflit de clé silencieux ;
  aucune sélection → erreur avalée · tests : T03 · sources : [FJournaux.class:227](../../../../../.src/Compta/Tables/FJournaux.class#L227)
- [ ] FJOURNAUX-A03 — [anomalie] Suppression sans contrôle d'usage du journal dans les écritures,
  sur la ligne sélectionnée et non le code saisi · tests : T05 · sources : [FJournaux.class:Button3_Click](../../../../../.src/Compta/Tables/FJournaux.class#L261-L276)
- [ ] FJOURNAUX-A04 — [anomalie] `Btn_KeyPress` : toute touche sur Enregistrer enregistre ;
  avertissement « pas un compte de trésorerie » non bloquant (`b` écrasé) · tests : T02, T05 · sources : [FJournaux.class:Btn_KeyPress](../../../../../.src/Compta/Tables/FJournaux.class#L148-L163), [FJournaux.class:375](../../../../../.src/Compta/Tables/FJournaux.class#L375)
