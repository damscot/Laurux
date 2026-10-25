# Ccompta — Dépendances

> Source : `.src/Reports/Ccompta.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Ccompta.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level2sbis`, `Level3T`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Anomalies.class` | `<type>`, `BasPage`, `Entete`, `Level0P`, `Level1A2`, `Lines`, `level2A2` |
| `.src/Compta/Impressions/Echeancier.class` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1E`, `Level4E`, `Level5E`, `Lines`, `level2E` |
| `.src/Compta/Impressions/EcrM.class` | `<type>`, `BasPage2`, `Entete`, `Level1M`, `Lines`, `level2M` |
| `.src/Compta/Impressions/EdImpayes.class` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level3`, `Level4`, `Level5`, `Lines`, `level2` |
| `.src/Compta/Impressions/EdNjustifiees.class` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level6`, `level2` |
| `.src/Compta/Impressions/EdNlettrees.class` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level3`, `Level4`, `Level5`, `Lines`, `level2` |
| `.src/Compta/Impressions/EditcompteA.class` | `<type>`, `BasPage`, `Entete`, `Level0C`, `Level1CA`, `Level2CA`, `Level3C`, `Level4C`, `Level5C`, `Lines` |
| `.src/Compta/Impressions/EditcompteM.module` | `<type>`, `BasPage`, `Entete`, `Level0C`, `Level1C`, `Level2C`, `Level2s`, `Level3C`, `Level4C`, `Level4T`, `Level5C`, `Lines` |
| `.src/Compta/Impressions/Jourcent.class` | `<type>`, `BasPage`, `Entete`, `Level0J`, `Level5J`, `level6J`, `level7J` |
| `.src/Compta/Impressions/JournauxA.class` | `<type>`, `BasPage2`, `Entete`, `Level0A`, `Level0J`, `Level1A`, `Level1J`, `Level2A`, `Lines`, `level2J`, `level6J`, `level7J` |
| `.src/Compta/Impressions/JournauxM.module` | `<type>`, `BasPage2`, `Entete`, `Level0J`, `Level1J`, `Level1JT`, `Lines`, `level2J`, `level2JT`, `level6J`, `level7J` |
| `.src/Compta/Impressions/Plancomptable.class` | `<type>`, `BasPage`, `Entete`, `Level0P`, `Level1P`, `Lines`, `level2P` |
| `.src/Compta/Pointage.class` | `<type>`, `BasPage`, `Entete`, `Level0R`, `Level1R`, `Level2R`, `Level3R`, `Level6` |
| `.src/Gestion/Impressions/Traites.class` | `<type>`, `BasPage`, `Entete`, `Level1T`, `Level2T` |
| `.src/Gestion/Lcr/Lcr.class` | `<type>`, `BasPage`, `Entete`, `Level1T`, `Level2T` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level2sbis`, `Level3T`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **15 appelants**, tous par une variable typée `pdf As Ccompta` + `New Ccompta("Portrait", "mm",
  "A4")` : 12 éditions de `Compta/Impressions` (`Anomalies`, `Echeancier`, `EcrM`, `EdImpayes`,
  `EdNjustifiees`, `EdNlettrees`, `EditcompteA`, `EditcompteM`, `Jourcent`, `JournauxA`, `JournauxM`,
  `Plancomptable`), `Compta/Pointage`, `Gestion/Impressions/Traites` et `Gestion/Lcr/Lcr`
  (`Imp_Traites`, variable locale `Dim pdf As Ccompta`, ligne 538). Vérifié par `grep -rn "As
  Ccompta"`.
- **Arités vérifiées** (script de comptage des arguments sur les 15 appelants, signatures de
  `Ccompta`) :
  - `EditcompteA:726` `pdf.level4C(totdeb, totcred, totsld, Posy)` : 4 arguments pour 5
    (`compte` manquant) → erreur à l'exécution, anomalie de l'appelant EDITCOMPTEA-A01 ;
  - `JournauxA:695` `pdf.level2J(…)` : 9 arguments pour 10 (`Nlot` manquant) → anomalie de
    l'appelant JOURNAUXA-A01 ;
  - `Lcr:635` `pdf.level2(…)` à 11 arguments : **faux positif** connu (le `pdf` de cette fonction est
    le membre `pdf As CLcr`, pas le `Dim pdf As Ccompta` d'`Imp_Traites`) ;
  - `Jourcent:774` et `Jourcent:868` (`pdf.level5J()` sans argument) sont dans des lignes
    commentées : sans objet.
  `deps.py` range ces cas dans les `arity_errors` **des appelants** : le bloc AUTO de `Ccompta` n'en
  montre aucun.
- `unused` (`Level2sbis`, `Level3T`) confirmé par `grep -rni "\.level2sbis\|\.level3T"` :
  `Level3T` n'est appelé que sur un `Cbalances` (`FTVA:597`) ; aucun appel de `Level2sbis` dans le
  projet. Aucun appel dynamique (`Object.Call`) ni chaîne ne les cite.
- Les noms de méthodes sont appelés avec une casse variable (`pdf.level4C`, `pdf.Baspage`,
  `pdf.level7j`) : Gambas ignore la casse ; `deps.py` aussi.
- Héritage : `PdfWriter` (`AddPage`, `SetXY`, `SetFont`, `SetFillColor`, `Cell`, `SetY`, `PageNo`,
  `SetLineWidth`, `Line`). `Open`, `AliasNbPages` et `Output` sont appelés par les écrans, pas par
  `Ccompta`.
- Pas de `.form`, pas de SQL, pas de handler.
- **Ordre de rework** : `PdfWriter` (sans réactiver `Header`/`Footer`) → création de `PdfLaurux`
  (si retenue) → `Ccompta` → appelants. Toute modification de signature d'un `Level*` impose de
  modifier dans le même commit les appelants listés dans le bloc AUTO.
