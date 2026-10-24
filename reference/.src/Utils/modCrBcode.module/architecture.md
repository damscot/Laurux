# modCrBcode — Architecture

> Source : `.src/Utils/modCrBcode.module` · Auteur : Charles Guerin

## Vue d'ensemble

Module de **dessin d'un code-barres EAN-13** avec l'ancienne API `Draw` (Gambas 2) : barres de garde,
encodage L/G/R selon le premier chiffre, puis texte du code sous les barres.

**Code mort** : `PrintBarcode` n'a **aucun appelant** (`grep -rni "PrintBarcode\|modCrBcode" .src` ne
renvoie que ce fichier). Le dessin d'EAN-13 utilisé par Laurux est `Cdocuments.EAN13`
(`Reports/Cdocuments.class:367`, sur `PdfWriter`). L'en-tête mentionne `modCrBcode.class`.

Nature : **GUI/dessin** (aucun accès base).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `PrintBarcode` | 7-103 | Public | 17 | 79 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`PrintBarcode(bcode, posX, posY, bcHeight, barThickness, SorP)`** [portée : réductible — aucun
  appelant] [nature : GUI (dessin)]. Initialise les tables `structure`, `enc1/2/3` (codes L, G, R),
  tailles de police écran/imprimante ; trace les barres avec `Draw.Line` sur le périphérique `Draw`
  courant (doit avoir été ouvert par l'appelant par `Draw.Begin`) ; écrit le texte avec `Draw.Text`.
  `SorP` choisit la taille de police écran (`True`) ou imprimante. Limites : `barThickness` doit être
  entre 1 et 10 (indice `barThickness - 1`), premier caractère non numérique → `structure[0]`, sortie
  silencieuse si un chiffre est invalide (`Try … If Error Then Return`), pas de contrôle de la clé.
  Les déclarations `New String[10]` sont immédiatement écrasées par des littéraux.

## État global utilisé

- Aucun (contexte `Draw` implicite).

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet si le module est supprimé.

### Commonalisation avec d'autres fichiers

- Doublon fonctionnel de `Cdocuments.EAN13` ([architecture](../../Reports/Cdocuments.class/architecture.md))
  et du contrôle de clé EAN-13 de `Caisse/FClientcarte.class:504-514`.

### Réduction de portée

- Sans objet (suppression proposée).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
