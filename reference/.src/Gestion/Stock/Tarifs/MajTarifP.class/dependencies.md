# MajTarifP — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/MajTarifP.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/MajTarifP.class` — classe, formulaire associé `MajTarifP.form`
- Handlers GUI détectés : 8
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Prix_achat`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `fourList_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `EtiqRecpt` | `<hérité>` |
| `Serveur` | `Pass` |
| `Start` | `Musique`, `son` |
| `Utils` | `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Variables` | `SMajArt`, `Sexport`, `Sprix` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Four`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`ChkPrx`, `fourMan`, `prix_base`, `PvTTcLF`, `TrC`, `Prix_achat`, `rTva`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `Maj_Etiqp`, `Maj_Etiqg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu248_Click` (`Fmenu.class:2050`, `MajTarifP.show()`).
- `Prix_achat` (`unused`) confirmé : aucun appel, ni dans le fichier ni ailleurs.
- Les 14 membres `scope_reducible` sont confirmés sans appelant externe ; `fourList_Click`
  (`replay_dynamic`) reste `Public`.
- Handlers du groupe `Cmpt` (`Four`, `Pourcent`) : `Cmpt_GotFocus`, `Cmpt_keyPress`.
- `Button1` (« Doc HTML ») n'a pas de handler (aucune action).
- Tables : `Fiches_Art`, `Fiches_Four`, `Fiches_Tvaav`, `Fiches_EtiProd`, `Fiches_EtiGond` (toutes
  via `Cbase.Table`).
- À reworker dans le même lot que `MajFbtarif2` et `Etiqfbtarif` (classe commune `LTarifCalc`).
