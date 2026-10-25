# Telium — Dépendances

> Source : `.src/Caisse/Telium.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Telium.class` — classe
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `demanderPaiement`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `calculerLRC`, `demanderInitialisation`, `demanderReponse`, `envoyerSignal`, `attendreSignal`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`demanderPaiement`
<!-- /AUTO:dependances -->

## Notes d'analyse

- `jamais_reference` vérifié : `grep -rnw Telium .src .project` ne trouve que le fichier ; aucune
  chaîne `"Telium"`, aucun `.form`. Le binaire `.gambas/TELIUM` est compilé mais jamais chargé.
- `unused` / `unused_transitive` vérifiés (voir architecture.md).
- **Dépendance externe non listée par `deps.py`** : `SerialPort` du composant `gb.net`
  (`.project`, `Component=gb.net`), périphérique `/dev/ttyACM0` (droits du groupe `dialout`).
- `Raise Error(…)` (ligne 40) : levée d'un événement non déclaré, non détectée par `deps.py`
  (ni par `gbc3`) ; erreur constatée à l'exécution.
- Aucune contrainte d'ordre : suppression indépendante.
