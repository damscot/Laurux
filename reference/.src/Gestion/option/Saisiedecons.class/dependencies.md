# Saisiedecons — Dépendances

> Source : `.src/Gestion/option/Saisiedecons.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Saisiedecons.class` — classe, formulaire associé `Saisiedecons.form`
- Handlers GUI détectés : 26
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `FCalc` | `<type>`, `Resultat` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Fournisseur`, `Sans_Solde` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db`, `totobs` |
| `calculdroit` | `<type>`, `droit`, `drsurfac` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Ligrecpt`, `Fiches_consigne`, `Fiches_ligcons`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Ouverture unique : `menuopt.class:51` (`Saisiedecons.Show`, auto-instance, sans argument) ; les
  paramètres optionnels de `_new` ne sont jamais fournis.
- `Bsel`/`Bval` écrits par `TriCpt` et `TriArticles` via `Object.SetProperty` (`Me` passé en
  dernier argument) : doivent rester `Public`.
- **Contrôles créés par code** : grilles `As "rechbl"` et `As "rechcons"` dans des fenêtres `$win`
  ⇒ handlers `rechbl_keypress`, `rechbl_click`, `rechcons_click` (non rattachés au `.form`). Créées
  après `Utils.Observers(Me)`, elles ne sont pas journalisées (rejeu impossible de ces clics).
  Homonymie : `rechcons` est aussi le nom d'une classe (sans lien ici).
- Observateurs `saisie` et `consigne` (`consigne_click`) : `Last` désigne le contrôle observé
  (bouton bascule portant le type dans `Tag`).
- `replay_missing` : `GridView1` sans `GridView1_Click` (sélection par `GridView1_Activate`, Suppr
  par `GridView1_KeyPress`).
- `FCalc` : F5 dans `saisie_keypress` (idiome commun aux 7 appelants, voir FCALC-005).
- `calculdroit` : `New Calculdroit(art_dra, art_volm, art_deg, qte)` (`:281`), propriétés `drsurfac`,
  `droit`.
- Écrit `Fiches_ligcons` (lu par `Consigne`, `Edconsigne`, `ValidBR1`) et `Fiches_Entrecpt`
  (montants relus par `ValidBR1.ValideSaisie` pour la comptabilisation).
