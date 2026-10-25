# Ecomptamat — Synthèse

> Source : `.src/Gestion/option/Ecomptamat.class` · Synthèse des autres documents.

## Rôle

État `gb.report` de la déclaration mensuelle de la comptabilité matières (alcools) pour les
régies en régime suspendu : plage des vignettes, volumes effectif et d'alcool pur, droits,
sécurité sociale et total à payer. Instancié par `Caleditcmat.Edit`.

## Points clés

- **Lecture seule, aucune écriture comptable : pas un module complexe** (la clôture, qui écrit,
  est dans Caleditcmat).
- 46 handlers `Data` du `.report` (faux `unused` de `deps.py`).
- Jumeau d'`Einvmat` (~280 lignes communes) ; `convers` arrondit avant découpage hl/l/cl.
- Écrit `Caleditcmat.ddcl` à chaque cellule (dépendance circulaire).
- Ne concerne pas les tables `*M` du matériel.

## Dépendances principales

- Utilise : `Caleditcmat` (structure `Declaration`, `ddcl`), `Utils.db`, `Utils.lastday` ;
  tables `Fiches_Societes`, `Fiches_Parametres`, `Fiches_ligregie`, `Fiches_regie`.
- Utilisé par : `Caleditcmat.Edit` (toujours avec `edit = False`).

## Risques

- Plage de vignettes fausse en réédition (paramètre toujours `False`, voir CALEDITCMAT-A05) et
  non filtrée (A02).
- N° d'identification peut-être non imprimé (`ni_Data` vide, A01, à confirmer).
- Première société imprimée en multi-sociétés (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 306 |
| Lignes de commentaire | 13 |
| Fonctions | 48 |
| Fonctions Public | 47 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 6 (`convers`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays et 1 gbtest (ECOMPTAMAT-T01 à T07) : texte du PDF, options de calcul et d'arrondi,
réédition, vignettes, identifiant, `Convers`.

## Rework

4 étapes (ECOMPTAMAT-001 à 004) : documentation, variable locale au lieu de `Caleditcmat.ddcl`,
code mort, module commun avec Einvmat. 4 anomalies (A01 à A04).
