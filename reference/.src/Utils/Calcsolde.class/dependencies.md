# Calcsolde — Dépendances

> Source : `.src/Utils/Calcsolde.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Calcsolde.class` — classe, formulaire associé `Calcsolde.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |
| `.src/Compta/Pointage.class` | `Calcul` |
| `.src/Compta/Utils/impfec.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LPrix` | `_call` |
| `Start` | `Musique` |
| `Utils` | `MouseDefault`, `MouseProcessing`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants manqués** (méthodes héritées de `Form`) : `Fmenu.class:969` (`Calcsolde.ShowModal()`),
  `impfec.class:58` (`Calcsolde.ShowModal`), `Prgm.class:60` (`Calcsolde.show`, par nom saisi).
  Seul `Pointage.class:728` (`Calcul`) est détecté.
- **Faux positif** : `Btn_Click` est le handler du groupe `Btn` du `.form`.
- L'appel statique `Calcsolde.Calcul` depuis `Pointage` crée l'instance automatique du formulaire
  (constructeur `_new(False)` exécuté, `form_Open` non déclenché).
- **Ordre de rework** : `LPrix` stable (`.D`) ; `Pointage` à reprendre dans le même commit si la
  signature de `Calcul` change.
