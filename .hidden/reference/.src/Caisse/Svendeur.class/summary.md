# Svendeur — Synthèse

> Source : `.src/Caisse/Svendeur.class` · Synthèse des autres documents.

## Rôle

Petite fenêtre « Caissière » ouverte par la saisie `Caisse` (`Alt+V`/`Ctrl+X`, ticket vide) pour
choisir un autre vendeur pour le ticket, sans mot de passe. Le choix passe par `Start.$Cai` et
`Caisse.$Vendeur`.

## Points clés

- 4 fonctions : constructeur (liste des vendeurs) et trois handlers.
- `Caisse.$Vendeur` est écrit sur l'auto-instance de `Caisse`, alors que la saisie affichée est
  une instance `New Caisse` : le changement de vendeur ne serait jamais pris en compte.
- Code vendeur lu sur un caractère.

## Dépendances principales

- Appelant : `Caisse` (auto-instance, deux raccourcis).
- Utilise : `Utils.db`, `Start.$Cai`, `Caisse.$Vendeur` (auto-instance).
- Table : `Fiches_Vendeurs`.

## Risques

- Changement de vendeur sans effet et instance cachée de `Caisse` (SVENDEUR-A01, à confirmer à
  l'exécution, gravité élevée en caisse).
- Vendeur `12` contrôlé comme `1` (SVENDEUR-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 44 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 15 |
| Complexité max (fonction) | 6 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 scénarios `replay` (SVENDEUR-T01 à T04) : liste, changement de vendeur suivi d'un ticket
(référence de A01), quitter, code sur deux caractères.

## Rework

3 étapes sans changement de comportement (SVENDEUR-001 à 003) : documentation, séparation de la
requête de contrôle, helper `LVendeur`. 2 anomalies (SVENDEUR-A01, A02).
