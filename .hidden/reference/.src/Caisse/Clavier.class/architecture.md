# Clavier — Architecture

> Source : `.src/Caisse/Clavier.class`

## Vue d'ensemble

`Clavier` est le **clavier virtuel AZERTY de l'écran de connexion de la caisse** (mode tactile).
Il est ouvert par [`Ouverture`](../Ouverture.class/architecture.md) (`Button3_Click`,
`Ouverture.class:265-268`, `New Clavier` puis `Show`) et écrit la saisie dans le champ mot de
passe `Ouverture.Mdp` (auto-instance d'`Ouverture`, ouverte par `Ouverture.ShowModal()` dans
`Cmenu.class:150`).

Le `.form` (sans bordure, 130 × 32) contient 41 boutons du groupe **`Clav`** (lettres `A`…`Z`,
chiffres `c0`…`c9`, `Point`, `Virgule`, `Poinvirgule`, `Espace`, `Efface`), 4 panneaux
d'espacement aussi rattachés à `Clav`, et 3 boutons hors groupe : `Entree`, `Fermer` et
`Etoile`. Le **nom** du contrôle sert de valeur de touche (`Last.Name`).

L'écran appelle `Utils.Observers(Me)` dans `_new` : il est journalisé et rejouable (un clic de
bouton est rejoué par `Value = True`, qui lève `Clav_Click`).

Nature : **GUI**, avec une petite logique pure (calcul de la saisie) extractible.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$saisie` | var | Private |  | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-11 | Public | 1 | 5 | 0 | méthode spéciale |
| `Clav_click` | 13-18 | Public | 1 | 4 | 0 | handler GUI |
| `Numerique` | 20-34 | Public | 4 | 13 | 0 | portée réductible ? |
| `Alpha` | 36-66 | Public | 8 | 29 | 0 | portée réductible ? |
| `Fermer_Click` | 68-77 | Public | 1 | 4 | 0 | handler GUI |
| `Entree_Click` | 79-83 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : `Me.Center` (aussitôt annulé),
  `Utils.Observers(Me)`, `Me.Move(120, 280)` (position fixe).
- **`Clav_click()`** [nécessaire, handler du groupe `Clav`] [mixte] : appelle `Alpha()` puis
  recopie `$saisie` dans `Ouverture.Mdp.Text`. Le contenu tapé au clavier physique dans `Mdp` est
  écrasé (`$saisie` part de `""`, CLAVIER-A03).
- **`Alpha()`** [réductible] [calcul sur `Last`] (CC 8) : nom d'une lettre → ajout de la lettre
  (toujours en **majuscule**) ; nom de 2 caractères (`c7`) → ajout du chiffre ; `Point` → `.` ;
  `Etoile` → `*` ; `Espace` → espace ; `Efface` → retire le dernier caractère ; `Entree` → CR LF.
  Les branches `Etoile` et `Entree` sont **inatteignables** (boutons hors du groupe `Clav`) ;
  `Virgule` et `Poinvirgule` ne correspondent à aucune branche : `,` et `;` sont ignorés
  (CLAVIER-A01). Appelée seulement par `Clav_click` (signal `scope_reducible` confirmé).
- **`Numerique()`** [réductible → code mort] : variante chiffres seuls, jamais appelée dans ce
  fichier (signal `unused` confirmé : les 15 appels `Numerique()` de `Caisse.class:8136-8237`
  visent la copie locale `Caisse.Numerique`).
- **`Fermer_Click()`** [nécessaire, handler] [GUI] : `Me.Close` puis **`Ouverture.Button1_Click()`**
  (tentative de connexion) : « Fermer » valide la saisie comme « Entrée » (CLAVIER-A02). Code
  commenté (`$Org`) à retirer.
- **`Entree_Click()`** [nécessaire, handler] [GUI] : `Fermer_Click()`.

Aucun signal `handlers_inactifs`, `replay_*` ni `arity_errors`.

## État global utilisé

- `Ouverture.Mdp` (contrôle de l'auto-instance d'`Ouverture`), `Ouverture.Button1_Click`.
- `Utils.Observers`.
- `Last` (bouton émetteur).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Alpha` : remplacer les 7 `If` imbriqués par un `Select Case Last.Name` (même résultat).
- Supprimer `Numerique`, le `Me.Center` sans effet et le code commenté de `Fermer_Click`.

### Commonalisation avec d'autres fichiers

- [`Caisse`](../Caisse.class/architecture.md) contient des copies de `Alpha` et `Numerique`
  (`Caisse.class:8248`, `8264` ; seule différence : `Entree` n'ajoute CR LF que si
  `zone = "Nmc4"`). Fonction pure commune proposée : `Utils.ToucheVirtuelle(sSaisie, sTouche,
  bEntree As Boolean) As String` (ou un petit module `LClavier`), appelée par les deux classes
  avec un comportement identique.

### Réduction de portée

- `Alpha` → `Private` ; `Numerique` supprimé. Les handlers (`Clav_click`, `Fermer_Click`,
  `Entree_Click`) restent `Public`.

### Séparation traitement / GUI

- `Clav_click` : `$saisie = ToucheVirtuelle($saisie, Last.Name, True)` (pur) puis affectation de
  `Ouverture.Mdp.Text` (GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
