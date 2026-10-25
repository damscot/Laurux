# Etiqcasier — Rework

> Source : `.src/Gestion/Etiquettes/Etiqcasier.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Etiqcasier.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 793 |
| Lignes de commentaire | 72 |
| Fonctions | 35 |
| Fonctions Public | 35 |
| Complexité cyclomatique totale | 187 |
| Complexité max (fonction) | 24 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 793 | 187 | 24 | 0 | 35 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIQCASIER-001 — [documentation] En-tête en français : rôle, mises en page A4/Dymo, renvoi à
  Etiqart pour la partie commune · appelants : aucun · tests : T01 · sources : [Etiqcasier.class:_new](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L66-L70), [Etiqcasier.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L876-L943)
- [ ] ETIQCASIER-002 — [code mort] Supprimer `Art1_man`, membres jamais lus (`SorP`, couleurs,
  `dte`), `Shell "cd ~"`, commentaire `'Etiqart.visible` · appelants : aucun · tests : T01-T08 · sources : [Etiqcasier.class:Art1_man](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L692-L711), [Etiqcasier.class:789](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L789), [Etiqcasier.class:fin_impression](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L860-L873)
- [ ] ETIQCASIER-003 — [commonalisation] Listes famille/fournisseur dans `EtiqArticles`
  (ETIQART-003, même commit) · appelants : `Etiqart`, `Etigond` · tests : T01 · sources : [Etiqcasier.class:ToggleButton3_Click](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L172-L203), [Etiqcasier.class:Colfour2_Click](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L455-L462)
- [ ] ETIQCASIER-004 — [commonalisation] Requête de sélection et contrôles de borne dans
  `EtiqArticles` (ETIQART-004) · appelants : `Etiqart`, `Etigond` · tests : T01 · sources : [Etiqcasier.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L756-L858), [Etiqcasier.class:Art2_man](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L713-L732)
- [ ] ETIQCASIER-005 — [commonalisation] Table de travail `Etiquettes` dans `EtiqArticles`
  (ETIQART-005 ; filtre casier en paramètre, affichage `listBart`) · appelants : `Etiqart`,
  `Etigond`, `Eticli` · tests : T04, T08 · sources : [Etiqcasier.class:liste_Click](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L588-L616), [Etiqcasier.class:Art_man](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L633-L690)
- [ ] ETIQCASIER-006 — [complexité] `Button2_Click` (CC 24) découpé comme ETIQART-006 · appelants :
  aucun · tests : T01-T07 · sources : [Etiqcasier.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L756-L858)
- [ ] ETIQCASIER-007 — [séparation traitement/GUI] `Imprime` : valeurs de l'article et nombre
  d'étiquettes séparés du dessin ; `Art_man` sans `Message` pour l'ajout en table · appelants :
  aucun · tests : T04, T07 · sources : [Etiqcasier.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L876-L943), [Etiqcasier.class:Art_man](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L633-L690)
- [ ] ETIQCASIER-008 — [réduction de portée] `init_ComboBox`, `SelectionArt`, `Art_man`,
  `Art2_man`, `ChkInput`, `Button2_Click`, `fin_impression`, `Imprime`, `pos_Etiq`,
  `Import_Portable` → `Private` · appelants : aucun · tests : T01-T08 · sources : [Etiqcasier.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L108-L124), [Etiqcasier.class:SelectionArt](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L141-L167), [Etiqcasier.class:Import_Portable](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L993-L1006)
- [ ] ETIQCASIER-009 — [commonalisation] Format, ouverture PDF, `pos_Etiq` (V3) et sortie via
  `PlancheEtiquettes` (après ETIQART-010) ; dessin casier partagé avec `EtiqRecpt` si PDF identique
  · appelants : `EtiqRecpt` (ETIQRECPT-006) · tests : T01, T03, T05, T09 · sources : [Etiqcasier.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L945-L967), [Etiqcasier.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L876-L943), [EtiqRecpt.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L121-L310)
- [ ] ETIQCASIER-010 — [complexité] `Cbase.Table("TabEtiq")` ; un seul `Utils.Observers(Me)` (dump
  inchangé, log sans doublons) · appelants : aucun · tests : T01-T08 · sources : [Etiqcasier.class:775](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L775), [Etiqcasier.class:85](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L85), [Etiqcasier.class:89](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L89)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIQCASIER-A01 — [anomalie] Imprimante Zebra : pas de PDF, `pdf.Open()` sur `Null` ;
  `Connect` jamais appelée (ZEBRA-A01) · tests : T06 · sources : [Etiqcasier.class:798](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L798), [Etiqcasier.class:Connect](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L969-L988), [Etiqcasier.class:936](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L936)
- [ ] ETIQCASIER-A02 — [anomalie] Format lu par `code` seul alors que la clé est `(code, page)` : la
  page choisie dans la liste est ignorée si le code existe pour plusieurs pages · tests : T02 · sources : [Etiqcasier.class:775](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L775)
- [ ] ETIQCASIER-A03 — [anomalie] `pos_Etiq` V3 : `Esplargeur` ajouté une seule fois, décalage dès
  la 3e colonne (harmonisation avec V1 à valider, change le PDF) · tests : T03 · sources : [Etiqcasier.class:951](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L951)
- [ ] ETIQCASIER-A04 — [anomalie] Comportements hérités d'Etiqart : table `Etiquettes` permanente
  (ETIQART-A04), article orphelin de la liste → erreur (ETIQART-A03), import portable qui ouvre le
  PDF (ETIQART-A02), PDF et aide partagés avec Etiqart · tests : T04, T08 · sources : [Etiqcasier.class:608](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L608), [Etiqcasier.class:835](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L835), [Etiqcasier.class:1000](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L1000), [Etiqcasier.class:1010](../../../../../.src/Gestion/Etiquettes/Etiqcasier.class#L1010)
