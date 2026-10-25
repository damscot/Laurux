# Listecom — Rework

> Source : `.src/Gestion/Stock/Listecom.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Listecom.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 162 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 14 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 162 | 22 | 14 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LISTECOM-001 — [documentation] En-tête en français : rôle (historique d'achats d'un client),
  deux modes (avec/sans article), sources interrogées (factures et BL, en cours et entretien,
  lignes `A`/`M`), limite de 10 dates, défauts connus (A01-A04) · appelants : aucun · tests :
  aucun · sources : [Listecom.class:_new](../../../../../.src/Gestion/Stock/Listecom.class#L7-L141)
- [ ] LISTECOM-002 — [complexité] Découper `_new` en `LitDates`, `RemplitParArticle`,
  `RemplitParClient` (privées), SQL et remplissage identiques (CC 14 → ≤ 6 visé) ; passer
  `design` en paramètre de `ajouart` · appelants : `Facture`, `FClient` (inchangés) · tests :
  T01-T04 · sources : [Listecom.class:_new](../../../../../.src/Gestion/Stock/Listecom.class#L7-L141), [Listecom.class:ajouart](../../../../../.src/Gestion/Stock/Listecom.class#L143-L163)
- [ ] LISTECOM-003 — [commonalisation] Fonction privée `ReqLignes(avecArticle)` générant les deux
  requêtes `UNION` à 4 sous-requêtes (texte SQL identique, sans changement SQL) · appelants :
  aucun · tests : T01, T02 · sources : [Listecom.class:40-54](../../../../../.src/Gestion/Stock/Listecom.class#L40-L54), [Listecom.class:98-114](../../../../../.src/Gestion/Stock/Listecom.class#L98-L114)
- [ ] LISTECOM-004 — [réarchitecture] `Cbase.Table(…)` pour `TabHisFac`, `TabHisLigFac`,
  `TabHisFacm`, `TabHisLigFacm`, `TabBl`, `TabLigbl`, `TabBlM`, `TabLigblM`, `TabArt`, `TabMo`
  (noms physiques identiques, sans changement SQL) · appelants : aucun · tests : T01, T02 ·
  sources : [Listecom.class:_new](../../../../../.src/Gestion/Stock/Listecom.class#L7-L141), [Listecom.class:ajouart](../../../../../.src/Gestion/Stock/Listecom.class#L143-L163)
- [ ] LISTECOM-005 — [séparation traitement/GUI] Requêtes (dates, lignes, désignation) isolées
  dans des fonctions sans accès aux contrôles, appelées par `_new` · appelants : aucun · tests :
  T01-T04 · sources : [Listecom.class:_new](../../../../../.src/Gestion/Stock/Listecom.class#L7-L141), [Listecom.class:ajouart](../../../../../.src/Gestion/Stock/Listecom.class#L143-L163)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LISTECOM-A01 — [anomalie, à confirmer] Mode client : une date sans ligne `A`/`M` n'avance
  `j` que d'une unité ; la boucle continue après la dernière date (`res!dte` lu sur un résultat
  épuisé) → erreur ou grille décalée · tests : T03 · sources : [Listecom.class:133-137](../../../../../.src/Gestion/Stock/Listecom.class#L133-L137)
- [ ] LISTECOM-A02 — [anomalie] Mode article : `Columns.Count = 1 + res.Count * 4` crée des
  colonnes vides inutiles ; prix moyen par défaut `"0,00"` au lieu du format `"0.000"` des autres
  lignes · tests : T02 · sources : [Listecom.class:25](../../../../../.src/Gestion/Stock/Listecom.class#L25), [Listecom.class:66](../../../../../.src/Gestion/Stock/Listecom.class#L66)
- [ ] LISTECOM-A03 — [anomalie, à confirmer] SQLite : `UNION(SELECT …)` entre parenthèses n'est
  pas accepté par SQLite (requête des dates en échec) · tests : T05 · sources : [Listecom.class:16](../../../../../.src/Gestion/Stock/Listecom.class#L16), [Listecom.class:18](../../../../../.src/Gestion/Stock/Listecom.class#L18)
- [ ] LISTECOM-A04 — [anomalie] Les dates sont lues dans `Fiches_HistoFac`/`Fiches_Bl` seulement,
  les lignes aussi dans `Fiches_HistoFacM`/`Fiches_BlM` : un achat présent uniquement dans les
  tables « entretien » n'apparaît jamais · tests : T01 · sources : [Listecom.class:16](../../../../../.src/Gestion/Stock/Listecom.class#L16), [Listecom.class:18](../../../../../.src/Gestion/Stock/Listecom.class#L18)
