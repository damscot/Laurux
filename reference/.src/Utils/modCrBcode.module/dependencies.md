# modCrBcode — Dépendances

> Source : `.src/Utils/modCrBcode.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/modCrBcode.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `PrintBarcode`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`PrintBarcode`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Aucun usage, ni statique ni par chaîne (`grep -rni "modCrBcode\|PrintBarcode" .src` → ce fichier
  seulement ; pas de `Class.Load` dynamique hors `Start.module:493` qui ne charge que `LPrix` et
  `LScript`). deps.py est correct ici.
- Utilise la classe `Draw` du composant graphique (API héritée de Gambas 2) : sa suppression retire
  aussi cette dépendance.
