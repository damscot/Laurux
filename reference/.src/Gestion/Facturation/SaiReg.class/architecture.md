# SaiReg — Architecture

> Source : `.src/Gestion/Facturation/SaiReg.class`

## Vue d'ensemble

`SaiReg` est l'écran de **saisie des règlements clients/fournisseurs** (menu Gestion ›
Facturation › Saisie des règlements : `Fmenu.brdreg`, bouton `rglmt`, libellé `lbsr`). L'opérateur
choisit un mode de règlement (`nreg`, table `Fiches_Reglements`), qui détermine le journal et le
compte interne, puis un compte tiers (`client`) ; l'écran affiche dans `selection` les écritures
du tiers (lettrées ou non, sur ± 8 ans) et/ou ses BL non facturés, permet de cocher les pièces
réglées (lettrage), de saisir le montant, et accumule les règlements dans un **bordereau**
(`borderaux`, objet `$Lecr` de type `VarEcr`). La validation passe les écritures par `EcrReg`
(sous-classe d'`EcrAuto`) et imprime un récapitulatif ; l'édition du bordereau passe par `EdReg`.

Deux modes de validation (`Labvalide.Tag`) :
- **Saisie** (`Valide_saisie`) : chaque règlement ajouté/modifié/supprimé est écrit par
  `EcrReg` ;
- **Bordereau** (`Valide_bordereau`) : pour un règlement « bordereau » sur compte interne, les
  écritures non lettrées du compte interne sont relues à l'ouverture et validées ensemble, à une
  date demandée dans une petite fenêtre construite dynamiquement.

Mode **caisse** : `ObjFacB.editef` ([ObjFacB.class:740](../../../../../.src/Gestion/option/ObjFacB.class#L740)) incruste l'écran dans une fenêtre
(`New SaiReg($win, VarEcr.caisse, Me.numcli)`) pour saisir le règlement d'une facture qu'on vient
d'éditer ; le client est alors imposé.

Le bouton `SwitchSelec` (mode « Facture ») permet, à partir de BL cochés, de produire une facture
de fin de mois (`Facture()` → tables de travail `Facturefm`/`Bl` → `OptFac` en mode fin de mois).

Nature globale : **mixte**, fortement couplée à `VarEcr`, `Listextcpt`, `EcrReg`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `RegCaisse` | event | Public |  |  | 3 |
| `dtes` | enum | Private | oui |  | 5 |
| `numdocs` | enum | Private | oui |  | 5 |
| `numlots` | enum | Private | oui |  | 5 |
| `libels` | enum | Private | oui |  | 5 |
| `montds` | enum | Private | oui |  | 5 |
| `montcs` | enum | Private | oui |  | 5 |
| `journals` | enum | Private | oui |  | 5 |
| `oks` | enum | Private | oui |  | 5 |
| `sel` | var | Private |  | String[] | 6 |
| `dteb` | enum | Private | oui |  | 8 |
| `numdocb` | enum | Private | oui |  | 8 |
| `numlotb` | enum | Private | oui |  | 8 |
| `libelb` | enum | Private | oui |  | 8 |
| `montcb` | enum | Private | oui |  | 8 |
| `etatb` | enum | Private | oui |  | 8 |
| `brd` | var | Private |  | String[] | 9 |
| `Valide_bordereau` | enum | Private | oui |  | 11 |
| `Valide_saisie` | enum | Private | oui |  | 11 |
| `$Vecr` | var | Private |  | VarEcr | 13 |
| `$Lecr` | var | Private |  | New VarEcr | 14 |
| `$selec` | var | Private |  | String[] | 15 |
| `$resreg` | var | Private |  | Result | 16 |
| `$resjou` | var | Private |  | Result | 17 |
| `$rescli` | var | Private |  | Result | 18 |
| `$resext` | var | Private |  | Result | 19 |
| `$resbl` | var | Private |  | Result | 20 |
| `$liste` | var | Private |  | Listextcpt | 21 |
| `$letr` | var | Private |  | String | 22 |
| `$modif` | var | Private |  | Boolean | 23 |
| `$ind` | var | Private |  | Integer | 24 |
| `$typ` | var | Private |  | Integer | 25 |
| `$ntk` | var | Private |  | String | 26 |
| `Bsel` | var | Public |  | Boolean | 28 |
| `Bval` | var | Public |  | String | 29 |
<!-- /AUTO:declarations -->

- `Event RegCaisse(mnt As Float, typ As Integer, ntk As String)` : déclaré avec **3** paramètres,
  levé avec **4** (SAIREG-A01) ; aucun gestionnaire n'existe aujourd'hui (`ObjFacB` crée l'écran
  `As "win"` mais n'a pas de `win_RegCaisse`).
- Énumérations privées des colonnes de `selection` (`dtes`…`oks`) et de `borderaux`
  (`dteb`…`etatb`), avec leurs libellés `sel[]` et `brd[]`.
- `Bsel`/`Bval` : `Public`, positionnées par `TriCpt` (`Object.SetProperty`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 31-122 | Public | 13 | 85 | 0 | méthode spéciale |
| `Form_Close` | 124-132 | Public | 3 | 6 | 1 | handler GUI |
| `nreg_KeyPress` | 134-142 | Public | 7 | 7 | 0 | handler GUI |
| `nreg_LostFocus` | 145-240 | Public | 23 | 85 | 0 | handler GUI |
| `dtereg_LostFocus` | 242-253 | Public | 2 | 9 | 0 | handler GUI |
| `affectv` | 255-285 | Private | 6 | 28 | 0 |  |
| `client_LostFocus` | 287-298 | Public | 4 | 9 | 0 | handler GUI |
| `Client_KeyPress` | 300-304 | Public | 2 | 3 | 0 | handler GUI |
| `affclient` | 306-320 | Private | 3 | 13 | 0 |  |
| `sel_LostFocus` | 322-327 | Public | 1 | 4 | 0 | handler GUI |
| `tltr_Click` | 330-335 | Public | 1 | 4 | 0 | handler GUI |
| `check_reg` | 338-349 | Public | 3 | 10 | 0 | portée réductible ? |
| `sel_gotfocus` | 352-356 | Public | 1 | 3 | 0 | handler GUI |
| `ltrs_Click` | 358-363 | Public | 1 | 4 | 0 | handler GUI |
| `nltrs_Click` | 365-370 | Public | 1 | 4 | 0 | handler GUI |
| `rdoc_click` | 372-377 | Public | 1 | 4 | 0 | handler GUI |
| `SwitchSelec_Click` | 379-390 | Public | 3 | 10 | 0 | handler GUI |
| `affsel` | 393-453 | Private | 24 | 57 | 0 |  |
| `affselligne` | 455-481 | Private | 2 | 24 | 0 |  |
| `rechsel` | 483-494 | Private | 3 | 9 | 0 |  |
| `selection_choose` | 496-532 | Public | 5 | 34 | 0 | portée réductible ? |
| `selection_KeyPress` | 534-557 | Public | 5 | 19 | 0 | handler GUI |
| `selection_Click` | 559-571 | Public | 3 | 9 | 0 | handler GUI |
| `selection_Activate` | 573-593 | Public | 7 | 18 | 0 | handler GUI |
| `testtbl` | 595-602 | Private | 7 | 6 | 0 |  |
| `affborderau` | 605-652 | Private | 6 | 37 | 0 |  |
| `borderaux_Activate` | 654-662 | Public | 1 | 7 | 0 | handler GUI |
| `butvalide_Click` | 665-714 | Public | 10 | 45 | 0 | handler GUI |
| `butvalide_KeyPress` | 716-720 | Public | 3 | 3 | 0 | handler GUI |
| `butan_Click` | 722-729 | Public | 1 | 6 | 0 | handler GUI |
| `butsup_Click` | 731-746 | Public | 2 | 14 | 0 | handler GUI |
| `modsb` | 748-759 | Private | 2 | 10 | 0 |  |
| `butsortie_Click` | 761-765 | Public | 1 | 3 | 0 | handler GUI |
| `butsortie_KeyPress` | 767-771 | Public | 3 | 3 | 0 | handler GUI |
| `rechcli_Click` | 773-787 | Public | 2 | 12 | 0 | handler GUI |
| `rechreg_Click` | 789-806 | Public | 4 | 15 | 0 | handler GUI |
| `valide_Click` | 808-818 | Public | 3 | 8 | 0 | handler GUI |
| `edite_Click` | 820-831 | Public | 3 | 8 | 0 | handler GUI |
| `Listreg_Click` | 833-842 | Public | 2 | 8 | 0 | handler GUI |
| `mabl` | 845-870 | Private | 2 | 23 | 0 |  |
| `mabreg` | 872-882 | Private | 1 | 9 | 0 |  |
| `affdonnes` | 884-895 | Private | 2 | 10 | 0 |  |
| `Facture` | 897-946 | Private | 4 | 46 | 0 |  |
| `vldsaisie_Click` | 949-998 | Public | 8 | 45 | 0 | portée réductible ? |
| `vldbordereau_Click` | 1000-1078 | Public | 6 | 74 | 0 | portée réductible ? |
| `btval_click` | 1080-1084 | Public | 1 | 3 | 0 | handler GUI |
| `btaba_click` | 1086-1090 | Public | 1 | 3 | 0 | handler GUI |
| `impecr` | 1092-1105 | Private | 2 | 11 | 0 |  |
| `editions_Click` | 1109-1120 | Public | 2 | 9 | 0 | portée réductible ? |
| `editionb_Click` | 1122-1133 | Public | 2 | 9 | 0 | portée réductible ? |
| `quite_Click` | 1135-1139 | Public | 1 | 3 | 0 | portée réductible ? |
| `somme_Click` | 1142-1146 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et fermeture

- **`_new(Optional tpe, ncl, ndc, nlt)`** [portée : nécessaire (constructeur)] [nature : GUI].
  Observateurs de rejeu, `Chainage` de navigation, observateurs `sel` sur `client`, `ndoc`,
  `nlot` ; paramétrage des `TextReg` (recherche de compte sur `Fiches_Cli`, formats numériques et
  date) ; largeur des colonnes proportionnelle (`coef`), réduction de police si l'écran est trop
  étroit. En mode caisse (`tpe = VarEcr.caisse`) : client imposé et non modifiable, `$ntk = ndc`,
  affichage immédiat. `nlt`, `str`, `res` sont inutilisés. L'appel depuis `ObjFacB` passe la
  fenêtre parente en premier (consommée par `Form`, arguments suivant les obligatoires — il n'y
  en a aucun ici).
- **`Form_Close()`** [portée : nécessaire (handler ; appelé aussi par `ObjFacB.win_close`)]
  [GUI]. Si une saisie est en cours (`$modif`), propose de la valider (`valide_Click`).

### Règlement, client, sélection

- **`nreg_KeyPress()`** [handler] : Tab/Entrée → champ suivant ; F2 → `rechreg_Click`.
- **`nreg_LostFocus()`** [handler] [mixte] (CC 23). Propose de valider une saisie en cours, puis
  lit le règlement (`Fiches_Reglements`) et son journal (`Fiches_Journaux`), choisit le mode
  Bordereau/Saisie (bordereau si `bordereaux`, ou sans compte interne ni bordereau). Hors caisse,
  pour un règlement « bordereau » : relit les écritures non lettrées et non clôturées du compte
  interne (`Fiches_Mvt WHERE compte = cptint AND lettree <> True AND cloturee = False`), et pour
  chacune l'écriture du tiers de même numéro (`Fiches_Mvt ⨝ Fiches_Comptes`, type C/F, non
  collectif), les écritures du tiers de même lot (`Listextcpt.rechechelot`) comme pièces
  lettrées, et les autres lignes de l'écriture (lues **sans test `Available`**) ; alimente
  `$Lecr` puis `affborderau`. Tables en dur.
- **`dtereg_LostFocus()`** [handler] [mixte]. Refuse une date en période comptable close
  (`VerifDate.ClotComptable`) ; libellé par défaut « <règlement> du <date> ».
- **`affectv(rescli, ind, tot)`** [Private] [calcul]. Construit un `VarEcr` (trésorerie,
  `L_valide`) à partir d'une ligne d'écriture.
- **`client_LostFocus()`**, **`Client_KeyPress()`** (F2), **`rechcli_Click()`** (recherche
  `TriCpt` clients/fournisseurs) [handlers] [GUI].
- **`affclient()`** [Private] [mixte]. Lit le compte tiers (`Fiches_Comptes`, type C/F) : intitulé
  et solde, ou bulle d'avertissement.
- **`sel_LostFocus()`**, **`sel_gotfocus()`** [handlers du groupe d'observateurs `sel`] ;
  **`tltr_Click`**, **`ltrs_Click`**, **`nltrs_Click`** (filtre tous / lettrés / non lettrés),
  **`rdoc_click`** (groupe `rdoc` : écritures, factures, BL) [handlers] : relancent `affsel`.
- **`check_reg()`** [portée : réductible] [GUI]. Exige un règlement choisi (message sinon).
- **`SwitchSelec_Click()`** [handler] [GUI]. Mode « Facture » autorisé seulement si l'option BL
  est choisie.
- **`affsel()`** [Private] [mixte] (CC 24). Remplit `selection` : BL non facturés du client
  (`Fiches_Bl` type B) si « Tous » ou « BL », puis écritures du compte (`Listextcpt` sur
  ± 8 ans, filtrées par document ou lot) en sautant l'écriture en cours de modification ;
  calcule le total affiché.
- **`affselligne(…)`**, **`rechsel(i)`**, **`testtbl(i, j)`** [Private] : affichage d'une ligne,
  icône « sélectionnée » si la pièce figure dans `$Vecr.Tlettrage` (comparaison sur date, lot,
  compte, montants relus par `Val()` sur le texte formaté, et document).
- **`selection_choose(sel)`** [portée : réductible] [mixte]. Coche/décoche une pièce : ajoute ou
  retire un élément de `$Vecr.Tlettrage`, préremplit document, lot et libellé, recalcule le total
  sélectionné.
- **`selection_KeyPress()`** (Espace = cocher, Tab), **`selection_Click()`** (après
  `check_reg`) [handlers ; `selection_Click` en rejeu dynamique], **`selection_Activate()`**
  [handler] : ouvre le document (BL, facture ou archive) dans `OptFac`.

### Bordereau

- **`affborderau()`** [Private] [GUI]. Affiche `$Lecr` avec l'état (Val/Ajo/Mod/Sup, couleurs) et
  les totaux saisis / du bordereau.
- **`borderaux_Activate()`** [handler]. Charge la ligne choisie pour modification (`affdonnes`).
- **`butvalide_Click()`** [handler] [mixte]. En mode « Facture » : `Facture()`. Sinon refuse un
  décaissement non autorisé (`decaissement` du règlement et `/Soc<XX>/Decais`), puis ajoute ou
  modifie le règlement dans `$Lecr` (`modsb` passe en mode Saisie). `butvalide_KeyPress` le
  rappelle.
- **`butan_Click()`**, **`butsup_Click()`** [handlers]. Abandon ; suppression (retrait si ajouté,
  sinon état `L_sup`).
- **`modsb()`**, **`mabl()`**, **`mabreg()`**, **`affdonnes()`** [Private] : bascule de mode,
  remises à blanc, chargement d'une ligne.
- **`butsortie_Click()`**, **`butsortie_KeyPress()`** [handlers] : fermeture.
- **`rechreg_Click()`** [handler]. Affiche/masque la `ListView` `Listreg` des règlements.
- **`Listreg_Click()`** [handler]. Recopie `Listreg.Item.Text` (« code libellé ») dans `nreg`
  (limité à 2 caractères par `MaxLength`, à confirmer) puis `nreg_LostFocus`. `Listreg` étant une
  `ListView`, ce clic **n'est pas rejoué** par `ReplayObserver` (REPLAYOBSERVER-A06).
- **`valide_Click()`**, **`edite_Click()`** [handlers]. Aiguillent vers `vldsaisie_Click` /
  `vldbordereau_Click` et `editions_Click` / `editionb_Click` selon le mode.

### Validation et éditions

- **`vldsaisie_Click()`** [portée : réductible (aucun contrôle de ce nom)] [mixte]. Pour chaque
  règlement non déjà validé : `New EcrReg(nreg, journal, var).ecriture()` ; en cas d'échec,
  message et poursuite ; pour un ajout, `Raise RegCaisse(montant, $resreg!caisse, $ntk,
  numdoc)` (4 arguments, la variable `choix` calculée juste avant est ignorée) ; cumule
  l'impression (`EcrReg.Impression`) puis l'affiche (`Visualiseur.Prog`). Lève enfin
  `RegCaisse(total, sans_caisse, …)` et remet l'écran à blanc.
- **`vldbordereau_Click()`** [portée : réductible] [mixte]. Fenêtre de saisie de la date de
  règlement construite dynamiquement (`Window` + `TextReg` + boutons `btval`/`btaba`) ; si
  validée : état `L_valide`, type trésorerie, date appliquée à toutes les lignes,
  `New EcrReg(code, journal, $Lecr).ecriture()`, impression, remise à blanc (même en cas
  d'erreur d'écriture).
- **`btval_click()`**, **`btaba_click()`** [handlers des boutons dynamiques] : ferment la fenêtre
  avec 0 / 1.
- **`impecr(ereg)`** [Private] — **jamais appelée** (code mort, doublon des blocs d'impression).
- **`editions_Click()`**, **`editionb_Click()`** [portée : réductible] [GUI]. Édition `EdReg`
  (règlements ajoutés / tous) dans `~/tmp/Bordereau.pdf`, puis visualisation.
- **`quite_Click()`** [portée : réductible] — **aucun contrôle `quite`** dans le `.form` : code
  mort.
- **`somme_Click()`** [handler] : calculatrice `Fmontant`.
- **`Facture()`** [Private] [mixte]. Recrée les tables de travail `Facturefm` et `Bl` (structure
  de `Facturefm`), ouvre une transaction (`Utils.db.Begin`) **jamais validée**, insère le client
  et les BL cochés (`Create9`), appelle `res.Update` une seconde fois sur le dernier BL, puis
  `New OptFac(ObjFac.finmois, client, $Vecr.numlot)` : `numlot` devient le **suffixe de table**
  d'`ObjFac` en fin de mois (SAIREG-A02).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Decais"]`.
- `Utils.db` (`Exec`, `Begin`, `Create9`), `Utils.arrondi`, `Utils.cpoint`, `Utils.Observers`.
- `VarEcr`, `Listextcpt`, `EcrReg`, `EdReg`, `VerifDate`, `TriCpt`, `ProgBar`, `Visualiseur`,
  `Fmontant`, `OptFac`, `ObjFac` (constantes), `Mreglement` (constantes), `TextReg`, `chainage`.
- Tables (en dur) : `Fiches_Reglements`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Comptes`,
  `Fiches_Bl`, `Fiches_BlM`, `Fiches_HistoFac[M]`, `Fiches_Cli` ; tables de travail
  `Facturefm`, `Bl`. Les écritures comptables passent par `EcrReg`/`EcrAuto`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `impecr`, `quite_Click`, les variables locales inutilisées (`str`, `res`, `obj`,
  `choix` de `vldsaisie_Click` si A01 n'est pas validée…).
- Factoriser l'impression récapitulative (trois copies : `vldsaisie_Click`,
  `vldbordereau_Click`, `impecr`) en `ImprimeEcritures(ereg, imp)` privée.
- `nreg_LostFocus` (CC 23) : extraire `ChargeBordereau()` (lecture des écritures du compte
  interne) ; `affsel` (CC 24) : extraire `AjouteBl()` et `AjouteEcritures()`.
- `vldbordereau_Click` : la fenêtre de date pourrait être un petit formulaire, mais cela
  ajouterait un `.form` : on garde la construction dynamique.

### Commonalisation avec d'autres fichiers

- `Facture()` crée les tables de travail de fin de mois avec la structure de
  [`Facturefm`](../Facturefm.class/architecture.md) : helper commun (FACTUREFM-007).
- La lecture d'une écriture vers un `VarEcr` (`affectv`) ressemble aux chargements de
  `Saisecrit`/`Tresor` (séquence `VarEcr` répétée, voir notes transverses « LVar ») : candidat
  d'un constructeur `VarEcr.DepuisResult(r)`.
- Sélection de pièces à lettrer : logique proche de `Lettrage`/`Pointage` (lot Compta).

### Réduction de portée

- `check_reg`, `selection_choose`, `vldsaisie_Click`, `vldbordereau_Click`, `editions_Click`,
  `editionb_Click` → `Private` (aucun contrôle de ce nom, aucun appel externe, vérifié par `grep`).
- Restent `Public` : `Form_Close` (appelé par `ObjFacB.win_close`), tous les handlers,
  `selection_Click` (rejeu dynamique), `btval_click`/`btaba_click` (boutons dynamiques),
  `Bsel`/`Bval`.

### Séparation traitement / GUI

- `nreg_LostFocus` : lecture du règlement/journal et chargement du bordereau sans contrôle,
  le handler gardant l'affichage et les messages.
- `vldsaisie_Click` / `vldbordereau_Click` : boucle d'écriture `EcrReg` isolée des messages et
  de l'impression.
- `Facture()` : préparation des tables de travail séparée de l'ouverture d'`OptFac`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Reglements`, `Fiches_Journaux` sans clé `Cbase` utilisée ici (`TabJour` existe) ;
  `Fiches_Reglements` n'en a pas.
- Les colonnes booléennes `lettree`/`cloturee` comparées à `True`/`False` : un index
  `(compte, lettree, cloturee)` sur `Fiches_Mvt` accélérerait la reprise de bordereau (à mesurer).
