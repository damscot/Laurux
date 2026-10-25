# MajFbtarif1 — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` — classe, formulaire associé `MajFbtarif1.form`
- Handlers GUI détectés : 10
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `fourList_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `Utils` | `Cdate_Dbase`, `Observers`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Centrales`, `Fiches_Four`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** : `grep -rn "MajFbtarif1" .src` ne trouve que la classe et son `.form`.
  `Fmenu` (`Menu244` « Future base tarif ») ouvre `MajFbtarif2` (`Menu246`, `Fmenu.class:2038`)
  et `Etiqfbtarif` (`Menu247`), jamais `MajFbtarif1`. Les handlers sont donc tous morts, bien que
  `deps.py` ne les signale pas (ils sont levés par Gambas si la fenêtre existait).
- `fourList_Click` figure dans `replay_dynamic` : sans objet tant que l'écran est inaccessible.
- Fonction remplacée par l'option `MajFtbt` d'[`Impart`](../Impart.class/architecture.md)
  (`Impart.class:1275`, écriture de `art_pbfbt`/`art_datefbt`).
- Tables : `Fiches_Art` (écriture `art_pbfbt`, `art_datefbt`), `Fiches_Four`, `Fiches_Centrales`.
