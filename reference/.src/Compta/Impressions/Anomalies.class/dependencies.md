# Anomalies — Dépendances

> Source : `.src/Compta/Impressions/Anomalies.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Anomalies.class` — classe, formulaire associé `Anomalies.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0P`, `Level1A2`, `Lines`, `level2A2` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `ProgBar` | `<type>`, `Avancement`, `Enable_Detail`, `IsStoppable` |
| `Sha1Calc` | `CalcSha1`, `CalcSha1_Verify` |
| `Utils` | `Cdate_Dbase`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Exercice_Begin`, `Exercice_End`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.class:2445` (`Menu324_Click`, « Anomalies des clés »), `Anomalies.Show()`.
- `Exercice_Begin`/`Exercice_End` : aucun appelant externe (grep) ; portée réductible confirmée.
  Elles dupliquent `LDate.Exercice_Cloture`/`Exercice_Debut`.
- **Tables non vues par `deps.py`** : `Fiches_Mvt1` … `Fiches_Mvt5` (`"Fiches_Mvt" & Last.Tag`).
- `N_Click` est le handler du groupe `N` (`E0`, `N1`…`N5`).
- Aucune dépendance circulaire. **Ordre de rework** : après `LDate` (LDATE-008) et `Sha1Calc`.
