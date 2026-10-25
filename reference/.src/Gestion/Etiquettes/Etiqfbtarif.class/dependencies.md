# Etiqfbtarif — Dépendances

> Source : `.src/Gestion/Etiquettes/Etiqfbtarif.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/Etiqfbtarif.class` — classe, formulaire associé `Etiqfbtarif.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Barcode`, `Code`, `Intitule`, `NewPage`, `PrixHt`, `PrixTTC`, `Rectangle`, `Tva`, `volm` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Dbase`, `Find_nbdec`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Etiquettes`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `fin_impression`, `prix_base`, `TrC`, `Prix_achat`, `rTva`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `PvTTcLF`, `Imprime`, `pos_Etiq`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants** : `Fmenu.Menu242_Click` et `Fmenu.Menu247_Click` (`Fmenu.class:2026`, `2044`,
  `Etiqfbtarif.ShowModal()`).
- **Signaux `deps.py`** : `unused`, `arity_errors`, `handlers_inactifs`, `replay_dynamic`,
  `replay_missing`, `unused_transitive` vides. `scope_reducible` (14 membres) confirmé par grep : les
  fonctions homonymes de `MajFbtarif2`, `MajTarifP`, `Impart`, `Articles` sont des copies locales,
  pas des appels.
- `deps.py` ne voit pas que `Calc_Marge`, `Calc_Percent`, `Calc_coeff` n'ont **aucun effet
  observable** (résultats jamais lus) : code mort fonctionnel relevé à la main.
- **Tables** : `Fiches_Art`, `Fiches_Tvaav` (Cbase), `Fiches_Etiquettes` (littéral). Lecture seule.
- **Dépendances externes** : `Visualiseur.Prog`, `Doc.Open`, `Shell "cd ~"`, fichiers
  `~/tmp/EtiqGond.pdf`/`.ps`.
- **Ordre de rework** : la commonalisation du calcul de prix suit le lot Gestion/Stock/Tarifs
  (`MajFbtarif2`) ; le socle `PlancheEtiquettes` suit ETIQART-010.
