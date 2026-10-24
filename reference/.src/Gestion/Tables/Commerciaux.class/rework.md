# Commerciaux — Rework

> Source : `.src/Gestion/Tables/Commerciaux.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Commerciaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 145 |
| Lignes de commentaire | 4 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 38 |
| Complexité max (fonction) | 9 (`Ven_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 145 | 38 | 9 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COMMERCIAUX-001 — [documentation] En-tête (absent) : rôle, colonnes, correspondance des tags
  `Btn` (1 supprimer, 2 enregistrer), tables utilisatrices · appelants : aucun · tests : aucun ·
  sources : [Commerciaux.class:Form_Open](../../../../../.src/Gestion/Tables/Commerciaux.class#L3-L34), [Commerciaux.class:Btn_Click](../../../../../.src/Gestion/Tables/Commerciaux.class#L65-L80)
- [ ] COMMERCIAUX-002 — [réarchitecture] `Cbase.Table("TabCommerciaux")` au lieu du nom en dur
  (SQL identique) ; suppression des `With utils`/`With Utils` inutiles · appelants : aucun ·
  tests : T01-T04 · sources : [Commerciaux.class:Form_Open](../../../../../.src/Gestion/Tables/Commerciaux.class#L3-L34), [Commerciaux.class:Button1_Click](../../../../../.src/Gestion/Tables/Commerciaux.class#L91-L110), [Commerciaux.class:Button3_Click](../../../../../.src/Gestion/Tables/Commerciaux.class#L112-L124), [Commerciaux.class:Maj_Zones](../../../../../.src/Gestion/Tables/Commerciaux.class#L134-L146)
- [ ] COMMERCIAUX-003 — [complexité] `Form_Open` : extraire `InitColonnes()` et `ChargeListe()`
  (appel de `Utils.Observers` conservé à l'identique) · appelants : aucun · tests : T01-T05 ·
  sources : [Commerciaux.class:Form_Open](../../../../../.src/Gestion/Tables/Commerciaux.class#L3-L34)
- [ ] COMMERCIAUX-004 — [séparation traitement/GUI] `EnregistreCommercial(...)` et
  `SupprimeCommercial(sCode)` sans contrôle (SQL inchangé, concaténation conservée jusqu'à A01) ·
  appelants : aucun · tests : T01-T04 · sources : [Commerciaux.class:Button1_Click](../../../../../.src/Gestion/Tables/Commerciaux.class#L91-L110), [Commerciaux.class:Button3_Click](../../../../../.src/Gestion/Tables/Commerciaux.class#L112-L124)
- [ ] COMMERCIAUX-005 — [commonalisation] Rattacher liste/enregistrement/suppression au socle
  « table code/libellé » (voir CENTRALES-005) ; contrôle de la commission via un helper de saisie
  numérique commun · appelants : aucun · tests : T01-T04 · sources : [Commerciaux.class:Ven_LostFocus](../../../../../.src/Gestion/Tables/Commerciaux.class#L42-L63), [Centrales.class:Button3_Click](../../../../../.src/Gestion/Tables/Centrales.class#L110-L129)
- [ ] COMMERCIAUX-006 — [réduction de portée] `Button1_Click`, `Button3_Click`, `Refresh`,
  `Maj_Zones`, `Cleanchamps` → `Private` ; `Vendeur_Click` reste `Public` (rejeu) · appelants :
  aucun · tests : T01-T05 · sources : [Commerciaux.class:Refresh](../../../../../.src/Gestion/Tables/Commerciaux.class#L126-L132), [Commerciaux.class:Maj_Zones](../../../../../.src/Gestion/Tables/Commerciaux.class#L134-L146), [Commerciaux.class:Cleanchamps](../../../../../.src/Gestion/Tables/Commerciaux.class#L148-L155)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] COMMERCIAUX-A01 — [anomalie] `DELETE` par concaténation sur `Vendeur.Current[0]` (ligne
  sélectionnée et non code saisi ; erreur sans sélection) · tests : T04 · sources : [Commerciaux.class:117](../../../../../.src/Gestion/Tables/Commerciaux.class#L117)
- [ ] COMMERCIAUX-A02 — [anomalie] `Music.Play` sans `Music.Load` et sans test du réglage son ·
  tests : aucun (son) · sources : [Commerciaux.class:115](../../../../../.src/Gestion/Tables/Commerciaux.class#L115)
- [ ] COMMERCIAUX-A03 — [anomalie] `Utils.Observers(Me)` réexécuté à chaque `Refresh` (via
  `Form_Open`) : observateurs de rejeu cumulés (à confirmer) · tests : T05 · sources : [Commerciaux.class:7](../../../../../.src/Gestion/Tables/Commerciaux.class#L7), [Commerciaux.class:Refresh](../../../../../.src/Gestion/Tables/Commerciaux.class#L126-L132)
- [ ] COMMERCIAUX-A04 — [anomalie] Code non unique en base et suppression sans contrôle d'usage
  (`Fiches_Cli.cli_comm`) ; l'UPDATE touche toutes les lignes du même code · tests : T04 · sources : [Commerciaux.class:99](../../../../../.src/Gestion/Tables/Commerciaux.class#L99)
