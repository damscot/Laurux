# EdArt1 — Dépendances

> Source : `.src/Gestion/Impressions/EdArt1.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdArt1.class` — classe, formulaire associé `EdArt1.form`
- Handlers GUI détectés : 19
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Footer`, `Level10`, `Level6`, `Level6M`, `Level6bis`, `Level7`, `Level7M`, `Level7bis`, `Ligne`, `Photo` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Coulfd`, `Fcolr`, `Find_nbdec`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |
| `textfamille` | `<form>`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionArt`, `art_man`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu73_Click` (`Fmenu.class:857`, `EdArt1.Show`, auto-instance non
  modale). Aucun autre usage (grep `EdArt1` dans `.src`).
- **Écrits entrants** : `TriArticles` (`.src/Affichages/TriArticles.class`) écrit `Bsel`/`Bval` par
  `Object.SetProperty` sur le formulaire passé en `Parent` : `Bsel` et `Bval` doivent rester
  `Public` (non vu par `deps.py`, qui ne les signale pas comme réductibles).
- **Classe de rendu** : `Carticles` (`Inherits PdfWriter`) : `Entete`, `Footer`, `Level6`,
  `Level6M`, `Level6bis`, `Level7`, `Level7M`, `Level7bis`, `Level10`, `Photo`, `Ligne`. Toute
  modification de leurs signatures touche aussi `EdArt2`, `EdArt3`, `EdStk`, `EdRup`, `Edmo`,
  `EdFam`, `Edregul`, `Edregulprdc` (`New CArticles` dans ces fichiers).
- **Tables** : `Fiches_Fam`, `Fiches_Four`, `Fiches_Art` sont nommées **en dur** (`Tab = …`) sauf
  dans `art_man` (`Cbase.Table("TabArt")`). Lecture seule : aucune écriture en base.
- **Contrôle composite** : `Fam`/`Fam2` sont des [`textfamille`](../../../Utils/textfamille.class/dependencies.md)
  (`.src/Utils/textfamille.class`) : leur construction fait `Quit` si `/Soc<XX>/ipr` est absent
  (TEXTFAMILLE-A01), ce qui ferme Laurux à l'ouverture de cet écran.
- **Handlers et rejeu** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click` sont
  appelés par `ReplayObserver` via `Object.Call` (`replay_dynamic`) : rester `Public`. Aucune grille
  sans `_Click` (`replay_missing` vide), aucun handler inactif, aucune fonction `unused`, aucune
  erreur d'arité.
- **Portée** : `deps.py` propose `SelectionArt`, `art_man`, `Button2_Click` : confirmés par grep
  (`Button2` est dans le groupe `btn`, donc `Button2_Click` n'est pas un handler).
- **Ordre de rework** : après `Carticles` (lot Reports) si ses en-têtes sont factorisés ; avec
  `EdArt3` et `EdStk` (socle commun).
