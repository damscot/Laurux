# FTvac — Dépendances

> Source : `.src/Compta/Tables/FTvac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FTvac.class` — classe, formulaire associé `FTvac.form`
- Handlers GUI détectés : 10
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Txtva_LostFocus`, `Tvacc_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cleanchamps`, `Txtva_LostFocus`, `Tvacc_LostFocus`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Tvalist_Click`, `Tvalist3_Click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `cpoint`, `Tvaman`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `PointBase`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Tvaac`

### Membres Public sans usage externe détecté (portée réductible ?)

`cpoint`, `Refresh`, `Maj_Zones`, `Cleanchamps`, `Cdtva_GotFocus`, `Txtva_GotFocus`, `Txtva_LostFocus`, `Tvacc_GotFocus`, `Tvacc_LostFocus`, `Button1_Click`, `Button3_Click`, `Tvaman`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.Menu113_Click` (`.src/Communs/Fmenu.class:547`, `FTvac.show`).
- **Handlers inactifs confirmés** : `Txtva_LostFocus` et `Tvacc_LostFocus` (contrôles du groupe
  `Tva`, aucun appel explicite, vérifié par `grep -rn`). Par conséquent `Tvaman` n'est jamais
  exécutée et `cpoint` (appelée seulement par `Txtva_LostFocus`) non plus.
- `Cdtva_GotFocus`, `Txtva_GotFocus`, `Tvacc_GotFocus` : handlers nominaux eux aussi inactifs mais
  **appelés explicitement** (`_New`, `Maj_Zones`, `Tva_KeyPress`, `Tvalist3_KeyPress`) : `deps.py`
  ne les signale pas, à juste titre.
- `Cleanchamps` : aucun appel (code mort). `Refresh`, `Maj_Zones` : appels internes seulement.
- Le texte `Tvaman()` dans `Movr.class:199` désigne la méthode homonyme de `Movr`, sans lien.
- Effet de bord sur `Fiches_Comptes.taux_tachat`, lu par la saisie des écritures et des achats.
- Ordre de rework : avec `FTvav` (module commun).
