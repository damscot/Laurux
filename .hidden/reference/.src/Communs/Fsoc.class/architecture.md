# Fsoc — Architecture

> Source : `.src/Communs/Fsoc.class`

## Vue d'ensemble

`Fsoc` est l'écran **« Gestion des sociétés »** : il liste les sociétés trouvées dans les bases
MySQL du serveur (une base `Laurux<XX>` ou `<préfixe>_Laurux<XX>` par société), affiche la fiche
`Fiches_Societes` de la société sélectionnée et permet de la **créer ou modifier**, de la
**supprimer** (`DROP DATABASE`), de la **dupliquer** (écran `Dup`), et de **changer de société de
travail** (reconnexion de `Utils.db`, réécriture de `Laurux.conf`, puis redémarrage ou fermeture
de Laurux).

Instanciation : `New Fsoc(Me)` depuis `Fmenu.Menu26_Click` (le paramètre `hform` est la fenêtre
principale, fermée lors d'un changement de société). `Prgm.class:81` appelle `Fsoc.ShowModal()`
sans argument : voir l'anomalie FSOC-A06.

Le fichier est **presque entièrement GUI** : le SQL (lecture/écriture de `Fiches_Societes`,
`Fiches_Identite`, `DROP DATABASE`) est directement mêlé aux contrôles. Il dépend fortement du
dialecte **MySQL** (`Utils.db.Databases`, requêtes inter-bases `Laurux<XX>.Fiches_Societes`,
`Shell mysql`, `ALTER DATABASE … COLLATE`) : rien n'est prévu pour SQLite.

Contrôles du `.form` : 20 champs du groupe `Soc` (`Code` tag 1, `Civilite` 2, `Intitule` 3,
`Libre` 3, `Adr1` 4 … `Fax` 17, `Site` 18, `Banque` 19, `Bic` 20 ; `tel` 15, `Port` 16), 6 boutons
du groupe `Btn` (tags 1 à 6), la liste `Soclist` (ColumnView 3 colonnes : code, « type intitulé »,
nom de base masqué).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 30 |
| `Soc` | var | Private |  | String | 31 |
| `Soc1` | var | Private |  | String | 32 |
| `s` | var | Private |  | Integer | 33 |
| `son` | var | Private |  | Integer | 34 |
| `testerTVA` | var | Private |  | Boolean | 35 |
| `cs` | var | Private |  | String | 36 |
| `Lig` | var | Private |  | String | 37 |
| `chkNbase` | var | Private |  | Boolean | 38 |
| `$hform` | var | Private |  | Form | 39 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 41-60 | Public | 1 | 18 | 0 | méthode spéciale |
| `Recup_Soc` | 62-72 | Public | 4 | 9 | 0 | portée réductible ? |
| `Form_Open` | 74-82 | Public | 2 | 6 | 0 | handler GUI |
| `Init_base` | 84-135 | Public | 17 | 49 | 0 | portée réductible ? |
| `Init_Civilite` | 137-153 | Public | 4 | 13 | 0 | portée réductible ? |
| `Nsoc` | 155-162 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Zones` | 164-199 | Public | 5 | 32 | 0 | portée réductible ? |
| `cleanChamps` | 201-225 | Public | 1 | 23 | 0 | portée réductible ? |
| `Refresh` | 227-235 | Public | 1 | 7 | 0 | portée réductible ? |
| `Soc_KeyPress` | 237-377 | Public | 30 | 110 | 0 | handler GUI |
| `Btn_Click` | 379-413 | Public | 9 | 26 | 0 | handler GUI |
| `Soc_GotFocus` | 418-424 | Public | 1 | 5 | 0 | handler GUI |
| `Soc_LostFocus` | 426-433 | Public | 3 | 6 | 0 | handler GUI |
| `code_LostFocus` | 435-447 | Public | 3 | 10 | 0 | portée réductible ? |
| `Button1_Click` | 449-511 | Public | 14 | 60 | 0 | portée réductible ? |
| `Button3_Click` | 513-548 | Public | 5 | 31 | 0 | portée réductible ? |
| `Button4_Click` | 550-585 | Public | 6 | 33 | 0 | portée réductible ? |
| `Button5_Click` | 587-591 | Public | 1 | 3 | 0 | portée réductible ? |
| `Nbase_MouseDown` | 593-598 | Public | 2 | 4 | 0 | portée réductible ? |
| `Soclist_Click` | 600-630 | Public | 3 | 28 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et chargement

- **`_New(hform As Form)`** [portée : nécessaire (constructeur)] [nature : GUI]. Mémorise `hform`,
  enregistre les observateurs (`Utils.Observers`), charge la musique, affiche le SIRET configuré
  (`/Soc<XX>/Siret`) dans `Label11`, prépare les colonnes de `Soclist`, puis `Init_base`,
  `Init_Civilite`, `Recup_Soc`.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. `Maj_Zones` puis focus sur
  `Code`. Aussi appelé directement par `Button1_Click`. `Catch` → `Message.Error`.
- **`Init_base()`** [portée : réductible] [nature : mixte]. Parcourt `Utils.db.Databases` et retient
  les bases Laurux : avec `/Soc<XX>/Prefixe`, un nom `x_Laurux…` (exactement un `_`) ; sinon un nom
  commençant par `Laurux` de plus de 6 caractères. Pour chaque base retenue :
  `SELECT * FROM <base>.Fiches_Societes` (avec préfixe) ou `… WHERE cd_sc = &1` avec le suffixe du
  nom (sans préfixe) ; ajoute **la première ligne** dans `Soclist` (`Try` : un code déjà présent est
  ignoré). Tables : `Fiches_Societes` de **chaque** base (nom en dur, pas de `Cbase.Table`).
  `Catch` → `Message.Warning`. Partie extractible : la détection des bases (liste de noms), commune
  avec [`LauruxConf._new`](../LauruxConf.class/architecture.md) et `Dup`.
- **`Init_Civilite()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Identite`
  (nom en dur ; `Cbase.Table("TabIdentite")` existe) → `Civilite` (première entrée vide `"  "`,
  clé `"00"`). `Catch` vide.
- **`Recup_Soc()`** [portée : réductible] [nature : GUI]. Sélectionne dans `Soclist` la ligne de
  `Start.Societe` ; à défaut la **dernière** ligne reste sélectionnée. Liste vide : l'erreur est
  interceptée par `Catch` → `Me.Close` (fermeture silencieuse, FSOC-A09).
- **`Refresh()`** [portée : réductible] [nature : GUI]. Recharge tout (`Init_base`, `Init_Civilite`,
  `Recup_Soc`, `Maj_Zones`) ; appelé après la duplication (`Btn` tag 6).
- **`Maj_Zones()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Societes WHERE
  cd_sc = &1` sur la **connexion courante** avec le code de la ligne courante de `Soclist`, puis
  remplit les 21 champs. Si la ligne sélectionnée appartient à une autre base, aucune ligne n'est
  trouvée et les champs gardent leur valeur. Partie extractible : la lecture de la fiche.
- **`cleanChamps()`** [portée : réductible] [nature : GUI]. Vide les 21 champs.
- **`Nsoc(numero)`** [portée : réductible] [nature : calcul] — **code mort** : aucun appel ; copie
  exacte de `Utils.Nsoc` (lui-même mort, voir [`Utils.module`](../../Utils/Utils.module/architecture.md)).

### Saisie et navigation

- **`Soc_KeyPress()`** (CC 30, max du fichier) [portée : nécessaire (handler du groupe `Soc`)]
  [nature : GUI]. Entrée/Retour/Tab : passe au champ suivant selon `Last.Tag` (tags 2 à 19) et
  `Stop Event`. Cas particuliers :
  - tag 1 (`Code`) : `code_LostFocus` ; si le code est invalide (`s = 1`), reste sur `Code` ;
  - tag 11 (`Siret`) : calcule `Tvaintra = "FR" & CTestTVA.CleTVAIntra(siren) & siren` (siren = 9
    premiers caractères du SIRET sans espaces, en majuscules) ; clé sur un seul chiffre si < 10
    (voir `CTESTTVA-A01`) ;
  - tag 12 (`Tvaintra`) : `CTestTVA.isIntraComValide` ; si **invalide**, avertissement puis focus sur
    `Capital` ; si **valide**, aucun déplacement (FSOC-A04). Mémorise le résultat dans `testerTVA`.
  - tag 20 (`Bic`) : aucun cas → comportement par défaut de la touche.
  F1 : aide (`Button5_Click`).
- **`Soc_GotFocus()`** [portée : nécessaire (handler)] [nature : GUI]. `Utils.SetEditColor`.
- **`Soc_LostFocus()`** [portée : nécessaire (handler)] [nature : GUI]. Tag 8 (`Email`) :
  `Utils.chkEmail`.
- **`code_LostFocus()`** [portée : nécessaire (handler de `Code`)] [nature : GUI]. Code de longueur
  ≠ 2 → son + avertissement et `s = 1`. ⚠️ `s` n'est jamais remis à 0 par une saisie correcte
  (seulement par le cas tag 1 de `Soc_KeyPress`).
- **`Nbase_MouseDown()`** [portée : réductible] [nature : GUI] — **code mort** : aucun contrôle
  `Nbase` dans `Fsoc.form` (vestige copié de `LauruxConf`). Écrit `chkNbase` et `Soc1`, jamais lus.

### Boutons

- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : GUI]. Aiguillage par
  tag : 1 aide, 2 nouveau (vide les champs), 3 suppression, 4 enregistrement, 5 fermer, 6 duplication
  (`MDP` si `/Soc<XX>/Admin`, puis `Dup.ShowModal`, puis `Refresh`).
- **`Button1_Click()`** (enregistrer) [portée : nécessaire (handler, appelé aussi par `Btn_Click`)]
  [nature : mixte]. Cherche une base nommée exactement `Laurux<code>` (**sans préfixe**) ; absente →
  `LauruxConf.Createbase("Laurux" & code)` (question à l'utilisateur, création et remplissage avec
  `Laurux01.sql`). Puis, sur `Laurux<code>.Fiches_Societes` : `SELECT *` ; si non vide `TRUNCATE` ;
  puis `INSERT` des 21 champs (paramètres `&1` à `&{21}`). Enfin `Init_base`, écrit `/Soc`,
  `/intitule`, `/dbase/Name` (= `/dbase/Prefixe` & `Laurux<code>`), `Save`/`Reload`,
  `Start.Societe`, titre de `Fmenu`. Si `testerTVA`, relance `Form_Open`. `Catch` → son +
  `Message.Error`, `s = 1`. Variable `siren` calculée mais inutilisée. **Ne reconnecte pas**
  `Utils.db` : la connexion reste sur l'ancienne base alors que `Start.Societe` change.
- **`Button3_Click()`** (supprimer) [portée : nécessaire] [nature : mixte]. Confirmation puis
  `DROP DATABASE Laurux<code>` (sans préfixe). Le test `If Not Error` suit un `Exec` sans `Try` :
  une erreur part dans le `Catch`, la branche « Suppression impossible » est inatteignable. Message
  « Société  supprimée » : la variable `Tables` n'est jamais affectée. Remet à vide les clés
  `Soc` (sans `/`), `/Societes/Soc`, `/Societes/intitule` (clés différentes de `/Soc` et
  `/intitule` utilisées ailleurs, FSOC-A02).
- **`Button4_Click()`** — **code mort** [portée : sans objet] [nature : mixte]. Le bouton `Button4`
  (« Créer », `Tag = "2"`) appartient au groupe d'événements `Btn` du `.form` : Gambas n'appelle que
  `Btn_Click`, qui traite le tag 2 par `cleanChamps()` + `Code.SetFocus`. `Button4_Click` n'est
  appelé nulle part (vérifié par `grep`, signalé par `deps.py` comme handler nominal inactif).
  Ancienne sélection de société, remplacée par `Soclist_Click`. Contenu : avertissement (avec
  `Soc` **avant** son affectation), écrit `/Soc`, `/intitule`, `/dbase/Name`, puis
  reconnecte `Utils.db` sur `Laurux<code>` (sans préfixe), `SET NAMES 'utf8mb4'`,
  `Shell mysql … SET @@global.sql_mode = NO_ENGINE_SUBSTITUTION` (mot de passe en clair dans la
  ligne de commande, port et tunnel SSH ignorés), `ALTER DATABASE … DEFAULT COLLATE
  utf8mb4_unicode_ci`, `SET NAMES … COLLATE`. `Start.UnLock`, ferme l'écran et la fenêtre
  principale (fin de Laurux).
- **`Button5_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Societes")`.
- **`Soclist_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Si la société cliquée
  n'est pas la société courante : même séquence de reconnexion que l'ancien `Button4_Click` (code mort) mais sur le nom
  de base complet de la colonne 2 (préfixe compris), `Maj_Zones`, écriture de la configuration,
  message, fermeture de l'écran et de `hform`, puis **`Start.Main()`** (relance du programme dans
  la même pile d'appels). Sinon `Maj_Zones`.

## État global utilisé

- `Start.LocalSettings` : lecture `/Soc<XX>/Siret`, `/Soc<XX>/Prefixe`, `/Soc<XX>/Admin`,
  `/dbase/Prefixe`, `/dbase/Host` ; écriture `/Soc`, `/intitule`, `/dbase/Name`, `Soc`,
  `/Societes/Soc`, `/Societes/intitule`.
- `Start.Societe` (lu et écrit), `Start.Son`, `Start.Musique`, `Start.Motdepasse`, `Start.UnLock`,
  `Start.MainWindow`, `Start.Main`.
- `Utils.db` : `Databases`, `Exec`, `Close`/`Open`, `Name`, `Login`, `Password`.
- `Fmenu.Text` (auto-instance de la fenêtre principale), `Syntheses.Message`, `Dup`, `MDP`, `Doc`.
- Variables d'instance utilisées comme variables locales : `Tab`, `Lig`, `cs`, `Soc`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Soc_KeyPress` : remplacer les 16 cas « focus sur le champ suivant » par une table
  `tag → contrôle suivant` (tableau d'objets construit dans `_New`), en gardant les cas 1, 11 et 12
  à part et `Stop Event` partout où il existe aujourd'hui (CC 30 → environ 8).
- Regrouper l'écriture « société de travail » (`/Soc`, `/intitule`, `/dbase/Name`, `Save`, `Reload`,
  `Start.Societe`) répétée dans `Button1_Click` et `Soclist_Click` (après suppression de `Button4_Click`, FSOC-011) dans un helper
  privé `ChoisirSociete(sCode, sIntitule, sBase)`.
- `Tab`, `Lig`, `cs`, `Soc` : variables locales ; `Tab` remplacé par `Cbase.Table("TabSoc")`.
- `Nsoc`, `Nbase_MouseDown`, `Button4_Click`, `Soc1`, `chkNbase`, `siren` (dans `Button1_Click`) : code mort.

### Commonalisation avec d'autres fichiers

- **Détection des bases Laurux** : `Init_base` (l. 93-112), [`LauruxConf._new`](../LauruxConf.class/architecture.md)
  (l. 58-87), `Button1_Click` (l. 461-473) et `Compta/Utils/Dup.class` (l. 82) parcourent
  `Utils.db.Databases` avec des règles proches mais différentes. Helper commun
  `Utils.BasesLaurux(bPrefixe As Boolean) As String[]` ; chaque appelant garde sa règle actuelle
  (paramètre) pour ne pas changer de comportement.
- **Séquence de reconnexion MySQL** (`Close`, `Name`, `Open`, `SET NAMES`, `Shell mysql …
  sql_mode`, `ALTER DATABASE … COLLATE`, `SET NAMES … COLLATE`) : `Soclist_Click`,
  [`LauruxConf.Button1_Click`](../LauruxConf.class/architecture.md) (l. 274-280) et `Fmenu.class:175`.
  Helper commun `Utils.OuvreBase(sNom)`, même ordre d'instructions. Le `Shell mysql` utilise la
  ligne de commande MySQL commune proposée par `UTILS-014` ([`Utils.module`](../../Utils/Utils.module/architecture.md)).
- **Nettoyage du SIREN** (l. 305-306 et 317-318) : propre à `Fsoc` ; `FFournisseur` (l. 650-660) ne fait
  qu'appeler `CTestTVA.isIntraComValide` (corrigé après le lot Gestion).
  Helper `CTestTVA.Siren(sSiret)` (voir [`CTestTVA`](../../Utils/CTestTVA.class/architecture.md)).
- **Création de base** : déléguée à [`LauruxConf.Createbase`](../LauruxConf.class/architecture.md),
  qui dépend des contrôles de l'écran de configuration (voir LAURUXCONF-007).

### Réduction de portée

- `Recup_Soc`, `Init_base`, `Init_Civilite`, `Maj_Zones`, `cleanChamps`, `Refresh` : aucun appel
  externe (vérifié par `grep` ; `Fmenu` ne fait que `New Fsoc(Me)` + `Show`) → `Private`.
  Couverture par les replays FSOC-T01 à T06.
- `Nsoc`, `Nbase_MouseDown` : suppression (code mort) plutôt que réduction.

### Séparation traitement / GUI

- `Button1_Click` : extraire `EnregistreSociete(sBase, aValeurs As String[])` (SELECT, TRUNCATE,
  INSERT) sans accès aux contrôles.
- `Maj_Zones` : extraire `LitSociete(sCode) As Result` ; `Init_base` : extraire la liste
  `(base, code, libellé)` ; `Button3_Click` : extraire `SupprimeBase(sBase)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table centrale des sociétés (base commune) éviterait le balayage de toutes les bases du
  serveur et les requêtes inter-bases `Laurux<XX>.Fiches_Societes`.
- `Fiches_Societes` ne contient qu'une ligne par base : `cd_sc` pourrait devenir une clé primaire
  avec contrainte d'unicité, rendant inutile le `TRUNCATE` + `INSERT` (remplacé par un `REPLACE`).
