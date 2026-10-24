# Fcaras — Dépendances

> Source : `.src/Gestion/Facturation/Fcaras.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/Fcaras.class` — classe, formulaire associé `Fcaras.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `son` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Tnom_Photo`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Facture.aff_photo` ([Facture.class:5283-5288](../../../../../.src/Gestion/Facturation/Facture.class#L5283-L5288)), qui construit
  `New Fcaras($photo, $crst)` puis `ShowModal`. Les deux arguments sont obligatoires : le
  constructeur de `Form` (parent optionnel) ne reçoit rien.
- `Tnom_Photo` : aucun appel externe (l'homonyme `Articles.Tnom_Photo` est une autre fonction).
  `deps.py` la signale à juste titre en portée réductible ; elle est en outre sans effet.
- Aucune table, aucun appel dynamique. `Music` (objet global gb.sdl2.audio) n'est pas compté par
  `deps.py`.
- Contrainte d'ordre : aucune ; à reworker indépendamment de `Facture`.
