# Ecritures — Rework

> Source : `.src/Compta/Utils/Ecritures.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Ecritures.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 374 |
| Lignes de commentaire | 29 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 18 (`Necrit_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 374 | 66 | 18 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECRITURES-001 — [documentation] En-tête : les trois niveaux, variables d'état, enchaînement
  avec `Saisecrit`/`Tresor` · appelants : aucun · tests : aucun · sources : [Ecritures.class:_New](../../../../../.src/Compta/Utils/Ecritures.class#L46-L65)
- [ ] ECRITURES-002 — [commonalisation] `ChargeComptes(sType)` privé pour les quatre handlers de type,
  valeur passée en `&1` (SQL équivalent, résultat identique) · appelants : aucun · tests : T01 ·
  sources : [Ecritures.class:Bclient_Click](../../../../../.src/Compta/Utils/Ecritures.class#L84-L92), [Ecritures.class:Bfournisseur_Click](../../../../../.src/Compta/Utils/Ecritures.class#L94-L102), [Ecritures.class:Bgestion_Click](../../../../../.src/Compta/Utils/Ecritures.class#L104-L112), [Ecritures.class:Bbilan_Click](../../../../../.src/Compta/Utils/Ecritures.class#L114-L122)
- [ ] ECRITURES-003 — [code mort] Supprimer `type_compte`, `QuitteEcritjl`, la lecture
  `Try Bcol = rResult!collectif` et sa branche, les variables `Indx`, `Collectif` · appelants :
  aucun · tests : T01, T03 · sources : [Ecritures.class:type_compte](../../../../../.src/Compta/Utils/Ecritures.class#L124-L131), [Ecritures.class:QuitteEcritjl](../../../../../.src/Compta/Utils/Ecritures.class#L365-L385), [Ecritures.class:282-316](../../../../../.src/Compta/Utils/Ecritures.class#L282-L316), [Ecritures.class:38-39](../../../../../.src/Compta/Utils/Ecritures.class#L38-L39)
- [ ] ECRITURES-004 — [réduction de portée] `type_Click` → `Private` · appelants : aucun · tests :
  T01 · sources : [Ecritures.class:type_Click](../../../../../.src/Compta/Utils/Ecritures.class#L67-L82)
- [ ] ECRITURES-005 — [séparation traitement/GUI] Requêtes extraites dans `ComptesDuType`,
  `ExtraitCompte`, `LignesEcriture` ; configuration des colonnes dans des fonctions privées ·
  appelants : aucun · tests : T01-T03 · sources : [Ecritures.class:Ecrit_Click](../../../../../.src/Compta/Utils/Ecritures.class#L139-L219), [Ecritures.class:EcritGL_Click](../../../../../.src/Compta/Utils/Ecritures.class#L225-L322)
- [ ] ECRITURES-006 — [commonalisation] `Cbase.Table("TabComptes"/"TabMvt")`, y compris l'argument
  de `Sha1Calc.CalcSha1` (SQL identique) · appelants : aucun · tests : T01-T03 · sources :
  [Ecritures.class:86](../../../../../.src/Compta/Utils/Ecritures.class#L86), [Ecritures.class:146](../../../../../.src/Compta/Utils/Ecritures.class#L146), [Ecritures.class:301](../../../../../.src/Compta/Utils/Ecritures.class#L301)
- [ ] ECRITURES-007 — [complexité] `Necrit_Click` : repositionnement (compte puis ligne) dans un
  helper privé `Repositionne(liste, valeur)` ; CC 18 → ≤ 8 · appelants : aucun · tests : T04, T05 ·
  sources : [Ecritures.class:Necrit_Click](../../../../../.src/Compta/Utils/Ecritures.class#L390-L436)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECRITURES-A01 — [anomalie] `type_Click` remet `type = "C"` : l'état mémorisé ne reflète pas le
  type affiché (sans effet visible aujourd'hui car son seul lecteur, `QuitteEcritjl`, est mort) ·
  tests : T01 · sources : [Ecritures.class:69](../../../../../.src/Compta/Utils/Ecritures.class#L69)
- [ ] ECRITURES-A02 — [anomalie] `cloturee`/`Tresr` mémorisés depuis la **dernière** ligne de
  l'écriture, et non depuis la ligne cliquée ; `Message.Delete` utilisé pour un avertissement ·
  tests : T05, T06 · sources : [Ecritures.class:305-310](../../../../../.src/Compta/Utils/Ecritures.class#L305-L310), [Ecritures.class:433](../../../../../.src/Compta/Utils/Ecritures.class#L433)
