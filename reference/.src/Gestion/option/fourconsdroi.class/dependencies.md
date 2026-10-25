# fourconsdroi — Dépendances

> Source : `.src/Gestion/option/fourconsdroi.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/fourconsdroi.class` — classe
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `addligne`, `enrligne`, `renligne`, `recuppalette`, `recupcoli`, `creadra`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `supligne`, `enregistre`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Consigne` | `<type>` |
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Utils` | `db`, `totobs` |
| `calculdroit` | `<type>`, `drsurfac`, `suspendu`, `vol`, `volap` |
| `calculdroit1` | `code` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_consigne`, `Fiches_ligcons`, `Fiches_ligregie`

### Membres Public sans usage externe détecté (portée réductible ?)

`addligne`, `supligne`, `enrligne`, `renligne`, `recuppalette`, `recupcoli`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : `grep -rni fourconsdroi .src` ne trouve que le fichier lui-même ; aucun
  appel dynamique ni chaîne citant la classe.
- `unused` : `addligne`, `enrligne`, `renligne`, `recuppalette`, `recupcoli`, `creadra` ;
  `unused_transitive` : `supligne` (appelée par `addligne`), `enregistre` (appelée par `enrligne`).
  Le constructeur lui-même n'est jamais exécuté.
- **Homonymie** : la structure `Public Struct consigne` porte le nom de la classe `Consigne` à la
  casse près ; `deps.py` attribue à tort à la classe `Consigne` les usages `<type>` des lignes
  22-24, 44, 116, 119, 203 et à `calculdroit1` les accès `code` des lignes 123, 207, 208, 213.
  Supprimer ce fichier lève l'ambiguïté (comportement de Gambas en cas de conflit structure/classe
  à confirmer, d'où l'intérêt de la suppression).
- Utilise `calculdroit` (propriétés `suspendu`, `drsurfac`, `vol`, `volap`, `droit`, `tvadroit`).
- Ordre de rework : indépendant ; à faire tôt pour assainir le graphe de `Consigne`.
