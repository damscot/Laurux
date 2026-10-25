# Banque — Synthèse

> Source : `.src/Gestion/Lcr/Banque.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Banque » (menu Tables) : création, modification et suppression des banques de remise LCR
(`Fiches_Banques`) : n° émetteur, RIB, SIREN, références, options d'adresse et de fin
d'enregistrement du fichier bancaire, adresse mail de la banque.

## Points clés

- Structure « grille virtuelle + fiche » avec SQL dans les handlers ; table en dur.
- Code banque sur un chiffre (1-9), relu par `Left$(…, 1)` dans tout le lot LCR.
- Logique morte (`B`/`code_LF`), double lecture de la fiche, `Print "ok"` de débogage.
- Non instrumenté (`Utils.Observers` absent) : pas de rejeu en l'état.

## Dépendances principales

- Ouvert par `Fmenu.MenuTbq_Click`. Utilise `Utils.Base`/`rs1`, `Utils.db`, `Doc`.
- Données lues par `Attribution`, `Preparation`, `Bordrx` (fichier bancaire et mail), `Glcr`.

## Risques

- Suppression d'une banque utilisée par des LCR/bordereaux (A02).
- Filtre clavier concaténé dans le SQL (A03).
- Longueurs des champs saisis non contrôlées alors que `Bordrx` les complète par `String$` (erreur
  si trop longs, voir BORDRX-A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 336 |
| Lignes de commentaire | 34 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 8 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (BANQUE-T01 à T08) : liste et filtres, consultation, création, modification,
suppression, code vide, code existant, guillemet. Ils exigent l'instrumentation (BANQUE-A04).

## Rework

6 étapes (BANQUE-001 à 006) : documentation, code mort, simplification des lectures, réduction de
portée (13 membres), séparation des écritures SQL, liste commune des banques. 5 anomalies
(BANQUE-A01 à A05).
