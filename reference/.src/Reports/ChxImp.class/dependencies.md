# ChxImp — Dépendances

> Source : `.src/Reports/ChxImp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/ChxImp.class` — classe, formulaire associé `ChxImp.form`
- Handlers GUI détectés : 1
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Variables` | `impr` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Classe jamais référencée** (signal `jamais_reference` confirmé) : aucun `New ChxImp`,
  `ChxImp.Show`, `ChxImp.ShowModal`, ni chaîne « ChxImp » utilisable par `Class.Load` /
  `Object.New` (le seul `Class.Load` du projet, `Start.Start_Test`, charge `LPrix` et `LScript`).
  `git log -G 'ChxImp\.(Show|ShowModal|ShowDialog)|New ChxImp'` ne trouve aucune ouverture dans
  l'historique : l'écran est mort depuis sa création (`e1b2d2b8`, 2016).
- **Homonyme** : `ChxImp` était aussi le nom d'une case à cocher de `Facture`, `Facturefm`,
  `FacturefmA`, `Facturergbl` (supprimée en 2017) ; il en reste un commentaire `Facturergbl:455`.
- **Utilise** : `Variables.impr` (écrit ici, jamais lu : VARIABLES-002), commande `lpstat`.
- **Handler** : `Button1_Click` (`Public`, à conserver tant que le `.form` existe).
- Pas d'`Utils.Observers` : écran non rejouable (sans objet puisqu'il n'est jamais ouvert).
- Aucune dépendance circulaire. **Ordre** : décision CHXIMP-A01 avec VARIABLES-002 (si le couple
  est supprimé, `Variables.impr` devient supprimable).
