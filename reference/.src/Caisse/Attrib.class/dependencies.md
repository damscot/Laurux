# Attrib — Dépendances

> Source : `.src/Caisse/Attrib.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Attrib.class` — classe, formulaire associé `Attrib.form`
- Handlers GUI détectés : 13

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Cmenu.class` | `<hérité>` |
| `.src/Utils/FSetFormat.class` | `fnd` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CFormat` | `<type>`, `Background`, `Foreground`, `_get` |
| `Caisse` | `origine` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `FSetFormat` | `Run` |
| `ImageButton` | `<form>`, `<type>`, `BackGround`, `Picture`, `Text` |
| `Start` | `$tcai`, `LocalSettings`, `Societe` |
| `TriArticles` | `<type>` |
| `Utils` | `Observers`, `convBool`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Touches`

### Membres Public sans usage externe détecté (portée réductible ?)

`createPanel`, `Init`, `TestArt`, `Cbutton`, `Init2`, `Fond_ImageButton`, `Libellearticle`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** (vérifié) : `Cmenu.ControleCai` (`Cmenu.class:177`, `Attrib.ShowModal()`, auto-instance),
  seulement si `Start.$Tcai` est renseigné.
- **Membres lus de l'extérieur** :
  - `Attrib.fnd` par `FSetFormat.Lgo2_Click` (`FSetFormat.class:72`) : l'`UPDATE … SET fond WHERE
    touche = &2` de `FSetFormat` **n'a pas de filtre `cai`** → l'image est appliquée à la même touche
    de toutes les caisses (ATTRIB-A03, correction dans `FSetFormat`). Dépendance circulaire
    `Attrib` ↔ `FSetFormat` par auto-instances.
  - `Bsel`/`Bval` écrits par `TriArticles` via `Object.SetProperty` (`TriArticles.class:30-31`,
    `165-166`) : appel dynamique non vu par `deps.py`, ces membres doivent rester `Public`.
  - `Libellearticle` : lu ici, écrit par personne (`grep -rni libellearticle .src`) → ATTRIB-A04.
- **`Caisse.origine`** : `deps.py` le compte comme usage de `Caisse` ; le membre n'est jamais lu
  (`Caisse.class:121`, seuls des paramètres homonymes sont utilisés) et l'écriture vise
  l'auto-instance (ATTRIB-A06).
- **Tables** : `Fiches_Touches` (aussi lue par `Caisse` pour le clavier de vente et écrite par
  `FSetFormat`), `Fiches_Art` (nom en dur dans `TestArt`).
- **Groupes et contrôles dynamiques** : `Clav2` (touches du `.form`), `Clav3` (touches créées par
  `New (ImageButton, hpan) As "Clav3"`). `ImageButton` (lot Caisse) ne déclare que l'événement
  `Click` : la levée de `DblClick` (`Clav2_Dblclick`/`Clav3_Dblclick`) est à confirmer.
- Aucun `arity_errors` (le `New TriArticles(…)` à 9 arguments est correct), aucun `unused`,
  `unused_transitive`, `handlers_inactifs`, `replay_dynamic`, `replay_missing`, `sql_params`.
- **Portée réductible** (vérifiée) : `createPanel`, `Init`, `TestArt`, `Cbutton`, `Init2`,
  `Fond_ImageButton` ; `Libellearticle` dépend d'A04.
- **Ordre de rework** : ATTRIB-A03 avec `FSetFormat` (lot Utils, déjà commité : à reporter dans sa
  documentation) ; la commonalisation `CFormat.Applique` avec `SetColors`/`FSetFormat`/`RichDataGrid`.
