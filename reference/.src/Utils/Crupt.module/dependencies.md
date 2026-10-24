# Crupt — Dépendances

> Source : `.src/Utils/Crupt.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Crupt.module` — module
- Handlers GUI détectés : 0
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 83 (1 argument(s), marqueurs aucun)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/EdRup.class` | `Rupture` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `Utils` | `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_Entcom`, `Fiches_Ligbl`, `Fiches_Ligcom`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Gestion/Impressions/EdRup.class:335`
  (`Crupt.Rupture(CheckBox1.value, CheckBox2.value, four.Text, four2.Text, Art.Text, Art2.Text, "EdRup")`).
  Aucun autre appel (grep `Rupture(`) : le commentaire d'en-tête est obsolète.
- **Tables non vues par `deps.py`** : `Rupture` et `RuptureC` (tables de travail en dur, créées et
  supprimées ici, lues par `EdRup.class:337-460`, mises à jour par `Utils/Changefam.class:541,542`
  et verrouillées en `Changefam.class:732`).
- **Tables métier** (via `Cbase.Table`) : `Fiches_Ligcom`, `Fiches_Art`, `Fiches_Entcom`,
  `Fiches_Ligbl`, `Fiches_Bl` (lecture seule).
- **Contrat avec `EdRup`** : colonnes `codea, intitulea, four, qtecli, qtefour, qtecom, codec,
  intitulec, numcom` de `Rupture` et `codea, intitulea, four, qtecom, qte, codec, intitulec, numcom`
  de `RuptureC` ; `EdRup` modifie aussi `RuptureC.qtecom` (l. 432).
- **Ordre de rework** : avec `EdRup` (même lot), après `DB_Connection`.
