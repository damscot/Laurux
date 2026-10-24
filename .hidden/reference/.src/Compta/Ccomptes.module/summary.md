# Ccomptes — Synthèse

> Source : `.src/Compta/Ccomptes.module` · Synthèse des autres documents.

## Rôle

Aide d'affichage du plan comptable (`Fiches_Comptes`) dans la grille de `FComptes` : rendu des
cellules depuis `Utils.rs3`, largeurs de colonnes, chargement filtré par préfixe en tri
croissant (`Deb2`) ou décroissant (`Deb3`).

## Points clés

- Appelant unique : `FComptes`.
- 6 fonctions sur 10 sont mortes (`Deb4`…`Deb9`).
- SQL concaténé via `Utils.Base3` ; la saisie utilisateur `Sel` est entre guillemets doubles
  (atténué par le filtre de touches de `FComptes`).
- Couleur de fond lue dans `/Soc<XX>/Coul_fen` à chaque cellule, idiome répété dans ~36 écrans.

## Dépendances principales

- Utilise : `Utils.Base3`, `Utils.rs3`, `Utils.cpoint`, `Start.LocalSettings`.
- Utilisé par : `FComptes` (9 appels).

## Risques

- Résultat global `Utils.rs3` partagé : un autre écran peut l'écraser.
- Tri lexical `cast(compte_cc AS char)` non indexé (performance sur gros plans comptables).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 3 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 24 |
| Complexité max (fonction) | 6 (`Colco_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (CCOMPTES-T01 à T04 : ouverture, recherche, tri inverse, couleurs) et 1 gbtest (T05)
sur la fonction pure de construction du SQL créée par le rework.

## Rework

7 étapes (CCOMPTES-001 à 007) : documentation, suppression de 6 fonctions mortes, factorisation
`Deb2`/`Deb3`, SQL paramétré, helper de couleur commun, intégration éventuelle dans `FComptes`,
fonction pure de requête. 1 anomalie mineure (CCOMPTES-A01).
