# Ttarfioul — Tests

> Source : `.src/Gestion/option/Ttarfioul.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie avec calcul : replays avec dump de `Fiches_tarpp`/`Fiches_ligtarpp`, plus un
`gbtest` du calcul extrait (après TTARFIOUL-002). Valeurs attendues produites dans le clone
**Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TTARFIOUL-T01 | replay | Affichage d'un barème existant | Option → Tarif fioul ; code article avec barème (unité `M3`) | grilles affichées (bornes × 1 000) | `tests/affichage/` | à faire |
| TTARFIOUL-T02 | replay | Saisie, calcul, enregistrement | article sans barème ; 3 tranches ; marges ; Calcul ; Enregistrer | dump des deux tables (dernière tranche absente figée, A01) | `tests/saisie_calcul/` | à faire |
| TTARFIOUL-T03 | replay | Enregistrement sans recalcul | T01 ; modification d'un prix dans `TableView2` ; Enregistrer | dump | `tests/enreg_sans_calcul/` | à faire |
| TTARFIOUL-T04 | replay | Ouverture depuis la fiche article | `artopt` → bouton tarif | code verrouillé, barème affiché | `tests/depuis_artopt/` | à faire |
| TTARFIOUL-T05 | gbtest | Calcul de tranche | marge de tranche, prix de revient, marge de zone, supplément, TVA 20 % / 5,5 % | normal/sup HT et TTC de référence | `tests/prix_tranche/` | à faire |

## Détail des tests

- **Données** : jeu `option_carbu` (`modfichier.fichiercarbu`) + 2 articles fioul (`art_vol` `M3`
  et `L`), un barème existant.
- **Rejeu** : l'édition des cellules de `TableView` passe par l'éditeur interne ; vérifier que le
  journal `Utils.Observers` capture `Save` (sinon scénario manuel). T05 n'existe qu'après
  TTARFIOUL-002.
- **Comparaison** : dump normalisé des deux tables.
