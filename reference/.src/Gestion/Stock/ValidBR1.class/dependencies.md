# ValidBR1 — Dépendances

> Source : `.src/Gestion/Stock/ValidBR1.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/ValidBR1.class` — classe, formulaire associé `ValidBR1.form`
- Handlers GUI détectés : 11

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Stock/commande1.class` | `Ecritures` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Achat` | `Reception`, `Validee` |
| `Cbase` | `Table` |
| `Consigne` | `<type>`, `cdecol`, `cdepal`, `cdeunit`, `consigne`, `nbcol`, `nbpal`, `recupcol`, `recuppalette` |
| `DB_Connection` | `Edit`, `Exec` |
| `EcrAuto` | `<type>`, `FinImp`, `Imp`, `Impression`, `ecriture`, `numecr` |
| `LDate` | `<type>`, `DT`, `L`, `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `Fournisseurs`, `HT`, `String2Array`, `TTC` |
| `LPrix` | `Add_Taxe`, `TotNHT`, `_call` |
| `LTaxe` | `<type>`, `Montant`, `TVA` |
| `LVar` | `<type>`, `AddDate`, `Evaluate`, `ParseResult` |
| `ObjProp` | `<type>`, `AddChamp`, `cle`, `tri` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `Societe` |
| `TextReg` | `<form>`, `EstDate`, `Text`, `Type`, `all`, `dte`, `reg` |
| `TriGen` | `<type>`, `ExtraSel`, `GetAllFiltered`, `GroupBy`, `Show`, `Update` |
| `Utils` | `Option`, `db` |
| `VarEcr` | `<type>`, `Autre`, `L_ajou`, `collectif`, `compte`, `dte`, `etat`, `intitul`, `libelle`, `modifi`, `montantc`, `montantd`, `numdoc`, `numlot`, `plus`, `reccomp`, `trouve`, `type` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>` |
| `commande1` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Comptes`, `Fiches_Entrecpt`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Ligrecpt`, `Fiches_Parametres`, `Fiches_Tvaac`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** : `Fmenu.class:2292` (`Menu232_Click`, `ValidBR1.ShowModal()`),
  `commande1.class:691` (`ValidBR1.Showmodal`, bouton dans l'état « Sans »),
  `commande1.class:733` (`ValidBR1.Ecritures(...)` sur l'auto-instance, état « Réception »).
  Tous passent par l'**auto-instance** du formulaire.
- **Utilise** : `commande1` (`New Commande1(Null, …)` dans `TriBr_Activate`) → dépendance
  **circulaire** `commande1` ↔ `ValidBR1` : rework conjoint des points d'appel (`Ecritures`).
- **Appels dynamiques non vus** : `TriGen` écrit `Bsel`/`Bval` par `Object.SetProperty` et lève
  `MajSel`/`Data`/`Activate` vers `TriFou_*`/`TriBr_*`.
- **LTaxe/LPrix** : `ValidBR1.class:419` (`ltx.Montant(lpx).PuBHT.G`) dépend de LTAXE-A01 et
  LPRIX-A01, qui doivent être corrigées dans le même commit (sinon quantité appliquée deux fois).
- **EcrAuto** : `New EcrAuto(jrnal5, vecr)`, `ecriture`, `Imp`, `Impression`, `FinImp`, `numecr`
  (l. 259-264, 303-310) : replays de `ValidBR1` à repasser pour tout rework d'`EcrAuto`.
- **Tables** : `Fiches_Entrecpt` (écriture `validee`), lecture de `Fiches_Ligrecpt`,
  `Fiches_Four`, `Fiches_Comptes`, `Fiches_Art`, `Fiches_Fam`, `Fiches_Tvaac`,
  `Fiches_Parametres` ; `Fiches_Mvt`, soldes et numéros écrits indirectement par `EcrAuto` ;
  `Docs_Ged`/`Docs_Tag` via `LGed`. Toutes en dur sauf `TabFour`.
- **Phase 2** : pas d'appel à `Utils.Observers` → écran non instrumenté pour la capture des
  scénarios (VALIDBR1-A06).
- **Ordre de rework** : avec `commande1` (appel `Ecritures`), après `LTaxe`/`LPrix` (A01) et
  `EcrAuto`/`LVar` (commonalisations).
