# EdArt1 — Rework

> Source : `.src/Gestion/Impressions/EdArt1.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdArt1.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 532 |
| Lignes de commentaire | 65 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 31 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 532 | 122 | 31 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDART1-001 — [documentation] En-tête de classe en français (rôle, menu appelant, fichier
  `~/tmp/Tarif1.pdf`, colonnes imprimées, paramètre `/Soc<XX>/Pvcons`, case `Phot` invisible) ;
  commentaire `'''` sur `Button2_Click`, `SelectionArt`, `art_man` · appelants : aucun · tests :
  aucun · sources : [EdArt1.class:_New](../../../../../.src/Gestion/Impressions/EdArt1.class#L42-L61), [EdArt1.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696)
- [ ] EDART1-002 — [code mort] Supprimer `Frmt`/`Coulfond` (lus, jamais utilisés), `Nbpage`, `dte`,
  `PosX`, le `Shell "cd …"` (sous-processus sans effet), les `With Utils` sans membre abrégé et le
  `Case 1` de `Btn_Click` (inatteignable : `Button1` hors du groupe `Btn`) · appelants : aucun ·
  tests : T01, T10 · sources : [EdArt1.class:_New](../../../../../.src/Gestion/Impressions/EdArt1.class#L42-L61), [EdArt1.class:579](../../../../../.src/Gestion/Impressions/EdArt1.class#L579), [EdArt1.class:Btn_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L435-L451)
- [ ] EDART1-003 — [commonalisation] Remplacer le corps des 4 bascules de liste
  (`ToggleButton3..6_Click`) par un helper commun `EdSelection.ListeCodes(cv, table, code, lib,
  bRaise)` partagé avec `EdArt3`, `EdStk`, `Edmo` (SQL identique) · appelants : aucun · tests : T08 ·
  sources : [EdArt1.class:ToggleButton3_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L80-L113), [EdArt1.class:ToggleButton6_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L269-L302), [EdStk.class:ToggleButton3_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L110-L142), [Edmo.class:ToggleButton1_Click](../../../../../.src/Gestion/Impressions/Edmo.class#L54-L86)
- [ ] EDART1-004 — [commonalisation] `art_man` → `EdSelection.ChercheArticle(code) As Boolean`
  (4 requêtes dans le même ordre), son et message gardés dans l'appelant ; partagé avec `EdArt3`,
  `EdRup` · appelants : aucun · tests : T07 · sources : [EdArt1.class:art_man](../../../../../.src/Gestion/Impressions/EdArt1.class#L356-L382), [EdArt3.class:art_man](../../../../../.src/Gestion/Impressions/EdArt3.class#L352-L378), [EdRup.class:art_man](../../../../../.src/Gestion/Impressions/EdRup.class#L156-L182)
- [ ] EDART1-005 — [séparation traitement/GUI] Extraire de `Button2_Click` la requête
  `SelectArticles(iTri, bornes) As Result` et le formatage pur `LigneTarif(rarts, bMarge) As
  String[]` (sans contrôles), testables ; le handler garde les contrôles et le PDF · appelants :
  aucun · tests : T01 à T06, T11 · sources : [EdArt1.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696)
- [ ] EDART1-006 — [complexité] `Button2_Click` (CC 31) : extraire `EnteteTarif(pdf)` (bloc
  `Entete` + `Level7*` écrit deux fois) et `SautDePage(pdf)` ; même ordre d'appels PdfWriter (CC ≤ 12
  visé) · appelants : aucun · tests : T01 à T04 · sources : [EdArt1.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696)
- [ ] EDART1-007 — [commonalisation] Idiome d'alignement « espace si 2 décimales »
  (`Len(x) - InStr(x, ",") = 2`) → fonction unique `FormatAligne(valeur, nbdec)` (≈ 15 copies dans
  `EdArt1`, `EdArt3`, `EdStk`, `EdRup`, `EdMat`) ; la ligne 623 garde son comportement actuel (voir
  EDART1-A01) · appelants : aucun · tests : T01, T03 · sources : [EdArt1.class:618](../../../../../.src/Gestion/Impressions/EdArt1.class#L618), [EdArt1.class:629](../../../../../.src/Gestion/Impressions/EdArt1.class#L629), [EdStk.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L463-L586)
- [ ] EDART1-008 — [commonalisation] `Button2_Click` d'`EdArt1` et d'`EdArt3` → procédure commune
  `ImprimeTarif(titre, typeClient)` (après EDART1-005/006 et EDART3-005) ; différences paramétrées
  (titre, option marge, coefficient de type client) · appelants : aucun · tests : T01 à T06,
  EDART3-T01 à T04 · sources : [EdArt1.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696), [EdArt3.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt3.class#L626-L763)
- [ ] EDART1-009 — [réduction de portée] `SelectionArt`, `art_man`, `Button2_Click` → `Private`
  (aucun appelant externe ; `Button2` est dans le groupe `btn`, couvert par le replay du bouton) ·
  appelants : aucun · tests : T01, T07, T09 · sources : [EdArt1.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdArt1.class#L330-L351), [EdArt1.class:art_man](../../../../../.src/Gestion/Impressions/EdArt1.class#L356-L382), [EdArt1.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L553-L696)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDART1-A01 — [anomalie] Alignement de `paht` calculé avec `InStr(pvht, ",")` de l'article
  **précédent** (effet visible seulement en mode photo, aujourd'hui inaccessible) · tests : T11 ·
  sources : [EdArt1.class:623](../../../../../.src/Gestion/Impressions/EdArt1.class#L623)
- [ ] EDART1-A02 — [anomalie] `Cmpt_KeyPress` tag 2 (`Art2`) contrôle `Art.Text` au lieu de
  `Art2.Text` et renvoie le focus sur `Art` en cas d'échec · tests : T07 · sources : [EdArt1.class:479](../../../../../.src/Gestion/Impressions/EdArt1.class#L479), [EdArt1.class:art_man](../../../../../.src/Gestion/Impressions/EdArt1.class#L356-L382)
- [ ] EDART1-A03 — [anomalie] `Bsel` jamais remis à `False` avant `TriArticles` : une sélection
  annulée recopie l'article choisi précédemment (même défaut que MATERIEL-A09) · tests : T09 ·
  sources : [EdArt1.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdArt1.class#L330-L351)
- [ ] EDART1-A04 — [anomalie] `Btn_KeyPress` lance l'impression pour **toute** touche sur
  « Imprimer » (Tab, flèches) ; la barre d'espace déclenche probablement deux impressions
  (`KeyPress` puis `Click`, à confirmer) · tests : T01 (manuel) · sources : [EdArt1.class:Btn_KeyPress](../../../../../.src/Gestion/Impressions/EdArt1.class#L453-L460)
- [ ] EDART1-A05 — [anomalie] `art_man` accepte un code fournisseur / code-barre / référence
  centrale sans le remplacer par `art_code` : la plage SQL utilise ensuite la saisie brute (à
  confirmer : comportement voulu ?) · tests : T07 · sources : [EdArt1.class:art_man](../../../../../.src/Gestion/Impressions/EdArt1.class#L356-L382)
- [ ] EDART1-A06 — [anomalie] Échap dans `Colfam2`/`Colfour2` : focus sur le premier champ mais
  sélection du second · tests : T08 · sources : [EdArt1.class:196](../../../../../.src/Gestion/Impressions/EdArt1.class#L196), [EdArt1.class:322](../../../../../.src/Gestion/Impressions/EdArt1.class#L322)
- [ ] EDART1-A07 — [anomalie] Pas de `Catch` dans `Button2_Click` : une erreur (image, SQL) laisse
  le curseur en attente et aucun PDF n'est produit · tests : aucun · sources : [EdArt1.class:598](../../../../../.src/Gestion/Impressions/EdArt1.class#L598), [EdArt1.class:694](../../../../../.src/Gestion/Impressions/EdArt1.class#L694)
