# Tregion — Rework

> Source : `.src/Gestion/option/Tregion.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Tregion.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 168 |
| Lignes de commentaire | 2 |
| Fonctions | 19 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 8 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 168 | 43 | 8 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TREGION-001 — [documentation] En-tête en français : rôle, structure de `Fiches_region`
  (ligne sentinelle `cart='0'` = intitulé), création par `modfichier.fichiercarbu`, cycle
  `Barselection` ; renommer `anul` en `modif` dans `bar1_annule` (nom du handler inchangé) ·
  appelants : aucun · tests : T01-T08 · sources : [Tregion.class:form_Open](../../../../../.src/Gestion/option/Tregion.class#L7-L25), [Tregion.class:Textcode_LostFocus](../../../../../.src/Gestion/option/Tregion.class#L167-L185)
- [ ] TREGION-002 — [séparation traitement/GUI] `ChargeRegions() As Result` (3 occurrences),
  `RegionExiste(code, cart) As Boolean` (2), `DesignationArticle(code) As String` (2), sans accès
  aux contrôles ; SQL identique · appelants : aucun · tests : T01-T05, T08 · sources :
  [Tregion.class:bar1_valide](../../../../../.src/Gestion/option/Tregion.class#L107-L144), [Tregion.class:Textart_LostFocus](../../../../../.src/Gestion/option/Tregion.class#L187-L200), [Tregion.class:affichedonne](../../../../../.src/Gestion/option/Tregion.class#L201-L216)
- [ ] TREGION-003 — [complexité] `bar1_valide` : `ValideRegion(creer, modi, code, cart) As String`
  (motif de refus), le handler garde ballons et `Stop Event` (CC 8 → ≤ 4 visé) · appelants :
  aucun · tests : T01-T04 · sources : [Tregion.class:bar1_valide](../../../../../.src/Gestion/option/Tregion.class#L107-L144)
- [ ] TREGION-004 — [réarchitecture] `Cbase.Table("TabArt")` pour `Fiches_Art` (SQL identique) ;
  clé `TabRegion` pour `Fiches_region` à décider en phase 3 avec `rechtipp`/`Edittipp` · appelants :
  aucun · tests : T02, T03, T08 · sources : [Tregion.class:191](../../../../../.src/Gestion/option/Tregion.class#L191), [Tregion.class:210](../../../../../.src/Gestion/option/Tregion.class#L210)
- [ ] TREGION-005 — [commonalisation] Cycle `Barselection` commun (voir TTOURNE-005,
  MREGLEMENT-006) ; handlers `bar1_*` conservés · appelants : aucun · tests : T01-T06 · sources :
  [Tregion.class:bar1_creer](../../../../../.src/Gestion/option/Tregion.class#L53-L63), [Tregion.class:bar1_annule](../../../../../.src/Gestion/option/Tregion.class#L39-L51), [Tregion.class:bar1_suivant](../../../../../.src/Gestion/option/Tregion.class#L99-L105)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TREGION-A01 — [anomalie] `form_Close` appelle `bar1_valide` sans argument : « Not enough
  arguments » sur « Oui » (vérifié avec `gbs3`) ; correction : `bar1_valide(bs.estcreer,
  bs.estmodif)` · tests : T07 · sources : [Tregion.class:161](../../../../../.src/Gestion/option/Tregion.class#L161)
- [ ] TREGION-A02 — [anomalie] Transaction ouverte pendant la saisie et laissée ouverte sur
  « Non » à la fermeture (même défaut que MREGLEMENT-A01, TTOURNE-A02) · tests : T07 · sources :
  [Tregion.class:56](../../../../../.src/Gestion/option/Tregion.class#L56), [Tregion.class:76](../../../../../.src/Gestion/option/Tregion.class#L76), [Tregion.class:form_Close](../../../../../.src/Gestion/option/Tregion.class#L158-L165)
- [ ] TREGION-A03 — [anomalie] `bar1_modif` édite par `code=&1` seul alors que la clé est
  `(code, cart)` : la modification d'un taux s'applique à la première ligne de la région, pas à
  celle affichée (à confirmer par T04) ; correction : `code=&1 AND cart=&2` · tests : T04 ·
  sources : [Tregion.class:77](../../../../../.src/Gestion/option/Tregion.class#L77)
- [ ] TREGION-A04 — [anomalie] Bouton Suppression affiché (`"111111110"`) mais `bar1_suprimer`
  vide · tests : T06 · sources : [Tregion.class:bar1_suprimer](../../../../../.src/Gestion/option/Tregion.class#L146-L150), [Tregion.class:form_Open](../../../../../.src/Gestion/option/Tregion.class#L7-L25)
- [ ] TREGION-A05 — [anomalie] `Textcode_LostFocus` poursuit après le ballon « code vide » :
  requête avec un code vide et message « premier code région » affiché à tort ; correction :
  `Return` après le ballon · tests : T03 · sources : [Tregion.class:Textcode_LostFocus](../../../../../.src/Gestion/option/Tregion.class#L167-L185)
