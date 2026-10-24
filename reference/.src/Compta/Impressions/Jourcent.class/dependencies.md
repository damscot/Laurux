# Jourcent — Dépendances

> Source : `.src/Compta/Impressions/Jourcent.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Jourcent.class` — classe, formulaire associé `Jourcent.form`
- Handlers GUI détectés : 15
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 838 `Jourcent.Donnees3` (5 donnés, attendus 4), l. 921 `Jourcent.Donnees0` (4 donnés, attendus 5)
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `coljour_Click`, `coljour2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0J`, `Level5J`, `level6J`, `level7J` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe`, `son` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `Cpt_GotFocus`, `Cpt_LostFocus`, `Cpt2_GotFocus`, `Cpt2_LostFocus`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `Donnees0`, `Donnees1`, `Donnees2`, `Donnees3`, `Create_table`, `Button1_Click`, `Raz`, `Centralisation`, `Centralisation2`, `Button2_Click`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Formulaire** : `Jourcent.form` (groupes `Btn` : `Button3` `Tag` 1, `Button1` `Tag` 3,
  `Button6` `Tag` 4 ; groupe `Cmpt` ; `coljour`, `coljour2`). **Aucune commande `Button2`** :
  `deps.py` classe à juste titre `Button2_Click` en « portée réductible » ; c'est du code mort
  joignable seulement par `Btn_Click` `Case 2`.
- **Utilisé par** : `Fmenu.Menu109_Click` (`jourcent.Show`, l. 1194). Aucun autre accès à
  l'auto-instance (grep `Jourcent\.`).
- **Non vu par `deps.py`** : `Ccompta` (`Entete`, `Level0J`, `level5J`, `level6J`, `level7J`,
  `BasPage`, `Output`) ; `Visualiseur.Prog` ; table de travail `centralisation` (DDL, `SELECT`,
  `UPDATE`, `INSERT`) ; `Utils.Coulfd` (résultat inutilisé : à vérifier qu'il est sans effet de
  bord avant suppression).
- **Signatures locales incohérentes** (code mort) : `Donnees0` appelé avec 4 arguments pour 5
  (l. 921), `Donnees3` avec 5 pour 4 (l. 838). `gbc3` ne les signale pas : à vérifier en phase 2.
- **Ordre de rework** : après le socle `ImpCompta` (JOURNAUX-003 à 005, JOURNAUXM-005/006).
