# ImpJdv — Tests

> Source : `.src/Compta/Utils/ImpJdv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre d'import : tests **replay** (menu Comptabilité > Outils > Import du JDV Laurux, `/Exp`
faux). Chaque test fournit des fichiers d'entrée de référence (`tests/<nom>/data/clients.txt`,
`ecritures<JJ>.csv`) et compare après import le **dump normalisé** de `Fiches_Cli`,
`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres` (`dnc`, `numecriture`, `dnfac`) et `Nvcompte`,
ainsi que les fichiers produits `rejets.txt` et `Nvcomptes.txt`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPJDV-T01 | replay | Import nominal, clients existants | `clients.txt` (31 champs, clients déjà en base), `ecritures70.csv` : 3 factures (411 + 707 + 44571) | `Maj_Client` appliquée, écritures et lignes collectif, soldes, `numecriture` ; `dnfac` remis à vide (A01 figée) | `tests/import_nominal/` | à faire |
| IMPJDV-T02 | replay | Création de clients (caractérisation A02/A04) | 2 clients absents de la base | état figé : erreur `Level2` ou fiches créées avec champs décalés (`cli_dmln`, `cli_obs`…) | `tests/creation_clients/` | à faire |
| IMPJDV-T03 | replay | Comptes manquants | écriture sur un compte 6xx/7xx absent de `Fiches_Comptes` | `Nvcompte` et `Nvcomptes.txt` remplis, aucune écriture importée | `tests/comptes_manquants/` | à faire |
| IMPJDV-T04 | replay | Ré-import du même fichier (A06/A07) | T01 rejoué deux fois | `rejets.txt` (lignes 411), message « 0 écriture(s) rejetée(s) », aucune ligne en double | `tests/reimport/` | à faire |
| IMPJDV-T05 | replay | Option « Clôturer les écritures » | T01 avec la case cochée | `cloturee = 1` sur toutes les lignes importées | `tests/cloture/` | à faire |
| IMPJDV-T06 | replay | Aller-retour avec ExportJdv (caractérisation A05) | fichiers produits par EXPORTJDV-T01 (en-tête société en 1re ligne) | comportement figé (erreur d'indice attendue, à confirmer) | `tests/aller_retour_export/` | à faire |
| IMPJDV-T07 | replay | Fichiers absents | répertoire vide | message « Le fichier client ou écritures n'existe pas » ; dump `Laurux_dump.sql<date>` tout de même produit | `tests/fichiers_absents/` | à faire |
| IMPJDV-T08 | replay | Réponse « Non » à la confirmation | fichiers valides | base inchangée ; fichiers `~/tmp/Edclients.pdf` (vide) et dump présents | `tests/confirmation_non/` | à faire |
| IMPJDV-T09 | replay | Intitulé avec apostrophe dans un compte manquant (A09) | compte absent, intitulé `L'atelier`, ligne en double | erreur SQL figée sur l'`UPDATE Nvcompte` | `tests/apostrophe_nvcompte/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées en phase 2 en rejouant les scénarios dans le clone **Laurux non
  modifié**, sur `Laurux01.sql` importée dans MariaDB jetable. Les fichiers d'entrée sont générés
  par `gen_input.py` à partir de clients et comptes existants de `Laurux01.sql` (T01) ou modifiés
  (T02-T09) ; `check_output.py` normalise les fichiers texte (fin de ligne, ordre).
- **Dump `Sauve`** : la présence de `<rep>/Laurux_dump.sql<JJMMAAAA>` est vérifiée, pas son
  contenu (date variable) ; le harnais doit fournir `mysqldump` et une base sur `127.0.0.1`
  (contraintes Docker des notes transverses : port et tunnel ignorés).
- **PDF** : seule la présence de `~/tmp/Edclients.pdf` est contrôlée ; `Visualiseur.Prog` est
  fermé par le scénario.
- **Couverture** : les vestiges Kugar `header`/`content0`/`content1` ne sont jamais exécutés
  (suppression IMPJDV-002).
- Les tests T02, T04, T06, T09 figent des anomalies (caractérisation) et seront mis à jour avec
  les corrections validées.
