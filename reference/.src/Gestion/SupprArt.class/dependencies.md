# SupprArt — Dépendances

> Source : `.src/Gestion/SupprArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/SupprArt.class` — classe, formulaire associé `SupprArt.form`
- Handlers GUI détectés : 17
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ChkPrx`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Articles` | `art_Suppr` |
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Editeur` | `Prog_Editeur` |
| `LDate` | `_call` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `son` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Fam`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff`, `SelectionArt`, `ChkPrx`, `art_man`, `Suppression`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant vérifié** : `Fmenu.class:1989` (`Menu234_Click`, `SupprArt.ShowModal()`), seul point
  d'entrée.
- **Dépendance majeure non visible dans `used_by` inverse** : `Articles.art_Suppr`
  (`Articles.class:4060`) appelé sur l'auto-instance du formulaire `Articles` (l. 377 et 423) ;
  toutes les tables supprimées viennent de là (voir le tableau d'architecture.md). Un rework de la
  signature d'`art_Suppr` (lot Gestion/Tables) impose de mettre à jour ce fichier dans le même
  commit.
- `deps.py` ne liste pas la table de travail `Artsup` (nom dans une variable `Tab`) ni les tables
  touchées indirectement par `art_Suppr`.
- `unused` : `ChkPrx` — vérifié (aucun appel, aucune chaîne dynamique).
- `replay_dynamic` : `Colfam_Click` (ColumnView) doit rester `Public`.
- `scope_reducible` : `Aff`, `SelectionArt`, `ChkPrx`, `art_man`, `Suppression` confirmés par grep.
- `Bsel`/`Bval` sont `Public` parce que `TriCpt` et `TriArticles` les écrivent par
  `Object.SetProperty` : **ne pas réduire leur portée**.
- **Pas de `Utils.Observers(Me)`** dans le constructeur : les événements de cet écran ne sont
  probablement pas journalisés pour le rejeu (à confirmer en phase 2).
- Pas de dépendance circulaire. Ordre : après (ou avec) le rework d'`Articles.art_Suppr` si sa
  signature change.
