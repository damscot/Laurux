# ComMail — Dépendances

> Source : `.src/Gestion/Tables/ComMail.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/ComMail.class` — classe, formulaire associé `ComMail.form`
- Handlers GUI détectés : 6
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button3_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |
| `.src/Gestion/option/ObjFacB.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Utils` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |
| `Variables` | `sTexte` |

### Tables SQL référencées

`Fiches_ComMail`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button3_Click`, `Button4_Click`, `stexte`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants réels (constructeur à argument obligatoire `Org`) :
  - `Fmenu.Menu326_Click` (`Fmenu.class:2459`, `New Commail("")`, mode gestion) ;
  - `FClient.class:2372` (`New Commail("F")`, mode choix ; `Variables.stexte` remis à `""` avant,
    lu après à `:2389`) ;
  - `ObjFacB.class:841` et `:856` (`New Commail("F")`, mode choix ; lecture de `Variables.sTexte`
    à `:662` et `:876`).
- **Faux positifs** : les nombreuses lignes `<hérité:showmodal>` de `Fmenu` (678, 713, 728, 936…)
  appartiennent à d'autres fonctions qui réutilisent le nom de variable `hForm` typé autrement ;
  seule la ligne 2460 concerne ComMail (limite connue : variable locale typée différemment selon
  les fonctions).
- Appel par nom de classe en minuscules (`Commail`) : Gambas est insensible à la casse.
- Couplage par état global : `Variables.sTexte` (écrit ici, lu par `FClient` et `ObjFacB`).
- `Button3_Click` : handler inactif (bouton groupé `Btn`) ; `stexte` : variable `Public` inutilisée.
- `colcol_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- Ordre de rework : avec Comment (module partagé).
