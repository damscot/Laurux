# FacturefmA — Architecture

> Source : `.src/Gestion/Facturation/FacturefmA.class`

## Vue d'ensemble

`FacturefmA` est l'écran de **facturation périodique (abonnements)** (menu Gestion › Facturation
› Facturation périodique, `Fmenu.Menu299`, masqué si `/Faca` = 0). Il sélectionne les BL
d'abonnement (`type = "A"`, `totalht <> 0`) dont la date de dernière facturation (`dtefac`)
est nulle ou antérieure à aujourd'hui, et retient pour chaque client le BL le plus récemment
facturé si la périodicité du client (`cli_aban` : « 1- Mensuel » … « 5- Annuel ») et son jour de
facturation (`cli_datab`) le rendent facturable à la date saisie (`Datej`). Il remplit les
tables de travail `Facturefm` et `Bl` (structures **réduites** par rapport à `Facturefm`), les
affiche, permet des retraits, puis lance l'édition par `OptFac` en mode `ObjFac.finmois`.

C'est une copie adaptée de [`Facturefm`](../Facturefm.class/architecture.md) ; il reste des
traces d'un envoi FTP des factures (`EnvoiFTP`, contrôle `FtpClient1`) qui n'est plus appelé.

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
| `Nfac` | var | Private |  | String | 36 |
| `Jnl` | var | Private |  | String | 37 |
| `cpt` | var | Private |  | String | 38 |
| `Intit` | var | Private |  | String | 39 |
| `numecr` | var | Private |  | String | 40 |
| `numr` | var | Private |  | Integer | 41 |
| `numr2` | var | Private |  | Integer | 42 |
| `cptRem` | var | Private |  | String | 43 |
| `Ctva` | var | Private |  | String | 44 |
| `Ctx` | var | Private |  | String | 45 |
| `cpttva` | var | Private |  | String | 46 |
| `IntitTva` | var | Private |  | String | 47 |
| `Txtleg` | var | Private |  | String | 48 |
| `Txtleg2` | var | Private |  | String | 49 |
| `Remmo` | var | Private |  | String | 50 |
| `Remart` | var | Private |  | String | 51 |
| `Mgart` | var | Private |  | String | 52 |
| `Mgmo` | var | Private |  | String | 53 |
| `Ttva` | var | Private |  | Float | 54 |
| `dateech` | var | Private |  | String | 55 |
| `Filename` | var | Private |  | String | 56 |
| `jour` | var | Private |  | String | 57 |
| `Nbl` | var | Private |  | Integer | 58 |
| `Nlgn` | var | Private |  | String | 59 |
| `Totalmo` | var | Private |  | String | 60 |
| `Totalart` | var | Private |  | String | 61 |
| `Totalrem` | var | Private |  | String | 62 |
| `totalht` | var | Private |  | String | 63 |
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
| `Bonl` | var | Private |  | Result | 78 |
| `dtex` | var | Private |  | String | 79 |
| `dte` | var | Private |  | String | 80 |
| `Devises` | var | Private |  | String | 81 |
| `PosY` | var | Private |  | Integer | 82 |
| `Visudoc` | var | Private |  | Boolean | 83 |
| `Coulfond` | var | Private |  | New String[] | 84 |
| `sclient` | var | Private |  | String | 85 |
| `sclient2` | var | Private |  | String | 86 |
| `Bsel` | var | Public |  | Boolean | 87 |
| `Bval` | var | Public |  | String | 88 |
| `Cclient` | var | Public |  | String | 89 |
| `ty` | var | Private |  | String | 90 |
| `Ccli` | var | Private |  | String | 91 |
| `dateech2` | var | Private |  | String | 92 |
| `pdf` | var | Private |  | Cdocuments | 93 |
| `hnew` | var | Private |  | File | 94 |
| `mail2` | var | Private |  | String | 95 |
| `$rs_soc` | var | Private |  | String | 96 |
| `$cli_nom` | var | Private |  | String | 97 |
| `$cli_pnm` | var | Private |  | String | 98 |
| `$cli_adr1` | var | Private |  | String | 99 |
| `$cli_adr2` | var | Private |  | String | 100 |
| `$cli_cd_ptl` | var | Private |  | String | 101 |
| `$cli_ville` | var | Private |  | String | 102 |
| `scode` | var | Private |  | String | 103 |
| `numrd` | var | Private |  | Integer | 104 |
| `bnumfac` | var | Private |  | Boolean | 105 |
| `numeroFac` | var | Private |  | String | 106 |
<!-- /AUTO:declarations -->

