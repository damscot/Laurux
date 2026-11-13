# Ttarfioul — Tests

> Source : `.src/Gestion/option/Ttarfioul.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie avec calcul : replays avec dump de `Fiches_tarpp`/`Fiches_ligtarpp`, plus un
`gbtest` du calcul extrait (après TTARFIOUL-002). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TTARFIOUL-T01 | replay | Affichage d'un barème existant | Option → Tarif fioul ; code article avec barème (unité `M3`) | grilles affichées (bornes × 1 000) | `tests/affichage/` | implémenté (gb.test) |
| TTARFIOUL-T02 | replay | Saisie, calcul, enregistrement | article sans barème ; 3 tranches ; marges ; Calcul ; Enregistrer | dump des deux tables (dernière tranche absente figée, A01) | `tests/saisie_calcul/` | implémenté (gb.test : dernière tranche absente figée, A01 ; borne 1000 L tronquée à 999.999 par decimal(6,3)) |
| TTARFIOUL-T03 | replay | Enregistrement sans recalcul | T01 ; modification d'un prix dans `TableView2` ; Enregistrer | dump | `tests/enreg_sans_calcul/` | implémenté (gb.test) |
| TTARFIOUL-T04 | replay | Ouverture depuis la fiche article | `artopt` → bouton tarif | code verrouillé, barème affiché | `tests/depuis_artopt/` | implémenté (gb.test : New Ttarfioul(Null, code)) |
| TTARFIOUL-T05 | gbtest | Calcul de tranche | marge de tranche, prix de revient, marge de zone, supplément, TVA 20 % / 5,5 % | normal/sup HT et TTC de référence | `tests/prix_tranche/` | à faire : calcul non extrait (après TTARFIOUL-002) |

## Détail des tests

- **Implémentation (phase 2)** : module `.src/Tests/Gestion/TtarfioulTest.test` (gb.test au lieu de replay : l'éditeur de cellule de TableView et le clic de TableView ne sont pas rejouables) ; jeu `modfichier_shared/options_bois_pp` complété dans `_Setup` (001 en M3 avec barème 2 tranches, 002 en L). `_new` lit les couleurs dans `Settings` (configuration Gambas par défaut) et non `Start.LocalSettings` : le test pose `/Coul/Znss` et `/Coul/Focus` dans `Settings`, sinon « Type mismatch: wanted Integer, got Null » (Ttarfioul._new.24).

- **Données** : jeu `option_carbu` (`modfichier.fichiercarbu`) + 2 articles fioul (`art_vol` `M3`
  et `L`), un barème existant.
- **Rejeu** : l'édition des cellules de `TableView` passe par l'éditeur interne ; vérifier que le
  journal `Utils.Observers` capture `Save` (sinon scénario manuel). T05 n'existe qu'après
  TTARFIOUL-002.
- **Comparaison** : dump normalisé des deux tables.
