# Ctraites — Dépendances

> Source : `.src/Reports/Ctraites.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Ctraites.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `EnteteN`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `SetFillColor`, `SetFont`, `SetXY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`EnteteN`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Classe jamais référencée** (`jamais_reference`), confirmé : `grep -rni "\bctraites\b" .src
  .project` ne trouve que le fichier ; aucun chargement dynamique (seul `Class.Load` :
  `Start.module:493`, liste fixe) ; `git log -S "Ctraites"` sans appelant historique.
- Fonction `unused` : `EnteteN` (les appels `pdf.EnteteN` du projet visent `Cdocuments`/`Cdocuments2`).
- Pas de `.form`, pas de SQL. Aucune contrainte d'ordre.
