# FRelCompte — Dépendances

> Source : `.src/Compta/Relances/FRelCompte.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/FRelCompte.class` — classe, formulaire associé `FRelCompte.form`
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Compdate`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `CompteRel`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Creleve` | `<type>`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4`, `Lines` |
| `DB_Connection` | `AutoIncrement`, `Engine`, `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Coulfd`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Four`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Relcomptes`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`MajTab`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `Compdate2`, `Releves`, `Button1_Click`, `Button7_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:793` (`FRelcompte.Show`, casse différente).
- **Portée réductible** : `MajTab`, `Compdate2`, `Releves` confirmés sans appelant externe ;
  `Compdate` n'a **aucun** appelant (mort). Les `Compdate()` trouvés par grep appartiennent à
  d'autres écrans (`Journaux`, `Balance`, …).
- `Button1_Click`/`Button7_Click` : appelés par `Btn_Click` (boutons du groupe `Btn` dans le
  `.form`), pas par un événement direct.
- Tables : `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Societes` en dur (clés `Cbase`
  `TabMvt`, `TabCli`, `TabFour`, `TabSoc` existantes) ; `Fiches_Journaux` déclarée dans `Tab3` mais
  jamais interrogée ; `Fiches_Relcomptes` sans clé.
- Jumeau `FRelFacture` : à reworker ensemble (même commonalisation).
