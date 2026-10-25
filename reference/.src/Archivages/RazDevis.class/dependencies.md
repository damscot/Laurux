# RazDevis — Dépendances

> Source : `.src/Archivages/RazDevis.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/RazDevis.class` — classe, formulaire associé `RazDevis.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Ligbl`, `Fiches_LigblM`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu290_Click` (`RazDevis.ShowModal()`, `Fmenu.class:2260`).
- Tables purgées : `Fiches_Bl`/`Fiches_Ligbl` (`type = 'D'`) et, en option, `Fiches_BlM`/`Fiches_LigblM`.
- Tables liées non purgées (vérifié dans `db_control.csv`) : `Fiches_AdrlivBL` (supprimée ailleurs
  par `ObjFacB.class:1094` et `OptFac.class:154`), `Fiches_EntMat`, `Fiches_Suivis.numdev`, `Docs_Ged`.
- Fichier de sauvegarde partagé avec `RazClientd` (`EffaceD.sql`).
- Effets externes : `Shell mysqldump`, `Syntheses.Message`.
- Aucun appel dynamique ; écran non instrumenté.
- Rework à mener avec `RazHistoFac` (copie quasi exacte).
