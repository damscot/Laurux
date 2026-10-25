# RazRlvb — Dépendances

> Source : `.src/Archivages/RazRlvb.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/RazRlvb.class` — classe, formulaire associé `RazRlvb.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `ProgBar` | `<type>` |
| `Start` | `LocalSettings`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Rappro`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu262_Click` (`RazRlvb.ShowModal()`, `Fmenu.class:2122`), menu
  « Epuration des relevés bancaires » de la comptabilité, sans mot de passe. Vérifié par
  `grep -rn RazRlvb .src`.
- `ProgBar` figure dans « Utilise » à cause de la déclaration `Dim PB As ProgBar`, jamais utilisée.
- Table : `Fiches_Rappro`, nommée en dur (pas de `Cbase.Table`) ; la clé `TabRappro` existe
  (`Cbase.module:368`) et est utilisée par `Pointage` (10 accès : lecture du relevé précédent,
  insertion, mise à jour, suppression).
- Dépendance de données : `Pointage` lit le dernier relevé d'un compte
  (`order by date_releve desc limit 1`) pour proposer le solde de départ ; `Fiches_Mvt*.nrlv`
  mémorise le numéro de relevé des écritures pointées. La purge ne touche ni l'un ni l'autre
  (références orphelines, voir RAZRLVB-A04).
- Effets externes : `Shell mysqldump` (fichier `~/Sauve/<Base>EffaceR.sql`), `Syntheses.Message`
  (`pico2wave`/`aplay` si `/son2`).
- Aucun appel dynamique ; pas d'`Utils.Observers` (écran non instrumenté).
- Ordre de rework : après la création de `Utils.DumpBase` (SAUVESAUTO-003) pour RAZRLVB-004 ; le
  module `Epuration` (RAZRLVB-006) se fait en un seul commit avec les cinq autres `Raz*`.
