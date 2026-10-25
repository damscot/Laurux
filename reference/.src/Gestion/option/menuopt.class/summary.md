# menuopt — Synthèse

> Source : `.src/Gestion/option/menuopt.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ajoute au menu principal (`Fmenu`) les entrées des options boisson (consignes, régie, vignettes,
déconsignes fournisseurs, suivi des consignes, comptabilité matière) et carburant (TIPP
régionale, tarif fioul, édition de la TIPP) et porte leurs handlers ; masque « Regroupement des
BL » quand une option est active.

## Points clés

- Classe sans `.form`, instanciée une fois par `Fmenu`.
- Handlers simples ouvrant les auto-instances des écrans de l'option.
- Petite fenêtre construite par code pour l'édition de la TIPP (`Edittipp` → PDF).

## Dépendances principales

- Utilisé par : `Fmenu`.
- Utilise : `Tconsigne`, `Tregie`, `Saisiedecons`, `Tregion`, `Ttarfioul`, `Caleditcmat`,
  `Edconsigne`, `atribvignette`, `Edittipp`, `Visualiseur`, `Start.LocalSettings`.

## Risques

- Faibles : A01 ré-entrance de `win_close`, A02 contrôles de période incomplets.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 127 |
| Lignes de commentaire | 2 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 3 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` (MENUOPT-T01 à T03) : menus selon les options, ouverture des écrans, édition de
la TIPP.

## Rework

3 étapes (MENUOPT-001 à 003) : documentation, création des menus par table, édition TIPP
séparée. 2 anomalies.
