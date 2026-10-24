# FFournisseur — Dépendances

> Source : `.src/Gestion/Tables/FFournisseur.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/FFournisseur.class` — classe, formulaire associé `FFournisseur.form`
- Handlers GUI détectés : 77
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button6_Keypress`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Tabfour3_click`, `Maj_vtl`, `colfo_Click`, `colfo_Activate`, `Button6_Keypress`, `FileFilter`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Cfour_Click`, `Colcompt2_Click`, `Colech_Click`, `Colcp_Click`, `Colal2_Click`
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 1616 (1 argument(s), marqueurs aucun)
- ⚠️ Accès par l'auto-instance du formulaire alors que la classe est aussi ouverte par `New` (la fenêtre affichée n'est pas celle modifiée) : `Tricp:136` → `Bsel`, `Tricp:137` → `Codepostal`, `Tricp:138` → `Bureaudistributeur`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Button6_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Vents`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/Tricp.class` | `Bsel`, `Bureaudistributeur`, `Codepostal` |
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Saisecrit.class` | `<hérité>` |
| `.src/Compta/Tresor.class` | `<hérité>` |
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Tables/Articles.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CTestTVA` | `isIntraComValide` |
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Adrexp`, `Barcode`, `Cp`, `CpC`, `NewPage`, `Nom`, `NomC` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Enrgcp` | `Ecp` |
| `EnvMail` | `Envoi2` |
| `Gsm` | `<type>` |
| `LDate` | `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Array2String`, `Comptabilite`, `DTE`, `Fournisseurs`, `HT`, `Ouvrir`, `String2Array`, `TTC` |
| `LPrix` | `<type>` |
| `ObjProp` | `<type>`, `tri` |
| `PdfWriter` | `Open`, `Output` |
| `Serveur` | `Pass` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `TriGen` | `<type>`, `ExtraSel`, `FontSize`, `Show`, `Update` |
| `Tricp` | `<type>` |
| `Utils` | `Base`, `Calcode`, `Fcolr`, `Fill_Civilite`, `Find_cbarre`, `ObsGotf`, `ObsLstf`, `Observers`, `Remplace`, `SetEditColor`, `chkEmail`, `convBool`, `cpoint`, `db`, `rs1` |
| `Variables` | `SMajFour`, `Sexport`, `Sprix` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Docs_Ged`, `Fiches_Art`, `Fiches_Carte`, `Fiches_Centrales`, `Fiches_Comptes`, `Fiches_ContactF`, `Fiches_Cpostaux`, `Fiches_Echeances`, `Fiches_Entcom`, `Fiches_Entrecpt`, `Fiches_Etiquettes`, `Fiches_Four`, `Fiches_Four_Vtl`, `Fiches_Mo`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Tag`, `Mails_Four`

### Membres Public sans usage externe détecté (portée réductible ?)

`nom_pays`, `Tabfour3_click`, `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `CleanVtl`, `Refresh`, `CleanChamps`, `Maj_Email`, `Aff_Centrale`, `CtrlBarre`, `Codebarre`, `CtrlCbarre`, `Calc_barre`, `FrancoLF`, `FportLF`, `MinCoMLF`, `Compt_GotFocus`, `Compt_LostFocus`, `collman`, `Ventilman`, `RdimCfour`, `Ventilations`, `Maj_vtl`, `colfo_Click`, `colfo_Activate`, `Button4_Click`, `Button3_Click`, `Button2_Click`, `Button6_Keypress`, `Button6_Click`, `Enrgvent`, `Button1_Click`, `Dbclk`, `Ref`, `Button14_Click`, `init_ComboBox`, `Button15_Click`, `Imprime`, `ImprimeC`, `fin_impression`, `pos_Etiq`, `pos_EtiqC`, `Cpman`, `aff_cp`, `ChkCp`, `ChkFranco`, `Aff_Ct`, `CleanChampsCt`, `Maj_Dssr`, `Button7_Click`, `Update_ListTags`
<!-- /AUTO:dependances -->

## Notes d'analyse

### Appelants (vérifiés par `grep`)

