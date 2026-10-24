# Trifam — Rework

> Source : `.src/Utils/Trifam.class` · Message de commit (phase 4) : `reference/.src/Utils/Trifam.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 131 |
| Lignes de commentaire | 5 |
| Fonctions | 15 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 18 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 131 | 37 | 18 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIFAM-001 — [documentation] En-tête : structure de l'arbre, rôle d'`ipr`, sémantique
  « `enfant` = dernier fils », parcours attendu (`For Each` + récursion sur `precedant`),
  sous-totaux cumulatifs · appelants : aucun · tests : aucun · sources : [Trifam.class:_new](../../../../.src/Utils/Trifam.class#L25-L91), [Trifam.class:_next](../../../../.src/Utils/Trifam.class#L93-L99)
- [ ] TRIFAM-002 — [code mort] Supprimer les variables locales inutilisées (`j`, `qst`, `suiv`,
  `enf`), les lignes commentées, et la double liaison `prec.suivant` dans la boucle de la racine
  (déjà faite par le constructeur du fils ; résultat identique) · tests : T01-T03 · sources : [Trifam.class:_new](../../../../.src/Utils/Trifam.class#L25-L91), [Trifam.class:57](../../../../.src/Utils/Trifam.class#L57)
- [ ] TRIFAM-003 — [complexité] `_new` : extraire `CreeFils(niveau, ipr, requete)` (boucle commune
  aux cas racine et nœud) · tests : T01-T04 · sources : [Trifam.class:_new](../../../../.src/Utils/Trifam.class#L25-L91)
- [ ] TRIFAM-004 — [commonalisation] Lecture et contrôle d'`ipr` partagés avec `textfamille`
  (fonction commune, même message, même `Quit`) · appelants : `textfamille` · tests : T06,
  TEXTFAMILLE-T01 · sources : [Trifam.class:34-39](../../../../.src/Utils/Trifam.class#L34-L39), [textfamille.class:_new](../../../../.src/Utils/textfamille.class#L14-L44)
- [ ] TRIFAM-005 — [commonalisation] Méthode `Parcours()` renvoyant la liste ordonnée des nœuds,
  adoptée par les 5 appelants à la place de leur `TriArticles` récursif (ordre identique) ·
  appelants : `Edart4`, `Edinv`, `Edinv1`, `Stockmvt`, `Histocliart` · tests : T07 + replays des
  appelants · sources : [Trifam.class:_next](../../../../.src/Utils/Trifam.class#L93-L99), [Stockmvt.class:TriArticles](../../../../.src/Gestion/Stockmvt.class#L46-L62)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIFAM-A01 — [anomalie] Bornes `> fam & " "…` et `< fam & "z"…` : codes de famille contenant
  des caractères triés après `z` exclus de l'arbre (à confirmer selon la collation) · tests : T05 · sources : [Trifam.class:74-78](../../../../.src/Utils/Trifam.class#L74-L78)
- [ ] TRIFAM-A02 — [anomalie] Paramétrage `ipr` absent → `Quit` (arrêt brutal de l'application
  depuis une édition) · tests : T06 · sources : [Trifam.class:36-38](../../../../.src/Utils/Trifam.class#L36-L38)
- [ ] TRIFAM-A03 — [anomalie] (performance, log SQL modifié) Construction en N+1 requêtes ; un
  chargement unique change le log `Exec_SQL` comparé par les replays · tests : T08 · sources : [Trifam.class:78](../../../../.src/Utils/Trifam.class#L78), [Trifam.class:104](../../../../.src/Utils/Trifam.class#L104)
