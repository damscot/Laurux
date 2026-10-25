# Tricartes — Dépendances

> Source : `.src/Caisse/Affichages/Tricartes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Affichages/Tricartes.class` — classe, formulaire associé `Tricartes.form`
- Handlers GUI détectés : 29
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcli_Click`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [25](../../../../../.src/Caisse/Affichages/Tricartes.class#L25), [26](../../../../../.src/Caisse/Affichages/Tricartes.class#L26), [82](../../../../../.src/Caisse/Affichages/Tricartes.class#L82), [83](../../../../../.src/Caisse/Affichages/Tricartes.class#L83)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `FClientcarte` | `<type>` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Base2`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |

### Tables SQL référencées

`Fiches_Carte`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`, `ClientsCartes`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés par `grep -rn`) : `Caisse.ClientsDivers` (`Caisse.class:7251-7256`,
  `New Tricartes(-1)`) et `Caisse.CartesFidelite` (`Caisse.class:7332-7338`,
  `New Tricartes(0, Null, Me)`). Aucun autre écran.
- **Appels dynamiques** (lignes 25, 26, 82, 83) : `Object.SetProperty(Obj, "Bsel"/"Bval", …)` sur
  l'écran appelant. `Caisse.Bsel` et `Caisse.Bval` (`Caisse.class:97-98`) doivent rester `Public` ;
  tout nouvel appelant doit exposer ces deux membres. Non visible dans le graphe `deps.py` (cible
  `Object`).
- **TRICARTES-A01** : `Caisse.ClientsDivers` n'envoie pas `ob` → sélection perdue. À reporter dans la
  documentation de `Caisse` (lot Caisse) : la correction se fait dans `Caisse.class:7255-7259`.
- **Dépendance circulaire** `Caisse` → `Tricartes` → `FClientcarte` (F4) ; `FClientcarte` → `Tricp`.
- `Utils.rs2` est partagé avec tous les écrans qui utilisent `Utils.Base2` (dont `Tricp`, ouvert
  depuis `FClientcarte` par F4) ; le rechargement `Deb3()` après `ClientsCartes` protège la liste.
- **`replay_dynamic`** : `colcli_Click` doit rester `Public`.
- Aucun `arity_errors`, `unused`, `unused_transitive`, `handlers_inactifs`, `replay_missing` ni
  `sql_params` (le SQL est concaténé, sans `&N`).
- **Portée réductible** (vérifiée) : `Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`,
  `ClientsCartes` (TRICARTES-004).
- **Ordre de rework** : après le lot Affichages si une classe de pagination commune est retenue
  (TRICARTES-005), en même temps que `TriclientsD` si ce dernier n'est pas supprimé.
