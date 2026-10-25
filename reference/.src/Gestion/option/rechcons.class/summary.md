# rechcons — Synthèse

> Source : `.src/Gestion/option/rechcons.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre de recherche d'un code de consigne (`Fiches_consigne`), filtrable par code ou libellé,
limitée à un type (`P`, `C`, `B`) ou complète (`"T"`) ; lève `trouver(code)` puis se ferme.

## Points clés

- Appelants : `Tconsigne` (recherche de la barre) et `facopt`.
- Une requête `LIKE` par frappe ; les deux filtres ne se cumulent pas.
- `rechcons_KeyPress` jamais levé (code mort) ; bloc `If … Endif` vide dans `_new`.

## Dépendances principales

- Utilise : `Utils.db` ; table `Fiches_consigne` (créée par `modfichier`).
- Utilisé par : `Tconsigne`, `facopt`.

## Risques

- Fenêtre non journalisée (`Utils.Observers` absent) et sans `GridView1_Click` : non rejouable.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 73 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 8 (`GridView1_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests (RECHCONS-T01 à T04) : 3 `gbtest` sous Xvfb (chargement par type, filtres, sélection) et
1 replay via `Tconsigne`.

## Rework

3 étapes (RECHCONS-001 à 003) : documentation, code mort, fonction de filtre commune.
1 anomalie (A01 : journalisation absente).
