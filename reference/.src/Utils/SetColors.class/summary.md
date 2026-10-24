# SetColors — Synthèse

> Source : `.src/Utils/SetColors.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de paramétrage des couleurs de l'interface (menu de `Fmenu`) : 6 onglets de zones d'aperçu
dont le `Tag` est la clé `/Coul/…` de `Laurux.conf` ; un double-clic ouvre `FSetFormat` et
enregistre le `CFormat` obtenu ; deux boutons rétablissent les valeurs par défaut.

## Points clés

- Aucune base de données ; uniquement `Start.LocalSettings`.
- `Coul_DblClick` est le handler du groupe `Coul` (21 `TextBox`), pas une méthode réductible.
- Écrit aussi des triplets RVB (`/Coul/Others`, `/Coul/Coulfonds`) lus par `Start.Coul` pour le
  thème.
- Valeurs par défaut écrites en dur ici, dans `Start.module` et dans `Fmenu`.

## Dépendances principales

- Appelant : `Fmenu` (`SetColors.ShowDialog`, non détecté par `deps.py`).
- Utilise `CFormat`, `FSetFormat`, `Start.LocalSettings`, `Utils.Observers`.

## Risques

- Triplets RVB incohérents avec les couleurs par défaut affichées (A01).
- Pas de `Save` sur les boutons « défaut » (A02, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 1 |
| Fonctions | 12 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 9 (`Coul_DblClick`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (ouverture, double-clic simple et RVB, deux remises à défaut) comparant la section
`[Coul]` de `Laurux.conf`, et 1 `gbtest` sur la décomposition RVB après extraction.

## Rework

5 étapes (SETCOLORS-001 à 005) : documentation, tables de valeurs par défaut, `CFormat.Applique`,
extraction de `RVBTexte`, constantes communes avec `Start` et `Fmenu`. 2 anomalies (A01, A02).
