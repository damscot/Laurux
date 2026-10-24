# Journaux — Dépendances

> Source : `.src/Compta/Impressions/Journaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Journaux.class` — classe, formulaire associé `Journaux.form`
- Handlers GUI détectés : 18
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Createtable`, `donnees1`, `donnees2`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `coljour_Click`, `coljour2_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ListBox1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Extrait.class` | `<hérité>` |
| `.src/Compta/Impressions/EcrM.class` | `<hérité>` |
| `.src/Compta/Impressions/JournauxM.module` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `JournauxM` | `Imprime` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `cpoint`, `db` |
| `journauxSetting` | `<hérité>` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `Cpt_GotFocus`, `Cpt_LostFocus`, `Cpt2_GotFocus`, `Cpt2_LostFocus`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `Createtable`, `Button1_Click`, `Raz`, `donnees1`, `donnees2`, `donnees3`, `Button2_Click`, `Colonnes`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Formulaire** : `Journaux.form` (groupes d'événements `Btn` et `Cmpt` ; `Panel2`, `ListBox1`,
  `coljour`, `coljour2`). Les 29 handlers gardent leur nom et leur portée `Public`.
- **Utilisé par** (vérifié par grep) : `Fmenu.Menu32_Click` (`journaux.Show`, l. 747) ;
  `JournauxM.Imprime` (`Journaux.Mouse`, l. 70 et 314) ; `EcrM` (`Journaux.Mouse`, l. 419 et
  570) ; `Extrait` (`Journaux.visible`, l. 1210). Ces trois derniers accès **instancient**
  l'auto-instance cachée si l'écran n'est pas ouvert (exécution de `_New` : requête
  `Fiches_Parametres`, lecture de la configuration d'export). À reporter dans la doc d'`EcrM` et
  d'`Extrait`.
- **Dépendance circulaire** `Journaux` ↔ `JournauxM` (curseur) : même lot de rework.
- **Utilise** (non vu ou mal typé par `deps.py`) : `journauxSetting.ShowModal` (auto-instance
  modale, l. 788) ; `Music` (son) ; table de travail `centralisation` (DDL dans
  `Button4_Click`) ; les tables `Fiches_Mvt1`…`Fiches_Mvt5` sont citées en chaînes littérales
  (`Tab0`), sans `Cbase.Table`.
- **Configuration** : clés `/ExportJournal<société>/Entete0..15` et `/Titre0..15` partagées avec
  `journauxSetting` (écrites là-bas, lues ici) ; contrat à préserver.
- **Portée réductible** : la liste `deps.py` est confirmée par grep. `Raz` n'y figure pas (nom
  homonyme dans d'autres fichiers) mais n'a pas non plus d'appelant externe.
