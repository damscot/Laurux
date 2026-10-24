# ImpSage — Dépendances

> Source : `.src/Compta/Utils/ImpSage.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/ImpSage.class` — classe, formulaire associé `ImpSage.form`
- Handlers GUI détectés : 2
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Maj_Client`, `Maj_Parametres`, `header`, `content1`, `content0`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cclients` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2S`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Corsage`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Four`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Import_Sage`, `Sauve`, `Creation_Fournisseur`, `Creation_Client`, `Maj_Client`, `Controle`, `ControleS`, `ComptaS`, `Controle_tiers`, `Controle_journal`, `Parametres`, `Ecritures`, `Maj_Parametres`, `Majnum`, `header`, `content1`, `content0`, `footer`, `Button3_Click`, `Compteur`, `Compteurf`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu286_Click` (`Fmenu.class:2236`, `ImpSage.ShowModal()`, menu « Import
  écritures Sage »). Aucun accès `ImpSage.<membre>` ailleurs (`grep`) : la liste « portée
  réductible » de `deps.py` est confirmée, et `Parametres`/`Ecritures` sont aussi réductibles.
- Code mort confirmé par `grep` dans le fichier : `Maj_Client`, `Maj_Parametres`, `header`,
  `content1`, `content0` (aucun appel).
- `Cclients.Level2S` (11 paramètres) est appelé avec le bon nombre d'arguments (le code Sage est
  passé dans le paramètre `numcompte`).
- Non détectés par `deps.py` : commande `mysqldump` (Shell), table de travail `Nvcompte`, fichiers
  `clients.pnc`, `ecritures.pnm`, `Nvcomptes.txt`, `rejets.txt`, `~/tmp/Edclients.pdf`.
- `Corsage` est aussi créée et modifiée par des migrations de `LauruxMaj` (l.3328, 3431, 3740) :
  aucun rework ne doit y toucher.
- Duplication avec `ImpJdv` et `Impclient` (compteur, collectif) : rework conjoint dans le même lot
  de phase 3, après la création des helpers `Utils.DumpBase` et `ProchainCodeClient`.
- Aucun appel dynamique ; pas de dépendance circulaire.
