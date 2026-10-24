# LBox — Architecture

> Source : `.src/Utils/LBox.class` · Formulaire : `.src/Utils/LBox.form`

## Vue d'ensemble

`LBox` est une **boîte de dialogue de saisie générique** à cinq modes (énumération `Public Enum
TextReg, TextArea, ListEditor, ListView, FileSelect`) :

| Mode | Contrôle affiché | Entrée `Inp` | Sortie |
|---|---|---|---|
| `TextReg` | `TextReg1` (champ contrôlé) | un `TextReg` dont on copie `reg`, `dte`, `dat`, `numerique`, `Text` (et qu'on **masque**) | `$obj.Text` |
| `TextArea` | `TextArea1` | texte | `$obj.Text` |
| `ListEditor` | `ListEditor1` | liste | `$obj.List` |
| `ListView` | `ListView1` + boutons de sélection, inversion et filtre par expression régulière | liste de valeurs (doublons et Null ignorés) | `$obj.List` = clés sélectionnées |
| `FileSelect` | `FileChooser1` (sans question ni boutons) | — | `$obj.List` = chemins sélectionnés |

La fenêtre est ouverte en modal ; `ShowModal` renvoie `True` si l'utilisateur annule. Le résultat
est écrit dans l'objet `obj` fourni (en pratique un [`LTrans`](../LTrans.class/architecture.md) ou le
`TextReg` d'entrée) ; sans `obj`, l'événement `MajOut` est levé (aucun observateur dans le projet).

Appelants : [`GedR`](../GedR.class/architecture.md) (changement d'URL, suppression et ajout de
tags) et [`LGed`](../LGed.class/architecture.md) (copie d'un fichier).
Convention d'appel des formulaires à constructeur (vérifiée sur `LBox`, `ProgBar`, `TriFacture`,
`LGed`) : arguments obligatoires de la classe, puis le parent de la fenêtre (`Null`), puis les
arguments optionnels — d'où `New LBox(message, inp, Null, obj, "", mode)`.

Nature globale : **GUI**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TextReg` | enum | Public | oui |  | 3 |
| `TextArea` | enum | Public | oui |  | 3 |
| `ListEditor` | enum | Public | oui |  | 3 |
| `ListView` | enum | Public | oui |  | 3 |
| `FileSelect` | enum | Public | oui |  | 3 |
| `$mode` | var | Private |  | Integer | 5 |
| `$cancel` | var | Private |  | Boolean | 6 |
| `$obj` | var | Private |  | Object | 7 |
| `$List` | var | Private |  | String[] | 8 |
| `$Text` | var | Private |  | String | 9 |
| `MajOut` | event | Public |  |  | 11 |
| `L` | property | Public |  | String[] | 13 |
| `T` | property | Public |  | String | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 17-80 | Public | 11 | 57 | 0 | méthode spéciale |
| `UpdateOut` | 82-126 | Private | 11 | 41 | 0 |  |
| `L_Read` | 131-135 | Private | 1 | 3 | 0 |  |
| `T_Read` | 137-141 | Private | 1 | 3 | 0 |  |
| `Annuler_Click` | 145-149 | Public | 1 | 3 | 0 | handler GUI |
| `Valider_Click` | 151-156 | Public | 1 | 4 | 0 | handler GUI |
| `ListInv_Click` | 158-174 | Public | 5 | 14 | 0 | handler GUI |
| `ListSelection` | 176-215 | Public | 11 | 35 | 0 | portée réductible ? |
| `ListDesel_Click` | 217-221 | Public | 1 | 3 | 0 | handler GUI |
| `ListSel_Click` | 223-227 | Public | 1 | 3 | 0 | handler GUI |
| `FileChooser1_Activate` | 229-233 | Public | 1 | 3 | 0 | handler GUI |
| `FileChooser1_Cancel` | 235-239 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Message, Inp, obj, Tooltip, Mode)`** (CC 11, max du fichier) [portée : nécessaire]
  [nature : GUI]. Affiche la question et son infobulle, masque tous les contrôles, puis affiche
  ceux du mode. Mode inconnu : `Error.Raise`. `Catch` : bip sonore si `Start.son` puis
  `Message.Error("Erreur de gestion d'input de LBox")` ; la fenêtre reste ouvrable mais vide.
  Variable `i As Variant` utilisée seulement en mode `ListView`.
- **`UpdateOut()`** [portée : privée de fait (déclarée sans `Public`)] [nature : mixte]. Recopie la
  valeur du contrôle actif dans `$Text` ou `$List`, puis dans `$obj.Text`/`$obj.List` (copie) ou,
  sans `obj`, lève `MajOut(contrôle)` dont la valeur de retour sert d'annulation. Cinq branches
  quasi identiques.
- **`L_Read()`** / **`T_Read()`** [nature : calcul] : copie de `$List` / `$Text`. Aucun usage
  externe (vérifié par `grep`) ; `L_Read` échoue (`Null.Copy`) en mode texte.
- **`Annuler_Click()`** : `Close($cancel)` — `$cancel` vaut `True` à l'initialisation.
- **`Valider_Click()`** : `$cancel = UpdateOut()` puis `Close($cancel)`.
- **`ListInv_Click()`** : inverse la sélection de chaque élément de `ListView1`.
- **`ListSelection(Selection)`** [portée : réductible] [nature : GUI] : sans filtre,
  sélectionne/désélectionne tout ; avec filtre, compile l'expression régulière
  (`Message.Warning` si invalide) et (dé)sélectionne les éléments qui correspondent
  (`r.Count >= 0`). Les deux branches `If Selection` dupliquent `r.Exec`.
- **`ListDesel_Click()`** / **`ListSel_Click()`** : `ListSelection(False/True)`.
- **`FileChooser1_Activate()`** : valide ; **`FileChooser1_Cancel()`** : `Close(True)`.

## État global utilisé

- `Start.son` (bip en cas d'erreur), `Music` (son préchargé ailleurs).
- Contrôle `TextReg` (classe du projet) pour le mode `TextReg`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `UpdateOut` : helper privé `Sortie(valeur, estListe, controle)` pour les cinq branches.
- `ListSelection` : un seul `r.Exec(i.Text)` puis `If r.Count >= 0 Then i.Selected = Selection`
  (même résultat).
- `ListInv_Click` : `i.Selected = Not i.Selected`.

### Commonalisation avec d'autres fichiers

- Les sélections filtrées par expression régulière existent aussi dans les listes `TriGen`
  (filtre de recherche) : pas de mise en commun simple (widgets différents).
- Le bip `If Start.son Then Music.Play` est répété dans de nombreux fichiers (`Utils.Cdate_calc`,
  …) : candidat d'un `Utils.Bip()` (déjà existant : `Utils.Bip()` est utilisé par `Caisse`).
  À vérifier que `Utils.Bip` fait exactement la même chose avant de l'utiliser ici.

### Réduction de portée

- `ListSelection` : appelé seulement en interne → `Private`.
- Propriétés `L` et `T` et événement `MajOut` : aucun usage externe ; à conserver ou supprimer en
  phase 3 selon l'usage générique voulu (suppression = API publique réduite, sans effet visible).

### Séparation traitement / GUI

- Sans objet (classe purement GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
