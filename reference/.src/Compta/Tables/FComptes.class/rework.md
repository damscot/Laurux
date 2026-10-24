# FComptes — Rework

> Source : `.src/Compta/Tables/FComptes.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FComptes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 919 |
| Lignes de commentaire | 53 |
| Fonctions | 60 |
| Fonctions Public | 60 |
| Complexité cyclomatique totale | 271 |
| Complexité max (fonction) | 48 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 919 | 271 | 48 | 0 | 60 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCOMPTES-001 — [documentation] En-tête en français (le fichier n'en a pas) : rôle, onglets,
  règles de type par tranche de numéros, contrôles de suppression, rôle du drapeau `Enr`, points
  d'entrée modaux · appelants : aucun · tests : aucun · sources : [FComptes.class:_New](../../../../../.src/Compta/Tables/FComptes.class#L35-L44), [FComptes.class:Button2_Click](../../../../../.src/Compta/Tables/FComptes.class#L297-L396), [FComptes.class:Button1_Click](../../../../../.src/Compta/Tables/FComptes.class#L402-L469)
- [ ] FCOMPTES-002 — [code mort] Supprimer `Cdate_EXT`, `lpad`, `cpoint`, les membres `soldec`,
  `Ncode`, `Type2` (affectés, jamais lus), l'appel inaccessible `collman("F")` et les `Else` vides ·
  appelants : aucun · tests : T01-T08 · sources : [FComptes.class:Cdate_EXT](../../../../../.src/Compta/Tables/FComptes.class#L17-L21), [FComptes.class:lpad](../../../../../.src/Compta/Tables/FComptes.class#L23-L27), [FComptes.class:cpoint](../../../../../.src/Compta/Tables/FComptes.class#L29-L33), [FComptes.class:4](../../../../../.src/Compta/Tables/FComptes.class#L4), [FComptes.class:316](../../../../../.src/Compta/Tables/FComptes.class#L316)
- [ ] FCOMPTES-003 — [réarchitecture] `Cbase.Table` (`TabComptes`, `TabMvt…`, `TabMvtM…`, `TabTvav`,
  `TabTvac`) pour les noms en dur (SQL identique ; `Fiches_SousComptes` reste en dur faute de clé) ·
  appelants : aucun · tests : T01-T07 · sources : [FComptes.class:Button1_Click](../../../../../.src/Compta/Tables/FComptes.class#L402-L469), [FComptes.class:Button2_Click](../../../../../.src/Compta/Tables/FComptes.class#L297-L396), [FComptes.class:Tvaveman](../../../../../.src/Compta/Tables/FComptes.class#L517-L540), [FComptes.class:Tvaacman](../../../../../.src/Compta/Tables/FComptes.class#L627-L650)
- [ ] FCOMPTES-004 — [commonalisation] Paires TVA ventes/achats (`ToggleButton2/3`,
  `Tvalist2_*`/`Tvalist_*`, `Tvaveman`/`Tvaacman`) → procédures paramétrées ; handlers conservés
  (corps délégués) · appelants : aucun · tests : T03 · sources : [FComptes.class:ToggleButton2_Click](../../../../../.src/Compta/Tables/FComptes.class#L474-L512), [FComptes.class:ToggleButton3_Click](../../../../../.src/Compta/Tables/FComptes.class#L584-L622), [FComptes.class:Tvaveman](../../../../../.src/Compta/Tables/FComptes.class#L517-L540), [FComptes.class:Tvaacman](../../../../../.src/Compta/Tables/FComptes.class#L627-L650)
- [ ] FCOMPTES-005 — [commonalisation] `Co_*`/`Intit_*` (Click, Dblclick, KeyPress) → `ChoixTri(...)`
  et `Recherche()` communs ; handlers conservés · appelants : aucun · tests : T08 · sources : [FComptes.class:Co_Click](../../../../../.src/Compta/Tables/FComptes.class#L759-L769), [FComptes.class:Intit_Click](../../../../../.src/Compta/Tables/FComptes.class#L792-L802), [FComptes.class:Co_KeyPress](../../../../../.src/Compta/Tables/FComptes.class#L782-L790), [FComptes.class:Intit_KeyPress](../../../../../.src/Compta/Tables/FComptes.class#L815-L823)
- [ ] FCOMPTES-006 — [complexité] `Button1_Click` : `CompteMouvemente(sCode)` construit les deux
  `UNION` par boucle (texte SQL identique) · appelants : aucun · tests : T05 · sources : [FComptes.class:430](../../../../../.src/Compta/Tables/FComptes.class#L430), [FComptes.class:440](../../../../../.src/Compta/Tables/FComptes.class#L440)
- [ ] FCOMPTES-007 — [séparation traitement/GUI] `Button2_Click` : `TypeParNumero(sCode, sType)`
  pure (tranches et types forcés) et `EnregistreCompte(...)` (INSERT/UPDATE inchangés, formes des
  booléens conservées) ; CC 48 → ≤ 15 visé · appelants : aucun · tests : T01-T04, T10 · sources : [FComptes.class:Button2_Click](../../../../../.src/Compta/Tables/FComptes.class#L297-L396)
- [ ] FCOMPTES-008 — [séparation traitement/GUI] `RepartitionEquilibree(sTotal, iNb, bPrec)` pure
  reproduisant exactement `Quitter_Postes` ; `LitCompte(sCode)` partagé par `Maj_Zones` et
  `Comptman` (même requête) · appelants : aucun · tests : T07, T11 · sources : [FComptes.class:Quitter_Postes](../../../../../.src/Compta/Tables/FComptes.class#L1147-L1155), [FComptes.class:Maj_Zones](../../../../../.src/Compta/Tables/FComptes.class#L60-L107), [FComptes.class:Comptman](../../../../../.src/Compta/Tables/FComptes.class#L693-L716)
- [ ] FCOMPTES-009 — [réarchitecture] `Ventilations` : requête paramétrée `WHERE code = &1` (texte SQL
  identique pour un code sans apostrophe, la zone code étant limitée à 8 caractères de compte) ·
  appelants : aucun · tests : T06 · sources : [FComptes.class:927](../../../../../.src/Compta/Tables/FComptes.class#L927)
- [ ] FCOMPTES-010 — [réduction de portée] `Maj_Zones`, `cleanChamps`, `Refresh`, `Tvaveman`,
  `Tvaacman`, `Comptman`, `Tris`, `Dbclk`, `Ref`, `Ventilations`, `CleanVtl`, `Ventilman`,
  `Aff_Analytique`, `Quitter_Postes`, `collman` → `Private` ; `Bsel`/`Bval` restent `Public` ·
  appelants : aucun · tests : T01-T09 · sources : [FComptes.class:Maj_Zones](../../../../../.src/Compta/Tables/FComptes.class#L60-L107), [FComptes.class:collman](../../../../../.src/Compta/Tables/FComptes.class#L1157-L1202), [FComptes.class:Quitter_Postes](../../../../../.src/Compta/Tables/FComptes.class#L1147-L1155)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCOMPTES-A01 — [anomalie] `Vents_KeyPress` et `Postes_KeyPress` posent la question de
  suppression à **chaque touche** (flèches comprises) avant de tester Suppr · tests : T06, T07 · sources : [FComptes.class:901](../../../../../.src/Compta/Tables/FComptes.class#L901), [FComptes.class:1132](../../../../../.src/Compta/Tables/FComptes.class#L1132)
- [ ] FCOMPTES-A02 — [anomalie] `Quitter_Postes` : `Qpostes` n'est jamais remis à vrai quand la
  répartition est vidée (total `"0"`) ; fermeture et changement de compte bloqués ; comparaison du
  total en texte (`"100"`) · tests : T07, T11 · sources : [FComptes.class:1149](../../../../../.src/Compta/Tables/FComptes.class#L1149), [FComptes.class:1150](../../../../../.src/Compta/Tables/FComptes.class#L1150)
- [ ] FCOMPTES-A03 — [anomalie] La suppression contrôle les types sur la fiche affichée mais
  supprime le compte de la ligne de grille (`Colco.row`) ; erreur si aucune ligne ; pas de contrôle
  TVA/journaux/analytique, `Fiches_Analytiques` orphelines · tests : T05 · sources : [FComptes.class:428](../../../../../.src/Compta/Tables/FComptes.class#L428), [FComptes.class:448](../../../../../.src/Compta/Tables/FComptes.class#L448), [FComptes.class:449](../../../../../.src/Compta/Tables/FComptes.class#L449)
- [ ] FCOMPTES-A04 — [anomalie] Drapeau `Enr` partagé : pour un type autre que `B`/`G`/`C`
  (ex. `A`), l'enregistrement dépend du dernier contrôle TVA/ventilation exécuté (silencieux sinon) ;
  `collman` teste le membre `type` au lieu du paramètre `Typc` · tests : T04 · sources : [FComptes.class:317](../../../../../.src/Compta/Tables/FComptes.class#L317), [FComptes.class:318](../../../../../.src/Compta/Tables/FComptes.class#L318), [FComptes.class:1178](../../../../../.src/Compta/Tables/FComptes.class#L1178)
- [ ] FCOMPTES-A05 — [anomalie] `Cmpt3_KeyPress` : F1 inaccessible (imbriqué dans le test
  Entrée) ; `Music.Play` sans test de `son` pour le type `A` · tests : T01, T07 · sources : [FComptes.class:1018](../../../../../.src/Compta/Tables/FComptes.class#L1018), [FComptes.class:346](../../../../../.src/Compta/Tables/FComptes.class#L346)
- [ ] FCOMPTES-A06 — [anomalie] `Maj_Zones` lit le compte sans test `Available` ; condition
  d'affichage de l'onglet analytique dépendante de la précédence `And`/`Or` (à confirmer) · tests :
  T07, T08 · sources : [FComptes.class:65](../../../../../.src/Compta/Tables/FComptes.class#L65), [FComptes.class:99](../../../../../.src/Compta/Tables/FComptes.class#L99)
- [ ] FCOMPTES-A07 — [anomalie] `Button6_Click` : l'UPDATE `WHERE code_vtl = &2` rattache au compte
  courant un sous-compte déjà ventilé sur un autre compte, sans avertissement · tests : T06 · sources : [FComptes.class:881](../../../../../.src/Compta/Tables/FComptes.class#L881)
