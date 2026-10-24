# Deblockbl — Dépendances

> Source : `.src/Communs/Deblockbl.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Deblockbl.class` — classe, formulaire associé `Deblockbl.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Docactif`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` et `db_control.csv` (commit `6b6b9dfc`).

- Seul appelant : `Prgm.class:113` (`Deblockbl.ShowModal`).
- **Schéma** : `Fiches_Docactif` n'a pas de colonne `numerobl` (`db_control.csv` : `doc_type`,
  `doc_num`, `user_name`, `process_id`, `machine_id`, `host_id`, `userdb_name`) ; `Fiches_Bl.numbl`
  existe (`varchar(6)`).
- Lien fonctionnel non détecté : `DocActif` (`Communs/DocActif.class`) gère les mêmes verrous.
- Aucun appel dynamique.
