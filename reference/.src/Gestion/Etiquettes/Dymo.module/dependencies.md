# Dymo — Dépendances

> Source : `.src/Gestion/Etiquettes/Dymo.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Dymo.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Gondole1`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `Remplace` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Gondole1`
<!-- /AUTO:dependances -->

## Notes d'analyse

- `unused` = `Gondole1` : **confirmé** par `grep -rn 'Dymo\.' .src` ; toutes les occurrences
  `Dymo.Value`/`Dymo.value` (EtiqPromo, EtiqRecpt, Etiqfbtarif, Etiqart, Etigond, Etiqcasier) visent
  le **RadioButton** `Dymo` du `.form`, prioritaire sur le module dans une classe de formulaire
  (le code compile alors que le module n'a pas de membre `Value`). Homonymie module/contrôle non
  résolue par `deps.py` (limite connue), ici sans faux positif.
- Les chaînes `"3- Dymo"` (`/Soc<XX>/Impetiq`, écrites par `Prefs`) ne référencent pas le module.
- Aucun appel dynamique (`Object.Call`, `Class.Load`) ne cite `Dymo`.
- Ordre de rework : indépendant ; supprimer après le test d'équivalence DYMO-T01.
