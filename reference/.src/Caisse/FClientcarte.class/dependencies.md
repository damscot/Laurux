# FClientcarte — Dépendances

> Source : `.src/Caisse/FClientcarte.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/FClientcarte.class` — classe, formulaire associé `FClientcarte.form`
- Handlers GUI détectés : 43
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Cb_GotFocus`, `Cb_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cb_GotFocus`, `Cb_LostFocus`, `Ref`, `aff_cp`, `ChkCp`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcli_Click`, `Colcp_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Histo`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/Tricp.class` | `<hérité>` |
| `.src/Caisse/Affichages/Tricartes.class` | `<type>` |
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Enrgcp` | `Ecp` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `Tricp` | `<type>` |
| `Utils` | `Base`, `Calcode`, `Cdate_Aff`, `Cdate_Dbase`, `Fcolr`, `Fill_Civilite`, `Find_cbarre`, `ObsGotf`, `ObsLstf`, `Observers`, `Remplace`, `SetEditColor`, `chkEmail`, `cpoint`, `db`, `rs1` |
| `Variables` | `Bsel`, `Bureaudistributeur`, `codepostal` |

### Tables SQL référencées

`Fiches_Carte`, `Fiches_Cartes`, `Fiches_Cpostaux`, `Fiches_HisEntTickets`, `Fiches_HisLigTickets`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`, `CleanChamps`, `ChkPrx`, `Cb_GotFocus`, `Cb_LostFocus`, `codeBarre`, `CtrlCbarre`, `Button4_Click`, `Button3_Click`, `Button2_Click`, `Dbclk`, `Ref`, `Cpman`, `aff_cp`, `ChkCp`, `Calc_barre`, `Button7_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants réels** (vérifiés par `grep -rn`) : `Fmenu.Menu238_Click` (`Fmenu.class:2002`,
  `FClientcarte.ShowModal()`, auto-instance) et `Tricartes.ClientsCartes` (`Tricartes.class:440-443`,
  `New FClientcarte`, touche F4 dans la liste des cartes de la caisse).
- **`Tricp` → `FClientcarte`** : la ligne « Utilisé par `Tricp` » vient de `Tricp.colco_Click`
  (`Tricp.class:139-142`, origine `"Clientcarte"`), qui écrit `FClientcarte.Bsel`,
  `FClientcarte.codepostal`, `FClientcarte.Bureaudistributeur`. **Ces membres n'existent pas** :
  erreur d'exécution « Unknown symbol » (ligne 140 hors `Try`). Dépendance circulaire
  `FClientcarte` ↔ `Tricp` (à traiter ensemble, FCLIENTCARTE-A02).
- Avec l'origine `"Client"` (utilisée par `Cpman`), `Tricp` écrit dans l'auto-instance de `FClient`
  (`Tricp.class:131-134`) : dépendance cachée vers `FClient`, non vue par l'heuristique.
- **Tables** : `Fiches_Cartes` (variable `Tab` de `Button3_Click`) n'existe pas et n'est jamais
  utilisée : faux positif à ignorer. `Fiches_HisEntTickets`/`Fiches_HisLigTickets` sont nommées en dur
  (clés `Cbase` existantes : `TabHisEntTck`/`TabHisLigTck`). `Fiches_CdBarre` et `Fiches_Art` sont lues
  indirectement par `Utils.Find_cbarre` (résultat ignoré) et `Fiches_Cpostaux` est écrite par
  `Enrgcp.Ecp`.
- **Autres lecteurs de `Fiches_Carte`** : `Caisse` (`RecupClientd`, `Enrg_Clientd`, `RecupCarte`…),
  `Tricartes`, `EmailingCarte`, `HitCarte`, `FFournisseur.CtrlCbarre` (copie erronée, FFOURNISSEUR-A06),
  `LauruxMaj`. Le code-barres `"299999" & code` est reconnu par `Caisse.class:1337`.
- **Handlers inactifs** : `Cb_GotFocus`, `Cb_LostFocus` (contrôle `CB` du groupe `Cmpt`) → code mort
  (FCLIENTCARTE-002).
- **Code mort** (`unused`, vérifié) : `Ref`, `aff_cp`, `ChkCp`. `Colcp_Click`/`Colcp_KeyPress` ne sont
  pas signalés mais sont inatteignables (`Colcp` invisible, seul `aff_cp` l'affichait).
- **`replay_dynamic`** : `colcli_Click` et `Colcp_Click` doivent rester `Public` (rejeu par
  `Object.Call`).
- **`replay_missing`** : `Histo` (ColumnView sans `Histo_Click`) : ne pas cliquer dans l'historique
  dans les scénarios (REPLAYOBSERVER-A06).
- **Portée réductible** : la liste AUTO contient `Button2_Click`, `Button3_Click`, `Button4_Click`,
  `Button7_Click` (méthodes du groupe `Btn`, conservées `Public` par convention) et `Refresh`
  (masque `Control.Refresh`, à conserver). Les autres membres sont traités par FCLIENTCARTE-007.
- Aucun `arity_errors`, aucun `sql_params`, aucun `unused_transitive`.
- **Ordre de rework** : après `Tricp` (lot Affichages) pour A02 ; `ProchainCodeCarte` dans le même
  commit que `Caisse.Enrg_Clientd` ; le helper code-barres avec `FFournisseur` (FFOURNISSEUR-006 `CleEan`/`GenereCodeBarre`, FFOURNISSEUR-A06).
