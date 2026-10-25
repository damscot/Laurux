# Epurmvtexp — Dépendances

> Source : `.src/Gestion/Stock/Epurmvtexp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Epurmvtexp.class` — classe, formulaire associé `Epurmvtexp.form`
- Handlers GUI détectés : 4
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `date1_LostFocus`, `date2_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `date1_LostFocus`, `date2_LostFocus`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 150 (1 argument(s), marqueurs aucun)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_calc`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Mvtexp`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_date`, `date1_LostFocus`, `date2_LostFocus`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.class:1957` (`Menu229_Click`, `EpurMvtexp.ShowModal()`, casse
  différente du nom de fichier, auto-instance du formulaire).
- **Handlers inactifs confirmés** : `Date1` et `Date2` sont déclarés `TextBox Cmpt` dans
  `Epurmvtexp.form` (l. 53 et 60) ; aucun `Cmpt_*` dans la classe. `date1_LostFocus` et
  `date2_LostFocus` (signalés `unused` et `handlers_inactifs`) ne sont donc jamais appelés ; la
  « portée réductible » de ces deux noms est sans objet (code mort).
- **Tables** : `Fiches_Parametres` (lecture), `Fiches_Mvtexp` (lecture et suppression), en dur
  (la clé `TabMvtexp` existe dans `Cbase`).
- **Lecteurs de `Fiches_Mvtexp` impactés par la purge** : `Cstock.module` (recalcul de
  `art_qte`), `Stockmvt.class:115-116`, `TriHistos.class:122/272`, `Edregul`, `ValidinvT:59`,
  `Changefam:529`, `Articles:4129` ; écrivain : `Mvtex.Enrgbl`.
- Aucun appel dynamique ni dépendance circulaire. Rework indépendant ; la correction de A01 doit
  être validée en même temps que les tests de `Mvtex` et de `Cstock` (mêmes données).
