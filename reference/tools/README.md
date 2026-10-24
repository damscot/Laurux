# Outillage du rework

Scripts Python 3 (bibliothèque standard uniquement), lancés depuis la racine du clone.

| Script | Rôle |
|---|---|
| `gambas_parse.py` | Parseur léger `.class`/`.module` : fonctions (portée, lignes, complexité), déclarations, contrôles des `.form` |
| `kpi.py` | KPI par fichier : LOC hors commentaires, complexité cyclomatique, globales, `Public` |
| `deps.py` | Graphe des dépendances inter-fichiers (heuristique statique), tables SQL, handlers GUI, portée réductible |
| `gendoc.py` | Crée/rafraîchit les 5 documents de `reference/<source>/` ; ne régénère que les blocs `<!-- AUTO:… -->`, puis appelle `links.py` |
| `links.py` | Recalcule les pointeurs `[Fichier.class:Fonction]()` / `[Fichier.class:123]()` vers les sources ; `--check` pour contrôler |
| `diffdeps.py` | Compare deux `deps.json` et liste les documents rédigés à revoir (appelants ajoutés ou retirés, portée annoncée réductible mais membre utilisé, fichier annoncé mort mais appelé) |

```bash
python3 reference/tools/kpi.py --label initial --json reference/data/kpi_initial.json
python3 reference/tools/deps.py --json reference/data/deps.json
python3 reference/tools/gendoc.py --history initial --commit 6b6b9dfc .src/Utils

# Extrait ciblé de reference/data/deps.json (sans réanalyser les sources)
python3 reference/tools/deps.py -q LPrix                          # un fichier, par nom
python3 reference/tools/deps.py -q .src/Utils -f used_by,tables   # un répertoire, champs choisis
python3 reference/tools/deps.py -q LPrix -q LTaxe -f scope_reducible

# Après une évolution de deps.py : quels documents revoir ?
git show HEAD:reference/data/deps.json > /tmp/deps_old.json
python3 reference/tools/deps.py --json reference/data/deps.json
python3 reference/tools/diffdeps.py /tmp/deps_old.json --md output/<session>/revue_deps.md -p .src/Utils
```

## Définitions

- **LOC** : lignes non vides qui ne commencent pas par `'`.
- **Complexité cyclomatique** d'une fonction : 1 + nombre de `If` (dont `Else If`), `Case` (hors `Select Case` et `Case Else`),
  `For`, `While`, `Until`, `And`, `Or`, `Catch`, `Try`, `IIf`.
- **Globales** : variables `Public` (non `Const`) d'un `.module`, et `Static Public` d'une `.class`.
- **Portée** : une fonction déclarée sans `Public`/`Private` est `Private` (vérifié avec `gbc3`).

## Champs de `deps.json` (par fichier)

