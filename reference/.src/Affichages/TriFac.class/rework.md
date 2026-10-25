# TriFac — Rework

> Source : `.src/Affichages/TriFac.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriFac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 409 |
| Lignes de commentaire | 1 |
| Fonctions | 35 |
| Fonctions Public | 35 |
| Complexité cyclomatique totale | 127 |
| Complexité max (fonction) | 19 (`ColFac_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 409 | 127 | 19 | 0 | 35 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIFAC-001 — [documentation] En-tête de classe : rôle (liste modale des factures archivées
  pour créer un avoir), contrat `_New(cclient)`, protocole de retour `Variables.Bsel` /
  `Variables.numeroFac`, signification de `Dat`/`sDa`/`Dbl`, touches (Échap/F2, flèches,
  PageUp/PageDown) · appelants : aucun · tests : T01-T04 · sources : [TriFac.class:_New](../../../../.src/Affichages/TriFac.class#L18-L38), [TriFac.class:ColFac_Click](../../../../.src/Affichages/TriFac.class#L414-L420)
- [ ] TRIFAC-002 — [code mort] Supprimer `Prxdec` (jamais `True`) et sa ligne, la variable locale
  `Avoir` (lue, jamais utilisée), le test `column = 7` (grille de 7 colonnes) et le second
  `If Not IsNull(cclient)` de `_New` ; remplir `Fac[]` une seule fois · appelants : aucun · tests :
  T01, T02 · sources : [TriFac.class:ColFac_Data](../../../../.src/Affichages/TriFac.class#L40-L92), [TriFac.class:_New](../../../../.src/Affichages/TriFac.class#L18-L38)
- [ ] TRIFAC-003 — [complexité] `Deb2`/`Deb2b`/`Deb3`/`Deb3b` → `Charge(sFiltre, bNumerique,
  sOrdre, bNumserie)` privée, texte SQL **identique** (les branches `Dat` identiques de
  `Deb2b`/`Deb3b` disparaissent) ; noms conservés en appels d'une ligne tant que `Deplacement` les
  cite · appelants : aucun · tests : T02, T03, T05 · sources : [TriFac.class:Deb2](../../../../.src/Affichages/TriFac.class#L94-L103), [TriFac.class:Deb2b](../../../../.src/Affichages/TriFac.class#L105-L114), [TriFac.class:Deb3b](../../../../.src/Affichages/TriFac.class#L116-L125), [TriFac.class:Deb3](../../../../.src/Affichages/TriFac.class#L127-L136)
- [ ] TRIFAC-004 — [complexité] Les 18 handlers d'en-tête (`NO_*`, `DA_*`, `CO_*`, `NM_*`, `MT_*`,
  `MTC_*`) délèguent à `ActiverColonne(sTri, hEntete, iDat, sDa)`, `SaisieFiltre(iDat)` et
  `InverserOrdre(iDat, sDa)` ; `DA_KeyPress` garde sa conversion de date ; handlers conservés
  (nom et portée) · appelants : aucun · tests : T02, T03 · sources : [TriFac.class:NO_MouseDown](../../../../.src/Affichages/TriFac.class#L166-L178), [TriFac.class:NO_KeyPress](../../../../.src/Affichages/TriFac.class#L187-L202), [TriFac.class:MTC_KeyPress](../../../../.src/Affichages/TriFac.class#L385-L399), [TriFac.class:DA_KeyPress](../../../../.src/Affichages/TriFac.class#L226-L251)
- [ ] TRIFAC-005 — [complexité] `ColFac_Data` : lecture de `/Coul/Facts`, `Utils.Fcolr` et repli
  `/Coul_fen` faits une fois dans `_New` (mêmes valeurs ; aujourd'hui à chaque cellule) ·
  appelants : aucun · tests : T02 · sources : [TriFac.class:ColFac_Data](../../../../.src/Affichages/TriFac.class#L40-L92)
- [ ] TRIFAC-006 — [réduction de portée] `Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Tris`, `Titre`, `Dbclk`, `Deplacement` → `Private` (aucun appelant externe, vérifié) ; les handlers restent `Public` · appelants : aucun · tests : T01-T04 · sources : [TriFac.class:Tris](../../../../.src/Affichages/TriFac.class#L138-L153), [TriFac.class:Titre](../../../../.src/Affichages/TriFac.class#L155-L164), [TriFac.class:Dbclk](../../../../.src/Affichages/TriFac.class#L401-L412), [TriFac.class:Deplacement](../../../../.src/Affichages/TriFac.class#L501-L518)
- [ ] TRIFAC-007 — [commonalisation] Pagination (`Descendre_*`, `Remonter_*`,
  `ColFac_MouseWheel`, flèches de `ColFac_KeyPress`, `Deplacement`) vers la classe d'aide
  `PaginationListe` partagée avec `TriFac2`, `TriEcritures`, `Tricartes` (TRICARTES-005),
  `TriclientsD`, `Tricp`, `TriMat` ; handlers conservés, SQL identique · appelants : aucun · tests :
  T03 · sources : [TriFac.class:Descendre_Click](../../../../.src/Affichages/TriFac.class#L459-L469), [TriFac.class:Remonter_Click](../../../../.src/Affichages/TriFac.class#L471-L479), [TriFac.class:ColFac_MouseWheel](../../../../.src/Affichages/TriFac.class#L448-L457), [TriFac2.class:Descendre_Click](../../../../.src/Affichages/TriFac2.class#L681-L691)
- [ ] TRIFAC-008 — [commonalisation] Socle commun avec `TriFac2` (mode « factures archivées ») :
  `RequeteFactures(sSource, sTri, sFiltre, bNumerique, bDesc, iDebut, iNb) As String` dans un module
  à créer (`ListeFactures`), texte SQL identique pour chaque écran ; calcul des couleurs
  `/Coul/Facts` partagé · appelants : `TriFac2` (même commit, TRIFAC2-008) · tests : T02, T05,
  TRIFAC2-T02 · sources : [TriFac.class:Deb2](../../../../.src/Affichages/TriFac.class#L94-L103), [TriFac2.class:Deb2bis](../../../../.src/Affichages/TriFac2.class#L171-L182), [TriFac.class:ColFac_Data](../../../../.src/Affichages/TriFac.class#L40-L92), [TriFac2.class:ColFac_Data](../../../../.src/Affichages/TriFac2.class#L52-L119)
- [ ] TRIFAC-009 — [séparation traitement/GUI] Texte SQL construit par une fonction pure
  (`RequeteFactures`, voir 008) appelée par `Charge`, qui garde seulement `Utils.Base2` et
  `ColFac.Refresh` ; formatage d'une cellule isolé dans `FormatCellule` · appelants : aucun · tests :
  T05 · sources : [TriFac.class:Deb2](../../../../.src/Affichages/TriFac.class#L94-L103), [TriFac.class:ColFac_Data](../../../../.src/Affichages/TriFac.class#L40-L92)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIFAC-A01 — [anomalie] Le double-clic n'inverse pas l'ordre : `Deb3` trie en `DESC` comme
  `Deb2` (lignes 130 et 132) ; de plus `Deplacement` utilise, après un double-clic, `Deb3` (filtre
  `sel`) quand la colonne est la date et `Deb3b` (filtre `sel2`, ordre `ASC`) sinon, c'est-à-dire
  l'inverse de `Deb2b`/`Deb2` : la page suivante change de filtre et d'ordre · tests : T03 ·
  sources : [TriFac.class:130](../../../../.src/Affichages/TriFac.class#L130), [TriFac.class:132](../../../../.src/Affichages/TriFac.class#L132), [TriFac.class:Dbclk](../../../../.src/Affichages/TriFac.class#L401-L412), [TriFac.class:Deplacement](../../../../.src/Affichages/TriFac.class#L501-L518)
- [ ] TRIFAC-A02 — [anomalie] État de tri incohérent : `DA_MouseDown` ne vide pas `sel2`, donc la
  pagination (`Deb2b`) réapplique l'ancien motif de date ; `CO_KeyPress` met `Dat = 1` alors que
  `CO_MouseDown` met `Dat = 0` (le tri du code client passe de numérique à alphabétique dès la
  première frappe) · tests : T02, T03 · sources : [TriFac.class:DA_MouseDown](../../../../.src/Affichages/TriFac.class#L204-L216), [TriFac.class:276](../../../../.src/Affichages/TriFac.class#L276), [TriFac.class:255](../../../../.src/Affichages/TriFac.class#L255)
- [ ] TRIFAC-A03 — [anomalie] Filtre concaténé dans le SQL (`LIKE "%<sel>%"`, colonne `Tri`,
  `LIMIT`) : un `"` ou un `\` saisi provoque une erreur SQL, `%` et `_` agissent comme jokers ;
  paramétrer par `&1` change ces cas · tests : T02 · sources : [TriFac.class:97](../../../../.src/Affichages/TriFac.class#L97), [TriFac.class:99](../../../../.src/Affichages/TriFac.class#L99), [TriFac.class:108](../../../../.src/Affichages/TriFac.class#L108), [TriFac.class:130](../../../../.src/Affichages/TriFac.class#L130)
- [ ] TRIFAC-A04 — [anomalie] `Variables.Bsel` n'est remis à `False` ni par `Facture.Creation` avant
  l'ouverture, ni par `_New`, ni par les fermetures Échap/F2 des en-têtes ou la croix de la fenêtre :
  après une première sélection, fermer la liste sans choisir recharge l'ancienne facture
  (`EntFac` avec l'ancien `Variables.numeroFac`). Correction proposée : `Variables.Bsel = False` dans
  `_New` · tests : T04 · sources : [TriFac.class:_New](../../../../.src/Affichages/TriFac.class#L18-L38), [TriFac.class:NO_KeyPress](../../../../.src/Affichages/TriFac.class#L187-L202), [Facture.class:12111](../../../../.src/Gestion/Facturation/Facture.class#L12111)
- [ ] TRIFAC-A05 — [anomalie] (à confirmer) Le prénom affiché en colonne 4 est celui mémorisé lors du
  dessin de la dernière cellule de colonne 0 ; si le GridView redessine une cellule isolée (survol,
  défilement partiel), le prénom peut appartenir à une autre ligne. Correction : lire `pnmclifac`
  dans `Utils.rs2` à la ligne courante · tests : T02 · sources : [TriFac.class:76](../../../../.src/Affichages/TriFac.class#L76), [TriFac.class:82](../../../../.src/Affichages/TriFac.class#L82)
