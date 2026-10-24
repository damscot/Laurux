# Remisec — Synthèse

> Source : `.src/Gestion/Tables/Remisec.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de la table des remises par type de client et par famille (`Fiches_RemTypec`), lue par
`TarArt`, `Facture`, `Moulinage` et `TriEqu`. Liste affichée par `RichDataGrid` (tri, recherche),
saisie type / famille / remise, enregistrement et suppression.

## Points clés

- Unique utilisateur de `RichDataGrid` et de `CFormat` (formats de colonnes).
- Copie du gabarit de `CoefTypeC` au nom de table et de colonne près ; proche de `Remisecli`.
- Contrôles `Quitte_*` sans valeur de retour : l'enregistrement n'est jamais bloqué.
- Noms de tables en dur alors que la clé `TabRemTypec` existe ; en-tête de fichier inexact.

## Dépendances principales

- Utilise : `RichDataGrid`, `CFormat`, `Cbase` (`TabTypec`, `TabFam`), `Utils`, `Doc`.
- Utilisé par : `Fmenu` (ouverture) ; la table est lue par `TarArt`, `Facture`, `Moulinage`,
  `TriEqu`.

## Risques

- Enregistrement d'un type ou d'une famille inexistants (A01).
- Remise affichée avec un format dégradé par `CFormat` (A02, à confirmer).
- Ligne sélectionnée arbitraire après une création (A03) ; erreur sur une ligne supprimée par
  ailleurs (A04).
- Rejeu des clics sur la grille à vérifier en phase 2 (pas de `Tabtypec_Click`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 243 |
| Lignes de commentaire | 41 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 10 (`Button3_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 scénarios `replay` (REMISEC-T01 à T05) : création, modification, saisie invalide,
suppression, affichage de la grille (format, tri, recherche).

## Rework

5 étapes (REMISEC-001 à 005) : documentation (en-tête), code mort, `Cbase.Table`, réduction de
portée de 5 fonctions, gabarit commun avec `CoefTypeC`/`Remisecli`. 4 anomalies (REMISEC-A01 à
A04).
