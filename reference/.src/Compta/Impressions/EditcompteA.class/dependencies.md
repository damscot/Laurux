# EditcompteA — Dépendances

> Source : `.src/Compta/Impressions/EditcompteA.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/EditcompteA.class` — classe, formulaire associé `EditcompteA.form`
- Handlers GUI détectés : 15
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 726 `Ccompta.Level4C` (4 donnés, attendus 5)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `content1`, `donnees2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0C`, `Level1CA`, `Level2CA`, `Level3C`, `Level4C`, `Level5C`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Analytiques`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_MvtA`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `dteN0_LostFocus`, `dteN1_LostFocus`, `Compdate`, `compdate2`, `Raz`, `content1`, `donnees`, `donnees2`, `Button1_Click`, `Centralisation`, `finmois`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant réel** : `Fmenu.Menu293_Click` (`Fmenu.class:2272`, `EditcompteA.ShowModal()`, menu
  Analytiques > Comptes). Aucun autre fichier n'utilise la classe.
- **`Button2_Click` « portée réductible »** : exact, et plus encore **code mort** : le `.form` n'a pas de
  `Button2` ni de contrôle du groupe `Btn` avec `Tag = 1` (seuls `Button1` tag 2 et `Button6` tag 3).
- **Faux positifs** : `Bsel`, `Bval` (écrits par `TriCpt` via `Object.SetProperty`).
- **Pseudo-handlers** : `dteN0_LostFocus`, `dteN1_LostFocus` (champs du groupe `Cmpt`, appelés seulement
  par `Cmpt_KeyPress`).
- **Tables** : `deps.py` liste `Fiches_Mvt`…`Fiches_Mvt5` (affectés à `Tab0`), mais l'impression lit
  `Fiches_MvtA` (`Cbase.Table("TabMvtA")`) et `Fiches_Analytiques` (`TabAna`) ; `Tab0` ne sert qu'à
  l'export mort. Table de travail `Ctrlnc` (DROP/CREATE/INSERT/UPDATE) non vue : c'est la seule écriture
  en base.
- **Classe de rendu** : `Ccompta` (`Level0C`, `Level1CA`, `Level2CA`, `Level3C`, `Level4C`, `Level5C`,
  `Lines`, `Entete`, `BasPage`). L'appel `level4C` à 4 arguments (l. 726) ne correspond pas à la
  signature à 5 paramètres (`Ccompta.class:548`) : `deps.py` ne contrôle pas l'arité.
  `Ccompta` est partagé par 15 fichiers : ne pas modifier ses signatures pour corriger A01.
- **Doublon structurel** : `Editcompte` (29 fonctions identiques) — tout rework d'une fonction commune
  doit être appliqué aux deux classes ou passer par le helper commun.
- **Ordre de rework** : la fusion de `Button1_Click` dans `EditcompteM` est conditionnée aux
  décisions sur EDITCOMPTEA-A01/A02 ; les étapes locales (code mort, saut de page, portée) sont
  indépendantes.
