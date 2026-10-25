# Cbilan — Dépendances

> Source : `.src/Reports/Cbilan.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cbilan.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1A`, `Level2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Imp_Bilan.module` | `<type>`, `BasPage`, `Level0`, `Level1`, `Level1L`, `Level1S`, `Level3`, `Lines` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1A`, `Level2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Compta/Impressions/Imp_Bilan.module` (`Private pdf As Cbilan`, `New Cbilan`
  ligne 649). Arités vérifiées : aucun écart.
- `unused` (`Level1A`, `Level2`) confirmé par grep : les appels `.Level1A`/`.Level2` du projet
  visent d'autres classes (`CLcr`, `Cbalances`, `Csig`, `Cclients`…) ; `Imp_Bilan` n'appelle que
  `Level0`, `Level1`, `Level1L`, `Level1S`, `Level3`, `Lines`, `BasPage`.
- Paramètres transmis mais ignorés : `detail` (`Level0`), `dte2` (`Level3`), `p5`, `imp3`, `imp4`
  (`Level1*`) — déjà relevés dans la documentation d'`Imp_Bilan` (valeurs N-1 calculées mais jamais
  imprimées, IMP_BILAN-A01).
- Pas de `.form`, pas de SQL, aucun appel dynamique.
- Ordre de rework : `Cbilan` avant `Imp_Bilan` si une signature change (suppression des paramètres
  inutilisés = modification des deux fichiers dans le même commit).
