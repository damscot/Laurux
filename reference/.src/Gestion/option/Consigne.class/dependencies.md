# Consigne — Dépendances

> Source : `.src/Gestion/option/Consigne.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Consigne.class` — classe, hérite de `Calculdroit1`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `LecCons`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Entrées/Achat.class` | `<type>`, `cdecol`, `cdepal`, `cdeunit`, `consigne_montant`, `nbcol`, `nbpal` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `cdecol`, `cdepal`, `cdeunit`, `consigne`, `nbcol`, `nbpal`, `recupcol`, `recuppalette` |
| `.src/Gestion/option/fourconsdroi.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LPrix` | `<type>`, `Qte`, `Sub` |
| `LTaxe` | `<type>`, `Consigne` |
| `Utils` | `db` |
| `calculdroit1` | `<type>`, `code`, `opt` |

### Tables SQL référencées

`Fiches_consigne`, `Fiches_ligcons`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Accès `Variant` non résolus** : `Achat` manipule la consigne de chaque ligne via
  `Sailig.AutresObj[Achat.Consignes].ccd` (`Achat.class:213-222`, `:289`, `:957`) : affectations
  `ccd.volume`, `ccd.code`, `ccd.degre`, `ccd.qte`, `ccd.cdepal`, `ccd.cdecol`, `ccd.cdeunit`
  (membres hérités de `calculdroit1`/`LPrix` compris). `deps.py` ne voit que les lignes typées
  (`Dim cdd As Consigne`, `Achat.class:929`).
- **Constructeur à 13 arguments** (`Achat.class:214`) : ordre LPrix (4) → calculdroit1 (4) →
  Consigne (5). Toute modification de signature d'un des trois `_new` décale les arguments
  d'`Achat`.
- **Faux positifs `deps.py`** :
  - `fourconsdroi.class:22-24,44,116,119,203` (`<type>`) et `<hérité:nb>`, `<hérité:montant>` :
    il s'agit de la **structure** `fourconsdroi.consigne` (`Public Struct consigne`, homonyme à la
    casse près), pas de cette classe ;
  - `calculdroit1` « utilisé par » `Consigne.class:30,35,36` (`code`) : ce sont le paramètre local
    `code` de `consigne_montant`, pas la propriété héritée.
- Appelants réels (vérifiés par `grep`) : `Achat` (`:8`, `:214`, `:929`, `:975-977`, `:983`,
  `:994`), `ValidBR1` (`:374`, `:414`, `:424-429`). Aucun appel dynamique.
- **Héritage** : `Consigne` → `calculdroit1` → `LPrix`. Les reworks de `LPrix` (LPRIX-A01 sur
  `_call`) et de `calculdroit1` (CALCULDROIT1-A01, drapeau `opt`) ont un effet direct sur les
  montants de consigne.
- Tables et colonnes de l'option boissons créées à l'exécution par `modfichier.fichierboisson`
  (appelé par `Prefs.class:1355`) : absentes de `db_control.csv` et de `Laurux01.sql`.
- Ordre de rework : après `LPrix`/`LTaxe` et `calculdroit1` ; avant ou avec `Achat` et `ValidBR1`
  (même jeu de tests de réception).