Comme dans `Facturefm`, la plupart des ≈ 80 variables d'instance sont **mortes** (déclarées,
jamais utilisées), notamment `Tab2`, `CblRslt`, `numbl`, `Nfac`, `Jnl`, `cpt`, `Intit`, `numr`,
`numr2`, `cptRem`, `Ctva`, `Ctx`, `cpttva`, `IntitTva`, `Txtleg`, `Txtleg2`, `Remmo`, `Remart`,
`Mgart`, `Mgmo`, `Ttva`, `dateech`, `jour`, `Nbl`, `Nlgn`, `Totalmo`, `Totalart`, `Totalrem`,
`totalht`, `Totht`, `typeL`, `Fam`, `Ardi`, `nbdec`, `Totttc`, `Brutht`, `Rem`, `TotEuros`, `nom`,
`adr211`, `adr222`, `numbonl`, `Bonl`, `PosY`, `Visudoc`, `Cclient`, `Ccli`, `dateech2`, `pdf`,
`$cli_adr1`, `$cli_adr2`, `$cli_cd_ptl`, `$cli_ville`, `numrd`, `bnumfac`. `ty`, `hnew`, `mail2`,
`$rs_soc`, `$cli_nom`, `$cli_pnm`, `scode`, `numeroFac`, `Mttc` ne servent qu'à `EnvoiFTP`
(morte). `Devises`, `Coulfond`, `numecr`, `dtex`, `dte` sont écrites sans être lues ;
`Filename` n'est jamais affectée. `Bsel`/`Bval` (écrites par `TriCpt`) doivent rester `Public`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 111-159 | Public | 3 | 43 | 0 | méthode spéciale |
| `recup_bl` | 164-301 | Public | 41 | 135 | 0 | portée réductible ? |
| `Colbl_Click` | 303-327 | Public | 4 | 22 | 0 | handler GUI |
| `Colbl_Keypress` | 329-354 | Public | 5 | 23 | 0 | handler GUI |
| `Coldetail_Click` | 356-360 | Public | 1 | 3 | 0 | handler GUI |
| `Coldetail_Keypress` | 362-396 | Public | 7 | 31 | 0 | handler GUI |
| `Quittedate` | 401-452 | Public | 9 | 49 | 0 | portée réductible ? |
| `Button1_KeyPress` | 454-458 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 460-471 | Public | 2 | 10 | 0 | handler GUI |
| `Button5_Click` | 473-479 | Public | 3 | 4 | 0 | handler GUI |
| `Radiobutton1_Click` | 481-488 | Public | 1 | 6 | 0 | handler GUI |
| `Radiobutton2_Click` | 490-501 | Public | 2 | 9 | 0 | handler GUI |
| `codeclient_KeyPress` | 503-516 | Public | 5 | 12 | 0 | handler GUI |
| `Togglebutton1_Click` | 518-532 | Public | 3 | 12 | 0 | handler GUI |
| `dtef_LostFocus` | 534-543 | Public | 4 | 8 | 0 | handler GUI |
| `EnvoiFTP` | 545-571 | Public | 3 | 24 | 0 | portée réductible ? |
| `Ftpclient1_read` | 573-575 | Public | 1 | 2 | 0 | handler GUI |
| `FtpClient1_Error` | 577-579 | Public | 1 | 2 | 0 | handler GUI |
| `FtpClient1_Connect` | 581-583 | Public | 1 | 2 | 0 | handler GUI |
| `FtpClient1_Finished` | 585-587 | Public | 1 | 2 | 0 | handler GUI |
| `Datej_KeyPress` | 589-602 | Public | 5 | 12 | 0 | handler GUI |
| `DateChooser1_Activate` | 604-609 | Public | 1 | 4 | 0 | handler GUI |
| `Button7_Click` | 614-618 | Public | 1 | 3 | 0 | handler GUI |
| `Button9_Click` | 620-628 | Public | 2 | 7 | 0 | handler GUI |
| `Button16_Click` | 630-634 | Public | 1 | 3 | 0 | handler GUI |
| `Button14_Click` | 636-644 | Public | 1 | 6 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et sélection

