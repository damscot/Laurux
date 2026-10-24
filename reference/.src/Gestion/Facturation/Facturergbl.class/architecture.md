# Facturergbl — Architecture

> Source : `.src/Gestion/Facturation/Facturergbl.class`

## Vue d'ensemble

`Facturergbl` est l'écran de **regroupement de BL** (menu Gestion › Facturation › Regroupement
des BL, `Fmenu.Menu306`, masqué selon les options) : il liste les clients ayant **plusieurs** BL
non facturés jusqu'à une date, puis fusionne les BL d'un client (ou de tous les clients
affichés) en **un nouveau BL** numéroté depuis `Fiches_Parametres.dnbon`, en recopiant les
lignes (avec fusion optionnelle des articles identiques) et en supprimant les BL d'origine.

La classe sert aussi de **bibliothèque à `Moulinage`** (caisse) : `Moulinage` crée une instance
invisible (`RegroupBL = New Facturergbl`, [Moulinage.class:1007](../../../../../.src/Caisse/Moulinage.class#L1007)) pour appeler `Ent_Bl`
(regroupement des BL réglés par un même ticket, [Moulinage.class:1307](../../../../../.src/Caisse/Moulinage.class#L1307)) et `Maj_Parametres`
([Moulinage.class:1437](../../../../../.src/Caisse/Moulinage.class#L1437)).

Le fichier contient en outre une **édition de facture regroupée** (`Button14_Click`, 520 lignes,
CC 121) et ses fonctions (`Ventilation`, `Maj_Totalisation`, `Calc_tva`) qui sont
**inatteignables** : elles dépendent du panneau `Edit`, invisible dans le `.form`, que seule
`Bl_Edit` (jamais appelée) rendait visible.

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `b` | var | Private |  | Integer | 28 |
| `Tab` | var | Private |  | String | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `Tab3` | var | Private |  | String | 31 |
| `Tab4` | var | Private |  | String | 32 |
| `rResult` | var | Private |  | Result | 33 |
| `CblRslt` | var | Private |  | Result | 34 |
| `numbl` | var | Private |  | Result | 35 |
| `Nbon` | var | Private |  | String | 36 |
| `cpt` | var | Private |  | String | 37 |
| `Intit` | var | Private |  | String | 38 |
| `numecr` | var | Private |  | String | 39 |
| `numr` | var | Private |  | Integer | 40 |
| `numr2` | var | Private |  | Integer | 41 |
| `cptRem` | var | Private |  | String | 42 |
| `Ctva` | var | Private |  | String | 43 |
| `Ctx` | var | Private |  | String | 44 |
| `cpttva` | var | Private |  | String | 45 |
| `IntitTva` | var | Private |  | String | 46 |
| `Txtleg` | var | Private |  | String | 47 |
| `Txtleg2` | var | Private |  | String | 48 |
| `Remmo` | var | Private |  | String | 49 |
| `Remart` | var | Private |  | String | 50 |
| `Mgart` | var | Private |  | String | 51 |
| `Mgmo` | var | Private |  | String | 52 |
| `Ttva` | var | Private |  | Float | 53 |
| `dateech` | var | Private |  | String | 54 |
| `Filename` | var | Private |  | String | 55 |
| `jour` | var | Private |  | String | 56 |
| `Nbl` | var | Private |  | Integer | 57 |
| `Nlgn` | var | Private |  | String | 58 |
| `Totalmo` | var | Private |  | String | 59 |
| `Totalart` | var | Private |  | String | 60 |
| `Totalrem` | var | Private |  | String | 61 |
| `totalht` | var | Private |  | String | 62 |
| `totalttc` | var | Private |  | String | 63 |
| `Totht` | var | Private |  | String | 64 |
| `typeL` | var | Private |  | String | 65 |
| `Fam` | var | Private |  | String | 66 |
| `Ardi` | var | Private |  | String | 67 |
| `nbdec` | var | Private |  | String | 68 |
| `Totttc` | var | Private |  | String | 69 |
| `Brutht` | var | Private |  | String | 70 |
| `Rem` | var | Private |  | String | 71 |
| `TotEuros` | var | Private |  | String | 72 |
| `nom` | var | Private |  | String | 73 |
| `Mttc` | var | Private |  | String | 74 |
| `adr211` | var | Private |  | String | 75 |
| `adr222` | var | Private |  | String | 76 |
| `numbonl` | var | Private |  | String | 77 |
| `intituleb` | var | Private |  | String | 78 |
| `Bonl` | var | Private |  | Result | 79 |
| `dtex` | var | Private |  | String | 80 |
| `dte` | var | Private |  | String | 81 |
| `Devises` | var | Private |  | String | 82 |
| `PosY` | var | Private |  | Integer | 83 |
| `Visudoc` | var | Private |  | Boolean | 84 |
| `Coulfond` | var | Private |  | New String[] | 85 |
| `sclient` | var | Private |  | String | 86 |
| `sclient2` | var | Private |  | String | 87 |
| `Bsel` | var | Public |  | Boolean | 88 |
| `Cclient` | var | Public |  | String | 89 |
| `Ccli` | var | Private |  | String | 90 |
| `dateech2` | var | Private |  | String | 91 |
| `pdf` | var | Private |  | Cdocuments | 92 |
<!-- /AUTO:declarations -->

Variables d'instance (≈ 65, sans portée explicite donc `Private`) : la plupart ne servent qu'à
la chaîne d'édition morte (`Totht`, `Totttc`, `Remmo`, `Remart`, `Totalrem`, `Totalart`,
`Totalmo`, `Txtleg`, `Txtleg2`, `cpt`, `Intit`, `Ctva`, `Ctx`, `cpttva`, `IntitTva`, `Ttva`,
`cptRem`, `PosY`, `Nlgn`, `Mttc`, `TotEuros`, `numr`, `numr2`, `Coulfond`, `Devises`, `pdf`…).
`Ent_Bl` lit pourtant `Totht`, `Mttc`, `mgart`, `mgmo` et `dateech`, qui restent vides hors de
cette chaîne (FACTURERGBL-A05). Mortes dans tous les cas : `CblRslt` hors `Button14`, `Nbl`
hors `Button14`, `Cclient`, `Ccli` (écrite seulement), `dateech2`, `dtex`, `Visudoc`, `adr211`/
`adr222` hors `Button14`, `Ardi`/`nbdec`/`typeL` (seulement `ard`, morte). `Bsel` est déclarée
mais aucune recherche `TriCpt` n'est faite ici (pas de `Bval`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 97-159 | Public | 7 | 55 | 0 | méthode spéciale |
| `recup_bl` | 164-242 | Public | 11 | 71 | 0 | portée réductible ? |
| `Colbl_Click` | 244-268 | Public | 4 | 22 | 0 | handler GUI |
| `Colbl_Keypress` | 270-298 | Public | 6 | 26 | 0 | handler GUI |
| `Coldetail_Activate` | 300-307 | Public | 1 | 5 | 0 | handler GUI |
| `Coldetail_Click` | 309-313 | Public | 1 | 3 | 0 | handler GUI |
| `Coldetail_Keypress` | 315-349 | Public | 7 | 31 | 0 | handler GUI |
| `Quittedate` | 354-409 | Public | 9 | 49 | 0 | portée réductible ? |
| `Button1_KeyPress` | 411-415 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 417-428 | Public | 2 | 10 | 0 | handler GUI |
| `Button5_Click` | 430-435 | Public | 3 | 4 | 0 | handler GUI |
| `Radiobutton1_Click` | 437-442 | Public | 1 | 4 | 0 | handler GUI |
| `Bl_Edit` | 447-457 | Public | 4 | 8 | 0 | portée réductible ? |
| `dtef_LostFocus` | 459-468 | Public | 4 | 8 | 0 | handler GUI |
| `Button14_Click` | 470-992 | Public | 121 | 515 | 0 | handler GUI |
| `Parametres` | 997-1008 | Public | 2 | 9 | 0 | portée réductible ? |
| `Maj_Parametres` | 1013-1018 | Public | 1 | 4 | 1 |  |
| `Ventilation` | 1023-1038 | Public | 2 | 13 | 0 | portée réductible ? |
| `Maj_Totalisation` | 1043-1123 | Public | 10 | 66 | 0 | portée réductible ? |
| `Calc_tva` | 1128-1217 | Public | 15 | 83 | 0 | portée réductible ? |
| `Selbl` | 1219-1233 | Public | 3 | 13 | 0 | portée réductible ? |
| `Ent_Bl` | 1238-1317 | Public | 14 | 71 | 1 |  |
| `Bl_Sup` | 1322-1332 | Public | 1 | 8 | 0 | portée réductible ? |
| `Button9_Click` | 1334-1359 | Public | 4 | 23 | 0 | handler GUI |
| `ard` | 1364-1401 | Public | 14 | 33 | 0 | portée réductible ? |
| `Button16_Click` | 1403-1407 | Public | 1 | 3 | 0 | handler GUI |
| `Datej_DblClick` | 1409-1417 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 1419-1424 | Public | 1 | 4 | 0 | handler GUI |
| `Datej_KeyPress` | 1426-1439 | Public | 5 | 12 | 0 | handler GUI |
| `Button7_Click` | 1444-1448 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et sélection

- **`_New()`** [portée : nécessaire (constructeur, aussi exécuté par `Moulinage`)] [nature :
  mixte]. Lit la devise, `Utils.Observers(Me)`, **lance `Shell "lpc status"`** pour remplir la
  liste d'imprimantes `Cimp` (panneau `Edit`, inatteignable), configure les colonnes, propose le
  dernier jour du mois dans `datej`.
- **`Button1_Click()`** / **`Button1_KeyPress()`** [handlers] [mixte]. `Quittedate` puis
  `recup_bl`.
- **`Quittedate()`** [portée : réductible] [mixte]. Identique à `FacturefmA.Quittedate` : refuse
  une date hors du mois de la période en cours (`dtepec`).
- **`recup_bl()`** [portée : réductible] [mixte] (CC 11). `DROP`/`CREATE` des tables de travail
  `Facturefm` (`code, nom, cp, ville, totf, tottc`) et `Bl` (**`numbl`**, `code, date, ht, ttc`).
  Sélection dans `Fiches_Bl` des BL `B` sans ticket (`numtick IS NULL`) et des `F` non imprimés,
  datés au plus tard de `datej`. Cumule les totaux par client (un BL sans client est signalé et
  ignoré), insère chaque BL ayant des lignes dans `Bl`, puis n'affiche que les clients ayant
  **plus d'un** BL.
- **`Radiobutton1_Click()`** [handler] [GUI]. Vide les listes.

### Listes et retraits

- **`Colbl_Click()`** [handler, rejeu dynamique] [mixte]. BL du client (`Bl`).
- **`Colbl_Keypress()`** [handler] [mixte]. Suppr → retrait du client des tables de travail ;
  réaffichage des clients à plusieurs BL.
- **`Coldetail_Click()`** [handler, rejeu dynamique] [GUI]. Mémorise le BL.
- **`Coldetail_Activate()`** [handler] [GUI]. Consultation (`AFacture`).
- **`Coldetail_Keypress()`** [handler] [mixte]. Suppr → retrait du BL ; ⚠️ écrit le TTC dans
  `Colbl.Item[3]` (même défaut que FACTUREFMA-A01).

### Regroupement

- **`Button9_Click()`** [handler] [mixte]. Confirmation, puis sous
  `LOCK TABLES Fiches_Parametres, Fiches_Bl, Fiches_Ligbl, Bl, Fiches_Cli, Fiches_Tvaav WRITE` :
  `Nbon = Parametres()`, `Selbl()`, `Maj_Parametres(Nbon)`, `UNLOCK TABLES`, puis nouvelle
  sélection. ⚠️ `Ent_Bl` appelle `DocActif.Get_Lock`/`Free_Lock`, qui exécutent leur propre
  `LOCK TABLES Fiches_Docactif WRITE` … `UNLOCK TABLES` : sous MySQL, cela **remplace puis libère**
  les verrous posés ici dès le premier BL (FACTURERGBL-A03).
- **`Parametres()`** [portée : réductible] [calcul]. `dnbon + 1` formaté sur 6 chiffres.
- **`Maj_Parametres(Numbon)`** [portée : nécessaire (`Moulinage`)] [calcul].
  `UPDATE Fiches_Parametres SET dnbon = …`.
- **`Selbl()`** [portée : réductible] [mixte]. Tous les clients affichés (`RadioButton1`) :
  incrémente `Nbon` **avant** chaque `Ent_Bl` (le premier numéro `dnbon + 1` est sauté) ; sinon un
  seul `Ent_Bl` pour le client courant (`sclient`, vide si aucun clic). Option `Fusion_art`.
- **`Ent_Bl(sclient, nbon, Fus_art, Optional ntk, Optional Date_Bl = LDate(datej.Text).G)`**
  [portée : nécessaire (`Moulinage`)] [nature : calcul] (CC 14). Source : les BL du ticket `ntk`
  dans `Fiches_Bl` (appel `Moulinage`) ou ceux de la table de travail `Bl` (écran). Si au moins
  un BL : insère l'entête du nouveau BL `nbon` (`Fiches_Bl`, coordonnées de `Fiches_Cli`,
  `htbl = Val(Totht)`, `ech = Cdate_Dbase(dateech)`, marges `mgart`/`mgmo`,
  `totalttc = Val(Mttc)`, `type = "B"`), prend le verrou applicatif du nouveau BL, ajoute une
  ligne de commentaire « Règlement en Caisse par le Ticket n° … » (cas ticket), puis pour chaque
  BL source verrouillé : ligne « Regroupement BL n° … », recopie des lignes `A` et `C` (fusion
  des articles identiques — même code, remise et prix — si `Fus_art`, en cumulant quantités et
  montants : ⚠️ les marges sont lues sur l'**entête** `Entbonl!mrgart_ligbl`, colonne inexistante
  de `Fiches_Bl` → erreur, FACTURERGBL-A02), suppression du BL source (lignes et entête) et
  libération de son verrou. Met enfin à jour les totaux HT/TTC du nouveau BL. Les lignes des types
  `M`, `T`, `O`, `E`, `P`, `R` des BL sources ne sont **pas** recopiées (sélection `A`/`C`
  seulement) : à confirmer comme volontaire.

### Chaîne d'édition inatteignable (code mort)

- **`Bl_Edit()`** [portée : réductible] — **jamais appelée** : affichait le panneau `Edit`.
- **`Button14_Click()`** [handler d'un bouton du panneau `Edit`, inatteignable] (CC 121).
  Édition PDF (`Cdocuments`) d'une facture regroupée : verrous `LOCK TABLES` sur ≈ 20 tables,
  en-tête société (`Fiches_Societes`, dupliqué dans 6 fichiers), pagination, lignes, acomptes,
  écotaxes, totaux, `Calc_tva`, insertion dans la table `Totalisation`, impression
  (`Impression.Facture`). Contient l'erreur d'arité signalée par `deps.py` :
  `Cdocuments.Level6F` appelé avec **5 arguments pour 6** (le paramètre `frais` manque,
  l. 948, 953, 960). Utilise `Totht` à la fois comme total courant de la facture et comme cumul
  de `Maj_Totalisation`, qui l'écrase.
- **`Button16_Click()`**, **`dtef_LostFocus()`** [handlers du panneau `Edit`] : inatteignables.
- **`Ventilation()`**, **`Maj_Totalisation()`**, **`Calc_tva()`** [portée : réductible]
  : appelées seulement par `Button14_Click`. Table de travail `Totalisation` (DROP/CREATE),
  `LOCK TABLES` imbriqués (qui libèrent ceux de l'appelant sous MySQL). `Moulinage` possède ses
  propres versions (signatures différentes).
- **`Bl_Sup()`** [portée : réductible] — **jamais appelée** (suppression du BL `Nbon`).
- **`ard(Puttc)`** [portée : réductible] — **jamais appelée** ; copie à l'identique de
  `ValidBR.ard` (arrondi au 0,05/0,10/0,50/1 par chaîne).

### Divers

- **`Button5_Click()`** : supprime `Filename` s'il existe (affecté seulement par `Button14`) et
  ferme. **`Button7_Click()`** : aide `Doc.Open("RegroupementBl")`.
- **`Datej_DblClick()`**, **`Datej_KeyPress()`**, **`DateChooser1_Activate()`** [handlers] :
  sélecteur de date.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/…"]` (`Cimp`, `Entete`, `Conditions`, `Recap`, `glogo`, `Logo`,
  `Siret`, `Prxdec`, `AutoEnt` — tous dans la chaîne morte), `Start.Son`, `Start.Musique`,
  `Variables.bRemise` (chaîne morte).
- `Utils.db`, `Utils.Coulfd`, `Utils.Observers`, `Utils.cpoint`, `Utils.Cdate_*`,
  `Utils.Calcech`, `Cbase.Table` (partiel), `DocActif`, `Cdocuments`, `Impression`, `Syntheses`,
  `AFacture`, `Doc`, commande système `lpc`.
- Tables : `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_Cli`, `Fiches_Parametres`, tables de travail
  `Facturefm`, `Bl`, `Totalisation` ; dans la chaîne morte : `Fiches_Societes`, `Fiches_LibelFac`,
  `Fiches_Echeances`, `Fiches_Art`, `Fiches_Mo`, `Fiches_Fam`, `Fiches_Comptes`, `Fiches_Tvaav`,
  `Fiches_Tleg`, `Fiches_Mvt`, `Fiches_HistoFac`, `Fiches_Suivis`, `Fiches_RgLigbl`, GED.

## Propositions d'amélioration

### Réécriture / refactorisation

- Décision préalable (FACTURERGBL-A01) : supprimer la chaîne d'édition morte (`Button14_Click`,
  `Button16_Click`, `dtef_LostFocus`, `Ventilation`, `Maj_Totalisation`, `Calc_tva`, `Bl_Edit`,
  le `Shell "lpc status"` de `_New`) — ≈ 700 lignes et la complexité 121 —, ou la réactiver en
  corrigeant l'arité et les verrous. Les handlers des contrôles du panneau `Edit` (présent dans le
  `.form`, intouchable) peuvent être laissés vides.
- Supprimer `Bl_Sup`, `ard` et les variables mortes.
- `Ent_Bl` : extraire `InsereEntete`, `RecopieLigne` (fusion ou insertion) ; préciser par des
  variables locales les valeurs aujourd'hui lues dans des membres vides (`Totht`, `Mttc`…), à
  valeur identique.

### Commonalisation avec d'autres fichiers

- Écran de sélection : base commune avec [`Facturefm`](../Facturefm.class/architecture.md) et
  [`FacturefmA`](../FacturefmA.class/architecture.md) (FACTUREFM-006) ; `Quittedate` identique à
  celle de `FacturefmA`.
- `Ent_Bl` est un service de regroupement utilisé par `Moulinage` : le déplacer dans un module
  non graphique (ex. `RegroupementBl`) éviterait à `Moulinage` d'instancier un formulaire (et le
  `Shell lpc` + les observateurs de rejeu de `_New`) — déplacement hors périmètre de ce plan,
  préparé par la séparation ci-dessous.
- `ard` = `ValidBR.ard` = arrondi par chaîne (voir notes transverses : `Utils.arrondi`,
  `LPrix.Arrondi_Calc`).
- En-tête société des PDF (chaîne morte) : `Creleve.EnteteSociete` proposé (LIGCLI-004) ; sans
  objet si la chaîne est supprimée.

### Réduction de portée

- `recup_bl`, `Quittedate`, `Parametres`, `Selbl` → `Private`.
- Restent `Public` : `Ent_Bl`, `Maj_Parametres` (`Moulinage`), tous les handlers, `Colbl_Click`
  et `Coldetail_Click` (rejeu dynamique).

### Séparation traitement / GUI

- `Ent_Bl` ne lit aucun contrôle sauf la valeur par défaut de `Date_Bl` (`datej.Text`) : rendre
  ce défaut explicite dans `Selbl` (même valeur) pour que la fonction soit purement
  traitement.
- `Button9_Click` : extraire `RegroupeSelection(tous, fusion)` (verrous, numérotation, `Selbl`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Numérotation des BL par `dnbon` (`varchar(8)` de `Fiches_Parametres`) lue puis réécrite : un
  compteur atomique (`DB_Connection.LockIncrement` ou séquence) supprimerait le besoin de
  `LOCK TABLES`.
- Tables de travail (`Facturefm`, `Bl`, `Totalisation`) : tables temporaires de session.
