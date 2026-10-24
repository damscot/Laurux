# DocActif — Tests

> Source : `.src/Communs/DocActif.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Service de verrous appelé par 9 fichiers : les fonctions `Public` sont testables en `gbtest`
tant qu'aucun dialogue n'est affiché (verrou libre, verrou du processus courant, `msg = False`).
Les chemins avec dialogue sont couverts par des `replay` (le harnais répond aux boîtes). Résultat
comparé : valeur renvoyée et dump de `Fiches_Docactif` (colonnes volatiles `process_id`,
`machine_id`, `host_id` remplacées par des marqueurs « courant » / « autre »). Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DOCACTIF-T01 | gbtest | `Get_Lock` sur document libre | table vide ; `Get_Lock("Test", "1")` | `True` ; une ligne avec l'identité courante | `tests/get_libre/` | à faire |
| DOCACTIF-T02 | gbtest | `Is_Lock` sans message | ligne de T01 ; `Is_Lock("Test", "1", False)`, `Is_Lock("Test", "2", False)` | `True`, `False` | `tests/is_lock/` | à faire |
| DOCACTIF-T03 | gbtest | `Free_Lock` de son propre verrou | ligne de T01 ; `Free_Lock("Test", "1")` | ligne supprimée ; valeur renvoyée `False` (A01 figée) | `tests/free_propre/` | à faire |
| DOCACTIF-T04 | replay | `Get_Lock` déjà pris par le processus courant | ligne avec le PID courant | `Message.Info` ; `True` ; table inchangée | `tests/get_meme_process/` | à faire |
| DOCACTIF-T05 | replay | `Get_Lock` d'un processus mort du même poste | ligne avec un PID inexistant ; réponses « Supprimer » puis « Annuler » | `True` et `process_id` repris / `False` et table inchangée | `tests/get_process_mort/` | à faire |
| DOCACTIF-T06 | replay | `Get_Lock` d'un processus vivant du même poste | ligne avec le PID d'un processus factice vivant (`sleep`) | avertissement ; `False` | `tests/get_process_vivant/` | à faire |
| DOCACTIF-T07 | replay | `Get_Lock` d'un autre poste | ligne avec un autre `machine_id` | avertissement ; `False` | `tests/get_autre_poste/` | à faire |
| DOCACTIF-T08 | replay | `Free_Lock` d'un verrou étranger | ligne d'un autre poste ; « Forcer Libérer » puis « Annuler » | ligne supprimée / conservée ; `False` dans les deux cas | `tests/free_etranger/` | à faire |
| DOCACTIF-T09 | replay | `Free_Lock` d'un verrou absent | table vide | avertissement « Lock inexistant » | `tests/free_absent/` | à faire |
| DOCACTIF-T10 | replay | Fenêtre d'administration | 3 verrous ; Menu328 ; clic sur une ligne, « OK » | liste affichée (7 colonnes) ; ligne supprimée | `tests/administration/` | à faire |
| DOCACTIF-T11 | replay | Intégration `Parametre` | ouverture puis fermeture de Paramètres | verrou `Parametres/0` présent pendant l'ouverture, absent après | `tests/integration_parametre/` | à faire |
| DOCACTIF-T12 | gbtest | Statut pur (après DOCACTIF-004) | lignes simulées pour les 5 cas | code de statut attendu | `tests/statut/` | à faire |

## Détail des tests

- **Données** : base de test MariaDB ; `Fiches_Docactif` vidée puis remplie par script SQL pour
  chaque cas (identité « autre » : valeurs fixes ; identité « courante » : lue par le test via les
  mêmes commandes que `_new`).
- **Processus vivant/mort** : T05 utilise un PID libre (vérifié par `ps`) ; T06 lance `sleep 600`
  et enregistre son PID.
- **Verrou de table** : un test complémentaire (manuel ou script Python avec une seconde
  connexion) vérifie que `LOCK TABLES` est bien relâché après chaque appel (requête bloquante
  avec délai). Le chemin `Count > 1` de `Free_Lock` (A02) est inatteignable avec la clé primaire.
- **SQLite** : rejouer T01 à T03 sur `Laurux01.sqlite` (pas de `LOCK TABLES`).
- **Contrainte gb.test** : `DocActif` est une `Form` ; l'appel statique instancie la fenêtre (sans
  l'afficher). Les tests `gbtest` demandent donc un affichage virtuel (Xvfb), à confirmer en
  phase 2.
