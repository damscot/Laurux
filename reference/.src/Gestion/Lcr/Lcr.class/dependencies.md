# Lcr — Dépendances

> Source : `.src/Gestion/Lcr/Lcr.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Lcr.class` — classe, formulaire associé `Lcr.form`
- Handlers GUI détectés : 32
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Deb3`, `Level1`, `Level2`, `Level3`, `Level4`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColLcr_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CLcr` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Lines` |
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level1T`, `Level2T` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `G`, `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TextReg` | `<form>`, `EstDate`, `EstNum`, `MaxLength`, `Name`, `Select`, `Text`, `Type`, `Value`, `dte`, `nbdec`, `reg` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client` |
| `Utils` | `Base`, `Cdate_Aff`, `Coulfd`, `Fcolr`, `ObsLstf`, `convBool`, `cpoint`, `db`, `rs1` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Lcr`, `Fiches_Traites`

### Membres Public sans usage externe détecté (portée réductible ?)

`Entete`, `Tris`, `Deb2`, `Deb3`, `Refresh`, `CleanChamps`, `Maj_Zones`, `compte`, `compteman`, `Imp_Traites`, `Imp_Lcr`, `Level1`, `Level2`, `Level3`, `Level4`, `sCmpt`, `sdesg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **`arity_errors` l. 635 « `Ccompta.level2` 11/9 » : faux positif vérifié.** Dans `Imp_Lcr`,
  `pdf` désigne le membre de classe `pdf As CLcr` (l. 55) ; la déclaration locale
  `Dim pdf As Ccompta` n'existe que dans `Imp_Traites` (l. 538). L'appel vise donc
  `CLcr.Level2(num, Datel, snom, sadr1, sadr2, scp, datech, smontant, secartee, sacceptee, PosY)`,
  11 paramètres pour 11 arguments. `deps.py` étend à tout le fichier le type d'une variable locale
  homonyme d'un membre (limite connue « variable typée différemment selon les fonctions »).
  `Ccompta.level2` (`.src/Reports/Ccompta.class:108`, 9 paramètres) n'est pas appelé ici ;
  `Imp_Traites` appelle `Ccompta.Level2T` avec 14 arguments pour 14 paramètres (correct).
- Conséquence : `CLcr` est signalé à tort avec `Level1`/`Level2` « jamais référencées » et `Lcr`
  n'apparaît qu'avec `<type>` dans ses appelants ; `Lcr` utilise `CLcr.Entete`, `Level1`, `Level2`,
  `Lines`, `BasPage` et `Ccompta.Entete`, `Level1T`, `Level2T`, `BasPage`.
- `unused` vérifiés : `Deb3`, `Level3`, `Level4` ; **en plus** `Level1` et `Level2` (impression
  `Draw`) sont morts : seuls des appels `pdf.Level1()`/`pdf.Level2()` existent.
- `replay_dynamic` : `ColLcr_Click` doit rester `Public`.
- `Bsel`, `Bval` : écrits dynamiquement par `TriCpt` (`Object.SetProperty`,
  `.src/Affichages/TriCpt.class:112-113`) → `Public` obligatoire. `sCmpt`, `sdesg` : aucun usage.
- Point d'entrée : `Fmenu.MenuTrlcr_Click` (`Fmenu.class:2506`), menu visible si `/Soc<XX>/Lcr`.
- Données amont : `Fiches_Traites` est alimentée par `EcrAuto.class:558` (facturation) et lue aussi
  par `Impressions/Traites.class` ; données aval : `Attribution`, `Preparation`, `Glcr`, `Bordrx`
  lisent `Fiches_Lcr`.
- Écran non instrumenté (`Utils.Observers(Me)` absent) : voir LCR-A08.
- Ordre de rework : après `CLcr` ; commonalisations avec `Attribution`/`Preparation` à faire
  ensemble (phase 3) ; commonalisation `Imp_Traites` avec `Traites.class` (lot Impressions).
