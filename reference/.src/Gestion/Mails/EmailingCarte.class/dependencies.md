# EmailingCarte — Dépendances

> Source : `.src/Gestion/Mails/EmailingCarte.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Mails/EmailingCarte.class` — classe, formulaire associé `EmailingCarte.form`
- Handlers GUI détectés : 20
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `bstatut_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColCli_Click`, `ColCli2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `EnvMail` | `Envoi`, `Extension` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Statut` | `<hérité>` |
| `Utils` | `Base`, `Fcolr`, `Observers`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Carte`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`, `SetObservers`, `bstatut_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Point d'entrée** (vérifié) : `Fmenu.Menu240_Click` (`EmailingCarte.ShowModal()`, l. 2012-2016),
  auto-instance du formulaire ; `_New()` sans paramètre.
- **`bstatut_Click`** : signalé `unused` par `deps.py` à juste titre — aucun contrôle `bstatut`
  dans `EmailingCarte.form` (vérifié par `grep -c bstatut`). En revanche la référence `Statut`
  (l. 649-652) est **réelle** : aucun contrôle `Statut` dans le formulaire, c'est l'auto-instance
  du formulaire `Gestion/Tables/Statut`. À préserver tant que l'anomalie EMAILINGCARTE-A06 n'est
  pas tranchée ; `deps.py` rattache bien `Statut` (`<hérité>` dans les dépendances de Statut).
- **`Button2_Click`** : `Button2` est dans le groupe `btn` ; la méthode est appelée par
  `Btn_Click`/`Btn_KeyPress`, d'où la « portée réductible » correcte.
- **Branches inatteignables** : tags 4, 7, 8 d'`Etiq_KeyPress` ; `Btn_Click` tag 1.
- **Table non vue par `deps.py`** : `Cli_Mailing` (nom par variable), partagée avec `Emailing`.
- **Appels dynamiques** : `ColCli_Click`, `ColCli2_Click` appelés par `ReplayObserver` via
  `Object.Call` (doivent rester `Public`).
- **Contrat avec `EnvMail.Envoi`** : chemin complet passé comme répertoire (EMAILINGCARTE-A02).
- **Ordre de rework** : après `EnvMail` ; avec `Emailing` et `Eticli` (commonalisation commune).
