# TriclientsD — Synthèse

> Source : `.src/Caisse/Affichages/TriclientsD.class` · Synthèse des autres documents.

## Rôle

Liste paginée de sélection des clients divers de la caisse dans `Fiches_Clid`. **Classe morte** :
jamais instanciée depuis l'intégration de la caisse dans Laurux ; la sélection des clients divers
passe par `Tricartes(-1)` sur `Fiches_Carte`.

## Points clés

- `jamais_reference` confirmé par `grep` (aucun appel, aucune chaîne `Class.Load`/`Object.New`).
- `colcli_Click` écrit `Caisse.Clicoded`, membre inexistant (erreur « Unknown symbol » à
  l'exécution), et `Caisse.Bsel` sur l'auto-instance, pas sur la fenêtre de caisse.
- 60 % de code commun avec `Tricartes` (pagination, filtre).
- `ClavInput` jamais appelée.
- `Fiches_Clid` n'a plus aucun écrivain (seulement purgée par `RazClientd`).

## Dépendances principales

- Utilisé par : personne.
- Utilise : `Utils.Base2`/`rs2`, `Utils.Obstch`, `Cbase.Table("TabClid")`, `Caisse` (auto-instance).

## Risques

- Aucun en production (code inatteignable). Risque de maintenance : factoriser ou corriger du code
  mort.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 177 |
| Lignes de commentaire | 11 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 65 |
| Complexité max (fonction) | 11 (`ColCli_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `replay` de non-régression (caisse et purge `RazClientd`) pour valider la suppression.

## Rework

Anomalie principale TRICLIENTSD-A01 : suppression du couple `.class`/`.form` (validation
utilisateur). À défaut, 3 étapes (documentation, `ClavInput`, réduction de portée) et l'anomalie
A02 (`Caisse.Clicoded`).
