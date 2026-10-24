# FCalc — Dépendances

> Source : `.src/Utils/FCalc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/FCalc.class` — classe, formulaire associé `FCalc.form`
- Handlers GUI détectés : 8
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `GetParent`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `<type>`, `Resultat` |
| `.src/Compta/Saisecrit.class` | `<type>`, `Resultat` |
| `.src/Compta/Tables/Abont.class` | `<type>`, `Resultat` |
| `.src/Compta/Tresor.class` | `<type>`, `Resultat` |
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `Resultat` |
| `.src/Gestion/Reglements/TresorFac.class` | `<type>`, `Resultat` |
| `.src/Gestion/option/Saisiedecons.class` | `<type>`, `Resultat` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Calc` | `<type>` |
| `Utils` | `Observers`, `cpoint` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`GetParent`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Liste des appelants confirmée par grep (7 fichiers, 8 points d'appel) : `Caisse:1647-1650`,
  `Saisecrit:1339-1346`, `Tresor:1057-1063`, `Abont:127-129`, `Facture:3318-3321` et `5574-5576`,
  `TresorFac:469-475`, `Saisiedecons:131-133`. Tous ouvrent par la touche F5 et lisent
  `FCalc.Resultat` (statique).
- **Faux positifs « portée réductible »** : `buttons_enter`, `buttons_leave`, `buttons_Click` sont les
  handlers du groupe `buttons` du `.form` (tous les boutons de la calculette). Seul `GetParent` est
  réellement inutilisé.
- `GetParent` est la seule référence à la classe morte `Calc` : à supprimer ensemble (CALC-A01).
- Pas de dépendance circulaire.
