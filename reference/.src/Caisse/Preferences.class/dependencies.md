# Preferences — Dépendances

> Source : `.src/Caisse/Preferences.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Preferences.class` — classe, formulaire associé `Preferences.form`
- Handlers GUI détectés : 11

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Cmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LauruxConf` | `<hérité>` |
| `Majversion` | `<hérité>` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `Observers` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`SetObservers`, `aff_logo`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelant unique : `Cmenu` (auto-instance `Preferences.ShowModal()`, [Cmenu.class:305](../../../../.src/Caisse/Cmenu.class#L305) et
  [Cmenu.class:345](../../../../.src/Caisse/Cmenu.class#L345)).
- Dépendances **par clé de configuration** (non vues par `deps.py`, qui ne suit pas les chaînes
  `LocalSettings`) : voir le tableau de architecture.md. Les plus sensibles : `Caisse` (17 clés),
  `Impression` (`Cimp`, `CmdImp`, `TKpdf` ; clés globales pour la facture), `Start`
  (`Font`, `choixtouches`), `Ouverture` (`tactile`, `choixtouches`), `Cmenu` (`admin2`).
- Clés écrites sans lecteur : `caisse/FACpdf`, `caisse/son`, `caisse/tircarte` (PREFERENCES-A01,
  A02). `caisse/intitule` n'a ni contrôle ni usage effectif (aller-retour).
- Commande externe `lpc` (paquet `cups-bsd`) : à mentionner dans DEPENDANCES.md si absente.
- Ordre de rework : PREFERENCES-A01 dans le même commit qu'IMPRESSION-A01/A02.
