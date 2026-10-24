# Tresor — Dépendances

> Source : `.src/Compta/Tresor.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tresor.class` — classe, formulaire associé `Tresor.form`
- Handlers GUI détectés : 38
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Maj_Zones`, `Totsl`, `FileFilter`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Libview_Click`, `EcritL_Click`, `Choix1_Click`, `jour_Click`, `Colabt_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Ecrit1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Compta/Extrait.class` | `<type>` |
| `.src/Compta/Utils/Ecritures.class` | `<type>` |
| `.src/Compta/Utils/Fmontant.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Abont` | `Compteur_Incr` |
| `Cbase` | `Table` |
| `Comptabilite` | `Bsel`, `journal`, `libelle`, `snum` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `DocActif` | `Free_Lock`, `Get_Lock`, `Is_Lock` |
| `Extrait` | `<type>` |
| `FCalc` | `<type>`, `Resultat` |
| `FClient` | `<hérité>` |
| `FComptes` | `<hérité>` |
| `FFournisseur` | `<hérité>` |
| `LDate` | `<type>`, `EFin`, `G`, `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `LPrix` | `<type>`, `Abs`, `Add`, `_call` |
| `LVar` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `Listextcpt` | `<type>`, `Controle`, `letcpt`, `letgroupe`, `resext` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TextReg` | `<form>`, `MaxLength`, `Name`, `RechX`, `RechY`, `Select`, `Text`, `champs`, `condition`, `conteneur`, `recherche` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `TriEcritures` | `<type>` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `Remplace`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Four`, `Fiches_Journaux`, `Fiches_Libelles`, `Fiches_Ligabon`, `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Numabon`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `Lib`, `DelMvt`, `DelEcr`, `Cleanchamps`, `Movt`, `compte`, `compteman`, `Journauxman`, `Ecritures`, `Majnum`, `Journaux`, `Lettrage`, `Totsl`, `ecritnv`, `ecritv`, `comptetresorerie`, `Journal_GotFocus`, `Journal_LF`, `Datej_GotFocus`, `Datej_LF`, `numcompte_LF`, `Montant_LF`, `numdoc_LF`, `datee_GotFocus`, `datee_LF`, `QuitteDate`, `Button1_Click`, `ToggleButton4_Click`, `Calculsolde`, `Button2_Click`, `DelMvt2`, `Enrg_Ecr`, `Recup_Type`, `Ecrit_Click`, `ecrit2`, `Ecrit3`, `Lettre_Click`, `Quit_Click`, `Selct_Click`, `Necrit_Click`, `Clear`, `Suppr_Click`, `Button3_Click`, `Aff_Mask`, `Deb3`, `LignAbt`, `Type_compte`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelants réels** (vérifiés par `grep -rn "Tresor" .src`) :
  - saisie : `Fmenu.class:677` (`Menu22_Click`, contrôle préalable du tunnel de réplication) et
    `Extrait.class:1246` (`Appel_Tresor`, appelé l. 979) — `New Tresor("")` ;
  - modification d'une écriture validée : `Extrait.class:1218` (`Necrit_Click`),
    `Ecritures.class:400`, `Fmontant.class:202` — `New Tresor(num)` → `Ecrit3` dès le constructeur.
  Le constructeur `_new(num2 As String)` est donc l'unique API externe ; sa signature est figée par
  ces 5 appelants.
- **Faux positif de `deps.py`** : `Extrait.class:338` (`<hérité:showmodal>`) concerne un
  `Lettrage`, pas `Tresor` (variable `hForm` réutilisée) ; idem les homonymes `Tresor` variables
  locales de `ValidBR.class:969` et `Cielimp.class:278`.
- **Portée** : `Bsel`/`Bval` sont écrits par `Object.SetProperty` depuis `TriCpt.class:112-113`
  (faux positif « réductible »). `Journal_GotFocus`, `Datej_GotFocus`, `datee_GotFocus` ne sont pas
  des handlers (contrôles dans le groupe `Cmpt`) mais sont conservés `Public` par prudence ; toutes
  les autres méthodes signalées réductibles sont bien internes.
- **Handlers de groupe** : `Cmpt_*` (9 champs) et `Btn_*` (9 boutons) ; `btn_Enter` (casse
  différente) est relié au même groupe `Btn`.
- **Dépendances cachées** :
  - `Listextcpt` (`letgroupe`, `letcpt`, `Controle`, `resext`) met à jour `Fiches_Mvt1-5` : le
    lettrage d'une écriture de trésorerie peut toucher des factures d'exercices antérieurs ;
  - `Sha1Calc.CalcSha1` lit `Fiches_MvtM` ; `DocActif.Get_Lock`/`Free_Lock` écrivent dans la table
    des documents actifs ; `LGed` écrit dans les tables GED ;
  - `Abont.Compteur_Incr` (`Abont` est un formulaire, appel sur l'auto-instance) incrémente
    `Fiches_Numabon.compteur` ;
  - `Comptabilite` (module) sert de boîte aux lettres avec `TriEcritures` (`Bsel`, `snum`,
    `libelle`, `journal`).
- **Requêtes concaténées** : `compteman` (`LIKE '<saisie>%'`), `Ecritures`/`Majnum` (nom de colonne),
  `Button5_Click` (`fo_code = <compte>` sans guillemets).
- **Ordre de rework** : dépend de `LVar` (LVAR-004), de `Listextcpt` (lettrage) et des helpers
  communs à créer avec `Saisecrit`/`Trecarts` (solde, numérotation, archivage `MvtM`) ; à placer
  après eux en phase 3. Pas de dépendance circulaire (Tresor n'est appelé que par des écrans).
