# Etigond — Rework

> Source : `.src/Gestion/Etiquettes/Etigond.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Etigond.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 915 |
| Lignes de commentaire | 80 |
| Fonctions | 39 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 235 |
| Complexité max (fonction) | 51 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 915 | 235 | 51 | 0 | 39 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIGOND-001 — [documentation] En-tête en français : rôle, deux mises en page choisies par
  le libellé du modèle, options d'impression, drapeau `Nb`, renvoi à Etiqart pour la partie
  commune · appelants : aucun · tests : T01 · sources : [Etigond.class:_new](../../../../../.src/Gestion/Etiquettes/Etigond.class#L71-L83), [Etigond.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etigond.class#L865-L995)
- [ ] ETIGOND-002 — [code mort] Supprimer `Art1_man`, `rect` (et son calcul dans `Init`),
  `Tab2 = "Fiches_Tvaav"` jamais utilisé, `SorP`, `dte`, couleurs jamais lues, `Shell "cd ~"`,
  valeur initiale `"EtiqGond.ps"` · appelants : aucun · tests : T01-T12 · sources : [Etigond.class:Art1_man](../../../../../.src/Gestion/Etiquettes/Etigond.class#L702-L717), [Etigond.class:Init](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1070-L1101), [Etigond.class:798](../../../../../.src/Gestion/Etiquettes/Etigond.class#L798), [Etigond.class:776](../../../../../.src/Gestion/Etiquettes/Etigond.class#L776)
- [ ] ETIGOND-003 — [commonalisation] Listes famille/fournisseur dans `EtiqArticles` (voir
  ETIQART-003, même commit) · appelants : `Etiqart`, `Etiqcasier` · tests : T01, T05 · sources : [Etigond.class:ToggleButton3_Click](../../../../../.src/Gestion/Etiquettes/Etigond.class#L188-L219), [Etigond.class:Colfour2_KeyPress](../../../../../.src/Gestion/Etiquettes/Etigond.class#L407-L427), [Etigond.class:Colfam_Click](../../../../../.src/Gestion/Etiquettes/Etigond.class#L432-L440)
- [ ] ETIGOND-004 — [commonalisation] Requête de sélection et contrôles de borne dans
  `EtiqArticles` (ETIQART-004 ; le tri casier passe par `Radiobutton7`) · appelants : `Etiqart`,
  `Etiqcasier` · tests : T05 · sources : [Etigond.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Etigond.class#L761-L848), [Etigond.class:Art2_man](../../../../../.src/Gestion/Etiquettes/Etigond.class#L719-L738)
- [ ] ETIGOND-005 — [commonalisation] Table de travail `Etiquettes` (temporaire ici) et grille dans
  `EtiqArticles` (ETIQART-005) · appelants : `Etiqart`, `Etiqcasier`, `Eticli` · tests : T07, T12 · sources : [Etigond.class:liste_Click](../../../../../.src/Gestion/Etiquettes/Etigond.class#L606-L633), [Etigond.class:Art_man](../../../../../.src/Gestion/Etiquettes/Etigond.class#L650-L700), [Etigond.class:Gridbart_Update](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1109-L1129), [Etigond.class:Gridbart_Click](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1131-L1153)
- [ ] ETIGOND-006 — [complexité] `Imprime` (CC 51) : `DessineGondole`, `DessineArticle` et
  lecture de l'article séparées ; ordre des appels PDF inchangé · appelants : aucun · tests :
  T01-T04, T08 · sources : [Etigond.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etigond.class#L865-L995)
- [ ] ETIGOND-007 — [séparation traitement/GUI] `ValeursEtiquette(rArt)` (prix formatés, TVA, prix
  au kg/l, nombre) sans accès aux contrôles, options passées en paramètre · appelants : aucun ·
  tests : T01-T04, T08 · sources : [Etigond.class:Imprime](../../../../../.src/Gestion/Etiquettes/Etigond.class#L865-L995)
- [ ] ETIGOND-008 — [réduction de portée] `init_ComboBox`, `SelectionArt`, `Art_man`, `Art2_man`,
  `ChkInput`, `Button2_Click`, `fin_impression`, `Imprime`, `pos_Etiq`, `Import_Portable`, `Init`,
  `Gridbart_Update` → `Private` · appelants : aucun · tests : T01-T12 · sources : [Etigond.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etigond.class#L122-L138), [Etigond.class:SelectionArt](../../../../../.src/Gestion/Etiquettes/Etigond.class#L158-L183), [Etigond.class:Init](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1070-L1101), [Etigond.class:Gridbart_Update](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1109-L1129)
- [ ] ETIGOND-009 — [commonalisation] `Init`, ouverture du PDF, `pos_Etiq` (variante V2, identique
  à `EtiqRecpt.pos_Etiq`) et `fin_impression` via `PlancheEtiquettes` (après ETIQART-010) ; PDF
  identique · appelants : aucun · tests : T01, T06, T09, T13 · sources : [Etigond.class:Init](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1070-L1101), [Etigond.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Etigond.class#L997-L1029), [Etigond.class:fin_impression](../../../../../.src/Gestion/Etiquettes/Etigond.class#L850-L862), [EtiqRecpt.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L312-L344)
- [ ] ETIGOND-010 — [complexité] `Cbase.Table("TabEtiq")` pour `Fiches_Etiquettes` ; un seul
  `Utils.Observers(Me)` (log de rejeu sans doublons, dump inchangé) · appelants : aucun · tests :
  T01-T12 · sources : [Etigond.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etigond.class#L122-L138), [Etigond.class:98](../../../../../.src/Gestion/Etiquettes/Etigond.class#L98), [Etigond.class:102](../../../../../.src/Gestion/Etiquettes/Etigond.class#L102)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIGOND-A01 — [anomalie] Imprimante Zebra : aucun PDF créé, `pdf.Open()` sur `Null` ;
  `Connect` jamais appelée (décision commune ZEBRA-A01) · tests : T10 · sources : [Etigond.class:794](../../../../../.src/Gestion/Etiquettes/Etigond.class#L794), [Etigond.class:Connect](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1031-L1050), [Etigond.class:983](../../../../../.src/Gestion/Etiquettes/Etigond.class#L983)
- [ ] ETIGOND-A02 — [anomalie] `Init` saute les positions `Posetiq` **avant** la création du PDF :
  en Dymo, `pos_Etiq` appelle `pdf.NewPage()` dès la 2e position (« Null object » au premier
  passage, page en trop sur un ancien PDF ensuite) ; en A4, idem si `Posetiq` dépasse une page ;
  `Import_Portable` ouvre le PDF dans l'éditeur au lieu de `ImpT.txt` (voir ETIQART-A02) · tests :
  T09, T12 · sources : [Etigond.class:778](../../../../../.src/Gestion/Etiquettes/Etigond.class#L778), [Etigond.class:1094](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1094), [Etigond.class:1062](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1062)
- [ ] ETIGOND-A03 — [anomalie] Mise en page choisie par recherche de « Gondole » / « Article » dans
  le libellé du modèle : en A4, un modèle nommé autrement produit un PDF vide sans message ·
  tests : T03 · sources : [Etigond.class:919](../../../../../.src/Gestion/Etiquettes/Etigond.class#L919), [Etigond.class:954](../../../../../.src/Gestion/Etiquettes/Etigond.class#L954)
- [ ] ETIGOND-A04 — [anomalie] Le membre `Nb` n'est jamais remis à faux : après une impression
  avec `Posetiq > 1`, l'impression suivante place la 1re étiquette en (0, 0) (positions remises à 0
  en fin de traitement) au lieu de la marge (à confirmer en replay) · tests : T06 · sources : [Etigond.class:845](../../../../../.src/Gestion/Etiquettes/Etigond.class#L845), [Etigond.class:1095](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1095), [Etigond.class:921](../../../../../.src/Gestion/Etiquettes/Etigond.class#L921)
- [ ] ETIGOND-A05 — [anomalie] Lectures sans test `Available` : taux de TVA (`code_tva` absent →
  erreur), article orphelin de la liste (erreur dans `Imprime`), liste vide (PDF vide sans
  message) ; aide ouverte sur la page `Etiqart` ; `CheckBox1` décochée affiche « Impression du
  Taux de TVA » alors que la TVA est toujours imprimée · tests : T04, T11 · sources : [Etigond.class:905](../../../../../.src/Gestion/Etiquettes/Etigond.class#L905), [Etigond.class:824](../../../../../.src/Gestion/Etiquettes/Etigond.class#L824), [Etigond.class:1105](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1105), [Etigond.class:CheckBox1_Click](../../../../../.src/Gestion/Etiquettes/Etigond.class#L1155-L1163)
