# BalanceM — Dépendances

> Source : `.src/Compta/Impressions/BalanceM.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/BalanceM.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Classe2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Balance.class` | `Imprime` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Balance` | `<hérité>` |
| `Cbalances` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1`, `Level1a`, `Level2`, `Level2a`, `Level3`, `Level3a`, `Level4`, `Level4a` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe`, `son` |
| `TypeClient` | `<type>`, `where` |
| `Utils` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Bas_page`, `Classe`, `Classe2`, `Raz`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Balance.Button1_Click` (`Balance.class:620`). Les membres `Bas_page`, `Classe`,
  `Classe2`, `Raz` n'ont aucun appelant externe (`grep -rn "BalanceM\."`) ; `Classe2` n'a aucun appelant
  du tout.
- **Dépendance inverse vers le formulaire** : `Balance.Mouse` (l. 78, 251, 257) suppose que l'écran est
  l'auto-instance (`Fmenu.Menu31_Click` → `Balance.Show`). Dépendance circulaire `Balance` ↔ `BalanceM` :
  les deux fichiers sont reworkés ensemble.
- **Classes de rendu** : `Cbalances` (`.src/Reports/Cbalances.class`, `Inherits PdfWriter`) : `Entete`,
  `BasPage`, `Level0`, `Level1`, `Level1a`, `Level2`, `Level2a`, `Level3`, `Level3a`, `Level4`,
  `Level4a`, et les méthodes héritées `Open`, `AliasNbPages`, `Output`. `Cbalances` est aussi utilisée par
  `FTVA` : ne pas modifier ses signatures dans ce rework.
- **Tables** : `Fiches_Comptes`, `Fiches_Societes` via `Cbase` ; `Fiches_Cli` en dur (l. 82) ; la table
  d'écritures arrive en paramètre (`sTab0` = `Fiches_Mvt` … `Fiches_Mvt5`), non vue par `deps.py`.
  Lecture seule.
- **Contrôle reçu en paramètre** : `typecl As TypeClient` (`Compta/Utils/TypeClient.class`, propriété
  `where` qui produit `cli_typec IN('…', …)` via `Utils.db.Subst`).
- **Fichier produit** : `~/tmp/Balance.pdf`, ouvert par `Visualiseur.Prog` (`/Soc<XX>/caisse/CmdVis`
  ou `Desktop.Open`).
- **Ordre de rework** : BALANCEM-007 (signature d'`Imprime`) et BALANCE-008 dans le même commit.
