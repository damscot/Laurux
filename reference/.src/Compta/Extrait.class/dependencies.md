# Extrait — Dépendances

> Source : `.src/Compta/Extrait.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Extrait.class` — classe, formulaire associé `Extrait.form`
- Handlers GUI détectés : 37
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Compdate`, `compdate2`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colcli`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Compta/Saisecrit.class` | `<type>` |
| `.src/Compta/Tresor.class` | `<type>` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Journaux` | `<hérité>` |
| `LDate` | `<type>`, `Apres`, `Avant`, `FinMois`, `G`, `L`, `_call` |
| `LGed` | `<type>`, `Clients`, `Comptabilite`, `Fournisseurs`, `Ouvrir`, `Search` |
| `Lettrage` | `<type>` |
| `Listextcpt` | `<type>`, `litleres`, `resext` |
| `ProgBar` | `<type>` |
| `Saisecrit` | `<type>` |
| `Start` | `B`, `G`, `LocalSettings`, `Musique`, `R`, `Societe`, `son` |
| `Tresor` | `<type>` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `Utils` | `Cdate_Comp`, `Cdate_Dbase`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Four`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `cpt_LF`, `Compdate`, `compdate2`, `compteman`, `clear`, `affichage`, `aff`, `Centralisation`, `finmois`, `Raz`, `Appel_Saisie`, `Appel_Tresor`, `sCmpt`, `sDesg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants (tous `New Extrait(…)` + `ShowModal`) : `Fmenu.Menu16_Click` (`Fmenu.class:725-727`,
  sans compte), `Saisecrit` (`Saisecrit.class:1200`, F8), `Tresor` (`Tresor.class:933`, F8),
  `FClient` (`FClient.class:3254`, `Org = "S"`, type `C`). La signature de `_New` est donc liée à
  ces quatre fichiers.
- **Faux positif `deps.py`** : `Bsel` et `Bval` sont signalés réductibles, mais `TriCpt` les
  écrit par `Object.SetProperty($obj, "Bsel"/"Bval", …)` (`TriCpt.class:112-113`) ; ils doivent
  rester `Public`. `sCmpt` et `sDesg` sont réellement inutilisés (les références
  `Comptabilite.sCmpt` du projet visent une autre classe).
- `Journaux` (`Necrit_Click`, l. 1210) : référence à l'auto-instance du formulaire d'impression
  `Compta/Impressions/Journaux`, pas à un contrôle local ; la lecture de `.Visible` instancie ce
  formulaire (caché) s'il ne l'était pas.
- Tables : `Fiches_Societes`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Comptes`, `Fiches_Mvt`,
  `Fiches_Parametres` (en dur) ; **non détectée** : `Ctrln` (table de travail créée/détruite à
  chaque affichage centralisé). `Fiches_Mvt1`…`Mvt5` sont lues indirectement par `Listextcpt`.
- Événements par groupe : `cmpt` (observateurs sur `dteN0`, `dten1`, `cpt`) et `nmoins`
  (`N1`…`N5`, `Tag` = nom du champ `dteclecX`) : ces handlers ne doivent pas être renommés.
- Ordre de rework : après `Listextcpt` (fournisseur des données) et `LDate` ; les reworks
  d'API de `_New` imposent de modifier `Fmenu`, `Saisecrit`, `Tresor`, `FClient` dans le même
  commit (aucun n'est proposé ici).
