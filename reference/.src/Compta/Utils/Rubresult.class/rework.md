# Rubresult — Rework

> Source : `.src/Compta/Utils/Rubresult.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Rubresult.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 290 |
| Lignes de commentaire | 39 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 63 |
| Complexité max (fonction) | 21 (`BcrSelect_Activate`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 290 | 63 | 21 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RUBRESULT-001 — [documentation] En-tête en français : rôle, signification des préfixes
  `B`/`R`/`S`, des types (`T`, `E`, `L`, `S`, `O`, `C`, `D`, `R`, `G`), de `detail` et `num`,
  format des fichiers `Bcr.txt`/`Bcrcpt.txt` et caractère destructif de l'import · appelants :
  aucun · tests : aucun · sources : [Rubresult.class:_New](../../../../../.src/Compta/Utils/Rubresult.class#L30-L52), [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392)
- [ ] RUBRESULT-002 — [code mort] Supprimer `Button3_Click` (handler nominal inactif, groupe
  `Btn`, tag 4 traité par `Btn_Click` ; aucun appel) et le bloc commenté de `colcol_Click`. Pas de
  modification du `.form` · appelants : aucun · tests : T01-T03 · sources : [Rubresult.class:Button3_Click](../../../../../.src/Compta/Utils/Rubresult.class#L246-L250), [Rubresult.class:colcol_Click](../../../../../.src/Compta/Utils/Rubresult.class#L78-L93)
- [ ] RUBRESULT-003 — [réduction de portée] `CleanChamps`, `Rubman` → `Private` ; `Refresh` renommé
  `RafraichitListe` (privée) pour ne plus masquer `Form.Refresh` · appelants : aucun · tests :
  T01-T04 · sources : [Rubresult.class:CleanChamps](../../../../../.src/Compta/Utils/Rubresult.class#L95-L102), [Rubresult.class:Rubman](../../../../../.src/Compta/Utils/Rubresult.class#L255-L271), [Rubresult.class:Refresh](../../../../../.src/Compta/Utils/Rubresult.class#L104-L109)
- [ ] RUBRESULT-004 — [séparation traitement/GUI] Extraire `EnregistreRubrique(…)`,
  `SupprimeRubrique(sNum)` et `ImporteParametrage(sRep) As String` (sans contrôles, renvoie le
  message d'erreur) ; les handlers gardent messages, son, souris et affichage. SQL identique et dans
  le même ordre · appelants : aucun · tests : T01-T07 · sources : [Rubresult.class:Button1_Click](../../../../../.src/Compta/Utils/Rubresult.class#L195-L211), [Rubresult.class:Button2_Click](../../../../../.src/Compta/Utils/Rubresult.class#L213-L244), [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392)
- [ ] RUBRESULT-005 — [complexité] `BcrSelect_Activate` (CC 21) : fonction privée
  `ChampsLigne(sLigne, iNb) As String[]` reproduisant exactement le découpage `InStr`/`Left$`/`Mid$`
  (cas `;` manquant compris) et procédure `ChargeTable` par fichier · appelants : aucun · tests :
  T04, T07, T08 · sources : [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392)
- [ ] RUBRESULT-006 — [commonalisation] Import et export du paramétrage dans un même module avec
  `Exprub` (format décrit une fois, voir EXPRUB-004) ; `Rubman` utilise `LitRubrique` commun avec
  `Rubcompt` (RUBCOMPT-006) · appelants : `Prgm` (via `Exprub.run`, signature inchangée) · tests :
  T04, EXPRUB-T01 · sources : [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392), [Exprub.class:run](../../../../../.src/Compta/Utils/Exprub.class#L15-L60), [Rubresult.class:Rubman](../../../../../.src/Compta/Utils/Rubresult.class#L255-L271)
- [ ] RUBRESULT-007 — [commonalisation] Noms de tables via `Cbase.Table("TabRubriques")` /
  `("TabRubCompt")` (clés ajoutées avec RUBCOMPT-006, SQL identique) · appelants : `Cbase` ·
  tests : T01-T04 · sources : [Rubresult.class:Form_Open](../../../../../.src/Compta/Utils/Rubresult.class#L54-L76), [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RUBRESULT-A01 — [anomalie, perte de données] Le contrôle d'existence teste deux fois
  `Bcr.txt` et jamais `Bcrcpt.txt` : sans `Bcrcpt.txt`, `Fiches_RubCompt` est supprimée et recréée
  vide avant l'erreur d'ouverture · tests : T05 · sources : [Rubresult.class:305](../../../../../.src/Compta/Utils/Rubresult.class#L305), [Rubresult.class:358](../../../../../.src/Compta/Utils/Rubresult.class#L358)
- [ ] RUBRESULT-A02 — [anomalie] Import sans transaction ni gestion d'erreur : toute erreur
  (ligne mal formée, valeur trop longue) laisse les tables vidées ou partielles · tests : T05, T07 ·
  sources : [Rubresult.class:BcrSelect_Activate](../../../../../.src/Compta/Utils/Rubresult.class#L284-L392)
- [ ] RUBRESULT-A03 — [anomalie, SQLite] `Truncate` n'est pas traduit par `DB_Connection` : import
  impossible sous SQLite (à confirmer) ; et `Amort` lu depuis `"0"` vaut vrai (chaîne non vide) si le
  fichier vient d'une base SQLite · tests : T06 · sources : [Rubresult.class:311](../../../../../.src/Compta/Utils/Rubresult.class#L311), [Rubresult.class:350](../../../../../.src/Compta/Utils/Rubresult.class#L350), [Rubresult.class:373](../../../../../.src/Compta/Utils/Rubresult.class#L373)
- [ ] RUBRESULT-A04 — [anomalie] Suppression : utilise la ligne sélectionnée et non le numéro saisi
  (erreur si aucune sélection) et laisse les plages `Fiches_RubCompt` orphelines · tests : T03 ·
  sources : [Rubresult.class:205](../../../../../.src/Compta/Utils/Rubresult.class#L205)
- [ ] RUBRESULT-A05 — [anomalie] `Det` et `Prod` partagent le tag 4 : `Prod` n'est jamais atteint
  au clavier et `CleanChamps` ne le vide pas (la valeur précédente est réenregistrée sur la rubrique
  suivante) ; correction côté code seulement (`Last.Name`), le `.form` restant intact · tests : T02 ·
  sources : [Rubresult.class:135](../../../../../.src/Compta/Utils/Rubresult.class#L135), [Rubresult.class:CleanChamps](../../../../../.src/Compta/Utils/Rubresult.class#L95-L102)
- [ ] RUBRESULT-A06 — [anomalie] `Btn_KeyPress` enregistre sur toute touche pressée sur
  « Enregistrer » · tests : T02 · sources : [Rubresult.class:Btn_KeyPress](../../../../../.src/Compta/Utils/Rubresult.class#L149-L158)
