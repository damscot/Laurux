# Dup — Architecture

> Source : `.src/Compta/Utils/Dup.class` · Formulaire : `.src/Compta/Utils/Dup.form`

## Vue d'ensemble

Écran **« Duplication de sociétés »** (menu Admin « Duplication de société », `Fmenu.Menu150_Click`,
et `Fsoc` choix 6, tous deux protégés par `MDP` si `/Soc<XX>/Admin`). Il copie le paramétrage de
la société courante (base `Laurux<XX>`) vers une autre base `Laurux<YY>`, existante ou créée pour
l'occasion par `LauruxConf.Createbase`, et en option ses tiers, familles, articles, commentaires
et main-d'œuvre.

La copie se fait par **SQL inter-bases MySQL** (`<base>.<table>`) : `DROP TABLE` puis
`CREATE TABLE <cible> SELECT * FROM <source>`, table par table, avec quelques remises à zéro
(compteurs de documents et d'écritures, soldes, stocks). La liste des bases vient d'un
`Shell mysql -e "show databases"`. L'écran est donc **MySQL uniquement**.

Nature : **mixte**. Tout le traitement est dans le handler `Button1_Click` (CC 82, 205 lignes),
fait de 22 blocs quasi identiques.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

Contrôles du `.form` : `S1` (base source, lecture seule), `Nbase` (ComboBox des bases cibles),
`Chk1` Clients, `Chk2` Fournisseurs, `Chk3` Familles, `Chk4` Articles, `Chk5` Commentaires,
`Chk6` MO ; `Button1` Lancer, `Button2` Aide, `Button3` Quitter.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-50 | Public | 5 | 19 | 0 | méthode spéciale |
| `Button3_Click` | 52-56 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 58-62 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 64-296 | Public | 82 | 205 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : mixte]. Charge le son, centre la
  fenêtre, `Utils.Observers(Me)`. Lance `Shell "cd ~"` (sans effet : sous-shell), puis
  `Shell "mysql -h <Host> -u <Login> -p<Password> -e \"show databases;\" -B -s > ~/bases.txt" Wait`
  — **mot de passe en clair dans la ligne de commande** et port/tunnel SSH ignorés — et remplit
  `Nbase` avec les lignes qui commencent par `Laurux` et dépassent 6 caractères. Le fichier
  `~/bases.txt` n'est ni fermé explicitement ni supprimé. `S1 = "Laurux" & /Soc`.
- **`Button3_Click()`** [handler, GUI] : ferme.
- **`Button2_Click()`** [handler, GUI] : `Doc.Open("Dup")` (aide).
- **`Button1_Click()`** (CC 82) [handler] [nature : mixte, partie extractible : toute la séquence
  SQL à partir de la ligne 78] :
  1. Refuse la copie sur elle-même ; demande confirmation (`Message.Question`).
  2. `set sql_mode = 'no_auto_value_on_zero'` sur la **session courante** (jamais restauré :
     remplace tout le `sql_mode` de la connexion pour le reste de la session — à confirmer).
  3. Existence de la cible : parcours de `Utils.db.Databases` ; si elle existe, confirmation
     d'écrasement, sinon `LauruxConf.Createbase(Nbase.Text, False)` (schéma de défaut).
  4. Copie systématique : `Fiches_Parametres` (puis `dnbon`, `dnfac` = `000000`, `dncom` =
     `00000`, `numecriture`, `numecriture2` = 0, `dnc` = `411000` / `dnf` = `401000` si les
     tiers ne sont pas copiés), `Fiches_Tvaav`, `Fiches_Tvaac`, `Fiches_Journaux`,
     `Fiches_Echeances`, `Fiches_Txt_Relances`, `Fiches_Etiquettes`, `Fiches_Cpostaux`,
     `Fiches_Societes` (puis `cd_sc = <YY>` sur toutes les lignes).
  5. `Fiches_Comptes` : dans la cible, suppression des comptes hors 411/401 et des collectifs,
     puis (option) remplacement des comptes 411 et/ou 401 individuels, puis insertion depuis la
     source des comptes hors 411/401 et des collectifs ; `solde = soldep = 0` (3ᵉ argument
     superflu). C'est la seule table copiée par `INSERT … SELECT` (structure conservée).
  6. Options : `Chk1` → `Fiches_Cli`, `Fiches_AdrlivC`, `Fiches_ContactC` ; `Chk2` →
     `Fiches_Four`, `Fiches_ContactF` ; `Chk3` → `Fiches_Fam` ; `Chk4` → `Fiches_Art` (stock,
     commandes, dépôt, dates remis à zéro) et `Fiches_CdBarre` ; `Chk5` → `Fiches_Commentaires` ;
     `Chk6` → `Fiches_Mo`, `Fiches_Txtmo`.
  7. Chaque `DROP` est sous `Try` ; en cas d'échec sur une base existante, `Message.Error` puis la
     copie continue. Aucune transaction (les DDL MySQL valident implicitement).

  ⚠️ **`CREATE TABLE … SELECT` ne recopie ni clé primaire, ni index, ni `AUTO_INCREMENT`, ni
  valeurs par défaut** : les 20 tables copiées ainsi divergent de `db_control.csv` (détectable par
  `DB_Sanity`) et les tables à colonne `lind` auto-incrémentée perdent leur compteur (anomalie
  A01). `DB_Connection.CopieTable` utilise `CREATE TABLE … LIKE` mais ne copie pas les données
  et ne gère pas le préfixe de base.

