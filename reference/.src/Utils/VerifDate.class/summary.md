# VerifDate — Synthèse

> Source : `.src/Utils/VerifDate.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Date (`Inherits LDate`) qui vérifie qu'un document ou un mouvement ne tombe pas dans une période
close : clôture comptable mensuelle, période de facturation en cours, et en option B/T clôtures de
la comptabilité matières en droits suspendus ou acquittés. Les fonctions `Clot*` renvoient `True`
(date refusée) après un `Message.Warning`.

## Points clés

- Construction : 1 à 3 requêtes SQL (`Fiches_Parametres`, `Fiches_ligregie`/`Fiches_regie`).
- `ClotFac` = comptable + gestion (fenêtre de deux mois) ; `ClotDroi` = suspendu + acquitté.
- `ClotSuspendu`/`ClotAcquite` quasi identiques ; tables écrites en dur.
- `_call` est du code mort ; plusieurs membres `Public` sont internes.

## Dépendances principales

- Utilise : `LDate` (héritage), `Utils.Option`, `Utils.db`.
- Utilisé par 7 fichiers : `Facture`, `Facturefm`, `ObjFac`, `ObjFacB`, `SaiReg`, `Mvtex`,
  `commande1`.

## Risques

- Logique mêlée aux messages : impossible à tester en gb.test sans séparation.
- Appel statique dans `Facture` (auto-instance figée pour la session).
- `Error.Raise` dans le constructeur si `arrete` est vide (option B/T).
- Pas de test `Available` sur les paramètres.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 117 |
| Lignes de commentaire | 3 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 41 |
| Complexité max (fonction) | 10 (`ClotSuspendu`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus (VERIFDATE-T01 à T09) : 6 `gbtest` avec base (construction standard et B/T,
repli sur `arrete`, cas acceptés, erreur `arrete` vide) et 3 `replay` pour les cas refusés
(`SaiReg`, `Facture`, `Mvtex`).

## Rework

6 étapes sans changement de comportement (VERIFDATE-001 à 006) : documentation, code mort `_call`,
fusion suspendu/acquitté, séparation règles/messages, `Cbase.Table`, réduction de portée.
3 anomalies (VERIFDATE-A01 à A03) soumises à validation.
