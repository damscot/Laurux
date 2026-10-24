# FCloture — Rework

> Source : `.src/Compta/Clotures/FCloture.class` · Message de commit (phase 4) : `reference/.src/Compta/Clotures/FCloture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 116 |
| Lignes de commentaire | 25 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 25 |
| Complexité max (fonction) | 17 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 116 | 25 | 17 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCLOTURE-001 — [documentation] En-tête en français : préconditions (pas de provisoire,
  clés SHA-1 valides), champs modifiés (`cloturee`, `numerodef`, `dteval`, `dtepc`,
  `numecriture2`), comportement en cas d'interruption · appelants : aucun · tests : aucun ·
  sources : [FCloture.class:Button1_Click](../../../../../.src/Compta/Clotures/FCloture.class#L92-L161)
- [ ] FCLOTURE-002 — [code mort] Supprimer `Dateimp1`, `Dateimp2`, `Depc`, `dtex`, `$cle`, le
  `SELECT` inutilisé de la l. 152 et l'argument `&3` superflu de la l. 137 (SQL modifié : un
  `SELECT` en moins, dump identique) · appelants : aucun · tests : T01, T04 ·
  sources : [FCloture.class:33-34](../../../../../.src/Compta/Clotures/FCloture.class#L33-L34), [FCloture.class:108](../../../../../.src/Compta/Clotures/FCloture.class#L108), [FCloture.class:152](../../../../../.src/Compta/Clotures/FCloture.class#L152), [FCloture.class:137](../../../../../.src/Compta/Clotures/FCloture.class#L137)
- [ ] FCLOTURE-003 — [commonalisation] Dernier jour du mois et mois suivant via `LDate`
  (`FinMois`, `PFin`) au lieu du découpage de chaîne ; dates écrites identiques · appelants :
  aucun · tests : T01, T04, T08 · sources : [FCloture.class:Aff_date](../../../../../.src/Compta/Clotures/FCloture.class#L52-L84), [FCloture.class:143-150](../../../../../.src/Compta/Clotures/FCloture.class#L143-L150), [LDate.class:Fin_Mois](../../../../../.src/Utils/LDate.class#L564-L573)
- [ ] FCLOTURE-004 — [commonalisation] `Cbase.Table("TabMvt")` / `Cbase.Table("TabParam")` pour
  les requêtes et pour `Sha1Calc.CalcSha1_Verify` (SQL identique) · appelants : aucun ·
  tests : T01-T03 · sources : [FCloture.class:56](../../../../../.src/Compta/Clotures/FCloture.class#L56), [FCloture.class:104-105](../../../../../.src/Compta/Clotures/FCloture.class#L104-L105), [FCloture.class:126](../../../../../.src/Compta/Clotures/FCloture.class#L126)
- [ ] FCLOTURE-005 — [séparation traitement/GUI] Extraire `ClotureMois(sMois, sAnnee, numecr, PB)
  As String` (SQL, SHA-1, numérotation) et `PeriodeSuivante(dtepc)` sans accès aux contrôles ;
  `Button1_Click` garde messages, souris et fermeture (SQL identique) · appelants : aucun ·
  tests : T01-T07, T08 · sources : [FCloture.class:Button1_Click](../../../../../.src/Compta/Clotures/FCloture.class#L92-L161), [FCloture.class:Aff_date](../../../../../.src/Compta/Clotures/FCloture.class#L52-L84)
- [ ] FCLOTURE-006 — [complexité] `FCloture.Close()` → `Me.Close()` ; conditions de la l. 123 et
  l. 134 réécrites avec un booléen `bSansNumDef` (CC 17 → ≤ 10 visé) · appelants : aucun ·
  tests : T01, T03 · sources : [FCloture.class:123](../../../../../.src/Compta/Clotures/FCloture.class#L123), [FCloture.class:130](../../../../../.src/Compta/Clotures/FCloture.class#L130), [FCloture.class:134](../../../../../.src/Compta/Clotures/FCloture.class#L134)
- [ ] FCLOTURE-007 — [réduction de portée] `Aff_date` → `Private` · appelants : aucun ·
  tests : T01, T04 · sources : [FCloture.class:Aff_date](../../../../../.src/Compta/Clotures/FCloture.class#L52-L84)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCLOTURE-A01 — [anomalie] Interruption par la `ProgBar` (`Break`) ou clé SHA-1 invalide en
  cours de boucle : les écritures déjà traitées restent clôturées, sans transaction ; après un
  `Break`, `dtepc` est **quand même avancé** (période déclarée clôturée alors que des écritures
  ne le sont pas) · tests : T03, T05 · sources : [FCloture.class:139](../../../../../.src/Compta/Clotures/FCloture.class#L139), [FCloture.class:153](../../../../../.src/Compta/Clotures/FCloture.class#L153)
- [ ] FCLOTURE-A02 — [anomalie] Aucun contrôle de la fin d'exercice : `dteclec` est lu (`dtex`)
  mais jamais utilisé, des mois postérieurs à l'exercice peuvent être clôturés (intention à
  confirmer) · tests : T07 · sources : [FCloture.class:108](../../../../../.src/Compta/Clotures/FCloture.class#L108)
- [ ] FCLOTURE-A03 — [anomalie] `Fiches_Parametres` vide à l'ouverture : l'application entière
  est quittée (`Quit`) au lieu de fermer l'écran · tests : manuel · sources : [FCloture.class:58-66](../../../../../.src/Compta/Clotures/FCloture.class#L58-L66)
