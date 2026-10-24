# Syntheses — Architecture

> Source : `.src/Utils/Syntheses.module`

## Vue d'ensemble

Module de **synthèse vocale** : joue un son d'alerte puis prononce un message en français avec
`pico2wave` et `aplay`, si l'option « son 2 » (`/son2`) est activée dans les préférences. Utilisé pour
annoncer la fin de traitements (purges `Raz*`), les promotions du jour (`Fmenu`) et les rendez-vous
(`AffRdv`).

Nature : **système/son** (aucune GUI, aucune base).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Musique` | var | Private | oui | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Message` | 5-17 | Public | 4 | 11 | 13 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Message(msg As String) As String`** [portée : nécessaire] [nature : système]. `Music.Load(
  "son/warning2.ogg")` (toujours, même si le son est désactivé) ; si `Start.LocalSettings["/son2"]` :
  `Music.Play`, `Wait 0.5`, `Exec ["pico2wave", "-l", "fr-FR", "-w", "msg.wav", msg] Wait`, puis, sans
  erreur, `Shell "pico2wave ; aplay msg.wav"` (asynchrone). Ne renvoie rien malgré `As String`.
  ⚠️ Le `Shell` relance `pico2wave` **sans argument** (erreur d'usage, sans effet visible) avant
  `aplay` ; `msg.wav` est écrit dans le **répertoire courant** et n'est jamais supprimé. Le nom
  `Message` masque la classe `Message` à l'intérieur du module (aucun impact : elle n'y est pas
  utilisée). Appelants : 17 appels dans 13 fichiers (`Fmenu` ×3, `Fsoc` ×3, `RazClientd`, `RazDevis`,
  `RazHistoFac`, `RazHistoFbl`, `RazHistoTk`, `RazRlvb`, `FRestore`, `Verbal`, `Facture`,
  `Facturergbl`, `AffRdv`).

## État global utilisé

- `Start.LocalSettings["/son2"]` ; composant `Music` (gb.sdl2.audio ou équivalent) ; répertoire courant.
- Variable de module `Musique` (`Private`, constante de fait).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer `Shell "pico2wave ; aplay msg.wav"` par `Exec ["aplay", fichier]` ; écrire le WAV dans
  `Temp$()` et le supprimer après lecture (même son produit).
- Transformer en `Sub` (aucune valeur renvoyée) : changement de signature sans impact (aucun
  appelant n'utilise le retour, à vérifier dans le même commit).
- `Musique` → `Const`.

### Commonalisation avec d'autres fichiers

- Le chargement/lecture de son est dispersé : [Utils.Play/Bip](../Utils.module/architecture.md),
  `Utils.Cdate_calc`, `Variables.Musique`, `Start.Musique`. Un module « son » unique (Play, Parle)
  regrouperait ces usages.
- Vérification de la présence de `pico2wave` : [CheckProg](../CheckProg.module/architecture.md).

### Réduction de portée

- Sans objet (fonction unique, 17 appels).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
