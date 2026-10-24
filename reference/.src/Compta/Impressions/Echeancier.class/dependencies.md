# Echeancier — Dépendances

> Source : `.src/Compta/Impressions/Echeancier.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Echeancier.class` — classe, formulaire associé `Echeancier.form`
- Handlers GUI détectés : 15
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level0`, `Level1E`, `level2`, `Level3`, `Level4`, `Level5`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0`, `Level1E`, `Level4E`, `Level5E`, `Lines`, `level2E` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Raz`, `Level0`, `Level1E`, `level2`, `Level3`, `Level4`, `Level5`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu303_Click` (`.src/Communs/Fmenu.class:2339`,
  `Echeancier.ShowModal()`, menu « Echéanciers »).
- **Portée réductible confirmée** : `Level0`, `Level1E`, `level2`, `Level3`, `Level4`, `Level5`
  n'ont aucun appelant (`grep -rn "Echeancier\." .src`) ; ce sont des méthodes `Draw` mortes,
  homonymes de méthodes de `Ccompta` (les appels `pdf.Level…` visent `Ccompta`). `Raz` n'est
  appelé qu'en interne.
- **Tables** : la liste AUTO est exacte. `Fiches_Reglements`, `Fiches_Societes` et la variante
  filtrée (`Fiches_Mvt`/`Fiches_Comptes`/`Fiches_Cli`) sont écrites en dur ; `Cbase` n'a pas de clé
  pour `Fiches_Reglements` (à ajouter dans `Cbase.module` si le rework ECHEANCIER-005 est retenu :
  appelant impacté `Cbase`).
- **`Ccompta`** : `Level0`, `Level1E`, `level2E`, `Level4E`, `Level5E`, `Lines`, `BasPage`,
  `Entete`.
- Aucun appel dynamique ; aucune dépendance circulaire.
- **Ordre de rework** : après le socle commun des éditions et LDATE-008 ; ajout éventuel de la clé
  `Cbase` avant ECHEANCIER-005.
