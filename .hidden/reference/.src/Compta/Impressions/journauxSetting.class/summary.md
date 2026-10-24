# journauxSetting — Synthèse

> Source : `.src/Compta/Impressions/journauxSetting.class` · Synthèse des autres documents.

## Rôle

Boîte modale « Colonnes d'export » ouverte depuis l'écran `Journaux`. L'utilisateur compose, par
double-clic ou glisser-déposer, la liste ordonnée des colonnes du fichier `journaux.txt` ; la
validation l'enregistre dans `Laurux.conf` (`/ExportJournal<société>/Entete<i>` et `/Titre<i>`).

## Points clés

- Contrat implicite avec `Journaux` : 12 libellés ↔ indices 0 à 11 du tableau `p[]` de l'export,
  valeur `" "` pour une position absente, positions 0 à 15.
- Les 12 libellés sont définis deux fois (remplissage de `ListBox1` et `Select Case` de
  validation).
- Aucun SQL ; seul effet : `Start.LocalSettings` + `Save`.

## Dépendances principales

- Appelée par `Journaux.BtnPrefColonnes_Click` (auto-instance modale).
- `Start.LocalSettings`, `Start.Societe`, `Start.Musique`, `Utils.Observers`.

## Risques

- Valider une liste vide conserve l'ancienne configuration (A01).
- Glisser vers la liste des champs crée des doublons (A02).
- Toute évolution des libellés ou indices doit être faite en même temps dans `Journaux`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 123 |
| Lignes de commentaire | 6 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 16 (`BtnValider_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (JOURNAUXSETTING-T01 à T06) : configuration complète, partielle, doublon, liste
vide, glisser-déposer, annulation. Critère : section `[ExportJournal01]` du `Laurux.conf` de test.

## Rework

6 étapes sans changement de comportement (JOURNAUXSETTING-001 à 006) : documentation, code mort,
table constante des libellés, helpers partagés avec `Journaux`, séparation traitement/GUI,
réduction de portée de `testColonne`. 2 anomalies (JOURNAUXSETTING-A01, A02).
