# Dcaisses — Dépendances

> Source : `.src/Caisse/Dcaisses.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Dcaisses.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `TestCai`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`TestCai`
<!-- /AUTO:dependances -->

## Notes d'analyse

- `jamais_reference` vérifié : `grep -rnw Dcaisses .src .project` ne trouve que le fichier.
- Homonymie de fonction : `TestCaisses.TestCai(Cai, Vdr)` a le même nom avec une autre
  signature ; les appels d'`Ouverture` sont qualifiés `TestCaisses.`, donc aucune ambiguïté.
- Aucune contrainte d'ordre : suppression indépendante.
