# FClient — Dépendances

> Source : `.src/Gestion/Tables/FClient.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/FClient.class` — classe, formulaire associé `FClient.form`
- Handlers GUI détectés : 101
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Maj_vtl`, `Remmo_LF`, `Remart_LF`, `Ref`, `Cpman`, `ChkCp`, `FileFilter`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcli_Click`, `Colcompt2_Click`, `Coltype_Click`, `Colech_Click`, `Colcp_Click`, `Colal_Click`, `Colal2_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colmat`, `Vents`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/Tricp.class` | `Bsel`, `Bureaudistributeur`, `Codepostal` |
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Saisecrit.class` | `<hérité>` |
| `.src/Compta/Tresor.class` | `<hérité>` |
| `.src/Gestion/Facturation/Facture.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Adrexp`, `Cp`, `CpC`, `NewPage`, `Nom`, `NomC` |
| `ComMail` | `<type>` |
| `DB_Connection` | `AutoIncrement`, `Create9`, `Edit`, `Engine`, `Exec` |
| `Doc` | `Open` |
| `Enrgcp` | `Ecp` |
| `EnvMail` | `Envoi2` |
| `Extrait` | `<type>` |
| `Gsm` | `<type>` |
| `LDate` | `_call` |
| `LGed` | `<type>`, `AddTag`, `AddTags`, `Array2String`, `Clients`, `Comptabilite`, `DTE`, `HT`, `Ouvrir`, `String2Array`, `TTC` |
| `LPrix` | `<type>` |
| `Listecom` | `<type>` |
| `ObjProp` | `<type>`, `tri` |
| `PdfWriter` | `Open`, `Output` |
| `Serveur` | `Pass` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TarTypeCli` | `<type>`, `client`, `type` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `TriGen` | `<type>`, `ExtraSel`, `FontSize`, `Show`, `Update` |
| `Tricp` | `<type>` |
| `Utils` | `Base`, `Cdate_Dbase`, `Fcolr`, `Fill_Civilite`, `ObsGotf`, `ObsLstf`, `Observers`, `Option`, `Remplace`, `SetEditColor`, `chkEmail`, `cpoint`, `db`, `rs1` |
| `Variables` | `SMajCli`, `Sexport`, `Sprix`, `sTexte` |
| `Visualiseur` | `Prog` |
| `gridvi` | `<type>`, `code`, `dec`, `razcol` |
| `hexdblKey` | `Crypt` |
| `rechtipp` | `<type>` |
| `rechtour` | `<type>` |

### Tables SQL référencées

`Corsage`, `Docs_Ged`, `Fiches_AdrlivC`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_Cli_Vtl`, `Fiches_Commerciaux`, `Fiches_Comptes`, `Fiches_ContactC`, `Fiches_Cpostaux`, `Fiches_Echeances`, `Fiches_Etiquettes`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Materiels`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Reglements`, `Fiches_Societes`, `Fiches_Statut`, `Fiches_Tag`, `Fiches_Typec`, `Fiches_region`, `Fiches_tourne`, `Mails_Cli`

### Membres Public sans usage externe détecté (portée réductible ?)

`nom_pays`, `Tris`, `Deb2`, `Colcli_contact`, `Deb3`, `Maj_Zones`, `Aff_Mat`, `ChiffreA`, `Maj_vtl`, `CleanVtl`, `Refresh`, `CleanChamps`, `Maj_Email`, `RdimColcli`, `Aff_Statut`, `Remmo_LF`, `Remart_LF`, `Button4_Click`, `Button3_Click`, `Button2_Click`, `GenRum`, `Ventilations`, `Button6_Click`, `Recup_Typec`, `echman`, `Dbclk`, `Titre`, `V1_Clk`, `Ref`, `collman`, `Ventilman`, `Button1_Click`, `Envoi`, `Button12_Click`, `init_ComboBox`, `Button13_Click`, `Imprime`, `ImprimeC`, `fin_impression`, `pos_Etiq`, `pos_EtiqC`, `Cpman`, `aff_cp`, `ChkCp`, `Cpman2`, `Cpman3`, `Aff_AdrC`, `CleanChampsAdr`, `Aff_Ct`, `CleanChampsCt`, `Maj_Dssr`, `Button7_Click`, `Update_ListTags`
<!-- /AUTO:dependances -->

## Notes d'analyse

### Appelants (vérifiés par `grep`)

| Appelant | Ligne | Usage |
|---|---|---|
| `Fmenu.Menu12_Click` | `Fmenu.class:565` | `FClient.ShowModal()` (auto-instance) |
| `Saisecrit` | `Saisecrit.class:1206` | création d'un compte client manquant (option « client ») |
| `Tresor` | `Tresor.class:928` | idem |
| `Facture` | `Facture.class:884` | F4 sur la zone client |
| `Facture` | `Facture.class:4061` | complétion d'une fiche pour un client abonnement |
| `Tricp.colco_Click` | `Tricp.class:132-134` | écrit `FClient.Bsel`, `Codepostal`, `Bureaudistributeur` sur l'**auto-instance** (sans risque : FClient n'est jamais instancié par `New`) |
| `TriCpt.ColTri_MajSel` | `TriCpt.class:112-113` | `Object.SetProperty(Me, "Bsel"/"Bval")` (appel dynamique non vu par `deps.py`) |
| `TriGen` | `TriGen.class:138-139, 228-232` | idem, pour `RechTag_Click` (`TriGen(…, Me)`) |

