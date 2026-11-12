# Fsoc — Tests

> Source : `.src/Communs/Fsoc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans API publique testable isolément : tous les tests sont des **replays** sur une
instance MariaDB Docker contenant plusieurs bases société. Le critère est le dump normalisé de
**toutes** les bases `Laurux*` du serveur (liste des bases comprise) et le `Laurux.conf` de test
après le scénario (clés `[General]` `Soc`/`intitule`, `[dbase]` `Name`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSOC-T01 | replay | Ouverture, liste des sociétés | bases `Laurux01` et `Laurux02` (dérivées de `Laurux01.sql`), `/Soc` = 01 | `Soclist` à 2 lignes, ligne 01 sélectionnée, champs remplis (log GUI) ; aucun changement BDD | `tests/ouverture_liste/` | implémenté |
| FSOC-T02 | replay | Modification de la société courante | changer `Intitule`, `Adr1`, `Siret` puis Enregistrer (tag 4) | `Fiches_Societes` de `Laurux01` : 1 ligne aux nouvelles valeurs ; `/intitule` mis à jour | `tests/modification/` | implémenté |
| FSOC-T03 | replay | Création d'une société | Nouveau (tag 2), code `03`, champs, Enregistrer, « Oui » à la création | base `Laurux03` créée depuis `Laurux01.sql`, `Fiches_Societes` = saisie ; `/Soc` = 03, `/dbase/Name` = `Laurux03` ; connexion restée sur `Laurux01` (figé) | `tests/creation/` | implémenté (fsoc_creation : base Laurux03 dumpée par « bases », @Laurux.conf comparé ; comportement figé DB_CONNECTION-A12 : Message.Error au lieu de Message.Info, cd_sc et saisie non écrits dans Laurux03, /dbase/Name non changé) |
| FSOC-T04 | replay | Suppression | sélection de `Laurux02`, Supprimer, « Oui » | base `Laurux02` absente ; message « Société  supprimée » (anomalie A01 figée) ; clés `Soc`, `/Societes/Soc` vides | `tests/suppression/` | implémenté |
| FSOC-T05 | replay | Bouton « Créer » (tag 2, groupe `Btn`) | code `02` affiché, clic « Créer » | champs vidés (`cleanChamps`), focus sur `Code`, aucune écriture de configuration ni de base (`Button4_Click` n'est **pas** exécuté) | `tests/bouton_creer/` | implémenté |
| FSOC-T06 | replay | Changement par clic dans la liste | clic sur la ligne 02 | `/Soc` = 02, `/dbase/Name` = `Laurux02`, collation de `Laurux02` = `utf8mb4_unicode_ci` ; redémarrage (`Start.Main`) observé dans le log | `tests/selection_liste/` | xfail : erreur fatale au SET NAMES après réouverture (journal fermé par Utils.db.Close, mode -l) |
| FSOC-T07 | replay | Calcul du n° TVA | `Siret` = `732 829 320 00074` + Entrée ; puis un SIREN de clé < 10 | `Tvaintra` = `FR44732829320` ; clé sur 1 chiffre pour le second (CTESTTVA-A01 figée) | `tests/tva_calcul/` | implémenté |
| FSOC-T08 | replay | Contrôle du n° TVA (tag 12) | `Tvaintra` invalide + Entrée, puis valide + Entrée | invalide : avertissement puis focus `Capital` ; valide : focus inchangé (A04 figée) | `tests/tva_controle/` | implémenté |
| FSOC-T09 | replay | Code société invalide | `Code` = `1` + Entrée | son + avertissement, focus reste sur `Code` | `tests/code_invalide/` | implémenté |
| FSOC-T10 | replay | Navigation clavier | Entrée successives du tag 1 au tag 20 | ordre des focus de référence (log), y compris `Libre` (tag 3) → `Adr1` | `tests/navigation/` | implémenté |
| FSOC-T11 | replay | Mode préfixe | `/Soc01/Prefixe` actif, bases `pre_Laurux01`, `pre_Laurux02` | `Soclist` liste les bases préfixées ; `Init_base` sans filtre `cd_sc` | `tests/prefixe/` | implémenté (fsoc_prefixe : conf /Soc01/Prefixe, jeu fsoc_prefixe ; requêtes sans filtre cd_sc sur pre_Laurux01/02 dans sql.log ; liste affichée non comparée) |
| FSOC-T12 | replay | Duplication (tag 6) | `/Soc01/Admin` faux, `Dup` vers `Laurux04` | base `Laurux04` créée, `Refresh` relit la liste (scénario partagé avec les tests de `Dup`) | `tests/duplication/` | implémenté (variante : cible Laurux02 existante, dumpée par « bases » ; création de Laurux04 non couverte : Createbase, DB_CONNECTION-A12) |
| FSOC-T13 | replay | Ouverture via `Prgm` | `./Laurux` avec la commande `Prgm` « Fsoc » | figer l'erreur actuelle (A06, à confirmer) | `tests/prgm_fsoc/` | implémenté (erreur fatale A06 figée, code 125) |

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

### Implémentation (phase 2, 2026-11-11)

- Scénarios `.hidden/Tests/Communs/assets/fsoc_<nom>/` : `fsoc_ouverture_liste` (T01), `fsoc_modification` (T02),
  `fsoc_creation` (T03), `fsoc_suppression` (T04), `fsoc_bouton_creer` (T05), `fsoc_selection_liste` (T06,
  xfail, code 125), `fsoc_tva_calcul` (T07), `fsoc_tva_controle` (T08), `fsoc_code_invalide` (T09),
  `fsoc_navigation` (T10), `fsoc_duplication` (T12), `fsoc_prgm` (T13, code 125).
- Jeu de données `.hidden/Tests/Communs/assets/fsoc_shared/fsoc_deux_bases.sql` : copie complète de Laurux01 dans Laurux02 (`cd_sc` = 02), et
  suppression des bases `Laurux02`…`Laurux09`, `pre_Laurux01/02` laissées par d'autres scénarios (`Init_base`
  énumère toutes les bases du serveur : sql.log en dépend). Le runner ne dumpe que Laurux01 et ne compare pas
  `Laurux.conf` : les effets sur les autres bases sont vérifiés par sql.log.
- Le Focus d'un rejeu ne sélectionne pas le texte : les valeurs existantes sont effacées par BackSpace ; les
  Entrée (Soc_KeyPress) sélectionnent le champ suivant. T10 vérifie l'ordre des focus par une lettre distincte
  saisie dans chaque champ puis enregistrée (dump) ; Entrée sur Tvaintra vide ne déplace pas le focus (A04).
- T03 : après `LauruxConf.Createbase` (Utils.db.Close), le journal SQL est fermé : les requêtes suivantes
  n'apparaissent plus dans sql.log ; le scénario supprime Laurux03 à la fin et omet le Quitter final (erreur
  fatale du journal fermé). T12 : variante vers Laurux02 existante (la création de Laurux04 passerait par
  Createbase). T13 : `Fsoc.ShowModal()` sur l'instance automatique → « Not enough arguments » (A06 confirmée).

### Implémentation (vague 2 bis, 2026-11-12 : clés conf / bases / fichiers de meta.json)

- FSOC-T03 (`fsoc_creation`) : `"bases": ["Laurux03"]`, `"fichiers": ["@Laurux.conf"]` ; le nettoyage de fin de
  scénario (suppression de Laurux03, couverte par T04) est retiré, le framework supprimant les bases parasites avant
  chaque test. Constat : la seconde boîte n'est pas le Message.Info de `Createbase` mais le Message.Error du `Catch`
  de `Fsoc.Button1_Click` : après `Utils.db.Close`, la requête suivante écrit dans le journal fermé
  (DB_CONNECTION-A12) ; Laurux03 contient donc la copie brute de Laurux01.sql (`Fiches_Societes` : ligne `01`,
  ni UPdate cd_sc ni saisie) ; configuration : `/Soc` = 03, `[Soc03]`, `[Coul]` réécrite (valeurs à virgules de
  `Createbase`), `/dbase/Name` resté `Laurux01`, `/Societes/Soc03` perdu par `Reload` (comportement figé).
  sql.log et dump de Laurux01 inchangés.
- FSOC-T11 (`fsoc_prefixe`) : `"conf": {"/Soc01/Prefixe": "1"}`, jeu `.hidden/Tests/Communs/assets/fsoc_prefixe/fsoc_prefixe.sql` (bases
  `pre_Laurux01`/`pre_Laurux02` avec une table `Fiches_Societes` d'une ligne). sql.log : `Select * From
  pre_Laurux0x.Fiches_Societes` sans filtre, Laurux01 exclue.
- FSOC-T12 (`fsoc_duplication`) : `"bases": ["Laurux02"]` (copie de Laurux01 : `Fiches_Societes` = ligne 02
  « Laurux » au lieu de « SECONDE SOCIETE »). sql.log et dump de Laurux01 inchangés.
- Jeu `fsoc_deux_bases` simplifié : `DROP DATABASE` des bases parasites retirés (nettoyage fait par le framework) ;
  tous ses scénarios (fsoc_*, lauruxconf_*, start_cli_replay, start_cli_societe, start_redemarrage) et
  LauruxConfTest restent identiques.
