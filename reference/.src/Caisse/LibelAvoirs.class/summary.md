# LibelAvoirs — Synthèse

> Source : `.src/Caisse/LibelAvoirs.class` · Synthèse des autres documents.

## Rôle

Écran de saisie d'un texte unique de la caisse : texte de durée de validité des avoirs (`Fiches_LibelAvoirs.libelav`, lu par `Caisse.class:289`, table en dur). Ouvert depuis le menu de gestion
(`Fmenu.Menu208_Click`).

## Points clés

- Table mono-ligne : `INSERT` si vide, sinon `UPdate` **sans `WHERE`** (volontaire).
- Copie quasi identique de `LibelTicket` et de `LibelFac` (famille « texte unique » avec `Tleg`, `Tmail`).
- `Button2_Click` n'est pas un handler levé (`Button2` est dans le groupe `Btn`) : portée
  réductible confirmée.
- `Music.Load` sans `Music.Play`, branche `Case 1` vide : code mort.
- Écran non instrumenté (`Utils.Observers` absent) : non rejouable en l'état.

## Dépendances principales

- Appelant : `Fmenu`. Utilise `Utils.db`, `Cbase.Table`, `Utils.ReplaceLb`, `Doc`.
- Dépendance de données : la caisse lit la même table pour imprimer.

## Risques

- Texte impossible à effacer ; `"` et `&` transformés silencieusement (A01).
- Pas de journal de rejeu (A02) : les tests de phase 2 demandent une injection par le harnais.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 34 |
| Lignes de commentaire | 26 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 11 |
| Complexité max (fonction) | 4 (`Btn_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `replay` prévus (création/modification, texte vide, caractères spéciaux), comparés
par dump de la table, valeurs attendues produites dans le clone non modifié.

## Rework

5 étapes sans changement de comportement (LIBELAVOIRS-001 à 005) : documentation, code mort,
séparation lecture/écriture, commonalisation « texte unique », réduction de portée de
`Button2_Click`. 2 anomalies (LIBELAVOIRS-A01 à A02) soumises à validation.
