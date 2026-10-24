# Cdoc — Synthèse

> Source : `.src/Utils/Cdoc.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancien écran (2007) de paramétrage des couleurs des documents (proforma, commande, devis, bon,
facture) enregistrées dans `Laurux.conf` (`/Coul/*`).

## Points clés

- **Aucun appelant** : l'écran est inaccessible ; `SetColors` le remplace.
- Écrit `/Coul/Fac`, clé lue par aucun autre fichier (les autres utilisent `/Coul/Facts`).
- Handlers de groupes (`Coul`, `Btn`) signalés à tort comme réductibles par `deps.py`.

## Dépendances principales

- Utilise : `Start.LocalSettings`.
- Utilisé par : aucun fichier.

## Risques

- Aucun à l'exécution (code mort) ; coût de maintenance et confusion avec `SetColors`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 103 |
| Lignes de commentaire | 27 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 6 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 contrôle statique (CDOC-T01) : absence d'appelant. Pas de test fonctionnel possible.

## Rework

1 étape de documentation (CDOC-001). Suppression de la classe et du formulaire proposée en
CDOC-A01, soumise à validation (suppression d'un `.form`).
