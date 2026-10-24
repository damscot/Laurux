# DB_Desktop — Synthèse

> Source : `.src/Utils/DB_Desktop.class` · Synthèse des autres documents.

## Rôle

Simulation de frappes clavier compatible X11 (`Desktop.SendKeys`) et Wayland (`ydotool`). Instance
unique `Utils.de`, créée au démarrage. Malgré son préfixe `DB_`, la classe ne touche pas la base.

## Points clés

- `_new` détecte Wayland via un shell (`echo $XDG_SESSION_TYPE`) et vérifie l'installation de
  `ydotool` par `apt list` (message d'aide renvoyant à `wayland.sh`).
- `SendKey` : touches spéciales via `ydotool key`, texte via `ydotool type`, sans quotes ni `Wait`.

## Dépendances principales

- Utilise : `gb.desktop`, commandes `ydotool`, `apt`, `grep`.
- Utilisé par : `TextReg` (`SendKey`, et `SendKeys` hérité), `ReplayObserver` (`wayland`,
  `SendKeys` hérité).

## Risques

- Injection shell et frappes désordonnées sous Wayland (A01).
- Message d'installation affiché à tort hors Debian/Ubuntu (A02).
- Deux appelants contournent le routage Wayland en appelant `SendKeys` (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 31 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 3 (`SendKey`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests prévus (DB_DESKTOP-T01 à T04) : 3 `gbtest` avec faux binaires `ydotool`/`apt` dans le
`PATH` (détection, routage, message) et 1 `replay` sous X11 (validation par Entrée dans `TextReg`).

## Rework

4 étapes sans changement de comportement (DB_DESKTOP-001 à 004) : documentation, lecture directe de
la variable d'environnement, séparation détection/message, réduction de portée de `correspondance`.
3 anomalies (DB_DESKTOP-A01 à A03).
