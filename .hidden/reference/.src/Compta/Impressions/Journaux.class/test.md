# Journaux — Tests

> Source : `.src/Compta/Impressions/Journaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tous les tests sont des **replays** de l'écran « Impression des journaux ». Les tests
d'impression proprement dits sont décrits dans [JournauxM](../JournauxM.module/test.md) ; ceux-ci
couvrent la saisie, les contrôles et l'export texte.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| JOURNAUX-T01 | replay | Ouverture | jeu dérivé commun (Balance), date système figée | `dteN0` = 1er jour après `dteclec`, `dteN1` = aujourd'hui (ou exercice précédent si aujourd'hui précède) ; `Cpt` = 01, `Cpt2` = 99 | `tests/ouverture/` | implémenté |
| JOURNAUX-T02 | replay | Choix d'exercice | clic `E1`, `N1` … `N5`, `E0` | dates affichées de référence ; `Exo5` = `dteclec5` − 1 an + 1 mois | `tests/choix_exercice/` | implémenté |
| JOURNAUX-T03 | replay | Contrôle des dates | `dteN0` avant le début ; `dteN1` après la fin ; `dteN1` < `dteN0` ; saisie `00` | avertissements, retour sur l'exercice précédent avec `E0` coché (comportement figé) | `tests/controle_dates/` | implémenté |
| JOURNAUX-T04 | replay | Listes de journaux | F2 sur `Cpt` puis Entrée ; F2 sur `Cpt2` puis Échap ; clic | `Cpt`/`Cpt2` renseignés, focus attendu | `tests/liste_journaux/` | à faire : touches F2 et Échap non rejouées |
| JOURNAUX-T05 | replay | Impression, tri par numéro | `RadioButton2` coché | PDF identique au tri par date (A01 figée) | `tests/tri_numero/` | à faire : tri visible seulement dans le PDF (sortie PDF non comparée) |
| JOURNAUX-T06 | replay | Export texte | configuration 12 colonnes, journaux 01-99, période complète | `~/tmp/journaux.txt` identique octet par octet ; dump (`centralisation` recréée vide, A04) | `tests/export_txt/` | implémenté |
| JOURNAUX-T07 | replay | Export sans configuration | aucune clé `/ExportJournal<soc>` | message « Veuillez renseigner l'ordre des colonnes » ; aucun fichier | `tests/export_sans_config/` | implémenté |
| JOURNAUX-T08 | replay | Exports successifs | export, changement de configuration (6 colonnes), second export | solde cumulé d'un export à l'autre (A02) et colonnes résiduelles (A03) figés | `tests/export_successifs/` | implémenté |
| JOURNAUX-T09 | replay | Export : période partielle et collectifs | période d'un mois, collectifs 411 | lignes hors période et collectives absentes | `tests/export_periode/` | implémenté |
| JOURNAUX-T10 | replay | Quitter | bouton Quitter après impression | écran fermé ; `~/tmp/Journaux.pdf` conservé (A05 figée) | `tests/quitter/` | à faire : seul effet = ~/tmp/Journaux.pdf conservé (sortie PDF non comparée) |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié**, base
  Docker importée du jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md)) (voir JOURNAUXM, `Laurux01.sql` n'a
  aucune écriture), `Laurux.conf` de test (`-c`) contenant ou non les clés `/ExportJournal01/…`.
- **Date système** : `Ex1` dépend de `Now` ; figer la date (`faketime`) ou ne comparer que les
  dates issues de `dteclec*`.
- **Export** : le fichier ne contient ni date d'édition ni utilisateur ; comparaison octet par
  octet. Montants via `Utils.cpoint` (point décimal), indépendants de la locale.
- **Non testable automatiquement** : aide `Doc.Open`, ouverture de l'éditeur
  (`Editeur.Prog_Editeur`, répondre « Non »), sons.
- **Scénarios (vague 3)** : `.hidden/Tests/Compta/assets/journaux_<nom>/` — `ouverture` (T01), `choix_exercice` (T02,
  N-1 seulement), `controle_dates` (T03, Du avant le début seulement), `export_txt` (T06), `export_sans_config` (T07),
  `export_successifs` (T08, A02 seulement : le changement de configuration de A03 passe par journauxSetting, glisser-déposer
  non rejoué), `export_periode` (T09). Jeux : `extrait_shared/extrait_base` (T01-T07),
  `jourcent_collectifs/jourcent_collectifs` (T09), `jourcent_collectif_453/jourcent_collectif_453` (T08, lignes exportées
  déséquilibrées). Configuration 12 colonnes par la clé `conf` de meta.json (`/ExportJournal01/Entete<i>`, `Titre<i>`).
  Les dates affichées ne sont observées qu'au travers de l'export `~/tmp/journaux.txt` (comparé par `fichiers`).
  La question finale « Voulez-vous l'ouvrir ? » reçoit « Non » (Tab + Espace).
