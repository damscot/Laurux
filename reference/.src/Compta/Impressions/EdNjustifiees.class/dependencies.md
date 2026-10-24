# EdNjustifiees — Dépendances

> Source : `.src/Compta/Impressions/EdNjustifiees.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/EdNjustifiees.class` — classe, formulaire associé `EdNjustifiees.form`
- Handlers GUI détectés : 6

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level6`, `level2` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde` |
| `TypeClient` | `<form>`, `where` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`cpt_GotFocus`, `cpt_LostFocus`, `cpt2_GotFocus`, `cpt2_LostFocus`, `Raz`, `Button1_Click`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu252_Click` (`.src/Communs/Fmenu.class:2074`,
  `EdNjustifiees.Show()`, menu « Ecritures non justifiées »).
- **Portée réductible (liste AUTO)** : `Raz` et `Button3_Click` (aucun contrôle `Button3` dans le
  `.form`, seul F1 l'appelle) sont réductibles. `Button1_Click` (contrôle du groupe `btn`, appelé par
  `Btn_Click`) et `cpt_GotFocus`/`cpt_LostFocus`/`cpt2_GotFocus`/`cpt2_LostFocus` (contrôles du
  groupe `Cmpt`, appelés explicitement) portent des noms de handlers : ils restent `Public` (règle
  PLAN, `ReplayObserver`). `Bsel`/`Bval` sont écrits par `TriCpt.ColTri_MajSel`
  (`.src/Affichages/TriCpt.class:112-113`, `Object.SetProperty`) : `Public` obligatoire.
- **Tables** : liste AUTO exacte (`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Cli`, `Fiches_Societes`),
  plus `Fiches_Typec` lu par `TypeClient`. La table de travail `Ctrln` est seulement nommée
  (`Tab1`), jamais créée ni lue ici ; ce nom est partagé avec Editcompte, EditcompteM, Extrait,
  FTVA et EdImpayes (structures différentes, collision multi-poste : EDITCOMPTE-A06 dans
  [Editcompte/rework.md](../Editcompte.class/rework.md)).
- **Lien fonctionnel avec `Csolde`** : l'écran détecte les écarts entre `Fiches_Comptes.solde`
  (tenu par `Csolde`, `BordereauxC.Maj_Collectif`, `Moulinage`…) et les écritures ; les anomalies
  de solde de BORDEREAUXC-A03 apparaissent ici.
- **Groupe `Cmpt`** : `Cpt` (tag 1), `Cpt2` (tag 2) ; F2 teste les tags 3/4 (anomalie A01).
- Aucun appel dynamique hors `TriCpt` ; pas de dépendance circulaire.
