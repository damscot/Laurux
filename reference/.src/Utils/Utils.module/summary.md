# Utils — Synthèse

> Source : `.src/Utils/Utils.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module global historique : il porte le **handle BDD unique** `Utils.db` (`DB_Connection`), les
`Result` partagés `rs1`…`rs4` des grilles virtuelles, l'état du tunnel SSH, et 76 fonctions
utilitaires : conversions numériques et de dates, couleurs du thème et focus, enregistrement des
observateurs de log/replay, calcul d'échéance, code-barres, administration MySQL par shell.

## Points clés

- Utilisé par **347 fichiers** pour `db` ; `cpoint` (~2 100 appels), `Cdate_Aff`, `Cdate_Dbase`,
  `Observers` (231 écrans), `Fcolr`, `ObsGotf`/`ObsLstf` sont les autres piliers.
- Environ 820 blocs `With Utils` (194 fichiers) appellent les membres en `.X` : invisibles pour
  `deps.py`, ils doivent être recherchés par grep.
- `Base`…`Base4` sont quatre copies identiques ; chacune range son `Result` dans une globale
  `rsN` lue par les handlers `_Data` des écrans (contrat implicite, collisions possibles).
- `Calcech` (CC 77, 115 lignes) calcule les échéances clients par manipulation de chaînes.
- Dix fonctions `Cdate_*` attendent chacune un format de chaîne différent.
- Fonctions mixtes : `Message`/`Music` dans `Cdate_calc`, `FloatParse`, `Next_Code`, `chkEmail`.
- `Ciel()` modifie le schéma hors de `LauruxMaj`.
- 9 fonctions et 3 variables mortes ; 4 membres réductibles en `Private`.

## Dépendances principales

- Utilise : `Start` (réglages, son, fenêtre principale), `DB_Connection`, `DB_Desktop`,
  `ReplayObserver`, `LLog`, `LDate`, `hexdblKey`, `Cbase`, `Fmenu` (test de type).
- Utilisé par : la quasi-totalité des `.class`/`.module` ; cycles avec `DB_Connection`, `Start`,
  `LPrix`/`LTaxe`, `LDate`, `ReplayObserver`.
- Doublons dans d'autres fichiers : `cpoint` (6 copies locales), `convBool` (`Lettrage`), arrondi au
  0,05 (`Caisse`, `Moulinage`, `Facture`, `LPrix`…), init SSH (`LauruxConf`), shell MySQL (`Mmysql`).

## Risques

- **Rayon d'impact maximal** : toute régression touche tout l'applicatif ; les signatures Public
  ne bougent pas, les factorisations restent internes.
- `Rmdir_rf`/`Mkdir_p` passent un chemin non quoté au shell (`rm -rf`).
- `ControlTunnel` construit une commande `mysql` invalide (contrôle de réplication faux).
- `fam` produit un SQL invalide sans sélection ; `Obstch` a une condition toujours vraie.
- Dépendance à la locale de `arrondi`, `totobs`, `Calcode` (à confirmer).
- Mots de passe MySQL en clair sur la ligne de commande (`Fill_DataBase`, `ControlTunnel`…).
- `ROArray` jamais vidé (croissance mémoire, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1311 |
| Lignes de commentaire | 101 |
| Fonctions | 76 |
| Fonctions Public | 76 |
| Complexité cyclomatique totale | 473 |
| Complexité max (fonction) | 77 (`Calcech`) |
| Variables globales | 16 |
| Variables Public | 16 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

26 tests prévus (UTILS-T01 à T26) : 22 `gbtest` (conversions, dates, matrice `Calcech` d'environ
4 000 cas, chaînes, `Next_Code`, `Calcode`, `Option`, SQL `Find_cbarre`/`Commande`/`orientation`,
`glb`, `Ciel`, système de fichiers, `Log`, performance) exécutés sous deux locales, et 4 `replay`
(grilles `BaseN`, couleurs et observateurs, saisies, restauration CLI). Tunnel SSH, réplication,
son et curseur restent manuels.

## Rework

16 étapes sans changement de comportement (UTILS-001 à 016) : documentation, suppression du code
mort, réduction de portée, factorisation de `BaseN`, des couleurs, des observateurs, de `Cdate_Comp`,
de `Calcech` (après tests), des remplacements de chaînes, séparation traitement/GUI, helper shell
MySQL et init SSH commune avec `LauruxConf`. 12 anomalies (UTILS-A01 à A12) sont soumises à
validation utilisateur.
