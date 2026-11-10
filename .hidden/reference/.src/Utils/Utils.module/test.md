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
| UTILS-T01 | gbtest | `cpoint`, `PointBase`, `CSlash`, `CDec`, `Find_nbdec` | `Null`, `""`, `" 1.5"`, `"1,5"`, `"-3.155"`, `"abc"` × nbdec `"0"`, `"2"`, `"3"`, `"4"` | chaînes de référence | `tests/conversions_numeriques/` | implémenté |
| UTILS-T02 | gbtest | `FloatParse` | `"1 234,56"`, `"-3.15"`, `"+ 2"`, `"12"`, `""`, `Null`, `"abc"` | Float de référence (cas `"abc"` : `Message.Error`, voir Détail) | `tests/floatparse/` | implémenté (cas « abc » à faire : Message.Error bloquant) |
| UTILS-T03 | gbtest | `arrondi` | montants ± (String et Float) × `ndec` 0..4, valeurs x,xx5 | Float de référence, 2 locales | `tests/arrondi/` | implémenté (locale fr_FR seule) |
| UTILS-T04 | gbtest | `totobs`, `convBool`, `convStr` | tableaux mixtes (`"1.5"`, `"2,5"`, `""`, `"x"`) ; `"0"`, `""`, `"1"`, `"2"` | somme / chaînes | `tests/totobs_bool/` | implémenté |
| UTILS-T05 | gbtest | `Cdate_Dbase`, `Cdate2_Dbase`, `Cdate_Aff`, `Cdate_Carte`, `Cdate_Com`, `Cdate_Comp2`, `Cdate_Ciel`, `Cdate_Cador`, `Cdate_Sage` | une `Date`, puis la chaîne au format attendu par chaque fonction (voir architecture.md) | chaînes de référence (dont masques `YY`) | `tests/dates_formats/` | implémenté |
| UTILS-T06 | gbtest | `Cdate_Comp` | `Date` ; chaînes `yyyy-mm-dd`, `mm-dd-yyyy`, avec `.` et `/` ; `"20240131"` ; entiers 2024, 202401, 20240131, 999905 | chaînes de référence ; erreurs figées (branche entière) | `tests/cdate_comp/` | implémenté (999905 et 99990105 à faire : blocage par Message dans LDate, A04) |
| UTILS-T07 | gbtest | `Cdate_calc` (hors cas d'erreur) | `"5"`, `"0503"`, `"050324"`, `"05.03.2024"`, `"05/03/2024"`, `Null` | `Date` de référence (mois/année courants injectés : à figer avec une date système fixée, voir Détail) | `tests/cdate_calc/` | implémenté (cas invalides à faire : Message.Error) |
| UTILS-T08 | gbtest | `Calc_mois`, `mois`, `lastday` | dates de chaque mois, décembre, février bissextile/non ; `mois(0..13)` | chaînes / entiers | `tests/mois/` | implémenté |
| UTILS-T09 | gbtest | `Calcech` (matrice) | `dureech` ∈ {00, 30, 45, 60, 90} × `jours` ∈ {00, 05, 10, 15, 25, 30} × `finmois` ∈ {Vrai, Faux} × `datef` ∈ {1er, 15, 28, 30, 31 de chaque mois, 29/02 bissextile} | 1 chaîne par cas (≈ 4 000 cas) | `tests/calcech_matrice/` | implémenté |
| UTILS-T10 | gbtest | `Remplace`, `ReplaceLb`, `Replace` (CP850), `Accent` | chaînes avec `"`, `&`, `\n`, `'`, accents | octets de référence | `tests/chaines/` | implémenté |
| UTILS-T11 | gbtest | `Next_Code` | `""`, `"9"`, `"A009"`, `"A099"`, `"AZ"`, `"Zz"`, `"z"`, `"A-"`, code de 15 car. | codes de référence ; troncature (voir Détail) | `tests/next_code/` | implémenté (troncature à faire : Message.Warning bloquant) |
| UTILS-T12 | gbtest | `Calcode` | codes EAN-8, EAN-13 connus, chaîne vide | clé de référence, 2 locales | `tests/calcode/` | implémenté (locale fr_FR seule) |
| UTILS-T13 | gbtest | `Fcolr`, `Fcoulfond`, `Nsoc`, `PageFormat*` | `"background: 123; font: x; foreground: 456;"`, sans espace, vide ; `"R: 1,G: 2,B: 3"` ; `"01:Soc"` ; 4 formats + inconnu | tableaux / entiers | `tests/parse_divers/` | implémenté |
| UTILS-T14 | gbtest | `Option` | `Laurux.conf` de test avec `/Soc01/bois`, `/pp` ∈ {absent, 0, 1} | `N`/`B`/`P`/`T` | `tests/option/` | implémenté |
| UTILS-T15 | gbtest | `Find_cbarre` | BDD `Laurux01.sql` + jeu dérivé (code-barres secondaire, article sans code-barres, inconnu, `Null`) | codes de référence | `tests/find_cbarre/` | implémenté |
| UTILS-T16 | gbtest | `Commande` (`"Four"`) | jeu dérivé : 0, 1, 3 lignes `Fiches_Ligcom` ; `uv` 1 et 6 ; `decm` `""`, `"2"` | chaînes de référence | `tests/commande/` | implémenté |
| UTILS-T17 | gbtest | `orientation` | jeu dérivé option bois (`Fiches_ligcons`, `Fiches_ligregie`, `Fiches_Bl`, `Fiches_Art.art_dra`) × `choix` F, B, FM | booléens ; erreur figée pour `FM` (table `Bl`) | `tests/orientation/` | implémenté |
| UTILS-T18 | gbtest | `glb` | `Laurux.conf` MySQL direct, MySQL + SSH, SQLite | propriétés de `db` et variables SSH | `tests/glb/` | implémenté |
| UTILS-T19 | gbtest | `Ciel` | base vierge puis base déjà dotée des tables | tables `Ciel_Lrx*` et colonne `imp_ciel` présentes ; 2ᵉ appel sans erreur | `tests/ciel_ddl/` | implémenté |
| UTILS-T20 | gbtest | `Mkdir_p`, `Rmdir_rf` | répertoire temporaire simple, imbriqué, `/`, `User.Home`, `Null` | booléens et état du disque (pas de chemin avec espace : anomalie A07) | `tests/mkdir_rmdir/` | implémenté |
| UTILS-T21 | gbtest | `Log` | `Start.Arg_Debug` vrai/faux, nom d'objet et chaîne | création d'un seul `LLog` par nom | `tests/log/` | implémenté |
| UTILS-T22 | replay | `Base`…`Base4` + `rsN` | écrans `Archives` (Base, Base3), `TriFac2` (Base2), `TriMo` (Base4), `Ccomptes` via `Saisecrit` : ouverture, tri, défilement | capture des cellules affichées identique | `tests/replay_grilles/` | à faire : capture des cellules affichées non prise en charge par le runner (seuls dump et SQL sont comparés) |
| UTILS-T23 | replay | `Observers`, `SetEditColor`, `ObsGotf`, `ObsLstf`, `ObsLstf2` | écran `FClient` avec `/Soc01/Coul_fen` = 1 puis 0 ; tabulation entre champs | couleurs de fond capturées par le log ; enregistrement des `ReplayObserver` (le replay lui-même en dépend) | `tests/replay_couleurs/` | à faire : couleurs de fond non capturées par le runner ; l'enregistrement des ReplayObserver est couvert par REPLAYOBSERVER-T02 à T04 |
| UTILS-T24 | replay | `Fill_Civilite`, `chkEmail`, `Obstch`, `fam` | `FClient` (civilités, e-mail invalide), `TriBl` (recherche au clavier, touche Entrée), `Stockmvt` (aucune famille cochée) | contenus de liste, messages et requêtes SQL du log | `tests/replay_saisies/` | à faire : contenus de liste et messages non capturés ; chkEmail ouvre un Message.Warning (à couvrir avec les scénarios FClient du lot Gestion) |
| UTILS-T25 | replay | `Clear_DataBase`, `Create_DataBase`, `Fill_DataBase` | restauration en ligne de commande (`Start` `Arg_Restore_DB`) de `Laurux01.sql` dans MariaDB Docker | dump normalisé identique ; sortie d'erreur vide | `tests/restauration_cli/` | implémenté |
| UTILS-T26 | gbtest | Performance | 100 000 `cpoint` + `Cdate_Dbase` + `Calcech` | durée de référence (`gbx3 -p`) | `tests/perf_utils/` | à faire : mesure de durée (gbx3 -p, étape 6 de la phase 2), pas de valeur golden |

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
- **Implémentation (phase 2)** : module `.src/Tests/Utils/UtilsTest.test` (une méthode `Tnn…` par test),
  valeurs attendues dans `.hidden/Tests/Utils/assets/UtilsTest/expected.txt`. Jeux de données :
  `datasets/utils_cbarre_commande.sql` (T15, T16 : code-barres secondaire, lignes `Fiches_Ligcom`) et
  `datasets/utils_orientation.sql` (T17 : tables minimales `Fiches_ligcons`/`Fiches_ligregie` et colonne
  `art_dra`, faute de DDL de l'option bois dans le dépôt). Le runner n'exécute qu'en `fr_FR.UTF-8` :
  la seconde locale (`LANG=C`) reste à outiller. T09 : une clé par (durée, jours, fin de mois), 61 dates
  chacune. T07 : les composants issus de `Now` sont vérifiés par différence (`dMois`, `dAnnee`).
  T22-T25 (replay) : à faire (écrans couverts par les lots des appelants ; T25 dépend de `--restore`).
- **Comportements figés notables** : `Nsoc` lève « Type mismatch » à chaque appel (String renvoyée pour
  String[]) ; `Fcoulfond` compare à `"R"/"G"/"B"` après `LCase` (jamais trouvé) ; `Fcolr` exige `": "`
  (sans espace : Null) ; `Calcode("12A4")` lève une erreur ; `convStr` renvoie `"T"`/Null.
- **T25** : scénario `.hidden/Tests/Utils/assets/utils_restauration_cli/` (`--restore Laurux01.sql` sur une base modifiée par
  `statut_p1_p2`, puis Quitter) : le dump attendu est celui de `Laurux01.sql`.
