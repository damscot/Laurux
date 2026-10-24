# EcrM — Architecture

> Source : `.src/Compta/Impressions/EcrM.class`

## Vue d'ensemble

`EcrM` est l'écran **« Écritures modifiées/supprimées »** (menu Compta, `Fmenu.Menu323_Click` →
`EcrM.Show()`). Il imprime le contenu des tables d'historique des modifications
`Fiches_MvtM` … `Fiches_MvtM5` (une par exercice, structure `MvtM` à 30 colonnes, dont
`supprimee` et `datem`) entre deux dates, avec un filtre « Toutes / Modifiées / Supprimées » et
deux tris (date/numéro/compte ou numéro/date/compte). Le PDF `~/tmp/Journaux.pdf` est produit par
`Ccompta` (`Level1M`/`level2M`/`BasPage2`) puis ouvert par `Visualiseur.Prog`.

Le fichier est une **copie partielle de [`Journaux.class`](../Journaux.class/architecture.md)**
(l'en-tête de licence porte encore « Journaux.class » / « Edition des journaux ») : il en garde la
sélection d'exercice (`E0`, `E1`, `N1`…`N5`), le contrôle des dates, la table `centralisation`, les
fonctions `donnees*` d'export texte et de nombreux cumuls inutilisés. Contrairement à `Journaux`,
la sélection d'exercice a été factorisée dans `exercice(ind)` (seule fonction `Private`), ce qui
en fait un bon point de départ pour un helper commun.

Nature globale : **mixte** ; `Button1_Click` (CC 34) concentre SQL, calcul et rendu PDF.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebhP` | var | Private |  | Float | 27 |
| `CredhP` | var | Private |  | Float | 28 |
| `TotSldhP` | var | Private |  | Float | 29 |
| `TotDeb` | var | Private |  | Float | 30 |
| `TotCred` | var | Private |  | Float | 31 |
| `TotSld` | var | Private |  | Float | 32 |
| `debit` | var | Private |  | Float | 33 |
| `credit` | var | Private |  | Float | 34 |
| `solde` | var | Private |  | Float | 35 |
| `dte` | var | Private |  | String | 36 |
| `dte1` | var | Private |  | String | 37 |
| `dte2` | var | Private |  | String | 38 |
| `Txt` | var | Private |  | String | 39 |
| `Filename` | var | Private |  | String | 40 |
| `Filetxt` | var | Private |  | String | 41 |
| `jour` | var | Private |  | String | 42 |
| `hfile` | var | Private |  | File | 43 |
| `type_jour` | var | Private |  | String | 44 |
| `Tab` | var | Private |  | String | 45 |
| `Tab0` | var | Private |  | String | 46 |
| `Tab1` | var | Private |  | String | 47 |
| `Db_ction` | var | Private |  | Float | 48 |
| `Cd_ction` | var | Private |  | Float | 49 |
| `Type` | var | Private |  | String | 50 |
| `son` | var | Private |  | Integer | 51 |
| `Ordre` | var | Private |  | String | 52 |
| `pdf` | var | Private |  | Ccompta | 53 |
<!-- /AUTO:declarations -->

Variables d'instance utiles : `dte1`/`dte2` (bornes de l'exercice choisi, pour le contrôle des
dates), `Tab1` (table `Fiches_MvtM*` interrogée), `Type` (filtre SQL modifiées/supprimées),
`Ordre` (clause `ORDER BY`), `solde`, `Filename`, `Txt`, `son`, `pdf`.
Jamais lues ou jamais utiles : `Tab0` (table `Fiches_Mvt*` affectée par chaque handler
d'exercice, jamais interrogée), `DebhP`/`CredhP` (toujours 0), `TotSldhP`, `TotDeb`, `TotCred`,
`TotSld`, `Db_ction`, `Cd_ction`, `debit`/`credit` (cumulés, jamais imprimés), `Filetxt`, `hfile`
(jamais ouvert), `type_jour` (jamais affecté), `jour` (variable de travail de `Ex1`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 55-67 | Public | 1 | 10 | 0 | méthode spéciale |
| `Ex1` | 69-93 | Public | 2 | 22 | 0 | portée réductible ? |
| `Exo` | 95-99 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exo1` | 101-105 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exo2` | 107-111 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exo3` | 113-117 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exo4` | 119-123 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exo5` | 125-129 | Public | 1 | 3 | 0 | portée réductible ? |
| `exercice` | 131-162 | Private | 7 | 28 | 0 |  |
| `Cmpt_KeyPress` | 164-191 | Public | 10 | 23 | 0 | handler GUI |
| `Btn_Click` | 193-208 | Public | 6 | 11 | 0 | handler GUI |
| `dteN0_GotFocus` | 210-216 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 218-239 | Public | 5 | 20 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 241-245 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 247-276 | Public | 8 | 28 | 0 | portée réductible ? |
| `Compdate` | 278-290 | Public | 3 | 11 | 0 | portée réductible ? |
| `compdate2` | 292-304 | Public | 3 | 11 | 0 | portée réductible ? |
| `E0_Click` | 306-312 | Public | 1 | 5 | 0 | handler GUI |
| `E1_Click` | 314-320 | Public | 1 | 5 | 0 | handler GUI |
| `N1_Click` | 322-328 | Public | 1 | 5 | 0 | handler GUI |
| `N2_Click` | 330-336 | Public | 1 | 5 | 0 | handler GUI |
| `N3_Click` | 338-344 | Public | 1 | 5 | 0 | handler GUI |
| `N4_Click` | 346-352 | Public | 1 | 5 | 0 | handler GUI |
| `N5_Click` | 354-360 | Public | 1 | 5 | 0 | handler GUI |
| `Createtable` | 362-374 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button1_Click` | 376-576 | Public | 34 | 186 | 0 | portée réductible ? |
| `Raz` | 578-591 | Public | 1 | 12 | 0 | portée réductible ? |
| `donnees1` | 593-597 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 599-603 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees3` | 605-609 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button3_Click` | 611-615 | Public | 1 | 3 | 0 | portée réductible ? |
| `Modifiee_Click` | 617-621 | Public | 1 | 3 | 0 | handler GUI |
| `Supprimee_Click` | 623-627 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton1_Click` | 629-633 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton2_Click` | 635-639 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et choix de l'exercice

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)`,
  musique, centrage, tri par date (`RadioButton1_Click`), exercice en cours (`E0_click`), focus sur
  la date de début.
- **`Ex1()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (nom en
  dur) ; `dteN0` = premier jour du mois suivant `dteclec` (`Utils.Calc_mois`), `dteN1` = aujourd'hui.
  Si aujourd'hui est antérieur à `dteN0` (comparaison de chaînes `yyyymmdd`), bascule sur `Exo()`
  (bornes de l'exercice en cours). ⚠️ Dans ce cas `dte1`/`dte2` ne sont **pas** remis à jour par
  `Ex1` mais par `exercice(0)` ; sinon `dte1`/`dte2` = `dteN0`/`dteN1` : les contrôles de
  `dteN0_LostFocus` refusent alors toute date avant le premier jour du mois suivant la clôture
  (comportement hérité, à confirmer).
- **`Exo()`, `Exo1()` … `Exo5()`** [portée : réductible] [nature : GUI]. Délèguent à
  `exercice(0..5)`. Simples alias : leurs appels peuvent viser directement `exercice(n)`.
- **`exercice(ind)`** [portée : Private] [nature : mixte]. `Raz()`, lecture de
  `Fiches_Parametres` (nom en dur, sans `Available`), puis bornes `dteN0` = `dteclec<ind+1>` + 1 jour,
  `dteN1` = `dteclec<ind>` (format `LDate.L`). Cas 5 : `dteclec5` - 1 an + 1 jour. Copie
  `dteN0`/`dteN1` dans `dte1`/`dte2`. C'est l'équivalent exact de
  `LDate.Exercice_Cloture(ind+1)` + 1 jour / `LDate.Exercice_Cloture(ind)` (voir LDATE-008).
- **`E0_Click()`, `E1_Click()`, `N1_Click()` … `N5_Click()`** [portée : nécessaire (handlers)]
  [nature : GUI]. Fixent `Tab0` (inutile) et `Tab1` = `Fiches_MvtM<n>` (noms en dur, alors que
  `Cbase` connaît `TabMvtM`…`TabMvtM5`), puis `Ex1`/`Exo<n>`. `E0` et `E1` visent tous deux
  l'exercice en cours ; `E0` part du mois suivant la clôture, `E1` de l'exercice complet.

### Saisie des dates

- **`Cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI]. `Last.tag`
  1 (`DteN0`) + Entrée/Tab → `dteN0_LostFocus`, focus sur `Dten1`. **`Case 4`** : copié de
  `Journaux` (où le tag 4 est `Cpt2`) ; dans ce `.form` aucun contrôle du groupe `Cmpt` n'a le tag
  4 (`Dten1` a le tag 2) : la branche est **morte** et Entrée dans `Dten1` ne fait rien
  (ECRM-A01). F1 → aide.
- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : GUI]. Tag 1 aide,
  3 impression, 4 suppression de `~/tmp/Journaux.pdf` puis fermeture.
- **`dteN0_GotFocus()`, `dteN1_GotFocus()`** [portée : nécessaire (nom de handler)] [nature : GUI].
  Fond vert de saisie. Les contrôles `DteN0`/`Dten1` appartiennent au groupe `Cmpt` : Gambas
  n'émet alors l'événement que sous le nom du groupe (`Cmpt_GotFocus`, absent) ; ces fonctions ne
  sont exécutées que par appel explicite.
- **`dteN0_LostFocus()`** [portée : nécessaire (nom de handler)] [nature : mixte]. Normalise la
  saisie (`Utils.CDate_calc` puis `Cdate_aff`, repli sur aujourd'hui si `"00.00.0:00"`), puis
  compare (chaînes `yyyymmdd` converties par `Val`) à `dte1`/`dte2` ; hors bornes → `Compdate`.
  `Catch` : remet le focus. Appelée uniquement depuis `Cmpt_KeyPress` (pas sur perte de focus).
- **`dteN1_LostFocus()`** [portée : nécessaire (nom de handler)] [nature : mixte]. Même logique
  pour la date de fin, plus le contrôle « fin < début » (`Message.Warning`, retour à `exo()`).
  **Jamais exécutée** : aucun appel explicite et aucun événement (groupe `Cmpt`) — signalée par
  `deps.py` (`handlers_inactifs`). Conséquence : la date de fin saisie n'est ni normalisée ni
  contrôlée (ECRM-A01).
- **`Compdate()`, `compdate2()`** [portée : réductible] [nature : GUI]. Son + `Message.Warning(Txt)`
  ; sur « Ok », retour à l'exercice en cours (`Exo`, `E0.Value = True`) et focus. Corps identiques
  au contrôle près.

### Impression

- **`Createtable()`** [portée : réductible] [nature : calcul]. `DROP TABLE IF EXISTS
  centralisation` puis `CREATE TABLE centralisation(cd_cent, intitule, db_cent, crd_cent, njournal)`
  (`Try`). Copie de `Journaux.Createtable` / `JournauxM.Createtable` ; la table n'est **ni
  alimentée ni lue** par EcrM (code mort SQL). Le même nom est recréé avec une autre structure
  par `Imp_Sig` et `Intjdv` (chacun recrée la table avant usage).
- **`Button1_Click()`** (CC 34) [portée : nécessaire (appelé par `Btn_Click`, nom de handler)]
  [nature : mixte].
  1. `Journaux.Mouse = Mouse.Wait` : agit sur l'**auto-instance du formulaire `Journaux`**, pas sur
     `EcrM` ; la première exécution instancie ce formulaire caché (son `_New` enregistre des
     observateurs et interroge la base) (ECRM-A02).
  2. `Createtable()` ; `SELECT * FROM Fiches_Societes Where cd_sc = &1` ; `Shell "cd …"` inutile ;
     `SELECT * FROM Fiches_Parametres` → `dtepc` ; « ( Edition provisoire ) » si la date de fin
     dépasse `dtepc`. `Datep` est calculé et jamais utilisé.
  3. `SELECT * FROM <Tab1> WHERE dte >= &1 and dte <= &2 [and <Type>] order by <Ordre>`
     (dates par `Utils.Cdate2_Dbase` ; `Type` et `Ordre` concaténés ; deux paramètres
     surnuméraires `False, True`).
  4. Pour chaque ligne : `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1` (une requête par
     ligne) ; compte absent → `Message.Error` et `Return` (curseur de `Journaux` laissé en
     attente, PDF abandonné). Statut `M`/`S` selon `supprimee`. Trait de séparation à chaque
     changement de numéro (`numerodef` en édition définitive, `numero` en provisoire).
     Libellé « Facture »/« Avoir » pour 401/411/453 ; la branche `type_jour = "VE"` est morte.
     Pour 401/411/453, la ligne n'est imprimée que si `datem` n'est pas nul (sinon `posy` avance
     quand même : ligne blanche) ; pour les autres comptes, `Format$(datem)` est appelé même si
     `datem` est nul (ECRM-A04, à confirmer).
  5. Saut de page à `posy > 283` : `BasPage2(ipage)` puis en-tête **toujours** « écritures
     modifiées » quel que soit le filtre (ECRM-A03). `ipage` démarre à 0 : la première page porte
     « Page N° 0 » (ECRM-A05).
  6. Les cumuls `totdeb`, `totcred`, `totsld`, `TotDeb2`, `TotCred2`, `debitcol`, `creditcol`,
     `Ccoll` ne sont jamais imprimés (code mort). `Output`, `Visualiseur.Prog`, curseur de
     `Journaux` remis à `Default`.
  Sans ligne : `Message.Warning("Aucune écriture pour cette sélection !")`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls inutilisés.
- **`donnees1/2/3(...)`** [portée : réductible] [nature : calcul]. Écrivent dans `hFile`, jamais
  ouvert ; aucun appelant (code mort, copiés de `Journaux`).
- **`Button3_Click()`** [portée : nécessaire (appelé par `Btn_Click`)] [nature : GUI].
  `Doc.Open("Editjournaux")` : aide de l'édition des journaux (rubrique héritée de la copie).
- **`Modifiee_Click()`, `Supprimee_Click()`** [portée : nécessaire (handlers)] [nature : GUI].
  Fixent la clause `Type`. « Toutes » (valeur par défaut du `.form`) n'a pas de handler : le filtre
  n'est pas appliqué parce que `Toutes.value` est testé en premier.
- **`RadioButton1_Click()`, `RadioButton2_Click()`** [portée : nécessaire (handlers)] [nature :
  GUI]. Fixent `Ordre`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.CDate_calc`, `Utils.Cdate_aff`,
  `Utils.Cdate2_Dbase` ; `LDate(...).L`, `LDate(...).G`.
- `Start.Son`, `Start.Musique`, `Start.Societe`.
- Auto-instance du formulaire `Journaux` (`Journaux.Mouse`).
- Noms de tables en dur : `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Comptes`,
  `Fiches_Journaux` (affecté, jamais utilisé), `Fiches_Mvt*` (`Tab0`, inutilisé), `Fiches_MvtM*`,
  `centralisation`.
- Fichier `~/tmp/Journaux.pdf` (le même nom que l'édition des journaux : les deux écrans
  s'écrasent mutuellement le fichier).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer `Exo`…`Exo5` par des appels directs `exercice(n)` ; `exercice` lit les bornes via
  `LDate.Exercice_Cloture(n)` (même résultat au format `.L`).
- Handlers d'exercice : un tableau `Cbase.Table("TabMvtM" & suffixe)` au lieu des noms en dur ;
  suppression de `Tab0`.
- `Button1_Click` : sortir la boucle d'impression d'une ligne dans `ImprimeLigne(rResult, …)` ;
  cache local des comptes (une requête par compte distinct au lieu d'une par ligne, SQL modifié,
  dump identique) ; suppression des cumuls jamais imprimés.
- `Compdate`/`compdate2` : une seule fonction paramétrée par le contrôle à refocaliser.

### Commonalisation avec d'autres fichiers

- **Socle commun des éditions comptables** (voir [FTVA](../FTVA.class/architecture.md#commonalisation-avec-dautres-fichiers)) :
  en-tête société, fichier PDF, `Termine`, contrôle de saisie de date (`Cdate_calc` +
  `Cdate_aff` + repli `"00.00.0:00"`, 40 fichiers) et **sélection d'exercice** (helper `Bornes(index)`
  de BALANCE-004, [Balance/rework.md](../Balance.class/rework.md), qui inclut EcrM) : `exercice(ind)`
  d'EcrM est la version factorisée des `Exo`…`Exo5` copiés dans
  [Journaux](../Journaux.class/architecture.md), [JournauxA](../JournauxA.class/architecture.md),
  [Balance](../Balance.class/architecture.md), [Editcompte](../Editcompte.class/architecture.md),
  [EditcompteA](../EditcompteA.class/architecture.md).
- `Createtable` est identique à `Journaux.Createtable` et `JournauxM.Createtable`
  ([JournauxM](../JournauxM.module/architecture.md)) : à supprimer ici (code mort) plutôt qu'à
  partager.
- `donnees1/2/3` : copies mortes de `Journaux`/`JournauxA`/`Balance`.

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Createtable`, `Raz` → `Private` (aucun appel
  externe : `grep -rn "EcrM\." .src` ne trouve que `Fmenu:2433 EcrM.Show()`). `donnees*` sont
  supprimées (code mort).
- Les fonctions nommées comme des handlers (`dteN0_*`, `dteN1_*`, `Button1_Click`,
  `Button3_Click`) restent `Public` (règle PLAN : `ReplayObserver`).

### Séparation traitement / GUI

- Fonction pure `Bornes_Exercice(ind) As String[]` (dates de début/fin `.L`), utilisée par
  `exercice` pour remplir les contrôles.
- Fonction pure `Date_Hors_Periode(sDate, sDebut, sFin) As Integer` (-1/0/1) pour les contrôles de
  `dteN0_LostFocus`/`dteN1_LostFocus`.
- Fonction `Requete_Modifs(sTable, sDebut, sFin, sType, sOrdre) As Result` isolant le SQL de
  `Button1_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les six tables `Fiches_MvtM*` (une par exercice) obligent à choisir la table selon l'exercice ;
  une table unique avec une colonne d'exercice, ou une vue `UNION`, simplifierait l'écran.
- `centralisation` (table de travail au schéma variable selon l'écran qui la crée) devrait être
  une table temporaire propre à chaque traitement.
- Un index `(dte)` sur `Fiches_MvtM*` accélérerait le filtre de dates.
