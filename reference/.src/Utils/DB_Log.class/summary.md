# DB_Log — Synthèse

> Source : `.src/Utils/DB_Log.class` · Synthèse des autres documents.

## Rôle

Fenêtre de consultation et de pilotage du journal de `DB_Connection` : affichage du log local en
grille (9 colonnes), activation, vidage, sauvegarde, édition des filtres `Clé:regex` et réglage des
niveaux console/fichier des loggers `LLog` par module.

## Points clés

- Ouverte depuis Gestion (`Fmenu.Menu330_Click`) et la caisse (`Cmenu.mdp_admin3`).
- `Refresh` recrée le logger de `DB_Connection` puis relit une copie temporaire du fichier.
- Découpage naïf `Split(…, ";")` : dépend du format exact des lignes de log.
- Aucun SQL, aucune table.

## Dépendances principales

- Utilise : `DB_Connection` (9 méthodes de pilotage du log), `Start.LLogColl` et les constantes de
  `LLog`.
- Utilisé par : `Fmenu`, `Cmenu` (constructeur). `.form` : `DB_Log.form` (13 handlers).

## Risques

- Lignes de log contenant `;` ou des sauts de ligne : affichage tronqué ou erreur d'indice (A01).
- `Copy` sans `Try`, fichier jamais fermé (A02) ; nom de sauvegarde basé sur la racine du sélecteur
  (A03, à confirmer).
- Couplage au format du log partagé avec `DB_Connection` et `ReplayObserver`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 224 |
| Lignes de commentaire | 2 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 42 |
| Complexité max (fonction) | 9 (`DebugView_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests prévus (DB_LOG-T01 à T07) : 6 `replay` sur des fichiers de log préparés (affichage, lignes
atypiques, activation, sauvegarde, filtres, niveaux) et 1 `gbtest` sur la lecture du log extraite.

## Rework

7 étapes sans changement de comportement (DB_LOG-001 à 007) : documentation, extraction de
`LireLog`, factorisation des bascules de panneaux et du cycle de niveaux, enum partagée du format,
code mort, réduction de portée. 3 anomalies (DB_LOG-A01 à A03).
