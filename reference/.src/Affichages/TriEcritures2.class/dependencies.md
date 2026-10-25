# TriEcritures2 — Dépendances

> Source : `.src/Affichages/TriEcritures2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriEcritures2.class` — classe, formulaire associé `TriEcritures2.form`
- Handlers GUI détectés : 46
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Debe1`, `Debe2`, `Debe3`, `Debe4`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Ecrit_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Comptabilite` | `Bsel`, `journal`, `libelle`, `sCmpt`, `snum` |
| `Utils` | `Base`, `ObsGotf`, `ObsLstf`, `Observers`, `rs1` |

### Tables SQL référencées

`Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Entete`, `Dbclk2`, `Tris2`, `Deplacement`, `Debe1`, `Debe2`, `Debe3`, `Debe4`, `Debn1`, `Debn2`, `Debn3`, `Debn4`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **`jamais_reference` confirmé** : `grep -rnw "TriEcritures2" .src` ne trouve que le fichier
  lui-même ; aucune chaîne `"TriEcritures2"` ; `git log -S "TriEcritures2" -- .src` : seulement
  l'import initial `5d9a8696` (2016). Jamais appelée dans l'historique disponible.
- Écritures vers `Comptabilite` (`Bsel`, `snum`, `libelle`, `journal`, `sCmpt`) jamais exécutées :
  la ligne `TriEcritures2:549` du tableau de `Comptabilite/architecture.md` est sans effet réel.
- `unused` : `Debe1`, `Debe2`, `Debe3`, `Debe4` (vérifié). `unused_transitive` vide.
- `replay_dynamic` : `Ecrit_Click` (sans objet si suppression). Pas de `replay_missing`.
- Aucune dépendance entrante : la suppression n'impacte aucun autre fichier.