- **`_New()`** [portée : nécessaire (constructeur)] [nature : mixte]. Lit la devise (inutilisée),
  `Utils.Observers(Me)`, colonnes de `Colbl`/`Coldetail`, `Datej` = aujourd'hui.
- **`Button1_Click()`** / **`Button1_KeyPress()`** [handlers] [mixte]. Vide les listes,
  `Quittedate`, puis `recup_bl` si la date est acceptée.
- **`Quittedate()`** [portée : réductible] [mixte]. Normalise `datej` (`Utils.Cdate_calc/aff`),
  puis compare `aaaamm` de la date à la période en cours `Fiches_Parametres.dtepec` (`mm.aaaa`) :
  date hors du mois de la période → avertissement et refus (`b = 1`). Calcule aussi `dtex`,
  `dte`, `dte2`, `ye` et `numecr` sans les utiliser. Identique à `Facturergbl.Quittedate`.
- **`recup_bl()`** [portée : réductible] [nature : mixte] (CC 41, maximum du fichier).
  `DROP`/`CREATE` de `Facturefm` (`code, nom, cp, ville, totf, tottc`, clé `code`) et de `Bl`
  (`num, code, date, ht, ttc` — **sans `nom`**). Sélection `Fiches_Bl ⨝ Fiches_Cli` des BL `A`
  avec `dtefac <= aujourd'hui` (`Utils.cdate_dbase(Now)`, pas la date saisie) ou `dtefac` nul,
  triés par client puis `dtefac` décroissant (tous clients ou client saisi). Pour le **premier BL
  de chaque client** seulement (`codecli`) : client sans périodicité → avertissement ; jamais
  facturé → retenu ; sinon, selon `cli_aban`, compare le mois de `dtefac` (obtenu par
  `Left$(DteFac, 2)` sur la conversion implicite Date → String « mm/jj/aaaa hh:nn:ss ») au mois
  de la date saisie moins la périodicité, et le jour `cli_datab` au jour saisi. Un BL retenu est
  cumulé dans `Facturefm` et inséré dans `Bl` s'il a des lignes. Affiche ensuite `Facturefm`.
  Défauts : calcul du mois précédent faux en début d'année pour les périodicités > 1 mois
  (`12 - (-1)` = 13, FACTUREFMA-A03) ; cas annuel fondé sur `Right$(DteFac, 4)` qui contient
  l'heure (A02) ; test `IsNull(dtefac)` mort (dans la branche « non nul »).

### Listes et retraits

- **`Colbl_Click()`** [handler, rejeu dynamique] [mixte]. BL du client depuis `Bl` (arguments
  inutiles passés à `Exec`).
- **`Colbl_Keypress()`** [handler] [mixte]. Suppr → `DELETE` du client dans `Facturefm` et `Bl`,
  puis réaffichage (toute touche réaffiche la liste).
- **`Coldetail_Click()`** [handler, rejeu dynamique] [GUI]. Mémorise le BL.
- **`Coldetail_Keypress()`** [handler] [mixte]. Suppr → `DELETE` du BL dans `Bl`, réaffichage du
  détail et du total HT du client. ⚠️ Écrit le TTC de chaque BL dans **`Colbl.Item[3]`** (colonne
  Ville de la ligne client courante) au lieu de `Coldetail.Item[3]` (A01) ; la colonne HT n'est
  pas formatée.

### Saisie, édition, divers

- **`Radiobutton1_Click`** / **`Radiobutton2_Click`** / **`codeclient_KeyPress`** /
  **`Togglebutton1_Click`** [handlers] [GUI/mixte] : identiques à `Facturefm`.
- **`dtef_LostFocus()`** [handler] [GUI]. Normalise la date du panneau d'édition `Edit`.
- **`Datej_KeyPress()`**, **`DateChooser1_Activate()`** [handlers] [GUI]. Sélecteur de date.
- **`Button7_Click()`** : aide `Doc.Open("Cabonnement")`. **`Button5_Click()`** : supprime
  `Filename` (jamais affecté) et ferme.
