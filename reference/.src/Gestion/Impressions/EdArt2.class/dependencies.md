# EdArt2 — Dépendances

> Source : `.src/Gestion/Impressions/EdArt2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdArt2.class` — classe, formulaire associé `EdArt2.form`
- Handlers GUI détectés : 19
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Footer`, `Level8`, `Level8bis`, `Level9`, `Level9bis`, `Ligne2`, `Photo` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Find_nbdec`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`SelectionArt`, `art_man`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (`used_by` vide, confirmé par `grep -rni edart2 .src`). Le menu Tarif > Client
  (`Fmenu.Menu74_Click`, `Fmenu.class:863`) ouvre `EdArt4` depuis le commit `29df3a6d`. `deps.py`
  ne signale pas le fichier comme mort car ses handlers (levés par Gambas) masquent l'absence
  d'ouverture : le critère « formulaire jamais instancié ni montré » n'est pas calculé (limite
  d'outillage).
- **Utilise** : `Carticles` (`Level8`, `Level8bis`, `Level9`, `Level9bis`, `Ligne2`, `Photo`,
  `Entete`, `Footer`) ; ces 5 méthodes `Level8*`/`Level9*`/`Ligne2` de `Carticles` ne sont appelées que
  par ce fichier. `TriArticles` (`Bsel`/`Bval`), `Utils`, `Cbase`, `Visualiseur`, `Doc`.
- **Tables** : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four` (lecture seule, noms en dur sauf
  `art_man`).
- **Rejeu** : `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click` dans
  `replay_dynamic` (sans objet si le fichier est supprimé).
- **Portée** : `SelectionArt`, `art_man`, `Button2_Click` sans appelant externe.
- **Ordre de rework** : décider EDART2-A01 avant tout rework d'`EdArt1`/`EdArt3` (le socle commun
  n'a pas à couvrir `EdArt2` s'il est supprimé).
