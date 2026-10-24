# Fusers — Tests

> Source : `.src/Communs/Fusers.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de saisie simple : tests `replay` avec comparaison du **dump de `Fiches_Users`** (trié par
`nom`, `lind` conservé) et du contenu affiché de `Coluser`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FUSERS-T01 | replay | Affichage de la liste | `Fiches_Users` avec 3 lignes ; Menu50 | 3 lignes (nom, poste) dans `Coluser` | `tests/liste/` | à faire |
| FUSERS-T02 | replay | Création | nom « martin », poste « caisse1 » ; **Enregistrer** | ligne ajoutée | `tests/creation/` | à faire |
| FUSERS-T03 | replay | Modification du poste | clic sur « martin », poste « bureau » ; **Enregistrer** | `poste` mis à jour, pas de nouvelle ligne | `tests/modif_poste/` | à faire |
| FUSERS-T04 | replay | Tentative de renommage | clic sur « martin », nom « durand » ; **Enregistrer** | nouvelle ligne « durand », « martin » conservé (comportement actuel, A02) | `tests/renommage/` | à faire |
| FUSERS-T05 | replay | Suppression | clic sur une ligne, **Supprimer**, **Oui** puis **Non** | ligne supprimée / conservée | `tests/suppression/` | à faire |
| FUSERS-T06 | replay | Suppression avec nom saisi différent de la sélection | sélection « martin », saisie « durand », **Supprimer** | « martin » supprimé (A03 figée) | `tests/suppression_selection/` | à faire |
| FUSERS-T07 | replay | Nom avec apostrophe | nom « d'Alès » ; **Enregistrer** | erreur SQL affichée par `DB_Connection.Exec` (A01 figée), table inchangée | `tests/apostrophe/` | à faire |
| FUSERS-T08 | replay | Champs vides | **Enregistrer** et **Supprimer** sans nom | aucune requête, focus sur `Utilisateur` | `tests/champs_vides/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (table `Fiches_Users`) dans MariaDB Docker, complété par un script
  d'insertion des 3 utilisateurs de départ.
- **Doublons de nom** : un jeu avec deux lignes de même nom est à essayer pour figer le
  comportement du `ColumnView` (clé dupliquée) ; s'il provoque une erreur bloquante, le cas est
  documenté et exclu.
- **Non testable automatiquement** : son (`Music.Play`).
