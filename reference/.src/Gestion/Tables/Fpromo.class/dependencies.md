# Fpromo — Dépendances

> Source : `.src/Gestion/Tables/Fpromo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Fpromo.class` — classe, formulaire associé `Fpromo.form`
- Handlers GUI détectés : 11
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Deb3`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColPromo_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Base`, `Cdate_Dbase`, `Fcolr`, `Observers`, `SetEditColor`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_ArtPromo`, `Fiches_Promo`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb2`, `Deb3`, `Button3_Click`, `Button2_Click`, `CleanChamps`, `Maj_Zones`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1921` (`Fpromo.ShowModal()`).
- Lecteurs de `Fiches_Promo` / `Fiches_ArtPromo` : `Caisse`, `Facture`, `Articles`,
  `ArtPromo.module`, `EtiqPromo`, `StatPromo`, `Changefam` (`ArtPromo`) : la suppression en cascade
  de `Button2_Click` les affecte.
- État partagé `Utils.rs1` (écrit par `Utils.Base`, lu par `ColPromo_Data`) ; fenêtre modale, donc
  pas de concurrence avec FpromoArt.
- `Button2_Click`/`Button3_Click` : pseudo-handlers (boutons du groupe `Btn`).
- `ColPromo_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- `Deb3` : jamais appelée (`unused`).
- Ordre de rework : avec FpromoArt.
