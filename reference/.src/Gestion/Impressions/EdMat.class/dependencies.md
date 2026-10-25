# EdMat — Dépendances

> Source : `.src/Gestion/Impressions/EdMat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdMat.class` — classe, formulaire associé `EdMat.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColMarque_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriMat.class` | `Bsel`, `CodeMat` |
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cmat` | `<type>`, `Entete`, `Footer`, `Level1`, `Level2` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Client`, `Sans_Solde` |
| `TriMat` | `<type>` |
| `Utils` | `Find_nbdec`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Marques`, `Fiches_Materiels`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionProp`, `SelectionMat`, `Mat_man`, `Aff_Marques`, `Button2_Click`, `CClient`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** : `Fmenu.Menu289_Click` (`Fmenu.class:2254`, `EdMat.Show()`) et `TriMat`
  (`TriMat.class:380-382`, `Case "EdMat"` : `EdMat.Bsel = True`, `EdMat.CodeMat = …`) qui écrit sur
  l'**auto-instance** : `EdMat` doit rester ouvert par `EdMat.Show()` (auto-instance) pour que la
  sélection revienne dans le bon objet.
- **TriCpt** écrit `Bsel`/`Bval` par `Object.SetProperty` ; `CClient` n'est écrit par personne
  (grep `CClient`), ce que `deps.py` signale comme « portée réductible » : vrai, mais c'est le
  symptôme d'EDMAT-A01.
- **Tables** : `Fiches_Materiels` (`Tab` en dur et `Cbase.Table("TabMat")`), `Fiches_Marques` (en
  dur). Aucune table `*M` (bons/factures d'entretien). Lecture seule.
- **Rendu** : `Cmat` (`Inherits PdfWriter`) : `Entete`, `Level1`, `Level2`, `Footer` ; `Ligne` et
  `Ligne2` de `Cmat` non utilisés ici.
- **Rejeu** : `ColMarque_Click` (`replay_dynamic`) → `Public`. `replay_missing`, `unused`,
  `handlers_inactifs`, `arity_errors` vides. `deps.py` ne signale pas les boutons
  `ToggleButton7`/`ToggleButton8` sans handler (contrôles sans événement traité : limite).
- **Portée** : `SelectionProp`, `SelectionMat`, `Mat_man`, `Aff_Marques`, `Button2_Click`,
  `CClient` (variable) proposés réductibles : confirmés par grep.
- **Ordre de rework** : indépendant du socle tarif ; après `TriMat` si sa communication par
  auto-instance change (lot Affichages).
