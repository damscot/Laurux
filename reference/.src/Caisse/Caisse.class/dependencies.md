# Caisse — Dépendances

> Source : `.src/Caisse/Caisse.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Caisse.class` — classe, formulaire associé `Caisse.form`
- Handlers GUI détectés : 132
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Efface_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `InitBA6X`, `Imp_Cheque1`, `margeart`, `Button44b_click`, `Button50_Click`, `Efface_Click`, `Entree2_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColTka_Click`, `Cavoirs_Click`, `Cacomptes_Click`
- ⚠️ Accès par l'auto-instance du formulaire alors que la classe est aussi ouverte par `New` (la fenêtre affichée n'est pas celle modifiée) : `TriclientsD:66` → `Bsel`, `Attrib:22` → `origine`, `Cfacture:121` → `Ba4`, `Cfacture:138` → `Ba4`, `Cfacture:144` → `Ba4`, `Cfacture:149` → `Ba4`, `Cfacture:172` → `Ba4`, `Cfacture:233` → `Ba4`, `Cfacture:247` → `Ba4`, `Cfacture:264` → `Ba4`, `Cfacture:270` → `Ba4`, `Cfacture:275` → `Ba4`, `Svendeur:46` → `$Vendeur`, `Svendeur:48` → `$Vendeur`, `Svendeur:56` → `$Vendeur`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColumnView1`, `LigTk`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Affichages/TriclientsD.class` | `Bsel` |
| `.src/Caisse/Attrib.class` | `origine` |
| `.src/Caisse/Cmenu.class` | `<type>` |
| `.src/Caisse/Reports/Cfacture.class` | `Ba4` |
| `.src/Caisse/Svendeur.class` | `$Vendeur` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `ArtPromo` | `Intitule_Promo`, `Maj_qteplus`, `Prix_Promo`, `Prix_Promottc`, `art_Promo` |
| `Cbase` | `Table` |
| `Cfacture` | `<type>`, `Com`, `Entete`, `Entete2`, `Entete3`, `Level1`, `Level2F`, `Level2T`, `Level4`, `Lines`, `Lines2`, `Logo2`, `newPage` |
| `DB_Connection` | `Exec`, `LockIncrement` |
| `Doc` | `Open` |
| `DocActif` | `Free_Lock`, `Get_Lock` |
| `EnvMail` | `Envoi` |
| `FCalc` | `<type>`, `Resultat` |
| `Fondcaisse` | `<type>` |
| `ImageButton` | `<form>`, `<type>`, `BackGround`, `Picture`, `Text` |
| `Impression` | `Facture`, `Ticket` |
| `LDate` | `<type>`, `DT`, `L`, `LT`, `_call` |
| `LTrans` | `<type>`, `List` |
| `Moulinage` | `Generation_Bl`, `Livre_caisse` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Sha1Calc` | `CalcSha1T` |
| `Start` | `$cai`, `LocalSettings`, `Musique`, `Societe`, `son` |
| `Svendeur` | `<hérité>` |
| `TextReg` | `<type>`, `Text`, `mail`, `reg` |
| `TriArticles` | `<type>` |
| `TriCpt` | `<type>`, `Client`, `Sans_Solde` |
| `TriFacture` | `<type>`, `BonFacNonPaye` |
| `Tricartes` | `<type>` |
| `Utils` | `Bip`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Observers`, `Remplace`, `Replace`, `convBool`, `cpoint`, `db` |
| `hexdblKey` | `Crypt` |
| `numtostring` | `nbtostring` |

### Tables SQL référencées

`Fiches_Acomptes`, `Fiches_Art`, `Fiches_ArtPromo`, `Fiches_Avoirs`, `Fiches_Bl`, `Fiches_Caisses`, `Fiches_Carte`, `Fiches_Cli`, `Fiches_ClientCaisse`, `Fiches_Comptes`, `Fiches_EntTicketz`, `Fiches_LibelAvoirs`, `Fiches_LibelTicket`, `Fiches_LigTicketz`, `Fiches_Ligbl`, `Fiches_Parametres`, `Fiches_Promo`, `Fiches_Societes`, `Fiches_StkDepots`, `Fiches_Touches`, `Fiches_Tvaav`, `Fiches_Vendeurs`