- **`Button9_Click()`** [handler] [GUI]. Affiche le panneau `Edit` si des clients sont listés.
  **`Button16_Click()`** : masque le panneau.
- **`Button14_Click()`** [handler] [GUI]. `New OptFac(ObjFac.finmois, "", "", Me.Parent, " ",
  False, LDate(datej.Text))`, `ShowModal`, puis ferme l'écran. Le type est **fin de mois** (et non
  `ObjFac.abonnement`) et la date est `datej`, pas la date `Dtef` saisie dans le panneau (A05).

### Envoi FTP (code mort)

- **`EnvoiFTP($code)`** [portée : réductible] [mixte]. **Jamais appelée** (vérifié par `grep`).
  Chiffre le code client (`hexdblKey.crypt("en", …)`), envoie `Copie.spiece` sur
  `/Soc<XX>/Adrbase3/<code>/<ty>` (création du répertoire en cas d'échec), puis écrit une ligne de
  compte rendu dans `#Hnew` (fichier jamais ouvert). L'anomalie COPIE-A02 (envoi de
  `Copie.spiece`) ne peut donc pas se produire aujourd'hui.
- **`Ftpclient1_read`**, **`FtpClient1_Error`**, **`FtpClient1_Connect`**,
  **`FtpClient1_Finished`** [handlers du contrôle `FtpClient1`] : vides. `deps.py` classe
  `FtpClient1_Connect` en « jamais référencée » : c'est un gestionnaire d'événement (`Connect`)
  du client FTP (gb.net.curl), il ne doit pas être signalé comme fonction morte.

## État global utilisé

- `Start.LocalSettings` (`/Coul/Znss`, `/Soc<XX>/Coul_fen`, `/Soc<XX>/Adrbase3` dans le code
  mort), `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Coulfd`, `Utils.Observers`, `Utils.FColr`, `Utils.cpoint`,
  `Utils.Cdate_calc/aff/dbase`, `Cbase.Table("TabCli")`, `hexdblKey`, `Copie.spiece`, `Doc`.
- Tables : `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_Cli`, `Fiches_Parametres` ; tables de travail
  `Facturefm` et `Bl`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `EnvoiFTP`, les variables qui ne servent qu'à elle et les ≈ 55 autres variables
  mortes. Les quatre handlers vides de `FtpClient1` peuvent rester (contrôle présent dans le
  `.form`, intouchable) ou être supprimés (un événement sans gestionnaire est ignoré) : on les
  garde par prudence.
- `recup_bl` : remplacer les cinq branches `Case` de périodicité, quasi identiques, par une table
  `[libellé, nombre de mois]` et une seule fonction `EstFacturable(dtefac, aban, datab, date)`,
  **à comportement identique** (y compris les défauts A02/A03, corrigés séparément).
- `Quittedate` : supprimer les calculs inutilisés (`dtex`, `dte`, `dte2`, `ye`, `numecr`).

### Commonalisation avec d'autres fichiers

- `Quittedate` est identique à `Facturergbl.Quittedate` ; les handlers de liste et de saisie
  client sont ceux de `Facturefm` : voir FACTUREFM-006 (base commune des trois écrans).
- Création des tables de travail : helper commun (FACTUREFM-007) — la structure réduite d'ici
  devrait s'aligner sur celle attendue par `ObjFac` (A04).

### Réduction de portée

- `recup_bl`, `Quittedate` → `Private` ; `EnvoiFTP` → suppression ; `Cclient` → suppression.
- Restent `Public` : tous les handlers (dont `FtpClient1_Connect`), `Colbl_Click` et
  `Coldetail_Click` (rejeu dynamique), `Bsel`/`Bval` (`TriCpt`).

### Séparation traitement / GUI

- `recup_bl` : extraire la sélection, la règle de périodicité et l'alimentation des tables de
  travail dans des fonctions sans contrôle (paramètres : date saisie, client) ; le handler garde
  l'affichage et l'avertissement « client sans périodicité ».

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker la périodicité d'abonnement sous forme numérique (`cli_aban` est un libellé
  « 1- Mensuel ») et la date de prochaine facturation sur le BL d'abonnement : la sélection
  deviendrait une simple requête `WHERE prochaine_fac <= date`.
- Tables de travail : voir `Facturefm` (tables temporaires de session).
