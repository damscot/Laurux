# RazHistoFac — Dépendances

> Source : `.src/Archivages/RazHistoFac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/RazHistoFac.class` — classe, formulaire associé `RazHistoFac.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

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

`Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu259_Click` (`ShowModal`, `Fmenu.class:2104`) et `Prgm` (nom `eff`,
  `RazHistoFac.Show()`, `Prgm.class:71`).
- Tables purgées : `Fiches_HistoFac`, `Fiches_HistoLigfac`, et si la case est cochée
  `Fiches_HistoFacM`, `Fiches_HistoLigfacM` (clés `TabHisFac*`, `Cbase.module:50-63`).
- Tables liées non purgées (vérifié dans `db_control.csv`) : `Fiches_HisentMat`, `Fiches_Suivis`,
  `Fiches_Traites`, `Fiches_Lcr`, `Fiches_BordereauxC`, `Fiches_Bl`/`Fiches_BlM` (`numfac`),
  `Fiches_ligcons`/`Fiches_ligregie` (lues par `Archives` avec le n° de facture), `Docs_Ged`.
- Lecteurs des données purgées : `Archives`, `ObjFac`/`ObjFacB` (réimpression), `Cstock` (recalcul
  depuis le dernier inventaire), statistiques, `Facture` (contrôles de numérotation, à confirmer).
- Effets externes : `Shell mysqldump` (`~/Sauve/<Base>EffaceF.sql`), `Syntheses.Message`.
- Aucun appel dynamique ; écran non instrumenté.
- Rework à mener avec `RazDevis` (copie quasi exacte).
