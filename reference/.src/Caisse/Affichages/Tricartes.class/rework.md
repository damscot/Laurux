# Tricartes — Rework

> Source : `.src/Caisse/Affichages/Tricartes.class` · Message de commit (phase 4) : `reference/.src/Caisse/Affichages/Tricartes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 322 |
| Lignes de commentaire | 13 |
| Fonctions | 37 |
| Fonctions Public | 37 |
| Complexité cyclomatique totale | 102 |
| Complexité max (fonction) | 11 (`ColCli_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 322 | 102 | 11 | 0 | 37 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRICARTES-001 — [documentation] En-tête de classe : rôle, contrat `_new(Divers, ob)` (`0` =
  fidélité, `-1` = clients divers ; `ob` doit exposer `Public Bsel`/`Bval`), pagination tactile,
  touches (F4, flèches, PageUp/PageDown, Échap/F2) · appelants : aucun · tests : T01-T06 · sources : [Tricartes.class:_new](../../../../../.src/Caisse/Affichages/Tricartes.class#L13-L38), [Tricartes.class:colcli_Click](../../../../../.src/Caisse/Affichages/Tricartes.class#L79-L88)
- [ ] TRICARTES-002 — [code mort] `Colcli_Data` : supprimer `Frmt`/`Frmt2` (deux lectures de
  couleurs par cellule, jamais utilisées) ; `CliTable` dimensionné à 7 et rempli une fois dans `_new` ;
  doublons `Dbl = ""` des `*_Click` · appelants : aucun · tests : T02, T03 · sources : [Tricartes.class:Colcli_Data](../../../../../.src/Caisse/Affichages/Tricartes.class#L58-L77), [Tricartes.class:C1_Click](../../../../../.src/Caisse/Affichages/Tricartes.class#L208-L222)
- [ ] TRICARTES-003 — [complexité] `Deb3`/`Deb4` → `Charge(bDesc)` (texte SQL identique) ;
  `C1_Click`/`N1_Click`/`Cp1_Click`/`VILLE_Click` → `TriColonne(sTri, hEntete)`, handlers conservés ·
  appelants : aucun · tests : T02, T03 · sources : [Tricartes.class:Deb3](../../../../../.src/Caisse/Affichages/Tricartes.class#L180-L186), [Tricartes.class:Deb4](../../../../../.src/Caisse/Affichages/Tricartes.class#L188-L194), [Tricartes.class:N1_Click](../../../../../.src/Caisse/Affichages/Tricartes.class#L230-L244), [Tricartes.class:VILLE_Click](../../../../../.src/Caisse/Affichages/Tricartes.class#L274-L288)
- [ ] TRICARTES-004 — [réduction de portée] `Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`, `ClientsCartes` → `Private` (aucun appelant externe, vérifié ; couverts par les replays) · appelants : aucun · tests : T01-T05 · sources : [Tricartes.class:Tris](../../../../../.src/Caisse/Affichages/Tricartes.class#L40-L53), [Tricartes.class:Deplacement](../../../../../.src/Caisse/Affichages/Tricartes.class#L169-L178), [Tricartes.class:ChkInput](../../../../../.src/Caisse/Affichages/Tricartes.class#L423-L432), [Tricartes.class:ClientsCartes](../../../../../.src/Caisse/Affichages/Tricartes.class#L438-L445)
- [ ] TRICARTES-005 — [commonalisation] Pagination tactile (`Descendre_*`, `Remonter_*`,
  `ColCli_MouseWheel`, `Deplacement`, flèches de `ColCli_KeyPress`) vers une classe d'aide
  `PaginationListe` partagée avec `TriclientsD` et les `Tri*` du lot Affichages (handlers conservés,
  SQL identique) · appelants : aucun · tests : T03 · sources : [Tricartes.class:Descendre_Click](../../../../../.src/Caisse/Affichages/Tricartes.class#L127-L137), [Tricartes.class:Remonter_Click](../../../../../.src/Caisse/Affichages/Tricartes.class#L139-L147), [Tricartes.class:ColCli_MouseWheel](../../../../../.src/Caisse/Affichages/Tricartes.class#L116-L125), [TriclientsD.class:Descendre_Click](../../../../../.src/Caisse/Affichages/TriclientsD.class#L109-L119)
- [ ] TRICARTES-006 — [séparation traitement/GUI] `RequeteCartes(sTri, sSel, iDivers, bDesc,
  iDebut, iNb) As String` pure (texte identique à aujourd'hui), utilisée par `Charge` ; candidate au
  partage avec `FClientcarte.Deb2`/`Deb3` · appelants : aucun · tests : T07 · sources : [Tricartes.class:Deb3](../../../../../.src/Caisse/Affichages/Tricartes.class#L180-L186), [Tricartes.class:Deb4](../../../../../.src/Caisse/Affichages/Tricartes.class#L188-L194), [FClientcarte.class:Deb2](../../../../../.src/Caisse/FClientcarte.class#L126-L131)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRICARTES-A01 — [anomalie] `Caisse.ClientsDivers` ouvre `New Tricartes(-1)` **sans `ob`** :
  `colcli_Click` ne transmet rien, `Caisse.Bsel` reste `False` et la fiche client divers choisie
  n'est jamais reprise (Ctrl+N, F2, `button42`) ; de plus `RecupClientd(Codearticle)` passe le code
  article au lieu de `Bval`. Correction dans `Caisse` : `New Tricartes(-1, Null, Me)` et
  `RecupClientd(Bval)` · tests : T04 · sources : [Caisse.class:7255](../../../../../.src/Caisse/Caisse.class#L7255), [Caisse.class:7259](../../../../../.src/Caisse/Caisse.class#L7259), [Tricartes.class:24](../../../../../.src/Caisse/Affichages/Tricartes.class#L24)
- [ ] TRICARTES-A02 — [anomalie] Filtre concaténé dans le SQL (`LIKE "%<sel>%"`) : `ChkInput` bloque
  `"` et `&` mais un `\` saisi provoque une erreur SQL (MySQL), `%` et `_` agissent comme jokers ;
  paramétrer par `&1` change ces cas · tests : T02 · sources : [Tricartes.class:183](../../../../../.src/Caisse/Affichages/Tricartes.class#L183), [Tricartes.class:191](../../../../../.src/Caisse/Affichages/Tricartes.class#L191), [Tricartes.class:ChkInput](../../../../../.src/Caisse/Affichages/Tricartes.class#L423-L432)
