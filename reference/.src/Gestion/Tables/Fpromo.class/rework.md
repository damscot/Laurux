# Fpromo — Rework

> Source : `.src/Gestion/Tables/Fpromo.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Fpromo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 186 |
| Lignes de commentaire | 34 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 8 (`Cmpt_Keypress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 186 | 43 | 8 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FPROMO-001 — [documentation] En-tête : rôle, lien avec FpromoArt, suppression en cascade,
  lecteurs des promotions · appelants : aucun · tests : aucun · sources : [Fpromo.class:20](../../../../../.src/Gestion/Tables/Fpromo.class#L20)
- [ ] FPROMO-002 — [code mort] Supprimer `Deb3` (jamais appelée) et les variables de couleur
  calculées mais inutilisées (`CoulZns`, `CoulZnaf`, `Coulfc`) · appelants : aucun · tests :
  T01 · sources : [Fpromo.class:Deb3](../../../../../.src/Gestion/Tables/Fpromo.class#L179-L183), [Fpromo.class:_New](../../../../../.src/Gestion/Tables/Fpromo.class#L36-L66)
- [ ] FPROMO-003 — [complexité] `UPdate … SET libelle = &2, datedeb = &3, datefin = &4 where
  code = &1` (la clé n'est plus réécrite) ; SQL modifié, dump identique · appelants : aucun ·
  tests : T02 · sources : [Fpromo.class:214](../../../../../.src/Gestion/Tables/Fpromo.class#L214)
- [ ] FPROMO-004 — [séparation traitement/GUI] `EnregistrePromo`, `SupprimePromo` (cascade),
  `LitPromo` sans contrôle · appelants : aucun · tests : T01-T05 · sources : [Fpromo.class:Button3_Click](../../../../../.src/Gestion/Tables/Fpromo.class#L207-L226), [Fpromo.class:Button2_Click](../../../../../.src/Gestion/Tables/Fpromo.class#L231-L248), [Fpromo.class:Maj_Zones](../../../../../.src/Gestion/Tables/Fpromo.class#L268-L281)
- [ ] FPROMO-005 — [commonalisation] Module `Promo` partagé avec FpromoArt (lecture, liste,
  suppression) et helper de calendrier commun avec Edsdepots, MvtDepots, Sdepots · appelants :
  aucun · tests : T01-T05, FPROMOART-T01-T06 · sources : [Fpromo.class:ToggleButton1_Click](../../../../../.src/Gestion/Tables/Fpromo.class#L136-L145), [Fpromo.class:DateChooser1_Activate](../../../../../.src/Gestion/Tables/Fpromo.class#L158-L171), [FpromoArt.class:Cpromo](../../../../../.src/Gestion/Tables/FpromoArt.class#L174-L195), [Edsdepots.class:DateChooser1_Activate](../../../../../.src/Gestion/Depots/Edsdepots.class#L327-L336)
- [ ] FPROMO-006 — [réduction de portée] `Deb2`, `Button3_Click`, `Button2_Click`, `CleanChamps`,
  `Maj_Zones` → `Private` ; `ColPromo_Click` reste `Public` (rejeu) · appelants : aucun · tests :
  T01-T05 · sources : [Fpromo.class:Deb2](../../../../../.src/Gestion/Tables/Fpromo.class#L173-L177), [Fpromo.class:CleanChamps](../../../../../.src/Gestion/Tables/Fpromo.class#L259-L266), [Fpromo.class:Maj_Zones](../../../../../.src/Gestion/Tables/Fpromo.class#L268-L281)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FPROMO-A01 — [anomalie] Aucun contrôle des dates (début ≤ fin, date vide convertie en `''`) ·
  tests : T03 · sources : [Fpromo.class:212](../../../../../.src/Gestion/Tables/Fpromo.class#L212), [Fpromo.class:214](../../../../../.src/Gestion/Tables/Fpromo.class#L214)
- [ ] FPROMO-A02 — [anomalie] Suppression en cascade sans transaction ; `Maj_Zones` sans test
  `Available` et `Catch` muet (erreurs masquées) · tests : T04 · sources : [Fpromo.class:239](../../../../../.src/Gestion/Tables/Fpromo.class#L239), [Fpromo.class:240](../../../../../.src/Gestion/Tables/Fpromo.class#L240), [Fpromo.class:Maj_Zones](../../../../../.src/Gestion/Tables/Fpromo.class#L268-L281)
