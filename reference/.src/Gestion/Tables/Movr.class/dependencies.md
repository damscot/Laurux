# Movr — Dépendances

> Source : `.src/Gestion/Tables/Movr.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Movr.class` — classe, formulaire associé `Movr.form`
- Handlers GUI détectés : 42
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Txht_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Txht_LostFocus`, `Valeur2TTC_LF`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colmo_Click`, `fourList_Click`, `FamList_Click`, `CmoList_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Facturation/Facture.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Base`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `PointBase`, `Remplace`, `cpoint`, `db`, `rs1` |
| `gridvi` | `<type>`, `bouton_Click`, `code`, `dec`, `razcol` |
| `textfamille` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Fiches_Fam`, `Fiches_Four`, `Fiches_Ligbl`, `Fiches_Mo`, `Fiches_Tvaav`, `Fiches_Txtmo`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`, `CleanChamps`, `RdimColmo`, `code_LF`, `Dbclk`, `Ref`, `mo_man`, `TvaMan`, `FamMan`, `fourMan`, `TxMoMan`, `Txht_LostFocus`, `Button3_Click`, `Prvt_LF`, `Valeur_LF`, `Valeur2_LF`, `Valeur2TTC_LF`, `Calc_MargeMo`, `Button4_Click`, `Button7_Click`, `Valeur2TTC_LostFocus`, `Valeur2TTC_Calcul`, `arrondi`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée (auto-instance, modale) : `Fmenu.Menu37_Click` (`.src/Communs/Fmenu.class:911`)
  et `Facture.mo_KeyPress` (`.src/Gestion/Facturation/Facture.class:3159`, touche F4 sur la zone
  de code MO). Aucun membre appelé de l'extérieur : `deps.py` les voit comme `<hérité>`
  (`ShowModal` de `Form`), c'est exact.
- `Gridvi` (`.src/Utils/gridvi.class`, mode `"M"`) : onglet de statistiques de vente de la MO,
  lecture seule (`Fiches_Parametres`, lignes de BL/factures, `Fiches_Mo`) ; mêmes usages dans
  `Articles` (`"A"`), `FClient` (`"C"`), `Famille` (`"F"`), `Ttourne` (`"T"`).
- `Utils.rs1` : `Result` global partagé par `Utils.Base` ; `Colmo_Data` le relit à chaque cellule.
  Movr étant modal, la collision n'apparaît qu'au retour vers un écran appelant qui utilise aussi
  `rs1` (ex. `Facture`, à vérifier dans le lot Facturation).
- Tables : `deps.py` voit `Fiches_Fam`, `Fiches_Four`, `Fiches_Ligbl`, `Fiches_Mo`, `Fiches_Tvaav`,
  `Fiches_Txtmo` (noms en dur ou via `Tab`) ; `Cbase.Table("TabMo")` résout aussi `Fiches_Mo`.
  Seule `Fiches_Mo` est modifiée (INSERT, UPdate, DELETE).
- Autres écrivains de `Fiches_Mo` : `Txmo.MajMo` (taux, prix de revient, marge), `FTvav.Recalcul`
  (`mo_valeurttc` au changement de taux de TVA). Autres fichiers citant `Fiches_Mo`/`TabMo` (à repasser si le format
  d'une colonne change) : `Facture`, `ObjFac`, `Facturergbl`, `ValidBR`, `Listecom`, `Edmo`,
  `Articles`, `Famille`, `FFournisseur`, `Prodcomposes`, `TriArticles`, `TriMo`, `gridvi`, `Dup`,
  statistiques (`Histovmo`, `RelvMo`, `Statbase`).
- `handlers_inactifs` (`deps.py`) : `Txht_LostFocus` est un vrai handler inactif (`Txht` dans le
  groupe `Cmpt`, de plus en lecture seule) ; `Valeur2TTC_LF` n'a pas une forme de handler
  (suffixe `_LF`) mais n'est appelée nulle part : les deux sont du **code mort** (MOVR-002).
  `Valeur2TTC_LostFocus`, `Button3_Click`, `Button4_Click`, `Button7_Click` sont aussi des
  pseudo-handlers (contrôles groupés) mais appelés explicitement : à juste titre absents des
  handlers inactifs.
- Rejeu dynamique (`Object.Call`, REPLAYOBSERVER-A06) : `Colmo_Click`, `fourList_Click`,
  `FamList_Click`, `CmoList_Click` restent `Public`.
- Ordre de rework : avec `Txmo` (marge commune, MOVR-006/TXMO-005) et avec `Materiel`
  (`ArrondiPrix`, MOVR-007/MATERIEL-008). Pas de dépendance circulaire.
