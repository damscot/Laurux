# Edittipp — Dépendances

> Source : `.src/Gestion/option/Edittipp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Edittipp.class` — classe, formulaire associé `Edittipp.report`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/menuopt.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `<type>`, `D`, `FinMois` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Ligbl`, `Fiches_region`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `menuopt.class:163-172` (`New Edittipp($mois, $anne)`, `edt.Print(prt)` —
  méthode héritée de `Report`, notée `<inconnu:print>` par `deps.py`).
- **Faux `unused`** : `num_Data`, `prod_Data`, `vol_Data`, `rais_Data`, `siret_Data`, `code_Data`,
  `dest_Data` sont les événements `Data` des contrôles `num`, `prod`, `vol`, `rais`, `siret`, `code`,
  `dest` de la bande `ligne` du fichier `Edittipp.report` : `deps.py` ne lit que les `.form`. Ils
  doivent rester `Public`.
- Colonnes `tipp_ligbl`, `tipp_ligfac`, `cli_dfin` ajoutées par `modfichier.fichiercarbu` (appelé
  par `Prefs.class:1345`), absentes de `db_control.csv`.
- Aucun appel dynamique.
