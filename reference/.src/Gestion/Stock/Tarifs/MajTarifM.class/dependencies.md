# MajTarifM — Dépendances

> Source : `.src/Gestion/Stock/Tarifs/MajTarifM.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/Tarifs/MajTarifM.class` — classe, formulaire associé `MajTarifM.form`
- Handlers GUI détectés : 35
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Deb4`, `Calc_coeff`, `Dbclk`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `fourList_Click`, `colarts_Click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Deb2`, `Deb3`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CPrix` | `CTva`, `Cascade` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `EtiqRecpt` | `<hérité>` |
| `Serveur` | `Pass` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Base`, `CDec`, `Fcolr`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `ObsLstf2`, `Observers`, `Obstch`, `SetEditColor`, `cpoint`, `db`, `rs1` |
| `Variables` | `SMajArt`, `Sexport`, `Sprix` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_Fam`, `Fiches_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`pbhtLF2`, `TrC2`, `PaUAGF2`, `PaUALF2`, `TxLF2`, `FraisLF2`, `Coeff2`, `Pourcent2`, `PvhtLF2`, `PvTTcLF2`, `Tva_Calcul2`, `arrondi2`, `Reaff2`, `Tris`, `Deb2`, `Deb3`, `Deb4`, `CleanChamps`, `Maj_Zones`, `Fam2`, `Calc_Marge`, `Calc_Percent`, `Calc_coeff`, `Calc_Marge2`, `Calc_Percent2`, `Calc_coeff2`, `Calc_coeff3`, `Calc_coeff4`, `ChkPrx`, `Dbclk`, `Art_Dblclk`, `ChkInput2`, `Deb5`, `Deb6`, `Maj_Etiqp`, `Maj_Etiqg`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Seul appelant : `Fmenu.Menu249_Click` (`Fmenu.class:2056`, `MajTarifM.Show()`).
- `unused` confirmés par `grep` : `Deb4`, `Calc_coeff`, `Dbclk` ; `unused_transitive` : `Deb2`,
  `Deb3` (appelées seulement par `Dbclk`).
- `scope_reducible` : les 36 membres sont sans appelant externe (homonyme `Tris` dans
  `FComptes.class:729` = `Ccomptes.Tris`, sans rapport) ; `Dbclk`, `Art_Dblclk` ne sont pas des
  handlers (noms sans `_<Événement>` valide).
- `replay_dynamic` : `fourList_Click`, `colarts_Click` restent `Public`.
- Groupes du `.form` : `Cmpt` (tags 1, 8-16), `Rem` (tags 1-3), `Ard` (`Arr2`, `Nbd2`, `Dec2`), `Dsg`
  (`Dsg1`, `Dsg2`, invisibles, sans handler).
- `Utils.Base(colarts, sql)` remplit `Utils.rs1`, lu par `colarts_Data` : couplage par état global.
- `CPrix` ([architecture](../../../../Utils/CPrix.module/architecture.md)) : `Cascade` (remises en
  cascade) et `CTva` (taux de TVA).
- Ordre de rework : après ARTICLES-011/012 (fonctions pures communes) et SERVEUR-008.
