# Editfac — Rework

> Source : `.src/Reports/Editfac.class` · Message de commit (phase 4) : `reference/.src/Reports/Editfac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 476 |
| Lignes de commentaire | 23 |
| Fonctions | 14 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 154 |
| Complexité max (fonction) | 112 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 476 | 154 | 112 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITFAC-001 — [documentation] En-tête de classe : report gb.report des documents de vente,
  instancié seulement via `EditfacB` (`New EditfacB(Me, Me)` dans `ObjFacB`), contrat des membres
  d'`ObjFacB` lus, rôle de `lgint`/`coef`/`longueur`, handlers `*_Data` et surcharge de
  `code_Data`/`intitule_Data` par `EditfacB` · appelants : aucun · tests : T01-T10 · sources : [Editfac.class:_new](../../../../.src/Reports/Editfac.class#L12-L354), [Editfac.class:code_Data](../../../../.src/Reports/Editfac.class#L415-L425), [Editfac.class:intitule_Data](../../../../.src/Reports/Editfac.class#L427-L441)
- [ ] EDITFAC-002 — [code mort] Supprimer la locale `tot` et l'objet `ctva = New LTaxe`
  (remplacé aussitôt par la boucle `For Each`) · appelants : aucun · tests : T01, T02 · sources : [Editfac.class:17](../../../../.src/Reports/Editfac.class#L17), [Editfac.class:283](../../../../.src/Reports/Editfac.class#L283)
- [ ] EDITFAC-003 — [réduction de portée] `$vfac` → `Private` (aucun usage hors du fichier,
  `EditfacB` utilise `$cal`) · appelants : aucun · tests : T01 · sources : [Editfac.class:3](../../../../.src/Reports/Editfac.class#L3)
- [ ] EDITFAC-004 — [complexité] Découper `_new` (CC 112) en sous-procédures privées appelées
  dans le même ordre (`EnteteSociete`, `AdresseClient`, `TitreDocument`, `Materiel`,
  `ColonnesFacultatives`, `Totaux`, `PiedDocument`, `TableauTva`, `BlNonChiffre`,
  `MasqueBandeauxVides`, `CouleursColonnes`) et helper `Masque(panneau, Optional cellule)` pour
  les séquences `Children.Clear`/`Width = "0mm"`/`Border` ; aucune sous-procédure > CC 20 ·
  appelants : aucun · tests : T01-T10, EDITFACB-T01-T04 · sources : [Editfac.class:_new](../../../../.src/Reports/Editfac.class#L12-L354)
- [ ] EDITFAC-005 — [commonalisation] Fonction `Public LigneDoc(Index) As Variant` (clé
  `"0000"`, `Null` si absente) utilisée par les dix handlers `*_Data` (noms, portée et
  comportement inchangés, y compris `code_Data` sans remise à `" "`) et par les surcharges
  d'`EditfacB` · appelants : `EditfacB` (même commit, facultatif) · tests : T01-T03, EDITFACB-T01-T04 · sources : [Editfac.class:code_Data](../../../../.src/Reports/Editfac.class#L415-L425), [Editfac.class:stk_Data](../../../../.src/Reports/Editfac.class#L443-L454), [Editfac.class:tx_Data](../../../../.src/Reports/Editfac.class#L534-L545), [EditfacB.class:code_data](../../../../.src/Gestion/option/EditfacB.class#L661-L679), [EditfacB.class:intitule_Data](../../../../.src/Gestion/option/EditfacB.class#L681-L703)
- [ ] EDITFAC-006 — [complexité] `edtva` : tableaux de contrôles indexés par `i` au lieu de cinq
  `Case` identiques ; branches `Else` conservées telles quelles jusqu'à la décision EDITFAC-A02 ·
  appelants : aucun · tests : T02, T10 · sources : [Editfac.class:edtva](../../../../.src/Reports/Editfac.class#L356-L411)
- [ ] EDITFAC-007 — [complexité] Requêtes : `Cbase.Table("TabSoc")` et `Cbase.Table("TabBl")`
  au lieu des noms en dur ; comptage des BL par `SELECT COUNT(*) … WHERE cdclibl = &1` au lieu de
  `SELECT *` + `.Count` (SQL modifié, dump identique, même nombre affiché) · appelants : aucun ·
  tests : T01, T05 · sources : [Editfac.class:42](../../../../.src/Reports/Editfac.class#L42), [Editfac.class:119](../../../../.src/Reports/Editfac.class#L119)
- [ ] EDITFAC-008 — [séparation traitement/GUI] Lectures SQL dans des fonctions sans accès aux
  contrôles (`LitSociete(sCode) As Result`, `NbBlClient(sClient) As Integer`) et question
  « masquer les coordonnées du client » dans une fonction privée `MasquerClient() As Boolean` ;
  même message, même moment · appelants : aucun · tests : T01, T05, T06 · sources : [Editfac.class:42](../../../../.src/Reports/Editfac.class#L42), [Editfac.class:86](../../../../.src/Reports/Editfac.class#L86), [Editfac.class:119](../../../../.src/Reports/Editfac.class#L119)
- [ ] EDITFAC-009 — [commonalisation] En-tête société par l'objet `LEnteteSoc` de CDOCUMENTS-006
  (même requête filtrée par `cd_sc`), libellés du report conservés (« site : », `vfac.libsire`) ·
  appelants : aucun · tests : T01, T09 · sources : [Editfac.class:_new](../../../../.src/Reports/Editfac.class#L12-L354), [Cdocuments.class:Entete](../../../../.src/Reports/Cdocuments.class#L96-L196)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITFAC-A01 — [anomalie] Duplicata : `ObjFac.archive` figure dans le premier `Case`
  (ligne 92, commit `537f1ee2`), donc le `Case ObjFac.archive` des lignes 159-160 (« Duplicata
  facture n° ») est inatteignable ; une facture réimprimée depuis l'archive porte le titre
  « Facture n° ». À décider : imprimer « Duplicata » (retirer `archive` du premier `Case` en
  gardant coupon/délais/réserves) ou supprimer la branche morte · tests : T04 · sources : [Editfac.class:92](../../../../.src/Reports/Editfac.class#L92), [Editfac.class:159](../../../../.src/Reports/Editfac.class#L159)
- [ ] EDITFAC-A02 — [anomalie, à confirmer visuellement] `edtva` n'est appelée que pour
  `i < nb` : ses branches `Else` ne s'exécutent jamais, les lignes de TVA inutilisées
  (`ptva1`…`ptva4`, 3 mm chacune) restent affichées vides et `ptva` reste visible sans taxe ;
  au-delà de 5 taux, les suivants sont ignorés sans message. Correction proposée : masquer les
  lignes `i >= nb` après la boucle · tests : T10 · sources : [Editfac.class:285](../../../../.src/Reports/Editfac.class#L285), [Editfac.class:edtva](../../../../.src/Reports/Editfac.class#L356-L411)
- [ ] EDITFAC-A03 — [anomalie, à confirmer] « Total BL a facturer » compte toutes les lignes de
  `Fiches_Bl` du client (`WHERE cdclibl = &1`), y compris devis (`D`), commandes (`C`) et BL déjà
  facturés (`numfac` renseigné) ; filtre attendu : `type = 'B'` et `numfac` nul (règle à valider
  avec l'utilisateur) · tests : T05 · sources : [Editfac.class:119](../../../../.src/Reports/Editfac.class#L119)
