# Tregie — Synthèse

> Source : `.src/Gestion/option/Tregie.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de paramétrage des **régies** (droits sur les alcools, option boissons) : type, taux de
droit, seuil de degré et taux de cotisation sécurité sociale, régime acquitté/suspendu, assiette
volume/alcool pur, droits sur facture, compte et TVA (`Fiches_regie`). Ces paramètres sont ceux
de `calculdroit` et `calculdroit1`.

## Points clés

- Barre `barselection` (`"111111110"`) : transaction pendant la saisie, `Commit` à la validation.
- **Après modification d'une régie, recalcul en masse des articles** (`modifart`) : droits et sécu
  recalculés, incorporés aux frais (suspendu ou droits sur facture) ou au prix d'achat
  (acquitté), puis prix de revient et, au choix, prix de vente ou coefficient ; édition PDF
  avant/après.
- Grilles mensuelles (4 exercices) créées avec leurs en-têtes mais jamais alimentées.

## Dépendances principales

- Utilise : `barselection`, `calculdroit`, `TriCpt`, `PdfWriter`, `Visualiseur`, `Utils.db`,
  `Start.LocalSettings` (`pp`).
- Utilisé par : `menuopt` (`.Show`).
- Tables : `Fiches_regie`, `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Comptes`, `Fiches_Parametres`.

## Risques

- `form_Close` → `bar1_valide` sans argument (« Not enough arguments », vérifié `gbs3`).
- `FOR UPDATE` non supporté en SQLite ; suppression non implémentée.
- Recalcul en masse : division par un prix de revient nul, prix remis à 0 si le choix n'est ni 1
  ni 2 (à confirmer).
- Table et colonnes d'option absentes de `db_control.csv`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 448 |
| Lignes de commentaire | 5 |
| Fonctions | 32 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 101 |
| Complexité max (fonction) | 13 (`verifie`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (TREGIE-T01 à T07) : 6 replays (création, contrôles, recalcul suspendu/acquitté,
option fioul, fermeture) et 1 `gbtest` du calcul de prix extrait.

## Rework

7 étapes (TREGIE-001 à 007) : documentation, extraction du calcul de prix et des contrôles,
`Cbase.Table`, relectures factorisées, cycle de barre commun. 5 anomalies (A01 à A05).
