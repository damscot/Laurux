# TriEqu — Rework

> Source : `.src/Affichages/TriEqu.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriEqu.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 283 |
| Lignes de commentaire | 6 |
| Fonctions | 25 |
| Fonctions Public | 25 |
| Complexité cyclomatique totale | 85 |
| Complexité max (fonction) | 12 (`Colart_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 283 | 85 | 12 | 0 | 25 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIEQU-001 — [documentation] En-tête de classe : rôle (choix parmi les articles
  équivalents), signature (paramètres `client`/`tclient` ignorés), retour par `Variables.Bsel` /
  `Variables.$Codearticle` avec remise à zéro à l'annulation · appelants : aucun · tests : T01, T02 · sources : [TriEqu.class:_new](../../../../.src/Affichages/TriEqu.class#L22-L47), [TriEqu.class:Colart_Click](../../../../.src/Affichages/TriEqu.class#L143-L153), [TriEqu.class:Form_Close](../../../../.src/Affichages/TriEqu.class#L155-L162)
- [ ] TRIEQU-002 — [code mort] Supprimer `Tarifclient` et son appel (résultat jamais affiché :
  `PvhtPro` jamais affecté, `pvpro` jamais lu) en gardant la colonne 10 vide ; supprimer `cli`,
  `Tcli`, `pvpro`, `PvhtPro`, `Typeremise` — SQL modifié (2 requêtes de moins par ligne), dump
  identique · appelants : aucun (signature de `_new` conservée) · tests : T01, T05 · sources : [TriEqu.class:Tarifclient](../../../../.src/Affichages/TriEqu.class#L199-L228), [TriEqu.class:190](../../../../.src/Affichages/TriEqu.class#L190)
- [ ] TRIEQU-003 — [complexité] Les 6 blocs d'annulation → `Fermer()` privée (ou `Me.Close`
  seul, `Form_Close` faisant la remise à zéro) ; `Co_MouseDown`/`Co2_MouseDown`/`Co3_MouseDown` →
  `TriColonne(sTri2, hEntete)` (handlers conservés) ; `ArtTable` initialisé une fois · appelants :
  aucun · tests : T02, T03 · sources : [TriEqu.class:Colart_KeyPress](../../../../.src/Affichages/TriEqu.class#L49-L77), [TriEqu.class:Co_MouseDown](../../../../.src/Affichages/TriEqu.class#L265-L277), [TriEqu.class:Co3_MouseDown](../../../../.src/Affichages/TriEqu.class#L327-L339), [TriEqu.class:Colart_Data](../../../../.src/Affichages/TriEqu.class#L164-L197)
- [ ] TRIEQU-004 — [complexité] `Deb2`/`Deb3` → `Charge(bDesc)` (texte SQL identique) ·
  appelants : aucun · tests : T03, T04 · sources : [TriEqu.class:Deb2](../../../../.src/Affichages/TriEqu.class#L249-L255), [TriEqu.class:Deb3](../../../../.src/Affichages/TriEqu.class#L257-L263)
- [ ] TRIEQU-005 — [séparation traitement/GUI] `RequeteEquivalents(sCode, sTri2, bDesc, iDebut,
  iNb) As String` pure, utilisée par `Charge` · appelants : aucun · tests : T06 · sources : [TriEqu.class:Deb2](../../../../.src/Affichages/TriEqu.class#L249-L255)
- [ ] TRIEQU-006 — [réduction de portée] `Deplacement`, `Tris`, `Deb2`, `Deb3`, `Dbclk` → `Private`
  (aucun appelant externe, vérifié ; couverts par T03, T04) · appelants : aucun · tests : T03, T04 · sources : [TriEqu.class:Deplacement](../../../../.src/Affichages/TriEqu.class#L136-L141), [TriEqu.class:Tris](../../../../.src/Affichages/TriEqu.class#L230-L247), [TriEqu.class:Dbclk](../../../../.src/Affichages/TriEqu.class#L358-L368)
- [ ] TRIEQU-007 — [commonalisation] Pagination vers `PaginationListe` (TRICARTES-005, avec
  `Tricp`, `TriMat`, `Tricartes`…) ; handlers conservés, SQL identique · appelants : aucun ·
  tests : T04 · sources : [TriEqu.class:Colart_MouseWheel](../../../../.src/Affichages/TriEqu.class#L79-L88), [TriEqu.class:Descendre_Click](../../../../.src/Affichages/TriEqu.class#L90-L100), [TriEqu.class:Remonter_Click](../../../../.src/Affichages/TriEqu.class#L102-L110)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIEQU-A01 — [anomalie] Tri par double-clic : `Dbclk` ne modifie jamais `Dbl` (toujours
  décroissant) et `Deplacement` ignore le sens (pages suivantes en croissant) · tests : T03 · sources : [TriEqu.class:Dbclk](../../../../.src/Affichages/TriEqu.class#L358-L368), [TriEqu.class:Deplacement](../../../../.src/Affichages/TriEqu.class#L136-L141)
- [ ] TRIEQU-A02 — [anomalie] Colonne « HT Pro » toujours vide : `Tarifclient` calcule `pvpro`
  mais la cellule affiche `PvhtPro`, jamais affecté ; afficher le prix remisé (en réutilisant le
  calcul de `Facture`) change l'écran · tests : T05 · sources : [TriEqu.class:191](../../../../.src/Affichages/TriEqu.class#L191), [TriEqu.class:Tarifclient](../../../../.src/Affichages/TriEqu.class#L199-L228)
- [ ] TRIEQU-A03 — [anomalie, à confirmer] Couleur de ligne déterminée par `art_stkmin` (colonne 0
  masquée) et non par la quantité en stock ; lecture `rs2[""]` pour la colonne 10 (premier champ
  sous SQLite, comportement MySQL à vérifier) · tests : T05 · sources : [TriEqu.class:181](../../../../.src/Affichages/TriEqu.class#L181), [TriEqu.class:179](../../../../.src/Affichages/TriEqu.class#L179)
