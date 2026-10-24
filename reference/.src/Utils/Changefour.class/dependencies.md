# Changefour — Dépendances

> Source : `.src/Utils/Changefour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Changefour.class` — classe, formulaire associé `Changefour.form`
- Handlers GUI détectés : 9

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Start` | `Musique`, `son` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `Utils` | `Find_cbarre`, `Observers`, `db` |
| `Variables` | `Bsel` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`art_man`, `AjoutArt`, `SelectionArt`, `SelectionFour`, `SelectionFour2`, `SelectionFour3`, `fourman`, `Change`, `Change2`, `Change3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant réel** (manqué par l'heuristique) : `Fmenu.class:2345` (`Changefour.ShowModal()`).
- **Faux positifs « portée réductible »** : `Bsel`/`Bval` (écrits par `TriArticles` et `TriCpt` via
  `Object.SetProperty`, `.src/Affichages/TriCpt.class:112-113`), `Cmpt_KeyPress` et `Btn_Click`
  (handlers des groupes `Cmpt`/`Btn` du `.form`), `Bouton1..3_Click` (boutons dynamiques).
- `Variables.Bsel` est écrit (ligne 206) mais sans lien avec la sélection réelle (`Me.Bsel`).
- **Tables** : `CFour` (temporaire de session) absente de `Cbase` et de `db_control.csv`.
- **Ordre de rework** : avec `Changefam` (commonalisation CHANGEFAM-005). Pas de dépendance
  circulaire.
