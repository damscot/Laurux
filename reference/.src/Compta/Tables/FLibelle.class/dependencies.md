# FLibelle — Dépendances

> Source : `.src/Compta/Tables/FLibelle.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FLibelle.class` — classe, formulaire associé `FLibelle.form`
- Handlers GUI détectés : 4
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `Remplace`, `db` |

### Tables SQL référencées

`Fiches_Libelles`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `num_GotFocus`, `num_LostFocus`, `intitule_GotFocus`, `intitule_LostFocus`, `Button1_Click`, `Button2_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.Menu24_Click` (`.src/Communs/Fmenu.class:684`).
- **Handlers nominaux inactifs non signalés par `deps.py`** : `num_GotFocus`, `num_LostFocus`,
  `intitule_GotFocus`, `intitule_LostFocus` (contrôles du groupe `Lib`). Ils sont appelés
  explicitement, donc vivants ; `deps.py` ne les liste pas parmi les inactifs car il exclut les
  noms appelés dans le fichier (comportement correct).
- La table est lue par `Saisecrit.class:805` et `Tresor.class:210` (`Cbase.Table("TabLibel")`) :
  repasser leurs replays de saisie si le contenu de la table de test change.
- Aucun appel dynamique.
