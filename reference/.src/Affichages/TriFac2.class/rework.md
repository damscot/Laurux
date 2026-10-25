# TriFac2 — Rework

> Source : `.src/Affichages/TriFac2.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriFac2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 629 |
| Lignes de commentaire | 16 |
| Fonctions | 44 |
| Fonctions Public | 44 |
| Complexité cyclomatique totale | 187 |
| Complexité max (fonction) | 20 (`ColFac_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 629 | 187 | 20 | 0 | 44 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIFAC2-001 — [documentation] En-tête : rôle (reprise d'un BL en cours ou d'une facture
  archivée), deux sources et leurs colonnes, protocole `Variables.Bsel`/`numeroFac`, touches ·
  appelants : aucun · tests : T01-T06 · sources : [TriFac2.class:_New](../../../../.src/Affichages/TriFac2.class#L19-L50), [TriFac2.class:ColFac_Click](../../../../.src/Affichages/TriFac2.class#L631-L641)
- [ ] TRIFAC2-002 — [code mort] Supprimer `Dat` (toutes les branches `If dat = 0` sont identiques),
  `Client` (jamais lu), `Prxdec`, la variable locale `Avoir`, les lignes de SQL commentées ; remplir
  `Fac[]` une fois par changement de source · appelants : aucun · tests : T01-T04 · sources : [TriFac2.class:_New](../../../../.src/Affichages/TriFac2.class#L19-L50), [TriFac2.class:ColFac_Data](../../../../.src/Affichages/TriFac2.class#L52-L119), [TriFac2.class:Deb2](../../../../.src/Affichages/TriFac2.class#L121-L132)
- [ ] TRIFAC2-003 — [complexité] Les 8 requêtes `Deb2`…`Deb3bis` → `Charge(bArchives, bDate,
  bDesc)` privée (SQL modifié aux espaces près, dump identique) · appelants : aucun · tests : T03,
  T07 · sources : [TriFac2.class:Deb2](../../../../.src/Affichages/TriFac2.class#L121-L132), [TriFac2.class:Deb3](../../../../.src/Affichages/TriFac2.class#L160-L169), [TriFac2.class:Deb2bis](../../../../.src/Affichages/TriFac2.class#L171-L182), [TriFac2.class:Deb3bis](../../../../.src/Affichages/TriFac2.class#L210-L219)
- [ ] TRIFAC2-004 — [complexité] Les 21 handlers d'en-tête délèguent à `ActiverColonne(sTriEnCours,
  sTriArchives, hEntete, sDa)` et `SaisieFiltre()` ; `DA_KeyPress` garde sa conversion ; handlers
  conservés · appelants : aucun · tests : T03 · sources : [TriFac2.class:NOMM_MouseDown](../../../../.src/Affichages/TriFac2.class#L251-L268), [TriFac2.class:NMF_KeyPress](../../../../.src/Affichages/TriFac2.class#L489-L508), [TriFac2.class:MTC_MouseDown](../../../../.src/Affichages/TriFac2.class#L560-L580)
- [ ] TRIFAC2-005 — [complexité] Couleurs `/Coul/Facts` calculées une fois dans `_New` au lieu de
  chaque cellule · appelants : aucun · tests : T03 · sources : [TriFac2.class:ColFac_Data](../../../../.src/Affichages/TriFac2.class#L52-L119)
- [ ] TRIFAC2-006 — [réduction de portée] `Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Deb2bis`, `Deb2bbis`, `Deb3bbis`, `Deb3bis`, `Tris`, `Titre`, `Dbclk`, `Deplacement` → `Private` (aucun appelant externe, vérifié) · appelants : aucun · tests : T01-T06 · sources : [TriFac2.class:Tris](../../../../.src/Affichages/TriFac2.class#L221-L237), [TriFac2.class:Titre](../../../../.src/Affichages/TriFac2.class#L239-L249), [TriFac2.class:Dbclk](../../../../.src/Affichages/TriFac2.class#L610-L629), [TriFac2.class:Deplacement](../../../../.src/Affichages/TriFac2.class#L723-L756)
- [ ] TRIFAC2-007 — [commonalisation] Pagination vers `PaginationListe` (voir TRIFAC-007,
  TRICARTES-005) ; handlers conservés · appelants : aucun · tests : T03 · sources : [TriFac2.class:Descendre_Click](../../../../.src/Affichages/TriFac2.class#L681-L691), [TriFac2.class:Remonter_Click](../../../../.src/Affichages/TriFac2.class#L693-L701), [TriFac2.class:ColFac_MouseWheel](../../../../.src/Affichages/TriFac2.class#L670-L679)
- [ ] TRIFAC2-008 — [commonalisation] Socle commun avec `TriFac` : `RequeteDocuments` (source
  `Fiches_Bl` ou `Fiches_HistoFac`) et calcul des couleurs partagés, dans le module de TRIFAC-008 ;
  texte SQL identique · appelants : `TriFac` (même commit) · tests : T03, T07, TRIFAC-T05 · sources : [TriFac2.class:Deb2bis](../../../../.src/Affichages/TriFac2.class#L171-L182), [TriFac.class:Deb2](../../../../.src/Affichages/TriFac.class#L94-L103), [TriFac2.class:ColFac_Data](../../../../.src/Affichages/TriFac2.class#L52-L119)
- [ ] TRIFAC2-009 — [séparation traitement/GUI] Texte SQL dans une fonction pure appelée par
  `Charge` ; `Archives_Click`/`Encours_Click` ne gardent que l'état et l'affichage · appelants :
  aucun · tests : T07 · sources : [TriFac2.class:Deb2](../../../../.src/Affichages/TriFac2.class#L121-L132), [TriFac2.class:Archives_Click](../../../../.src/Affichages/TriFac2.class#L758-L768), [TriFac2.class:Encours_Click](../../../../.src/Affichages/TriFac2.class#L770-L780)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIFAC2-A01 — [anomalie] `DA_KeyPress` : en mode archives, effacer le filtre de date par
  retour arrière appelle `Deb2` (requête sur `Fiches_Bl` avec `Tri = "datefac"`, colonne
  inexistante) → erreur SQL ; il faudrait `Deb2bis` · tests : T05 · sources : [TriFac2.class:335](../../../../.src/Affichages/TriFac2.class#L335)
- [ ] TRIFAC2-A02 — [anomalie] `Dbclk` : le second double-clic en mode archives appelle `Deb2bbis`
  (filtre de date `sel2`) au lieu de `Deb2bis` (filtre `sel`) : la liste perd ou change de filtre ·
  tests : T03 · sources : [TriFac2.class:623](../../../../.src/Affichages/TriFac2.class#L623)
- [ ] TRIFAC2-A03 — [anomalie] `Archives_Click`/`Encours_Click` ne vident ni le filtre (`sel`,
  `sel2`), ni `Dbl`/`sDa`, ni le décalage `NbEnreg`, ni les en-têtes : le filtre saisi dans une
  source s'applique à l'autre (colonne différente) et la liste peut s'ouvrir sur une page vide ·
  tests : T04 · sources : [TriFac2.class:Archives_Click](../../../../.src/Affichages/TriFac2.class#L758-L768), [TriFac2.class:Encours_Click](../../../../.src/Affichages/TriFac2.class#L770-L780)
- [ ] TRIFAC2-A04 — [anomalie] `Variables.Bsel` non remis à `False` à l'ouverture (même défaut que
  TRIFAC-A04) : fermer sans choisir (Échap dans un en-tête, croix) recharge le document choisi
  précédemment · tests : T06 · sources : [TriFac2.class:_New](../../../../.src/Affichages/TriFac2.class#L19-L50), [Facture.class:12111](../../../../.src/Gestion/Facturation/Facture.class#L12111)
- [ ] TRIFAC2-A05 — [anomalie] Filtre concaténé dans le SQL (`LIKE "%<sel>%"`) : `"` ou `\` → erreur
  SQL, `%`/`_` jokers (même défaut que TRIFAC-A03) · tests : T03 · sources : [TriFac2.class:124](../../../../.src/Affichages/TriFac2.class#L124), [TriFac2.class:174](../../../../.src/Affichages/TriFac2.class#L174)
