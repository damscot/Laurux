# Mreglement — Architecture

> Source : `.src/Gestion/Tables/Mreglement.class`

## Vue d'ensemble

Écran de la **table des modes de règlement** (`Fiches_Reglements` : `code` char(2) clé primaire,
`libel`, `journal` (journal de trésorerie), `cptint` (compte interne 58x), `bordereaux`, `lcr`
(0 sans, 1 LCR non acceptée, 2 LCR acceptée), `caisse` (mode de règlement de caisse lié),
`decaissement`, `regroup`). Ouvert par `Fmenu.class:2573` (`Mreglement.Show`). Les modes de
règlement sont lus par `FClient`, `ObjFac`, `SaiReg`, `EcrReg`, `EcrAuto`, `Echeancier` et
`Moulinage`.

Le fichier joue **deux rôles** :
1. **écran de saisie** construit sur la barre d'actions `Barselection` (`"001110010"` : création,
   modification, suppression, sortie ; la recherche n'est **pas** affichée), avec transaction
   ouverte entre l'action et sa validation (`Utils.db.Begin`/`Commit`/`Rollback`) et écriture par
   `Result` éditable (`Utils.db.Create9`, `Utils.db.Edit`, `Utils.db.Delete`) ;
2. **référentiel des modes de règlement de caisse** : énumérations `Public` (`sans_lcr`,
   `lcr_nacc`, `lcr_acc` ; `sans_caisse` … `ticket_resto`), tableaux `RegCais` (libellés) et
   `CodeCais` (codes des lignes de ticket : `N`, `Q`, `U`…), fonctions de conversion
   `RegMode2CodeCaisse`, `CodeCaisse2RegMode` et `Laision_Reg`. `RegCais`, `CodeCais` et les
   fonctions sont des membres **d'instance** : `Moulinage` y accède par `Mreglement.RegCais…`,
   ce qui crée l'**auto-instance cachée du formulaire** (exécution de `_new` : observateurs, barre,
   `SELECT`).

Même famille que les écrans à `Barselection` du lot option (`Tregie`, `Ttourne`, `Tconsigne`,
`Tregion`, `Tchauffeur`).

Nature : **mixte** (référentiel de calcul + GUI avec SQL).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `sans_lcr` | enum | Public | oui |  | 3 |
| `lcr_nacc` | enum | Public | oui |  | 3 |
| `lcr_acc` | enum | Public | oui |  | 3 |
| `sans_caisse` | enum | Public | oui |  | 4 |
| `espece` | enum | Public | oui |  | 4 |
| `rendu` | enum | Public | oui |  | 4 |
| `carte` | enum | Public | oui |  | 4 |
| `cheque` | enum | Public | oui |  | 4 |
| `bon_achat` | enum | Public | oui |  | 4 |
| `cheque_cadeaux` | enum | Public | oui |  | 4 |
| `autre` | enum | Public | oui |  | 4 |
| `bonus` | enum | Public | oui |  | 4 |
| `ticket_resto` | enum | Public | oui |  | 4 |
| `RegCais` | var | Public |  | String[] | 5 |
| `CodeCais` | var | Public |  | String[] | 6 |
| `$ressel` | var | Private |  | Result | 8 |
| `$res` | var | Private |  | Result | 9 |
| `$bars` | var | Private |  | Barselection | 10 |
| `Bsel` | var | Public |  | Boolean | 12 |
| `Bval` | var | Public |  | String | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-49 | Public | 3 | 31 | 0 | méthode spéciale |
| `affiche` | 51-82 | Private | 9 | 27 | 0 |  |
| `interne_Click` | 85-96 | Public | 2 | 10 | 0 | handler GUI |
| `rdb_click` | 98-102 | Public | 1 | 3 | 0 | handler GUI |
| `bar1_creer` | 105-113 | Public | 1 | 7 | 0 | handler GUI |
| `bar1_modif` | 115-124 | Public | 2 | 8 | 0 | handler GUI |
| `bar1_annule` | 126-132 | Public | 1 | 5 | 0 | handler GUI |
| `bar1_valide` | 134-191 | Public | 11 | 51 | 0 | handler GUI |
| `bar1_suprimer` | 193-199 | Public | 1 | 5 | 0 | handler GUI |
| `bar1_quitter` | 201-205 | Public | 1 | 3 | 0 | handler GUI |
| `jour_LostFocus` | 207-223 | Public | 3 | 14 | 0 | handler GUI |
| `cptint_LostFocus` | 225-241 | Public | 3 | 14 | 0 | handler GUI |
| `CodeCaisse2RegMode` | 243-254 | Public | 2 | 9 | 0 | portée réductible ? |
| `RegMode2CodeCaisse` | 256-264 | Public | 3 | 7 | 1 |  |
| `Laision_Reg` | 266-277 | Public | 2 | 9 | 1 |  |
| `Combocais_Click` | 279-290 | Public | 4 | 9 | 0 | handler GUI |
| `Butint_Click` | 292-305 | Public | 2 | 11 | 0 | handler GUI |
| `bar1_recherche` | 307-329 | Public | 6 | 21 | 0 | handler GUI |
| `butjour_Click` | 331-353 | Public | 6 | 20 | 0 | handler GUI |
| `recherche_Click` | 355-372 | Public | 4 | 16 | 0 | handler GUI |
| `recherche_KeyPress` | 374-382 | Public | 2 | 7 | 0 | handler GUI |
| `GridView1_Data` | 384-396 | Public | 4 | 11 | 0 | handler GUI |
| `GridView1_Click` | 398-403 | Public | 1 | 4 | 0 | handler GUI |
| `borderau_Click` | 406-414 | Public | 3 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Référentiel (appelé hors du fichier)

