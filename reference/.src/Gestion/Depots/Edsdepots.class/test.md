# Edsdepots — Tests

> Source : `.src/Gestion/Depots/Edsdepots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec comparaison du PDF produit (texte extrait) et du dump de `Fiches_Sdepots`. Valeurs
attendues produites dans le clone **Laurux non modifié**, horloge fixée (dates par défaut
calculées depuis `Now`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDSDEPOTS-T01 | replay | Impression entrées + sorties | jeu avec mouvements `E` et `S` ; Imprimer | `~/tmp/RegulDep.pdf` (texte de référence) | `tests/impression_es/` | à faire |
| EDSDEPOTS-T02 | replay | Sorties seules | jeu sans `E` dans la période ; Imprimer | erreur d'objet nul (A01 figée) | `tests/sorties_seules/` | à faire |
| EDSDEPOTS-T03 | replay | Aucun mouvement | période vide | message « Aucun mouvement » | `tests/aucun_mouvement/` | à faire |
| EDSDEPOTS-T04 | replay | Purge | `Effmvts` cochée, Oui | erreur SQL `datesortie`, aucune suppression, message de succès (A02 figée) | `tests/purge/` | à faire |
| EDSDEPOTS-T05 | replay | Dates inversées | fin < début | avertissement, saisie conservée | `tests/dates_inversees/` | à faire |

## Détail des tests

- **Données** : jeu dérivé de `Laurux01.sql` avec des mouvements `Fiches_Sdepots` (produits par
  les replays de MvtDepots/Sdepots) ; un mouvement d'article supprimé pour vérifier qu'il n'est
  pas imprimé.
- **Comparaison** : `pdftotext` du PDF (sans dates d'édition) et dump de `Fiches_Sdepots`.
- **Horloge** : `faketime` pour figer les dates par défaut.
