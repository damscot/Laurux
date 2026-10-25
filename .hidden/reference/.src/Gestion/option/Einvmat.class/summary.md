# Einvmat — Synthèse

> Source : `.src/Gestion/option/Einvmat.class` · Synthèse des autres documents.

## Rôle

État `gb.report` de la déclaration mensuelle de la comptabilité matières (alcools) pour les
régies en droits acquittés. Il reçoit de `Caleditcmat.Edit` une collection de déclarations par
régie et imprime les volumes effectif et d'alcool pur (début, entrées, sorties, fin) en
hl/l/cl, avec totaux.

## Points clés

- Lecture seule, pas d'écriture comptable : ce n'est pas un module complexe.
- 33 handlers `Data` du `.report` (faux `unused` de `deps.py`, qui ne lit pas les `.report`).
- Copie quasi conforme d'`Ecomptamat` (régime suspendu) ; seule différence : l'arrondi de
  `convers`.
- Écrit dans `Caleditcmat.ddcl` à chaque cellule (dépendance circulaire).
- Ne concerne pas les tables `*M` du matériel.

## Dépendances principales

- Utilise : `Caleditcmat` (structure `Declaration`, `ddcl`), `Utils.db`, `Utils.lastday` ;
  tables `Fiches_Societes`, `Fiches_Parametres`, `Fiches_regie`.
- Utilisé par : `Caleditcmat.Edit`.

## Risques

- Formatage hl/l/cl incohérent aux arrondis (A01) et sur volumes négatifs (A03).
- En-tête de la première société en multi-sociétés (A02).
- `Application.Busy = 0` brutal (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 244 |
| Lignes de commentaire | 10 |
| Fonctions | 35 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 6 (`convers`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays et 1 gbtest (EINVMAT-T01 à T05) : texte du PDF comparé, horloge figée, jeu `cmat_base`.

## Rework

4 étapes (EINVMAT-001 à 004) : documentation, variable locale au lieu de `Caleditcmat.ddcl`,
code mort, module commun avec Ecomptamat. 4 anomalies (A01 à A04).
