# Eticli — Synthèse

> Source : `.src/Gestion/Etiquettes/Eticli.class` · Synthèse des autres documents.

## Rôle

Impression d'étiquettes adresse clients sur planche A4, par plage de codes (filtres type client, tri par code/type/CP) ou par liste (table temporaire `Etiquettes`).

## Points clés

- Grilles de sélection sur `Utils.rs1` (état global partagé) ; `pos_Etiq` V1 identique à Etiqart ; dessin d'adresse identique à `FClient.Imprime`.
- Bornes CP saisies mais jamais appliquées ; bornes client comparées en texte puis en nombre.
- `Button2_Click` CC 31 ; deux `Utils.Observers(Me)`.

## Dépendances principales

- Appelant : `Fmenu.Menu163_Click` (auto-instance).
- Tables `Fiches_Cli`, `Fiches_Typec`, `Fiches_Etiquettes` (littéraux), `Etiquettes` (temporaire).

## Risques

- Filtre CP ignoré (A01) ; bornes incohérentes et `>=` en mode liste (A02) ; tri par type masqué → `Null object` (A03) ; tri de `Colcli2` qui réinitialise `Colcli`, page du modèle ignorée (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 702 |
| Lignes de commentaire | 70 |
| Fonctions | 39 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 180 |
| Complexité max (fonction) | 31 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests `replay` (PDF normalisé et log).

## Rework

10 reworks (documentation, code mort, fusions internes, découpage de `Button2_Click` à SQL identique, table de travail commune, séparation, portée de 13 membres, `PlancheEtiquettes`, `Cbase`/observateurs, focus commun). 4 anomalies.
