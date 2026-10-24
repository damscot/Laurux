# TextReg — Synthèse

> Source : `.src/Utils/TextReg.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Contrôle de saisie standard de Laurux (`ButtonBox` exporté) : filtrage par expression régulière,
types texte/numérique/date/date-heure, fenêtre de recherche en base, historique des saisies,
mode scanner de codes-barres, restauration par Échap.

## Points clés

- Posé dans **36 formulaires (239 contrôles)** et créé dynamiquement par `TriGen`, `Sailig`,
  `SaiTableau`, `Caisse`, `menuopt`, `Achat` : les `.form` et noms de contrôles sont figés.
- Le contrôle, sa fenêtre et sa grille de recherche partagent le nom d'événement `butb`.
- Paramètres et historique persistants via `ObjProp` (fichier `Laurux-AutoParams-<société>.conf`),
  relus à chaque prise de focus.
- Recherche : `SELECT <champs> FROM <table> WHERE <champ> LIKE &1 <condition>` (valeur
  paramétrée, noms de tables en dur chez les appelants).
- `butb_keypress` : CC 31.

## Dépendances principales

- Utilise `Utils.db`, `Utils.de` (`DB_Desktop`), `ObjProp`, `LDate`, `LDateC`.
- Dépendance circulaire avec `ObjProp` ; propriétés appliquées par réflexion depuis `ObjProp`
  (`Champ`, `reg`, `Choirech`).
- `deps.py` signale à tort `champs` et `lke` comme réductibles (ils sont utilisés).

## Risques

- Contrôle omniprésent : toute régression touche la saisie de presque tous les écrans.
- Mode scanner sous Wayland contourné (A01) ; lecture de `MaxLength` en erreur (A02) ; changement
  de type vers une date après un type texte en erreur (A03) ; accès à la grille sans contrôle
  (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 536 |
| Lignes de commentaire | 14 |
| Fonctions | 52 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 177 |
| Complexité max (fonction) | 31 (`butb_keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests : 4 `gbtest` (numérique, dates, changement de type, fonctions pures extraites) et 6
`replay` (filtre à la frappe, perte de focus, recherche, historique, Échap/calendrier, scanner),
valeurs générées dans le clone Laurux non modifié.

## Rework

10 étapes (TEXTREG-001 à 010) : documentation, code mort, helper de date, découpage de
`butb_keypress`, simplifications, extraction de la recherche et de la conversion numérique,
format de décimales partagé avec `Utils`, réduction de portée de `Unselect`, relecture des
paramètres limitée. 4 anomalies (A01 à A04) soumises à validation.
