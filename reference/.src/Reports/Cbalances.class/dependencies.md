# Cbalances — Dépendances

> Source : `.src/Reports/Cbalances.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cbalances.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level2s`, `Level2sbis`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/BalanceM.module` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level1a`, `Level2`, `Level2a`, `Level3`, `Level3a`, `Level4`, `Level4a` |
| `.src/Compta/Impressions/FTVA.class` | `<type>`, `BasPage`, `Entete`, `Level0T`, `Level1T`, `Level2T`, `Level3T`, `Level4T`, `Level4TVA`, `Level5T` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level2s`, `Level2sbis`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Deux appelants seulement : `Compta/Impressions/BalanceM.module` (balance) et
  `Compta/Impressions/FTVA.class` (état de TVA), chacun par `New Cbalances("Portrait", "mm", "A4")`.
- Arités vérifiées sur les deux appelants (comptage des arguments) : aucun écart.
- `unused` (`Level2s`, `Level2sbis`) confirmé par grep : les appels `pdf.Level2S`/`pdf.level2s`
  existants visent un `Cclients` (`ImpSage:203-221`) et un `Ccompta` (`EditcompteM:129`), pas
  `Cbalances`.
- `Level3T` est bien utilisé (`FTVA:597`) : c'est `Ccompta.Level3T` qui est mort.
- Aucun appel dynamique, aucune table, pas de `.form`.
- Ordre de rework : après `PdfWriter` et la base `PdfLaurux` éventuelle ; avant les appelants
  `BalanceM` et `FTVA`.
