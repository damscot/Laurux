# Doc — Synthèse

> Source : `.src/Communs/Doc.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module d'aide en ligne : `Doc.Open(Rubrique)` ouvre `Ecrans/<Rubrique>.html` du répertoire de
l'application avec `xdg-open`, ou à défaut la documentation générale du site Laurux.

## Points clés

- 162 appels dans 155 fichiers, 111 rubriques ; paramètre `Module` jamais utilisé.
- Aucune page locale livrée : toutes les rubriques ouvrent la même URL.
- `Exec` non bloquant, sans gestion d'erreur.

## Dépendances principales

- Appelé par la plupart des écrans (boutons d'aide) et `Fmenu` (« ? > Aide Html »).
- Utilise `xdg-open` (`xdg-utils`) et `Application.Path`.

## Risques

- API très utilisée : la signature d'`Open` ne doit pas changer.
- Aide contextuelle inopérante (A01) ; erreur si `xdg-open` est absent (A02, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 8 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 2 (`Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (DOC-T01 à T05) : 4 `gbtest` avec un `xdg-open` factice (sans page, page locale, autre
module, fonction pure extraite) et un `replay` du menu d'aide.

## Rework

4 étapes (DOC-001 à 004) : documentation, constante, fonction pure `CheminAide`, ouverture d'URL
commune. 2 anomalies (DOC-A01, A02).
