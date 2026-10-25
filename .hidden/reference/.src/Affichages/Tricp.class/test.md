# Tricp — Tests

> Source : `.src/Affichages/Tricp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de sélection : scénarios `replay` capturés dans le clone **Laurux non modifié** depuis
les quatre appelants. Base `Laurux01.sql` (table `Fiches_Cpostaux` complète ou jeu dérivé
`cpostaux` d'au moins 3 pages pour un même préfixe). Comparaison : code postal et bureau repris
par l'appelant, dump normalisé quand la fiche est enregistrée (`Fiches_Cli`, `Fiches_Four`,
`Fiches_Carte`), lignes `Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRICP-T01 | replay | Sélection depuis la fiche client | `FClient` : saisie `750` dans le CP, ouverture (`Cpman`), clic sur une ligne, enregistrement | CP et bureau repris ; `Fiches_Cli` enregistrée | `tests/client/` | à faire |
| TRICP-T02 | replay | Sélection depuis une facture | `Facture` : CP `44`, choix dans la liste | CP et bureau repris par `Variables` | `tests/facture/` | à faire |
| TRICP-T03 | replay | Fiche fournisseur (menu) et F11 depuis Facture | `FFournisseur` par le menu, puis par F11 dans `Facture` | menu : repris ; F11 : figer la perte (FFOURNISSEUR-A07) | `tests/fournisseur/` | à faire |
| TRICP-T04 | replay | Carte de fidélité | `FClientcarte` : `Cpman` puis `ToggleButton5` | figer : rien de repris par `Cpman` ; erreur « Unknown symbol » par `ToggleButton5` (A01) | `tests/clientcarte/` | à faire |
| TRICP-T05 | replay | Filtre, tri, double-clic | saisie dans `CO` puis `INTIT`, Retour arrière, double-clic sur un en-tête, PageDown | requêtes de référence ; figer l'ordre incohérent après double-clic (A03) | `tests/filtre_tri/` | à faire |
| TRICP-T06 | replay | Pagination | PageDown ×2, PageUp, molette, boutons, flèche bas en dernière ligne | `LIMIT` successifs ; retour à 0 | `tests/pagination/` | à faire |
| TRICP-T07 | replay | Annulation après sélection (A02) | `Facture` : sélection d'un CP, puis réouverture et Échap | figer : l'ancien CP est réappliqué | `tests/annulation/` | à faire |
| TRICP-T08 | gbtest | `RequeteCp` (après TRICP-005) | tri `cp`/`burdist`, filtre vide/`75`, sens, pages 0 et 2 | texte SQL identique au clone non modifié | `tests/requete_cp/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 à A05 figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` (écran rejouable) ; `colco_Click` est rejoué
  par `Object.Call` (doit rester `Public`). Pas de `replay_missing`.
- **Pagination** : `lg` dépend de la hauteur de la grille : fixer police et facteur d'échelle.
- **Mutualisation** : T01 avec `FClient`, T02/T07 avec `Facture` (module complexe : scénarios à
  valider avec l'utilisateur), T03 avec `FFournisseur`, T04 avec `FClientcarte` (FCLIENTCARTE-T07).
- **Non testable automatiquement** : l'aide F1 (`Doc.Open`) ouvre une application externe.
