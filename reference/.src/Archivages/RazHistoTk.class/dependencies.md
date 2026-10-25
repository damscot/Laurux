# RazHistoTk — Dépendances

> Source : `.src/Archivages/RazHistoTk.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/RazHistoTk.class` — classe, formulaire associé `RazHistoTk.form`
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
| `Start` | `LocalSettings`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_HisEntTickets`, `Fiches_HisLigTickets`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu260_Click` (`ShowModal`, `Fmenu.class:2110`) et `Prgm` (nom `eft`,
  `RazHistoTk.Show()`, `Prgm.class:72`, non modal).
- Tables via `Cbase.Table("TabHEntTck")`/`("TabHLigTck")` = `Fiches_HisEntTickets`/
  `Fiches_HisLigTickets`, alimentées par `Moulinage` (clés `TabHisEntTck`/`TabHisLigTck`).
- Lecteurs des données purgées (impact fonctionnel) : `ArchivesTck`, `Statcai` (nom en dur),
  `HitCarte`, `EdRup`, `FClientcarte` (nom en dur), `Moulinage` (livre de caisse d'une date).
- Références non purgées : `Fiches_Bl.numtick`, `Fiches_BlM.numtick`, `Fiches_Acomptes.ntk`.
- Effets externes : `Shell mysqldump` (`~/Sauve/<Base>EffaceT.sql`), `Syntheses.Message`.
- Aucun appel dynamique ; écran non instrumenté.
- Ordre de rework : avec les autres `Raz*` (module `Epuration`) ; après SAUVESAUTO-003.
