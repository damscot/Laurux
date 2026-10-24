# Fprepdus — Synthèse

> Source : `.src/Communs/Fprepdus.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Petite fenêtre de **synthèse des dus** à la date du jour : nombre de clients débiteurs et total
dû (comptes `C` à solde positif), nombre de fournisseurs créditeurs et total (comptes `F` à solde
négatif), dans la devise de `Fiches_Parametres`. Ouverte par un clic sur `lblClm3` dans Fmenu.

## Points clés

- Calcul entièrement fait dans `_new` (deux parcours de `Fiches_Comptes`), lecture seule.
- `TraitementC` et `TraitementF` sont deux copies quasi identiques (CC 8 chacune).
- Devise mise au pluriel par ajout de « s », variable membre modifiée au passage.

## Dépendances principales

- Appelant : `Fmenu.lblClm3_MouseDown`.
- Utilise : `Utils.db`, `Utils.cpoint`, `Cbase.Table("TabParam")`, `Fiches_Comptes` (en dur).

## Risques

- Total fournisseurs affiché négatif, pluriel jamais appliqué côté fournisseurs (A01).
- Pluriel de devise naïf (« EURs ») (A02).
- Code mort (`Dte` reformatée inutilement).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 72 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 8 (`TraitementC`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (FPREPDUS-T01 à T05) : 4 `replay` sur les textes affichés (base de référence, jeu contrôlé,
aucun dû, devises) et 1 `gbtest` sur la fonction de calcul après séparation.

## Rework

5 étapes sans changement de comportement (FPREPDUS-001 à 005) : documentation, code mort, fonction
de calcul commune aux deux synthèses, `Cbase.Table`, réduction de portée. 2 anomalies
(FPREPDUS-A01, A02) soumises à validation utilisateur.
