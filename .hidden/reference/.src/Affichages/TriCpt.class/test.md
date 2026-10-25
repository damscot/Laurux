# TriCpt — Tests

> Source : `.src/Affichages/TriCpt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de sélection de compte : scénarios `replay` capturés dans le clone **Laurux non modifié**
depuis des appelants simples (`Plancomptable`, `Balance`, `Lettrage`, `Pointage`, `SaiReg`,
`EdMat`). Base `Laurux01.sql` + jeu dérivé `comptes_selection` : comptes B/G dont des comptes de
trésorerie (`comptr_cc ≠ 0`), clients avec adresses de livraison et contacts, fournisseurs avec
contacts, clients inactifs/divers/auto-entrepreneurs, comptes `lettrable` vrai/faux. Comparaison :
compte repris par l'appelant, lignes `Exec_SQL` (conditions imposées) à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRICPT-T01 | replay | Sélection d'un compte général | `Plancomptable` (`General`, sans solde) : filtre `401`, clic | compte repris ; figer la liste (condition `type_cc='B' OR type_cc='G'` sans parenthèses, A02) | `tests/compte_general/` | à faire |
| TRICPT-T02 | replay | Clients : facturation, livraison, contacts | `EdMat` (`Client`) : `Livr`, `contact`, `Afac`, changement de `Cselc` | colonnes et requêtes de référence ; code client repris | `tests/clients_modes/` | à faire |
| TRICPT-T03 | replay | Conditions clients | cocher `inact`, puis `divers`, `autoe` | conditions `cli_actif`/`cli_div`/`cli_autoent` de référence | `tests/conditions_clients/` | à faire |
| TRICPT-T04 | replay | Mode Tous | `LGed` (comptabilité) : `gest`, `bil`, `all`, `cli`, `fou`, `clifou` | listes successives ; largeur de fenêtre (captures) | `tests/mode_tous/` | à faire |
| TRICPT-T05 | replay | Condition après changement de mode (A03) | mode Tous → `cli` → cocher `inact` → `gest` | figer l'erreur SQL (colonne `cli_actif` inconnue) | `tests/condition_mode/` | à faire |
| TRICPT-T06 | replay | Lettrage | `Lettrage` client puis fournisseur | client : seuls les comptes `lettrable` ; fournisseur : tous (A04 figée) | `tests/lettrage/` | à faire |
| TRICPT-T07 | replay | Annulation après sélection (A01) | `Materiel` : sélection d'un client, puis réouverture et Échap | figer : l'ancien client est réappliqué | `tests/annulation/` | à faire |
| TRICPT-T08 | replay | Trésorerie avec solde | `Pointage` (`Tresorerie`, avec solde) | comptes `type_cc='B' and comptr_cc != 0`, colonne solde arrondie | `tests/tresorerie/` | à faire |
| TRICPT-T09 | replay | Clients et fournisseurs | `SaiReg` (`Client_Fournisseur`, avec solde) | `UNION`, colonne Type ; compte repris | `tests/clients_fournisseurs/` | à faire |
| TRICPT-T10 | gbtest | `ConditionComptes` (après TRICPT-005) | 8 types × appelant `Lettrage`/autre × 3 cases | texte identique au clone non modifié | `tests/condition_comptes/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 à A04 figées.
- **Rejeu** : `TriCpt` n'appelle **pas** `Utils.Observers(Me)` et la grille est créée par
  `TriGen` dans un `Panel` (non instrumentée) : en l'état, aucune action dans cette fenêtre n'est
  journalisée. Avant la phase 2, vérifier le comportement de `ReplayObserver` ; à défaut, ajouter
  `Utils.Observers(Me)` (après création de la liste) est un changement à valider, sinon piloter par
  script de clics. Cela conditionne les scénarios des 41 appelants qui choisissent un compte.
- **Géométrie** : largeur adaptée à `Screen.AvailableWidth` et taille de page de `TriGen` :
  fixer la résolution, la police et le facteur d'échelle.
- **Mutualisation** : T06 avec `Lettrage`, T07 avec `Materiel` (MATERIEL-T12), T08 avec
  `Pointage`, T09 avec `SaiReg`.
