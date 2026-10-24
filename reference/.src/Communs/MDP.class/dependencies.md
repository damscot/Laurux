# MDP — Dépendances

> Source : `.src/Communs/MDP.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/MDP.class` — classe, formulaire associé `MDP.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Communs/Fsoc.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Motdepasse`, `Societe`, `son` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Mdp2_LF`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **Appelants réels** : `Fmenu` (8 × `MDP.showmodal()` sur l'auto-instance : `Menu25`, `Menu26`,
  `Menu65`, `Menu110`, `Menu142`, `Menu150`, `Menu166`, `Menu173` ; `New MDP(Null, True)` dans
  `Menu329`) et `Fsoc.class:401` (`MDP.showmodal()`).
- **Faux positif** : `Caisse/Ouverture.class` (lignes 89-184) utilise un **contrôle** `Mdp` de son
  propre formulaire (`Mdp.Text`, `Mdp.SetFocus`), pas cette classe (résolution insensible à la
  casse de `deps.py`).
- **Contrat implicite** : la valeur de retour passe par `Start.Motdepasse` (global `Public` de
  `Start.module:30`) ; tout appelant doit le remettre à `""`.
- **Écrivain des mots de passe** : `Prefs.class:531` (`MdpPrefsG`) et `:536` (`MdpPrefs`) ; même
  déchiffrement dans `Prgm.Mdp_LF` et `Prefs.Mdp_LF` (`Prefs.class:466`).
- Aucun appel dynamique ; aucune table.
- **Ordre de rework** : MDP-003 (API statique) avant FMENU-006, PRGM-003 et le rework équivalent de
  `Fsoc`/`Prefs`.