Aucune fonction de FClient n'est appelée par un autre fichier : la liste « portée réductible » est
exacte pour les fonctions, **fausse pour `Bsel`/`Bval`** (écrits dynamiquement) et pour
`Codepostal`/`Bureaudistributeur` (écrits par `Tricp`, que `deps.py` voit bien en `used_by`).

### Ce que l'heuristique rate ou surestime

- **`ListTags_Add`** : signalé `unused` et « portée réductible », c'est le handler de l'événement
  `Add` du contrôle `ListEditor` (gb.form, vérifié dans `gb.form.info`). Il doit rester `Public`.
- **`Remmo_LF`/`Remart_LF`** (`handlers_inactifs`) : ce ne sont pas des handlers (`_LF` n'est pas un
  événement Gambas) mais des fonctions mortes ; `Remmo`/`Remart` sont dans le groupe `Cmpt2`.
- **`C1_Click`, `N1_Click`, `A1_Click`, `Cp1_Click`** : étiquetés « handler GUI », mais `C1`…`CP1`
  sont des `TextBox` (pas d'événement `Click`) : pseudo-handlers appelés par les `*_GotFocus`.
- **`Cmpt3_Click`** : étiqueté « handler GUI » ; le groupe `Cmpt3` ne contient que la `TextBox`
  `Compt` → jamais levé, code mort.
- **`ButtonN_Click` des boutons du groupe `Btn`** (`Button1`, `2`, `3`, `4`, `7`, `12`, `13`) et
  `Button6_Click` (groupe `Vnt`) : non levés par Gambas, appelés par `Btn_Click`/`Vnt_*`. `deps.py`
  les classe en « portée réductible » ; on garde leur nom et leur portée (règle des handlers).
- **Groupe d'événements `form`** : `Button20_Click` crée `New Form As "Form"` ; les événements de
  cette fenêtre sont routés vers `FClient.Form_*` (FCLIENT-A11).
- **Événements de classes du projet** : `Buttr1_trouve`/`Buttr2_trouve` (`Rechtipp`),
  `butto1_trouve`/`butto2_trouve` (`Rechtour`), `PanelGedDoc_MajSel` (`TriGen`) : correctement vus.
- **Tables hors `Cbase`** non vues par `deps.py` dans `tables` : table temporaire `Contact`
  (`Colcli_contact`). `Fiches_region` est une table d'option créée par `modfichier.module`, absente de
  `db_control.csv`.
- **Clé `TabCdocs`** comptée comme dépendance `Cbase.Table` alors qu'elle n'existe pas (CBASE-A01).
- **Ressources hors base** : `Pays.txt` (répertoire courant), `~/Contacts.vcf`, `~/tmp/EtiqCli.pdf`,
  `xdg-open` (Google Maps, Infogreffe), client mail (`EnvMail.Envoi2`), SMS (`Gsm`).

### Appels dynamiques et rejeu

- `replay_dynamic` (doivent rester `Public`, REPLAYOBSERVER-A06) : `colcli_Click`, `Colcompt2_Click`,
  `Coltype_Click`, `Colech_Click`, `Colcp_Click`, `Colal_Click`, `Colal2_Click`.
- `Vents` et `Colmat` (ColumnView) n'ont pas de `_Click` : un clic enregistré sur ces listes ferait
  échouer `Object.Call` au rejeu.

### Dépendances circulaires

- `FClient` → `Tricp` → `FClient` (auto-instance) ; `FClient` → `TriCpt`/`TriGen` → `FClient`
  (`Object.SetProperty`). Pas de cycle de compilation, mais le contrat `Bsel`/`Bval`/`Codepostal`/
  `Bureaudistributeur` lie ces fichiers.

### Contraintes d'ordre de rework

- **FCLIENT-011 à 014 dans le même commit que FFOURNISSEUR-010 à 013** (socle `FicheTiers`).
- FCLIENT-015 après SERVEUR-008 (`Serveur.Actif`).
- FCLIENT-A04 dépend de la décision CBASE-A01 (mapper `TabCdocs` ou supprimer l'appel).
- FCLIENT-A01 à traiter avec la commonalisation des règles de collectif (`FComptes`, `FCollectif`,
  `FFournisseur`) ; FCLIENT-A10 avec `Tricp`/`TriCpt` (lot Affichages).
- FCLIENT-014 (`PlancheEtiquettes`) à reprendre ensuite par `.src/Gestion/Etiquettes/`.
