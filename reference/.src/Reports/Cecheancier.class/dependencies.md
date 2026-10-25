# Cecheancier — Dépendances

> Source : `.src/Reports/Cecheancier.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cecheancier.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Entete`, `BasPage`, `Level0`, `Level2`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Entete`, `BasPage`, `Level0`, `Level2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Classe jamais référencée** (`jamais_reference`), confirmé : `grep -rni "\bcecheancier\b" .src
  .project` ne trouve que le fichier lui-même ; seul `Class.Load` du projet : `Start.module:493`
  (liste fixe `LPrix`, `LScript`) ; `git log -S "Cecheancier"` ne montre aucun appelant historique.
- Fonctions `unused` : `Entete`, `BasPage`, `Level0`, `Level2` (mortes par conséquence).
- Pas de `.form`, pas de SQL. Aucune contrainte d'ordre pour la suppression.
