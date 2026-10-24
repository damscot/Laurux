# Cielcorspj — Synthèse

> Source : `.src/Compta/Cielcorspj.class` · Synthèse des autres documents.

## Rôle

Saisie de la table de correspondance des journaux Ciel → Laurux (`Ciel_Lrx_Jo`), utilisée par
l'import d'écritures Ciel (`Cielimp`) et l'import FEC (`impfec`).

## Points clés

- Copie à 89 % de `Cielcorsp` ; différences : table, source de la liste (`Fiches_Journaux`),
  contrôle de doublon limité au code Ciel.
- `Button2_Click`/`Button3_Click` appelés par `Btn_Click` : pas de handler mort.
- `ChkInput` est du code mort.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Ciel`, `Chainage`, `Doc`.
- Utilisé par : `Fmenu`, `impfec`.

## Risques

- Double-clic = suppression immédiate de la correspondance (A01).
- Toute correction faite dans `Cielcorsp` doit être reportée ici tant que la commonalisation
  n'est pas faite.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 192 |
| Lignes de commentaire | 45 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 8 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (CIELCORSPJ-T01 à T06), parallèles à ceux de `Cielcorsp`.

## Rework

5 étapes (CIELCORSPJ-001 à 005) : documentation, code mort, module commun avec `Cielcorsp`
(même commit que CIELCORSP-003), `Cbase.Table`, réduction de portée. 1 anomalie (CIELCORSPJ-A01).
