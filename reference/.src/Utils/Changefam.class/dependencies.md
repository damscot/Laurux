# Changefam — Dépendances

> Source : `.src/Utils/Changefam.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Changefam.class` — classe, formulaire associé `Changefam.form`
- Handlers GUI détectés : 12
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `verifart`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `FamList_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `LGed` | `Articles` |
| `Start` | `Musique`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Find_cbarre`, `Observers`, `db` |
| `textfamille` | `<form>`, `<type>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Docs_Ged`, `Fiches_Art`, `Fiches_ArtPromo`, `Fiches_CdBarre`, `Fiches_CdFour`, `Fiches_Cequ`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Fam`, `Fiches_HisInvT`, `Fiches_HisLigTickets`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Inv`, `Fiches_InvT`, `Fiches_LigTicketz`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Ligcom`, `Fiches_Ligrecpt`, `Fiches_Materiels`, `Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_PrdComp`, `Fiches_Rpl1`, `Fiches_Rpl2`, `Fiches_TarTypcli`, `Fiches_Tarcli`

### Membres Public sans usage externe détecté (portée réductible ?)

`art_man`, `AjoutArt`, `SelectionArt`, `SelectionFam`, `fam_Man`, `fam_Man2`, `fam_Man3`, `fam_Man4`, `Change`, `Change2`, `Change3`, `Modifart`, `verifam`, `verifart`, `verrou`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant réel** (manqué par l'heuristique) : `Fmenu.class:1376` (`Changefam.ShowModal`, menu
  Gestion). Aucun autre appel (grep `Changefam`).
- **Faux positifs « portée réductible »** :
  - `Bsel`/`Bval` sont écrits par `TriArticles` via `Object.SetProperty(Obj, "Bsel"…)`
    (`.src/Affichages/TriArticles.class:30-31,165-166`) : appel dynamique non résolu.
  - `Cmpt_KeyPress` et `cmpt_lostfocus` sont des handlers du groupe `Cmpt` déclaré dans
    `Changefam.form` (contrôles `Code`, `NvCode`, `Nfam`, `Afam2`, `Nfam2`) : non détectés comme
    handlers car le nom d'événement est le groupe, pas un contrôle.
  - `Btn_Click` : handler du groupe `Btn` (`Button1..7`).
  - `Bouton1_Click`, `Bouton2_Click`, `Bouton3_Click` : handlers de boutons créés dynamiquement
    (`New Button($hForm) As "Bouton1"`).
- **Faux négatif** : `textfamille` est utilisé comme type de 4 contrôles du `.form` (`Afam`, `Nfam`,
  `Afam2`, `Nfam2`) et de façon typée dans `verifam` ; ses méthodes `Clear`, `SetFocus`, `Select`
  et la propriété `Text` sont appelées sur ces contrôles (ex. `Afam.Clear` lignes 144 et 180).
- **Tables** : `CFamille` (temporaire de session) et `Rupture`/`RuptureC` (tables de travail créées
  par `.src/Utils/Crupt.module:21-26`) ne sont pas dans `Cbase` ni dans `db_control.csv`. Aucune table
  n'est désignée par `Cbase.Table`.
- **Dépendances transverses** : `LGed.Articles` (constante de type GED), `Utils.Find_cbarre`.
- **Ordre de rework** : à traiter **avec** `Changefour` (commonalisation) et après `textfamille`
  (son API `Clear`/`SetFocus`/`Select`/`Text` doit rester stable).
- Pas de dépendance circulaire.
