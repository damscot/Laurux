# Ttourne — Synthèse

> Source : `.src/Gestion/option/Ttourne.class` · Synthèse des autres documents.

## Rôle

Écran de gestion des tournées (`Fiches_tourne` : code, libellé), ouvert par
`Fmenu.Menu327_Click`, avec un onglet de statistiques mensuelles par tournée délégué à `Gridvi`.

## Points clés

- Barre `Barselection` complète ; création et modification dans une transaction ouverte entre
  l'action et la validation (`Begin` → `Create9`/`Edit` → `Commit`/`Rollback`).
- Suppression affichée mais non implémentée.
- Relève du **socle `Barselection`** (Tregion, Tregie, Tconsigne, Mreglement), pas du socle
  « table code/libellé » de Centrales.
- Statistiques : `Gridvi` lit les BL/factures et leurs variantes `*M` (entretien matériel) ;
  Ttourne n'y accède pas directement.
- Instrumenté par `Utils.Observers(Me)` : rejouable.

## Dépendances principales

- Utilise : `Barselection`, `Gridvi`, `Utils.db`, `Utils.Observers`/`ObsGotf`/`ObsLstf`.
- Utilisé par : `Fmenu` (ouverture). La table est partagée avec `rechtour`, `FClient`, `Facture`.

## Risques

- **Fermeture avec « Oui »** : `bar1_valide` appelé sans argument → erreur d'exécution (A01).
- **Fermeture avec « Non »** : transaction laissée ouverte sur la connexion partagée (A02).
- Première tournée créée sur table vide → erreur « Null object » (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 147 |
| Lignes de commentaire | 3 |
| Fonctions | 21 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 46 |
| Complexité max (fonction) | 7 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 replays (TTOURNE-T01 à T10) : création, refus, modification, annulation, navigation,
suppression inopérante, fermeture Non/Oui, table vide, statistiques. Jeu `tournees_base` partagé
avec `rechtour`.

## Rework

5 étapes (TTOURNE-001 à 005) : documentation, extraction des requêtes, validation séparée, clé
`Cbase` commune avec `rechtour`, cycle `Barselection` commun. 4 anomalies (A01 à A04).
