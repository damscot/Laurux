# MajFbtarif2 — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` — classe, formulaire associé `MajFbtarif2.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Serveur` | `Pass` |
| `Start` | `Musique`, `son` |
| `Utils` | `Cdate_Dbase`, `Find_nbdec`, `Observers`, `cpoint`, `db` |
| `Variables` | `SMajArt`, `Sexport`, `Sprix` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`prix_base`, `PvTTcLF`, `TrC`, `Prix_achat`, `rTva`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `Maj_Etiqp`, `Maj_Etiqg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu246_Click` (`Fmenu.class:2038`, `MajFbtarif2.Showmodal()`).
- Les 12 membres `scope_reducible` sont confirmés sans appelant externe (`grep -rn "\.<nom>\b"`
  hors `Stock/Tarifs` : aucun résultat pertinent).
- Dépendance de données : `art_pbfbt`/`art_datefbt` sont écrits par `Impart` (option
  `MajFtbt`, `Impart.class:1275`) et lus par `Etiqfbtarif` (aperçu des étiquettes) : l'ordre
  d'usage est Impart → Etiqfbtarif → MajFbtarif2.
- `Serveur.Pass("Art", …)` relit `Fiches_Art` (nom en dur dans `Serveur.module:23`) pendant le
  `LOCK TABLES` : autorisé, la table est verrouillée sous ce nom.
- Tables effectivement touchées : `Fiches_Art` (lecture/écriture), `Fiches_Tvaav` (lecture),
  `Fiches_EtiProd`, `Fiches_EtiGond` (écriture, hors verrou : MAJFBTARIF2-A02).
- Pas d'appel dynamique ; aucune dépendance circulaire.
