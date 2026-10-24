# Calc — Dépendances

> Source : `.src/Utils/Calc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Calc.class` — classe, formulaire associé `Calc.form`
- Handlers GUI détectés : 22
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `division_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `division_Click`, `Div`, `Mlt`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/FCalc.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`SetObservers`, `division_Click`, `calcul`, `Oprt`, `Rep`, `prct`, `Div`, `Mlt`, `ChkPrx`, `Resultat`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant réel** : la seule référence (`FCalc.class:101`, `GetParent() As Calc`) est un type
  de retour dans une fonction jamais appelée. `Calc.Resultat` n'est lu nulle part. L'appel
  `Calc.run()` de `Facture.class:10647` est commenté. Les autres occurrences du mot (`Einvmat:18`
  `For Each Calc In tabl`, `Recalcsolde.Calc()`) sont des homonymes sans rapport.
- Pas d'appel dynamique par nom (`"Calc"`) trouvé (le lanceur `Prgm` ne connaît pas `Calc`).
- **Ordre de rework** : supprimer `Calc` **dans le même commit** que la correction du type de retour
  de `FCalc.GetParent` (ou sa suppression), sinon `gbc3` échoue.
