# Tricartes — Architecture

> Source : `.src/Caisse/Affichages/Tricartes.class` (+ `Tricartes.form`)

## Vue d'ensemble

`Tricartes` est la **liste de sélection des cartes** (`Fiches_Carte`) ouverte depuis la caisse
(`Caisse`, mode PDV `./Laurux -p`). Elle est paginée « écran tactile » : `lg` lignes par page
(hauteur de la grille / 22 px), boutons `Descendre`/`Remonter`, molette, PageUp/PageDown ; la
requête utilise `LIMIT <NbEnreg>, <lg>`. Un bouton `Fermer` n'est visible qu'en mode tactile
(`/Soc<XX>/caisse/tactile`).

Contrat d'appel : `New Tricartes(Divers As Integer, Optional ob As Object)`.
- `Divers` filtre la colonne `Fiches_Carte.divers` : `0` = cartes de fidélité, `-1` = « clients
  divers » (fiches créées par `Caisse.Enrg_Clientd` pour les facturettes, `divers = -1`).
- `ob` est l'écran appelant : à l'ouverture `Object.SetProperty(ob, "Bsel", False)` et
  `("Bval", Null)` ; au clic sur une ligne `Bsel = True` et `Bval = code de la carte`, puis
  fermeture. `ob` doit donc exposer `Public Bsel` et `Public Bval` (c'est le cas de `Caisse`,
  `Caisse.class:97-98`). Contrairement à `TriCpt` (MATERIEL-A09), la remise à `False` de `Bsel` à
  l'ouverture est faite (et `Caisse` la refait avant l'appel).

Appelants (vérifiés par `grep -rn`) :
- `Caisse.CartesFidelite` (`Caisse.class:7330-7340`, F8 / `Button32`) :
  `New Tricartes(0, Null, Me)` — en Gambas, les paramètres obligatoires de `_new` sont consommés
  d'abord, puis le `Parent` de `Form` (`Null`), puis l'optionnel `ob` (`Me`). Correct.
- `Caisse.ClientsDivers` (`Caisse.class:7249-7270`, Ctrl+N, F2 dans `Nmc4`/`Nmc5`/`Nmc6`,
  `button42`) : `New Tricartes(-1)` **sans `ob`** → la sélection n'est jamais transmise et
  `Caisse` teste un `Bsel` resté `False` (TRICARTES-A01).

La classe n'hérite pas de `TriGen` (`TriGen` est un composant instancié sur un panneau, voir lot
Affichages) ; elle reprend le modèle des listes paginées `Tri*` historiques (`TriclientsD`,
`Tricp`, `TriMat`, `TriFac`, `TriBl`…). Mesure `dup.py` : 149 lignes communes sur 322 avec
[`TriclientsD`](../TriclientsD.class/architecture.md) (ratio 0,60), 68 avec `Tricp` (0,25).

Nature : **GUI**, SQL de liste construit par concaténation.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `NbEnreg` | var | Private |  | Integer | 3 |
| `Clitable` | var | Private |  | New String[9] | 4 |
| `Dbl` | var | Private |  | Boolean | 5 |
| `Tri` | var | Private |  | String | 6 |
| `sel` | var | Private |  | String | 7 |
| `$divers` | var | Private |  | Integer | 8 |
| `lg` | var | Private |  | Integer | 9 |
| `Obj` | var | Private |  | Object | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 13-38 | Public | 4 | 24 | 0 | méthode spéciale |
| `Tris` | 40-53 | Public | 1 | 12 | 0 | portée réductible ? |
| `Colcli_Data` | 58-77 | Public | 2 | 17 | 0 | handler GUI |
| `colcli_Click` | 79-88 | Public | 2 | 7 | 0 | handler GUI |
| `ColCli_KeyPress` | 90-114 | Public | 11 | 22 | 0 | handler GUI |
| `ColCli_MouseWheel` | 116-125 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 127-137 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 139-147 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 149-157 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 159-167 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 169-178 | Public | 3 | 8 | 0 | portée réductible ? |
| `Deb3` | 180-186 | Public | 1 | 5 | 0 | portée réductible ? |
| `Deb4` | 188-194 | Public | 1 | 5 | 0 | portée réductible ? |
| `Dbclk` | 196-206 | Public | 2 | 9 | 0 | portée réductible ? |
| `C1_Click` | 208-222 | Public | 1 | 12 | 0 | handler GUI |
| `C1_Dblclick` | 224-228 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Click` | 230-244 | Public | 1 | 12 | 0 | handler GUI |
| `N1_Dblclick` | 246-250 | Public | 1 | 3 | 0 | handler GUI |
| `Cp1_Click` | 252-266 | Public | 1 | 12 | 0 | handler GUI |
| `Cp1_Dblclick` | 268-272 | Public | 1 | 3 | 0 | handler GUI |
| `VILLE_Click` | 274-288 | Public | 1 | 12 | 0 | handler GUI |
| `VILLE_Dblclick` | 290-294 | Public | 1 | 3 | 0 | handler GUI |
| `C1_KeyPress` | 296-309 | Public | 5 | 12 | 0 | handler GUI |
| `N1_KeyPress` | 311-335 | Public | 8 | 23 | 0 | handler GUI |
| `Cp1_KeyPress` | 337-354 | Public | 6 | 16 | 0 | handler GUI |
| `VILLE_KeyPress` | 356-369 | Public | 5 | 12 | 0 | handler GUI |
| `C1_GotFocus` | 371-376 | Public | 2 | 4 | 0 | handler GUI |
| `C1_LostFocus` | 378-382 | Public | 2 | 3 | 0 | handler GUI |
| `N1_GotFocus` | 384-389 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 391-395 | Public | 2 | 3 | 0 | handler GUI |
| `cp1_GotFocus` | 397-402 | Public | 2 | 4 | 0 | handler GUI |
| `cp1_LostFocus` | 404-408 | Public | 2 | 3 | 0 | handler GUI |
| `VILLE_GotFocus` | 410-415 | Public | 2 | 4 | 0 | handler GUI |
| `VILLE_LostFocus` | 417-421 | Public | 2 | 3 | 0 | handler GUI |
| `ChkInput` | 423-432 | Public | 2 | 8 | 0 | portée réductible ? |
| `ClientsCartes` | 438-445 | Public | 1 | 5 | 0 | portée réductible ? |
| `Fermer_Click` | 447-451 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et chargement

- **`_new(Divers, ob)`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`,
  bouton `Fermer` en mode tactile, tri initial `code`, hauteur de ligne 22, calcul de `lg`,
  mémorisation de `$divers` et `Obj`, remise à zéro de `Bsel`/`Bval` chez l'appelant
  (`Object.SetProperty`), libellés d'en-tête, premier chargement `Deb3()`, focus sur `N1`.
