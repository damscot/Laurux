# TarTypeCli — Synthèse

> Source : `.src/Gestion/Tables/TarTypeCli.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran des tarifs particuliers par client (`Fiches_Tarcli`) ou par type de client
(`Fiches_TarTypcli`) : liste des articles concernés (prix HT/TTC, remise, marge calculés en SQL),
saisie d'un coefficient, d'un prix ou d'une remise avec recalcul par cascade `LPrix`/`LTaxe`,
enregistrement et suppression. Ouvert depuis le menu, la fiche client et la fiche article.

## Points clés

- Deux modes fixés par l'énumération publique `client`/`type` ; requêtes dupliquées selon le
  mode dans 7 fonctions.
- Liste `TriGen` reconstruite à chaque changement de client/type.
- Remise passée en **montant** dans `Tcoeff_Lostfocus` (variante de la cascade de `GesTar`).
- Tables en dur, sauf `TabTypec`.

## Dépendances principales

- Utilise : `TriGen`, `TriCpt`, `TriArticles`, `LPrix`, `LTaxe`, `Chainage`, `TextReg`,
  `Utils.db`.
- Utilisé par : `Fmenu`, `FClient`, `Articles` (constructeur et énumération).

## Risques

- Suppr en mode type : requête sur la mauvaise table (A01).
- Sélection dans la liste : coefficient d'un autre client / type affiché puis enregistré (A02).
- Liste périmée après « supprimer tout » (A03) ; trace `artman` (A04) ; erreurs après un
  article introuvable (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 413 |
| Lignes de commentaire | 32 |
| Fonctions | 30 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 93 |
| Complexité max (fonction) | 8 (`Art_man`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 scénarios `replay` (TARTYPECLI-T01 à T08) : création client et type, cascade de prix,
sélection dans la liste, suppressions, ouverture contextuelle, recherche d'article. gb.test des
formules après séparation.

## Rework

7 étapes (TARTYPECLI-001 à 007) : documentation, code mort, table/colonne selon le mode,
`Cbase.Table`, réduction de portée de 7 fonctions, séparation traitement/GUI, fabrique de prix
commune. 5 anomalies (TARTYPECLI-A01 à A05).
