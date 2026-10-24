# FEditrel — Dépendances

> Source : `.src/Compta/Relances/FEditrel.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Relances/FEditrel.class` — classe, formulaire associé `FEditrel.form`
- Handlers GUI détectés : 12
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `selcouleur`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `couleur`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Creleve` | `<type>`, `Entete`, `Entete2`, `Level5`, `Level6`, `Level7`, `Level8` |
| `DB_Connection` | `Engine`, `Exec` |
| `LDate` | `<type>`, `L`, `_call` |
| `Ligcli` | `<type>`, `sold` |
| `Listextcpt` | `<type>`, `resext` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Txt_Relances`, `Fiches_relances`

### Membres Public sans usage externe détecté (portée réductible ?)

`dteN1_GotFocus`, `dteN1_LostFocus`, `Impressionr`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:781` (`Menu49_Click`, « Préparation des relances »).
- **Appels non vus par l'heuristique** (objets `Variant` issus de `ScrollView1.Children` /
  `ScrollView2.Children`) : `Ligcli.couleur`, `visext`, `selection`, `numero`, `lib`, `imp`,
  `traitement`, `rellet`, `numlet`, `setfocus`, `next`, `tag`, `Delete` ; `Ligext.selection`.
- Handlers d'événements de `Ligcli` (groupe `"lig"`) : `lig_GotF` (`Gotf`), `Lig_up` (`Up`),
  `lig_Down` (`Down`) — à garder `Public` et sous ce nom.
- `Impressionr` : aucun appelant externe (portée réductible confirmée).
- Tables en dur : `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Societes`, `Fiches_Comptes` (clés `Cbase`
  existantes) ; `Fiches_relances`, `Fiches_Txt_Relances` (sans clé).
- Ordre de rework : `Ligcli` et `Ligext` dans le même lot ; la commonalisation de l'impression
  (LIGCLI-005) et de l'en-tête société avant ou avec ce fichier.
