# calculdroit1 — Dépendances

> Source : `.src/Gestion/option/calculdroit1.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/calculdroit1.class` — classe, hérite de `LPrix`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>`, `accise_droit`, `drsurfac`, `opt` |
| `.src/Gestion/Entrées/Achat.class` | `code`, `degre`, `secu_droit`, `volume_total` |
| `.src/Gestion/option/Consigne.class` | `<type>`, `code`, `opt` |
| `.src/Gestion/option/fourconsdroi.class` | `code` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LPrix` | `<type>`, `Add_Taxe`, `Arr_0001`, `Cpt`, `Mnt`, `Qte`, `Sub` |
| `LTaxe` | `<type>`, `DA`, `Regie`, `Remise`, `SS`, `TVA` |
| `Utils` | `Option`, `db` |

### Tables SQL référencées

`Fiches_Parametres`, `Fiches_Tvaav`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`taxe_droit`, `famille`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants réels** (vérifiés par `grep`) :
  - `Moulinage` (`Moulinage.class:2675`, `:2803-2806`) : `New Calculdroit1(qt, quantite, art_cdarr,
    "", art_dra, art_volm, art_deg, art_fam)` (8 arguments : 4 pour `LPrix`, 4 pour
    `calculdroit1`), puis `drsurfac`, `accise_droit`, `Mnt`, `G`, `TotBTC`, `opt` ;
  - `Consigne` (héritage, `Consigne.class:3`) et, à travers lui, `Achat` (`code`, `volume`,
    `degre`, `qte`, `volume_total`, `secu_droit` via `Sailig.AutresObj[Achat.Consignes].ccd`,
    `Achat.class:216-219`, `:617`, `:958-970`, `:1220`) et `ValidBR1` (propriétés de `LPrix`).
- **Faux positifs** : `deps.py` attribue à `calculdroit1` les références `code` de
  `Consigne.class:30,35,36` (paramètre local) et de `fourconsdroi.class:123,207,208,213` (champ de
  la structure `fourconsdroi.consigne`).
- **Portée réductible annoncée** : `taxe_droit` (confirmé, aucun appel externe) ; `famille`
  (variable jamais lue, confirmé).
- Propriétés `droit` et `secu` : aucun lecteur sur une variable typée `calculdroit1` ou `Consigne`
  (les nombreux `.droit`/`.secu` du projet portent sur `calculdroit`). Non signalées par `deps.py`
  (propriétés).
- Dépendance d'héritage : `calculdroit1` → `LPrix` ; `Consigne` → `calculdroit1`. Le
  constructeur dépend de l'ordre des paramètres de `LPrix._New`.
- `Error.Raise` à deux arguments (l. 51, 54) : non vu par le contrôle d'arité (méthode native).
- Ordre de rework : après `LPrix`/`LTaxe` ; avant `Consigne`, `Achat`, `ValidBR1` et `Moulinage`
  (lot Caisse).
