# EdPrep — Rework

> Source : `.src/Gestion/Impressions/EdPrep.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdPrep.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 350 |
| Lignes de commentaire | 25 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 70 |
| Complexité max (fonction) | 43 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 350 | 70 | 43 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDPREP-001 — [documentation] En-tête : les deux sorties (liste affichée, bons imprimés
  directement), l'export expédition et le format du commentaire véhicule `XX` · appelants : aucun ·
  tests : aucun · sources : [EdPrep.class:Button1_Click](../../../../../.src/Gestion/Impressions/EdPrep.class#L47-L317), [EdPrep.class:Button3_Click](../../../../../.src/Gestion/Impressions/EdPrep.class#L319-L373)
- [ ] EDPREP-002 — [code mort] Supprimer `Frmt`, `Coulfond` (calculés, jamais lus), `TypeD`
  (jamais affecté : remplacé par `""`), `Nbpage`, `Shell "cd …"`, les affectations écrasées
  d'`intitule`/`intitule2` · appelants : aucun · tests : T01-T07 · sources : [EdPrep.class:39](../../../../../.src/Gestion/Impressions/EdPrep.class#L39), [EdPrep.class:40](../../../../../.src/Gestion/Impressions/EdPrep.class#L40), [EdPrep.class:29](../../../../../.src/Gestion/Impressions/EdPrep.class#L29), [EdPrep.class:100](../../../../../.src/Gestion/Impressions/EdPrep.class#L100), [EdPrep.class:220](../../../../../.src/Gestion/Impressions/EdPrep.class#L220)
- [ ] EDPREP-003 — [réduction de portée] `donnees1` → `Private` (appelé seulement par
  `Button3_Click`) · appelants : aucun · tests : T06 · sources : [EdPrep.class:donnees1](../../../../../.src/Gestion/Impressions/EdPrep.class#L403-L407)
- [ ] EDPREP-004 — [complexité] `Button1_Click` (CC 43) : extraire `ImprimeListe`,
  `ImprimeBonsPreparation`, `AdresseLivraison(numbl, cli)` ; sorties identiques (les deux variantes
  de saut de page sont conservées jusqu'à A02) · appelants : aucun · tests : T01-T05 · sources : [EdPrep.class:Button1_Click](../../../../../.src/Gestion/Impressions/EdPrep.class#L47-L317)
- [ ] EDPREP-005 — [complexité] Requête des lignes simplifiée (`where num_ligbl = &1`, condition
  redondante retirée) et nom du fournisseur par jointure ; `Cbase.Table` pour `TabAdrC`,
  `TabLigbl`, `TabArt`, `TabFour` (SQL modifié, dump identique, texte PDF identique) · appelants :
  aucun · tests : T01, T02, T05 · sources : [EdPrep.class:243](../../../../../.src/Gestion/Impressions/EdPrep.class#L243), [EdPrep.class:250](../../../../../.src/Gestion/Impressions/EdPrep.class#L250), [EdPrep.class:98](../../../../../.src/Gestion/Impressions/EdPrep.class#L98)
- [ ] EDPREP-006 — [séparation traitement/GUI] `CommandesEnCours(sOrdre)` et
  `LigneExpedition(numbl, intitule) As String` (pure, testable) ; ouverture du CSV après la requête
  seulement si le comportement est identique (fichier vide créé aujourd'hui sans commande : à
  conserver) · appelants : aucun · tests : T06, T07 · sources : [EdPrep.class:328](../../../../../.src/Gestion/Impressions/EdPrep.class#L328), [EdPrep.class:352](../../../../../.src/Gestion/Impressions/EdPrep.class#L352)
- [ ] EDPREP-007 — [commonalisation] Liste des documents (`level2d`, détail, sauts de page)
  commune avec `EdDocs` (seuils 180/194 en paramètre) · appelants : aucun · tests : T01, T02 et
  ceux d'`EdDocs` · sources : [EdPrep.class:86](../../../../../.src/Gestion/Impressions/EdPrep.class#L86), [EdDocs.class:Button1_Click](../../../../../.src/Gestion/Impressions/EdDocs.class#L48-L216)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDPREP-A01 — [anomalie] Bon de préparation : `Burdis2 = Left$(Burdis, 30)` imprime le code
  postal et la ville de **facturation** dans le bloc de livraison (au lieu de `Burdis2`) · tests :
  T03 · sources : [EdPrep.class:225](../../../../../.src/Gestion/Impressions/EdPrep.class#L225), [EdPrep.class:238](../../../../../.src/Gestion/Impressions/EdPrep.class#L238)
- [ ] EDPREP-A02 — [anomalie] Saut de page des bons : date de commande brute (format Gambas) au lieu
  de `dd.mm.yyyy`, et en-tête société absent quand le saut survient dans les commentaires · tests :
  T05 · sources : [EdPrep.class:214](../../../../../.src/Gestion/Impressions/EdPrep.class#L214), [EdPrep.class:267](../../../../../.src/Gestion/Impressions/EdPrep.class#L267), [EdPrep.class:285](../../../../../.src/Gestion/Impressions/EdPrep.class#L285)
- [ ] EDPREP-A03 — [anomalie] Export sans commande : `Expedition.csv` ouvert avant la requête et
  jamais fermé (descripteur ouvert jusqu'à la fermeture de l'écran) · tests : T07 · sources : [EdPrep.class:328](../../../../../.src/Gestion/Impressions/EdPrep.class#L328), [EdPrep.class:360](../../../../../.src/Gestion/Impressions/EdPrep.class#L360)