| Appelant | Ligne | Usage |
|---|---|---|
| `Fmenu.Menu13_Click` | `Fmenu.class:571` | `Ffournisseur.ShowModal()` (auto-instance) |
| `Articles` | `Articles.class:1294` | ouverture modale depuis la fiche article |
| `Saisecrit` | `Saisecrit.class:1207` | création d'un compte fournisseur manquant |
| `Tresor` | `Tresor.class:929` | idem |
| `Facture` | `Facture.class:6345` | F4 : auto-instance |
| `Facture` | `Facture.class:5658` | F11 : **`New FFournisseur`** (instance distincte) |
| `Tricp.colco_Click` | `Tricp.class:136-138` | écrit `Bsel`, `Codepostal`, `Bureaudistributeur` sur l'**auto-instance** : sans effet sur l'instance créée en F11 (FFOURNISSEUR-A07) |
| `TriCpt` / `TriGen` | `TriCpt.class:112-113`, `TriGen.class:138-139, 228-232` | `Object.SetProperty(Me, "Bsel"/"Bval")` (dynamique) |

Aucune fonction de FFournisseur n'est appelée ailleurs : la « portée réductible » est exacte pour
les fonctions, pas pour `Bsel`/`Bval`.

### Ce que l'heuristique rate ou surestime

- **`ListTags_Add`** (`unused`) : handler de l'événement `Add` du `ListEditor` (gb.form).
- **`Button6_Keypress`** (`handlers_inactifs`) : confirmé mort (`Button6` dans le groupe `Vnt`) ;
  `deps.py` ne signale pas que **`Button6_Click`** devient mort par transitivité (son seul appelant
  est `Button6_Keypress`).
- **`C1_Click`…`V1_Click`** étiquetés « handler GUI » : `TextBox` sans événement `Click`
  (pseudo-handlers). **`Compt_GotFocus`/`Compt_LostFocus`** classés « portée réductible » à juste
  titre (pseudo-handlers du groupe `Cmpt3`), mais leur nom est conservé.
- **`Tabfour3_click`, `colfo_Click`, `colfo_Activate`** : `unused` exact (pas de contrôle de ce nom).
- **`HBox1_MouseDown`** : handler réel mais vide.
- **Clé `TabFdocs`** inexistante dans `Cbase` (CBASE-A01) ; **`TabCarte`** = `Fiches_Carte`, table des
  cartes clients, utilisée à tort pour les fournisseurs (A06).
- `CTestTVA.isIntraComValide` est appelé **sans** SIREN : la note de `Fsoc` (FSOC-009) qui annonce un
  nettoyage de SIREN dupliqué ici est inexacte ; seul le contrôle intracommunautaire est commun.
- Ressources hors base : `Pays.txt`, `~/Contacts.vcf`, `~/tmp/EtiqFour.pdf`, `xdg-open` (site, carte,
  Infogreffe, `tva-intracommunautaire.com`).

### Appels dynamiques et rejeu

- `replay_dynamic` (restent `Public`) : `Cfour_Click`, `Colcompt2_Click`, `Colech_Click`,
  `Colcp_Click`, `Colal2_Click`.
- `Vents` (ColumnView) n'a pas de `Vents_Click` : clic à éviter dans les scénarios.

### Dépendances circulaires

- `FFournisseur` ↔ `Tricp` (auto-instance), ↔ `TriCpt`/`TriGen` (`Object.SetProperty`).
- `Facture` → `FFournisseur` → (`Tricp` → auto-instance) : cycle fonctionnel cassé en F11.

### Contraintes d'ordre de rework

- **FFOURNISSEUR-010 à 013 dans le même commit que FCLIENT-011 à 014** (socle `FicheTiers`).
- FFOURNISSEUR-014 après SERVEUR-008.
- FFOURNISSEUR-A01 dépend de CBASE-A01 ; FFOURNISSEUR-A07 à traiter avec `Tricp` (lot Affichages)
  et `Facture` (lot Facturation).
- FFOURNISSEUR-A06 : à aligner sur `FClientcarte` (lot Caisse) et sur une éventuelle contrainte
  d'unicité de `fo_cb`.