## État global utilisé

- `Start.Musique`, `Start.LocalSettings["/dbase/Host"]`, `Start.LocalSettings["/Soc"]`.
- `Utils.db` (`Exec`, `Login`, `Password`, `Databases`), `Utils.Observers`.
- `LauruxConf.Createbase`, `Doc.Open`.
- Tables : 21 tables `Fiches_*` (liste ci-dessus), en dur et préfixées par le nom de base.

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `CopieTableSoc(sTable, bExisting)` : `Try DROP` + message + `CREATE TABLE … SELECT`
  (même SQL). Les 20 blocs se réduisent à une liste de tables par option ; CC 82 → ~12.
- Remplacer les branches `If Chk<N>.value = True` dupliquées (deux blocs `Chk1`, deux blocs
  `Chk6`) par une table `[case à cocher → tables]`.
- Supprimer `Shell "cd " & User.Home` (sans effet) et le 3ᵉ argument superflu de la ligne 149.

### Commonalisation avec d'autres fichiers

- **Détection des bases Laurux** : la boucle sur `Utils.db.Databases` (ligne 82) et le `Shell mysql
  show databases` du constructeur rejoignent le helper `Utils.BasesLaurux(bPrefixe)` proposé par
  [LauruxConf](../../../Communs/LauruxConf.class/architecture.md) (LAURUXCONF-005) et
  [Fsoc](../../../Communs/Fsoc.class/architecture.md) (FSOC-008).
- **Ligne de commande mysql** : même construction (mot de passe en clair, port ignoré) que les
  helpers `Utils.Fill/Clear/Create_DataBase`, `Mmysql`, `FRestore` (voir notes transverses,
  `Utils.DumpBase`).
- La copie de table entre bases pourrait devenir une méthode `DB_Connection.CopieTableBase(src,
  dst, avecDonnees)` partagée avec `DB_Connection.CopieTable` (utilisée par `FClotureAn`).

### Réduction de portée

- Aucune : toutes les fonctions sont des handlers ou le constructeur.

### Séparation traitement / GUI

- Extraire la séquence SQL de `Button1_Click` dans `Private Sub Duplique(sSrc, sDst, bExisting,
  bCli, bFour, bFam, bArt, bCom, bMo)` sans accès aux contrôles ; le handler garde les
  confirmations, le curseur et le message final. Les `Message.Error` sur échec de `DROP` restent
  dans `Duplique` (ou sont renvoyés dans une liste et affichés dans le même ordre).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une base unique multi-sociétés (colonne `societe`) supprimerait la duplication par bases ;
  hors périmètre.
