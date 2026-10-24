# Lettrage — Dépendances

> Source : `.src/Compta/Lettrages/Lettrage.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Lettrages/Lettrage.class` — classe, formulaire associé `Lettrage.form`
- Handlers GUI détectés : 17
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcli_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Compta/Extrait.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `<type>`, `EDeb`, `EFin`, `G`, `L` |
| `Listextcpt` | `<type>`, `letcpt`, `resext` |
| `Start` | `Musique`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `Utils` | `Cdate_Aff`, `Observers`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`convBool`, `cpoint`, `compteman`, `Indexation`, `clear`, `affichage`, `Button5_Click`, `Button7_Click`, `Button8_Click`, `Desg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** (vérifiés par `grep`) : `Fmenu.Menu51_Click` (`.src/Communs/Fmenu.class:710-713`,
  `New Lettrage("", "")` + `ShowModal`) et `Extrait.cmpt_keypress` (`.src/Compta/Extrait.class:337`,
  F4, compte et type de l'extrait). Aucun appel de méthode de la classe depuis l'extérieur.
- **Appel dynamique entrant** : `TriCpt` (`.src/Compta/TriCpt.class:112-113`) écrit `Bsel` et
  `Bval` par `Object.SetProperty($obj, …)` : `deps.py` les annonce à tort comme réductibles.
- `Desg` : réellement inutilisé (aucune occurrence hors déclaration).
- `convBool`, `cpoint` : aucun appelant externe ; usages internes uniquement.
- **Dépendance forte** à `Listextcpt` (`_new`, `resext`, `letcpt`) : tout rework de `Listextcpt`
  (lot `Compta/Utils`) doit repasser LETTRAGE-T02 à T04. `Listextcpt` touche aussi
  `Fiches_Mvt1…Mvt5` (tables construites dynamiquement, non vues par `deps.py`).
- `Utils.cpoint` est utilisé dans `affichage` et `Colcli_Click` en plus de la copie locale.
- Homonymes à ne pas confondre : `TresorFac.Lettrage()` (méthode) et la clé de configuration
  `/Soc<XX>/Lettrage` (Prefs, LauruxConf) n'ont pas de lien avec cette classe.
- Ordre de rework : après `Listextcpt` et `TriCpt` (API stables), indépendant des autres écrans du lot.
