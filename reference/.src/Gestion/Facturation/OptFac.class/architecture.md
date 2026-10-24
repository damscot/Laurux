# OptFac — Architecture

> Source : `.src/Gestion/Facturation/OptFac.class`

## Vue d'ensemble

`OptFac` est la **fenêtre d'options d'édition d'un document de vente** (BL, facture, devis,
commande, proforma, bon d'atelier, facture archivée, factures de fin de mois ou périodiques). Elle
instancie un objet facture `ObjFacB` (sous-classe de [`ObjFac`](../ObjFac.class/architecture.md))
avec le nom d'observateur `"var"`, affiche ses options (entête, réserves, pied, TTC, récapitulatif,
2ᵉ ligne, nombre d'exemplaires, échéance, adresse de livraison, texte de règlement…), recopie
chaque modification de case dans l'objet, puis déclenche l'édition (`editebl`, `editef`,
`editefm`), la visualisation, l'envoi par courriel ou l'ouverture de l'écran SMS.

Appelants (constructeur `New OptFac(choix, num, nfac [, Parent] [, mttc, livraison, dte,
courriel])`) : `Facture.Bl_Edit` ([Facture.class:9557-9559](../../../../../.src/Gestion/Facturation/Facture.class#L9557-L9559)), `Archives.Button9_Click`
([Archives.class:1464](../../../../../.src/Archivages/Archives.class#L1464)), `Facturefm.Button9_Click` ([Facturefm.class:781](../../../../../.src/Gestion/Facturation/Facturefm.class#L781)),
`FacturefmA.Button14_Click` ([FacturefmA.class:640](../../../../../.src/Gestion/Facturation/FacturefmA.class#L640)), `SaiReg.selection_Activate` et
`SaiReg.Facture` ([SaiReg.class:581-588](../../../../../.src/Gestion/Facturation/SaiReg.class#L581-L588), [SaiReg.class:942](../../../../../.src/Gestion/Facturation/SaiReg.class#L942)). Les appelants qui passent
`Me.Parent` en 4ᵉ position le voient consommé par le constructeur de `Form` : Gambas transmet au
constructeur parent les arguments qui suivent les paramètres **obligatoires** de la classe
(vérifié sur un projet minimal), `mttc`/`livraison`/`dte`/`courriel` prennent ensuite les suivants.

Nature globale : **GUI** (aiguillage d'options), avec trois écritures SQL directes.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$vfac` | var | Private |  | ObjFacB | 3 |
| `$courriel` | var | Private |  | String | 4 |
| `$choix` | var | Private |  | Integer | 5 |
| `$dte` | var | Private |  | LDate | 6 |
| `$regl1` | var | Private |  | String | 7 |
| `$regl2` | var | Private |  | String | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 10-110 | Public | 16 | 87 | 0 | méthode spéciale |
| `Form_Open` | 112-118 | Public | 1 | 5 | 0 | handler GUI |
| `form_Close` | 120-158 | Public | 4 | 33 | 0 | handler GUI |
| `Checkdte_Click` | 160-164 | Public | 1 | 3 | 0 | handler GUI |
| `Dtef_LostFocus` | 166-170 | Public | 1 | 3 | 0 | handler GUI |
| `Dtech_LostFocus` | 172-179 | Public | 2 | 6 | 0 | handler GUI |
| `entete_Click` | 181-185 | Public | 1 | 3 | 0 | handler GUI |
| `Coln_Click` | 187-191 | Public | 1 | 3 | 0 | handler GUI |
| `Cond_Click` | 193-197 | Public | 1 | 3 | 0 | handler GUI |
| `Imp2L_Click` | 199-203 | Public | 1 | 3 | 0 | handler GUI |
| `Nbexpl_Click` | 206-210 | Public | 1 | 3 | 0 | handler GUI |
| `Blch_Click` | 212-216 | Public | 1 | 3 | 0 | handler GUI |
| `Impstock_Click` | 218-222 | Public | 1 | 3 | 0 | handler GUI |
| `Impttc_Click` | 224-228 | Public | 1 | 3 | 0 | handler GUI |
| `Ignore_Remise_Click` | 230-240 | Public | 2 | 9 | 0 | handler GUI |
| `Imptotbl_Click` | 242-246 | Public | 1 | 3 | 0 | handler GUI |
| `AffBledit2_Click` | 248-262 | Public | 2 | 13 | 0 | handler GUI |
| `reserve_Click` | 264-268 | Public | 1 | 3 | 0 | handler GUI |
| `Pied_Click` | 270-274 | Public | 1 | 3 | 0 | handler GUI |
| `Recap_Click` | 276-280 | Public | 1 | 3 | 0 | handler GUI |
| `Rgmt_Click` | 282-297 | Public | 2 | 14 | 0 | handler GUI |
| `regl_lostfocus` | 299-307 | Public | 2 | 7 | 0 | handler GUI |
| `RegDef_Click` | 309-313 | Public | 1 | 3 | 0 | handler GUI |
| `ImpPDF_Click` | 315-319 | Public | 1 | 3 | 0 | handler GUI |
| `var_echeance` | 322-326 | Public | 1 | 3 | 0 | handler GUI |
| `var_nombre` | 328-332 | Public | 1 | 3 | 0 | handler GUI |
| `var_fttc` | 334-338 | Public | 1 | 3 | 0 | handler GUI |
| `totlettre_Click` | 341-345 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton10_Click` | 349-361 | Public | 2 | 11 | 0 | handler GUI |
| `Aff_AdrC` | 363-399 | Public | 7 | 36 | 0 | portée réductible ? |
| `Colal_Click` | 401-423 | Public | 2 | 20 | 0 | handler GUI |
| `Colal_Keypress` | 425-440 | Public | 8 | 11 | 0 | handler GUI |
| `Nombl_LostFocus` | 444-448 | Public | 1 | 3 | 0 | handler GUI |
| `Adr1BL_LostFocus` | 450-454 | Public | 1 | 3 | 0 | handler GUI |
| `Adr2BL_LostFocus` | 456-460 | Public | 1 | 3 | 0 | handler GUI |
| `CPBL_LostFocus` | 462-466 | Public | 1 | 3 | 0 | handler GUI |
| `VilleBL_LostFocus` | 468-472 | Public | 1 | 3 | 0 | handler GUI |
| `edite_Click` | 478-517 | Public | 11 | 34 | 0 | handler GUI |
| `Fermer_Click` | 519-523 | Public | 1 | 3 | 0 | handler GUI |
| `visu_Click` | 525-529 | Public | 1 | 3 | 0 | handler GUI |
| `sms_Click` | 531-542 | Public | 1 | 9 | 0 | handler GUI |
| `mail_Click` | 544-548 | Public | 1 | 3 | 0 | handler GUI |
| `propimp_Click` | 550-555 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction, ouverture, fermeture

- **`_new(choix, num, nfac, Optional mttc, livraison, dte, courriel)`** [portée : nécessaire
  (constructeur)] [nature : mixte] (CC 16). Prépare la grille `Colal` (adresses de livraison),
  crée trois `Chainage` (navigation clavier : adresse BL, dates, règlement ; la variable `chaine`
  est réutilisée, seuls les effets de bord comptent), type les champs (`TextReg.EstDate`, regex
  CP). Crée `$vfac = New ObjFacB(nfac, choix) As "var"` : `nfac` est le numéro de document (BL
  ou facture, ou suffixe de table `"M"`/`""` en fin de mois, voir `ObjFac._new`). Recopie dans
  les cases les options de l'objet (lues dans `Start.LocalSettings` par `ObjFac._new`), règle la
  visibilité des panneaux selon `choix` (`Pbl`/`Pfac`/`Pfac1`/`Preg`/`Ftri`/`sms`/`visu`), puis
  `$vfac.numcli = num` (déclenche `ObjFac.numcli_Write` : fiche client, événements `nombre`,
  `fttc`, `echeance`) et `numfac`/`numbl = nfac`. `mttc` n'est plus utilisé (ligne commentée) ;
  `res` est déclaré inutilement.
- **`Form_Open()`** [handler] [GUI]. Affiche la date, réaffecte `dtedoc` et réaffecte
  `numcli` à lui-même pour relever les événements de l'objet une fois la fenêtre ouverte.
- **`form_Close()`** [handler] [mixte]. **Persiste** dans `Start.LocalSettings` (puis
  `Save`/`Reload`) les cases `Recap` (deux fois), `Entete`, `Conditions`, `Pied`, `Imp2L`, `Col`,
  `Impstocke`, `ImpPDF`, `ImpTotbl`, `Cond`. Puis met à jour l'adresse de livraison du BL :
  si `$vfac.adrliv.nom` et `numbl` sont renseignés, `utils.db.Edit` (ou `Create9`) de
  `Fiches_AdrlivBL` dans une transaction ; sinon `utils.db.Delete("Fiches_AdrlivBL", numbl = …)`.
  ⚠️ `$vfac.adrliv` reste `Null` si la fiche client n'a pas été lue (fin de mois ouvert avec
  `num = ""` puis fermé sans édition) : « Null object » probable (OPTFAC-A03, à confirmer).
  `/ImpPDF` et `/Cond` sont écrits mais **jamais relus** (`ObjFac` ne lit pas `/ImpPDF`,
  ligne 242 commentée, ni `/Cond`).

### Recopie des cases vers l'objet (handlers, [nature : GUI])

`Checkdte_Click` (`dtmouv`), `Dtef_LostFocus` (`dtedoc`, recalcule l'échéance), `entete_Click`,
`Coln_Click` (`colon`), `Cond_Click` (`simpcond`), `Imp2L_Click` (`ligne2`), `Nbexpl_Click`
(`nbexplemplaire`), `Blch_Click` (`blchif`), `Impstock_Click` (`Stock`), `Impttc_Click` (`ttc`),
`Ignore_Remise_Click` (`remise`, désactive `Imptotbl`), `Imptotbl_Click` (`blrecap`),
`reserve_Click`, `Pied_Click`, `Recap_Click`, `RegDef_Click` (`breg`), `totlettre_Click`
(`doclet`) : une affectation chacun. Toutes [portée : nécessaire (handlers)].

- **`Dtech_LostFocus()`** [handler] [mixte]. Si l'échéance change, la recopie et exécute
  `UPDATE Fiches_Bl SET ech = … WHERE numbl = $vfac.numbl` (table en dur : ni `Cbase`, ni variante
  `M`). La comparaison `$vfac.dteech <> Dtech.dte` porte sur deux **objets** `LDate` (références)
  : elle est toujours vraie, l'`UPDATE` est donc émis à chaque perte de focus (dump inchangé).
- **`ImpPDF_Click()`** [handler] [GUI]. ⚠️ Écrit `$vfac.pdf = ImpPDF.Value` : `pdf` est le
  **chemin** du PDF joint aux factures (`/Pdfchemin`), pas l'indicateur d'archivage (`sauvpdf`).
  Le Boolean devient `"T"` ou `""` : cocher fait imprimer un fichier nommé `T`, décocher supprime
  la jonction du PDF (OPTFAC-A02).
- **`Rgmt_Click()`** / **`regl_lostfocus()`** [handlers] [GUI]. Active ou neutralise la saisie du
  texte de règlement (`tsaisreg`, deux lignes jointes par `\n`), en mémorisant les valeurs dans
  `$regl1`/`$regl2`. `regl_lostfocus` est le handler du groupe `regl` du `.form` (`regl1`, `regl2`) et
  est aussi appelé directement par `Rgmt_Click`.
- **`AffBledit2_Click()`** [handler] [GUI]. Affiche le panneau d'adresse de livraison prérempli
  avec `$vfac.adrliv`.

### Événements de l'objet facture (`var_*`, [nature : GUI])

- **`var_echeance(Value)`**, **`var_nombre(Value)`**, **`var_fttc(Value)`** : recopient
  l'échéance, le nombre d'exemplaires et le mode TTC levés par `ObjFac`. L'événement `modreg`
  d'`ObjFac` n'a aucun gestionnaire.

### Adresses de livraison

- **`ToggleButton10_Click()`** [handler] [GUI]. Affiche/masque `Colal` et appelle `Aff_AdrC("")`.
- **`Aff_AdrC(Org)`** [portée : réductible (aucun appel externe)] [nature : mixte]. Lit
  `Cbase.Table("TabAdrC")` (`Fiches_AdrlivC`) : toutes les adresses si `Org = "F2"`, sinon celles
  du client ; remplit `Colal` et présélectionne la première adresse du client. ⚠️ La branche
  `"F2"` passe `$vfac.numcl` en argument inutile : ce membre **n'existe pas** dans
  `ObjFac`/`ObjFacB` → erreur « Unknown symbol » à l'exécution (OPTFAC-A01).
- **`Colal_Click()`** [handler, rejeu dynamique] [mixte]. Lit l'adresse choisie et la recopie
  dans les champs `*BL` (en appelant leurs `_LostFocus`). Doit rester `Public`
  (`ReplayObserver` l'appelle par `Object.Call`, voir REPLAYOBSERVER-A06).
- **`Colal_Keypress()`** [handler] [GUI]. Échap masque, Entrée valide, F2 liste toutes les
  adresses.
- **`Nombl_LostFocus`**, **`Adr1BL_LostFocus`**, **`Adr2BL_LostFocus`**, **`CPBL_LostFocus`**,
  **`VilleBL_LostFocus`** [handlers] [GUI] : recopie dans `$vfac.adrliv`.

### Boutons

- **`edite_Click()`** [handler du bouton public `!edite`] [mixte]. Désactive les boutons puis
  selon `$choix` : fin de mois/abonnement → construit la clause `ORDER BY` à partir des cases
  `Tnum`/`Tnom`/`Tcp`/`Pville`, `$vfac.editefm(False, tri)` puis ferme ; facture →
  `$vfac.editef()` ; autres → `$vfac.editebl()`. Réactive les boutons.
- **`Fermer_Click()`** : ferme. **`visu_Click()`** : `$vfac.visualisation()`.
  **`mail_Click()`** : `$vfac.mail($courriel)`. **`propimp_Click()`** : configuration de
  l'imprimante de l'objet.
- **`sms_Click()`** [handler] [GUI]. Prépare le numéro (`resent!tel`) et ouvre `Gsm`. ⚠️ Les deux
  `Replace$` partent tous deux de `resent!tel` : seul le retrait des espaces est conservé, les
  points restent (OPTFAC-A04).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/…"]` (écrit à la fermeture : 10 clés).
- `Utils.db` (`Edit`, `Create9`, `Delete`, `Begin`/`Commit`, `Exec`), `Cbase.Table("TabAdrC")`,
  tables en dur `Fiches_Bl`, `Fiches_AdrlivBL` (sans clé `Cbase`).
- Objet `ObjFacB` et ses membres publics hérités d'`ObjFac` (≈ 35 membres lus ou écrits).

## Propositions d'amélioration

### Réécriture / refactorisation

- Les 17 handlers « une case → un membre » sont intouchables (noms de handlers) ; on peut
  documenter la table case ↔ membre ↔ clé `LocalSettings` en en-tête.
- `form_Close` : supprimer la double écriture de `/Recap` ; extraire `SauveOptions()` et
  `MajAdresseLivraison()`.
- `Dtech_LostFocus` : comparer `.L` des deux dates (l'`UPDATE` ne serait plus émis inutilement :
  SQL modifié, dump identique).
- `sms_Click` : variable `telp` locale inutilement en majuscule/minuscule mélangée.

### Commonalisation avec d'autres fichiers

- La recopie d'options `LocalSettings` ↔ cases est partiellement dupliquée dans
  [`ObjFac._new`](../ObjFac.class/architecture.md) (lecture) et ici (écriture) : une table
  commune `[clé, membre]` dans `ObjFac` servirait aux deux sens.
- `Aff_AdrC`/`Colal_Click` (adresses de livraison client) ont un équivalent dans `Facture`
  (à confirmer avec le document de `Facture`).

### Réduction de portée

- `Aff_AdrC` → `Private`.
- `entete_Click` et `edite_Click` sont signalés « jamais référencés » par `deps.py` : **faux
  positifs**, ce sont les handlers des contrôles publics `!Entete` et `!edite` du `.form`
  (préfixe `!` non reconnu par l'outil). Ils restent `Public`.

### Séparation traitement / GUI

- `form_Close` : la mise à jour de `Fiches_AdrlivBL` devient une méthode d'`ObjFac`
  (`EnregistreAdresseLivraison()`), la fenêtre gardant la persistance des cases.
- `Dtech_LostFocus` : l'`UPDATE` de l'échéance devient `ObjFac.MajEcheance()`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_AdrlivBL` (adresse de livraison par BL) n'a pas de clé `Cbase` ni de variante `M`
  pour les tables d'entretien ; une colonne `adrliv_id` vers `Fiches_AdrlivC` éviterait la copie.
