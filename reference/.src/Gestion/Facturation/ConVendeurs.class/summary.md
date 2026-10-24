# ConVendeurs — Synthèse

> Source : `.src/Gestion/Facturation/ConVendeurs.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de connexion d'un vendeur en gestion commerciale (option `/Soc<XX>/Vendeurs`) : choix du
vendeur dans `Fiches_Vendeurs`, contrôle du mot de passe (déchiffré par `hexdblKey`),
mémorisation dans `/Soc<XX>/CodeVendeur` puis ouverture de la saisie de documents (`Facture`).

## Points clés

- Points d'entrée : `Fmenu.Menu42` (`New ConVendeurs`), `Fmenu.Menu193` (`New ConVendeurs(True)`)
  et la touche F5 de `Facture` (auto-instance).
- `Facture` est construite **avant** le contrôle de connexion et ouverte en modal après.
- Le contrat avec `Fmenu`/`Facture` est la chaîne « code nom » de `/Soc<XX>/CodeVendeur`.

## Dépendances principales

- Utilisé par : `Fmenu`, `Facture`.
- Utilise : `Fiches_Vendeurs` (`Cbase.Table("TabVendeurs")`), `hexdblKey`, `Start.LocalSettings`,
  `Facture`.
- Duplication avec `Caisse/Ouverture` et `Caisse/Svendeur` (sélection de vendeur).

## Risques

- `New ConVendeurs(True)` (Menu193) lève « Type mismatch » : l'argument part au constructeur de
  `Form` (vérifié sur un projet minimal) — CONVENDEURS-A01.
- Codes vendeurs à 2 caractères mal gérés (`Left$(…, 1)`) — A02.
- « Déconnecter » masque l'auto-instance et non la fenêtre affichée — A03.
- Depuis F5 de `Facture`, une seconde saisie de documents s'ouvre (à confirmer) — A04.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 9 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (CONVENDEURS-T01 à T06) sur un jeu dérivé de deux vendeurs : connexion
réussie/refusée, code sur 2 caractères, déconnexion, F5 depuis `Facture`, menu entretien. Les
anomalies sont figées (caractérisation).

## Rework

5 étapes (CONVENDEURS-001 à 005) : documentation, réduction de portée, simplification du drapeau
`b`, séparation SQL/GUI, helper commun avec `Ouverture`/`Svendeur`. 5 anomalies (A01 à A05)
soumises à validation.
