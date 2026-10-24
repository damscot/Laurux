# journauxSetting — Dépendances

> Source : `.src/Compta/Impressions/journauxSetting.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/journauxSetting.class` — classe, formulaire associé `journauxSetting.form`
- Handlers GUI détectés : 9
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ListBox1`, `ListBox2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Journaux.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Musique`, `Societe` |
| `Utils` | `Observers` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`testColonne`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Formulaire** : `journauxSetting.form` (`ListBox1`, `ListBox2`, `BtnValider`, `BtnAnnuler`).
  Le handler `listbox2_Drop` est écrit en minuscules (Gambas ignore la casse) : ne pas le
  renommer.
- **Utilisé par** : `Journaux.BtnPrefColonnes_Click` (`journauxSetting.ShowModal`, auto-instance
  modale, l. 788).
- **Contrat de données non visible par `deps.py`** : clés `/ExportJournal<soc>/Entete0..15` et
  `/Titre0..15` écrites ici et lues par `Journaux.Colonnes` et `Journaux.Button4_Click` ; les
  indices 0 à 11 désignent les cases de `Journaux.p[]`. Toute modification doit être faite dans
  le même commit des deux côtés.
- Aucun SQL, aucun appel dynamique.
