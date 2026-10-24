# textfamille — Synthèse

> Source : `.src/Utils/textfamille.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Contrôle utilisateur (`Inherits ScrollView`, `Export`) de saisie d'un code famille en plusieurs
zones, une par niveau de la hiérarchie définie par le paramètre société `ipr`. Propriété `text` pour
lire/écrire le code complet.

## Points clés

- Aucun SQL ; dépend uniquement de `Start.LocalSettings` (`ipr`).
- Lève `KeyPress` à chaque zone validée, ce qui pilote les handlers de groupe des écrans.
- Paramétrage absent → `Message.Error` puis `Quit`.
- Code mort : ajustement de hauteur sans effet.

## Dépendances principales

- Placé dans 8 formulaires (`Changefam`, `Articles`, `EdArt1`, `Movr`, `Famille`, `CoefTypeC`,
  `Remisec`, `Remisecli`).
- Partage le paramètre `ipr` avec `Trifam`.

## Risques

- API utilisée via les `.form` (invisible pour `deps.py`) : `Clear`, `setfocus`, `Select`, `text`
  doivent rester publics.
- Arrêt de l'application si `ipr` manque ; code décalé si le premier niveau est vide.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 107 |
| Lignes de commentaire | 4 |
| Fonctions | 9 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 7 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests (TEXTFAMILLE-T01 à T06) : 4 gb.test sous affichage virtuel (construction, `text`, niveau
vide, `Clear`) et 2 replays (saisie dans la fiche article, `ipr` absent).

## Rework

5 étapes (TEXTFAMILLE-001 à 005) : documentation, code mort, helper de longueur, fonctions pures de
découpe/assemblage, lecture d'`ipr` commune avec `Trifam`. 2 anomalies (TEXTFAMILLE-A01, A02).
