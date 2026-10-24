# Ligcli — Synthèse

> Source : `.src/Compta/Relances/Ligcli.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ligne graphique « client à relancer » de l'écran `FEditrel` : code, nom, solde, choix lettre ou
relevé, numéro de lettre, impression ou courriel, et édition individuelle de la lettre (PDF).
Affiche l'extrait de compte du client (lignes `Ligext`) quand elle prend le focus.

## Points clés

- Créée par `FEditrel.affiche` (parent `ScrollView1`, événements `"lig"`).
- Propriétés et méthodes `couleur`/`visext` appelées par `FEditrel` via `Variant`.
- `Buttonedit_Click` (CC 25) : copie individuelle de `FEditrel.Impressionr`, avec UPDATE de
  `Fiches_Mvt.relance`.
- Décocher un client supprime ses lignes de `Fiches_relances`.

## Dépendances principales

- Utilise : `Utils.db`, `Listextcpt`, `Ligext`, `Creleve`, `Visualiseur`, `EnvMail`, `LDate`.
- Tables : `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Txt_Relances`, `Fiches_relances`,
  `Fiches_Societes`, `Fiches_Mvt`.
- Utilisé par : `FEditrel` uniquement.

## Risques

- Lectures sans `Available` à la construction (LIGCLI-A01).
- Signe du solde et niveau de relance écrit incohérents avec `FEditrel` (A02, A03).
- Observateurs écrasés (A04, à confirmer) ; suppression sans confirmation (A05).
- Méthode morte `EnvMail` homonyme du module d'envoi.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 333 |
| Lignes de commentaire | 16 |
| Fonctions | 20 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 59 |
| Complexité max (fonction) | 25 (`Buttonedit_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (LIGCLI-T01 à T07) via `FEditrel` : construction, navigation, désélection,
éditions (lettre, relevé, saut de page), client sans compte. Courriel non testable
automatiquement.

## Rework

7 étapes : documentation, code mort (`EnvMail`, `devises`, `numlet_Write`), en-tête société et
corps de lettre communs avec `FEditrel`/`FRelCompte`/`FRelFacture`, séparation traitement/GUI,
`Cbase.Table`. 5 anomalies (LIGCLI-A01 à A05).
