# Tregie — Rework

> Source : `.src/Gestion/option/Tregie.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Tregie.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 448 |
| Lignes de commentaire | 5 |
| Fonctions | 32 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 101 |
| Complexité max (fonction) | 13 (`verifie`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 448 | 101 | 13 | 0 | 22 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TREGIE-001 — [documentation] En-tête : rôle (référentiel des régies), signification des
  colonnes (`ap`, `suspendu`, `drfac`, `degres`…), règle de recalcul des articles de `modifart`,
  grilles sans données · appelants : aucun · tests : T01-T05 · sources : [Tregie.class:form_Open](../../../../../.src/Gestion/option/Tregie.class#L10-L40), [Tregie.class:modifart](../../../../../.src/Gestion/option/Tregie.class#L456-L529)
- [ ] TREGIE-002 — [documentation] `affent` et `affichedonne` : commentaire « grilles mensuelles
  non alimentées » (les grilles appartiennent au `.form`, aucun code supprimé ; le
  commentaire « affiche gridv » sans code est remplacé) · appelants : aucun · tests : T01 ·
  sources : [Tregie.class:affent](../../../../../.src/Gestion/option/Tregie.class#L42-L99), [Tregie.class:affichedonne](../../../../../.src/Gestion/option/Tregie.class#L101-L128)
- [ ] TREGIE-003 — [séparation traitement/GUI] Extraire de `modifart` une fonction
  `RecalculPrixArticle(...)` sans accès aux contrôles (régime, choix et option `pp` passés en
  paramètres) ; SQL et PDF inchangés · appelants : aucun · tests : T03-T05, T07 · sources : [Tregie.class:modifart](../../../../../.src/Gestion/option/Tregie.class#L456-L529)
- [ ] TREGIE-004 — [séparation traitement/GUI] `verifie` : requêtes compte et TVA dans des
  fonctions privées `CompteExiste`, `TvaExiste` (SQL identique) · appelants : aucun · tests : T02 ·
  sources : [Tregie.class:verifie](../../../../../.src/Gestion/option/Tregie.class#L161-L211)
- [ ] TREGIE-005 — [réarchitecture] `Cbase.Table` pour `Fiches_Art`, `Fiches_Tvaav`,
  `Fiches_Comptes`, `Fiches_Parametres` (SQL identique) · appelants : aucun · tests : T01-T05 ·
  sources : [Tregie.class:affent](../../../../../.src/Gestion/option/Tregie.class#L42-L99), [Tregie.class:verifie](../../../../../.src/Gestion/option/Tregie.class#L161-L211), [Tregie.class:modifart](../../../../../.src/Gestion/option/Tregie.class#L456-L529), [Tregie.class:Buttva_Click](../../../../../.src/Gestion/option/Tregie.class#L424-L444)
- [ ] TREGIE-006 — [complexité] `Relire()` pour les trois relectures de `Fiches_regie` ;
  `pdfaff` appelée via une petite fonction `LigneArticle(pdf, res, posy)` (deux appels identiques) ·
  appelants : aucun · tests : T01, T03 · sources : [Tregie.class:bar1_annule](../../../../../.src/Gestion/option/Tregie.class#L304-L313), [Tregie.class:bar1_valide](../../../../../.src/Gestion/option/Tregie.class#L315-L332), [Tregie.class:pdfaff](../../../../../.src/Gestion/option/Tregie.class#L550-L566)
- [ ] TREGIE-007 — [commonalisation] Cycle de barre commun (voir MREGLEMENT-006, TCONSIGNE-004) ;
  en-têtes mensuels communs avec `gridvi` · appelants : aucun · tests : T01-T06 · sources : [Tregie.class:bar1_creer](../../../../../.src/Gestion/option/Tregie.class#L341-L350), [Tregie.class:bar1_modif](../../../../../.src/Gestion/option/Tregie.class#L352-L360), [Tregie.class:affent](../../../../../.src/Gestion/option/Tregie.class#L42-L99)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TREGIE-A01 — [anomalie] `form_Close` appelle `bar1_valide` sans argument : « Not enough
  arguments » (vérifié `gbs3`) ; sur « Non », transaction laissée ouverte · tests : T06 · sources : [Tregie.class:406](../../../../../.src/Gestion/option/Tregie.class#L406), [Tregie.class:form_Close](../../../../../.src/Gestion/option/Tregie.class#L403-L410)
- [ ] TREGIE-A02 — [anomalie, à confirmer] `bar1_modif` : `Edit(…, "code=&1 FOR UPDATE")` non
  supporté par SQLite ; lecture de `resregie!code` sans test `Available` · tests : T03 · sources : [Tregie.class:356](../../../../../.src/Gestion/option/Tregie.class#L356), [Tregie.class:358](../../../../../.src/Gestion/option/Tregie.class#L358)
- [ ] TREGIE-A03 — [anomalie] `modifart` : division par `art_prvt` nul (choix « coeff ») au milieu
  de la transaction ; valeur de `Message.Question` hors 1/2 → prix de vente et coefficient à 0
  (à confirmer) · tests : T04 · sources : [Tregie.class:510](../../../../../.src/Gestion/option/Tregie.class#L510), [Tregie.class:504](../../../../../.src/Gestion/option/Tregie.class#L504)
- [ ] TREGIE-A04 — [anomalie] Bouton Supprimer affiché (`"111111110"`) mais `bar1_suprimer` ne fait
  qu'un `Print` console · tests : T01 · sources : [Tregie.class:23](../../../../../.src/Gestion/option/Tregie.class#L23), [Tregie.class:bar1_suprimer](../../../../../.src/Gestion/option/Tregie.class#L334-L339)
- [ ] TREGIE-A05 — [anomalie, à confirmer] `ListBox1_Activate` : `Left(texte)` ne garde que le
  premier caractère du code TVA (`ttva char(2)`) ; `Bsel` non remis à `False` avant `TriCpt` ;
  `$ind` non mis à jour par `bar1_modif` (même défaut que TCONSIGNE-A04) · tests : T01, T03 ·
  sources : [Tregie.class:448](../../../../../.src/Gestion/option/Tregie.class#L448), [Tregie.class:Buttccomp_Click](../../../../../.src/Gestion/option/Tregie.class#L412-L422), [Tregie.class:bar1_modif](../../../../../.src/Gestion/option/Tregie.class#L352-L360)
