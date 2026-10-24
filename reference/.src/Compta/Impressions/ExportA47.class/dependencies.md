# ExportA47 — Dépendances

> Source : `.src/Compta/Impressions/ExportA47.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/ExportA47.class` — classe, formulaire associé `ExportA47.form`
- Handlers GUI détectés : 13
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `finmois`, `export`, `donnees1`, `donnees2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `EnvMail` | `Envoi2` |
| `LDate` | `<type>`, `D`, `F`, `G`, `L`, `_call` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Accent`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Ex1`, `finmois`, `Exo`, `Exo1`, `Exo2`, `Exo3`, `Exo4`, `Exo5`, `DteN0_GotFocus`, `DteN0_LostFocus`, `DteN1_GotFocus`, `DteN1_LostFocus`, `CheckDate`, `export`, `Button2_Click`, `donnees1`, `donnees2`, `donnees3`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Formulaire** : `ExportA47.form` (groupes `Btn` : `Button3` `Tag` 1, `Button2` `Tag` 2,
  `Button6` `Tag` 4 ; groupe `cmpt` : `DteN0` `Tag` 1, `Dten1` `Tag` 2 ; `EC`, `EN`, `E1`…`E5`,
  `Panexp`, `Envoi`, `DateChooser1`, `Button1`/`Button4`). Seul appelant :
  `Fmenu.Menu298_Click` (`ExportA47.ShowModal()`, l. 2310).
- **Non vu par `deps.py`** : `LDate` (`_call`, `EDeb`, `EFin`, `G`, `L`, `D`, `F`) — chaque
  `EDeb`/`EFin` exécute une requête `Fiches_Parametres` ; `ProgBar` (`New`, `Show`,
  `Avancement`, `Close`) ; `Editeur.Prog_Editeur` ; `EnvMail.Envoi2` (dans `export()`, code
  mort) ; `Dialog` ; `Utils.Accent` ; table de travail `centralisation` (DDL).
- **Faux positif** : `finmois` et `export` n'apparaissent pas dans « portée réductible » (noms
  homonymes ailleurs) mais n'ont **aucun** appelant, interne ou externe (grep).
- **Dépendances de comportement** : le contenu du fichier dépend de `Utils.Accent` (UTILS-A12 :
  `ô` → `e` ; `'` → `\'`) et de `LDate.Exercice_Fin`/`Exercice_Debut` (LDATE-A02/A03). Corriger
  ces anomalies **modifie le FEC produit** : les tests EXPORTA47 doivent être repassés dans le
  même commit.
- **Ordre de rework** : après `LDate` et `Utils.Accent` (ou en même temps que leurs anomalies) ;
  socle `ImpCompta.TableMvt` (JOURNAUX-003) avant EXPORTA47-004.
