# FpromoArt — Dépendances

> Source : `.src/Gestion/Tables/FpromoArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/FpromoArt.class` — classe, formulaire associé `FpromoArt.form`
- Handlers GUI détectés : 13
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Code_KeyPress`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Code_KeyPress`, `Calc_Marge`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colpromo_Click`, `ColArtPromo_Click`

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
| `TriArticles` | `<type>` |
| `Utils` | `Base`, `Cdate_Aff`, `Fcolr`, `Find_cbarre`, `Observers`, `cpoint`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_ArtPromo`, `Fiches_Ligbl`, `Fiches_Promo`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Code_KeyPress`, `Cpromo`, `ChkPrx`, `Deb2`, `CleanChamps`, `delArt`, `SelectionArt`, `art_man`, `CalcTTC`, `CalcHt`, `Recup_Tva`, `Calc_Marge`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul point d'entrée : `Fmenu.class:1927` (`FpromoArt.ShowModal()`).
- `TriArticles` (ouvert par `SelectionArt` avec `Me`) écrit `Bsel`/`Bval` par `Object.SetProperty` :
  ces variables doivent rester `Public`.
- État partagé `Utils.rs1` (écrit par `Utils.Base`, lu par `Colartpromo_Data`).
- `Code_KeyPress` : handler inactif (`Code` appartient au groupe `Cmpt`).
- `Colpromo_Click` et `ColArtPromo_Click` rejoués par `ReplayObserver.Replay_Click` : doivent
  rester `Public`.
- `Calc_Marge` : jamais appelée (`unused`).
- Tables lues : `Fiches_Promo`, `Fiches_ArtPromo`, `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Ligbl` ;
  table écrite : `Fiches_ArtPromo` (lue ensuite par `Caisse`, `Facture`, `ArtPromo.module`,
  `EtiqPromo`, `StatPromo`).
- Ordre de rework : avec Fpromo ; la fonction commune de recherche d'article concerne aussi
  MvtDepots, Sdepots et Facture.
