# TriArticles — Dépendances

> Source : `.src/Affichages/TriArticles.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriArticles.class` — classe, formulaire associé `TriArticles.form`
- Handlers GUI détectés : 15
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ChkInput`, `TriArticles_KeyPress`, `_KeyPress`, `FourMan`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colist_Click`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [30](../../../../.src/Affichages/TriArticles.class#L30), [31](../../../../.src/Affichages/TriArticles.class#L31), [165](../../../../.src/Affichages/TriArticles.class#L165), [166](../../../../.src/Affichages/TriArticles.class#L166)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Attrib.class` | `<type>` |
| `.src/Caisse/Caisse.class` | `<type>` |
| `.src/Gestion/Depots/MvtDepots.class` | `<type>` |
| `.src/Gestion/Entrées/Achat.class` | `<type>` |
| `.src/Gestion/Etiquettes/Etigond.class` | `<type>` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `<type>` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `<type>` |
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Impressions/EdArt1.class` | `<type>` |
| `.src/Gestion/Impressions/EdArt2.class` | `<type>` |
| `.src/Gestion/Impressions/EdArt3.class` | `<type>` |
| `.src/Gestion/Impressions/EdRup.class` | `<type>` |
| `.src/Gestion/Impressions/EdStk.class` | `<type>` |
| `.src/Gestion/Impressions/Edart4.class` | `<type>` |
| `.src/Gestion/Stock/Mvtex.class` | `<type>` |
| `.src/Gestion/Stockmvt.class` | `<type>` |
| `.src/Gestion/SupprArt.class` | `<type>` |
| `.src/Gestion/Tables/Btqart.class` | `<type>` |
| `.src/Gestion/Tables/FpromoArt.class` | `<type>` |
| `.src/Gestion/Tables/Materiel.class` | `<type>` |
| `.src/Gestion/Tables/Prodcomposes.class` | `<type>` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>` |
| `.src/Gestion/option/Saisiedecons.class` | `<type>` |
| `.src/Gestion/option/Ttarfioul.class` | `<type>` |
| `.src/Gestion/option/facopt.class` | `<type>` |
| `.src/Statistiques/Histocliart.class` | `<type>` |
| `.src/Utils/Calcstock.class` | `<type>` |
| `.src/Utils/Changefam.class` | `<type>` |
| `.src/Utils/Changefour.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `LCoul` | `<type>`, `Art_DB_bgcolor` |
| `ObjProp` | `<type>`, `AddChamp`, `tri` |
| `Start` | `LocalSettings`, `Societe` |
| `TriGen` | `<type>`, `ExtraSel`, `Update` |
| `Utils` | `Fcolr`, `Log`, `ObsGotf`, `Observers`, `Obstch`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Centrales`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Mo`

### Membres Public sans usage externe détecté (portée réductible ?)

`Update_Req`, `ChkInput`, `TriArticles_KeyPress`, `_KeyPress`, `FourMan`, `Filter_Calc`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants (`New TriArticles(…)`, 31 appels dans 29 fichiers)** : `Attrib:215`, `Caisse:6977`,
  `Changefam:191`, `Changefour:156`, `Calcstock:177`, `Saisiedecons:366`, `Ttarfioul:200`,
  `facopt:471`, `Etigond:162`, `Etiqcasier:146`, `Etiqart:155`, `Achat:270`, `SupprArt:286`,
  `MvtDepots:197`, `Mvtex:264`, `Stockmvt:931`, `EdStk:88`, `EdRup:134`, `EdArt1:334`,
  `EdArt2:326`, `EdArt3:330`, `Edart4:450` et `:461`, `FpromoArt:418`, `TarTypeCli:292`,
  `Materiel:340`, `Btqart:81`, `Facture:4432`, `Prodcomposes:464` et `:673` (`"mo_code"`),
  `Histocliart:192`. Tous passent `Me` en 9ᵉ argument et lisent ensuite leurs propres
  `Bsel`/`Bval` (`Public` vérifié dans les 29 fichiers ; `Bval` `Variant` chez `Caisse`).
- **Arité** : 9 arguments pour 8 paramètres est **correct** (5 obligatoires, puis `Parent` du
  `Form` = `Null`, puis `Dispo`, `Mat`, `ob`) ; `deps.py` a raison de ne rien signaler.
- **Appels dynamiques sortants** : `Object.SetProperty(Obj, "Bsel"/"Bval")` (l. 30-31 : remise à
  zéro ; l. 165-166 : sélection). **Entrants** : `TriGen` écrit `Bsel`/`Bval` de `TriArticles`
  (`TriGen.class:138-139, 228-232`) et lève `ColTri_MajSel`/`ColTri_ReDim` (handlers reliés par
  `As "ColTri"`, non vus par l'analyse du `.form`) : membres et handlers à garder `Public`.
- **Faux homonymes** : `Edinv`, `Edinv1`, `Stockmvt`, `Edart4`, `Histocliart` ont une méthode
  privée `TriArticles(fam As Trifam)` (tri de l'arbre des familles) sans rapport avec la classe.
- **Code mort vérifié** (signal `unused`) : `ChkInput`, `TriArticles_KeyPress`, `_KeyPress`,
  `FourMan` ; aucun appel, ni direct ni par chaîne. `replay_dynamic` : `Colist_Click` (doit rester
  `Public`). Pas de `replay_missing` (la grille `Coltri` est créée par `TriGen`, hors `.form`).
- **Tables** : `Fiches_Art` (`TabArt`), `Fiches_Mo` (`TabMo`), `Fiches_Four` (`TabFour`),
  `Fiches_Fam` (`TabFam`), `Fiches_Centrales` (`TabCentrales`), toutes par `Cbase.Table`.
- **Liens depuis les documents des appelants** : `Materiel` et `Prodcomposes` citent la classe en
  texte (`.src/Affichages/TriArticles.class`) ; la documentation de référence est ce dossier.
- **Ordre de rework** : après `TriGen` (TRIGEN-001 à 006). Une évolution de l'API (`Choisir`)
  impose de modifier les 29 appelants dans le même commit.
