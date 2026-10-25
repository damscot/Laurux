# Tregion — Synthèse

> Source : `.src/Gestion/option/Tregion.class` · Synthèse des autres documents.

## Rôle

Écran de la table de la TIPP régionale (option carburant) : `Fiches_region`, clé `(code, cart)`,
où la ligne `cart='0'` porte l'intitulé de la région et les autres lignes le taux par article.
Ouvert par `menuopt.tipp_click`.

## Points clés

- Table **créée à l'exécution** par `modfichier.fichiercarbu`, absente de `db_control.csv`, de
  `Laurux01.sql` et de `Cbase`.
- Cycle `Barselection` transactionnel (socle commun avec Ttourne, Tregie, Tconsigne,
  Mreglement) ; hors du socle « table code/libellé » de Centrales.
- Suppression affichée mais non implémentée.
- Instrumenté (`Utils.Observers` + observateurs `cmpt`) : rejouable.

## Dépendances principales

- Utilise : `Barselection`, `Utils.db`, `Utils.Observers`/`ObsGotf`/`ObsLstf`, tables
  `Fiches_region`, `Fiches_Art`.
- Utilisé par : `menuopt`. Table partagée avec `rechtipp`, `Edittipp`, `Facture`, `FClient`.

## Risques

- **Modification d'un taux** : `Edit` filtré sur `code` seul → la mauvaise ligne peut être
  modifiée (A03, à confirmer).
- Fermeture : erreur « Not enough arguments » sur « Oui » (A01), transaction laissée ouverte sur
  « Non » (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 168 |
| Lignes de commentaire | 2 |
| Fonctions | 19 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 8 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (TREGION-T01 à T08) sur un jeu `tipp_base` préparé en activant l'option carburant dans
le clone non modifié.

## Rework

5 étapes (TREGION-001 à 005) : documentation, extraction des requêtes, validation séparée, clé
`Cbase`, cycle `Barselection` commun. 5 anomalies (A01 à A05).
