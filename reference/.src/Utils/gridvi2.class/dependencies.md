# gridvi2 — Dépendances

> Source : `.src/Utils/gridvi2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/gridvi2.class` — classe
- Handlers GUI détectés : 2
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `bouton_Click`, `razcol`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `requete`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `db`, `lastday`, `mois` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`bouton_Click`, `razcol`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : confirmé par `grep -rni 'gridvi2' .src` (classes, modules, `.form`) et par
  l'absence de nom de classe en chaîne littérale (pas d'instanciation dynamique `Object.New`/
  `Class.Load`). `deps.py` a raison sur `used_by` vide.
- `deps.py` propose `bouton_Click` et `razcol` en « portée réductible » : c'est sans objet, la
  classe entière est morte.
- `bouton_Click` n'est relié à aucun bouton (la création du bouton est absente), contrairement à
  `gridvi`.
- Pas de `.form`, pas de dépendance circulaire. Ordre de rework : supprimer avant les reworks de
  `gridvi` (GRIDVI-009 suppose la suppression faite).
