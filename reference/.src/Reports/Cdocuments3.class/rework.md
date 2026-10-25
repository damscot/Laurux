# Cdocuments3 — Rework

> Source : `.src/Reports/Cdocuments3.class` · Message de commit (phase 4) : `reference/.src/Reports/Cdocuments3.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 159 |
| Lignes de commentaire | 9 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 159 | 17 | 2 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CDOCUMENTS3-001 — [documentation] En-tête de classe : gabarit du bon de préparation,
  appelant unique `EdPrep`, séquence d'appel par commande, `Entete` seule méthode qui crée une
  page, coordonnées en mm ; présenter la classe comme « bon de préparation »
  (le nom `Cdocuments3` est conservé) · appelants : aucun · tests : T01 · sources : [Cdocuments3.class:_new](../../../../.src/Reports/Cdocuments3.class#L12-L26), [Cdocuments3.class:Entete](../../../../.src/Reports/Cdocuments3.class#L39-L46)
- [ ] CDOCUMENTS3-002 — [code mort] Supprimer `Lines` et `Level3` (aucun appelant) et la variable
  `Coln` (jamais lue) ; `R2/G2/B2` suivent le sort de `_new` (CDOCUMENTS3-003) · appelants :
  aucun · tests : T01 + `gbc3 -agt` · sources : [Cdocuments3.class:Lines](../../../../.src/Reports/Cdocuments3.class#L30-L36), [Cdocuments3.class:Level3](../../../../.src/Reports/Cdocuments3.class#L186-L192)
- [ ] CDOCUMENTS3-003 — [commonalisation] Hériter du socle PDF commun `PdfLaurux` (PDFWRITER-011, CDOCUMENTS-005) : `_new` et
  `BasPage` identiques à `Cdocuments` sont retirés de ce fichier · appelants : aucun · tests :
  T01, T02 · sources : [Cdocuments3.class:_new](../../../../.src/Reports/Cdocuments3.class#L12-L26), [Cdocuments3.class:BasPage](../../../../.src/Reports/Cdocuments3.class#L206-L212), [Cdocuments.class:BasPage](../../../../.src/Reports/Cdocuments.class#L1202-L1208)
- [ ] CDOCUMENTS3-004 — [réarchitecture] Méthode `EntetePage(ent, numero, client As String[],
  livraison As String[])` qui enchaîne `Entete`, `Entete2`, `cadre`, `adresse`, `adresse2`,
  `Level1` ; utilisée par `EdPrep` aux lignes 213-245 et 284-289 (sortie identique) ; la séquence
  incomplète de la ligne 267 reste inchangée jusqu'à la décision CDOCUMENTS3-A01 · appelants :
  `EdPrep` (même commit) · tests : T02 · sources : [Cdocuments3.class:Entete](../../../../.src/Reports/Cdocuments3.class#L39-L46), [Cdocuments3.class:Entete2](../../../../.src/Reports/Cdocuments3.class#L48-L56), [EdPrep.class:213](../../../../.src/Gestion/Impressions/EdPrep.class#L213), [EdPrep.class:284](../../../../.src/Gestion/Impressions/EdPrep.class#L284)
- [ ] CDOCUMENTS3-005 — [complexité] `adresse`/`adresse2` : boucle sur un tableau de lignes au pas
  de 4 ou 5 mm ; arguments `Cell` normalisés (`False` au lieu de `""`/`" "`, `"L"` au lieu de
  `" L "`), rendu identique dans `PdfWriter.Cell` ; suppression du `SetFont` redondant de
  `Level2` · appelants : aucun · tests : T01 · sources : [Cdocuments3.class:adresse](../../../../.src/Reports/Cdocuments3.class#L72-L95), [Cdocuments3.class:adresse2](../../../../.src/Reports/Cdocuments3.class#L97-L112), [Cdocuments3.class:Level2](../../../../.src/Reports/Cdocuments3.class#L132-L153)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CDOCUMENTS3-A01 — [anomalie, à confirmer par T03] Saut de page dans la boucle des
  commentaires de `EdPrep` : la séquence de la ligne 267 n'appelle pas `Entete`, seule méthode
  qui fait `AddPage` ; l'en-tête, les cadres et les lignes suivantes sont imprimés **sur la même
  page**, par-dessus le contenu. Correction proposée : utiliser `EntetePage` (CDOCUMENTS3-004)
  aux trois endroits, avec la date formatée (EDPREP-A02) ; correction dans `EdPrep`, à reporter
  dans sa documentation · tests : T03 · sources : [EdPrep.class:265](../../../../.src/Gestion/Impressions/EdPrep.class#L265), [EdPrep.class:267](../../../../.src/Gestion/Impressions/EdPrep.class#L267), [Cdocuments3.class:Entete](../../../../.src/Reports/Cdocuments3.class#L39-L46)
