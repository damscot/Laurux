# Edconsigne — Dépendances

> Source : `.src/Gestion/option/Edconsigne.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Edconsigne.class` — classe, formulaire associé `Edconsigne.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `<type>`, `DT`, `EDeb`, `G`, `L` |
| `Start` | `B`, `G`, `R` |
| `TextReg` | `<form>`, `Text`, `reg` |
| `Utils` | `Observers`, `db` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Cli`, `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_Ligrecpt`, `Fiches_consigne`, `Fiches_ligcons`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Ouverture unique : `menuopt.class:75` (`Edconsigne.Show`, auto-instance).
- Écrivains de `Fiches_ligcons` dont l'état dépend : `Achat.EnrConsigne`, `Saisiedecons.majcons`,
  `facopt` (BL/factures), `fourconsdroi.enregistre` (mort). Tous écrivent `codecons` ; aucun
  n'écrit `Fiches_ligcons.code` (auto-incrément), ce qui confirme le défaut de jointure (A01).
- `Textcinf`… sont des contrôles `TextReg` (propriété `reg`) ; `Chainage` gère les sauts de zone.
- Boutons de recherche du `.form` sans gestionnaire (non signalés par `deps.py`, qui ne liste que
  les gestionnaires existants).
- Aucun appel dynamique ; aucune portée réductible.
