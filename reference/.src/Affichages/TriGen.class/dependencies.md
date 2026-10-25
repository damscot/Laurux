# TriGen — Dépendances

> Source : `.src/Affichages/TriGen.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/TriGen.class` — classe, Create Static
- Handlers GUI détectés : 17
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ExtraHave`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [138](../../../../.src/Affichages/TriGen.class#L138), [139](../../../../.src/Affichages/TriGen.class#L139), [228](../../../../.src/Affichages/TriGen.class#L228), [229](../../../../.src/Affichages/TriGen.class#L229), [231](../../../../.src/Affichages/TriGen.class#L231), [232](../../../../.src/Affichages/TriGen.class#L232)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/TriArticles.class` | `<type>`, `ExtraSel`, `Update` |
| `.src/Affichages/TriCpt.class` | `<type>`, `ExtraSel`, `Show` |
| `.src/Affichages/TriFacture.class` | `<type>`, `ExtraSel`, `GetAllFiltered`, `Refresh_Data` |
| `.src/Compta/Pointage.class` | `<type>`, `ExtraSel`, `FontSize`, `GetAllFiltered`, `Refresh_Data`, `Update` |
| `.src/Gestion/Stock/ValidBR1.class` | `<type>`, `ExtraSel`, `GetAllFiltered`, `GroupBy`, `Show`, `Update` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `ExtraSel`, `Update` |
| `.src/Gestion/Tables/Articles.class` | `<type>`, `Close`, `ExtraSel`, `Refresh_Height`, `Show`, `Update` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `ExtraSel`, `FontSize`, `Show`, `Update` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>`, `ExtraSel`, `FontSize`, `Show`, `Update` |
| `.src/Gestion/Tables/TarTypeCli.class` | `<type>`, `Close`, `ExtraSel` |
| `.src/Gestion/option/Visucmat.class` | `<type>`, `ExtraSel`, `Show`, `Update` |
| `.src/Tests/TriTest.class` | `<type>`, `ExtraSel` |
| `.src/Utils/GedR.class` | `<type>`, `ExtraSel`, `FontSize`, `GetAllFiltered`, `GroupBy`, `NoUp`, `Refresh_Data`, `Update` |
| `.src/Utils/LGed.class` | `<type>`, `Show` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `ObjProp` | `<type>`, `NomControl`, `filter`, `name`, `tri` |
| `TextReg` | `<type>`, `Delete`, `Name`, `Text`, `nofilter`, `reg` |
| `Utils` | `Observers`, `db` |
| `chainage` | `<type>`, `add` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`ExtraHave`, `GenFilter`, `DB_Incr`, `DB_Decr`, `imprime`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Dépendance croisée de test** : [`Tests/TriTest`](../../Tests/TriTest.class/dependencies.md)
  (`New TriGen(Panel1, …) As "ColTri"`, `ExtraSel`, `ColTri_MajSel`) est le banc d'essai de TriGen
  (décision utilisateur) ; il n'est ouvert par aucun écran applicatif (`jamais_reference` attendu).
- **Pas de `.form`, pas d'héritage** : `TriGen` est instancié par code (`New TriGen(...) As "<nom>"`)
  dans 14 fichiers (16 appels) : `TriArticles:155`, `TriCpt:363`, `TriFacture:134`, `GedR:260`,
  `LGed:685`, `Pointage:129`, `Visucmat:87`, `commande1:314`, `ValidBR1:50` et `:85`,
  `TarTypeCli:228`, `Articles:4453` et `:4754`, `FClient:3068` et `:3388`, `FFournisseur:2572`
  et `:2718`, `TriTest:41`.
- **Appels dynamiques sortants** (`Object.SetProperty`, l. 138-139 et 228-232) : écriture de
  `Bsel`/`Bval` sur l'objet `ob` (ou `Parent`). Ces membres doivent rester `Public` chez **tous**
  les appelants listés ci-dessus (vérifié : présents partout ; `Bval` est `Variant` chez
  `commande1` et `ValidBR1`, qui reçoivent une `Collection` de colonnes `cle`, et chez `Pointage`). `deps.py`
  ne relie pas ces écritures aux appelants : leur `Bsel`/`Bval` ne doit jamais être annoncé
  « portée réductible ».
- **Handlers des appelants** reliés par le nom d'observateur (non vus par l'analyse du `.form`) :
  `ColTri_MajSel` (TriArticles, TriCpt, TarTypeCli, commande1, Articles, TriTest), `ColTri_ReDim`
  (TriArticles, TriCpt), `ColTri_KeyPress` (TarTypeCli, commande1), `ColTri_Resize` (Articles),
  `ColTriGenDoc_MajSel` (Articles), `PanelGedDoc_MajSel` (FClient, FFournisseur), `coltri_MajSel`
  (Visucmat), `TriFou_majsel`/`TriFou_data`/`TriBr_majsel`/`TriBr_data`/`TriBr_Activate`
  (ValidBR1), `TriGen_MajSel`/`TriGen_Raz`/`TriGen_Data` (GedR, TriFacture, Pointage). Tous
  doivent rester `Public`. Les appels sans observateur (`LGed:685`, `FClient:3388`,
  `FFournisseur:2718`) n'utilisent que `Bsel`/`Bval`.
- **Faux positif d'homonymie** : `commande1.imprime` (l. 474, 617, 823) est une méthode d'un autre
  objet (`tbl`), pas `TriGen.imprime`.
- **Code mort vérifié** : `ExtraHave` (signal `unused`, aucun appel). Aucun `unused_transitive`,
  aucun `arity_errors`, aucun `replay_missing` (pas de `.form`).
- **Rejeu** : les contrôles créés par `TriGen` ne sont instrumentés (`Utils.Observers`) que si
  `Parent` n'est pas un `Panel`. Dans un `Panel`, l'instrumentation dépend de l'écran hôte, qui
  appelle en général `Utils.Observers(Me)` **avant** de créer le `TriGen` (`TriArticles`) ou pas du
  tout (`TriCpt`) : les clics dans la grille ne sont alors pas journalisés (voir test.md).
- **Tables** : aucune en littéral ; les tables viennent de la requête `Req` de l'appelant.
- **Contraintes d'ordre de rework** : toute modification de signature (`_new`, `ExtraSel`,
  `Close`…) ou d'événement impose de mettre à jour les 14 fichiers appelants dans le même commit.
  Faire le rework de `TriGen` **avant** ceux de `TriArticles`, `TriCpt`, `TriFacture`, `GedR`,
  `Pointage` (sélection multiple) et avant l'introduction de `PaginationListe`.
