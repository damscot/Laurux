# EtiqPromo — Rework

> Source : `.src/Gestion/Etiquettes/EtiqPromo.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/EtiqPromo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 306 |
| Lignes de commentaire | 13 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 69 |
| Complexité max (fonction) | 20 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 306 | 69 | 20 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIQPROMO-001 — [documentation] En-tête en français : rôle, choix du prix (début/fin), 3
  exemplaires en A4, positionnement avant/après selon `Nb` · appelants : aucun · tests : T01 · sources : [EtiqPromo.class:_New](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L29-L48), [EtiqPromo.class:Imprime](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L202-L293)
- [ ] ETIQPROMO-002 — [code mort] Supprimer `Init` (jamais appelée), les membres `Rect`, `SorP`, la
  valeur `Filename` inutile, `Shell "cd ~"` ; paramètres ignorés
  `pht`/`pttc` d'`Imprime` retirés (appel interne) · appelants : aucun · tests : T01-T05 · sources : [EtiqPromo.class:Init](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L158-L187), [EtiqPromo.class:125](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L125), [EtiqPromo.class:Imprime](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L202-L293)
- [ ] ETIQPROMO-003 — [séparation traitement/GUI] `ArticlesPromo(code)` et lecture des valeurs
  d'étiquette sans contrôle ; options (`Deb`, imprimante) passées en paramètre · appelants : aucun ·
  tests : T01-T03 · sources : [EtiqPromo.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L95-L156), [EtiqPromo.class:Imprime](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L202-L293)
- [ ] ETIQPROMO-004 — [réduction de portée] `init_ComboBox`, `fin_impression`, `Imprime`,
  `pos_Etiq` → `Private` · appelants : aucun · tests : T01-T05 · sources : [EtiqPromo.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L67-L83), [EtiqPromo.class:fin_impression](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L189-L199), [EtiqPromo.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L295-L326)
- [ ] ETIQPROMO-005 — [commonalisation] `init_ComboBox`, format, ouverture PDF, `pos_Etiq` (V5) et
  `fin_impression` via `PlancheEtiquettes` (après ETIQART-010) ; PDF identique · appelants : aucun
  · tests : T01, T04, T05 · sources : [EtiqPromo.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L295-L326), [EtiqPromo.class:fin_impression](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L189-L199), [EtiqPromo.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L67-L83)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIQPROMO-A01 — [anomalie] Imprimante Zebra : aucun PDF, `pdf.Open()` sur `Null` ; `Connect`
  jamais appelée (ZEBRA-A01) · tests : T06 · sources : [EtiqPromo.class:130](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L130), [EtiqPromo.class:Connect](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L328-L347)
- [ ] ETIQPROMO-A02 — [anomalie] `Imprime` joint `Fiches_ArtPromo` sans filtrer `code_promo` : un
  article présent dans plusieurs promotions peut recevoir les prix d'une autre promotion · tests :
  T03 · sources : [EtiqPromo.class:227](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L227)
- [ ] ETIQPROMO-A03 — [anomalie] `pos_Etiq` V5 : seuil `i2 > Nbhauteur` (une rangée de plus que la
  planche, imprimée hors page), espacement compté une fois (décalage dès la 3e colonne), format lu
  par `code` seul ; membre `Nb` jamais remis à faux entre deux impressions · tests : T04 · sources : [EtiqPromo.class:301](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L301), [EtiqPromo.class:308](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L308), [EtiqPromo.class:110](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L110)
- [ ] ETIQPROMO-A04 — [anomalie] Lecture de l'article sans test `Available` (ligne `ArtPromo`
  orpheline → erreur) · tests : T07 · sources : [EtiqPromo.class:228](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L228)
- [ ] ETIQPROMO-A05 — [anomalie] Branche Zebra (morte) : passe le TextBox `Code` (code promotion)
  comme code article à `Zebra.Gondole1` ; à corriger si ZEBRA-A01 est tranchée en faveur du
  branchement · tests : T06 · sources : [EtiqPromo.class:287](../../../../../.src/Gestion/Etiquettes/EtiqPromo.class#L287)
