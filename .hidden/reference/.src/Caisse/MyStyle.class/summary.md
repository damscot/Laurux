# MyStyle — Synthèse

> Source : `.src/Caisse/MyStyle.class` · Synthèse des autres documents.

## Rôle

Classe statique de dessin (`Create Static`) : constantes d'état de bouton et `DrawButton`, qui
peint un bouton arrondi en dégradé avec `Paint`. Seul utilisateur : `ImageButton` (touches de la
caisse).

## Points clés

- Constantes `Normal` et `Active` jamais utilisées.
- Seuls les drapeaux 2 et 6 (focus) modifient le rendu ; `Disabled` et le survol seul sont
  ignorés.
- Classe à un seul utilisateur : intégration dans `ImageButton` proposée.

## Dépendances principales

- Utilisée par `ImageButton.View_Draw`. Aucune dépendance projet ; `Paint`, `Color` (Qt).

## Risques

- Faibles : rendu visuel des touches de caisse uniquement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 5 (`DrawButton`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (rendu sur `Image` par somme de contrôle des pixels sous Xvfb, constantes).

## Rework

3 étapes (MYSTYLE-001 documentation, 002 constantes inutilisées, 003 intégration dans
`ImageButton`). 1 anomalie (MYSTYLE-A01 : états désactivé/survol non dessinés).
