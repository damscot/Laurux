# facopt — Dépendances

> Source : `.src/Gestion/option/facopt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/facopt.class` — classe
- Handlers GUI détectés : 16
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `majdroit`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `affcons`, `affdecons`, `affdroit`, `clicons`, `copdecons`, `deplig`, `imprime`, `majlig`, `numbl`, `suplig` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `TriArticles` | `<type>` |
| `Utils` | `ObsGotf`, `ObsLstf`, `db`, `totobs` |
| `calculdroit` | `<type>`, `droit`, `drsurfac`, `lib`, `secu`, `suspendu`, `tva`, `vol`, `volap` |
| `rechcons` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_consigne`, `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`majdroit`, `mabsaisie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Instanciation** : seul `Facture.modifpanel5` (`Facture:12289`, `New Facopt(Panelcons,
  Panelregi) As "option"`) ; événement `recalcul` → `Facture.option_recalcul` (`Facture:12464`).
- **Membres utilisés par `Facture`** (vérifié par `grep` sur `$opt.`) : `affcons`, `affdecons`,
  `affdroit`, `clicons`, `copdecons`, `deplig`, `imprime`, `majlig`, `numbl`, `suplig`. Les
  propriétés `texttotcons`, `texttotdeco`, `texttotdr`, `texttotss`, `tvadroit` n'apparaissent
  que dans du code commenté (`Facture:2561-2562`) ; `regie`, `consigne`, `artcons`, `textmondr`,
  `textmonss`, `lignedroit` nulle part → code mort.
- **`unused`** : `majdroit` confirmé (code mort, inexécutable). **`scope_reducible`** :
  `majdroit` (mort) et `mabsaisie` (appels internes seulement, confirmé).
- **Appels dynamiques** : `TriArticles` écrit `Bsel`/`Bval` par `Object.SetProperty` (doivent
  rester `Public`).
- **Contrôles créés par code** : grilles `gridregi`, `gridcons`, `gridsaisie` hors `.form` ;
  `replay_missing` ne les voit pas, aucune n'a de `_Click`.
- **Événements de `Rechcons`** : `rechcons_trouver` (groupe `"rechcons"`).
- **Tables** : toutes en littéral ; les tables de l'option sont créées par `modfichier`.
- **Ordre de rework** : avec `Facture` (appelant unique) ; `LitConsigne` commun avec `artopt`.

