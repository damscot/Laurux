# ImpJdv — Dépendances

> Source : `.src/Compta/Utils/ImpJdv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/ImpJdv.class` — classe, formulaire associé `ImpJdv.form`
- Handlers GUI détectés : 4
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 205 `Cclients.Level2` (12 donnés, attendus 13)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `header`, `content1`, `content0`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `coljour_Click`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 268 (1 argument(s), marqueurs aucun)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cclients` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Dbase`, `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Import`, `Sauve`, `Creation_Client`, `Maj_Client`, `Controle`, `Compta`, `Parametres`, `Ecritures`, `Maj_Parametres`, `Majnum`, `header`, `content1`, `content0`, `footer`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu134_Click` (`Fmenu.class:1344`, `ImpJdv.ShowModal`, menu « Import du
  JDV Laurux », visible si `/Exp` est faux). Aucun accès `ImpJdv.<membre>` ailleurs (`grep`), donc
  toutes les fonctions non handler sont réductibles, y compris `Compta`, `Parametres`, `Ecritures`
  que `deps.py` ne marque pas (homonymes probables dans d'autres fichiers).
- **Couplage de format** avec `ExportJdv` (type « 1- Fichier texte ») : `clients.txt` et
  `ecritures<JJ>.csv`. Le rework de l'un impose de rejouer les tests de l'autre (aller-retour
  EXPORTJDV-T15 / IMPJDV-T06).
- `Cclients.Level2` (`.src/Reports/Cclients.class:64`) a 13 paramètres obligatoires (`reglt` ajouté
  par le commit `087d438a`, 2016) ; l'appel l.205 n'en passe que 12. `deps.py` ne contrôle pas
  l'arité : à vérifier à l'exécution (IMPJDV-A04).
- Non détectés par `deps.py` : commande externe `mysqldump` (Shell), table de travail `Nvcompte`,
  fichiers `clients.txt`, `ecritures<JJ>.csv`, `Nvcomptes.txt`, `rejets.txt`,
  `~/tmp/Edclients.pdf`, `<rep>/Laurux_dump.sql<date>`.
- `Fiches_Parametres.dnfac` écrit ici (A01) est lu par `Caisse/Moulinage.class:2682` et
  `EcrAuto` (`LockIncrement("dnfac")`) : impact transverse sur la numérotation des factures.
- Duplication quasi complète avec `ImpSage` : rework conjoint (même lot en phase 3).
- Aucun appel dynamique ; pas de dépendance circulaire.
