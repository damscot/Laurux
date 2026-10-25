# CLcr — Dépendances

> Source : `.src/Gestion/Lcr/CLcr.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/CLcr.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level0`, `Level5A`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Lcr/Attribution.class` | `<type>`, `BasPage`, `Entete`, `Level1A`, `Level2A`, `Lines` |
| `.src/Gestion/Lcr/Bordrx.class` | `<type>`, `BasPage`, `Entete`, `Level1B`, `Level2B`, `Level3B`, `Level4B`, `Lines` |
| `.src/Gestion/Lcr/Glcr.class` | `<type>`, `BasPage`, `Entete`, `Level1A`, `Level2A` |
| `.src/Gestion/Lcr/Lcr.class` | `<type>`, `BasPage`, `Entete`, `Level1`, `Level2`, `Lines` |
| `.src/Gestion/Lcr/Preparation.class` | `<type>`, `BasPage`, `Entete`, `Level1A`, `Level2A`, `Lines` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level0`, `Level5A`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux positif `unused` sur `Level1` et `Level2`** : `Lcr.class` déclare le membre de classe
  `pdf As CLcr` (l. 55) et l'utilise dans `Imp_Lcr` (`pdf.Level1()` l. 625, `pdf.Level2(…)` l. 635,
  11 arguments = 11 paramètres). `deps.py` a typé `pdf` d'après la déclaration locale
  `Dim pdf As Ccompta` d'une autre fonction (`Imp_Traites`, l. 538), d'où le faux
  « `Ccompta.level2` 11/9 » signalé dans `Lcr` et la ligne « `Lcr` → `<type>` » seule ci-dessus.
  `Lcr` utilise en réalité `Entete`, `Level1`, `Level2`, `Lines`, `BasPage`.
- Vrais morts (vérifié par `grep -rn "Level0\|Level5A" .src`) : `Level0`, `Level5A`.
- `Lines` est appelé avec un `Integer` alors que le paramètre est `String` (conversion implicite).
- Aucun appel dynamique. Héritage de `PdfWriter` (`.src/Reports/PdfWriter.class`) : à reworker
  après une éventuelle classe de base commune des gabarits PDF (lot Reports).
- Ordre : `CLcr` avant ses 5 appelants si les signatures changent (`Lines`) ; sinon indépendant.
