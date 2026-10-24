# Analytique — Dépendances

> Source : `.src/Compta/Analytique.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Analytique.class` — classe, formulaire associé `Analytique.form`
- Handlers GUI détectés : 8

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Saisecrit.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `LDate` | `<type>`, `DT` |
| `Utils` | `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Analytiques`, `Fiches_MvtA`, `Fiches_Postes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb1`, `Button1_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Saisecrit.Button4_Click` (`Saisecrit.class:1950-1951`,
  `New Analytique(Code, Mtd, Numecrit.Text, debit.value, …)` puis `ShowModal`). `debit.value`
  (booléen) devient la chaîne `"T"`/`"F"` du paramètre `sens`.
- **Faux positif `deps.py`** : `Tbrem_Save` est le handler de l'événement `Save` de la
  `TableView` `Tbrem`, pas une méthode réductible.
- `Button1_Click` n'est pas un handler actif (bouton dans le groupe `Btn`), mais il est appelé
  par `Form_KeyPress` (F1) : ce n'est pas du code mort.
- Tables via `Cbase.Table` : `Fiches_Postes` (`TabPostes`), `Fiches_Analytiques` (`TabAna`),
  `Fiches_MvtA` (`TabMvtA`). `Saisecrit` lit et valide aussi `Fiches_MvtA` (l. 2057, 2693) :
  contrat implicite sur le format des lignes (`validee = 0` à l'insertion ici, mise à 1 par
  `Saisecrit`).
- Ordre de rework : avec `Saisecrit` pour toute évolution du contrat `Fiches_MvtA`.
