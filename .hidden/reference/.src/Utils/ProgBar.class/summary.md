# ProgBar — Synthèse

> Source : `.src/Utils/ProgBar.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre de progression commune (titre, barre, compteur, journal, Pause/Stop) utilisée par les
traitements longs : migrations, clôtures, purges, moulinage, GED, `DB_Sanity`…

## Points clés

- Forme d'appel : `New ProgBar(titre, n, parent, stoppable, unité, détail)` ; le 3ᵉ argument va à
  `Window._new` (vérifié par expérience `gbx3` 3.19).
- `Avancement()` met à jour l'affichage, gère la pause et renvoie la demande d'arrêt.
- Fermeture bloquée tant que le traitement n'est pas fini (sauf si stoppable) ; `Finalize`
  débloque.
- Aucune base de données.

## Dépendances principales

- 27 fichiers appelants (dont `LauruxMaj` : 18 instanciations, `FClotureAn`, `Moulinage`,
  `Raz*`, `DB_Sanity`, `LGed`, `GedR`).
- Utilise seulement `Utils.Observers`.

## Risques

- Unité jamais affichée (A01, latent) ; cadence de rafraîchissement fragile et division par zéro
  possible (A02).
- Tout changement de signature toucherait 27 fichiers.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 73 |
| Lignes de commentaire | 3 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 4 (`Form_Close`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `gbtest` (constructeur, cadence, arrêt/pause, fermeture, cas limites) et 1 `replay`
d'intégration (purge `RazDevis`).

## Rework

4 étapes (PROGBAR-001 à 004) : documentation, suppression de `Disable_Detail`, helper de
compteur, calcul du pourcentage isolé. 2 anomalies (A01, A02).
