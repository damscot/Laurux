# Ecritures — Dépendances

> Source : `.src/Compta/Utils/Ecritures.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Ecritures.class` — classe, formulaire associé `Ecritures.form`
- Handlers GUI détectés : 14
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `type_compte`, `QuitteEcritjl`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Ecrit_Click`, `EcritGL_Click`, `EcritJL_click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Saisecrit` | `<type>` |
| `Sha1Calc` | `CalcSha1` |
| `Start` | `Musique`, `son` |
| `Tresor` | `<type>` |
| `Utils` | `Cdate_Aff`, `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`type_Click`, `type_compte`, `QuitteEcritjl`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:905` (`Menu10_Click`, `Ecritures.Show`).
- **Portée réductible** : `type_Click` (appelée en interne uniquement ; aucun contrôle `type` dans le
  `.form`) ; `type_compte` et `QuitteEcritjl` n'ont **aucun** appelant (les `Type_compte()` de
  `Saisecrit.class:1109…` et `Tresor.class:2449` sont leurs propres méthodes).
- Utilise `Saisecrit` (`New Saisecrit(num, Me.Parent, True)`) et `Tresor` (`New Tresor(num)`) : leurs
  constructeurs ne doivent pas changer sans mettre à jour ce fichier.
- `Necrit_Click` rappelle `Ecritures.Show` sur l'auto-instance (la fenêtre ouverte par `Fmenu` est
  justement l'auto-instance).
- Tables en dur : `Fiches_Comptes`, `Fiches_Mvt` (clés `TabComptes`, `TabMvt` existantes).
