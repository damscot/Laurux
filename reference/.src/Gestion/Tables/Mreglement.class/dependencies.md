# Mreglement — Dépendances

> Source : `.src/Gestion/Tables/Mreglement.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Mreglement.class` — classe, formulaire associé `Mreglement.form`
- Handlers GUI détectés : 19
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `CodeCaisse2RegMode`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `recherche_Click`, `GridView1_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `CodeCais`, `Laision_Reg`, `RegCais`, `RegMode2CodeCaisse` |
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/LauruxMaj.module` | `lcr_acc`, `lcr_nacc` |
| `.src/Compta/Utils/EcrAuto.class` | `lcr_acc`, `sans_lcr` |
| `.src/Gestion/Facturation/SaiReg.class` | `autre`, `sans_caisse` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Start` | `LocalSettings`, `Societe` |
| `TextReg` | `<form>`, `MaxLength`, `Text`, `reg` |
| `TriCpt` | `<type>`, `Bilan`, `Sans_Solde` |
| `Utils` | `Observers`, `db` |
| `barselection` | `<type>`, `estcreer`, `estmodif` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Reglements`

### Membres Public sans usage externe détecté (portée réductible ?)

`CodeCaisse2RegMode`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Auto-instance cachée** : `Moulinage.Verif_Reglement_Caisse` et `Moulinage.Maj_Tresorerie`
  (`Moulinage.class:2495-2608`) lisent `RegCais`/`CodeCais` et appellent `RegMode2CodeCaisse`,
  `Laision_Reg` : ce sont des membres d'instance, Gambas crée donc l'auto-instance du formulaire
  (`_new` complet, sans affichage). Toute modification de `_new` a un effet sur le moulinage.
- Énumérations utilisées par `EcrAuto.class:556-557`, `LauruxMaj.module:5266`, `:5273` (migration :
  ne pas renommer), `SaiReg.class:974`, `:992`.
- `Bsel`/`Bval` sont écrits par `TriCpt` via `Object.SetProperty` (`Butint_Click` passe `Me`) :
  faux positif de portée réductible si on les retirait.
- `GridView1_Click` et `recherche_Click` rejoués par `ReplayObserver.Replay_Click` : doivent rester `Public`.
- Événements `bar1_*` levés par `Barselection` (`.src/Gestion/option/barselection.class`) ;
  `bar1_recherche` n'est jamais levé (bouton masqué par `"001110010"`).
- `CodeCaisse2RegMode` : jamais appelée (`unused`).
- Tables lues : `Fiches_Reglements`, `Fiches_Journaux`, `Fiches_Comptes` (noms en dur).
- Lecteurs de `Fiches_Reglements` : `FClient` (`:164`, `:1566`), `ObjFac` (`:361`), `SaiReg`,
  `EcrReg`, `EcrAuto`, `Echeancier`, `Moulinage`.
- Ordre de rework : la passe en `Static` du référentiel précède tout rework de `Moulinage`.
