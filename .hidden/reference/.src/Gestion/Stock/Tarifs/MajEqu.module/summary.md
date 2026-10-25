# MajEqu — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/MajEqu.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Maintient la table des codes équivalents `Fiches_Cequ` : chaque article d'un groupe
d'équivalence est relié à tous les autres, dans les deux sens. `Maj(code, cequ)` ajoute une
équivalence (et met à jour `art_cequ`), `Recup()` reconstruit la symétrie de toute la table.

## Points clés

- Module sans état, traitement SQL pur, sans GUI.
- Doublons évités par la clé primaire `(codep, codequ)` : 17 `INSERT` sous `Try`.
- Fermeture transitive par doubles boucles de requêtes (O(n²) par groupe) ; deux des trois blocs
  de `Maj` sont textuellement identiques.
- Export optionnel vers le « serveur » (`Serveur.Pass("EQ", …)`).

## Dépendances principales

- Utilisé par : `Articles` (3 appels), `Impart` (2 appels, dont un avec arguments inversés),
  `Prgm` (`Recup`).
- Utilise : `Utils.db`, `Cbase.Table("TabCequ"/"TabArt")`, `Variables.Sprix/Sexport/SMajArt`,
  `Serveur.Pass`.

## Risques

- `Recup` plante sur une table vide (MAJEQU-A01).
- Avec la backtrace active, chaque doublon ignoré ouvre une boîte d'erreur (MAJEQU-A02, à confirmer).
- Fermeture transitive en une passe : complétude à vérifier par MAJEQU-T02.
- L'appel inversé d'`Impart.class:1290` écrit `art_cequ` sur le mauvais article (IMPART-A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 47 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 29 |
| Complexité max (fonction) | 24 (`Maj`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 4 gb.test sur base Docker (ajout simple, chaîne d'équivalences, idempotence, `Recup`)
et 2 replays (export serveur, doublons avec backtrace).

## Rework

4 étapes (MAJEQU-001 à 004) : documentation, helper `Lien`, factorisation des deux blocs
identiques, garde d'export commune `Serveur.Actif`. 2 anomalies (A01, A02).