### Membres Public sans usage externe détecté (portée réductible ?)

`InitBA6X`, `PrintBA6X`, `SetObservers`, `InitTouche`, `Ent_tk`, `arrondi`, `Art_man`, `calc_total`, `Ouv_Tiroir`, `Aff_viseur`, `aff_Photo`, `Prix_promo`, `Valid_Qte`, `Valid_commentaire`, `Valid_HorsVte`, `Valid_Cart`, `Valid_Remise`, `RemqShow`, `Init_Art`, `Raz`, `AppArt`, `Recup_dec`, `Decimal`, `Remises_quantitatives`, `modif_Tk`, `TestPvttc`, `Calc_Tva`, `calc_HT`, `Calc_TTC`, `Valid_Remtot`, `Ticket_Attente`, `suppr_Tk`, `Valid_Especes`, `Valid_Reste`, `Valid_Carte`, `Valid_Cheque`, `Valid_Credit`, `Valid_Bachat`, `Valid_Bavoir`, `Valid_Chequecad`, `Valid_Bautre`, `Valid_Tresto`, `Valid_Bonus`, `pointsF`, `Valid_Bacompte`, `horsven_evkeypress`, `Mvt_HorsEnc`, `Maj_Acomptes`, `Entete_Tck`, `Serial_Tk`, `imp_ligtk`, `imp_ligtk2`, `Imp_Cheque`, `Imp_Cheque1`, `Defaut_Tk`, `Init_sport`, `Init_sport2`, `Recup_Poids`, `mdp_admin`, `Valid_Mdp`, `init_paiement`, `Calc_reste`, `TabTva`, `Aff_bastk`, `Enrg_Tk`, `Init_LigTk`, `Init_Columnview1`, `Init_Reg`, `Valid_Nticket`, `impressionbon`, `ChkNtk`, `Ent_tk2`, `Serial_Facture`, `Defaut_Facture`, `Ticketz`, `Defaut_Ticketxz`, `DupliZ`, `Dupli`, `SelectionArt`, `ChkPrx`, `ChkBs`, `Aff_Art`, `Ajout_Reg_Bl`, `Recup_Client`, `ClientsDivers`, `RecupClientd`, `Enrg_Clientd`, `CartesFidelite`, `RecupCarte`, `Maj_Quantite`, `Maj_QteDep`, `Tbremq_Create`, `Delete_Reglements_Tk`, `ColumnView1_Delete`, `Recalc_Tottk`, `Ligtk_Delete`, `RenameLigne`, `Button44b_click`, `Button50_Click`, `Efface_Click`, `Numerique`, `Alpha`, `ClavFam`, `Fermer2`, `Entree2_Click`, `createPanel`, `Cbutton`, `Init2`, `Clicode`, `Codearticle`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Appelant unique** : `Cmenu.class:253` (`OCaisse = New Caisse` puis `Object.Call(OCaisse, "Show")`).
  L'instance affichée n'est **pas** l'auto-instance du formulaire.
- **Accès par le nom de classe (auto-instance)**, non vus comme des appels sur l'instance ouverte :
  `Svendeur.class:46-56` écrit `Caisse.$Vendeur` (CAISSE-A04) ; `Cfacture.class:121…275` lit
  `Caisse.Ba4` (CAISSE-A05, CFACTURE-A01) ; `Attrib.class:22` écrit `Caisse.origine` (jamais lu,
  crée une auto-instance cachée, ATTRIB-A06) ; dans le fichier même, `button29_Click` lit
  `Caisse.Codearticle` (CAISSE-A06). Ces membres doivent rester `Public` tant que les anomalies ne
  sont pas corrigées.
- **Retours par `Object.SetProperty`** : `TriCpt` (`CliAv_Select_Click`, `AcptChClicpt_Click`,
  `Button30_click`), `TriArticles` (`SelectionArt`), `Tricartes` (`CartesFidelite`) écrivent
  `Bsel`/`Bval` → `Public` obligatoire. `New Tricartes(-1)` (`ClientsDivers`) ne passe pas `Me`
  (CAISSE-A07, TRICARTES-A01).
