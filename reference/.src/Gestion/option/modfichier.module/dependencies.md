# modfichier — Dépendances

> Source : `.src/Gestion/option/modfichier.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/modfichier.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prefs.class` | `fichierboisson`, `fichiercarbu`, `supf` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `AutoIncrement`, `Edit`, `Engine`, `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_AdrlivC`, `Fiches_Art`, `Fiches_Cli`, `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Ligcom`, `Fiches_Ligrecpt`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_consigne`, `Fiches_ligcons`, `Fiches_ligregie`, `Fiches_ligtarpp`, `Fiches_regie`, `Fiches_region`, `Fiches_tarpp`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Prefs.pp_Click` / `bois_Click` (`Prefs:1345-1356`), à chaque coche.
- **Schéma hors référence** : `Fiches_regie`, `Fiches_consigne`, `Fiches_ligcons`,
  `Fiches_ligregie`, `Fiches_region`, `Fiches_tarpp`, `Fiches_ligtarpp`, `Art_Tipp` et toutes les
  colonnes ajoutées sont absentes de `db_control.csv` et de `Laurux01.sql` (vérifié par `grep`).
  `deps.py` liste bien les tables (littéraux), sauf `Art_Tipp` (préfixe non reconnu).
- **Dépendants du schéma** (non visibles comme dépendances d'appel) : `ObjFacB`, `facopt`,
  `artopt`, `Calculdroit`, `Caleditcmat`, `fourconsdroi`, `Edittipp`, `Tregion`, `Ttarfioul`,
  `Tconsigne`, `Tregie`, `Facture`, `VerifDate`, `Utils.orientation`, `Parametre`.
- **Recouvrement avec `LauruxMaj.Maj369`** (`LauruxMaj.module:5501-5510`) : intouchable.
- **Ordre de rework** : indépendant ; les tests des fichiers de l'option dépendent du schéma
  produit ici (jeu `facturation_boisson`).

