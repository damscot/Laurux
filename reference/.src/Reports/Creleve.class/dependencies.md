# Creleve — Dépendances

> Source : `.src/Reports/Creleve.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Creleve.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `EnteteN`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Relances/FEditrel.class` | `<type>`, `Entete`, `Entete2`, `Level5`, `Level6`, `Level7`, `Level8` |
| `.src/Compta/Relances/FRelCompte.class` | `<type>`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4`, `Lines` |
| `.src/Compta/Relances/FRelFacture.class` | `<type>`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4`, `Level9`, `Lines` |
| `.src/Compta/Relances/Ligcli.class` | `<type>`, `Entete`, `Entete2`, `Level5`, `Level6`, `Level7`, `Level8` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `MultiCell`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`EnteteN`, `Logo`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Quatre appelants, tous dans `Compta/Relances` : `FEditrel`, `Ligcli` (lettres de relance) et
  `FRelCompte`, `FRelFacture` (relevés). Arités vérifiées (17 arguments pour `Entete`, 7 pour
  `Entete2`) : aucun écart.
- `unused` (`EnteteN`) confirmé par grep : les appels `pdf.EnteteN` (`EdFam`, `Edbr`, `RelMoprod`)
  visent `Cdocuments`/`Cdocuments2`.
- `Logo` figure dans `scope_reducible` : seul appel `Logo()` interne (`Entete`, ligne 55) ; les
  `pdf.Logo(…)` du projet visent `Cbordereaux` (`Bordereaux:153`). Réduction possible.
- Le SQL de l'en-tête société est **chez les appelants** (`SELECT * FROM Fiches_Societes WHERE
  cd_sc = &1`) ; `deps.py` ne le rattache pas à `Creleve` (normal). Mêmes blocs dans
  `Facturergbl` et `RelvMo`, qui utilisent `Cdocuments`.
- Configuration lue : `Start.LocalSettings["/Soc<XX>/glogo"]`, `["/Soc<XX>/Logo"]`.
- Pas de `.form`, aucun appel dynamique.
- Ordre de rework : la création d'une lecture commune de la société (LIGCLI-004) précède les
  reworks des quatre appelants ; la suppression des paramètres inutiles (`Pays`, `Col`, `Jour`) se
  fait dans le même commit que les appelants.
