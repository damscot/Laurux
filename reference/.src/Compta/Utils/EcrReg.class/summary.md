# EcrReg — Synthèse

> Source : `.src/Compta/Utils/EcrReg.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Spécialisation d'`EcrAuto` pour les écritures de règlement : à partir d'un mode de règlement, d'un
journal et d'un `VarEcr`, prépare les lignes (contrepartie banque ou compte intermédiaire,
inversion des montants, états) avant l'appel à `ecriture()` hérité.

## Points clés

- `New EcrReg(nreg, njo, var)` : `EcrAuto._new(njo, var)` puis `EcrReg._new(nreg)` → `reglement`.
- Cinq cas selon `Vecr.etat` : ajout, modification, validation de bordereau, suppression, caisse.
- `_call` et `Create Static` inutilisés.

## Dépendances principales

- Hérite d'`EcrAuto` ; utilise `VarEcr`, `Utils.db` (`Fiches_Reglements`, `Fiches_Comptes`).
- Utilisé par : `SaiReg`, `Moulinage`.

## Risques

- Lectures de comptes sans `Available` (ECRREG-A01).
- Logique d'inversion des montants dépendante du type de compte : à couvrir avant tout rework.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 18 (`reglement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (ECRREG-T01 à T07) : 6 `gbtest` (un par état + mode inconnu) qui lisent les lignes
préparées, 1 `replay` de bordereau via `SaiReg`.

## Rework

5 étapes : documentation, suppression de `_call`/`Create Static` et des `modifi` sans effet,
découpage de `reglement`, `Cbase.Table`. 1 anomalie (ECRREG-A01).
