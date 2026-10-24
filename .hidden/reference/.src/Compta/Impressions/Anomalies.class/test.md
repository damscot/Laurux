# Anomalies — Tests

> Source : `.src/Compta/Impressions/Anomalies.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de contrôle en lecture seule : tests `replay` sur MariaDB Docker (`Laurux01.sql` + jeu dérivé
`data/mvt_cles.sql` où quelques lignes de `Fiches_Mvt` et `Fiches_Mvt1` ont une colonne `control`
altérée). Résultat comparé : texte du PDF (`pdftotext`), messages, dump inchangé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ANOMALIES-T01 | replay | Dates par exercice | ouverture, puis clic sur N-1…N-5 | dates `DteN0`/`DteN1` de référence | `tests/anomalies_dates/` | à faire |
| ANOMALIES-T02 | replay | Exercice en cours | 3 lignes altérées dans `Fiches_Mvt` | texte PDF (numéros, clés mémorisée et calculée) | `tests/anomalies_n/` | à faire |
| ANOMALIES-T03 | replay | Exercice N-1 | 2 lignes altérées dans `Fiches_Mvt1` | texte PDF (clé calculée sur `Fiches_Mvt`, A01 figée) | `tests/anomalies_n1/` | à faire |
| ANOMALIES-T04 | replay | Aucune anomalie, plage vide, table absente | base saine ; plage sans écriture ; N-5 sans table | « Aucune anomalie ! » ; aucun message (A03) ; message d'erreur | `tests/anomalies_cas_limites/` | à faire |
| ANOMALIES-T05 | gbtest | `Exercice_End`/`Exercice_Begin` | indices 0 à 5 | dates de référence ; égalité avec `LDate.Exercice_Cloture` au jour près | `tests/anomalies_exercice/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` isolé, date
  d'impression masquée.
- T05 instancie le formulaire sans l'afficher (gb.test sous Xvfb, à confirmer) ; il disparaît si
  les fonctions sont supprimées au profit de `LDate`.
- **Non testable automatiquement** : l'interruption de la `ProgBar` en cours de traitement.
