# Eticli — Architecture

> Source : `.src/Gestion/Etiquettes/Eticli.class`

## Vue d'ensemble

Écran d'impression des **étiquettes adresse clients** (planche A4 : raison sociale + nom + prénom,
deux lignes d'adresse, code postal + ville). Ouverture : `Fmenu.Menu163_Click` (`Eticli.show`,
auto-instance non modale).

Deux modes :
- **plage** : codes clients `client1`–`client2` (défaut `41100001`–`4119999999`), filtre optionnel
  par type client (`CheckType`, bornes `Type`/`Type2`, liste `Fiches_Typec`), tri par code
  (`RadioButton1`), par type (`RadioButton2`, visible si `CheckType`) ou par code postal
  (`RadioButton3`, visible si `CheckCp`) ; les bornes de code postal `Cp1`/`Cp2` sont saisies mais
  **jamais utilisées** dans la requête (ETICLI-A01) ;
- **liste** (`Liste`) : table de travail **temporaire** `Etiquettes(code, nombre)` (même nom que
  pour les articles), alimentée par `Cli_Man`, codes affichés dans `ListCli`.

Sortie : `~/tmp/EtiqCli.pdf` (même nom que l'impression d'étiquettes de `FClient`), toujours en
`CEtiquettes("Portrait", "mm", "A4")` quel que soit le format de page du modèle, ouverte par
`Visualiseur.Prog`. `pos_Etiq` variante **V1** (identique à `Etiqart.pos_Etiq`).

