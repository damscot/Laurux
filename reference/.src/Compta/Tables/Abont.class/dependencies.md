# Abont — Dépendances

> Source : `.src/Compta/Tables/Abont.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/Abont.class` — classe, formulaire associé `Abont.form`
- Handlers GUI détectés : 20
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ChkPrx`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colabt_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colecr`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Saisecrit.class` | `Compteur_Incr` |
| `.src/Compta/Tresor.class` | `Compteur_Incr` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `FCalc` | `<type>`, `Resultat` |
| `LPrix` | `_call` |
| `Start` | `Musique` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `Utils` | `Bip`, `Observers`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Ligabon`, `Fiches_Numabon`

### Membres Public sans usage externe détecté (portée réductible ?)

`ChkPrx`, `FillColecr`, `Supprim_ligne`, `Deb3`, `Compteman`
<!-- /AUTO:dependances -->

## Notes d'analyse

- `Compteur_Incr` : appelée par `Saisecrit.LignAbt` (`.src/Compta/Saisecrit.class:3047`) et
  `Tresor.LignAbt` (`.src/Compta/Tresor.class:2555`) **sur l'auto-instance** `Abont` : le premier
  appel instancie le formulaire caché (`_New` → `Deb3` → SQL, `Utils.Observers`). Toute modification
  de `_New` a donc un effet sur la saisie des écritures par masque.
- `Bsel`/`Bval` : écrits par `TriCpt` (`Object.SetProperty`, `.src/Compta/TriCpt.class:112-113`) —
  faux positifs de « portée réductible ».
- `ChkPrx` : aucun appel (l'appel de `Cmpt_Keypress` est commenté) → code mort.
- `Message.Erreur` (l. 201, 468) n'est pas une méthode de `Message` : `deps.py` ne contrôle pas les
  membres des classes natives, `gbc3` non plus (résolution à l'exécution).
- Les expressions des lignes (`debit`, `credit`, `libelle`, `numDoc`, `numLot`) sont évaluées par
  `Saisecrit`/`Tresor` (`var.Evaluate`) : dépendance de format entre ces fichiers.
- Ordre de rework : `Compteur_Incr` (A06) à traiter avec `Saisecrit` et `Tresor`.
