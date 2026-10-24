# Rubcompt — Rework

> Source : `.src/Compta/Utils/Rubcompt.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Rubcompt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 270 |
| Lignes de commentaire | 42 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 14 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 270 | 66 | 14 | 0 | 19 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RUBCOMPT-001 — [documentation] En-tête en français : rôle (plages de comptes des rubriques
  du bilan, du compte de résultat et des SIG), clé `numrub, compte1`, sens du drapeau
  `amortissement`, tags du groupe `Lib`/`Btn` ; commentaire sur chaque fonction · appelants :
  aucun · tests : aucun · sources : [Rubcompt.class:_New](../../../../../.src/Compta/Utils/Rubcompt.class#L33-L54), [Rubcompt.class:Lib_KeyPress](../../../../../.src/Compta/Utils/Rubcompt.class#L110-L170)
- [ ] RUBCOMPT-002 — [code mort] Supprimer `Button3_Click` (handler nominal inactif : `Button3`
  est dans le groupe `Btn`, `Btn_Click` tag 4 ferme déjà la fenêtre ; aucun appel, vérifié par
  `grep`), la variable locale `typeL` de `Rubman` et les lignes commentées de `CleanChamps`. Pas
  de modification du `.form` · appelants : aucun · tests : T01, T05, T07 · sources : [Rubcompt.class:Button3_Click](../../../../../.src/Compta/Utils/Rubcompt.class#L264-L268), [Rubcompt.class:Btn_Click](../../../../../.src/Compta/Utils/Rubcompt.class#L183-L201), [Rubcompt.class:Rubman](../../../../../.src/Compta/Utils/Rubcompt.class#L347-L368)
- [ ] RUBCOMPT-003 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Rubman`, `Rubman2` →
  `Private` (aucun appelant externe, couverts par les replays). `Refresh` : renommer en
  `RafraichitListe` (privée) plutôt que changer la portée d'un nom qui masque `Form.Refresh` ·
  appelants : aucun · tests : T01-T07 · sources : [Rubcompt.class:Maj_Zones](../../../../../.src/Compta/Utils/Rubcompt.class#L77-L91), [Rubcompt.class:CleanChamps](../../../../../.src/Compta/Utils/Rubcompt.class#L93-L101), [Rubcompt.class:Refresh](../../../../../.src/Compta/Utils/Rubcompt.class#L103-L108), [Rubcompt.class:Rubman](../../../../../.src/Compta/Utils/Rubcompt.class#L347-L368), [Rubcompt.class:Rubman2](../../../../../.src/Compta/Utils/Rubcompt.class#L373-L383)
- [ ] RUBCOMPT-004 — [séparation traitement/GUI] Extraire `FinPlage(sCpt1) As String` (pure),
  `EnregistrePlage(sRub, sCpt1, sCpt2, bAmort) As Boolean`, `SupprimePlage(sRub, sCpt1)`,
  `ListePlages() As Result` et `RubriquesLignes() As Result`, sans accès aux contrôles ; les
  handlers gardent messages, son, focus et repositionnement. SQL identique · appelants : aucun ·
  tests : T02-T05, T08 · sources : [Rubcompt.class:Lib_KeyPress](../../../../../.src/Compta/Utils/Rubcompt.class#L110-L170), [Rubcompt.class:Button1_Click](../../../../../.src/Compta/Utils/Rubcompt.class#L214-L230), [Rubcompt.class:Button2_Click](../../../../../.src/Compta/Utils/Rubcompt.class#L232-L262), [Rubcompt.class:ToggleButton1_Click](../../../../../.src/Compta/Utils/Rubcompt.class#L273-L303)
- [ ] RUBCOMPT-005 — [complexité] `Form_Open` : remplacer la requête par ligne de `Rubman2` par
  un `LEFT JOIN Fiches_Rubriques` (lecture seule, SQL modifié, dump identique ; ordre des lignes à
  valider par T01, sinon conserver l'ordre `order by numrub` seul) ; `rResult`/`Rubs` deviennent
  locales · appelants : aucun · tests : T01, T06 · sources : [Rubcompt.class:Form_Open](../../../../../.src/Compta/Utils/Rubcompt.class#L56-L75), [Rubcompt.class:Rubman2](../../../../../.src/Compta/Utils/Rubcompt.class#L373-L383)
- [ ] RUBCOMPT-006 — [commonalisation] Lecture d'une rubrique `LitRubrique(sNumrub) As Result`
  partagée avec `Rubresult.Rubman` (voir RUBRESULT-006) ; noms de tables via deux nouvelles clés
  `Cbase` `TabRubriques`/`TabRubCompt` (SQL identique), ajoutées dans le même commit que
  RUBRESULT-007, EXPRUB-005, IMP_BILAN-009, IMP_SIG-006 et RUBIMP-009 · appelants : `Cbase` ·
  tests : T01-T05 · sources : [Rubcompt.class:Rubman](../../../../../.src/Compta/Utils/Rubcompt.class#L347-L368), [Rubcompt.class:Rubman2](../../../../../.src/Compta/Utils/Rubcompt.class#L373-L383), [Rubresult.class:Rubman](../../../../../.src/Compta/Utils/Rubresult.class#L255-L271), [Cbase.module:Table](../../../../../.src/Utils/Cbase.module#L3-L374)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RUBCOMPT-A01 — [anomalie] `Maj_Zones` lit le drapeau dans `Colcol.Item[4]` (curseur interne,
  dernière ligne chargée) au lieu de `Colcol.Current[4]` : la case « Amortissement » affichée peut
  être celle d'une autre plage, et l'enregistrement suivant écrase alors le drapeau (à confirmer
  à l'exécution) · tests : T06 · sources : [Rubcompt.class:83](../../../../../.src/Compta/Utils/Rubcompt.class#L83), [Rubcompt.class:Maj_Zones](../../../../../.src/Compta/Utils/Rubcompt.class#L77-L91)
- [ ] RUBCOMPT-A02 — [anomalie] Suppression : la rubrique vient de la ligne sélectionnée
  (`colcol.Current[0]`) et le compte du champ `Cpt1` ; si l'utilisateur a modifié la saisie, une
  autre plage (ou aucune) est supprimée ; erreur d'exécution si aucune ligne n'est sélectionnée ·
  tests : T04 · sources : [Rubcompt.class:224](../../../../../.src/Compta/Utils/Rubcompt.class#L224)
- [ ] RUBCOMPT-A03 — [anomalie, SQLite] Le drapeau `amortissement` est comparé à `"T"` (texte d'un
  booléen Gambas) ; sous SQLite la valeur lue est probablement `1`/`0` : la case n'est jamais
  cochée au clic (à confirmer) · tests : T03, T06 · sources : [Rubcompt.class:70](../../../../../.src/Compta/Utils/Rubcompt.class#L70), [Rubcompt.class:83](../../../../../.src/Compta/Utils/Rubcompt.class#L83)
- [ ] RUBCOMPT-A04 — [anomalie] Fin de plage proposée : `String$(8 - Len(Cpt1), "9")` avec un
  compte de plus de 8 caractères (longueur négative, erreur probable à confirmer) · tests : T08 ·
  sources : [Rubcompt.class:134](../../../../../.src/Compta/Utils/Rubcompt.class#L134)
- [ ] RUBCOMPT-A05 — [anomalie] `Btn_KeyPress` enregistre sur **toute** touche pressée quand le
  focus est sur « Enregistrer » (Tab, Échap…), en plus du clic · tests : T07 · sources : [Rubcompt.class:Btn_KeyPress](../../../../../.src/Compta/Utils/Rubcompt.class#L172-L181)
