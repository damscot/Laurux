# TarTypeCli — Dépendances

> Source : `.src/Gestion/Tables/TarTypeCli.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/TarTypeCli.class` — classe, formulaire associé `TarTypeCli.form`
- Handlers GUI détectés : 21
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>`, `client`, `type` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `client`, `type` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `client`, `type` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Articles` | `<hérité>` |
| `Cbase` | `Table` |
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Doc` | `Open` |
| `LPrix` | `<type>`, `Add_Taxe`, `G`, `PuNHT`, `PuNTC` |
| `LTaxe` | `<type>`, `Remise`, `TVA` |
| `ObjProp` | `<type>`, `AddChamp` |
| `Start` | `son` |
| `TextReg` | `<form>`, `EstNum`, `MaxLength`, `RechX`, `RechY`, `Text`, `Type`, `Value`, `champs`, `commence_par`, `conteneur`, `lke`, `nbdec`, `recherche`, `reg` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Client`, `Sans_Solde` |
| `TriGen` | `<type>`, `Close`, `ExtraSel` |
| `Typec` | `<hérité>` |
| `Utils` | `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_TarTypcli`, `Fiches_Tarcli`, `Fiches_Tvaav`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`TypeC_man`, `Aff_Tarart`, `SelectionArt`, `Art_man`, `Calc_Remise`, `Refresh`, `Calc_coeff`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Points d'entrée** (vérifiés par `grep -rn`) : `Fmenu:2190,2199`, `FClient:3263,3273`,
  `Articles:4536,4546`. Tous utilisent l'énumération publique `client`/`type` : elle reste
  `Public`. Arguments du constructeur : `(choix, Parent, cat, article)` (les arguments du parent
  `Window` s'insèrent après les arguments obligatoires de la classe, vérifié avec `gbs3`).
- **`replay_dynamic`** : `Coltype_Click` (`ColumnView`) reste `Public`.
- **Handlers de `TriGen`** : `ColTri_MajSel`, `ColTri_KeyPress` (objet `New TriGen(…) As
  "ColTri"`, événements `MajSel` et `keyPress`, `TriGen:234,433`).
- **`LPrix_change`** : événement `change` de `$lpx` (`New LPrix(…) As "LPrix"`).
- **`Bsel`/`Bval`** : écrits par `TriCpt` (`TriCpt:112-113`) et `TriArticles` (`TriArticles:30-31`)
  via `Object.SetProperty` : `Public`.
- **Vraies réductions** : `TypeC_man`, `Aff_Tarart`, `SelectionArt`, `Art_man`, `Calc_Remise`,
  `Refresh`, `Calc_coeff` (aucun appel externe).
- `Variables.OrgTarTypeCli` et `Variables.$TarTypeCli` (`Variables.module:13,15`) ne sont lus
  nulle part (code mort à signaler au lot Utils).
- **Ordre de rework** : TARTYPECLI-007 avec GESTAR-008.
