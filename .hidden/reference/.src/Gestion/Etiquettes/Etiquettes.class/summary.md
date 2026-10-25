# Etiquettes — Synthèse

> Source : `.src/Gestion/Etiquettes/Etiquettes.class` · Synthèse des autres documents.

## Rôle

Écran de paramétrage des formats de planches d'étiquettes (`Fiches_Etiquettes`, clé `(code, page)`, dimensions en dixièmes de mm), consommés par tous les écrans d'impression d'étiquettes et par FClient/FFournisseur.

## Points clés

- Seul écrivain de `Fiches_Etiquettes` ; libellé de liste `"<code>- <libellé>"` découpé par `Left$`/`Mid$`.
- 8 handlers `*_KeyPress` identiques (saisie numérique, passage à la zone suivante).
- Observateurs de focus `OBS` copiés dans Eticli.

## Dépendances principales

- Appelant : `Fmenu.Menu165_Click` (auto-instance).
- Utilise `Utils.db`, `Utils.PageFormatSupported`, `Utils.Observers`, `Doc.Open`.

## Risques

- Enregistrement sans contrôle du code ni de la page (ETIQUETTES-A01).
- Lecture d'un format avec la page précédemment sélectionnée (ETIQUETTES-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 228 |
| Lignes de commentaire | 26 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 73 |
| Complexité max (fonction) | 7 (`init_ComboBox`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (ETIQUETTES-T01 à T06) avec diff de `Fiches_Etiquettes` ; le format `Z- Test` sert de fixture aux autres écrans.

## Rework

7 reworks (documentation, factorisation des `KeyPress`, booléen au lieu du drapeau `Err`, `Cbase`, portée de 5 membres, séparation SQL/GUI, focus commun). 2 anomalies.
