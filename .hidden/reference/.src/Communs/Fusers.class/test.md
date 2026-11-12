# Fusers — Tests

> Source : `.src/Communs/Fusers.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de saisie simple : tests `replay` avec comparaison du **dump de `Fiches_Users`** (trié par
`nom`, `lind` conservé) et du contenu affiché de `Coluser`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FUSERS-T01 | replay | Affichage de la liste | `Fiches_Users` avec 3 lignes ; Menu50 | 3 lignes (nom, poste) dans `Coluser` | `tests/liste/` | implémenté |
| FUSERS-T02 | replay | Création | nom « martin », poste « caisse1 » ; **Enregistrer** | ligne ajoutée | `tests/creation/` | implémenté |
| FUSERS-T03 | replay | Modification du poste | clic sur « martin », poste « bureau » ; **Enregistrer** | `poste` mis à jour, pas de nouvelle ligne | `tests/modif_poste/` | implémenté |
| FUSERS-T04 | replay | Tentative de renommage | clic sur « martin », nom « durand » ; **Enregistrer** | nouvelle ligne « durand », « martin » conservé (comportement actuel, A02) | `tests/renommage/` | implémenté |
| FUSERS-T05 | replay | Suppression | clic sur une ligne, **Supprimer**, **Oui** puis **Non** | ligne supprimée / conservée | `tests/suppression/` | implémenté |
| FUSERS-T06 | replay | Suppression avec nom saisi différent de la sélection | sélection « martin », saisie « durand », **Supprimer** | « martin » supprimé (A03 figée) | `tests/suppression_selection/` | implémenté |
| FUSERS-T07 | replay | Nom avec apostrophe | nom « d'Alès » ; **Enregistrer** | erreur SQL affichée par `DB_Connection.Exec` (A01 figée), table inchangée | `tests/apostrophe/` | implémenté |
| FUSERS-T08 | replay | Champs vides | **Enregistrer** et **Supprimer** sans nom | aucune requête, focus sur `Utilisateur` | `tests/champs_vides/` | implémenté |

## Détail des tests

- **Données** : `Laurux01.sql` (table `Fiches_Users`) dans MariaDB Docker, complété par un script
  d'insertion des 3 utilisateurs de départ.
- **Doublons de nom** : un jeu avec deux lignes de même nom est à essayer pour figer le
  comportement du `ColumnView` (clé dupliquée) ; s'il provoque une erreur bloquante, le cas est
  documenté et exclu.
- **Non testable automatiquement** : son (`Music.Play`).

## Implémentation (phase 2)

- Scénarios : `.hidden/Tests/Communs/assets/fusers_<répertoire>/` (`fusers_liste`, `fusers_creation`,
  `fusers_modif_poste`, `fusers_renommage`, `fusers_suppression`, `fusers_suppression_selection`,
  `fusers_apostrophe`, `fusers_champs_vides`), ouverture par `Menu50` (Paramètres › Fichiers › Utilisateurs).
- Jeu de données : `.hidden/Tests/Communs/assets/fusers_shared/fusers_base.sql` (dupont/bureau1, martin/caisse1,
  leroy/atelier) ; T02 part de `Laurux01.sql` (table vide).
- Le `Focus` rejoué ne sélectionne pas le texte de `Utilisateur`/`Poste` : les champs remplis par
  `MajZones` sont effacés par des BackSpace avant la saisie.
- T07 : « d'Ales » (sans accent, non rejouable) ; l'erreur SQL du `SELECT` concaténé est une erreur
  fatale (`DB_Connection.Exec.438`, backtrace désactivée) : `code_sortie` 125 figé.
- T01 : la liste affichée n'est pas comparée ; le clic sur les 3 clés de `Coluser` échouerait (code 3)
  si une ligne manquait.
