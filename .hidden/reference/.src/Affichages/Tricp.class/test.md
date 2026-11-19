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
| TRICP-T01 | replay | Sélection depuis la fiche client | `FClient` : saisie `750` dans le CP, ouverture (`Cpman`), clic sur une ligne, enregistrement | CP et bureau repris ; `Fiches_Cli` enregistrée | `tests/client/` | à faire : passe par FClient (revue manuelle) |
| TRICP-T02 | replay | Sélection depuis une facture | `Facture` : CP `44`, choix dans la liste | CP et bureau repris par `Variables` | `tests/facture/` | à faire : passe par Facture (revue manuelle) ; la reprise par `Variables` (origine « Facture ») est vérifiée sans l'écran par `TricpTest.T06Pagination` |
| TRICP-T03 | replay | Fiche fournisseur (menu) et F11 depuis Facture | `FFournisseur` par le menu, puis par F11 dans `Facture` | menu : repris ; F11 : figer la perte (FFOURNISSEUR-A07) | `tests/fournisseur/` | à faire : passe par FFournisseur et Facture (revue manuelle) |
| TRICP-T04 | replay | Carte de fidélité | `FClientcarte` : `Cpman` puis `ToggleButton5` | figer : rien de repris par `Cpman` ; erreur « Unknown symbol » par `ToggleButton5` (A01) | `tests/clientcarte/` | implémenté (gb.test `TricpTest.T04Clientcarte` : origine « Clientcarte », A01 figée ; `TricpTest.T04bFicheCarte` : depuis FClientcarte, `Cpman` puis `ToggleButton5` en ShowModal, 1re ligne choisie par un Timer : rien de repris, erreur « 'FClientcarte.Bsel' is not a property ») |
| TRICP-T05 | replay | Filtre, tri, double-clic | saisie dans `CO` puis `INTIT`, Retour arrière, double-clic sur un en-tête, PageDown | requêtes de référence ; figer l'ordre incohérent après double-clic (A03) | `tests/filtre_tri/` | implémenté (gb.test `TricpTest.T05FiltreTri` : clic Intitulé, double-clics, page suivante, retour au code ; A03 figée : la page suivante après le 2e double-clic repasse en ordre croissant) ; la saisie dans `CO`/`INTIT` (Key.Text) reste à faire : Key.Code |
| TRICP-T06 | replay | Pagination | PageDown ×2, PageUp, molette, boutons, flèche bas en dernière ligne | `LIMIT` successifs ; retour à 0 | `tests/pagination/` | implémenté (gb.test `TricpTest.T06Pagination` : Descendre/Remonter, dernière page, retour sous 0, sélection reprise) ; molette (Mouse.Delta) et flèches (Key.Code) : à faire, Key.Code |
| TRICP-T07 | replay | Annulation après sélection (A02) | `Facture` : sélection d'un CP, puis réouverture et Échap | figer : l'ancien CP est réappliqué | `tests/annulation/` | à faire : passe par Facture (revue manuelle) |
| TRICP-T08 | gbtest | `RequeteCp` (après TRICP-005) | tri `cp`/`burdist`, filtre vide/`75`, sens, pages 0 et 2 | texte SQL identique au clone non modifié | `tests/requete_cp/` | à faire : extraction TRICP-005 (`RequeteCp`) |

## Détail des tests

- **Implémentation (phase 2, vague 9)** : module `.src/Tests/Affichages/TricpTest.test`, jeu `.hidden/Tests/Affichages/assets/TricpTest/cpostaux_pages.sql` (120 codes 44xxx, 30 codes 75xxx ; 17 lignes par page sans affichage).

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 à A05 figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` (écran rejouable) ; `colco_Click` est rejoué
  par `Object.Call` (doit rester `Public`). Pas de `replay_missing`.
- **Pagination** : `lg` dépend de la hauteur de la grille : fixer police et facteur d'échelle.
- **Mutualisation** : T01 avec `FClient`, T02/T07 avec `Facture` (Décision utilisateur du 2026-11-18 : Facture fait partie des 10
  classes à revue manuelle ; ce qui ne s'atteint que par elle reste à faire), T03 avec `FFournisseur`, T04 avec `FClientcarte` (FCLIENTCARTE-T07).
- **Non testable automatiquement** : l'aide F1 (`Doc.Open`) ouvre une application externe.
