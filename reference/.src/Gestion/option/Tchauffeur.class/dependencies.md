# Tchauffeur — Dépendances

> Source : `.src/Gestion/option/Tchauffeur.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Tchauffeur.class` — classe, formulaire associé `Tchauffeur.form`
- Handlers GUI détectés : 1
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `barselection` | `<type>` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Vérifié par `grep -rn -i 'Tchauffeur\|chauffeur' .src/` : aucune ouverture de l'écran (ni
  `Show`, ni `New`, ni appel dynamique par chaîne). Le couple `.class` + `.form` est mort
  (TCHAUFFEUR-A01).
- `Barselection` lève `premier`, `precedent`, `creer`, `modif`, `suprimer`, `suivant`, `dernier`,
  `quitter`, `valide`, `annule` vers le nom `bar1` : aucun handler `bar1_*` n'existe dans ce
  fichier, l'heuristique ne le signale pas (pas de contrôle « événements d'objet sans handler »).
- Aucune contrainte d'ordre de rework.
