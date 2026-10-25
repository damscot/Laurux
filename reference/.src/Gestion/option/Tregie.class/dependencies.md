# Tregie — Dépendances

> Source : `.src/Gestion/option/Tregie.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Tregie.class` — classe, formulaire associé `Tregie.form`
- Handlers GUI détectés : 22
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`, `GridView2`, `ListBox1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `PdfWriter` | `<type>`, `AddPage`, `AliasNbPages`, `Cell`, `Open`, `Output`, `SetFont`, `SetXY` |
| `Start` | `LocalSettings`, `Societe` |
| `TriCpt` | `<type>`, `Bilan`, `Sans_Solde` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db`, `mois` |
| `Visualiseur` | `Prog` |
| `barselection` | `<type>`, `estcreer`, `estmodif` |
| `calculdroit` | `<type>`, `droit`, `secu` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Comptes`, `Fiches_Parametres`, `Fiches_Tvaav`, `Fiches_regie`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Ouverture unique : `menuopt.class:45` (`Tregie.Show`, auto-instance) ; le menu porte le nom
  d'événement `"Tregie"` (`menuopt.class:14`), homonyme sans lien.
- `Bsel`/`Bval` écrits par `TriCpt` via `Object.SetProperty` (`Buttccomp_Click` passe `Me`) :
  doivent rester `Public`.
- Événements `bar1_*` levés par `barselection` ; `bar1_recherche` absent (bouton masqué).
- **Arité non détectée** : `form_Close` appelle `bar1_valide` sans argument (`Tregie.class:406`).
- `replay_missing` : `GridView1`, `GridView2` (jamais remplies, sans intérêt pour le rejeu) et
  `ListBox1` (liste des TVA, sans `ListBox1_Click`) : les scénarios doivent sélectionner la TVA par
  activation (double-clic/Entrée, `ListBox1_Activate`) ou saisir le code directement.
- Lecteurs de `Fiches_regie` : `calculdroit`, `calculdroit1`, `artopt`, `facopt`, `Utils.module`
  (`:1338` et suivantes).
- `modifart` réécrit `Fiches_Art` (prix, coefficient, droits) : effet sur tous les écrans de prix ;
  ordre de rework après `calculdroit`.
