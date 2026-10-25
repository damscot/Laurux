# RazHistoFbl — Dépendances

> Source : `.src/Archivages/RazHistoFbl.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/RazHistoFbl.class` — classe, formulaire associé `RazHistoFbl.form`
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

`Fiches_Entrecpt`, `Fiches_Ligrecpt`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants : `Fmenu.Menu261_Click` (`ShowModal`, `Fmenu.class:2116`) et `Prgm` (nom `efb`,
  `RazHistoFbl.Show()`, `Prgm.class:73`).
- Tables : `Fiches_Entrecpt` (clé `four`, `numrecpt`) et `Fiches_Ligrecpt` (clé `code`, `numrecpt`,
  `four`, `daterecpt`, `nligne`) ; les `DELETE` ignorent `four` (A01).
- Lecteurs des données purgées : `Cstock` (recalcul de stock depuis le dernier inventaire),
  `ValidBR`/`ValidBR1` (réceptions non validées), `Articles` (historique d'achats), `Stockmvt`,
  `StatFour`, `FFournisseur`, `Edbl`, options boissons (`Edconsigne`, `Saisiedecons`,
  `Caleditcmat`, `atribvignette`).
- Effets externes : `Shell mysqldump` (`~/Sauve/<Base>EffaceB.sql`), `Syntheses.Message`.
- Aucun appel dynamique ; écran non instrumenté.
