# Fcaras — Rework

> Source : `.src/Gestion/Facturation/Fcaras.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/Fcaras.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 7 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 38 | 12 | 7 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCARAS-001 — [documentation] En-tête de classe : rôle (photo + caractéristiques d'un
  article), appelant unique `Facture.aff_photo`, paramètres du constructeur · appelants : aucun ·
  tests : aucun · sources : [Fcaras.class:_new](../../../../../.src/Gestion/Facturation/Fcaras.class#L5-L29)
- [ ] FCARAS-002 — [code mort] Supprimer `Tnom_Photo` (sans effet : résultat jamais lu, `Pht`
  inutilisé), son appel et la variable `$photo` · appelants : aucun (vérifié par `grep`) ·
  tests : T01, T02 · sources : [Fcaras.class:Tnom_Photo](../../../../../.src/Gestion/Facturation/Fcaras.class#L31-L43), [Fcaras.class:12](../../../../../.src/Gestion/Facturation/Fcaras.class#L12), [Fcaras.class:3](../../../../../.src/Gestion/Facturation/Fcaras.class#L3)
- [ ] FCARAS-003 — [documentation] Renommer le paramètre `$crst` du constructeur en `sCaract`
  (préfixe `$` réservé aux membres privés) · appelants : aucun (passage par position) · tests :
  T01 · sources : [Fcaras.class:5](../../../../../.src/Gestion/Facturation/Fcaras.class#L5)

### Anomalies : changement de comportement, validation utilisateur requise

_Aucune._
