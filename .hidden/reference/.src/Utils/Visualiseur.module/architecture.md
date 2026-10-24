# Visualiseur — Architecture

> Source : `.src/Utils/Visualiseur.module`

## Vue d'ensemble

Point d'entrée unique pour **ouvrir un document généré** (PDF d'édition, document GED) : soit avec la
commande configurée dans les préférences de caisse (`/Soc<XX>/caisse/CmdVis`), soit avec
l'application par défaut du bureau (`Desktop.Open`). Environ 110 appels dans 98 fichiers (toutes les
éditions de comptabilité, gestion, statistiques, caisse, et `LGed`).

Nature : **système/GUI** (lancement d'une application externe).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Prog` | 3-13 | Public | 2 | 8 | 98 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Prog(Fic As String, Optional mime_type = "application/pdf") As String`** [portée : nécessaire]
  [nature : système]. Si `CmdVis` est renseigné pour la société active : `Shell CmdVis & " " & Fic`
  (asynchrone) ; sinon `Desktop.Open(Fic)`. Ne renvoie rien malgré `As String` ; la variable locale
  `$Exec` est inutilisée ; **`mime_type` est ignoré** (seul `LGed.class:434,436` le fournit). Le
  chemin n'est pas quoté dans le `Shell` (espaces). Le réglage `CmdVis` est saisi dans l'écran
  `Caisse/Preferences` mais s'applique à **toutes** les éditions, pas seulement à la caisse.

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/caisse/CmdVis"]`, `Start.Societe`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Déclarer `Prog` en `Sub` sans type de retour (aucun appelant n'utilise la valeur), supprimer
  `$Exec`.
- Lire `CmdVis` une seule fois par appel (actuellement deux lectures de `LocalSettings`).

### Commonalisation avec d'autres fichiers

- [Impression.Ticket/Facture](../Impression.module/architecture.md) appellent `Visualiseur.Prog`
  puis lancent `lpr` avec la même construction de commande par concaténation ; un helper commun
  « lancer une commande configurée sur un fichier » (avec quotage) servirait aux deux modules.
- `Editeur.Prog_Editeur` (`Gestion/Impressions/Editeur.module`) joue le même rôle pour les fichiers
  texte.

### Réduction de portée

- Sans objet (fonction unique, très utilisée).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
