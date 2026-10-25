# Edbr — Architecture

> Source : `.src/Gestion/Impressions/Edbr.module`

## Vue d'ensemble

Module d'**impression des bons de réception fournisseur** (BR) en PDF (`~/tmp/BonReception.pdf`,
classe `Cdocuments`). Il est appelé par deux écrans :

- [`Edbl`](../Edbl.class/architecture.md) (réimpression d'un BR, `sOrg = ""`) ;
- [`ValidBR`](../../Stock/ValidBR.class/architecture.md) (validation de réceptions, `Init()` puis
  `Ed(numrecpts, …, "ValidBR")` avec plusieurs BR séparés par `\n`), qui ajoute un pied de
  facture : récapitulatif TVA lu dans la table de travail `Totalisation` (`Calc_tva`).

Après l'impression, `Ed` copie le PDF dans `~/Impressions/BonReception-<fournisseur>.pdf`
(`Copie.Dupli`) et, si le fournisseur a `fo_copie`, l'archive dans la GED (`LGed`) avec les tags
du BR, du fournisseur et ses tags par défaut (`tag_def`).

Le module garde un **état global** entre appels (`pdf`, `PosY`, `Filename`, `Mttc`, `Nbpage`,
`TotEuros`, `Org`) : `Init()` remet `Nbpage` et `TotEuros` à zéro (appelé seulement par `ValidBR`).

Nature : **mixte** (SQL, calcul des totaux, PDF, GED, message).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `PosY` | var | Private | oui | Integer | 3 |
| `Filename` | var | Private | oui | String | 4 |
| `pdf` | var | Private | oui | Cdocuments | 5 |
| `Mttc` | var | Private | oui | String | 6 |
| `Nbpage` | var | Private | oui | Integer | 7 |
| `TotEuros` | var | Private | oui | String | 8 |
| `son` | var | Private | oui | String | 9 |
| `Org` | var | Private | oui | String | 10 |
| `Cdocuments` | var | Public | oui | String | 11 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Init` | 13-18 | Public | 1 | 4 | 1 |  |
| `Calc_tva` | 23-109 | Public | 17 | 80 | 0 | portée réductible ? |
| `Ed` | 111-256 | Public | 19 | 135 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Init()`** [portée : nécessaire, `ValidBR.class:648`] [calcul] : `Nbpage = 0`, `TotEuros = "0"`.
- **`Calc_tva()`** (CC 17) [portée : réductible, appelé seulement par `Ed`] [mixte] :
  - option auto-entrepreneur (`/Soc<XX>/AutoEnt`) → pas de lignes de TVA ;
  - `SELECT * FROM Fiches_Tvaav` puis, par taux, `SELECT * FROM Totalisation WHERE codetva = &1`
    (table de travail remplie par `ValidBR.Maj_Totalisation`) ; pour les comptes `445…` de montant
    non nul : `pdf.Level9F(code, HT, taux, TVA, Mttc, PosY)` et cumul de `Tva` ;
  - `Mttc = TotEuros + Tva` ; formats entiers si `/Soc<XX>/Prxdec` ; `pdf.Level10F` (totaux) et
    `pdf.Level11F("")` ;
  - ⚠️ `devises` n'est jamais renseignée (chaîne vide) ; `Mttc` passé à `Level9F` est la valeur du
    calcul **précédent** (paramètre non imprimé par `Cdocuments.Level9F` : sans effet visible) ;
    avec `Prxdec`, le **code TVA** est reformaté en entier (`Format$(Val(ctx), "0")`).
- **`Ed(Nbls, codef, dater, Coulfond, sOrg)`** (CC 19) [portée : nécessaire, `Edbl`, `ValidBR`]
  [mixte] :
  - crée `~/BR` s'il n'existe pas (répertoire jamais utilisé ensuite) ;
  - pour chaque numéro non vide de `Nbls` : `EnteteN`, `SELECT * FROM Fiches_Ligrecpt LEFT JOIN
    <TabArt> on art_code = code WHERE numrecpt = &1 and four = &2`, fournisseur (`Fiches_Four`),
    `Level1br` (date `daterecpt`), une ligne `level2br` par article (casier, PB HT, remise, PA HT,
    total), saut de page à 250 avec un en-tête qui affiche **`dater`** (paramètre) au lieu de la
    date de réception (EDBR-A02), `Level3br` (total), `Baspage` ; cumul `TotEuros` ;
  - branche `sOrg = "Valcom"` (intitulé préfixé par `compt3_fam` de la famille) : **aucun
    appelant** ne passe cette valeur (code mort) ;
  - BR sans ligne : son jamais joué (`son` déclaré `String`, jamais affecté) puis message « Aucun
    mouvement », mais l'en-tête de page a déjà été émis (page vide dans le PDF, EDBR-A04) ;
  - `ValidBR` : `Level7F`, `Calc_tva` ;
  - `Baspage`, `Output`, `Visualiseur.Prog`, `Copie.Dupli` (renseigne `Copie.spiece`, lu par
    `FacturefmA.EnvoiFTP`, lui-même mort : COPIE-A02) ;
  - GED si `Cfac` (`fo_copie` du **dernier** fournisseur lu) : `LGed.Search` / `New LGed`, `DTE`,
    `TTC` vide, `HT = LPrix(Totalbl)`, `PDFDupli`, en cas d'échec `Supprime(False)` et `Return`,
    sinon `DelAllTag`, `AddTag("BR" & nbl)`, `AddTag(codef)`, puis `SELECT tag_def FROM <TabFour>
    WHERE fo_code = " & codef` (**concaténation** ; `fo_code` est `int(11)` : résultat correct
    pour un code numérique) et `AddTags`. ⚠️ `nbl` et `Totalbl` sont ceux du **dernier** BR de la
    boucle : en validation multiple (`ValidBR`), un seul document GED est créé, au numéro du dernier
    BR, avec le HT du dernier BR, alors que le PDF contient tous les BR (EDBR-A01).

## État global utilisé

- Variables de module : `PosY`, `Filename`, `pdf`, `Mttc`, `Nbpage`, `TotEuros`, `son` (jamais
  affectée), `Org`, `Public Cdocuments As String` (**jamais utilisée**, homonyme de la classe
  `Cdocuments` : source de confusion).
- `Start.LocalSettings["/Soc<XX>/AutoEnt"]`, `["/Soc<XX>/Prxdec"]`, `User.Home`.
- `Utils.db`, `Utils.cpoint`, `Cbase.Table` (`TabArt`, `TabFam`, `TabFour`), `Copie`, `LGed`,
  `LDate`, `LPrix`, `Visualiseur`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Public Cdocuments As String`, `son`, la branche `Valcom`, `Mkdir ~/BR`, `Shell "cd"`,
  les variables locales inutiles (`Fichier`, `Mtva`…) et le code commenté (EDBR-002).
- `Ed` (CC 19) : extraire `ImprimeBon(nbl, codef)` et `ArchiveGed(nbl, codef, total)` (EDBR-007).
- Paramétrer la requête `tag_def` (EDBR-005).

### Commonalisation avec d'autres fichiers

- **Archivage GED** : même séquence `Search`/`New`/`PDFDupli`/`Supprime`/`DelAllTag`/`AddTag(s)`
  que `ObjFac`, `commande1` et `EcrAuto` → `LGed.Archive(...)` proposé par LGED-007 (voir
  [LGed](../../../Utils/LGed.class/architecture.md)). EDBR-004 bascule `Ed` sur cette méthode,
  après LGED-007.
- **Copie dans `~/Impressions`** : `Copie.Dupli` (voir [Copie](../../../Utils/Copie.module/architecture.md),
  COPIE-A01/A02) ; `Edbr` est aujourd'hui le seul appelant.
- **Pied de facture TVA** (`Calc_tva`) : logique proche du pied de facture des factures clients
  (`Cdocuments.Level9F`/`Level10F` utilisés aussi par `ObjFac`/`Facturergbl`) ; à rapprocher en
  phase 3 seulement si les sorties sont identiques.

### Réduction de portée

- `Calc_tva` → `Private` ; `Cdocuments` (variable) supprimée.

### Séparation traitement / GUI

- `TotauxTva() As Collection` (lecture `Fiches_Tvaav`/`Totalisation` et cumul) séparée de
  l'impression ; lecture des lignes de BR et du fournisseur séparée du PDF.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Totalisation` est une table de travail globale (collision entre postes) : une structure en
  mémoire ou une table par session serait plus sûre.
- Index `Fiches_Ligrecpt(numrecpt, four)` déjà présent (`idx_numrecpt`).
