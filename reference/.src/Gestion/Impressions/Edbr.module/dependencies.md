# Edbr — Dépendances

> Source : `.src/Gestion/Impressions/Edbr.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edbr.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/Edbl.class` | `Ed` |
| `.src/Gestion/Stock/ValidBR.class` | `Ed`, `Init` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cdocuments` | `<type>`, `BasPage`, `EnteteN`, `Level10F`, `Level11F`, `Level1br`, `Level2br`, `Level3br`, `Level7F`, `Level9F` |
| `Copie` | `Dupli` |
| `DB_Connection` | `Exec` |
| `LDate` | `<type>`, `L`, `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `DTE`, `DelAllTag`, `Fournisseurs`, `HT`, `PDFDupli`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `LPrix` | `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Ligrecpt`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Calc_tva`, `Cdocuments`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep : `ValidBR.class:648` (`Init`), `ValidBR.class:693` (`Ed`, plusieurs
  BR, `"ValidBR"`), `Edbl.class:62`, `:290`, `:299` (`Ed`, un BR, `""`). Aucun appelant ne passe
  `"Valcom"` → branche morte.
- « Portée réductible » : `Calc_tva` (appelé seulement à la ligne 220) confirmé ; `Cdocuments`
  est une variable `Public` jamais lue (grep `\.Cdocuments\b` : aucun résultat) → suppression.
- Table de travail `Totalisation` (`Cbase` la connaît sous la clé `Totalisation`) remplie par
  `ValidBR.Maj_Totalisation` juste avant l'appel : `Calc_tva` n'a de sens que dans ce contexte.
- Effets de bord externes : `Copie.spiece`/`schemin` (COPIE-A02), documents `Docs_Ged`,
  `Docs_Tag`, `Fiches_Tag` via `LGed` (non vus par `deps.py` : accès par les méthodes de `LGed`).
- Utilise `Cdocuments` (`EnteteN`, `Level1br`, `level2br`, `Level3br`, `Baspage`, `Level7F`,
  `Level9F`, `Level10F`, `Level11F`). `Level7F`/`Level10F` reçoivent `""` pour des paramètres
  `Boolean` (converti en `False`).
- Contrainte d'ordre : EDBR-004 après LGED-007 ; rework conjoint avec `ValidBR` pour EDBR-A01.
