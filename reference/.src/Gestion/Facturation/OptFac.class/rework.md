# OptFac — Rework

> Source : `.src/Gestion/Facturation/OptFac.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/OptFac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 389 |
| Lignes de commentaire | 21 |
| Fonctions | 43 |
| Fonctions Public | 43 |
| Complexité cyclomatique totale | 91 |
| Complexité max (fonction) | 16 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 389 | 91 | 16 | 0 | 43 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] OPTFAC-001 — [documentation] En-tête : rôle, signature du constructeur et consommation de
  `Parent` par `Form` (arguments après les obligatoires), table case ↔ membre d'`ObjFac` ↔ clé
  `LocalSettings` · appelants : aucun · tests : aucun · sources : [OptFac.class:_new](../../../../../.src/Gestion/Facturation/OptFac.class#L10-L110)
- [ ] OPTFAC-002 — [code mort] Supprimer la variable `res` de `_new` (le paramètre `mttc`,
  inutilisé, reste dans la signature pour ne pas toucher aux appelants) et la double écriture de
  `/Recap` dans `form_Close` · appelants : aucun · tests : T03 · sources : [OptFac.class:13](../../../../../.src/Gestion/Facturation/OptFac.class#L13), [OptFac.class:135](../../../../../.src/Gestion/Facturation/OptFac.class#L135)
- [ ] OPTFAC-003 — [réduction de portée] `Aff_AdrC` → `Private` (appelée par
  `ToggleButton10_Click` et `Colal_Keypress` seulement) · appelants : aucun · tests : T04 ·
  sources : [OptFac.class:Aff_AdrC](../../../../../.src/Gestion/Facturation/OptFac.class#L363-L399)
- [ ] OPTFAC-004 — [séparation traitement/GUI] `form_Close` : extraire `SauveOptions()` (cases →
  `LocalSettings`) et `MajAdresseLivraison()` (SQL `Fiches_AdrlivBL`, identique) · appelants :
  aucun · tests : T03, T04 · sources : [OptFac.class:form_Close](../../../../../.src/Gestion/Facturation/OptFac.class#L120-L158)
- [ ] OPTFAC-005 — [complexité] `Dtech_LostFocus` : comparer `$vfac.dteech.L <> Dtech.dte.L`
  au lieu des références d'objets (l'`UPDATE` n'est plus émis sans changement : SQL modifié,
  dump identique) · appelants : aucun · tests : T05 · sources : [OptFac.class:Dtech_LostFocus](../../../../../.src/Gestion/Facturation/OptFac.class#L172-L179)
- [ ] OPTFAC-006 — [commonalisation] Table commune `[clé LocalSettings, membre]` dans `ObjFac`,
  utilisée pour la lecture (`ObjFac._new`) et l'écriture (`form_Close`) des options · appelants :
  `ObjFac` (même commit) · tests : T03, OBJFAC-T01 · sources : [OptFac.class:form_Close](../../../../../.src/Gestion/Facturation/OptFac.class#L120-L158), [ObjFac.class:_new](../../../../../.src/Gestion/Facturation/ObjFac.class#L166-L285)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] OPTFAC-A01 — [anomalie] `Aff_AdrC("F2")` évalue `$vfac.numcl`, membre inexistant dans
  `ObjFac`/`ObjFacB` → « Unknown symbol » à l'exécution (F2 dans la liste des adresses).
  L'argument est de toute façon inutile (la requête n'a pas de `&1`) · tests : T09 · sources : [OptFac.class:368](../../../../../.src/Gestion/Facturation/OptFac.class#L368)
- [ ] OPTFAC-A02 — [anomalie] `ImpPDF_Click` écrit le Boolean dans `$vfac.pdf` (chemin du PDF
  joint aux factures) au lieu de l'indicateur d'archivage `sauvpdf` : `"T"` est envoyé à
  l'impression, ou la jonction du PDF est supprimée ; `/ImpPDF` est en outre persisté mais jamais
  relu · tests : T08, T03 · sources : [OptFac.class:ImpPDF_Click](../../../../../.src/Gestion/Facturation/OptFac.class#L315-L319), [ObjFac.class:242](../../../../../.src/Gestion/Facturation/ObjFac.class#L242), [OptFac.class:133](../../../../../.src/Gestion/Facturation/OptFac.class#L133)
- [ ] OPTFAC-A03 — [anomalie, à confirmer] `form_Close` lit `$vfac.adrliv.nom` alors que
  `adrliv` reste `Null` tant que la fiche client n'a pas été lue (fin de mois ouvert avec
  `num = ""` et fermé sans édition) → « Null object » probable (une structure Gambas non
  instanciée vaut `Null`, vérifié) · tests : T07 · sources : [OptFac.class:140](../../../../../.src/Gestion/Facturation/OptFac.class#L140), [ObjFac.class:331-332](../../../../../.src/Gestion/Facturation/ObjFac.class#L331-L332)
- [ ] OPTFAC-A04 — [anomalie] `sms_Click` : le second `Replace$` repart de `resent!tel` et annule
  le retrait des points du numéro · tests : T01 (numéro transmis à `Gsm`) · sources : [OptFac.class:537-538](../../../../../.src/Gestion/Facturation/OptFac.class#L537-L538)
- [ ] OPTFAC-A05 — [anomalie] `Dtech_LostFocus` met à jour `Fiches_Bl` en dur : sans effet pour
  une facture archivée ou un document d'entretien (`Fiches_BlM`) · tests : T05, T10 · sources : [OptFac.class:176](../../../../../.src/Gestion/Facturation/OptFac.class#L176)
