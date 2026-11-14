# Edsdepots — Tests

> Source : `.src/Gestion/Depots/Edsdepots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec comparaison du PDF produit (texte extrait) et du dump de `Fiches_Sdepots`. Valeurs
attendues produites dans le clone **Laurux non modifié**, horloge fixée (dates par défaut
calculées depuis `Now`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDSDEPOTS-T01 | replay | Impression entrées + sorties | jeu avec mouvements `E` et `S` ; Imprimer | `~/tmp/RegulDep.pdf` (texte de référence) | `tests/impression_es/` | implémenté |
| EDSDEPOTS-T02 | replay | Sorties seules | jeu sans `E` dans la période ; Imprimer | erreur d'objet nul (A01 figée) | `tests/sorties_seules/` | implémenté (code 125 figé) |
| EDSDEPOTS-T03 | replay | Aucun mouvement | période vide | message « Aucun mouvement » | `tests/aucun_mouvement/` | implémenté |
| EDSDEPOTS-T04 | replay | Purge | `Effmvts` cochée, Oui | erreur SQL `datesortie`, aucune suppression, message de succès (A02 figée) | `tests/purge/` | implémenté (code 125 figé) |
| EDSDEPOTS-T05 | replay | Dates inversées | fin < début | avertissement, saisie conservée | `tests/dates_inversees/` | implémenté |

## Détail des tests

- **Données** : jeu dérivé de `Laurux01.sql` avec des mouvements `Fiches_Sdepots` (produits par
  les replays de MvtDepots/Sdepots) ; un mouvement d'article supprimé pour vérifier qu'il n'est
  pas imprimé.
- **Comparaison** : `pdftotext` du PDF (sans dates d'édition) et dump de `Fiches_Sdepots`.
- **Horloge** : `faketime` pour figer les dates par défaut.
- **Implémentation (vague 6)** : jeux `sdepots_shared/sdepots_stock` (E et S) et `sdepots_shared/sdepots_sorties`
  (S seules) ; texte du PDF par `pdftotext` (`/Soc01/caisse/CmdVis`, fichier `edition.txt`). Scénarios
  `edsdepots_impression_es` (T01, dates par défaut 15.06.2014 → 15.06.2018), `edsdepots_sorties_seules` (T02 :
  « Null object » ligne 237, code 125), `edsdepots_aucun_mouvement` (T03, Laurux01), `edsdepots_purge` (T04 :
  `Click=-1@Effmvts`, Oui ; « Unknown column 'datesortie' » fatale, code 125 : le message de succès n'est pas
  atteint ; PDF produit avant), `edsdepots_dates_inversees` (T05 : date de fin 01.01.2010).