- **Énumérations** `sans_lcr`, `lcr_nacc`, `lcr_acc` (utilisées par `EcrAuto.class:556-557`,
  `LauruxMaj.module:5266`, `:5273`) et `sans_caisse` … `ticket_resto` (`SaiReg.class:974`, `:992`) :
  [portée : nécessaire].
- **`RegCais`**, **`CodeCais`** (variables `Public` d'instance) [portée : nécessaire] : lues par
  `Moulinage.class:2495`, `:2528-2533`, `:2608`.
- **`RegMode2CodeCaisse(mode)`** [portée : nécessaire] [nature : calcul] : `Null` pour 0 ou hors
  bornes, sinon `CodeCais[mode]` (`Moulinage.class:2498`).
- **`CodeCaisse2RegMode(Code)`** [portée : réductible] [nature : calcul] : inverse (0 si absent) ;
  **jamais appelée** (`unused`, code mort).
- **`Laision_Reg(mode)`** [portée : nécessaire] [nature : calcul] :
  `SELECT * FROM Fiches_Reglements WHERE caisse = &1` ; renvoie le code caisse si un mode de
  règlement est lié à ce mode de caisse, sinon `Null` (`Moulinage.class:2500`, `Combocais_Click`).

### Construction et affichage

- **`_new()`** [portée : nécessaire] [nature : mixte] : `Chainage` des zones `code`/`libel`/`jour`,
  `Utils.Observers`, barre `Barselection` (événements `bar1_*`), colonnes, longueurs maximales,
  masque `cptint.reg`, `SELECT * FROM Fiches_Reglements` mémorisé dans `$ressel`, combo des modes
  de caisse, `decaissement.Enabled` et `Frame1.Visible` selon `/Soc<XX>/Decais` et `/Soc<XX>/Lcr`.
- **`affiche()`** [Private] [nature : mixte] : recopie la ligne courante de `$ressel` dans les
  contrôles (`RegCais[$ressel!caisse]` : erreur si la valeur est hors bornes) et relit les
  libellés du journal (`Fiches_Journaux`) et du compte (`Fiches_Comptes`).
- **`GridView1_Data(Row, Column)`** [handler] : affichage paresseux depuis `$ressel`.
- **`GridView1_Click()`** [handler] : positionne `$ressel` et `affiche`. Rejoué par
  `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.

### Barre d'actions (événements de `Barselection`)

- **`bar1_creer()`** [handler] : active les zones, `Utils.db.Begin`, `$res = Utils.db.Create9(…)`.
- **`bar1_modif()`** [handler] : si aucune ligne n'est sélectionnée, **sort sans rien faire**
  alors que la barre est déjà en mode validation (anomalie A02) ; sinon `Begin` et
  `$res = Utils.db.Edit("Fiches_Reglements", "code=&1", …)`.
- **`bar1_annule()`** [handler] : `Rollback`, zones désactivées (les valeurs saisies restent affichées).
- **`bar1_valide()`** [handler] (CC 11, max du fichier) : en suppression, `Commit` et rechargement ;
  sinon contrôles (code obligatoire, compte interne commençant par `58` si « interne », journal
  obligatoire ; `Rollback` en cas d'échec), affectation des champs de `$res`, `$res.Update`,
  `Commit`, rechargement de `$ressel` et repositionnement.
- **`bar1_suprimer()`** [handler] : `Begin`, `Utils.db.Delete("Fiches_Reglements", "code=&1", …)`
  (méthode héritée de `Connection`, non journalisée par `DB_Connection`) ; aucun contrôle d'usage
  (`Fiches_Cli.cli_reg`, factures, échéances).
- **`bar1_quitter()`** [handler] : ferme la fenêtre.
- **`bar1_recherche()`** [handler] : liste de recherche des codes ; **jamais levé** car le bouton
  de recherche n'est pas affiché (9e caractère de `"001110010"` à `0`) : code mort en pratique.

### Saisie

- **`interne_Click()`** [handler] : active/désactive le panneau du compte interne.
- **`rdb_click()`** [handler du groupe `rdb` : `lcr`, `lcra`] : désactive le panneau du compte
  interne (effet de bord surprenant, à documenter).
- **`borderau_Click()`** [handler] : focus sur le compte interne.
- **`jour_LostFocus()`** [handler] : vérifie que le journal existe **et** est de type `TR` ;
  `Message.Error` sinon.
- **`cptint_LostFocus()`** [handler] : vérifie l'existence du compte.
- **`Combocais_Click()`** [handler] : refuse un mode de caisse déjà lié à un autre règlement
  (`Laision_Reg`) en remettant « Sans ».
- **`Butint_Click()`** [handler] : `TriCpt` (comptes de bilan) ; le résultat revient par
  `Bsel`/`Bval`, positionnés par `Object.SetProperty` depuis `TriCpt` (variables `Public` requises).
- **`butjour_Click()`** [handler] : liste des journaux `TR` dans `recherche` ; `MoveFirst`/`Repeat`
  sans test `Available` (erreur s'il n'y a aucun journal de trésorerie).
- **`recherche_Click()`** [handler] : tag 1 (inatteignable, voir `bar1_recherche`) ou tag 2 :
  recopie du journal. Rejoué par `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`recherche_KeyPress()`** [handler] : Échap ferme la liste.

## État global utilisé

- `Utils.db` (`Exec`, `Begin`, `Commit`, `Rollback`, `Create9`, `Edit`, `Delete`), `Utils.Observers` ;
  `Start.LocalSettings["/Soc<XX>/Decais"]`, `["/Soc<XX>/Lcr"]`, `Start.Societe`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **Référentiel statique** : `RegCais`, `CodeCais` en `Static Public`, `RegMode2CodeCaisse`,
  `Laision_Reg` en `Static Public` (syntaxe d'appel inchangée dans `Moulinage`) : l'auto-instance
  cachée du formulaire n'est plus créée par le moulinage (un `SELECT` en moins, dump identique).
  À terme, déplacer ce référentiel dans un module dédié (hors périmètre de ce plan).
- `Cbase.Table("TabJour")`, `Cbase.Table("TabComptes")` pour les tables qui ont une clé.

### Commonalisation avec d'autres fichiers

- Écrans à `Barselection` : `Tregie`, `Ttourne`, `Tconsigne`, `Tregion`, `Tchauffeur` (lot
  option) : même cycle `Begin` → `Create9`/`Edit` → `Commit`/`Rollback`, à factoriser dans
  `Barselection` ou un helper commun.
- Contrôle « journal de trésorerie existant » et « compte existant » : présents aussi dans
  `FComptes`, `FJournaux`, `Saisecrit`.

### Réduction de portée

- `CodeCaisse2RegMode` : jamais appelée → suppression (code mort) ou `Private`.
- `Bsel`/`Bval` : restent `Public` (écrits par `TriCpt` via `Object.SetProperty`).

### Séparation traitement / GUI

- `ValideReglement(...) As String` (contrôles de `bar1_valide` renvoyant le message d'erreur),
  appelé par le handler qui garde `Message.Error`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique sur `Fiches_Reglements.caisse` (hors 0) pour garantir la liaison 1-1 vérifiée à la
  main par `Combocais_Click`.
- `cptint` char(8) alors que le masque accepte 9 chiffres.
