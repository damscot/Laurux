# Commerciaux — Synthèse

> Source : `.src/Gestion/Tables/Commerciaux.class` · Synthèse des autres documents.

## Rôle

Écran de la table des commerciaux (`Fiches_Commerciaux` : code, nom, prénom, taux de commission),
référencés par les fiches clients et les statistiques commerciales.

## Points clés

- Sans constructeur ; `Form_Open` initialise et charge, et il est rappelé par `Refresh`.
- Table nommée en dur ; code non unique en base.
- `Button1_Click`/`Button3_Click` sont des pseudo-handlers (boutons groupés `Btn`).
- `Btn_KeyPress` : toute touche sur Enregistrer enregistre.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `Utils.ObsGotf`/`ObsLstf`, `Utils.cpoint`, `Doc`.
- Utilisé par : `Fmenu` (`Show`) ; table lue par `FClient`, `Facturefm`, statistiques.
- `Vendeur_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : `DELETE` concaténé sur la ligne sélectionnée ; A02 : son joué sans chargement ;
  A03 : observateurs cumulés à chaque rafraîchissement ; A04 : doublons de code, suppression sans
  contrôle.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 145 |
| Lignes de commentaire | 4 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 38 |
| Complexité max (fonction) | 9 (`Ven_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, modification, commission invalide, suppression, rafraîchissements multiples).

## Rework

6 étapes (001 à 006) : documentation, `Cbase.Table`, découpage de `Form_Open`, séparation
traitement/GUI, socle commun, réduction de portée. 4 anomalies (A01 à A04).
