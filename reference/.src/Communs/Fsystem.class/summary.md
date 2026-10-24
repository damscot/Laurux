# Fsystem — Synthèse

> Source : `.src/Communs/Fsystem.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Information système » (menu « ? ») : exécute le script `report.sh` du projet et affiche
son résultat, complété des bibliothèques graphiques trouvées, de la version du serveur SQL et de
celle de Laurux.

## Points clés

- Script copié dans un répertoire temporaire puis exécuté par `/bin/sh` (bloquant).
- Recherche de bibliothèques Qt4/GTK2 dans `/usr/lib/` seulement.

## Dépendances principales

- Appelé par `Fmenu.Menu266`. Utilise `Utils.db.Version`, `report.sh`, `/bin/sh`.

## Risques

- Faibles : informations obsolètes ou trompeuses (A01) ; erreurs non rattrapées si le script
  manque (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 2 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 6 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests (FSYSTEM-T01 replay, T02 gbtest après extraction) ; seule la structure du texte est
comparée.

## Rework

2 étapes (FSYSTEM-001, 002) : documentation et extraction de `RapportSysteme`. 2 anomalies.
