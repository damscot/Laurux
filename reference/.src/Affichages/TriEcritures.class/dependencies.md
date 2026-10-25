# TriEcritures — Dépendances

> Source : `.src/Affichages/TriEcritures.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriEcritures.class` — classe, formulaire associé `TriEcritures.form`
- Handlers GUI détectés : 52
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Debe1`, `Debe2`, `Debe3`, `Debe4`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Ecrit_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Saisecrit.class` | `<type>` |
| `.src/Compta/Tresor.class` | `<type>` |

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

- **Appelants** (vérifiés par `grep -rnw "TriEcritures"`) :
  - `Saisecrit.ecritnv` (`Saisecrit.class:633-646`) : `New TriEcritures("0", Sel, "0")`, puis
    `ecrit2()` si `Comptabilite.Bsel` ;
  - `Saisecrit.ecritv` (`Saisecrit.class:652-665`) : `("1", Sel, "0")`, puis `ecrit3()` ;
  - `Tresor.ecritnv` (`Tresor.class:784-796`) : `("0", Sel, "1")` ;
  - `Tresor.ecritv` (`Tresor.class:800-812`) : `("1", Sel, "1")`.
  `Sel` vaut toujours `""` au moment de l'appel.
- **Protocole par le module `Comptabilite`** : l'appelant met `Bsel = False` avant l'ouverture ;
  `TriEcritures` écrit `Bsel`, `snum`, `libelle`, `journal` (`Ecrit_Click`, lignes 633-636) et remet
  `sCmpt` à `""` (ligne 19). Lecteurs : `Saisecrit:2458`, `2546` (`snum`) ; `Tresor:1943-1947`
  (`snum`, `libelle`, `journal`). Voir COMPTABILITE-001/A01. Aucun membre de `TriEcritures` n'est lu
  sur l'instance : toute la communication passe par l'état global.
- `unused` : `Debe1`, `Debe2`, `Debe3`, `Debe4` — confirmé par `grep -rnw` sur `.src` (aucune autre
  occurrence que leur déclaration) ; `unused_transitive` vide.
- `replay_dynamic` : `Ecrit_Click` (rester `Public`). Pas de `replay_missing`, pas
  d'`arity_errors`, pas de `handlers_inactifs`.
- `deps.py` classe `JO_Click`, `COM_Click`… parmi les handlers ; un `TextBox` n'a pas d'événement
  `Click` (limite connue de l'outil) : ces méthodes sont des appels internes depuis `*_GotFocus`.
- « Portée réductible » confirmée pour `Entete`, `Dbclk2`, `Tris2`, `Deplacement`, `Debn1`-`Debn4`.
- Table : `Fiches_Mvt` (`TabMvt`), lecture seule.
- [`TriEcritures2`](../TriEcritures2.class/dependencies.md) est une copie morte (aucun appelant).
- Contrainte d'ordre : un changement de protocole de retour (suppression de `Comptabilite`) devrait
  être fait dans le même commit que `Saisecrit` et `Tresor`, après décision sur `TriEcritures2` et
  `TresorFac`.
