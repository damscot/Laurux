# LTrans — Synthèse

> Source : `.src/Utils/LTrans.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet de transport entre une fenêtre appelante et une fenêtre de sélection : un texte et une liste
(`Variant[]`). Utilisé avec `LBox` (GED : sélection de tags, de fichiers) et entre `TriFacture` et
`Caisse` (sélection de bons de caisse).

## Points clés

- `Create Static`, `Export` ; aucune logique.
- La méthode `New()` n'est pas un constructeur et n'est jamais appelée : une instance neuve a
  `List = Null`, convention dont dépendent `GedR` et `LGed`.
- `TriFacture`/`Caisse` communiquent par l'auto-instance statique (`LTrans.List`) et non par
  l'objet passé : état global déguisé.
- Propriété `Text` sans usage.

## Dépendances principales

- Utilisé par : `GedR`, `LGed`, `LBox` (via `Object`), `TriFacture`, `Caisse`.
- N'utilise rien.

## Risques

- Le test `Object.Class(Obj).Name = "LTrans"` dans `TriFacture` lie le nom de classe à une chaîne.
- Corriger `New` en `_new` changerait la détection « pas de sélection » (LTRANS-A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 22 |
| Lignes de commentaire | 2 |
| Fonctions | 5 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 1 (`New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (LTRANS-T01 à T05) : 3 `gbtest` (état initial, copie, auto-instance) et 2 `replay`
(règlement de bons en caisse, suppression de tags GED).

## Rework

3 étapes (LTRANS-001 à 003) : documentation, suppression de `New()` (code mort), suppression de
l'usage de l'auto-instance dans `TriFacture`/`Caisse`. 1 anomalie (LTRANS-A01).
