# LGed — Dépendances

> Source : `.src/Utils/LGed.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LGed.class` — classe, Create Static, formulaire associé `LGed.form`
- Handlers GUI détectés : 23
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `DelTag`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>`, `Autres` |
| `.src/Communs/LauruxMaj.module` | `Articles`, `Autres`, `Clients`, `Comptabilite`, `Fournisseurs` |
| `.src/Compta/Extrait.class` | `<type>`, `Clients`, `Comptabilite`, `Fournisseurs`, `Ouvrir`, `Search` |
| `.src/Compta/Saisecrit.class` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `HT`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `.src/Compta/Tresor.class` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `.src/Compta/Utils/EcrAuto.class` | `<type>`, `AddTags`, `Comptabilite`, `PDFDupli`, `Search`, `Supprime` |
| `.src/Gestion/Facturation/Facture.class` | `<type>`, `Clients`, `Search`, `Supprime` |
| `.src/Gestion/Facturation/ObjFac.class` | `<type>`, `AddTag`, `AddTags`, `Clients`, `DTE`, `DelAllTag`, `HT`, `PDFDupli`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `.src/Gestion/Impressions/Edbr.module` | `<type>`, `AddTag`, `AddTags`, `DTE`, `DelAllTag`, `Fournisseurs`, `HT`, `PDFDupli`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `.src/Gestion/Stock/ValidBR.class` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `Fournisseurs`, `HT`, `String2Array`, `TTC` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `AddTag`, `AddTags`, `Comptabilite`, `DTE`, `Fournisseurs`, `HT`, `String2Array`, `TTC` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `AddTag`, `AddTags`, `DTE`, `DelAllTag`, `Fournisseurs`, `HT`, `PDFDupli`, `Search`, `String2Array`, `Supprime`, `TTC` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `AddTag`, `Articles`, `HT`, `Ouvrir`, `Supprime`, `TTC` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `AddTag`, `AddTags`, `Array2String`, `Clients`, `Comptabilite`, `DTE`, `HT`, `Ouvrir`, `String2Array`, `TTC` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>`, `AddTag`, `AddTags`, `Array2String`, `Comptabilite`, `DTE`, `Fournisseurs`, `HT`, `Ouvrir`, `String2Array`, `TTC` |
| `.src/Utils/Changefam.class` | `Articles` |
| `.src/Utils/GedR.class` | `<type>`, `AddTag`, `Articles`, `Autres`, `Clients`, `Comptabilite`, `EpurationDocs`, `EpurationTags`, `Fournisseurs`, `Ouvrir` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `LBox` | `<type>`, `FileSelect` |
| `LDate` | `<type>`, `DT`, `FT`, `LT`, `Year`, `_call` |
| `LPrix` | `<type>`, `D`, `L`, `_call` |
| `LScript` | `<type>`, `Run`, `RunA` |
| `LTrans` | `<type>`, `List` |
| `ObjProp` | `<type>` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `Societe` |
| `TextReg` | `<form>`, `EstDateTime`, `EstNum`, `Text`, `Type`, `code`, `compte`, `dte`, `reg` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client`, `Fournisseur`, `Tous` |
| `TriGen` | `<type>`, `Show` |
| `Utils` | `Mkdir_p`, `Rmdir_rf`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Docs_Ged`, `Docs_Tag`, `Fiches_Tag`

### Membres Public sans usage externe détecté (portée réductible ?)

`Exist`, `DelTag`, `Get_Mime`, `Get_Default_Extension`, `MoveURL`, `Commit`, `Default_URL`, `ScannerFinalize`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux positifs de portée** : `Bsel`/`Bval` sont écrits dynamiquement par `TriCpt` et `TriGen`
  (`Object.SetProperty(Obj, "Bsel", …)`) ; `XdgMimeProc_Read`/`CurlMimeProc_Read` sont des
  événements de `Process` (`Shell … As "XdgMimeProc"`). Les autres membres listés (`Exist`,
  `DelTag`, `Get_Mime`, `Get_Default_Extension`, `MoveURL`, `Commit`, `Default_URL`,
  `ScannerFinalize`) sont bien sans appel externe (`grep`).
- **Appels via variables non typées par `deps.py`** : `lg.PDFDupli` (`ObjFac:921`,
  `commande1:652`, `Edbr:238`, `EcrAuto:584`), `lg.Ouvrir` (`GedR:107`, `FClient:3089`,
  `FFournisseur:2593`, `Extrait:1124`, `Articles:4465`), `hForm.TTC/HT/DTE`, `hForm.ShowModal`.
- **Appel statique douteux** : `Articles.class:4126` `LGed.Supprime(True)` sur l'auto-instance
  (épure seulement les tags).
- **Constantes `LGed.<type>` utilisées en SQL** par `LauruxMaj.module:5816-5840` (migration des
  anciennes tables `Docs_Clients`, `Docs_Fournisseurs`…) et `Changefam.class:516` : les valeurs de
  l'énumération sont **stockées en base** (`Docs_Ged.type`) et ne doivent jamais changer d'ordre.
- Tables (en dur) : `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` ; clés `Cbase` disponibles (`TabDocGed`,
  `TabDocTag`, `TabTag`), déjà utilisées par `Articles.class:4119`.
- SQL non portable SQLite : `insert ignore`, `LAST_INSERT_ID()` (non traduits par
  `DB_Connection`).
- Processus externes : `xdg-mime`, `curl`, `timeout`, `xsane`, `scanimage`, `convert` (via `Shell`
  et `LScript`).
- Circularité GUI : `LGed` ↔ `LBox`/`LTrans` (copie), `LGed` ↔ `GedR` (GedR ouvre LGed ;
  LGed ne connaît pas GedR). Ordre de rework : `LTrans`, `LBox`, puis `LGed`, puis `GedR`.
