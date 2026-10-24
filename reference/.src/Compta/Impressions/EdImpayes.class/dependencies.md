# EdImpayes — Dépendances

> Source : `.src/Compta/Impressions/EdImpayes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/EdImpayes.class` — classe, formulaire associé `EdImpayes.form`
- Handlers GUI détectés : 6
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cbl_GotFocus`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level3`, `Level4`, `Level5`, `Lines`, `level2` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Cbl_GotFocus`, `dteN0_LostFocus`, `dteN1_LostFocus`, `Raz`, `Bclient_Click`, `E0_Click`, `Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (confirmé par `grep -rn "EdImpayes" .src --include=*.class --include=*.module
  --include=*.form`) : ni menu, ni `New`, ni auto-instance. Le libellé de menu « Ecritures non
  lettrées » ouvre `EdNlettrees` (`Fmenu.Menu103_Click`, `Menu106_Click`). Le couple
  `EdImpayes.class`/`EdImpayes.form` est mort (historique git : dernière modification de fond avec
  l'intégration de la caisse, `f442d721`, puis `81ed3df5`).
- **Portée réductible** : `Ex1`, `E0_Click`, `Bclient_Click` (pas de contrôle correspondant),
  `Cbl_GotFocus` (pas de groupe `Cbl`, code mort) confirmés ; `Bsel`/`Bval` sont des faux positifs
  (écrits par `TriCpt` via `Object.SetProperty`).
- **Table de travail `Ctrln`** (omise par l'heuristique, nom dans une variable) : `DROP`/`CREATE`
  par compte imprimé, nom partagé avec Editcompte, EditcompteM, Extrait, FTVA (structures
  différentes) : EDITCOMPTE-A06. Sans effet réel puisque l'écran n'est jamais ouvert.
- La suppression du couple n'a **aucun** appelant à mettre à jour ; `gbc3 -agt` et
  `grep -rn EdImpayes` suffisent à la valider. Les fichiers `.lang`/`.pot` générés peuvent
  contenir ses chaînes (régénérés par l'IDE).
