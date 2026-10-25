# Cresultat — Dépendances

> Source : `.src/Reports/Cresultat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cresultat.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/RubImp.class` | `<type>`, `BasPage`, `Level0`, `Level1`, `Level2`, `Level3`, `Level7` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Compta/Impressions/RubImp.class` (`Private pdf As Cresultat`, `New
  Cresultat` ligne 1003). Les 6 méthodes publiques non spéciales sont toutes appelées (deps.py ne
  signale ni `unused` ni portée réductible : confirmé par lecture de `RubImp:1040-1125`).
- Arités vérifiées : aucun écart.
- La variable `p5` transmise par `RubImp` n'est jamais affectée (toujours vide) : le paramètre `p5`
  de `Level1`/`Level2` est inutile côté appelant comme côté gabarit.
- Pas de `.form`, pas de SQL, aucun appel dynamique.
