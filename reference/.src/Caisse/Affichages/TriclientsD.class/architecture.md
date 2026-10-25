# TriclientsD — Architecture

> Source : `.src/Caisse/Affichages/TriclientsD.class` (+ `TriclientsD.form`)

## Vue d'ensemble

`TriclientsD` (« divers caisse ») est une liste paginée de sélection des **clients divers** de la
caisse, lue dans `Fiches_Clid` (clé `Cbase` `TabClid` : colonnes `adr` texte multiligne, `ddate`,
`lind` auto-incrément). Elle affiche l'adresse sur une ligne (`\n` remplacés par deux espaces) et
renvoie l'identifiant `lind` à la caisse.

**La classe est morte** (vérifié) :
- aucun `New TriclientsD`, aucun `TriclientsD.` dans `.src` ; le nom n'apparaît dans aucune chaîne
  (`Class.Load`, `Object.New`, `.form`, `.report`) : `deps.py` la signale `jamais_reference`, ce que
  `grep -rni triclientsd .src` confirme ;
- elle est présente depuis l'intégration de la caisse dans Laurux (commit `f442d721`) et n'a jamais
  été appelée depuis ;
- son unique action, `colcli_Click`, écrit `Caisse.Clicoded`, **membre qui n'existe pas** dans
  `Caisse` (jamais présent dans l'historique git) : la compilation passe (résolution à l'exécution),
  mais le clic lèverait « Unknown symbol 'Clicoded' in class 'Caisse' » (mécanisme vérifié avec
  `gbs3`) ;
- elle écrit aussi `Caisse.Bsel` sur l'**auto-instance** de `Caisse`, alors que la fenêtre de caisse
  est créée par `New Caisse` (`Cmenu.class:253`) : même corrigée, la sélection n'atteindrait pas la
  caisse affichée.

La sélection des clients divers passe aujourd'hui par [`Tricartes`](../Tricartes.class/architecture.md)
avec `Divers = -1` (fiches `Fiches_Carte.divers = -1` créées par `Caisse.Enrg_Clientd`) :
`Fiches_Clid` n'a plus d'écrivain dans le code (seuls `RazClientd`, qui la purge, et `LauruxMaj`,
qui la crée, la citent).

Mesure `dup.py` : 149 lignes communes avec `Tricartes` (ratio 0,60), 67 avec `Tricp` (0,34).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `NbEnreg` | var | Private |  | Integer | 3 |
| `Clitable` | var | Private |  | New String[2] | 4 |
| `Dbl` | var | Private |  | Boolean | 5 |
| `Tri` | var | Private |  | String | 6 |
| `sel` | var | Private |  | String | 7 |
| `lg` | var | Private |  | Integer | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 11-29 | Public | 3 | 14 | 0 | méthode spéciale |
| `Tris` | 31-39 | Public | 1 | 7 | 0 | portée réductible ? |
| `Colcli_Data` | 44-62 | Public | 5 | 16 | 0 | handler GUI |
| `colcli_Click` | 64-70 | Public | 1 | 5 | 0 | handler GUI |
| `ColCli_KeyPress` | 72-96 | Public | 11 | 22 | 0 | handler GUI |
| `ColCli_MouseWheel` | 98-107 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 109-119 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 121-129 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 131-139 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 141-149 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 151-160 | Public | 3 | 8 | 0 | portée réductible ? |
| `Deb3` | 162-168 | Public | 1 | 5 | 0 | portée réductible ? |
| `Deb4` | 170-176 | Public | 1 | 5 | 0 | portée réductible ? |
| `Dbclk` | 178-188 | Public | 2 | 9 | 0 | portée réductible ? |
| `N1_Click` | 190-204 | Public | 1 | 9 | 0 | handler GUI |
| `N1_Dblclick` | 206-210 | Public | 1 | 3 | 0 | handler GUI |
| `N1_KeyPress` | 212-221 | Public | 4 | 8 | 0 | handler GUI |
| `N1_GotFocus` | 223-228 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 230-234 | Public | 2 | 3 | 0 | handler GUI |
| `ChkInput` | 236-245 | Public | 2 | 8 | 0 | portée réductible ? |
| `ClavInput` | 247-252 | Public | 1 | 4 | 0 | portée réductible ? |
| `Fermer_Click` | 254-258 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions sont **inatteignables** (classe jamais instanciée) ; la description vaut pour le
cas où la classe serait conservée.

- **`_new()`** [spéciale] [GUI] : `Utils.Observers(Me)`, bouton `Fermer` en mode tactile
  (`/Soc<XX>/caisse/tactile`), tri `adr`, calcul de `lg`, en-tête « Nom », chargement `Deb3()`.
- **`Tris()`** [portée : réductible] [GUI] : 2 colonnes, la seconde (`lind`) de largeur 0.
- **`Colcli_Data(Row, Column)`** [handler] [GUI] : colonne 0 = adresse sur une ligne ; colonne 1 =
  `lind` ; `Utils.rs2.MoveTo(Row)`.
- **`colcli_Click()`** [handler, rejoué par `Object.Call`] [GUI] : `Caisse.Bsel = True`,
  `Caisse.Clicoded = lind` (membre inexistant, voir ci-dessus), fermeture.
- **`ColCli_KeyPress`, `ColCli_MouseWheel`, `Descendre_Click`, `Remonter_Click`,
  `Descendre_KeyPress`, `Remonter_KeyPress`, `Deplacement`, `Dbclk`, `Fermer_Click`** : pagination
  et navigation **identiques** à `Tricartes` (même code, mêmes touches).
- **`Deb3()` / `Deb4()`** [réductible] [mixte] : `SELECT * FROM Fiches_Clid WHERE <Tri> LIKE
  "%<sel>%" ORDER BY <Tri> [DESC] LIMIT <NbEnreg>, <lg>` via `Utils.Base2` (concaténation).
- **`N1_Click`, `N1_Dblclick`, `N1_KeyPress`, `N1_GotFocus`, `N1_LostFocus`** : filtre sur l'adresse,
  comme `Tricartes` (un seul en-tête). Restes commentés d'un clavier virtuel (`Clavier("ClientsDiv")`).
- **`ChkInput()`** [réductible] : identique à `Tricartes.ChkInput`.
- **`ClavInput()`** : **code mort** (`unused`, jamais appelée ; prévue pour le clavier virtuel
  commenté).

## État global utilisé

- `Start.LocalSettings` (`/Soc<XX>/caisse/tactile`), `Start.Societe`, `Utils.rs2`.
- `Caisse.Bsel` et `Caisse.Clicoded` sur l'auto-instance de `Caisse` (le second inexistant).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : la classe est à supprimer (TRICLIENTSD-A01). Si l'utilisateur la conserve, la traiter
  comme `Tricartes` (pagination commune, `Charge(bDesc)`, réduction de portée).

### Commonalisation avec d'autres fichiers

- Pagination et `ChkInput` identiques à [`Tricartes`](../Tricartes.class/architecture.md)
  (TRICARTES-005) : seulement si la classe est conservée.

### Réduction de portée

- `Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput` : sans appelant externe (sans objet si la
  classe est supprimée).

### Séparation traitement / GUI

- Sans objet (classe morte).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Clid` n'a plus d'écrivain : la table pourrait être supprimée par une future migration,
  avec l'écran de purge `RazClientd` (lot Archivages), après vérification des bases en production.
