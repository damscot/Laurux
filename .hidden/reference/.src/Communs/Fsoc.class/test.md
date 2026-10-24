# Fsoc — Tests

> Source : `.src/Communs/Fsoc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans API publique testable isolément : tous les tests sont des **replays** sur une
instance MariaDB Docker contenant plusieurs bases société. Le critère est le dump normalisé de
**toutes** les bases `Laurux*` du serveur (liste des bases comprise) et le `Laurux.conf` de test
après le scénario (clés `[General]` `Soc`/`intitule`, `[dbase]` `Name`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSOC-T01 | replay | Ouverture, liste des sociétés | bases `Laurux01` et `Laurux02` (dérivées de `Laurux01.sql`), `/Soc` = 01 | `Soclist` à 2 lignes, ligne 01 sélectionnée, champs remplis (log GUI) ; aucun changement BDD | `tests/ouverture_liste/` | à faire |
| FSOC-T02 | replay | Modification de la société courante | changer `Intitule`, `Adr1`, `Siret` puis Enregistrer (tag 4) | `Fiches_Societes` de `Laurux01` : 1 ligne aux nouvelles valeurs ; `/intitule` mis à jour | `tests/modification/` | à faire |
| FSOC-T03 | replay | Création d'une société | Nouveau (tag 2), code `03`, champs, Enregistrer, « Oui » à la création | base `Laurux03` créée depuis `Laurux01.sql`, `Fiches_Societes` = saisie ; `/Soc` = 03, `/dbase/Name` = `Laurux03` ; connexion restée sur `Laurux01` (figé) | `tests/creation/` | à faire |
| FSOC-T04 | replay | Suppression | sélection de `Laurux02`, Supprimer, « Oui » | base `Laurux02` absente ; message « Société  supprimée » (anomalie A01 figée) ; clés `Soc`, `/Societes/Soc` vides | `tests/suppression/` | à faire |
| FSOC-T05 | replay | Bouton « Créer » (tag 2, groupe `Btn`) | code `02` affiché, clic « Créer » | champs vidés (`cleanChamps`), focus sur `Code`, aucune écriture de configuration ni de base (`Button4_Click` n'est **pas** exécuté) | `tests/bouton_creer/` | à faire |
| FSOC-T06 | replay | Changement par clic dans la liste | clic sur la ligne 02 | `/Soc` = 02, `/dbase/Name` = `Laurux02`, collation de `Laurux02` = `utf8mb4_unicode_ci` ; redémarrage (`Start.Main`) observé dans le log | `tests/selection_liste/` | à faire |
| FSOC-T07 | replay | Calcul du n° TVA | `Siret` = `732 829 320 00074` + Entrée ; puis un SIREN de clé < 10 | `Tvaintra` = `FR44732829320` ; clé sur 1 chiffre pour le second (CTESTTVA-A01 figée) | `tests/tva_calcul/` | à faire |
| FSOC-T08 | replay | Contrôle du n° TVA (tag 12) | `Tvaintra` invalide + Entrée, puis valide + Entrée | invalide : avertissement puis focus `Capital` ; valide : focus inchangé (A04 figée) | `tests/tva_controle/` | à faire |
| FSOC-T09 | replay | Code société invalide | `Code` = `1` + Entrée | son + avertissement, focus reste sur `Code` | `tests/code_invalide/` | à faire |
| FSOC-T10 | replay | Navigation clavier | Entrée successives du tag 1 au tag 20 | ordre des focus de référence (log), y compris `Libre` (tag 3) → `Adr1` | `tests/navigation/` | à faire |
| FSOC-T11 | replay | Mode préfixe | `/Soc01/Prefixe` actif, bases `pre_Laurux01`, `pre_Laurux02` | `Soclist` liste les bases préfixées ; `Init_base` sans filtre `cd_sc` | `tests/prefixe/` | à faire |
| FSOC-T12 | replay | Duplication (tag 6) | `/Soc01/Admin` faux, `Dup` vers `Laurux04` | base `Laurux04` créée, `Refresh` relit la liste (scénario partagé avec les tests de `Dup`) | `tests/duplication/` | à faire |
| FSOC-T13 | replay | Ouverture via `Prgm` | `./Laurux` avec la commande `Prgm` « Fsoc » | figer l'erreur actuelle (A06, à confirmer) | `tests/prgm_fsoc/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est capturé dans le clone **Laurux non
  modifié** (`./Laurux -l --logfile …` avec un `Laurux.conf` de test, option `-c`), puis rejoué sur
  les deux clones. Dumps normalisés de toutes les bases `Laurux*` + copie du `Laurux.conf` final.
- **Données** : `Laurux01.sql` importé dans `Laurux01`, et une copie modifiée (`cd_sc = 02`) dans
  `Laurux02` ; T11 utilise les mêmes bases renommées avec un préfixe.
- **Prérequis Docker** : `Host = 127.0.0.1` (et non `localhost`, qui force le socket Unix pour le
  client `mysql`) et port **3306** : le `Shell mysql` de `Soclist_Click`
  ignorent `/dbase/Port`. L'utilisateur de test doit avoir les droits `CREATE`/`DROP DATABASE` ; le
  `SET @@global.sql_mode` demande `SUPER` (son échec est silencieux, sans effet sur le dump).
- **Fin d'application** (T06, T13) : le runner doit accepter l'arrêt de Laurux comme fin
  normale du scénario.
- **Non testable automatiquement** : sons (`Music.Play`), aide HTML (`Doc.Open`), aspect des
  couleurs de focus.
