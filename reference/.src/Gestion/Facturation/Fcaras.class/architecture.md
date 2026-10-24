# Fcaras — Architecture

> Source : `.src/Gestion/Facturation/Fcaras.class`

## Vue d'ensemble

`Fcaras` est une **petite fenêtre modale sans bordure** qui affiche la photo et les
caractéristiques (texte libre) d'un article pendant la saisie d'un document de vente. Elle est
ouverte uniquement par `Facture.aff_photo` ([Facture.class:5287](../../../../../.src/Gestion/Facturation/Facture.class#L5287)) avec deux chaînes : le
chemin de l'image et le texte des caractéristiques.

Contrôles du `.form` : `Photos` (DrawingArea `Cached = True`, invisible au départ) dans `Panel4`,
`Crst` (TextArea), `Button1` (« Fermer »).

Nature globale : **GUI pure**, sans accès à la base.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$photo` | var | Private |  | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-29 | Public | 7 | 21 | 0 | méthode spéciale |
| `Tnom_Photo` | 31-43 | Public | 2 | 10 | 0 | portée réductible ? |
| `crst_KeyPress` | 45-49 | Public | 2 | 3 | 0 | handler GUI |
| `Button1_Click` | 51-55 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Photo, $crst)`** [portée : nécessaire (constructeur)] [nature : GUI]. Rend `Photos`
  visible et l'efface, mémorise `Photo` dans `$photo`, appelle `Tnom_Photo`, copie `$crst` dans
  `Crst.Text`, charge l'image (`Try Image.Load`) et la dessine à la taille de la zone
  (`Draw.Begin/Image/End`) ; en cas d'échec de chargement, la zone est effacée. `Catch` final :
  son d'alerte si `Start.son`, puis `Message.Error(Error.Text & Error.Where)`.
  Le second paramètre porte un préfixe `$` (réservé par convention aux membres privés).
- **`Tnom_Photo()`** [portée : réductible (aucun appel externe, vérifié par `grep`)] [nature :
  calcul]. Boucle `Len($photo)` fois en retirant à chaque tour le préfixe jusqu'au premier `/` :
  `$photo` finit réduit au nom de fichier. La variable locale `Pht` est calculée puis jamais lue,
  et `$photo` n'est plus lu après l'appel : **la fonction n'a aucun effet observable** (code mort
  fonctionnel). Copie quasi identique de `Articles.Tnom_Photo` ([Articles.class:Tnom_Photo](../../../../../.src/Gestion/Tables/Articles.class#L4352-L4364)),
  qui, elle, modifie le contrôle `Photo.Text`.
- **`crst_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. `Échap` dans `Crst` →
  `Button1_Click`.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.

## État global utilisé

- `Start.son` (son d'alerte) et `Music` (lecteur global).
- Aucun accès à `Utils.db` ni à `Start.LocalSettings`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Tnom_Photo` et son appel (aucun effet), ainsi que `$photo` qui ne sert plus qu'à
  cette fonction.
- Renommer le paramètre `$crst` en `sCaract` (nommage ; aucun impact sur les appelants, Gambas
  passe les arguments par position).

### Commonalisation avec d'autres fichiers

- Le motif « son d'alerte puis `Message.Error(Error.Text & " " & Error.Where)` » du `Catch` est
  répété dans des dizaines d'écrans (dont [`ConVendeurs`](../ConVendeurs.class/architecture.md)) :
  candidat d'un helper `Utils.ErreurInattendue()` (phase 3).
- Extraction du nom de fichier : `File.Name(chemin)` (gb natif) remplacerait les deux boucles
  `Tnom_Photo` (ici et dans `Articles`).

### Réduction de portée

- `Tnom_Photo` → `Private` (ou suppression, préférable).

### Séparation traitement / GUI

- Sans objet : la classe ne contient pas de traitement.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
