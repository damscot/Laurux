# Verbal — Dépendances

> Source : `.src/Compta/Utils/Verbal.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Verbal.class` — classe, formulaire associé `Verbal.form`
- Handlers GUI détectés : 3
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `date1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LDate` | `_call` |
| `Start` | `Musique`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`date1`, `Ex1`, `Exo`, `dteN0_LF`, `dteN1_LF`, `Compdate`, `compdate2`, `Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `Fmenu.Menu132_Click` (`Fmenu.class:1332`, `Verbal.ShowModal`,
  Comptabilité > Outils > Vérification des balances).
- **Tables** : `Fiches_Parametres` (dates de clôture `dteclec`, `dteclec1`), `Fiches_Comptes`
  (type `C`/`F`/`G`/`B`, `coll`), `Fiches_Mvt` (écritures validées de l'exercice courant). Noms
  écrits en dur ; `Cbase` fournit `TabParam`, `TabComptes` et `TabMvt` (SQL identique).
  `deps.py` ne liste pas les tables de ce fichier (champ `tables` vide) : faux négatif, les noms
  sont affectés à `Tab`/`Tab2` puis concaténés.
- `Syntheses.Message` n'affiche rien : il joue un son et une synthèse vocale si `/son2` est actif.
- `date1` n'est appelée nulle part (`grep -rn "date1" .src/Compta/Utils/Verbal.class` : seulement la
  définition) mais `deps.py` ne la signale pas en « portée réductible » (fonction sans appelant,
  à classer en code mort).
- `LDate(...)` (fabrique `_call`) et `.L` : dépendance au format `dd.mm.yyyy` de `LDate.L_Read`.
- Contrainte d'ordre : la commonalisation des dates d'exercice est à faire avec `RubImp` et les
  écrans de `Compta/Impressions` qui ont le même idiome `Ex1`/`Exo`.
