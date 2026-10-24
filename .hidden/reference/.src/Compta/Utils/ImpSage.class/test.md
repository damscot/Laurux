# ImpSage — Tests

> Source : `.src/Compta/Utils/ImpSage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests **replay** (menu Comptabilité > Outils > Import écritures Sage) : chaque test fournit des
fichiers `clients.pnc` et `ecritures.pnm` de référence (`tests/<nom>/data/`) et compare après
import le **dump normalisé** de `Corsage`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Comptes`,
`Fiches_Mvt`, `Fiches_Parametres` (`dnc`, `dnf`, `numecriture`) et `Nvcompte`, ainsi que
`rejets.txt` et `Nvcomptes.txt`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPSAGE-T01 | replay | Import nominal | 2 clients `411` et 1 fournisseur `401` inconnus ; 4 pièces (VTE, ACH, BQ1, OD) sur comptes existants | tiers, comptes, `Corsage`, écritures (collectif + tiers + contreparties), soldes, compteurs | `tests/import_nominal/` | à faire |
| IMPSAGE-T02 | replay | Code Sage déjà connu suivi d'un nouveau (caractérisation A01) | `clients.pnc` : tiers connu dans `Corsage` puis tiers inconnu | état figé : le nouveau tiers est associé au code Laurux du précédent | `tests/compteur_ecrase/` | à faire |
| IMPSAGE-T03 | replay | Création automatique de comptes généraux (`ControleS`) | écritures sur `6xxxxxxx`, `512xxxxx`, `8xxxxxxx` absents | comptes créés (type, trésorerie, intitulé `" "`), `Nvcomptes.txt` | `tests/comptes_crees/` | à faire |
| IMPSAGE-T04 | replay | Ré-import | T01 rejoué deux fois | lignes « écriture rejetée » dans `rejets.txt`, aucune ligne en double | `tests/reimport/` | à faire |
| IMPSAGE-T05 | replay | Double insertion des lignes tiers (caractérisation A03) | `dnc` = `411050` puis `411999` en base, 2 nouveaux clients avec écritures | codes `411051` (une ligne) ; `4111000`, `4111001` (lignes tiers insérées deux fois, figé) | `tests/seuil_compteur/` | à faire |
| IMPSAGE-T06 | replay | Fournisseur `403` et fournisseur déjà existant en `Fiches_Four` (A02) | tiers `403` ; tiers `401` dont `numf` existe déjà en `Fiches_Four` | comportement figé (tiers `403` traité comme `401` ; erreur d'`INSERT` sans `Try`) | `tests/fournisseurs/` | à faire |
| IMPSAGE-T07 | replay | Option « Clôturer » et journaux non reconnus | T01 avec case cochée + journal `XYZ` | `cloturee = 1` ; `jour` vide pour `XYZ` | `tests/cloture_journaux/` | à faire |
| IMPSAGE-T08 | replay | Fichiers absents / réponse « Non » | répertoire vide ; puis fichiers valides et « Non » | message ; base inchangée ; dump présent | `tests/absents_refus/` | à faire |
| IMPSAGE-T09 | gbtest | `ProchainCodeTiers` (après IMPSAGE-005) | `Null`, `"411000"`, `"411500"`, `"411999"`, `"4119999"`, `"401999"`, préfixes `411`/`401` | codes identiques à `Compteur`/`Compteurf` actuels | `tests/prochain_code/` | à faire |
| IMPSAGE-T10 | gbtest | `LigneSage` (après IMPSAGE-008) | lignes `.pnm` de T01 | champs découpés (journal, date, compte, sens, montant…) | `tests/ligne_sage/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées en phase 2 dans le clone **Laurux non modifié** sur
  `Laurux01.sql` (MariaDB jetable) ; fichiers d'entrée produits par `gen_input.py` (positions fixes
  documentées dans architecture.md) ; `check_output.py` normalise les fichiers texte.
- **Contrôles** : `Controle_journal` et `Controle_tiers` sont couverts par T01/T07 (tous les
  journaux reconnus + un inconnu), ce qui autorise leur passage en `Private` (règle de portée).
- **`Exist("")`** : T01 vérifie que `Controle` n'a pas d'effet (hors `Nvcompte`), ce qui confirme
  l'anomalie IMPSAGE-A05.
- **Non testable automatiquement** : comportement exact sous `sql_mode` strict pour la troncature
  de `Corsage.acode` (dépend de la configuration MariaDB du conteneur ; à fixer dans
  `tools/db/`).