- **`Tris()`** [portée : réductible] [GUI] : 7 colonnes, largeurs calées sur les en-têtes (les
  colonnes 2 à 4 — prénom, adresses — ont des largeurs fixes sous un unique en-tête `P1`).
- **`Deb3()` / `Deb4()`** [portée : réductible] [mixte] : `Tris()` puis
  `Utils.Base2(colcli, "SELECT * FROM Fiches_Carte WHERE <Tri> LIKE "%<sel>%" AND divers = <$divers>
  ORDER BY <Tri> [DESC] LIMIT <NbEnreg>, <lg>")` (résultat dans le global `Utils.rs2`). Filtre,
  tri et pagination sont **concaténés** ; `ChkInput` bloque `"` et `&` mais pas `\` (TRICARTES-A02).
  Les deux fonctions ne diffèrent que par `DESC`. `LIMIT a, b` et le littéral entre guillemets
  doubles sont acceptés par SQLite (à confirmer en phase 2).
- **`Colcli_Data(Row, Column)`** [handler] [GUI] : lit **à chaque cellule** les couleurs
  `/Coul/Fnets` et `/Coul/Znaff` (`Utils.FColr`) dans `Frmt`/`Frmt2`, **jamais utilisées**, remplit
  `CliTable` (7 colonnes sur les 9 déclarées) puis `Utils.rs2.MoveTo(Row)` et lecture de la colonne.
- **`Deplacement()`** [portée : réductible] [GUI] : borne `NbEnreg` à 0 et recharge dans le sens
  courant (`Dbl`).
- **`Dbclk()`** [portée : réductible] [GUI] : bascule tri croissant/décroissant (`Dbl`, Boolean
  affecté avec `"1"`/`""`) sans remettre `NbEnreg` à 0.

### Sélection

- **`colcli_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] : transmet
  `Bsel = True` et `Bval = code` à l'appelant si `Obj` est valide, puis ferme.
- **`ColCli_KeyPress()`** [handler] [GUI] (CC 11) : Entrée = sélection ; flèche haut en première
  ligne / bas en dernière ligne = page précédente / suivante ; PageUp/PageDown ; Échap/F2 ferme.
- **`ColCli_MouseWheel()`** [handler] [GUI] : `Mouse.Delta = -1` → page suivante si la page est
  pleine, sinon page précédente ; puis `Deplacement()`.
- **`Descendre_Click` / `Remonter_Click`** [handler] : page suivante (si pleine) / précédente,
  curseur en première ligne. **`Descendre_KeyPress` / `Remonter_KeyPress`** : Échap/F2 ferme,
  PageUp/PageDown. **`Fermer_Click`** : ferme.

### En-têtes de tri et filtre

