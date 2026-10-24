# ExportJdv — Dépendances

> Source : `.src/Compta/Utils/ExportJdv.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/ExportJdv.class` — classe, formulaire associé `ExportJdv.form`
- Handlers GUI détectés : 8
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `cpt_LostFocus`
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 758 `ExportJdv.donnees4` (9 donnés, attendus 8), l. 1000 `EnvMail.Envoi3` (5 donnés, attendus 4)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `finmois`, `cpt_LostFocus`, `donnees7`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `coljour_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `EnvMail` | `Envoi2`, `Envoi3` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Accent`, `CSlash`, `Calc_mois`, `Cdate_Aff`, `Cdate_Cador`, `Cdate_Ciel`, `Cdate_Dbase`, `Cdate_Sage`, `Cdate_calc`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `finmois`, `Exo`, `cpt_GotFocus`, `cpt_LostFocus`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `donnees1`, `donnees2`, `donnees3`, `donnees4`, `donnees5`, `donnees6`, `donnees7`, `donnees8`, `Raz`, `Button2_Click`, `Controle`, `export`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu133_Click` (`Fmenu.class:1338`, `ExportJdv.ShowModal`, menu « Export
  des journaux », visible si `/Exp`). `grep -rn "ExportJdv\." .src` ne trouve aucun autre accès :
  la liste « portée réductible » de `deps.py` est confirmée et s'étend à `finmois`, `Raz`,
  `export` (non marquées car homonymes d'autres symboles).
- Handler inactif confirmé : `cpt_LostFocus` (contrôle `Cpt` du groupe `Cmpt`, aucun appel). Les
  autres handlers nominaux (`dteN0_*`, `dteN1_*`, `cpt_GotFocus`, `Button2_Click`,
  `Button3_Click`) sont appelés explicitement depuis `Cmpt_KeyPress`/`Btn_Click`.
- Non détectés par `deps.py` : table de travail `centralisations` (DDL et écritures, jamais relue
  ailleurs : `grep -rn centralisations .src`), commandes externes `chmod` et `cp` (Shell),
  fichiers produits `ecritures<JJ>.<ext>`, `clients.txt|.pnc`, `JDV<date>.<ext>`.
- **Couplage de format** : le format 1 est relu par `ImpJdv` (`clients.txt`, `ecritures<JJ>.csv`),
  le format 6 correspond à l'entrée d'`ImpSage`. Tout rework de formatage doit rejouer
  IMPJDV-T06 (aller-retour) et garder les fichiers octet pour octet.
- `/Soc<XX>/Numdoc_exprt` est remis à `"0"` par `Epurjdv` (code mort) et affiché ici.
- `Expbase.class` porte le même en-tête de commentaire (« Exportjdv.class ») : copie historique,
  sans dépendance de code.
- Aucun appel dynamique ; pas de dépendance circulaire. Ordre de rework : après `Utils` (`Cdate_*`,
  `Accent`) et `EnvMail` ; même lot que `ImpJdv`/`ImpSage` pour les constantes de format.
