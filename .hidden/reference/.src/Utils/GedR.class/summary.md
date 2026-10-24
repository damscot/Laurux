# GedR — Synthèse

> Source : `.src/Utils/GedR.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de recherche et de gestion en masse de la GED : liste filtrable des documents (type, tags),
sélection multiple, ouverture, édition, suppression, remplacement de la base des URL, retrait et
ajout de tags en masse, épuration.

## Points clés

- Classe GUI (menu principal) construite sur `TriGen` ; SQL direct dans plusieurs handlers.
- Liste basée sur `GROUP_CONCAT(… SEPARATOR …)` (MySQL uniquement).
- Filtre de tags concaténé dans le SQL.
- Sélection multiple identique à celle de `TriFacture` et `Pointage`.
- Membres inutilisés (`Tableau`, `Obj`, `seltags`, `List`).

## Dépendances principales

- Utilise : `LGed`, `TriGen`, `LBox`, `LTrans`, `ProgBar`, `ObjProp`, `TextReg`, `Doc`, `Utils.db`.
- Utilisé par : `Fmenu` (`GedR.Show()`, non détecté par `deps.py`).

## Risques

- Suppression sans confirmation suivie d'une épuration globale (A04).
- Remplacement d'URL non limité au préfixe (A03) ; filtre SQL fragile (A02) ; SQLite (A01).
- Ajout de tags déjà présents (anomalie LGED-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 387 |
| Lignes de commentaire | 12 |
| Fonctions | 21 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 88 |
| Complexité max (fonction) | 20 (`ChangerUrl_Click`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 scénarios `replay` (GEDR-T01 à T08) sur le jeu GED commun : filtres, sélection, suppression,
changement d'URL, retrait et ajout de tags, édition, filtre avec guillemet.

## Rework

9 étapes (GEDR-001 à 009) : documentation, code mort, `Cbase.Table`, simplifications,
séparation SQL/GUI, commonalisations avec `LGed` et `TriGen`, réduction de portée. 5 anomalies
(GEDR-A01 à A05).
