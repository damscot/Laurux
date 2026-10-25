# Csig — Dépendances

> Source : `.src/Reports/Csig.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Csig.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1L`, `Level1A`, `Level1S`, `Level7`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Imp_Sig.module` | `<type>`, `BasPage`, `Level0`, `Level1`, `Level2`, `Level3`, `Lines`, `Lines2`, `Lines3` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1L`, `Level1A`, `Level1S`, `Level7`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Compta/Impressions/Imp_Sig.module` (`New Csig("l", "mm", "A4")`, ligne 257).
  Arités vérifiées : aucun écart (les appels commentés `Imp_Sig:313`, `442` ne comptent pas).
- `unused` (`Level1L`, `Level1A`, `Level1S`, `Level7`) confirmé par grep : `Imp_Sig` n'appelle que
  `Level0`, `Level1`, `Level2`, `Level3`, `Lines`, `Lines2`, `Lines3`, `BasPage` ; les autres appels
  `.level1L`/`.level1S`/`.Level7` du projet visent `Cbilan`, `Creleve` ou `Carticles`.
- `Utils.cpoint` n'est utilisé que par les niveaux morts : après leur suppression, `Csig` ne
  dépendra plus d'`Utils`.
- Pas de `.form`, pas de SQL, aucun appel dynamique.
