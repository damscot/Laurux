# NetHandler — Synthèse

> Source : `.src/Utils/NetHandler.class` · Synthèse des autres documents.

## Rôle

Handler gb.logging (`Inherits LogHandler`, classe `Export`) qui envoie les lignes du journal
applicatif sur une socket TCP. Créé par `DB_Connection.Start` quand un serveur de log distant est
configuré dans les préférences (`ServerLogIP`, `ServerLogPort`).

## Points clés

- États : 0 non connecté, 1 connecté, 2 fermé.
- `Open` attend la connexion en boucle `Wait 0.1` sans limite de temps ; un échec est silencieux.
- `GetOutput` fournit le texte d'état affiché par `DB_Log`.

## Dépendances principales

- Utilise : `gb.net` (`Socket`), `gb.logging`.
- Utilisé par : `DB_Connection` uniquement (handler `"remote"`).

## Risques

- Démarrage bloqué si l'hôte distant ne répond pas (A01) ; aggravé par la condition `Or` de
  `DB_Connection` qui crée le handler dès que l'IP est renseignée (DB_CONNECTION-A06).
- Pas de reprise après perte de connexion (A02).
- `deps.py` signale à tort `Open`/`Write`/`GetOutput` comme réductibles (appelés par le framework).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 43 |
| Lignes de commentaire | 4 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 5 (`Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `gbtest` prévus (NETHANDLER-T01 à T06) avec un serveur TCP Python de test : connexion réussie
ou refusée, écriture et niveaux, fermeture, double ouverture, intégration avec `DB_Connection`.

## Rework

2 étapes sans changement de comportement (NETHANDLER-001, 002) : documentation et code mort.
2 anomalies (NETHANDLER-A01, A02).
