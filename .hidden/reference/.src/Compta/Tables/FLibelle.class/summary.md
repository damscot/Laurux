# FLibelle — Synthèse

> Source : `.src/Compta/Tables/FLibelle.class` · Synthèse des autres documents.

## Rôle

Écran de la table des libellés d'écritures (`Fiches_Libelles`) proposés à la saisie comptable.

## Points clés

- SQL paramétré ; `Utils.Remplace` nettoie l'intitulé.
- `num_*`/`intitule_*` : handlers nominaux inactifs (groupe `Lib`) appelés explicitement.
- `Refresh` appelé deux fois après insertion.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Remplace`, `Doc` ; table `Fiches_Libelles` (en dur).
- Utilisé par : `Fmenu.Menu24_Click` ; table lue par `Saisecrit` et `Tresor`.

## Risques

- A01 : suppression de la ligne sélectionnée et non du numéro saisi.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 134 |
| Lignes de commentaire | 22 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 10 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (création, modification, suppression) avec diff de `Fiches_Libelles`.

## Rework

5 étapes (001 à 005) : documentation, `Refresh` unique, `Cbase.Table`, séparation, portée.
1 anomalie (A01).
