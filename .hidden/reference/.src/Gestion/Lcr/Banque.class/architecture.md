# Banque — Architecture

> Source : `.src/Gestion/Lcr/Banque.class`

## Vue d'ensemble

Écran **« Banque »** (menu Tables, `Fmenu.MenuTbq_Click`) : fichier des banques de remise des LCR,
table `Fiches_Banques` (clé `banques_code`, un chiffre 1 à 9 imposé par `code.reg = "[1-9]{1}"`).
Il gère les coordonnées utilisées par le fichier bancaire et le bordereau de
[`Bordrx`](../Bordrx.class/architecture.md) : n° émetteur (`banques_nume`), code banque, code
guichet, n° de compte, SIREN, référence de remise, référence tireur, option d'impression des
adresses (`banques_adr` : `N`/`O`/`C`), fin d'enregistrement (`banques_fenrg` : vide, `$0D0A$`,
`Ws`), adresse mail de la banque, et des textes (`banques_txt`, `banques_entete`,
`banques_corps`).

Structure classique « liste + fiche » : grille virtuelle `ColBanque` (`Utils.Base` +
`ColBanque_Data`), en-têtes cliquables `CO`/`Inte` pour trier et filtrer par saisie au clavier,
onglets de saisie, boutons du groupe `Btn` (Tag 1 doc, 2 supprimer, 3 valider, 4 quitter), zones
du groupe `Cmpt`.

L'écran n'appelle **pas** `Utils.Observers(Me)` : il n'est pas rejouable en l'état.

