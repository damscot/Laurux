# Fmenu — Dépendances

> Source : `.src/Communs/Fmenu.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Fmenu.class` — classe, formulaire associé `Fmenu.form`
- Handlers GUI détectés : 284
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Tva_Click`, `journaux_Click`
- ⚠️ Accès par l'auto-instance du formulaire alors que la classe est aussi ouverte par `New` (la fenêtre affichée n'est pas celle modifiée) : `Prefs:729` → `Menushowhide`, `Prefs:736` → `Menu2showhide`, `Prefs:743` → `Menu3showhide`, `Prefs:750` → `Menu4showhide`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Coltaches`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [2550](../../../../.src/Communs/Fmenu.class#L2550)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Cmenu.class` | `<hérité>` |
| `.src/Communs/Fsoc.class` | `<hérité>` |
| `.src/Communs/LauruxConf.class` | `<hérité>` |
| `.src/Communs/Prefs.class` | `Menu2showhide`, `Menu3showhide`, `Menu4showhide`, `Menushowhide` |
| `.src/Start.module` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Abont` | `<hérité>` |
| `AffRdv` | `Calc_Timer` |
| `Agenda` | `<hérité>` |
| `Anomalies` | `<hérité>` |
| `Archives` | `<hérité>` |
| `ArchivesTck` | `<hérité>` |
| `Articles` | `<hérité>` |
| `Attribution` | `<hérité>` |
| `Balance` | `<hérité>` |
| `Banque` | `<hérité>` |
| `Bordereaux` | `<hérité>` |
| `BordereauxC` | `<hérité>` |
| `Bordrx` | `<hérité>` |
| `Btqart` | `<hérité>` |
| `Calcsolde` | `<hérité>` |
| `Calcstock` | `<hérité>` |
| `Carch` | `<hérité>` |
| `Cbase` | `Table` |
| `Centrales` | `<hérité>` |
| `Changefam` | `<hérité>` |
| `Changefour` | `<hérité>` |
| `Cielcorsp` | `<hérité>` |
| `Cielcorspj` | `<hérité>` |
| `Cielimp` | `<hérité>` |
| `ClotureF` | `<hérité>` |
| `Cmenu` | `<type>` |
| `CoefTypeC` | `<hérité>` |
| `ComMail` | `<type>` |
| `Comment` | `<hérité>` |
| `Commerciaux` | `<hérité>` |
| `ConVendeurs` | `<type>` |
| `ConsultArt` | `<hérité>` |
| `Cpostaux` | `<hérité>` |
| `DB_Connection` | `Close`, `Exec`, `IsType`, `type_mysql` |
| `DB_Log` | `<type>` |
| `DB_Sanity` | `<type>` |
| `DateTar` | `EnrTouTar` |
| `Depots` | `<hérité>` |
| `Doc` | `Open` |
| `DocActif` | `<hérité>` |
| `Dup` | `<hérité>` |
| `Ecarts` | `<hérité>` |
| `EcartsT` | `<hérité>` |
| `Echeances` | `<hérité>` |
| `Echeancier` | `<hérité>` |
| `EcrM` | `<hérité>` |
| `Ecritures` | `<hérité>` |
| `EdArt1` | `<hérité>` |
| `EdArt3` | `<hérité>` |
| `EdClient` | `<hérité>` |
| `EdDocs` | `<hérité>` |
| `EdFam` | `<hérité>` |
| `EdFour` | `<hérité>` |
| `EdMat` | `<hérité>` |
| `EdNjustifiees` | `<hérité>` |
| `EdNlettrees` | `<hérité>` |
| `EdPrep` | `<hérité>` |
| `EdRup` | `<hérité>` |
| `EdStk` | `<hérité>` |
| `Edart4` | `<hérité>` |
| `Edbl` | `<hérité>` |
| `Edcom` | `<hérité>` |
| `Edinv` | `<type>` |
| `Editcompte` | `<hérité>` |
| `EditcompteA` | `<hérité>` |
| `Edmo` | `<hérité>` |
| `Ednsaisis` | `<hérité>` |
| `EdnsaisisT` | `<hérité>` |
| `Edpaiement` | `<hérité>` |
| `Edregul` | `<hérité>` |
| `Edregulprdc` | `<hérité>` |
| `Edsdepots` | `<hérité>` |
| `Emailing` | `<type>` |
| `EmailingCarte` | `<hérité>` |
| `Epurmvtexp` | `<hérité>` |
| `Eticli` | `<hérité>` |
| `Etigond` | `<type>` |
| `EtiqPromo` | `<hérité>` |
| `EtiqRecpt` | `<hérité>` |
| `Etiqart` | `<type>` |
| `Etiqcasier` | `<type>` |
| `Etiqfbtarif` | `<hérité>` |
| `Etiquettes` | `<hérité>` |
| `Expart` | `<hérité>` |
| `Expbase` | `<hérité>` |
| `Expclient` | `<hérité>` |
| `Expcontact` | `<hérité>` |
| `ExportA47` | `<hérité>` |
| `ExportJdv` | `<hérité>` |
| `Extrait` | `<type>` |
| `FAbout` | `<hérité>` |
| `FClient` | `<hérité>` |
| `FClientcarte` | `<hérité>` |
| `FCloture` | `<hérité>` |
| `FClotureAn` | `<hérité>` |
| `FCollectif` | `<hérité>` |
| `FComptes` | `<hérité>` |
| `FEditrel` | `<hérité>` |
| `FFournisseur` | `<hérité>` |
| `FJournaux` | `<hérité>` |
| `FLibelle` | `<hérité>` |
| `FPostes` | `<hérité>` |
| `FRelCompte` | `<hérité>` |
| `FRelFacture` | `<hérité>` |
| `FRelance` | `<hérité>` |
| `FRestore` | `<hérité>` |
| `FSauve` | `<hérité>` |
| `FTVA` | `<hérité>` |
| `FTips` | `<hérité>` |
| `FTvac` | `<hérité>` |
| `FTvav` | `<hérité>` |
| `Facture` | `<type>` |
| `Facturefm` | `<hérité>` |
| `FacturefmA` | `<hérité>` |
| `Facturergbl` | `<hérité>` |
| `Famille` | `<hérité>` |
| `Fcaisses` | `<hérité>` |
| `Fclientc` | `<hérité>` |
| `Fmontant` | `<hérité>` |
| `Fprepdus` | `<hérité>` |
| `Fpromo` | `<hérité>` |
| `FpromoArt` | `<hérité>` |
| `Fsoc` | `<type>` |
| `Fsystem` | `<hérité>` |
| `Fusers` | `<hérité>` |
| `Fvendeurs` | `<hérité>` |
| `GedR` | `<hérité>` |
| `Geninv` | `<hérité>` |
| `GeninvT` | `<hérité>` |
| `Glcr` | `<hérité>` |
| `Gsm` | `<type>` |
| `Histocliart` | `<hérité>` |
| `Histovmo` | `<hérité>` |
| `HitCarte` | `<hérité>` |
| `Identite` | `<hérité>` |
| `ImpDepots` | `<hérité>` |
| `ImpJdv` | `<hérité>` |
| `ImpSage` | `<hérité>` |
| `Impart` | `<hérité>` |
| `ImpartParam` | `<hérité>` |
| `Impclient` | `<hérité>` |
| `Impcpostaux` | `<hérité>` |
| `Jourcent` | `<hérité>` |
| `Journaux` | `<hérité>` |
| `JournauxA` | `<hérité>` |
| `LDate` | `_call` |
| `LGed` | `<type>`, `Autres` |
| `LauruxConf` | `<hérité>` |
| `LauruxMaj` | `Verif_Version` |
| `Lcr` | `<hérité>` |
| `Lettrage` | `<type>` |
| `Lettragemontant` | `<hérité>` |
| `Lettragesoldes` | `<hérité>` |
| `LibelAvoirs` | `<hérité>` |
| `LibelFac` | `<hérité>` |
| `LibelTicket` | `<hérité>` |
| `MDP` | `<type>` |
| `MajFbtarif2` | `<hérité>` |
| `MajTarifM` | `<hérité>` |
| `MajTarifP` | `<hérité>` |
| `Majcasier` | `<hérité>` |
| `Majversion` | `RecupVersion` |
| `Marques` | `<hérité>` |
| `Materiel` | `<type>` |
| `Monip` | `Monip` |
| `Moulinage` | `<hérité>` |
| `Movr` | `<hérité>` |
| `Mreglement` | `<hérité>` |
| `MvtDepots` | `<hérité>` |
| `MvtProdcomp` | `<hérité>` |
| `Mvtex` | `<hérité>` |
| `Parametre` | `<hérité>` |
| `Plancomptable` | `<hérité>` |
| `Pointage` | `<hérité>` |
| `Prefs` | `<type>`, `ApplyGlobal`, `ReadGlobal`, `ReadSettings` |
| `Preparation` | `<hérité>` |
| `Prgm` | `<hérité>` |
| `Prodcomposes` | `<hérité>` |
| `RazArt` | `<hérité>` |
| `RazClientd` | `<hérité>` |
| `RazClos` | `<hérité>` |
| `RazDevis` | `<hérité>` |
| `RazHistoFac` | `<hérité>` |
| `RazHistoFbl` | `<hérité>` |
| `RazHistoTk` | `<hérité>` |
| `RazInv` | `<hérité>` |
| `RazInvT` | `<hérité>` |
| `RazRlvb` | `<hérité>` |
| `RelMoprod` | `<hérité>` |
| `RelvMo` | `<hérité>` |
| `Remisec` | `<hérité>` |
| `Remisecli` | `<hérité>` |
| `RubImp` | `<hérité>` |
| `Rubcompt` | `<hérité>` |
| `Rubresult` | `<hérité>` |
| `SaiReg` | `<hérité>` |
| `Saisecrit` | `<type>` |
| `SaisieInv` | `<hérité>` |
| `SaisieInvT` | `<hérité>` |
| `SauvesAuto` | `Sauvegarde` |
| `Sdepots` | `<hérité>` |
| `SetColors` | `<hérité>` |
| `Sms` | `<hérité>` |
| `Start` | `$tcai`, `GlobalSettings`, `LocalSettings`, `Motdepasse`, `NoTips`, `Restore_Args`, `Societe`, `UnLock`, `son` |
| `StatClimo` | `<hérité>` |
| `StatComArt` | `<hérité>` |
| `StatComm` | `<hérité>` |
| `StatFour` | `<hérité>` |
| `StatPromo` | `<hérité>` |
| `StatTypCli` | `<hérité>` |
| `Statbase` | `<hérité>` |
| `Statcai` | `<hérité>` |
| `Statut` | `<hérité>` |
| `Stockmvt` | `<hérité>` |
| `SupprArt` | `<hérité>` |
| `Syntheses` | `Message` |
| `TBord` | `<hérité>` |
| `TarTypeCli` | `<type>`, `client`, `type` |
| `Tleg` | `<hérité>` |
| `Tmail` | `<hérité>` |
| `Traites` | `<hérité>` |
| `Trecarts` | `<hérité>` |
| `Tresor` | `<type>` |
| `Ttourne` | `<hérité>` |
| `Txmo` | `<hérité>` |
| `Typec` | `<hérité>` |
| `Utils` | `Base`, `Cdate_Dbase`, `ControlTunnel`, `Exit`, `Observers`, `db`, `fermeTunnel`, `glb`, `monteTunnel`, `rs1` |
| `ValidBR1` | `<hérité>` |
| `Validinv` | `<hérité>` |
| `ValidinvT` | `<hérité>` |
| `Verbal` | `<hérité>` |
| `commande1` | `<hérité>` |
| `impfec` | `<hérité>` |
| `menuopt` | `<type>` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Cli`, `Fiches_Parametres`, `Fiches_Promo`, `Fiches_Societes`, `Fiches_Taches`, `Fiches_TarTemp`

### Membres Public sans usage externe détecté (portée réductible ?)

`RecupTaches`, `Abonnement`, `preferences`, `Config`, `Tva_Click`, `journaux_Click`, `SetObserver`, `Soc`, `intitule`, `Version`, `PsX`, `PsY`, `CpTable`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

### Appelants

- **Instanciation** : `Start.module:320` (`Menu = New Fmenu`, puis `Object.Call(Menu, "Show")` et
  `Start.MainWindow = Object.GetProperty(Menu, "Window")`). C'est l'unique instance visible.
- **Auto-instance** (nom de classe utilisé comme objet) : `Prefs.class:729-750`
  (`Fmenu.Menushowhide`, `Menu2showhide`, `Menu3showhide`, `Menu4showhide`), `Fsoc.class:496, 532,
  556, 573`, `LauruxConf.class:297`, `Cmenu.class:64` (`Fmenu.Text = …`). Ces appels visent
  l'auto-instance de la classe, distincte de l'objet créé par `Start` : voir FMENU-A13 (à confirmer
  à l'exécution). Toute modification de signature de `Menu*showhide` impose de mettre à jour
  `Prefs`.
- **Test de type** non détecté par `deps.py` : `Utils.module:976` (`If hCont Is Fmenu Then` : les
  observateurs de replay parcourent `hCont.Menus`, ce qui rend tous les menus rejouables).
- `Fsoc` reçoit `Me` (`New Fsoc(Me)`, `Menu26_Click`) et le ferme (`Fsoc.class:623`,
  `$hform.Close`) lors d'un changement de société ; `Fsoc.class:576` et `LauruxConf.class:464`
  ferment `Start.MainWindow`.

### Ce que l'heuristique rate ou surestime

- **Portée réductible sous-estimée** : `Config` et `Abonnement` n'ont aucun appelant externe
  (`Cmenu` a son propre `Config`) ; `deps.py` ne les liste pas, probablement à cause des homonymes.
- **Code mort réel** parmi les « portée réductible » : `Tva_Click`, `journaux_Click` (aucun contrôle
  `Tva` ni `journaux` dans `Fmenu.form`), `Version`, `PsX`, `PsY` (jamais référencés).
- **Table surestimée** : `Fiches_Parametres` n'est jamais interrogée (variable `Tab` affectée puis
  inutilisée dans `Form_Open`). `Fiches_Bl`/`Fiches_Cli` viennent d'`Abonnement`,
  `Fiches_Promo`/`Fiches_Societes` de `Form_Open`, `Fiches_Taches` et `Fiches_TarTemp` sont écrites en
  dur.
- **Écritures indirectes** au démarrage : `LauruxMaj.Verif_Version` (migrations de schéma),
  `DateTar.EnrTouTar` (tarifs), `Start.Restore_Args` (restauration de test), `SauvesAuto.Sauvegarde`
  à la fermeture.
- **Handlers GUI** : 284 détectés ; 6 handlers de menu sont inatteignables (menus parents ou
  séparateurs : `Menu104`, `Menu106`, `Menu121`, `Menu141`, `Menu156`, `Menu201`) et 2 n'ont pas de
  contrôle (`Tva_Click`, `journaux_Click`). Voir la carte de navigation dans architecture.md.
- **Menus dynamiques** : `Menuopt` (dossier `Gestion/option`) crée des entrées « Consignes »,
  « Régie », « Tipp », « Tarif fioul »… dont les handlers sont dans `menuopt.class`, pas ici.
- `Doc.Open` (aide), `Monip.Monip`, `AffRdv.Calc_Timer`, `Syntheses.Message` : appels directs de
  modules, bien détectés.

### Appels dynamiques

- `Object.Call(CMenu, "Show")` (l. 2550, `Menu332_Click`) : `CMenu` est typé `Object`.
- `ReplayObserver` (via `Utils.Observers(Me)`) déclenche les menus par `Menu.Value = True` : les
  noms des handlers `MenuNNN_Click` et des contrôles du `.form` sont donc **intouchables**.

### Dépendances circulaires et ordre de rework

- `Fmenu` ↔ `Prefs` (Prefs appelle `Menu*showhide`, Fmenu ouvre `Prefs`), `Fmenu` ↔ `Fsoc`,
  `Fmenu` ↔ `LauruxConf`, `Fmenu` ↔ `Cmenu` (titre de fenêtre) : cycles d'IHM sans impact sur le
  rework tant que les API `Public` restent inchangées.
- Commonalisations à faire **avant** les reworks correspondants de Fmenu : `MDP.Autorise`
  (MDP-003), `Utils.ReplicationOK` (FMENU-005, touche `Utils`, `Start`, `Facture`), constantes de
  couleurs (SETCOLORS-005).
- `Fmenu` est **en tête de tous les scénarios replay** (navigation) : ses reworks doivent être
  validés par l'ensemble des replays de démarrage (FMENU-T01 à T05) avant ceux des autres écrans.
