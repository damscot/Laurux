# ConsultArt — Dépendances

> Source : `.src/Gestion/Tables/ConsultArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/ConsultArt.class` — classe, formulaire associé `ConsultArt.form`
- Handlers GUI détectés : 33
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ref`, `art_man`, `Decimal`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colarts_Click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `FamMan`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CPrix` | `CTva` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Base`, `CDec`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `ObsLstf2`, `Observers`, `cpoint`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Ligcom`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deb2`, `Deb3`, `Deb4`, `FamMan`, `fourMan`, `Maj_Zones`, `Fam2`, `Refresh`, `CleanChamps`, `Dbclk`, `entete`, `Ref`, `art_man`, `Decimal`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.lblClm2_MouseDown` (`Fmenu.class:1561`), `ConsultArt.Show` sur
  l'auto-instance (non modal).
- **Code mort confirmé** : `Ref`, `art_man`, `Decimal` (`unused`) ; `FamMan` n'est référencée que par
  `art_man`, donc morte aussi (l'heuristique ne propage pas l'inutilisation).
- **Portée réductible** : la liste de `deps.py` est confirmée par grep pour `Tris`, `Deb2`, `Deb3`,
  `Deb4`, `Fam2`, `fourMan`, `Maj_Zones`, `CleanChamps`, `Dbclk`, `entete` ; `Refresh` surcharge la
  méthode héritée du formulaire (à vérifier avec `gbc3` avant tout changement).
- **Appel dynamique entrant** : `Colarts_Click` (`GridView`) est appelé par
  `ReplayObserver.Replay_Click` via `Object.Call` : nom et portée `Public` intouchables.
- **Dépendance cachée** : `Utils.rs1`, résultat global rempli par `Utils.Base` (`Utils.module:39`)
  et relu par `Colarts_Data` ; `deps.py` voit l'appel `Utils.Base` mais pas le partage de `rs1` avec
  les autres écrans (CONSULTART-A05).
- **Tables** : toutes en dur, lecture seule ; la requête de liste passe par `Cbase.Table("TabArt")`.
- **Groupes du `.form`** : `Cmpt` (`Poids`, `Poids2`), `Ard` (`Dec`, `Nbd`, `Vol`), `ard` (`Arr`)
  n'ont aucun handler dans la classe (événements non traités, sans conséquence).
- Ordre de rework : CONSULTART-008 après ARTICLES-008 ; le reste est indépendant. Une
  commonalisation plus large avec `Articles` (lecture « article + famille + TVA ») est à décider en
  phase 3.
