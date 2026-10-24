# Cmoprod — Dépendances

> Source : `.src/Utils/Cmoprod.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Cmoprod.class` — classe
- Handlers GUI détectés : 0
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Name`, `C`, `CM`, `I`, `Q`, `ID`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Confirmé par `grep -rniw cmoprod .src` (insensible à la casse, `.class`, `.module`, `.form`) :
  aucun usage, aucun appel dynamique possible (`Class.Load` limité à `LPrix`/`LScript` dans
  `Start.module:483-484`).
