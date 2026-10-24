# EditcompteM — Dépendances

> Source : `.src/Compta/Impressions/EditcompteM.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/EditcompteM.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Compta/Impressions/Editcompte.class` | `Imprime` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0C`, `Level1C`, `Level2C`, `Level2s`, `Level3C`, `Level4C`, `Level4T`, `Level5C`, `Lines` |
| `DB_Connection` | `Engine`, `Exec` |
| `Editcompte` | `<hérité>` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Societes`, `Fiches_SousComptes`

### Membres Public sans usage externe détecté (portée réductible ?)

`bas_page`, `Centralisation`, `finmois`, `Raz`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Editcompte.Button1_Click` (`Editcompte.class:678`). `bas_page`,
  `Centralisation`, `finmois`, `Raz` n'ont aucun appelant externe ; `deps.py` ne marque que `bas_page`
  comme réductible, les trois autres sont exclus à cause d'homonymes (`Raz` est aussi une classe ;
  `Centralisation`/`finmois` existent dans 4 à 5 autres fichiers) : **faux négatifs**, vérifiés par
  `grep -rn "EditcompteM\."`.
- **Dépendance inverse** : `Editcompte.Mouse` (l. 100, 274) → auto-instance de l'écran ; dépendance
  circulaire `Editcompte` ↔ `EditcompteM`.
- **Tables** : `Fiches_Comptes`, `Fiches_Societes`, `Fiches_SousComptes` en dur ; la table d'écritures
  arrive par `Tab0` (`Fiches_Mvt`…`Fiches_Mvt5`, non vue) ; table de travail `Ctrln` écrite
  (DROP/CREATE/INSERT/UPDATE), non vue par `deps.py`.
- **Classe de rendu** : `Ccompta` (`Entete`, `BasPage`, `Lines`, `Level0C`, `Level1C`, `Level2C`,
  `Level2s`, `Level3C`, `Level4C`, `Level4T`, `Level5C`), partagée par 15 fichiers.
- **Fichier produit** : `~/tmp/Glivre.pdf` via `Visualiseur.Prog`.
- **Ordre de rework** : EDITCOMPTEM-005 (centralisation commune) dans le même lot que EDITCOMPTE-006 et
  EDITCOMPTEA-004 ; la fusion avec `EditcompteA.Button1_Click` attend la décision sur EDITCOMPTEA-A01/A02.
