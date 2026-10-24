# ArtPromo — Rework

> Source : `.src/Gestion/Tables/ArtPromo.module` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/ArtPromo.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 44 |
| Lignes de commentaire | 4 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 4 (`Maj_qtemoins`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 44 | 16 | 4 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ARTPROMO-001 — [documentation] En-tête du module : rôle, table `Fiches_ArtPromo` et sa clé,
  sémantique de `qte` (quantité vendue en promotion), convention de retour de `art_Promo` (`"T"` /
  `""`) ; commentaire `'''` sur chaque fonction · appelants : aucun · tests : T01-T05 · sources : [ArtPromo.module:art_Promo](../../../../../.src/Gestion/Tables/ArtPromo.module#L5-L14), [ArtPromo.module:Maj_qteplus](../../../../../.src/Gestion/Tables/ArtPromo.module#L62-L75)
- [ ] ARTPROMO-002 — [commonalisation] Helper privé `LitPromo(sCode, sPromo) As Result` utilisé par
  les six fonctions (même requête, SQL émis identique) · appelants : aucun · tests : T01-T05 ·
  sources : [ArtPromo.module:art_Promo](../../../../../.src/Gestion/Tables/ArtPromo.module#L5-L14), [ArtPromo.module:Prix_Promo](../../../../../.src/Gestion/Tables/ArtPromo.module#L16-L23), [ArtPromo.module:Prix_Promottc](../../../../../.src/Gestion/Tables/ArtPromo.module#L25-L32), [ArtPromo.module:Intitule_Promo](../../../../../.src/Gestion/Tables/ArtPromo.module#L34-L41), [ArtPromo.module:Maj_qtemoins](../../../../../.src/Gestion/Tables/ArtPromo.module#L45-L58), [ArtPromo.module:Maj_qteplus](../../../../../.src/Gestion/Tables/ArtPromo.module#L62-L75)
- [ ] ARTPROMO-003 — [complexité] `Maj_qtemoins`/`Maj_qteplus` délèguent à un helper privé
  `MajQte(sCode, sPromo, fDelta)` (même lecture puis même `UPDATE`) ; les deux procédures perdent leur
  type de retour `As String` jamais renseigné · appelants : `Caisse`, `Facture` (inchangés) · tests :
  T04 · sources : [ArtPromo.module:Maj_qtemoins](../../../../../.src/Gestion/Tables/ArtPromo.module#L45-L58), [ArtPromo.module:Maj_qteplus](../../../../../.src/Gestion/Tables/ArtPromo.module#L62-L75)
- [ ] ARTPROMO-004 — [commonalisation] Nouvelle fonction `PromoDuJour() As String` (première ligne
  de `TabPromo` avec `datedeb <= aujourd'hui <= datefin`, `""` sinon), utilisée par
  `Articles.Form_Open`, `Caisse` et `Facture` (même requête, même règle « première ligne ») ·
  appelants : `Articles` (ARTICLES-014), `Caisse`, `Facture` (via leurs cases) · tests : T05 ·
  sources : [Articles.class:Form_Open](../../../../../.src/Gestion/Tables/Articles.class#L227-L252), [Caisse.class:218](../../../../../.src/Caisse/Caisse.class#L218), [Facture.class:508](../../../../../.src/Gestion/Facturation/Facture.class#L508)
- [ ] ARTPROMO-005 — [complexité] `art_Promo` déclarée `As Boolean` (la locale l'est déjà) ; tous les
  appelants convertissent le résultat en booléen (`Apromo = …`) ou le testent dans un `If` :
  comportement identique (vérifié : `"T"`/`""` ↔ `True`/`False`) · appelants : `Articles` (491),
  `Caisse` (588, 1117, 1392, 7043, 7417, 7464), `Facture` (8208, 9265, 9302, 9344, 9390, 9435),
  `TarArt` (123), mis à jour si nécessaire dans le même commit · tests : T01 · sources : [ArtPromo.module:art_Promo](../../../../../.src/Gestion/Tables/ArtPromo.module#L5-L14), [TarArt.class:123](../../../../../.src/Utils/TarArt.class#L123)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] ARTPROMO-A01 — [anomalie] `Maj_qteplus`/`Maj_qtemoins` lisent puis réécrivent `qte` sans
  verrou : en caisse multi-postes, deux ventes simultanées d'un même article promu perdent un
  incrément. Correction : `UPDATE … SET qte = COALESCE(qte, 0) ± &2 WHERE …` (SQL modifié ; dump
  identique en mono-poste, différent seulement en concurrence) · tests : T04, T06 · sources : [ArtPromo.module:Maj_qtemoins](../../../../../.src/Gestion/Tables/ArtPromo.module#L45-L58), [ArtPromo.module:Maj_qteplus](../../../../../.src/Gestion/Tables/ArtPromo.module#L62-L75)
- [ ] ARTPROMO-A02 — [anomalie] Une seule promotion active est prise en compte par les appelants
  (première ligne de `Fiches_Promo`, ordre non spécifié) : un article d'une seconde promotion
  simultanée n'est jamais vu comme promu (règle métier à confirmer par l'utilisateur ; à traiter avec
  ARTPROMO-004) · tests : T05 · sources : [Articles.class:231](../../../../../.src/Gestion/Tables/Articles.class#L231), [Caisse.class:218](../../../../../.src/Caisse/Caisse.class#L218), [Facture.class:508](../../../../../.src/Gestion/Facturation/Facture.class#L508)
