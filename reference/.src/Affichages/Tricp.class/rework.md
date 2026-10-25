# Tricp — Rework

> Source : `.src/Affichages/Tricp.class` · Message de commit (phase 4) : `reference/.src/Affichages/Tricp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 220 |
| Lignes de commentaire | 2 |
| Fonctions | 24 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 88 |
| Complexité max (fonction) | 13 (`colco_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 220 | 88 | 13 | 0 | 24 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRICP-001 — [documentation] En-tête de classe : rôle, signature `_new(sOrg, cdcp)`, tableau
  des origines et des membres écrits (`FClient`, `FFournisseur`, `FClientcarte`, `Variables`),
  absence de remise à zéro de `Bsel`, usage de `Utils.rs2` · appelants : aucun · tests : T01-T07 · sources : [Tricp.class:_new](../../../../.src/Affichages/Tricp.class#L14-L34), [Tricp.class:colco_Click](../../../../.src/Affichages/Tricp.class#L128-L150)
- [ ] TRICP-002 — [complexité] `Deb2`/`Deb3` → `Charge(bDesc)` (texte SQL identique) ;
  `Co_KeyPress`/`Intit_KeyPress` → `Saisie()` commune (ordre des traitements conservé) ;
  suppression des doublons `Dbl = ""` et des branches `IsNull` équivalentes · appelants : aucun ·
  tests : T05, T06 · sources : [Tricp.class:Deb2](../../../../.src/Affichages/Tricp.class#L285-L290), [Tricp.class:Deb3](../../../../.src/Affichages/Tricp.class#L292-L297), [Tricp.class:Co_KeyPress](../../../../.src/Affichages/Tricp.class#L223-L235), [Tricp.class:Intit_KeyPress](../../../../.src/Affichages/Tricp.class#L256-L271), [Tricp.class:Co_Click](../../../../.src/Affichages/Tricp.class#L199-L215)
- [ ] TRICP-003 — [code mort] `CoTable` dimensionné à 2 et rempli une fois dans `_new` au lieu
  d'être réécrit à chaque cellule · appelants : aucun · tests : T05 · sources : [Tricp.class:Colco_Data](../../../../.src/Affichages/Tricp.class#L152-L161)
- [ ] TRICP-004 — [réduction de portée] `Deplacement`, `Tris`, `Dbclk`, `Deb2`, `Deb3` → `Private`
  (aucun appelant externe, vérifié ; couverts par les replays T05, T06) · appelants : aucun ·
  tests : T05, T06 · sources : [Tricp.class:Deplacement](../../../../.src/Affichages/Tricp.class#L117-L126), [Tricp.class:Tris](../../../../.src/Affichages/Tricp.class#L163-L171), [Tricp.class:Dbclk](../../../../.src/Affichages/Tricp.class#L273-L283), [Tricp.class:Deb2](../../../../.src/Affichages/Tricp.class#L285-L290), [Tricp.class:Deb3](../../../../.src/Affichages/Tricp.class#L292-L297)
- [ ] TRICP-005 — [séparation traitement/GUI] `RequeteCp(sTri, sSel, bDesc, iDebut, iNb) As
  String` pure (texte identique), utilisée par `Charge` · appelants : aucun · tests : T05, T08 · sources : [Tricp.class:Deb2](../../../../.src/Affichages/Tricp.class#L285-L290)
- [ ] TRICP-006 — [commonalisation] Pagination (`Descendre_*`, `Remonter_*`, `Colco_MouseWheel`,
  `Deplacement`, flèches de `colco_KeyPress`) vers la classe d'aide `PaginationListe` partagée avec
  `Tricartes`, `TriclientsD`, `TriMat`, `TriEqu`, `TriFac`, `TriBl` (TRICARTES-005) ; handlers
  conservés, SQL identique · appelants : aucun · tests : T06 · sources : [Tricp.class:Colco_MouseWheel](../../../../.src/Affichages/Tricp.class#L64-L73), [Tricp.class:Descendre_Click](../../../../.src/Affichages/Tricp.class#L75-L85), [Tricp.class:Remonter_Click](../../../../.src/Affichages/Tricp.class#L87-L95), [Tricartes.class:Descendre_Click](../../../../.src/Caisse/Affichages/Tricartes.class#L127-L137)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRICP-A01 — [anomalie] Retour de la sélection écrit en dur selon `sOrg` : `"Clientcarte"`
  écrit `FClientcarte.Bsel`, membre inexistant → erreur « Unknown symbol » ; `"Client"` depuis
  `FClientcarte` écrit dans l'auto-instance cachée de `FClient` (rien n'est repris) ;
  `"Fournisseur"` écrit l'auto-instance de `FFournisseur`, perdue pour la fiche ouverte par
  `New FFournisseur` (`Facture:5658`). Correction proposée : passer l'appelant au constructeur et
  écrire `Bsel`/`Codepostal`/`Bureaudistributeur` par `Object.SetProperty` (signature modifiée :
  `FClient`, `FFournisseur`, `Facture`, `FClientcarte` dans le même commit ; voir
  FCLIENTCARTE-A02, FFOURNISSEUR-A07) · tests : T03, T04 · sources : [Tricp.class:132](../../../../.src/Affichages/Tricp.class#L132), [Tricp.class:136](../../../../.src/Affichages/Tricp.class#L136), [Tricp.class:140](../../../../.src/Affichages/Tricp.class#L140), [FClientcarte.class:924](../../../../.src/Caisse/FClientcarte.class#L924), [FClientcarte.class:1015](../../../../.src/Caisse/FClientcarte.class#L1015)
- [ ] TRICP-A02 — [anomalie] Aucune remise à zéro de `Bsel` (ni à l'ouverture ni à l'annulation) :
  après une première sélection, Échap réapplique l'ancien code postal (`Variables.Bsel` pour
  `Facture`/`FClientcarte`, `FClient.Bsel`, `FFournisseur.Bsel`) · tests : T07 · sources : [Tricp.class:_new](../../../../.src/Affichages/Tricp.class#L14-L34), [Tricp.class:144](../../../../.src/Affichages/Tricp.class#L144)
- [ ] TRICP-A03 — [anomalie] `Dbclk` inversé : le premier double-clic recharge en ordre croissant
  et passe `Dbl` à `True`, si bien que les pages suivantes sortent en ordre décroissant ; le tri
  décroissant n'apparaît qu'au second double-clic · tests : T05 · sources : [Tricp.class:Dbclk](../../../../.src/Affichages/Tricp.class#L273-L283)
- [ ] TRICP-A04 — [anomalie] Filtre concaténé dans le SQL (`like "<sel>%"`) ; `"`, `&`, `'` sont
  ignorés pour le filtre mais pas bloqués (affichés dans l'en-tête), `\` provoque une erreur SQL
  (MySQL), `%`/`_` sont des jokers ; toute touche (flèches, Échap) relance la requête · tests : T05 · sources : [Tricp.class:225](../../../../.src/Affichages/Tricp.class#L225), [Tricp.class:287](../../../../.src/Affichages/Tricp.class#L287), [Tricp.class:294](../../../../.src/Affichages/Tricp.class#L294)
- [ ] TRICP-A05 — [anomalie] F1 dans `INTIT` ouvre l'aide « Lettrage » (copier-coller) et un
  `Catch` vide masque toute erreur de `Intit_KeyPress` · tests : aucun (aide externe) · sources : [Tricp.class:265](../../../../.src/Affichages/Tricp.class#L265), [Tricp.class:269](../../../../.src/Affichages/Tricp.class#L269)
