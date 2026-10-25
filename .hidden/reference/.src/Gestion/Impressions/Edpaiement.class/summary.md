# Edpaiement — Synthèse

> Source : `.src/Gestion/Impressions/Edpaiement.class` · Synthèse des autres documents.

## Rôle

Écran modal d'impression des **règlements d'une journée de facturation**, groupés par mode de
règlement avec totaux (`~/tmp/Regl.pdf`, `Cbordereaux`), à partir de `Fiches_Bl` et/ou
`Fiches_BlM` (entretien).

## Points clés

- Table de travail `Paiements` supprimée et recréée à chaque impression (hors référence).
- `Button2_Click` (CC 29) : SQL, DDL, PDF ; libellés de total et changements de page dupliqués,
  branche « Aucun mouvement » inatteignable.
- `date1_LostFocus` : pseudo-handler d'un contrôle groupé.

## Dépendances principales

- Appelé par `Fmenu` (`Menu194`, `ShowModal`). Utilise `Cbordereaux`, `Visualiseur`, `Utils`.
- Lit `Fiches_Parametres`, `Fiches_Bl`, `Fiches_BlM`.

## Risques

- EDPAIEMENT-A01 (à confirmer) : factures avec heure dans `dtefac` absentes.
- EDPAIEMENT-A02 (à confirmer) : doublons si un numéro existe dans les deux tables.
- Table de travail globale : collision entre postes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 187 |
| Lignes de commentaire | 32 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 44 |
| Complexité max (fonction) | 29 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (EDPAIEMENT-T01 à T07) : trois sources, double règlement, journée vide,
`dtefac` avec heure (A01 figée), saut de page ; `Paiements` exclue du dump.

## Rework

7 étapes (EDPAIEMENT-001 à 007) : documentation, code mort, portée, complexité, séparation,
remplacement de la table de travail, saisie de date commune. 2 anomalies à confirmer.
