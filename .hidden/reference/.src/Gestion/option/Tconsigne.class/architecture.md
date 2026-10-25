# Tconsigne — Architecture

> Source : `.src/Gestion/option/Tconsigne.class` · Formulaire : `Tconsigne.form`

## Vue d'ensemble

`Tconsigne` est l'**écran de paramétrage des consignes d'emballages** (option boissons) : une fiche
par code de consigne de `Fiches_consigne` (`code` sur 2 caractères, `libelle`, `prix`, `type`
`P` palette / `C` caisse / `B` bouteille, boutons radio `Radiopal`/`Radiocais`/`Radiobout`).
Ouvert par `menuopt` (`Tconsigne_click`, auto-instance `.Show`) et par la fiche article d'option
`artopt` (`Buttcons_Click`, `.ShowModal`).

L'écran est piloté par la barre d'actions [`barselection`](../barselection.class/architecture.md)
(`New Barselection("111111111", panel2) As "bar1"`, les 9 boutons visibles) : premier, précédent,
création, modification, suppression, suivant, dernier, quitter, recherche. Même cycle que
[`Mreglement`](../../Tables/Mreglement.class/architecture.md), [`Tregie`](../Tregie.class/architecture.md),
[`Ttourne`](../Ttourne.class/architecture.md), [`Tregion`](../Tregion.class/architecture.md) et
[`Tchauffeur`](../Tchauffeur.class/architecture.md) :

1. `bar1_creer` / `bar1_modif` ouvrent une **transaction** (`Utils.db.Begin`) et remplacent le
   `Result` de navigation par un `Create9` ou un `Edit` ;
2. `barselection.butval_Click` lève `valide($bcreer, $bmodif)` ou `annule(...)` : le second
   paramètre reçu par `bar1_valide(creer, anul)` est en réalité le drapeau **modification**
   (nommé `anul` ici) ; `Stop Event` dans le gestionnaire annule la sortie du mode saisie ;
3. `bar1_valide` fait `Update` + `Commit`, `bar1_annule` fait `Rollback`, puis le `Result` est relu
   (`ORDER BY code`) et repositionné sur `$ind`.

Règle métier telle que le code l'applique : le code est unique et non vide (contrôlé en création et
en sortie de `Textcode`) ; la suppression n'est **pas implémentée** (`bar1_suprimer` vide, « a
completer ») alors que le bouton est affiché. Le prix est celui utilisé par
[`Consigne.consigne_montant`](../Consigne.class/architecture.md),
[`Saisiedecons`](../Saisiedecons.class/architecture.md) et `facopt`.

Nature globale : **GUI + SQL** (un seul fichier de table, aucune règle de calcul).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `bs` | var | Private |  | Barselection | 3 |
| `rescons` | var | Private |  | Result | 4 |
| `$ind` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `form_Open` | 7-23 | Public | 2 | 14 | 0 | handler GUI |
| `cmpt_gotfocus` | 25-29 | Public | 2 | 3 | 0 | handler GUI |
| `cmpt_lostfocus` | 31-35 | Public | 2 | 3 | 0 | handler GUI |
| `bar1_annule` | 37-46 | Public | 2 | 9 | 0 | handler GUI |
| `bar1_creer` | 48-57 | Public | 1 | 8 | 0 | handler GUI |
| `bar1_dernier` | 59-66 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_modif` | 68-73 | Public | 1 | 4 | 0 | handler GUI |
| `bar1_precedent` | 75-82 | Public | 3 | 6 | 0 | handler GUI |
| `bar1_premier` | 84-91 | Public | 2 | 6 | 0 | handler GUI |
| `bar1_suivant` | 93-99 | Public | 2 | 5 | 0 | handler GUI |
| `bar1_valide` | 101-122 | Public | 7 | 19 | 0 | handler GUI |
| `bar1_suprimer` | 124-128 | Public | 1 | 2 | 0 | handler GUI |
| `bar1_quitter` | 130-134 | Public | 1 | 3 | 0 | handler GUI |
| `bar1_recherche` | 136-143 | Public | 1 | 5 | 0 | handler GUI |
| `rech_trouver` | 145-153 | Public | 2 | 7 | 0 | handler GUI |
| `form_Close` | 155-162 | Public | 4 | 6 | 0 | handler GUI |
| `Textcode_LostFocus` | 164-183 | Public | 3 | 16 | 0 | handler GUI |
| `affichedonne` | 185-200 | Private | 5 | 14 | 0 |  |
| `affectedonne` | 202-211 | Private | 4 | 8 | 0 |  |
| `mablanc` | 213-220 | Private | 1 | 6 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et focus

- **`form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. `Utils.Observers(Me)`, barre
  `bar1`, observateurs `cmpt` sur `Textcode`, `Textlib`, `Valueprix` ; `SELECT * FROM
  Fiches_consigne ORDER BY code`, affichage de la première fiche ; `$ind = 0`.
- **`cmpt_gotfocus()`**, **`cmpt_lostfocus()`** [portée : nécessaire (handlers)] [nature : GUI].
  Couleur de focus (`Utils.ObsGotf`/`ObsLstf`).
