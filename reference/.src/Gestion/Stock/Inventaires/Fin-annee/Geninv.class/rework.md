# Geninv — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 203 |
| Lignes de commentaire | 22 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 13 (`gen_Inv`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 203 | 36 | 13 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GENINV-001 — [documentation] En-tête de classe en français : place dans la chaîne de
  l'inventaire, structure de `Fiches_Inv`, signification des colonnes, rôle des deux tris ·
  appelants : aucun · tests : T01-T16 · sources : [Geninv.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L34-L45), [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153)
- [ ] GENINV-002 — [code mort] Supprimer `Coulfond` (jamais lu), le membre `tri` et son calcul,
  `Nbpage`, `Stktheorique`, `Tab2`, la valeur initiale `~/tmp/Edinv.ps` de `Filename`, le
  `Shell "cd ~"`, le second `Me.Mouse = Mouse.Wait`, le `With Utils` (remplacé par
  `Utils.Cdate_Dbase`) et le handler vide `Label1_MouseDown` · appelants : aucun · tests : T01, T13 ·
  sources : [Geninv.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L34-L45), [Geninv.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L155-L237), [Geninv.class:Label1_MouseDown](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L252-L254), [Geninv.class:191](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L191)
- [ ] GENINV-003 — [code mort] Supprimer le `DROP` de `button1_Click` (l. 65), redondant avec celui
  de `gen_Inv` (SQL modifié : un `DROP IF EXISTS` en moins, dump identique) · appelants : aucun ·
  tests : T07 · sources : [Geninv.class:65](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L65), [Geninv.class:93](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L93)
- [ ] GENINV-004 — [complexité] `gen_Inv` : un seul `SELECT` dont l'`ORDER BY` est construit par
  listes blanches à partir des radios (texte SQL identique pour chaque combinaison) ; CC 13 → ≤ 5
  visé · appelants : aucun · tests : T01-T06 · sources : [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153)
- [ ] GENINV-005 — [séparation traitement/GUI] `gen_Inv` → `Generer(sOrdre1, sOrdre2, sDate) As
  Integer` sans accès aux contrôles ; lecture des lignes de la feuille isolée de la mise en page
  dans `Button3_Click` · appelants : aucun · tests : T01-T15 · sources : [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153), [Geninv.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L155-L237)
- [ ] GENINV-006 — [commonalisation] Créer le module `Inventaire` (socle paramétré `"F"`/`"T"` :
  `Table`, `Libelle`, `DateInv`, `Supprimer`, `Creer`, `Generer`, `Lignes`, `MajComptage`,
  `ImportPortable`, voir architecture.md) et y déplacer la génération commune à `Geninv` et
  `GeninvT` ; SQL identique · appelants : aucun (nouveau module) · tests : T01-T16, GENINVT-T01..T13 ·
  sources : [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153), [GeninvT.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L486-L573)
- [ ] GENINV-007 — [réarchitecture] Noms de tables par `Cbase.Table("TabInv")` / `Cbase.Table("TabArt")`
  (ou `Inventaire.Table("F")`) au lieu des littéraux ; SQL identique · appelants : aucun ·
  tests : T01, T13 · sources : [Geninv.class:button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L47-L75), [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153), [Geninv.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L155-L237)
- [ ] GENINV-008 — [réduction de portée] `gen_Inv` → `Private` (aucun appelant externe, vérifié par
  grep) · appelants : aucun · tests : T01-T12 · sources : [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GENINV-A01 — [anomalie] Feuille de comptage lue sans `ORDER BY` : sur MySQL/InnoDB l'ordre
  suit la clé `inv_nlig char(9)` (1, 10, 100, 11…), sur SQLite l'ordre d'insertion ; le choix
  « Tri 2 » (`tri`) est calculé mais ignoré (à confirmer en phase 2) · tests : T13, T16 · sources : [Geninv.class:189](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L189), [Geninv.class:177](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L177)
- [ ] GENINV-A02 — [anomalie] `inv_valid` n'est jamais écrit pour `Fiches_Inv` (`Validinv` ne le
  marque pas et ne supprime pas la table) : l'avertissement « inventaire validé » n'apparaît jamais
  et un inventaire déjà validé peut être régénéré puis revalidé sans alerte · tests : T07 · sources : [Geninv.class:56](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L56), [Validinv.class:187](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L187)
- [ ] GENINV-A03 — [anomalie] Contrôle de flux par exception : table absente → erreur SQL
  (`Message.Error` en mode backtrace) puis `gen_Inv` dans le `Catch` ; une erreur dans `gen_Inv`
  après confirmation relance `gen_Inv` (double génération, seconde erreur non rattrapée) ; échec du
  `CREATE` ignoré (`Try`) · tests : T09 · sources : [Geninv.class:72](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L72), [Geninv.class:94](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L94)
- [ ] GENINV-A04 — [anomalie] `Button3_Click` : `rarts` lu sans `Available` ; un article supprimé
  depuis la génération fait échouer l'impression avec le message trompeur « Veuillez générer votre
  inventaire » ; colonne « quantité comptée » toujours vide (`qtecomptee` jamais affectée) ·
  tests : T14 · sources : [Geninv.class:203](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L203), [Geninv.class:210](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L210), [Geninv.class:235](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L235)
