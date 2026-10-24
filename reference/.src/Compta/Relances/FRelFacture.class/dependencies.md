# FRelFacture — Dépendances

> Source : `.src/Compta/Relances/FRelFacture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/FRelFacture.class` — classe, formulaire associé `FRelFacture.form`
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Compdate`, `Solde`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `CompteRel`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Creleve` | `<type>`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4`, `Level9`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Numtostring` | `Convertir`, `Num2Text` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Coulfd`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |
| `numtostring` | `<hérité>` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Four`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_RelFacture`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`MajTab`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `Compdate2`, `Releves`, `Solde`, `Button1_Click`, `Button7_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:799` (`Menu52_Click`).
- `Solde` et `Compdate` : aucun appelant (morts) ; `MajTab`, `Compdate2`, `Releves` : appelants
  internes seulement.
- **Modules homonymes `Numtostring` / `numtostring`** (`Utils/Numtostring.module`,
  `Caisse/numtostring.module`) : la compilation produit **un seul** fichier `.gambas/NUMTOSTRING`
  (noms de classes insensibles à la casse). Dans le dépôt actuel, ce fichier contient `Num2Text` et
  `Convertir` (module Utils) : l'appel `numtostring.Num2Text` de la ligne 464 vise donc le module
  Utils et fonctionnerait s'il n'était pas mort. Vérifié par `strings .gambas/NUMTOSTRING` et par un
  projet minimal (`gbc3`/`gbx3`) où deux modules différant par la casse donnent un seul bytecode,
  celui compilé en dernier. **Conséquence hors de ce fichier** : `Caisse.class:5064-5154`
  (`numtostring.nbtostring`) appelle un symbole absent du module retenu (à signaler au lot Caisse).
- Tables en dur : `Fiches_Mvt`, `Fiches_Journaux`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Societes`,
  `Fiches_Parametres` (clés `Cbase` existantes) ; `Fiches_RelFacture` sans clé.
- À reworker avec `FRelCompte` (base commune).
