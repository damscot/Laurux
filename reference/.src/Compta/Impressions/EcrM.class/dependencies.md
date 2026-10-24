# EcrM — Dépendances

> Source : `.src/Compta/Impressions/EcrM.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/EcrM.class` — classe, formulaire associé `EcrM.form`
- Handlers GUI détectés : 13
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `dteN1_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `dteN1_LostFocus`, `donnees1`, `donnees2`, `donnees3`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `compdate2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage2`, `Entete`, `Level1M`, `Lines`, `level2M` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Journaux` | `<hérité>` |
| `LDate` | `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate2_Dbase`, `Cdate_Aff`, `Cdate_calc`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_MvtM`, `Fiches_MvtM1`, `Fiches_MvtM2`, `Fiches_MvtM3`, `Fiches_MvtM4`, `Fiches_MvtM5`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `Createtable`, `Button1_Click`, `Raz`, `donnees1`, `donnees2`, `donnees3`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu323_Click` (`.src/Communs/Fmenu.class:2433`, menu « Ecritures
  modifiées/supprimées »). Aucun membre d'EcrM n'est appelé ailleurs (`grep -rn "EcrM\." .src`).
- **Handler inactif `dteN1_LostFocus`** (vérifié) : `Dten1` est dans le groupe `Cmpt` avec le tag
  2 ; Gambas émet `Cmpt_LostFocus` (non défini) et non `dteN1_LostFocus`, et `Cmpt_KeyPress` ne
  traite que les tags 1 et 4 (le 4 vient de `Journaux`, où il désigne `Cpt2`). La fonction n'est
  donc jamais exécutée (anomalie ECRM-A01). Pour la même raison, `dteN0_GotFocus`,
  `dteN0_LostFocus` et `dteN1_GotFocus` ne s'exécutent que par appel explicite.
- **Tables surestimées** : `Fiches_Mvt` … `Fiches_Mvt5` (variable `Tab0`, jamais interrogée) et
  `Fiches_Journaux` (variable `Tab2`, jamais utilisée) sont des faux positifs. **Tables omises** :
  `centralisation` (DDL de `Createtable`). Seules `Fiches_MvtM*`, `Fiches_Comptes`,
  `Fiches_Parametres` et `Fiches_Societes` sont réellement lues.
- **Dépendance cachée vers le formulaire `Journaux`** : `Journaux.Mouse` (l. 419 et 570) instancie
  l'auto-instance de `Journaux` ; détectée par `deps.py` (`<hérité:mouse>`), elle crée une
  dépendance EcrM → Journaux qui disparaît avec la correction ECRM-A02.
- **Ccompta** : `Level1M`, `level2M`, `BasPage2`, `Lines`, `Entete` ; `level2M` reçoit le statut
  `M`/`S` dans son paramètre `Nlot` (usage détourné, à garder tel quel).
- Aucun appel dynamique ; pas de dépendance circulaire.
- **Ordre de rework** : après LDATE-008 (`Exercice_Cloture`) et le socle commun des éditions ;
  peut servir de modèle pour la sélection d'exercice de Journaux/Balance/Editcompte.
