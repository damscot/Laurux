# FJournaux — Dépendances

> Source : `.src/Compta/Tables/FJournaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FJournaux.class` — classe, formulaire associé `FJournaux.form`
- Handlers GUI détectés : 9
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cleanchamps`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coljo_Click`, `Coljo2_Click`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 300 (1 argument(s), marqueurs aucun)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Parametre.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`ColjoRefresh`, `Maj_Zones`, `Cleanchamps`, `Button1_Click`, `Button3_Click`, `cptman`, `Button5_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée (vérifiés) : `Fmenu.Menu115_Click` (`.src/Communs/Fmenu.class:559`),
  `Fmenu.journal_Click` (`:1266`), `Parametre` (`.src/Communs/Parametre.class:408`, `ShowModal` de
  l'auto-instance). Aucun membre appelé de l'extérieur.
- `Cleanchamps` : aucun appel (code mort, pas seulement réductible).
- `Fiches_Journaux` est lu par la saisie des écritures, `Parametre`, la clôture… : la suppression
  sans contrôle d'usage (A03) peut casser ces écrans.
- Aucun appel dynamique.
