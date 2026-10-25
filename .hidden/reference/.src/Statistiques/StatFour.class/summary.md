# StatFour — Synthèse

> Source : `.src/Statistiques/StatFour.class` · Synthèse des autres documents.

## Rôle

Écran de critères et de calcul du « Chiffre d'affaire fournisseur » (achats) : cumule le
`montant` des réceptions `Fiches_Entrecpt` par fournisseur sur la période N et N-1 dans `Total`,
puis ouvre `VisStatFour`.

## Points clés

- Squelette commun aux `Stat*` en variante (`Balloon`, son commenté, format `dd/mm/yyyy`).
- `Traitement` (CC 17) : N-1 calculé dans la boucle N ; branche `INSERT` invalide mais
  inatteignable.
- Seul écran statistique sur les achats.

## Dépendances principales

- Ouvert par `Fmenu.Menu169_Click` ; ouvre `VisStatFour` (non rejouable).
- Tables `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Parametres`, `Total`.

## Risques

- **A01** : N-1 multiplié par le nombre de réceptions N.
- **A03** : nom du fournisseur précédent pour un fournisseur supprimé.
- **A04** : réceptions non validées comptées, `montant` NULL non protégé.
- **A05** : table `Total` partagée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 166 |
| Lignes de commentaire | 34 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 40 |
| Complexité max (fonction) | 17 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 `replay` (simple, N-1, fournisseur absent, validée/NULL, cas limites, SQLite),
1 `gbtest`. Le scénario s'arrête à l'ouverture de `VisStatFour` (non rejouable).

## Rework

7 étapes (STATFOUR-001 à 007) : documentation, code mort, `Cbase.Table`, portée, socle
`StatCommun`, séparation, cumul en mémoire (après A01). 5 anomalies (A01 à A05).