- **`C1_Click`, `N1_Click`, `Cp1_Click`, `VILLE_Click`** [GUI] : vident le filtre, remettent les
  libellés des autres en-têtes, fixent `Tri` (`code`, `nom`, `cd_ptl`, `ville`), `NbEnreg = 0`,
  rechargent (`Dbl = ""` écrit deux fois). Ce sont des `TextBox` : `Click` n'est pas levé par Gambas,
  ces méthodes ne sont appelées que par les `*_GotFocus` et par la navigation flèche gauche/droite.
- **`*_GotFocus` / `*_LostFocus`** : journalisation `Utils.ObsGotf`/`ObsLstf` et appel du `*_Click`.
- **`*_Dblclick`** : `Dbclk()`.
- **`C1_KeyPress`, `N1_KeyPress`, `Cp1_KeyPress`, `VILLE_KeyPress`** [handler] : `ChkInput()` pour
  **toute** touche (y compris flèches, Échap, F2, F4 : le filtre est recalculé et la requête rejouée
  avant l'action), puis Échap/F2 ferme, flèche bas descend dans la grille, flèches gauche/droite
  changent de colonne de tri ; F4 dans `N1` ouvre la gestion des cartes (`ClientsCartes`) puis
  recharge.
- **`ChkInput()`** [portée : réductible] [mixte] : refuse `"` et `&` (`Stop Event`), sinon
  `sel = Utils.Obstch(sel)` (ajout de `Key.Text` ou retrait sur Retour arrière) et `Deb3()`.
  Identique à `TriclientsD.ChkInput`.
- **`ClientsCartes()`** [portée : réductible] [GUI] : `New FClientcarte` en modal (gestion des cartes
  depuis la caisse).

## État global utilisé

- `Start.LocalSettings` : `/Soc<XX>/caisse/tactile`, `/Coul/Fnets`, `/Coul/Znaff` ; `Start.Societe`.
- `Utils.rs2` (via `Utils.Base2`) : résultat **global** de la liste. `ClientsCartes` ouvre
  `FClientcarte`, qui peut ouvrir `Tricp` (lui aussi sur `Utils.rs2`) : `Deb3()` est rappelée au
  retour, ce qui recharge `rs2` avant tout nouvel affichage.
- `Obj` : écran appelant (`Caisse`), modifié par `Object.SetProperty`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb3`/`Deb4` → `Charge(bDesc)` ; texte SQL inchangé.
- `C1_Click`/`N1_Click`/`Cp1_Click`/`VILLE_Click` → `TriColonne(sTri, hEntete)` (handlers conservés).
- `Colcli_Data` : supprimer les lectures de couleurs inutilisées, initialiser `CliTable` une fois.

### Commonalisation avec d'autres fichiers

- **Pagination tactile** (`Descendre_*`, `Remonter_*`, `ColCli_MouseWheel`, `Deplacement`, gestion
  des flèches dans `ColCli_KeyPress`) : identique dans [`TriclientsD`](../TriclientsD.class/architecture.md)
  et très proche dans `Tricp`, `TriMat`, `TriFac`, `TriFac2`, `TriBl`, `TriEqu`, `TriEcritures*`,
  `ArchivesTck`, `Archives` → classe d'aide `PaginationListe` (état `NbEnreg`/`lg`/`Dbl`, méthodes
  `Suivante`/`Precedente`/`Molette`) à définir avec le lot Affichages. `TriGen` porte déjà cette
  logique mais crée ses propres contrôles : l'utiliser imposerait de modifier le `.form` (exclu).
- **`ChkInput`** : identique dans `TriclientsD` ; même idiome dans les autres `Tri*` (`Utils.Obstch`).
- **Requête des cartes** : la même table est lue par [`FClientcarte`](../../FClientcarte.class/architecture.md)
  (`Deb2`/`Deb3`), `EmailingCarte` (sélection de destinataires, EMAILING-006 / EMAILINGCARTE-004) et
  `HitCarte` ; une fonction pure `RequeteCartes(sTri, sSel, iDivers, bDesc, iDebut, iNb) As String`
  servirait au moins aux deux écrans du lot Caisse.

### Réduction de portée

- `Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`, `ClientsCartes` : aucun appelant externe
  (vérifié) → `Private`. Les handlers restent `Public`.
- `Bsel`/`Bval` ne sont pas des membres de cette classe : ce sont ceux de l'appelant, qui doivent
  rester `Public` (`Caisse`).

### Séparation traitement / GUI

- Extraire la construction du SQL dans `RequeteCartes(…)` (calcul pur, testable en gbtest), appelée
  par `Deb3`/`Deb4` avec `Utils.Base2`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `divers` sert de type de fiche (carte de fidélité / client divers de caisse) : une colonne `type`
  explicite, ou une table distincte pour les clients divers, éviterait le filtre `divers = 0/-1` et
  les valeurs `NULL` invisibles des deux listes.
- Index sur `Fiches_Carte(divers, nom)` et `(divers, ville)` pour la pagination triée
  (`LIKE '%…%'` empêche l'usage de l'index pour le filtre).