Les grilles de sélection des clients (`Colcli`, `Colcli2`) sont des `GridView` alimentées par
`Utils.Base` sur le résultat global `Utils.rs1` (partagé avec d'autres écrans).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Tab2` | var | Private |  | String | 29 |
| `rCli` | var | Private |  | Result | 30 |
| `rCli2` | var | Private |  | Result | 31 |
| `son` | var | Private |  | Integer | 32 |
| `Nbetiq` | var | Private |  | Integer | 33 |
| `txtPosX` | var | Private |  | Integer | 34 |
| `txtPosY` | var | Private |  | Integer | 35 |
| `txtWidth` | var | Private |  | Integer | 36 |
| `SorP` | var | Private |  | Boolean | 37 |
| `CoulZns` | var | Private |  | Integer | 38 |
| `CoulZnaf` | var | Private |  | Integer | 39 |
| `CoulFoc` | var | Private |  | Integer | 40 |
| `i2` | var | Private |  | Integer | 41 |
| `Nblargeur` | var | Private |  | String | 42 |
| `Nbhauteur` | var | Private |  | String | 43 |
| `Largeur` | var | Private |  | Integer | 44 |
| `Hauteur` | var | Private |  | Integer | 45 |
| `Mrghaut` | var | Private |  | Integer | 46 |
| `Mrgauche` | var | Private |  | Integer | 47 |
| `Esplargeur` | var | Private |  | Integer | 48 |
| `Esphauteur` | var | Private |  | Integer | 49 |
| `Clitable` | var | Private |  | New String[3] | 50 |
| `Sens` | var | Private |  | String | 51 |
| `Tri` | var | Private |  | String | 52 |
| `Nbre` | var | Private |  | Integer | 53 |
| `Nom` | var | Private |  | String | 54 |
| `nombretiq` | var | Private |  | Integer | 55 |
| `Filename` | var | Private |  | String | 56 |
| `pdf` | var | Private |  | Cetiquettes | 57 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 59-93 | Public | 3 | 31 | 0 | méthode spéciale |
| `init_ComboBox` | 95-110 | Public | 5 | 13 | 0 | portée réductible ? |
| `CheckType_Click` | 112-123 | Public | 3 | 10 | 0 | handler GUI |
| `CheckCp_Click` | 125-136 | Public | 3 | 10 | 0 | handler GUI |
| `Tris` | 139-149 | Public | 1 | 9 | 0 | portée réductible ? |
| `Tris2` | 151-161 | Public | 1 | 9 | 0 | portée réductible ? |
| `Colcli_Data` | 163-173 | Public | 3 | 8 | 0 | handler GUI |
| `Colcli2_Data` | 175-185 | Public | 3 | 8 | 0 | handler GUI |
| `Colcli_ColumnClick` | 187-196 | Public | 1 | 7 | 0 | handler GUI |
| `Colcli2_ColumnClick` | 198-207 | Public | 1 | 7 | 0 | handler GUI |
| `colinit` | 209-227 | Public | 4 | 17 | 0 | portée réductible ? |
| `AffClients` | 232-242 | Public | 1 | 8 | 0 | portée réductible ? |
| `AffClients2` | 247-257 | Public | 1 | 8 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 262-278 | Public | 2 | 14 | 0 | handler GUI |
| `ColCli_Click` | 283-296 | Public | 2 | 12 | 0 | handler GUI |
| `Cli_Man` | 301-325 | Public | 6 | 22 | 0 | portée réductible ? |
| `ColCli_KeyPress` | 330-351 | Public | 7 | 18 | 0 | handler GUI |
| `ToggleButton2_Click` | 356-372 | Public | 2 | 14 | 0 | handler GUI |
| `ColCli2_KeyPress` | 377-398 | Public | 7 | 18 | 0 | handler GUI |
| `ColCli2_Click` | 403-411 | Public | 1 | 7 | 0 | handler GUI |
| `ToggleButton3_Click` | 417-449 | Public | 5 | 30 | 0 | handler GUI |
| `ColType_KeyPress` | 454-474 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 479-511 | Public | 5 | 30 | 0 | handler GUI |
| `ColType2_KeyPress` | 516-536 | Public | 6 | 17 | 0 | handler GUI |
| `ColType_Click` | 541-549 | Public | 1 | 7 | 0 | handler GUI |
| `ColType2_Click` | 554-562 | Public | 1 | 7 | 0 | handler GUI |
| `Btn_Click` | 564-580 | Public | 5 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 582-589 | Public | 2 | 6 | 0 | handler GUI |
| `liste_Click` | 591-617 | Public | 2 | 25 | 0 | handler GUI |
| `ChkInput` | 619-627 | Public | 7 | 7 | 0 | portée réductible ? |
| `Etiq_KeyPress` | 629-734 | Public | 30 | 88 | 0 | handler GUI |
| `Button2_Click` | 736-832 | Public | 31 | 94 | 0 | portée réductible ? |
| `Imprime` | 834-860 | Public | 2 | 24 | 0 | portée réductible ? |
| `fin_impression` | 862-875 | Public | 2 | 11 | 0 | portée réductible ? |
| `pos_Etiq` | 877-899 | Public | 4 | 21 | 0 | portée réductible ? |
| `OBS_GotFocus` | 901-909 | Public | 5 | 7 | 0 | handler GUI |
| `OBS_LostFocus` | 911-919 | Public | 4 | 7 | 0 | handler GUI |
| `SetObservers` | 921-933 | Public | 4 | 10 | 0 | portée réductible ? |
| `Button1_Click` | 935-939 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et options

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Couleurs, `Utils.Observers(Me)`
  **deux fois** (l. 72 et 90), masque les options type/CP, bornes par défaut, observateurs de
  focus `OBS` (`SetObservers`), `init_ComboBox`.
- **`init_ComboBox()`** [réductible] [nature : mixte]. `SELECT * FROM Fiches_Etiquettes` ; libellé
  `"<code>- <libellé>"` (sans la page, comme `FClient`).
- **`CheckType_Click` / `CheckCp_Click`** [nécessaires (handlers)] [nature : GUI]. Affichent ou
  masquent le panneau et le bouton radio de tri correspondants (sans décocher le bouton radio).
- **`liste_Click()`** [handler] [nature : mixte]. Bascule l'affichage ; `drop Table IF exists
  Etiquettes` ; en mode liste `CREATE temporary TABLE Etiquettes (…)` + `Engine()`. Rappelée par
  `fin_impression` (vide la liste).

### Grilles clients et types

- **`Tris()` / `Tris2()`** [réductibles] [nature : GUI]. Colonnes Code/Nom de `colcli`/`colcli2`.
- **`Colcli_Data` / `Colcli2_Data`** [handlers] [nature : GUI]. `Utils.rs1.MoveTo(Row)` et
  affichage de `cli_code`/`cli_nom` (membre `CliTable` réécrit à chaque cellule).
- **`Colcli_ColumnClick` / `Colcli2_ColumnClick`** [handlers] → **`colinit(Col, Coln)`**
  [réductible] [nature : mixte]. Alterne `Asc`/`Desc` et rappelle **`AffClients`** même pour
  `Colcli2` : les colonnes et le focus de `Colcli` sont alors réinitialisés à la place de ceux de
  `Colcli2` (ETICLI-A04).
- **`AffClients(tri2, sens2, col)` / `AffClients2(…)`** [réductibles] [nature : mixte].
  `Utils.Base(col, "select * from Fiches_Cli order by <tri> <sens>")` (concaténation de noms de
  colonnes internes, pas de saisie utilisateur), puis `MoveTo(0, 0)` et focus.
- **`ToggleButton1_Click` / `ToggleButton2_Click`** [handlers] [nature : mixte]. Affichent/masquent
  `Colcli`/`Colcli2` triées par code.
- **`ColCli_Click`** [handler ; rejeu `Object.Call`] [nature : mixte]. Recopie le code dans
  `Client1` ; en mode liste, l'ajoute (`Cli_Man`). **`ColCli2_Click`** [handler ; rejeu] : borne
  haute.
- **`ColCli_KeyPress` / `ColCli2_KeyPress`** [handlers] [nature : GUI]. F1 aide, Entrée choix,
  Échap/F2 fermeture.
- **`ToggleButton3_Click` / `ToggleButton4_Click`** [handlers] [nature : mixte]. Listes `ColType`
  / `ColType2` (`SELECT * FROM Fiches_Typec order by code`).
- **`ColType_KeyPress` / `ColType2_KeyPress`** [handlers], **`ColType_Click` / `ColType2_Click`**
  [handlers ; rejeu] : choix du type.

### Saisie

- **`Cli_Man()`** [réductible] [nature : mixte]. `SELECT * FROM Fiches_Cli where cli_code = &1` ;
  inconnu → avertissement ; en mode liste `INSERT INTO Etiquettes (code, nombre)` (doublon : erreur
  ignorée, code non ajouté à `ListCli`, pas de cumul contrairement à Etiqart).
- **`Etiq_KeyPress()`** (groupe `Etiq`, CC 30) [handler] [nature : GUI]. Enchaînement Entrée/Tab
  selon `Tag` 1..8 (contrôle d'existence du client, 5 chiffres pour les CP), `ChkInput` sur
  `Nbtiq`/`Posetiq`, F2 ouvre les listes, F1 aide.
- **`ChkInput()`** [réductible] [nature : GUI]. Chiffres seulement.
- **`Btn_Click()`** (groupe `Btn`) [handler]. `Tag` 1 aide, 2 impression, 3 suppression du PDF et
  fermeture. **`Btn_KeyPress()`** [handler] : Entrée sur `Tag` 2.

### Impression

- **`Button2_Click()`** (CC 31) [portée : réductible (non handler : `Button2` est dans le groupe
  `Btn`)] [nature : mixte]. Modèle obligatoire ; `SELECT * FROM Fiches_Etiquettes WHERE code = &1`
  (sans la page) ; en plage, une des 5 requêtes `SELECT * FROM Fiches_Cli WHERE cast(cli_code as
  char) >= &1 and cli_code <= &2 [and cli_typec BETWEEN &3 AND &4] order by …` (comparaison
  **texte** pour la borne basse et **numérique** pour la borne haute dans 3 requêtes sur 5,
  ETICLI-A02) ; aucune requête si `RadioButton2` est resté coché après avoir décoché `CheckType`
  (`rCli` reste `Null` ou garde le résultat précédent, ETICLI-A03). En liste : `SELECT * FROM
  Etiquettes`, puis pour chaque code `SELECT * FROM Fiches_Cli WHERE cli_code >= &1` (**`>=`** :
  premier client dont le code est supérieur ou égal, sans `ORDER BY`). Sauts `Posetiq - 1` avec
  impression d'un nom vide. Message « Ce format d'étiquettes n'existe pas » si la requête du format
  échoue (et non si elle est vide).
- **`Imprime()`** [réductible] [nature : mixte]. Lit le client courant de `rCli` (sans test
  `Available`), imprime `Nbtiq` étiquettes (`pos_Etiq`, 4 lignes `Nom`/`Cp`, ville tronquée à 20).
  Le membre `nombretiq` est calculé dans `Button2_Click` mais jamais utilisé.
- **`fin_impression()`** [réductible] [nature : mixte]. `Output`, `Visualiseur.Prog`, son,
  `Message.Warning` « Traitement terminé », `liste_Click`, remise à vide de la liste et du modèle.
- **`pos_Etiq()`** [réductible] [nature : calcul]. Variante V1 (identique à Etiqart).

### Focus

- **`OBS_GotFocus` / `OBS_LostFocus`** [handlers des `Observer`] et **`SetObservers`** [réductible] :
  copie d'[`Etiquettes`](../Etiquettes.class/architecture.md) (couleur `CoulFoc`).
- **`Button1_Click()`** [handler] : `Doc.Open("Eticli")`.

## État global utilisé

- `Start.*` (couleurs, `Coul_fen`, son), `Utils.db`, `Utils.Base`, **`Utils.rs1`** (résultat global
  partagé : un autre écran utilisant `rs1` pendant que la grille est affichée corrompt
  l'affichage), `Utils.FColr`, `Utils.Observers`, `Visualiseur`, `Doc`.
- Fichier `~/tmp/EtiqCli.pdf` (partagé avec `FClient.Button13_Click`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` (CC 31) : construire la clause `WHERE`/`ORDER BY` à partir des options (une seule
  requête paramétrée), puis boucle d'impression ; même SQL émis par cas.
- Fusionner `Tris`/`Tris2`, `AffClients`/`AffClients2`, `ToggleButton3`/`4`, `ColType*` (corps
  identiques au contrôle près).
- Un seul `Utils.Observers(Me)` ; supprimer `nombretiq`, `SorP`, `txtWidth`, `CoulZnaf`, `Tab2`
  redondants.

### Commonalisation avec d'autres fichiers

- Socle `PlancheEtiquettes` (format, `pos_Etiq` V1 identique à Etiqart, sortie) : voir
  [Etiqart › Commonalisation](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers).
  Le dessin d'une étiquette adresse (`Nom` × 3 + `Cp`) est identique à `FClient.Imprime` et
  `FFournisseur.Imprime` ([FClient](../../Tables/FClient.class/architecture.md), FCLIENT-014) à
  l'ordre des champs près : `PlancheEtiquettes.DessineAdresse(l1, l2, l3, cpVille)`.
- Table de travail `Etiquettes` : helper commun (ETIQART-005).
- Focus `OBS_*` : `Utils.CouleurFocus` avec [Etiquettes](../Etiquettes.class/architecture.md)
  (ETIQUETTES-007).
- Grilles de sélection client : même usage de `Utils.Base`/`Utils.rs1` que les écrans `Tri*`
  (`TriCpt`…) ; à rapprocher lors du lot Affichages.

### Réduction de portée

- `init_ComboBox`, `Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`, `Cli_Man`, `ChkInput`,
  `Button2_Click`, `Imprime`, `fin_impression`, `pos_Etiq`, `SetObservers` → `Private` (grep : aucun
  usage externe).

### Séparation traitement / GUI

- `RequeteClients(options) As Result` et `ListeAjoute(code, nombre)` sans contrôle ; l'écran garde
  messages et focus.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `cli_code` est `int(11)` : les bornes texte (`cast … as char`) disparaîtraient avec des
  comparaisons numériques homogènes ; un index sur `cli_cd_ptl`/`cli_typec` accélérerait les tris.
- Table de travail déclarée (voir Etiqart).
