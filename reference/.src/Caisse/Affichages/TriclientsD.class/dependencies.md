# TriclientsD — Dépendances

> Source : `.src/Caisse/Affichages/TriclientsD.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Affichages/TriclientsD.class` — classe, formulaire associé `TriclientsD.form`
- Handlers GUI détectés : 14
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ClavInput`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcli_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Caisse` | `Bsel` |
| `Cbase` | `Table` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Base2`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |

### Tables SQL référencées

`Fiches_Clid`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`, `ClavInput`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **`jamais_reference` confirmé** : `grep -rni 'triclientsd' .src` ne trouve que le fichier lui-même
  (ni `New`, ni appel statique, ni chaîne pour `Class.Load`/`Object.New`, ni `.form`/`.report`).
  Seule mention approchante : le commentaire `'Form = New Clavier("ClientsDiv")` du fichier.
- **Membre inexistant** : `Caisse.Clicoded` (ligne 67) n'existe pas dans `Caisse` (aucune
  occurrence de `clicoded` dans `.src` ni dans l'historique git hors ce fichier). `deps.py` le
  rapporte comme `<hérité:clicoded>` au lieu de le signaler : faux négatif (membre inexistant d'une
  classe, déjà listé dans les limites de l'outil pour les modules).
- `Caisse.Bsel` est écrit sur l'auto-instance de `Caisse` ; la caisse affichée est une instance
  `New Caisse` (`Cmenu.class:253`).
- **Table `Fiches_Clid`** : lue ici, purgée par `RazClientd` (`RazClientd.class:27-30`), créée par
  `LauruxMaj` (`LauruxMaj.module:3580`). Aucun `INSERT` dans le code : à reporter dans la
  documentation de `RazClientd` (lot Archivages).
- **`unused`** : `ClavInput` (vérifié).
- **`replay_dynamic`** : `colcli_Click` (sans objet, écran jamais ouvert).
- Aucun `arity_errors`, `handlers_inactifs`, `replay_missing`, `unused_transitive`, `sql_params`.
- **Ordre** : la suppression (TRICLIENTSD-A01) n'a aucun prérequis ; à faire avant TRICARTES-005 pour
  ne pas factoriser du code mort.