| Champ | Contenu |
|---|---|
| `uses` / `used_by` | dépendances sortantes / entrantes, par membre et lignes |
| `tables` | tables SQL citées en littéral (`Fiches_*`, `Docs_*`, `Mails_*`, `Corsage`, clés `Cbase`) |
| `handlers` | fonctions `<Contrôle|Groupe>_<Événement>` levées par Gambas (événements natifs ou `Event` du projet) |
| `handlers_inactifs` | `<Contrôle>_<Événement>` d'un contrôle rattaché à un groupe du `.form`, jamais appelé ailleurs |
| `replay_dynamic` | `<Contrôle>_Click` des GridView, ColumnView et ListBox, appelés par `ReplayObserver.Replay_Click` via `Object.Call` : doivent rester `Public` (sans objet si REPLAYOBSERVER-A06 est validée) |
| `replay_missing` | grilles GridView, ColumnView, ListBox du `.form` **sans** `<Grille>_Click` : un clic rejoué par `ReplayObserver` ferait `Object.Call` d'une méthode inexistante (à éviter dans les scénarios, ou REPLAYOBSERVER-A06) |
| `unused_transitive` | fonctions appelées seulement depuis du code mort (`unused`, `handlers_inactifs`), calcul itératif dans le fichier |
| `jamais_reference` | classe sans aucun appelant (une simple déclaration `As X` sans `New`, `Inherits` ni accès à un membre ne compte pas) et dont le nom n'apparaît dans aucune chaîne du projet (`Class.Load`, `Object.New`) : code mort probable (couple `.class` + `.form` → anomalie) |
| `auto_instance` | accès `Classe.membre` (membre d'instance) à une classe à formulaire qui est aussi ouverte par `New Classe` ailleurs : l'accès vise l'auto-instance cachée, pas la fenêtre affichée (ex. `Caisse.Ba4` depuis `Cfacture`) |
| `collision_casse` | autre source dont le nom ne diffère que par la casse : un seul `.gambas/<NOM>` est compilé (ex. `Utils/Numtostring` et `Caisse/numtostring`) |
| `sql_params` | appels `Exec`/`Subst` dont le SQL littéral (hors noms de table) a des arguments sans marqueur `&N`, ou des marqueurs sans argument (`&N` et `&{N}`) |
| `ui` | fichier d'interface analysé : `.form`, ou `.report` à défaut (même syntaxe) |
| `arity_errors` | appels `Cible.Méthode(…)` / `Méthode(…)` dont le nombre d'arguments sort de la signature |
| `unused` | fonctions jamais référencées (ni dans le fichier, ni ailleurs, ni en appel dynamique) |
| `scope_reducible` | membres `Public` sans usage externe détecté (suggestion à confirmer) |
| `dynamic_calls`, `event_groups`, `inherits`, `form`… | informations de contexte |

Les fonctions natives de Gambas (`Abs`, `Replace`, `Exist`…) ont priorité sur une méthode homonyme pour
un appel nu ; elles sont exclues du contrôle d'arité. Seules les chaînes citées dans un appel dynamique
(`Object.Call`, `Object.SetProperty`, `Object.GetProperty`…) protègent un membre de la « portée réductible ».

## Limites de `deps.py`

- La résolution se fait par nom de classe (`Classe.Membre`) ou par variable typée dans le fichier (`Dim h As Classe`).
  Les objets non typés (`Object`, `Variant`, `Last`) et les appels dynamiques (`Object.Call`…) ne sont pas résolus :
  les appels dynamiques sont signalés, et tout nom cité en chaîne littérale est exclu de la « portée réductible ».
- Une même variable locale typée différemment selon les fonctions peut produire des membres `<inconnu:…>`.
- La « portée réductible » est une **suggestion** à confirmer par `grep` avant tout rework.
- Le type d'une variable déclarée dans une fonction (`Dim`, paramètre) ne vaut que dans cette fonction ;
  `obj.Membre` ne compte comme référence interne que si `obj` est `Me`, la classe elle-même ou une variable
  du même type.
- Non détectés (relevés au lot Gestion-2) : appels de méthode sans parenthèses (arité), arité des fonctions
  natives (`Error.Raise`), accès via `Variant`/`AutresObj[…]`, propriétés jamais utilisées, boutons du `.form`
  sans handler, colonnes SQL inexistantes ou ambiguës, handlers surchargés d'un report parent.
- Non détectés (relevés pendant la phase 1, à vérifier à la main) :
  - handlers attachés dynamiquement par une classe de base (`SaiTableau.evenement`,
    `Object.Attach(obj, Me, Utils.Accent(name))`) : faux `unused` et fausses « portée réductible » (ex. `Achat`) ;
  - événement non vérifié contre la classe du contrôle (un `TextBox` n'a pas `Click`) ;
  - `New X(…)` non comparé à `X._new` : dans une classe `Form`, l'argument en trop devient le `Parent`
    (cas `New ConVendeurs(True)` → erreur de type) ;
  - homonymes à la casse près entre un contrôle et une classe (`TypeC`/`Typec`, `Comment`), entre un module
    et un contrôle (`Site`), entre une méthode et une classe (`Stockmvt.TriArticles`) ;
  - tables nommées par concaténation (`"Fiches_Bl" & "M"`) ou par variable (tables de travail) ;
  - membre inexistant d'un module (`Start.Soc`) et `db.Exec` (classe `DB` de gb.db au lieu de `Utils.db`) ;
  - handlers dont le seul contrôle est invisible, ou dans un panneau jamais affiché.

`reference/data/` contient les données générées au commit initial `6b6b9dfc` (`kpi_initial.json`, `deps.json`).
