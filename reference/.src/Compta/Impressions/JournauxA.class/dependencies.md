# JournauxA — Dépendances

> Source : `.src/Compta/Impressions/JournauxA.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/JournauxA.class` — classe, formulaire associé `JournauxA.form`
- Handlers GUI détectés : 13
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 695 `Ccompta.level2J` (9 donnés, attendus 10)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `donnees1`, `donnees2`, `donnees3`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `coljour_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage2`, `Entete`, `Level0A`, `Level0J`, `Level1A`, `Level1J`, `Level2A`, `Lines`, `level2J`, `level6J`, `level7J` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_MvtA`, `Fiches_Parametres`, `Fiches_Postes`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `Aff_Postes`, `Cpt_GotFocus`, `Cpt_LostFocus`, `Cpt2_GotFocus`, `Cpt2_LostFocus`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `Create_table`, `Button1_click`, `Raz`, `Centralisation`, `donnees1`, `donnees2`, `donnees3`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Formulaire** : `JournauxA.form` (groupes `Btn` et `Cmpt`, `RadioButton1`/`RadioButton2`,
  `ToggleButton1`/`ToggleButton2`, `coljour`). Seul appelant : `Fmenu.Menu292_Click`
  (`JournauxA.ShowModal()`, l. 2266).
- **Surestimation de `deps.py`** : les tables `Fiches_Mvt` … `Fiches_Mvt5` sont citées (affectation
  de `Tab0`) mais **jamais interrogées** ; `Fiches_Journaux`, `Fiches_Societes`, `Fiches_Comptes`
  en dur (`Tab2`, `Tab4`, `Tab5`) sont des variables inutilisées : les requêtes passent par
  `Cbase.Table`.
- **Non vu par `deps.py`** : `Ccompta` (`Entete`, `Level0A`, `Level0J`, `Level1A`, `Level2A`,
  `Level1J`, `level2J`, `Lines`, `Baspage2`, `level6J`, `level7J`, `Output`) ; `Visualiseur.Prog` ;
  table `Fiches_MvtA` (`TabMvtA`) et `Fiches_Postes` (`TabPostes`) ; table de travail
  `centralisation` écrite.
- **Signature externe incompatible** : `Ccompta.level2J` (10 paramètres non optionnels) est appelée
  avec 9 arguments (l. 695). Si `Ccompta` est reworkée (paramètre `Nlot` rendu `Optional`), le
  comportement de `JournauxA` change : à traiter avec JOURNAUXA-A01.
- **Fichier PDF partagé** : `~/tmp/Journaux.pdf`, même chemin que `JournauxM` et `EcrM`.
- **Ordre de rework** : après le socle `ImpCompta` (JOURNAUX-003/004, JOURNAUXM-005/006).
