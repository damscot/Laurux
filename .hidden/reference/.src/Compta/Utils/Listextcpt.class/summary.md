# Listextcpt — Synthèse

> Source : `.src/Compta/Utils/Listextcpt.class` · Synthèse des autres documents.

## Rôle

Extrait de compte **multi-exercices** : construit la requête `SELECT … UNION …` qui liste les
écritures d'un compte entre deux dates sur `Fiches_Mvt` (exercice en cours) et `Fiches_Mvt1`…`5`
(exercices clôturés), avec ligne de report à nouveau optionnelle. Sert aussi de point d'accès aux
mises à jour de lettrage (`letcpt`, `letgroupe`, `Controle`, `rechechelot`) et de pointage
(`totalpointe`, `enregistrepointage`) dans la bonne table d'exercice.

## Points clés

- `Create Static` ; usage `New Listextcpt(cpt, dtei, dtes, ltr, tri, origin, dteech)` puis
  `.resext` (exécution à chaque lecture) ou `.requete` (texte SQL).
- Bornes d'exercice relues dans `Fiches_Parametres.dteclec*` (6 tables testées par `LIMIT 1`).
- Traitement pur (SQL), sauf `Application.Busy` dans `enregistrepointage`.
- `_new` concentre la complexité (CC 28) ; 5 fonctions répètent le même motif d'`UNION` borné.
- **Contrat textuel** : `Pointage` retire les 14 derniers caractères de `requete`
  (`" ORDER BY  dte"`) ; le texte SQL doit rester identique.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.arrondi`, `LDate`, `LCoul.Ecr_DB_bgcolor` ; tables
  `Fiches_Parametres`, `Fiches_Mvt`…`Fiches_Mvt5`, `Fiches_Comptes` (noms en dur).
- Utilisé par 10 fichiers : `Extrait`, `Lettrage`, `Pointage`, `Tresor`, `EcrAuto`, `SaiReg`,
  `Facture`, `EdNlettrees`, `FEditrel`, `Ligcli`.

## Risques

- `der` jamais recalculé (ligne 82 compare deux fois à `dteinf`) ; alias d'objet entre `$dtei` et
  la borne de l'exercice le plus ancien ; colonnes inversées dans la ligne de report.
- Pointage et lettrage de groupe modifient toutes les tables d'exercice sans borne de date.
- `UNION (SELECT …)` probablement refusé par SQLite.
- Toute modification du texte de `requete` casse `Pointage`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 297 |
| Lignes de commentaire | 10 |
| Fonctions | 15 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 76 |
| Complexité max (fonction) | 28 (`_new`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 tests `gbtest` (LISTEXTCPT-T01 à T13) sur MariaDB Docker (`Laurux01.sql` + jeu multi-exercices) :
texte exact de la requête, résultats, report à nouveau, bornes, lettrage, contrôle d'équilibre,
pointage, cas d'erreur, SQLite et performance. Valeurs attendues capturées dans le clone non modifié.

## Rework

7 étapes sans changement de comportement (LISTEXTCPT-001 à 007) : documentation, code mort
(`litpointee`), découpage de `_new` à SQL identique, helper d'`UNION`, comparaison de dates par
`LDate`, `Application.Busy` remonté dans `Pointage`, bornes via `LDate.Exercice_Cloture`.
7 anomalies (A01 à A07) soumises à validation utilisateur.
