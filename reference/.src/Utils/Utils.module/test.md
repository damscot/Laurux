# Utils — Tests

> Source : `.src/Utils/Utils.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Les valeurs attendues sont produites en phase 2 en exécutant les mêmes appels dans le clone
**Laurux non modifié** (sortie capturée dans `tests/<nom>/expected/`), jamais déduites de la lecture
du code. Les anomalies sont donc figées (tests de caractérisation). Les tests numériques et de dates
sont lancés sous **deux locales** (`LANG=fr_FR.UTF-8` et `LANG=C`) pour figer la dépendance à la
locale de `arrondi`, `totobs`, `Calcode` et des `Val()`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| UTILS-T01 | gbtest | `cpoint`, `PointBase`, `CSlash`, `CDec`, `Find_nbdec` | `Null`, `""`, `" 1.5"`, `"1,5"`, `"-3.155"`, `"abc"` × nbdec `"0"`, `"2"`, `"3"`, `"4"` | chaînes de référence | `tests/conversions_numeriques/` | à faire |
| UTILS-T02 | gbtest | `FloatParse` | `"1 234,56"`, `"-3.15"`, `"+ 2"`, `"12"`, `""`, `Null`, `"abc"` | Float de référence (cas `"abc"` : `Message.Error`, voir Détail) | `tests/floatparse/` | à faire |
| UTILS-T03 | gbtest | `arrondi` | montants ± (String et Float) × `ndec` 0..4, valeurs x,xx5 | Float de référence, 2 locales | `tests/arrondi/` | à faire |
| UTILS-T04 | gbtest | `totobs`, `convBool`, `convStr` | tableaux mixtes (`"1.5"`, `"2,5"`, `""`, `"x"`) ; `"0"`, `""`, `"1"`, `"2"` | somme / chaînes | `tests/totobs_bool/` | à faire |
| UTILS-T05 | gbtest | `Cdate_Dbase`, `Cdate2_Dbase`, `Cdate_Aff`, `Cdate_Carte`, `Cdate_Com`, `Cdate_Comp2`, `Cdate_Ciel`, `Cdate_Cador`, `Cdate_Sage` | une `Date`, puis la chaîne au format attendu par chaque fonction (voir architecture.md) | chaînes de référence (dont masques `YY`) | `tests/dates_formats/` | à faire |
| UTILS-T06 | gbtest | `Cdate_Comp` | `Date` ; chaînes `yyyy-mm-dd`, `mm-dd-yyyy`, avec `.` et `/` ; `"20240131"` ; entiers 2024, 202401, 20240131, 999905 | chaînes de référence ; erreurs figées (branche entière) | `tests/cdate_comp/` | à faire |
| UTILS-T07 | gbtest | `Cdate_calc` (hors cas d'erreur) | `"5"`, `"0503"`, `"050324"`, `"05.03.2024"`, `"05/03/2024"`, `Null` | `Date` de référence (mois/année courants injectés : à figer avec une date système fixée, voir Détail) | `tests/cdate_calc/` | à faire |
| UTILS-T08 | gbtest | `Calc_mois`, `mois`, `lastday` | dates de chaque mois, décembre, février bissextile/non ; `mois(0..13)` | chaînes / entiers | `tests/mois/` | à faire |
| UTILS-T09 | gbtest | `Calcech` (matrice) | `dureech` ∈ {00, 30, 45, 60, 90} × `jours` ∈ {00, 05, 10, 15, 25, 30} × `finmois` ∈ {Vrai, Faux} × `datef` ∈ {1er, 15, 28, 30, 31 de chaque mois, 29/02 bissextile} | 1 chaîne par cas (≈ 4 000 cas) | `tests/calcech_matrice/` | à faire |
| UTILS-T10 | gbtest | `Remplace`, `ReplaceLb`, `Replace` (CP850), `Accent` | chaînes avec `"`, `&`, `\n`, `'`, accents | octets de référence | `tests/chaines/` | à faire |
| UTILS-T11 | gbtest | `Next_Code` | `""`, `"9"`, `"A009"`, `"A099"`, `"AZ"`, `"Zz"`, `"z"`, `"A-"`, code de 15 car. | codes de référence ; troncature (voir Détail) | `tests/next_code/` | à faire |
| UTILS-T12 | gbtest | `Calcode` | codes EAN-8, EAN-13 connus, chaîne vide | clé de référence, 2 locales | `tests/calcode/` | à faire |
| UTILS-T13 | gbtest | `Fcolr`, `Fcoulfond`, `Nsoc`, `PageFormat*` | `"background: 123; font: x; foreground: 456;"`, sans espace, vide ; `"R: 1,G: 2,B: 3"` ; `"01:Soc"` ; 4 formats + inconnu | tableaux / entiers | `tests/parse_divers/` | à faire |
| UTILS-T14 | gbtest | `Option` | `Laurux.conf` de test avec `/Soc01/bois`, `/pp` ∈ {absent, 0, 1} | `N`/`B`/`P`/`T` | `tests/option/` | à faire |
| UTILS-T15 | gbtest | `Find_cbarre` | BDD `Laurux01.sql` + jeu dérivé (code-barres secondaire, article sans code-barres, inconnu, `Null`) | codes de référence | `tests/find_cbarre/` | à faire |
| UTILS-T16 | gbtest | `Commande` (`"Four"`) | jeu dérivé : 0, 1, 3 lignes `Fiches_Ligcom` ; `uv` 1 et 6 ; `decm` `""`, `"2"` | chaînes de référence | `tests/commande/` | à faire |
| UTILS-T17 | gbtest | `orientation` | jeu dérivé option bois (`Fiches_ligcons`, `Fiches_ligregie`, `Fiches_Bl`, `Fiches_Art.art_dra`) × `choix` F, B, FM | booléens ; erreur figée pour `FM` (table `Bl`) | `tests/orientation/` | à faire |
| UTILS-T18 | gbtest | `glb` | `Laurux.conf` MySQL direct, MySQL + SSH, SQLite | propriétés de `db` et variables SSH | `tests/glb/` | à faire |
| UTILS-T19 | gbtest | `Ciel` | base vierge puis base déjà dotée des tables | tables `Ciel_Lrx*` et colonne `imp_ciel` présentes ; 2ᵉ appel sans erreur | `tests/ciel_ddl/` | à faire |
| UTILS-T20 | gbtest | `Mkdir_p`, `Rmdir_rf` | répertoire temporaire simple, imbriqué, `/`, `User.Home`, `Null` | booléens et état du disque (pas de chemin avec espace : anomalie A07) | `tests/mkdir_rmdir/` | à faire |
| UTILS-T21 | gbtest | `Log` | `Start.Arg_Debug` vrai/faux, nom d'objet et chaîne | création d'un seul `LLog` par nom | `tests/log/` | à faire |
| UTILS-T22 | replay | `Base`…`Base4` + `rsN` | écrans `Archives` (Base, Base3), `TriFac2` (Base2), `TriMo` (Base4), `Ccomptes` via `Saisecrit` : ouverture, tri, défilement | capture des cellules affichées identique | `tests/replay_grilles/` | à faire |
| UTILS-T23 | replay | `Observers`, `SetEditColor`, `ObsGotf`, `ObsLstf`, `ObsLstf2` | écran `FClient` avec `/Soc01/Coul_fen` = 1 puis 0 ; tabulation entre champs | couleurs de fond capturées par le log ; enregistrement des `ReplayObserver` (le replay lui-même en dépend) | `tests/replay_couleurs/` | à faire |
| UTILS-T24 | replay | `Fill_Civilite`, `chkEmail`, `Obstch`, `fam` | `FClient` (civilités, e-mail invalide), `TriBl` (recherche au clavier, touche Entrée), `Stockmvt` (aucune famille cochée) | contenus de liste, messages et requêtes SQL du log | `tests/replay_saisies/` | à faire |
| UTILS-T25 | replay | `Clear_DataBase`, `Create_DataBase`, `Fill_DataBase` | restauration en ligne de commande (`Start` `Arg_Restore_DB`) de `Laurux01.sql` dans MariaDB Docker | dump normalisé identique ; sortie d'erreur vide | `tests/restauration_cli/` | à faire |
| UTILS-T26 | gbtest | Performance | 100 000 `cpoint` + `Cdate_Dbase` + `Calcech` | durée de référence (`gbx3 -p`) | `tests/perf_utils/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : un module gb.test commun écrit une ligne `id;entrée;sortie`
  par cas ; `gen_input.py` produit les matrices (T03, T05, T09) ; `check_output.py` compare à
  `expected/` (tolérance 1e-9 sur les Float). Les deux clones exécutent le même module.
- **Date courante** : `Cdate_calc` complète avec le mois et l'année courants. Les tests T07 sont
  lancés avec `faketime` (date système figée) dans les deux clones.
- **Message / Music** : les cas qui déclenchent `Message.Error`/`Warning` (`FloatParse("abc")`,
  `Cdate_calc` invalide, troncature de `Next_Code`) ne peuvent pas tourner en gb.test sans GUI. Ils
  sont couverts par replay (T24) ou après la séparation traitement/GUI (UTILS-011), qui expose une
  fonction pure testable.
- **Données** : T15-T17 et T19 utilisent `Laurux01.sql` importé dans le MariaDB Docker jetable, plus
  un jeu dérivé `data/*.sql` (insertions minimales). `orientation` exige les tables de l'option bois,
  absentes de `Laurux01.sql` : leur DDL est extrait du clone de référence (`LauruxMaj` / module
  option) et versionné dans `tests/orientation/data/`.
- **Non testable automatiquement** : `monteTunnel`, `fermeTunnel`, `ControlTunnel` (serveur SSH et
  réplication MySQL), `MouseProcessing`/`MouseDefault`, `Play`/`Bip` (son), `Exit` (envoie `SIGINT`
  au processus de test). Ils sont documentés comme tests manuels ; `Exit` peut être couvert par un
  test de processus (code de sortie de `./Laurux` en ligne de commande).
- **Couverture visée** : 100 % des fonctions de calcul (sections 5, 6, 7, 9, 10 d'architecture.md) ;
  les fonctions GUI sont couvertes par T22-T24.
