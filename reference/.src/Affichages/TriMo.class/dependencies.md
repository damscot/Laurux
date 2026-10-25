# TriMo — Dépendances

> Source : `.src/Affichages/TriMo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriMo.class` — classe, formulaire associé `TriMo.form`
- Handlers GUI détectés : 2
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colmo_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `Base4`, `Observers`, `rs4` |
| `Variables` | `$Codemo`, `Bsel` |

### Tables SQL référencées

`Fiches_Mo`

### Membres Public sans usage externe détecté (portée réductible ?)

`trimo`, `Deb1`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Classe morte vérifiée** : `grep -rn "TriMo" .src` ne trouve que la méthode homonyme
  `Facture.TriMo()` (l. 2832, appelée l. 2826 et 2872 sous la forme `Trimo()`), sans rapport.
  Aucune chaîne `"TriMo"` pour un chargement dynamique. Le `.form` n'est ouvert par aucun menu.
- **Écritures globales** : `Variables.Bsel`, `Variables.$Codemo` (l. 62-63). `$Codemo` n'a aucun
  lecteur : VARIABLES-002 propose sa suppression, qui dépend de celle de `TriMo` (TRIMO-A01).
- **Signaux `deps.py`** : `jamais_reference` (confirmé) ; `replay_dynamic` = `colmo_Click` ;
  `scope_reducible` = `trimo`, `Deb1` (sans objet) ; aucun `unused` (les fonctions s'appellent
  entre elles), aucun `arity_errors`.
- **Ordre de rework** : TRIMO-A01 avant VARIABLES-002.