Nature : écran **mixte** (SQL directement dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 28 |
| `tab` | var | Private |  | String | 29 |
| `sel` | var | Private |  | String | 30 |
| `Lcrtable` | var | Private |  | New String[2] | 31 |
| `B` | var | Private |  | Integer | 32 |
| `son` | var | Private |  | Integer | 33 |
| `sKey` | var | Private |  | String | 34 |
| `Dbl` | var | Private |  | String | 35 |
| `CoulZns` | var | Private |  | Integer | 36 |
| `CoulZnaf` | var | Private |  | Integer | 37 |
| `Coulfc` | var | Private |  | Integer | 38 |
| `nv` | var | Private |  | Boolean | 39 |
| `ComboTest` | var | Private |  | Boolean | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-66 | Public | 2 | 22 | 0 | méthode spéciale |
| `Form_Open` | 68-77 | Public | 1 | 8 | 0 | handler GUI |
| `ColBanque_Data` | 79-88 | Public | 2 | 8 | 0 | handler GUI |
| `Tris` | 90-98 | Public | 1 | 7 | 0 | portée réductible ? |
| `Deb2` | 100-104 | Public | 1 | 3 | 0 | portée réductible ? |
| `Deb3` | 106-110 | Public | 1 | 3 | 0 | portée réductible ? |
| `Maj_Zones` | 112-140 | Public | 3 | 26 | 0 | portée réductible ? |
| `Refresh` | 142-146 | Public | 1 | 3 | 0 | portée réductible ? |
| `CleanChamps` | 148-167 | Public | 1 | 18 | 0 | portée réductible ? |
| `Colbanque_Click` | 169-183 | Public | 3 | 13 | 0 | handler GUI |
| `Btn_keyPress` | 185-202 | Public | 5 | 15 | 0 | handler GUI |
| `Dsg_GotFocus` | 204-212 | Public | 2 | 6 | 0 | handler GUI |
| `TabStrip1_Click` | 213-217 | Public | 1 | 3 | 0 | handler GUI |
| `Btn_Click` | 218-237 | Public | 5 | 14 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 239-260 | Public | 6 | 18 | 0 | handler GUI |
| `code_LF` | 262-270 | Public | 2 | 7 | 0 | portée réductible ? |
| `Co_GotFocus` | 272-277 | Public | 1 | 4 | 0 | handler GUI |
| `Co_LostFocus` | 279-283 | Public | 1 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 285-290 | Public | 1 | 4 | 0 | handler GUI |
| `Inte_LostFocus` | 292-296 | Public | 1 | 3 | 0 | handler GUI |
| `Dbclk` | 298-308 | Public | 2 | 9 | 0 | portée réductible ? |
| `Co_Click` | 310-320 | Public | 1 | 9 | 0 | handler GUI |
| `Co_Dblclick` | 322-331 | Public | 1 | 8 | 0 | handler GUI |
| `Co_KeyPress` | 333-345 | Public | 4 | 11 | 0 | handler GUI |
| `Inte_Click` | 347-357 | Public | 1 | 9 | 0 | handler GUI |
| `Inte_Dblclick` | 359-368 | Public | 1 | 8 | 0 | handler GUI |
| `Inte_KeyPress` | 370-383 | Public | 5 | 12 | 0 | handler GUI |
| `Ref` | 385-391 | Public | 1 | 5 | 0 | portée réductible ? |
| `banques_man` | 396-409 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button3_Click` | 414-427 | Public | 3 | 12 | 0 | portée réductible ? |
| `Button4_Click` | 432-472 | Public | 8 | 38 | 0 | portée réductible ? |
| `Button7_Click` | 477-481 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et liste

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI] : couleurs du thème, fond selon
  `/Soc<XX>/Coul_fen`, musique, titres des en-têtes, regex du code, `Chainage` de 11 zones.
- **`Form_Open()`** [événement] [nature : mixte] : `Tab = "Fiches_Banques"` (inutilisé), tri par
  code, `Tris()`, `Deb2()`, focus sur le code.
- **`ColBanque_Data(Row, Column)`** [événement] [nature : GUI] : lit `Utils.rs1` (résultat partagé
  rempli par `Utils.Base`) ; colonnes `banques_code`, `banques_nom`.
- **`Tris()`** [portée : réductible] [GUI] : 2 colonnes alignées sur les en-têtes.
- **`Deb2()` / `Deb3()`** [portée : réductible] [nature : mixte] :
  `select * from Fiches_Banques where <Tri> like "<sel>%" order by <Tri> [Desc]` via `Utils.Base`.
  `sel` (frappe au clavier) est **concaténé** entre guillemets doubles : une saisie contenant `"`
  casse la requête (erreur affichée par `DB_Connection.Exec`).
- **`Dbclk()`** [portée : réductible] : alterne tri ascendant (`Deb2`) / descendant (`Deb3`).
- **`Co_Click`, `Co_Dblclick`, `Inte_Click`, `Inte_Dblclick`** [événements] : réinitialisent `sel`,
  `Ref()`, choisissent la colonne de tri, puis `Deb2`/`Dbclk`.
- **`Co_KeyPress`, `Inte_KeyPress`** [événements] : ajoutent la touche à `sel` (retour arrière :
  retire un caractère) puis `Deb2`. `Inte_KeyPress` a un `Catch` vide, pas `Co_KeyPress`.
- **`Co_GotFocus`, `Inte_GotFocus`** [événements] : couleur de focus puis `Co_Click`/`Inte_Click`.
  **`Co_LostFocus`, `Inte_LostFocus`** : `Utils.ObsLstf`.
- **`Ref()`** [portée : réductible] : tri par code, `CleanChamps`, `Tris`.

### Fiche

- **`Colbanque_Click()`** [événement, `replay_dynamic` : doit rester `Public`] [nature : GUI] :
  `CleanChamps`, `Maj_Zones` si la ligne a un code, `nv = False`. `Catch` → focus sur le code.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : `select * from Fiches_Banques where
  banques_code = &1` et remplissage des 15 zones.
- **`CleanChamps()`** [portée : réductible] [GUI] : vide les 16 zones.
- **`Cmpt_Lostfocus()`** [événement du groupe `Cmpt`] : Tag 1 (code) : si `nv` et code non vide,
  `code_LF` ; Tag 2 (raison sociale) : `Utils.Remplace`. `nv` repasse à `False` après la
  première sélection et n'est jamais remis à `True` (le chargement automatique d'une fiche par
  saisie du code ne fonctionne qu'avant la première sélection).
- **`code_LF()`** [portée : réductible] : `banques_man()` si le code est non vide, sinon `B = 1`.
  Comme l'appelant teste déjà un code non vide, `B` ne vaut jamais 1 : le test `b <> 1` de
  `Button4_Click` est toujours vrai (logique morte).
- **`banques_man()`** [portée : réductible] [nature : mixte] : relit la banque et appelle
  `Maj_Zones` (deuxième lecture identique de la même ligne).

### Boutons (groupe `Btn`)

- **`Btn_Click()`** [événement] : Tag 1 → `Button7_Click` (doc), 2 → `Button3_Click`
  (suppression), 3 → focus sur `Dsg1` puis `Button4_Click` (validation), 4 → `Me.Close`.
- **`Btn_keyPress()`** [événement] : Entrée sur Tag 3 → `Button4_Click` ; F1 → doc. Un double
  enregistrement (KeyPress + Click du bouton) est possible : à confirmer en phase 2.
- **`Button3_Click()`** [pseudo-handler, appelé par `Btn_Click` ; portée réductible] [nature :
  mixte] : confirmation, `DELETE FROM Fiches_Banques WHERE banques_code = &1`, rafraîchissement.
  Aucune vérification des LCR (`Fiches_Lcr.banque`) ni des bordereaux qui référencent la banque.
- **`Button4_Click()`** [pseudo-handler ; portée réductible] [nature : mixte] (CC 8, max) :
  `Utils.Remplace` sur la raison sociale ; code vide → message ; sinon `INSERT` (16 colonnes) si
  le code n'existe pas, `UPdate` sinon. Après insertion, la boucle de resélection compare la
  colonne **1** (nom) au **code** : la nouvelle ligne n'est jamais sélectionnée. Message
  « VOUS DEVEZ D'ABORD REMPLIR… » par `Message(...)` (pas `Message.Error`).
- **`Button7_Click()`** [pseudo-handler ; portée réductible] : `Doc.Open("Banques")`.

### Divers

- **`Dsg_GotFocus()`** [événement du groupe `Dsg`] : Tag 1 → `Button4_Click`. `Dsg1` est un
  `TextLabel` invisible ; la levée de `GotFocus` sur ce contrôle est à confirmer (sinon code mort,
  sinon double enregistrement après `Btn_Click` Tag 3).
- **`TabStrip1_Click()`** [événement] : `Print "ok"` (trace de débogage sur la sortie standard).

## État global utilisé

- `Start.LocalSettings` (`/Coul/*`, `/Soc<XX>/Coul_fen`), `Start.Son`, `Start.Musique`,
  `Start.Societe`.
- `Utils.Base`/`Utils.rs1` (résultat partagé de la grille), `Utils.db`, `Utils.FColr`,
  `Utils.Remplace`, `Utils.ObsLstf`, `Doc.Open`.
- Table `Fiches_Banques` en dur (pas de clé `Cbase`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la double lecture `banques_man` → `Maj_Zones` (une seule requête).
- Supprimer la logique morte `B`/`code_LF` (le test est toujours vrai).
- `Deb2`/`Deb3` : un seul `Deb(ordre)`.

### Commonalisation avec d'autres fichiers

- Le motif « grille virtuelle + en-têtes cliquables `CO`/`Inte` + `sel` + `Dbclk` » est celui de
  nombreuses tables de référence (`Gestion/Tables`, `Compta/Tables`) ; un composant commun est hors
  périmètre (contrôles du `.form`), mais les fonctions `Dbclk`/`Co_KeyPress`/`Inte_KeyPress`
  pourraient s'appuyer sur un helper de filtre partagé.
- La liste « code - nom » des banques est reconstruite dans [`Glcr`](../Glcr.class/architecture.md),
  [`Attribution`](../Attribution.class/architecture.md) et
  [`Preparation`](../Preparation.class/architecture.md) : une fonction statique
  `Banque.Liste(combo)` ou un module LCR commun la centraliserait (la classe `Banque` étant une
  `Form`, un module est préférable).

### Réduction de portée

- `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`, `CleanChamps`, `code_LF`, `Dbclk`, `Ref`,
  `banques_man` et les pseudo-handlers `Button3_Click`, `Button4_Click`, `Button7_Click` (contrôles
  du groupe `Btn`, appelés seulement par `Btn_Click`/`Btn_keyPress`/`Dsg_GotFocus`) → `Private`.
  Vérifié par `grep -rn "Banque\." .src` : aucun appel externe.
- `Colbanque_Click` reste `Public` (rejeu dynamique) ainsi que tous les handlers réels.

### Séparation traitement / GUI

- Extraire `Enregistre(valeurs) As Boolean` (INSERT/UPDATE) et `Supprime(code)` de
  `Button4_Click`/`Button3_Click`, et `Lit(code) As Result` de `Maj_Zones`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `banques_code` limité à un chiffre (`int(2)` en base, mais `Left$(…, 1)` partout dans le lot LCR) :
  passer à un code plus long imposerait de revoir toutes les extractions `Left$(BQ.Text, 1)`.
- Clé étrangère `Fiches_Lcr.banque` / `Fiches_Bordereaux.banque` → `Fiches_Banques.banques_code`
  pour empêcher la suppression d'une banque utilisée.
- Ajouter une clé `Cbase` (`TabBanques`) et l'utiliser partout (corrige aussi CBASE-A01).
