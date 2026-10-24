# Achat — Dépendances

> Source : `.src/Gestion/Entrées/Achat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Entrées/Achat.class` — classe, hérite de `SaiTableau`
- Handlers GUI détectés : 7
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Code_gotfocus`, `Code_lostfocus`, `Code_KeyPress`, `Pal_gotfocus`, `Col_gotfocus`, `rem_lostfocus`, `TX_Conv_lostfocus`, `Px_Brut_lostfocus`, `Frais_lostfocus`, `LPrix_change`, `ligne_RetLigne`, `ligne_InsLig`, `ligne_Suplig`, `RadioButton1_click`, `RadioButton2_click`, `RadioButton3_click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Rech_click`, `radioBchange`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Entrées/GesTar.class` | `FicheArt`, `Tarif` |
| `.src/Gestion/Stock/ValidBR1.class` | `Reception`, `Validee` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `Consignes`, `ContMat`, `CreMat`, `CreRec`, `CreReliquat`, `CreaCommande`, `Delete`, `Doublon`, `EnCommande`, `EnrAch`, `FicheArt`, `Import`, `LitCommande`, `Reception`, `Sans`, `Show`, `SupAchat`, `TotHt`, `TotTtc`, `Validee`, `ajout`, `commentaire`, `date`, `fourisseur`, `generer`, `imprime`, `mail`, `ndoc` |
| `.src/Gestion/Stockmvt.class` | `Validee` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Articles` | `<hérité>` |
| `Consigne` | `<type>`, `cdecol`, `cdepal`, `cdeunit`, `consigne_montant`, `nbcol`, `nbpal` |
| `DB_Connection` | `Create9`, `Edit`, `Exec`, `Lockstock`, `RecArt` |
| `Editeur` | `Prog_Editeur` |
| `EnvMail` | `Envoi2` |
| `LDate` | `<type>`, `DT`, `GnT`, `L`, `_call` |
| `LPrix` | `<type>`, `Arr_0001`, `Mnt`, `PuBHT`, `PuNHT`, `PuNTC`, `Qte` |
| `LTaxe` | `<type>`, `Frais`, `Montant`, `Remise`, `TVA` |
| `ObjProp` | `<type>`, `AddChamp`, `Button`, `Height`, `NomControl`, `Width`, `name` |
| `ProgBar` | `<type>`, `Avancement` |
| `SaiTableau` | `$parent`, `$prop`, `<type>`, `Delete`, `Netoyage`, `VisibleChoi`, `VisibleTot`, `VisibleTuto`, `ajout`, `art`, `artstk`, `ind`, `ligne`, `ligne_InsLig`, `ligne_SupLig`, `lostfocus`, `mo`, `opt`, `show` |
| `Sailig` | `<type>`, `AutresObj`, `Ind`, `MonControle`, `Tag`, `chain`, `ecriture`, `lecture`, `prx`, `reception` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |
| `TextReg` | `EstNum`, `commence_par` |
| `TriArticles` | `<type>` |
| `Utils` | `Find_cbarre`, `cpoint`, `db` |
| `VarMajTar` | `<type>` |
| `artopt` | `<type>` |
| `calculdroit1` | `code`, `degre`, `secu_droit`, `volume_total` |
| `chainage` | `<type>`, `add`, `sup` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_ContactF`, `Fiches_Entcom`, `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Ligcom`, `Fiches_Ligrecpt`, `Fiches_Materiels`, `Fiches_Tvaav`, `Fiches_ligcons`, `Fiches_ligregie`, `Mails_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`ligne_LecCode`, `Code_gotfocus`, `Code_lostfocus`, `Code_KeyPress`, `Rech_click`, `qte_lostfocus`, `Pal_gotfocus`, `Pal_lostfocus`, `Col_gotfocus`, `Col_lostfocus`, `rem_lostfocus`, `TX_Conv_lostfocus`, `Px_Brut_lostfocus`, `Frais_lostfocus`, `LPrix_change`, `ligne_RetLigne`, `ligne_InsLig`, `ligne_Suplig`, `RadioButton1_click`, `RadioButton2_click`, `RadioButton3_click`, `OptAr`, `mat`, `rec`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Pas de `.form`** : classe héritée de `SaiTableau`, instanciée uniquement par
  `commande1:63` (`New Achat($prop, Panel2, panel3) As "Achat"`). Le seul écran à rejouer est
  donc `commande1`.
- **Handlers dynamiques (faux positifs `unused` et `scope_reducible`)** : `Code_gotfocus`,
  `Code_lostfocus`, `Code_KeyPress`, `Rech_click`, `qte_lostfocus`, `Pal_gotfocus`, `Pal_lostfocus`,
  `Col_gotfocus`, `Col_lostfocus`, `rem_lostfocus`, `TX_Conv_lostfocus`, `Px_Brut_lostfocus`,
  `Frais_lostfocus` sont levés par les contrôles des lignes, rattachés à l'instance par
  `Object.Attach(obj, Me, Utils.Accent(obj.name))` (`SaiTableau:229`) ; `LPrix_change` par
  `Object.Attach(lg.prx, Me, "LPrix")` (`SaiTableau:231`) ; `ligne_RetLigne`, `ligne_InsLig`,
  `ligne_Suplig` sont des redéfinitions des handlers de `SaiTableau` (lignes `As "ligne"`) ;
  `RadioButton1/2/3_click` sont levés par les boutons créés `As "RadioButton1..3"`
  (`SaiTableau:73-80`). Ils doivent tous rester `Public` et garder leur nom.
- `Reliquat_lostfocus` : observateurs `New Observer(…) As "Reliquat"` (`CreRec`) ; `abandon_click`,
  `valider_click`, `BtDbl_Click`, `ButT_click`, `mail_change`, `mail_click` : contrôles créés par
  code avec `As "<nom>"`.
- **Vraies réductions possibles** (vérifiées par `grep -rn`) : `ligne_LecCode`, `mat`, `rec`
  (usage interne) ; `OptAr` jamais affecté (code mort).
- **Variables `Public` écrites de l'extérieur** : `Bsel`/`Bval` par `TriArticles`
  (`Object.SetProperty`, `TriArticles:30-31`) ; `TotHt`/`TotTtc` par `commande1:266-267`
  (lus ensuite par `EnrAch`, `imprime`, `commande1:650,733`) ; `commentaire` par `commande1`.
- **Événements levés** vers `commande1` : `ajou` (`Achat_Ajou`, `commande1:217`), `LecArt`
  (`Achat_LecArt` → `GesTar.LecArt`, `commande1:241`), `EnrTarTemp` (`Achat_EnrTarTemp` →
  `GesTar.EnrTarTemp`, `commande1:878`), `gotfocus`/`lostfocus` hérités
  (`commande1:1029,1043`).
- **Énumérations lues ailleurs** : `CreaCommande`, `EnCommande`, `Reception`, `Validee`, `Sans`
  (`commande1`, `ValidBR1:200-202`, `Stockmvt:680`) ; `Tarif`, `FicheArt`, `Consignes`
  (index de `Sailig.AutresObj`, `GesTar:230-800`, `commande1:258,758-761`).
- **Accès non résolus par `deps.py`** : membres de `Consigne` via `AutresObj[Consignes].ccd`
  (`recuppalette`, `recupcol`, `consigne`, `suspendu`…) et de `VarMajTar` via
  `AutresObj[Tarif]` (`IgnoreTarif`) : objets `Variant`. `articles.ShowModal()` (ligne 258)
  désigne l'auto-instance du formulaire `Articles`.
- **Transaction partagée** : `commande1` ouvre `Utils.db.Begin`, `SupAchat` fait `Rollback` en
  cas d'erreur, `EnrAch` fait `Commit` (ligne 895) puis met à jour le stock **hors**
  transaction ; `commande1` refait `Utils.db.Commit` après `GesTar.EnrTar`. Tout rework de ces
  méthodes doit être fait avec `commande1`.
- **Ordre de rework** : après `SaiTableau`/`Sailig` (classe de base) et avec `commande1` et
  `GesTar` (énumérations et `AutresObj` partagés).
