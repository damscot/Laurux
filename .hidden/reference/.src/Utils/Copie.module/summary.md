# Copie — Synthèse

> Source : `.src/Utils/Copie.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Copie un PDF généré dans `~/<chemin>/<type>.pdf` et mémorise le chemin de la copie dans les globales
`spiece`/`schemin`.

## Points clés

- Appelé par `Edbr` (bons de réception) ; `spiece` est relu par `FacturefmA` pour un envoi FTP.
- Le premier appel crée le répertoire sans copier.
- `schemin` et le paramètre `Dtef` sont inutilisés.
- Des contrôles nommés `Copie` dans `FClient`, `FFournisseur`, `Prefs` brouillent les greps.

## Dépendances principales

- `Edbr.module`, `FacturefmA.class` ; programme `cp`.
- Doublon fonctionnel : `Caisse.Dupli` (archivage des tickets).

## Risques

- Couplage temporel caché avec `FacturefmA` (fichier envoyé par FTP à confirmer).
- Chemins non quotés.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 17 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 5 (`Dupli`) |
| Variables globales | 2 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests (COPIE-T01 à T03) : 2 `gbtest` sur `Dupli`, 1 `replay` de validation de bon de réception.

## Rework

3 étapes (COPIE-001 à 003) : documentation, nettoyage, `schemin` en `Private`. 3 anomalies
(COPIE-A01 à A03).
