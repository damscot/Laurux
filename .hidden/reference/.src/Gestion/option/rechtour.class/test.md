# rechtour — Tests

> Source : `.src/Gestion/option/rechtour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de recherche modale, sans écriture en base. Elle n'appelle pas `Utils.Observers(Me)` :
ses actions ne sont pas journalisées et **ne peuvent pas être rejouées** en l'état. Les tests
passent donc par l'écran appelant (fiche client), où seul l'effet final (valeur de la tournée
enregistrée dans `Fiches_Cli`) est observable dans le dump. Valeurs attendues produites dans le
clone Laurux non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECHTOUR-T01 | replay | Choix d'une tournée depuis la fiche client | jeu `tournees_base` (3 tournées insérées dans un ordre non trié) ; FClient → bouton tournée → double-clic sur la 2e ligne → enregistrer | `Fiches_Cli` : tournée du client = code choisi ; ligne `Exec_SQL` `SELECT * FROM Fiches_tourne` | `tests/choix_tournee_client/` | à faire |
| RECHTOUR-T02 | replay | Effacement par Suppr | même écran, touche Suppr dans la grille → enregistrer | tournée du client = valeur produite par `butto1_trouve(" ")` (à figer) | `tests/effacement_tournee/` | à faire |
| RECHTOUR-T03 | replay | Ordre d'affichage (caractérisation de A01) | jeu `tournees_base` | ordre des lignes = ordre physique de la table (capture d'écran ou log) | `tests/ordre_liste/` | à faire |
| RECHTOUR-T04 | replay | Table vide | `Laurux01.sql` (aucune tournée) ; ouverture puis Échap | aucune erreur, aucun événement | `tests/table_vide/` | à faire |

## Détail des tests

- **Jeu `tournees_base`** : `Laurux01.sql` + 3 lignes `Fiches_tourne` insérées dans l'ordre
  `T3`, `T1`, `T2` ; partagé avec [Ttourne](../Ttourne.class/test.md).
- **Rejouabilité** : à vérifier en début de phase 2. Si le replay ne peut pas piloter la fenêtre
  (pas d'observateur), deux options : appeler `Utils.Observers(Me)` dans `_new` (modification à
  faire dans **les deux** clones avant capture, à valider) ou classer T01-T03 en tests manuels.
- **`replay_missing`** : `GridView1` sans `GridView1_Click` ; un clic simple rejoué par
  `Object.Call` échouerait. Les scénarios utilisent l'activation (double-clic/Entrée), qui lève
  `GridView1_Activate`.
- T03 sert de test de caractérisation pour RECHTOUR-A01 : il devra être mis à jour si l'anomalie
  est corrigée.
