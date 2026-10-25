# artopt — Tests

> Source : `.src/Gestion/option/artopt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Formulaire incrusté : tests `replay` depuis la fiche article (`Articles`, voir ARTICLES-T17) et
depuis `commande1`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ARTOPT-T01 | replay | Affichage option boisson | `/Soc01/bois = 1` ; article avec régie suspendue et consignes P/C/B ; article sans option | zones affichées (log), `Frais`/`Prvt` de la fiche | `tests/affichage_boisson/` | à faire |
| ARTOPT-T02 | replay | Saisie et recalcul | modification transport, volume, degré, régie (liste), consignes (liste et code inconnu) | `recalculpx` → prix de la fiche ; bulles | `tests/saisie_recalcul/` | à faire |
| ARTOPT-T03 | replay | Enregistrement | création et modification d'article en option `B`, `P`, `T` | `Fiches_Art` (dump des colonnes d'option) | `tests/enregistrement/` | à faire |
| ARTOPT-T04 | replay | Option carburant | article fioul avec `Fiches_ligtarpp` (unité `M3`), via `Articles` (taux de `TxTva`) et via `commande1` (taux de l'article) ; bouton tarif | grille du tarif ; fenêtre `Ttarfioul` | `tests/carburant/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + `modfichier` (boisson et carburant), régies, consignes,
  `Fiches_ligtarpp` ; voir le jeu `facturation_boisson` ([ObjFacB/test.md](../ObjFacB.class/test.md)).
- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; le dump de `Fiches_Art`
  fait foi.
- **Rejeu** : `Gridtarpp`, `Listcons`, `Listregie` n'ont pas de `_Click` (`replay_missing`) :
  sélectionner par `Activate` (double clic / Entrée) uniquement.
- **Non testable** : A01 (article introuvable à l'enregistrement) n'est pas atteignable depuis
  l'interface dans le déroulement normal ; à caractériser par un scénario forcé si possible.
