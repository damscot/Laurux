# Cielcorsp — Synthèse

> Source : `.src/Compta/Cielcorsp.class` · Synthèse des autres documents.

## Rôle

Saisie de la table de correspondance des comptes clients/fournisseurs Ciel → Laurux
(`Ciel_Lrx`), utilisée par l'import d'écritures Ciel (`Cielimp`) et l'import FEC (`impfec`).

## Points clés

- Copie à 89 % de `Cielcorspj` (correspondance des journaux).
- `Btn_Click` aiguille les boutons du groupe `Btn` par `Tag` : `Button2_Click`/`Button3_Click`
  sont appelés, ce ne sont pas des handlers morts.
- `ChkInput` est du code mort.
- Tables créées à l'ouverture par `Utils.Ciel()` (DDL hors migrations).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Ciel`, `Chainage`, `Doc`.
- Utilisé par : `Fmenu`, `impfec`.

## Risques

- Double-clic = suppression immédiate de la correspondance (A01).
- État de validation porté par le membre `B` partagé entre `Cpt_man` et `Button2_Click`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 199 |
| Lignes de commentaire | 43 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (CIELCORSP-T01 à T06 : création des tables, ajout, liste fournisseurs, doublons,
compte inconnu, suppression) et 1 gbtest (T07) après séparation.

## Rework

6 étapes (CIELCORSP-001 à 006) : documentation, code mort, module commun avec `Cielcorspj`,
`Cbase.Table`, séparation traitement/GUI, réduction de portée. 2 anomalies (CIELCORSP-A01, A02).
