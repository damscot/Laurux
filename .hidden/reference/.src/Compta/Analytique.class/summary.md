# Analytique — Synthèse

> Source : `.src/Compta/Analytique.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de répartition analytique d'une ligne d'écriture, ouverte par `Saisecrit` :
préremplissage depuis `Fiches_MvtA` (ventilation existante) ou `Fiches_Analytiques` (ventilation
par défaut du compte), édition poste / % / montant, enregistrement dans `Fiches_MvtA`.

## Points clés

- Calculs, SQL et contrôles mélangés dans `Tbrem_Save` et `Button2_Click`.
- Totaux recalculés en relisant les libellés (`Label3.Text` tronqué de `" %"`).
- `Tbrem_Save` est un handler (événement `Save`) : faux positif « portée réductible » de `deps.py`.
- Le bouton d'aide est dans le groupe `Btn` dont le handler est vide.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.cpoint`, `Cbase.Table`, `LDate`, `Doc`.
- Utilisé par : `Saisecrit` (1 appel) ; contrat implicite sur `Fiches_MvtA` avec `Saisecrit`.

## Risques

- Validation qui supprime la ventilation de **tous les comptes** de l'écriture et peut tronquer
  les postes enregistrés (A02, à confirmer par replay).
- Ventilation non équilibrée acceptée sans édition (A04).
- Plus de 20 postes → erreur à l'ouverture (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 181 |
| Lignes de commentaire | 9 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 8 (`Tbrem_Save`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (ANALYTIQUE-T01 à T07 : défaut, existante, édition, non équilibrée, deux comptes, aide,
21 postes) et 1 gbtest (T08) sur les fonctions de répartition extraites.

## Rework

7 étapes (ANALYTIQUE-001 à 007) : documentation, factorisation de `Deb1`, SQL paramétré, totaux
en `Float`, séparation traitement/GUI, réduction de portée, nettoyage. 5 anomalies
(ANALYTIQUE-A01 à A05).
