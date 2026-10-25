# TriCpt — Synthèse

> Source : `.src/Affichages/TriCpt.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de **sélection d'un compte** (général, client, fournisseur, adresse de livraison,
contact), appelée 62 fois dans 41 fichiers (comptabilité, gestion, caisse). Elle héberge une liste
`TriGen` reconstruite à chaque changement de mode.

## Points clés

- `_new(type, solde, obj)` : `type` = énumération (`Tous`, `Client`, `Fournisseur`,
  `Client_Fournisseur`, `Bilan`, `Gestion`, `General`, `Tresorerie`) ou lettre `B/G/C/F/T` ;
  `Avec_Solde` ajoute la colonne solde.
- **Protocole** : `TriGen` écrit `Bsel`/`Bval` sur `TriCpt`, que `ColTri_MajSel` recopie chez
  l'appelant. **Pas de remise à zéro à l'ouverture** : une annulation réapplique la dernière
  sélection (A01, MATERIEL-A09).
- Condition imposée selon le type, les cases clients et le nom de l'appelant (`Lettrage` →
  `lettrable`).
- Chaque reconstruction émet 3 requêtes, dont une lecture complète de la table pour obtenir la
  structure ; tables en dur, sans `Cbase.Table`.
- Pas d'`Utils.Observers` : fenêtre non instrumentée pour le rejeu.

## Dépendances principales

- Utilise : `TriGen`, `ObjProp`, `Utils.db` ; tables `Fiches_Comptes`, `Fiches_Cli`,
  `Fiches_Four`, `Fiches_AdrlivC`, `Fiches_ContactC`, `Fiches_ContactF`.
- Utilisé par 41 fichiers (`Saisecrit`, `Lettrage`, `Balance`, `Facture`, `Caisse`, `Pointage`,
  `Materiel`…) qui doivent garder `Public Bsel`/`Bval` ; `TresorFac` ne les a pas
  (TRESORFAC-A02).

## Risques

- Correction de A01 : change le comportement d'annulation des 41 appelants.
- Condition `General` sans parenthèses (A02) ; erreur SQL après changement de mode (A03) ;
  `lettrable` ignoré pour les fournisseurs (A04) ; mode Trésorerie inaccessible (A05).
- Rejeu impossible sans instrumentation : conditionne les scénarios de tous les appelants.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 455 |
| Lignes de commentaire | 1 |
| Fonctions | 25 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 17 (`tricond`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests prévus (TRICPT-T01 à T10) : 9 `replay` (compte général, modes clients, conditions, mode
Tous, lettrage, annulation, trésorerie, clients+fournisseurs, erreur après changement de mode)
et 1 `gbtest` sur la condition extraite.

## Rework

8 étapes sans changement de comportement (TRICPT-001 à 008) : documentation, colonnes et
remplissages communs, code sans effet, condition en fonction pure, lecture de structure sans
parcours de table, `Cbase.Table`, relais commun avec `TriArticles`. 5 anomalies (TRICPT-A01 à
A05).
