# Intjdv — Synthèse

> Source : `.src/Compta/Utils/Intjdv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne fenêtre « Integration des écritures de ventes » (2007) : choix d'un journal de ventes,
d'une période et d'un fichier texte à positions fixes, à cumuler dans une table de travail
`centralisation`. **Fenêtre non appelée** et **traitement inopérant** (insertions commentées).

## Points clés

- Code mort : aucun menu ni appel (vérifié par `grep`) ; remplacée par `ExportJdv` / `ImpJdv`.
- `Button2_Click` lit le fichier et cumule des montants sans jamais les écrire ; seul effet :
  DROP/CREATE de `centralisation` (homonyme de la table de travail de `Jourcent`).
- Saisie journal / dates avec handlers nominaux appelés explicitement depuis `Cmpt_KeyPress`.
- Réglages globaux `/Rep_Jdv`, `/Jdv` (pas par société).

## Dépendances principales

- Appelants : aucun.
- Utilise `Utils.db`, `Utils.Cdate_calc/aff`, `Utils.cpoint`, `Utils.SetEditColor`,
  `Start.LocalSettings`.
- Tables : `Fiches_Journaux` (lecture), `centralisation` (DDL).

## Risques

- Aucun en l'état (inaccessible). Si réactivée : message « Importation terminée » trompeur et
  collision avec la table de travail de `Jourcent`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 308 |
| Lignes de commentaire | 65 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 58 |
| Complexité max (fonction) | 11 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Aucun replay possible. Un test `gbtest` sous Xvfb est décrit, à réaliser seulement si la
suppression (INTJDV-A01) est refusée.

## Rework

3 étapes (INTJDV-001 à 003) : documentation, puis, seulement si le fichier est conservé, code mort
et réduction de portée. 2 anomalies (INTJDV-A01 suppression du couple `.class` + `.form`, A02 table
de travail homonyme) soumises à validation utilisateur.