- **`TriclientsD`** (jamais référencé, code mort) écrit `Caisse.Bsel` et `Caisse.Clicoded`, membre
  **inexistant** : sans effet tant que la classe n'est jamais ouverte (à traiter dans son lot).
- **Homonymes** : `numtostring.nbtostring` (`Imp_Cheque`, `Imp_Cheque1`) est résolu par l'outil vers
  `Caisse/numtostring.module`, alors que seul `Utils/Numtostring.module` est compilé (CAISSE-A01) ;
  `Fcaisses` a un contrôle nommé `Caisse` (faux appelant possible).
- **Heuristique surestimée** : `scope_reducible` liste des handlers (`Efface_Click`,
  `Button44b_click`, `Button50_Click`, `Entree2_Click` sont en réalité du code mort, CAISSE-003) et
  `Clicode`, `Codearticle`, `$Vendeur` : `$Vendeur` est écrit depuis `Svendeur`, `Codearticle` lu
  par `Caisse.Codearticle` → à exclure de la réduction. `horsven_evkeypress` n'est pas un handler
  (le groupe de `Frame5` est `horsven_ev`) : réductible.
- **Signaux `deps.py` traités** : `unused` = `InitBA6X` (conservé, CAISSE-A09), `Imp_Cheque1`,
  `margeart`, `Button44b_click`, `Button50_Click`, `Efface_Click`, `Entree2_Click` (CAISSE-003) ;
  `handlers_inactifs` = `Efface_Click` (groupe `Clav`) ; `unused_transitive`, `arity_errors`,
  `sql_params` : vides ; `replay_dynamic` = `ColTka_Click`, `Cavoirs_Click`, `Cacomptes_Click`
  (restent `Public`) ; `replay_missing` = `ColumnView1`, `LigTk` (scénarios au clavier, test.md).
- **Heuristique ratée** : tables en dur (`Fiches_EntTicketz`, `Fiches_LigTicketz`, `Fiches_Caisses`,
  `Fiches_StkDepots`, `Fiches_Cli`, `Fiches_LibelAvoirs`, `Fiches_Art`) ; table de travail `Tottva`
  (hors `Cbase` et `db_control.csv`) ; colonne `art_qte` lue dans `Fiches_StkDepots` qui ne l'a pas
  (CAISSE-A03) ; contrôles et handlers créés par code (`win`, `mail`, `annul`, `valid` dans
  `entremail` ; `Clav3` dans `Cbutton`) ; `SPort2_Read` est à la fois handler et appelé directement.
- **Dépendances fonctionnelles fortes** : `Moulinage.Generation_BL` (bon de caisse) et
  `Moulinage.Livre_caisse` (tickets X/Z, archivage `Fiches_HisEntTickets`, facturation des BL
  réglés) appelés sur l'auto-instance du formulaire `Moulinage` ; `Sha1Calc.CalcSha1T` (chaînage) ;
  `DocActif` (verrous `Avoirs`/`Acomptes`) ; `Impression.Ticket`/`Facture` (IMPRESSION-A01/A02).
- **Dépendance circulaire** : `Caisse` → `Cfacture` → `Caisse.Ba4` ; `Caisse` → `Svendeur` →
  `Caisse.$Vendeur`.
- **Contraintes d'ordre de rework** : CAISSE-005 après ARTPROMO-004 ; CAISSE-006 après le choix de
  la fonction d'arrondi commune (ARTICLES-011 / FACTURE-008) ; CAISSE-017 avec `FClientcarte` ;
  CAISSE-018 dans le même commit que CLAVIER-005/006 ; CAISSE-A01 avec la doc
  `Utils/Numtostring` ; CAISSE-A04 avec `Svendeur`, CAISSE-A05 avec CFACTURE-A01, CAISSE-A07 avec
  TRICARTES-A01 ; tout rework touchant `Enrg_Tk` se valide aussi par les replays de `Moulinage`
  (bande Z sur les tickets produits).
