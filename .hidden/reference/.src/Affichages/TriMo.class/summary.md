# TriMo — Synthèse

> Source : `.src/Affichages/TriMo.class` · Synthèse des autres documents.

## Rôle

Ancienne fenêtre de sélection d'une main d'œuvre (`Fiches_Mo`). **Classe morte** : jamais
instanciée ; remplacée par `TriArticles` en mode `"mo_code"` (`Prodcomposes`).

## Points clés

- Aucun `New TriMo` ni chaîne `"TriMo"` dans le projet ; `Facture.TriMo()` est une méthode
  homonyme sans rapport.
- Protocole historique par `Variables.Bsel` / `Variables.$Codemo` ; `$Codemo` n'est lu nulle part.
- Table `Fiches_Mo` en dur, chargement complet sans pagination ni filtre.

## Dépendances principales

- Utilise : `Utils` (`Base4`, `rs4`, `Observers`), `Variables`.
- Utilisé par : personne.

## Risques

- Aucun à l'exécution ; la classe brouille la lecture (homonymie avec `Facture.TriMo`) et
  maintient `Variables.$Codemo` en vie.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 2 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 2 (`Colmo_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 contrôle statique (TRIMO-T01) garantissant l'absence de référence avant suppression. Aucun
scénario `replay` possible.

## Rework

1 étape de documentation (TRIMO-001). 1 anomalie (TRIMO-A01) : suppression du couple
`.class` + `.form`, puis de `Variables.$Codemo` (VARIABLES-002).
