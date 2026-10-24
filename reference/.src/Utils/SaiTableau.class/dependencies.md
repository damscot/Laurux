# SaiTableau — Dépendances

> Source : `.src/Utils/SaiTableau.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/SaiTableau.class` — classe
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Pentete_Scroll`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [229](../../../../.src/Utils/SaiTableau.class#L229), [231](../../../../.src/Utils/SaiTableau.class#L231), [232](../../../../.src/Utils/SaiTableau.class#L232)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Parametre.class` | `$prop`, `<type>`, `Netoyage`, `VisibleChoi`, `VisibleEntete`, `VisibleTot`, `VisibleTuto`, `ajout`, `ind`, `ligne`, `show` |
| `.src/Gestion/Entrées/Achat.class` | `$parent`, `$prop`, `<type>`, `Delete`, `Netoyage`, `VisibleChoi`, `VisibleTot`, `VisibleTuto`, `ajout`, `art`, `artstk`, `ind`, `ligne`, `ligne_InsLig`, `ligne_SupLig`, `lostfocus`, `mo`, `opt`, `show` |
| `.src/Gestion/Entrées/GesTar.class` | `$prop`, `<type>`, `Delete`, `Netoyage`, `VisibleChoi`, `VisibleTot`, `VisibleTuto`, `ajout`, `ind`, `ligne`, `show` |
| `.src/Gestion/Stock/VarMajTar.class` | `<type>` |
| `.src/Gestion/Stock/commande1.class` | `Netoyage`, `Tableau`, `VisibleTot`, `ind`, `ligne` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `ObjProp` | `<type>`, `AddChamp`, `Height`, `Label`, `NomControl`, `TextReg`, `Width` |
| `Sailig` | `<type>`, `Background`, `Delete`, `Dernier`, `Ind`, `MonControle`, `Panel1`, `Y`, `ecriture`, `lecture`, `prx`, `txl` |
| `TextReg` | `all` |
| `Utils` | `Accent`, `Option` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Pentete_Scroll`, `Extract`, `total`, `entete`, `pchoix`, `tuto`, `Pentete`, `Ptot`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Héritage** : `Achat` (`.src/Gestion/Entrées/Achat.class:3`) hérite de `SaiTableau` et redéfinit
  `_new`, `ajout`, `Delete`, `ligne_RetLigne`, `ligne_InsLig`, `ligne_Suplig` ; il gère aussi les
  événements `RadioButton1..3_Click` créés par `show()`.
- **Faux positifs « portée réductible »** : les membres utilisés par l'héritier via `Me.` ne sont
  pas détectés : `opt`, `mo`, `art`, `artstk`, `$parent` (Achat), ainsi que `Tableau`
  (`commande1.class:1034`, via `tbl.Tableau`) et `$prop` (`Parametre.class:167-170`, via
  `$tab.$prop`). Seuls `Extract`, `entete`, `total`, `pchoix`, `tuto`, `Pentete`, `Ptot` sont
  réellement réductibles ; `Pentete_Scroll` est un nom de handler (mort, voir architecture).
- **Appels dynamiques** (lignes 229, 231, 232) : `Object.Attach` vers des noms d'événements dérivés
  des noms de contrôles (`Utils.Accent(obj.Name)`), `LPrix`, `Ltaxe` : les héritiers et
  propriétaires reçoivent des événements `<Controle>_<Evt>`, `LPrix_change`… non visibles par
  l'analyse statique.
- **Utilisateurs** : `Parametre`, `GesTar`, `Achat` (+ `commande1` via un `Achat`), `VarMajTar`
  (type en paramètre).
- **Ordre de rework** : après `Sailig` et `ObjProp` (API consommée), avant `Achat`, `GesTar`,
  `Parametre`. Couplage fort et bidirectionnel avec `Sailig` (événements) : à traiter dans le même
  lot.
