# gridv — Dépendances

> Source : `.src/Utils/gridv.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/gridv.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ajoustat`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db`, `mois` |

### Tables SQL référencées

`Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`ajoustat`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant**, confirmé par `grep -rniE 'gridv\.|ajoustat' .src` (seule occurrence
  externe : un commentaire de `Tregie.class:127`). Pas d'appel dynamique possible sur un module
  sans nom en chaîne.
- Pas de `.form`, pas de dépendance circulaire. À supprimer dans le même lot que `gridvi2`.