- **`Textcode_LostFocus()`** [handler] [nature : mixte]. `SELECT … WHERE code = &1` : si le code
  existe, ballon « Code déja créer » et retour du focus ; si vide, ballon « Code ne peut pas être
  vide ». ⚠️ Le contrôle n'est actif qu'en création (`Textcode.Enabled`), mais il compare aussi au
  code en cours de modification si le champ est réactivé (sans objet en l'état).

### Barre d'actions (événements de `barselection`)

- **`bar1_premier`/`bar1_precedent`/`bar1_suivant`/`bar1_dernier`** [handlers] [nature : GUI].
  Navigation dans `rescons`. ⚠️ `bar1_suivant` ne teste pas `Available` (table vide : erreur sur
  `rescons.Index`, à confirmer).
- **`bar1_creer()`** [handler] [nature : mixte]. Mémorise `$ind`, `Begin`, `rescons =
  Utils.db.Create9("Fiches_consigne")`, vide la saisie (`mablanc`, type bouteille par défaut),
  active `Textcode`.
- **`bar1_modif()`** [handler] [nature : mixte]. `Begin`, `rescons = Utils.db.Edit("Fiches_consigne",
  "code=&1", Textcode.Text)`. `$ind` n'est **pas** mis à jour : après validation, la fiche affichée
  est celle de l'index mémorisé lors d'une création précédente (0 sinon).
- **`bar1_valide(creer, anul)`** (CC 7) [handler] [nature : mixte]. En création : refuse un code
  existant ou vide (`Stop Event`). Sort sans rien faire si ni création ni modification (cas de la
  suppression). Sinon `affectedonne`, `Update`, `Commit`, relecture et repositionnement sur `$ind`.
- **`bar1_annule(creer, anul)`** [handler] [nature : mixte]. `Rollback`, relecture, `$ind`.
- **`bar1_suprimer()`** [handler] — **vide** (suppression non implémentée).
- **`bar1_quitter()`** [handler] : `Me.Close`.
- **`bar1_recherche()`** [handler] [nature : GUI]. Ouvre [`rechcons`](../rechcons.class/architecture.md)
  en mode `"T"` (tous types), événement `rech_trouver`.
- **`rech_trouver(value)`** [handler] [nature : GUI]. Repart du premier enregistrement et avance
  jusqu'au code choisi. ⚠️ Boucle `While` sans test de fin : si `rescons` a été remplacé par un
  `Create9`/`Edit` (recherche pendant une saisie) ou si le code n'y est pas, erreur de lecture hors
  résultat.

### Fermeture

- **`form_Close()`** [handler] [nature : mixte]. Si la barre est en création ou modification,
  demande « Voullez-vous enregister… » ; sur « Oui », appelle **`bar1_valide` sans argument** alors
  que les deux paramètres sont obligatoires : vérifié avec `gbs3`, l'appel lève « Not enough
  arguments » à l'exécution (non détecté par `deps.py`, appel sans parenthèses). Sur « Non », la
  transaction ouverte n'est ni validée ni annulée. Puis `Me.Close` dans son propre événement
  `Close` (sans effet attendu, à confirmer).

### Aides privées

- **`affichedonne()`** [portée : privée] [nature : GUI]. Copie l'enregistrement courant dans les
  contrôles (sauf si `$ind = -1`).
- **`affectedonne()`** [nature : GUI → `Result`]. Copie les contrôles dans `rescons` ; le type est
  déduit des boutons radio.
- **`mablanc()`** [nature : GUI]. Vide la saisie, type `B` par défaut.

## État global utilisé

- `Utils.db` (`Exec`, `Create9`, `Edit`, `Begin`, `Commit`, `Rollback`) — transaction ouverte sur la
  connexion partagée pendant toute la saisie.
- `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`.
- Table `Fiches_consigne` (créée par `modfichier.fichierboisson`, absente de `db_control.csv`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Requête `SELECT * FROM Fiches_consigne ORDER BY code` répétée 3 fois → fonction privée
  `Relire()` (SQL identique).
- Contrôle d'unicité du code dupliqué entre `bar1_valide` et `Textcode_LostFocus` → fonction
  privée `CodeExiste(code) As Boolean`.

### Commonalisation avec d'autres fichiers

- Cycle de barre `Begin`/`Create9`/`Edit`/`Commit`/`Rollback`/relecture/`$ind` identique à
  [`Mreglement`](../../Tables/Mreglement.class/architecture.md) (MREGLEMENT-006), `Tregie`,
  `Ttourne`, `Tregion`, `Tchauffeur` : helper commun (classe de base ou module) à concevoir en
  phase 3.
- Écran « table code/libellé (+ prix, type) » : candidat au socle proposé dans
  [`Centrales`](../../Tables/Centrales.class/architecture.md) (CENTRALES-005), si le socle accepte
  une barre `barselection`.

### Réduction de portée

Aucune : toutes les méthodes `Public` sont des handlers (`form_*`, `cmpt_*`, `bar1_*`, `rech_*`,
`Textcode_*`), qui doivent rester `Public`.

### Séparation traitement / GUI

- `CodeExiste(code)` et `Relire()` sans accès aux contrôles ; `affectedonne` reste GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_consigne` dans `db_control.csv` et les bases de référence ; contrainte
  `CHECK (type IN ('P','C','B'))`.
- Clé étrangère `Fiches_ligcons.codecons` → `Fiches_consigne.code` (aujourd'hui la suppression,
  si elle était implémentée, laisserait des mouvements orphelins).
