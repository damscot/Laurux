# RazClientd — Dépendances

> Source : `.src/Archivages/RazClientd.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Archivages/RazClientd.class` — classe, formulaire associé `RazClientd.form`
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
| `Start` | `LocalSettings`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Clid`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu296_Click` (`RazClientd.ShowModal()`, `Fmenu.class:2298`), entrée
  « Epuration des clients divers caisses » du sous-menu « Epurations », sans mot de passe.
- `Fiches_Clid` (clé `TabClid`, `Cbase.module:140`) : lue seulement par
  [`TriclientsD`](../../Caisse/Affichages/TriclientsD.class/dependencies.md) (code mort,
  TRICLIENTSD-A01) et purgée ici ; **aucun code ne l'alimente** (vérifié par grep, hors
  migrations `LauruxMaj`). Report du lot Caisse (notes transverses).
- Fichier de sauvegarde `~/Sauve/<Base>EffaceD.sql` partagé avec `RazDevis` (écrasement mutuel).
- Effets externes : `Shell mysqldump`, `Syntheses.Message` (`pico2wave`/`aplay` si `/son2`).
- Aucun appel dynamique ; écran non instrumenté (`Utils.Observers` absent).
- Ordre de rework : décider d'abord RAZCLIENTD-A01 (suppression) ; sinon traiter avec les autres
  `Raz*` (module `Epuration`).
