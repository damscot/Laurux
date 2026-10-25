# Caleditcmat — Dépendances

> Source : `.src/Gestion/option/Caleditcmat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Caleditcmat.class` — classe, formulaire associé `Caleditcmat.form`
- Handlers GUI détectés : 10

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/Ecomptamat.class` | `ddcl` |
| `.src/Gestion/option/Einvmat.class` | `ddcl` |
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Exec` |
| `Ecomptamat` | `<type>` |
| `EditStkDepart` | `<type>`, `depart`, `fin`, `inventaire`, `tournant` |
| `Einvmat` | `<type>` |
| `LDate` | `<type>`, `Apres`, `D`, `FinMois`, `G`, `_call` |
| `ObjFac` | `dtedoc`, `facture`, `ligne`, `numcli` |
| `ObjFacB` | `<type>`, `calcul` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `B`, `G`, `R` |
| `TextReg` | `<form>`, `EstNum`, `Select`, `Text`, `Type`, `Value`, `reg` |
| `Utils` | `db` |
| `Visualiseur` | `Prog` |
| `Visucmat` | `<hérité>` |
| `calculdroit` | `<type>`, `droit`, `secu`, `vol`, `volap`, `volumess` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_ligregie`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `menuopt.cmat_click` (`menuopt.class:69`, `Caleditcmat.ShowModal`) : auto-instance.
- **`ddcl`** : seuls utilisateurs `Ecomptamat` (lignes 74-320) et `Einvmat` (lignes 62-231), qui
  l'écrivent et le relisent dans chaque handler `Data`. Comme l'écran est ouvert par son
  auto-instance, l'accès `Caleditcmat.ddcl` ne crée pas de second formulaire ; une ouverture par
  `New Caleditcmat` en créerait un caché. Ordre : EINVMAT-002 et ECOMPTAMAT-002 avant
  CALEDITCMAT-005.
- **Dépendance circulaire** `Caleditcmat` ↔ `Ecomptamat`/`Einvmat` (création des reports / lecture
  de `ddcl` et de la structure `Declaration`).
- **Appels sortants non vus** : `ObjFacB` (constructeur hérité d'`ObjFac`, `calcul`, `ligne`,
  `dtedoc`, `numcli`), `Calculdroit` (requêtes sur `Fiches_regie`, `Fiches_Tvaav`,
  `Fiches_Parametres`), `EditStkDepart`, `Visucmat`, `Visualiseur.Prog`, `ProgBar`. Un rework de
  `calculdroit` ou d'`ObjFacB`/`ObjFac` change les montants imprimés et contrôlés ici : repasser
  les tests de ce fichier.
- **Groupe** : `stdep_Click` est levé par le contrôle `Button3` (groupe `stdep` dans le `.form`).
- **SQLite** : l'`UPDATE` multi-tables (ligne 240) n'est pas traduit par `DB_Connection`.
