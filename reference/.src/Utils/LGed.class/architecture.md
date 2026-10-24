# LGed — Architecture

> Source : `.src/Utils/LGed.class` · Formulaire : `.src/Utils/LGed.form`

## Vue d'ensemble

`LGed` est à la fois l'**objet métier « document GED »** et la **fiche d'édition** de ce document
(c'est une `Form`, `Create Static`). Un document est une ligne de `Docs_Ged` (type, code, compte,
origine, URL, nom de fichier, type MIME, date, montants TTC/HT) reliée à des tags (`Fiches_Tag`) par
la table de liaison `Docs_Tag`.

Le type (`Public Enum Clients, Fournisseurs, Comptabilite, Autres, Articles`) détermine le
répertoire racine (`/Soc<XX>/Factchemin`, `FactcheminF`, `FactcheminC`, `FactcheminP`,
`FactcheminA`). Le fichier est stocké sous `<racine>/<compte>/<année>/<origine>/…`.

Trois familles d'usage :
1. **API objet, sans fenêtre** (instance non affichée) : `New LGed(Null, lind)` ou
   `New LGed(Null, 0, type, origine, code, compte)`, puis `AddTag(s)`, `DelAllTag`, `PDFDupli`
   (copie d'un PDF imprimé + enregistrement), `Supprime`, `Ouvrir`. Appelants : impressions et
   validations (`ObjFac`, `commande1`, `Edbr`, `EcrAuto`, `ValidBR`, `ValidBR1`…).
2. **API statique** (auto-instance) : `LGed.Search`, `LGed.String2Array`, `LGed.Array2String`,
   `LGed.EpurationTags`, `LGed.EpurationDocs`.
3. **Fiche d'édition** (`ShowModal`) : saisie des champs, choix de compte, tags, scan
   (xsane/scanimage + convert), copie d'un fichier existant, enregistrement (copie/déplacement du
   fichier puis `Commit`). Ouverte par `Saisecrit`, `Tresor`, `Articles`, `GedR`, `Fmenu`, `ValidBR`…

Nature globale : **mixte** : SQL et fichiers (logique) entremêlés avec les contrôles
(`ListTags`, `furl`, `fmime`…), jusque dans des méthodes de l'API objet (`Commit`, `Default_URL`,
`MoveURL`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Clients` | enum | Public | oui |  | 7 |
| `Fournisseurs` | enum | Public | oui |  | 7 |
| `Comptabilite` | enum | Public | oui |  | 7 |
| `Autres` | enum | Public | oui |  | 7 |
| `Articles` | enum | Public | oui |  | 7 |
| `$index` | var | Private |  | Integer | 9 |
| `$tags` | var | Private |  | Collection | 10 |
| `$type` | var | Private |  | Integer | 11 |
| `$code` | var | Private |  | String | 12 |
| `$compte` | var | Private |  | String | 13 |
| `$url` | var | Private |  | String | 14 |
| `$filename` | var | Private |  | String | 15 |
| `$mime` | var | Private |  | String | 16 |
| `$origin` | var | Private |  | String | 17 |
| `$mht` | var | Private |  | LPrix | 18 |
| `$mttc` | var | Private |  | LPrix | 19 |
| `$dte` | var | Private |  | LDate | 20 |
| `$mimeout` | var | Private |  | String | 21 |
| `$temp_file` | var | Private |  | String | 22 |
| `$temp_extension` | var | Private |  | String | 23 |
| `Bsel` | var | Public |  | Boolean | 25 |
| `Bval` | var | Public |  | String | 26 |
| `TTC` | property | Public |  | LPrix | 28 |
| `HT` | property | Public |  | LPrix | 29 |
| `DTE` | property | Public |  | LDate | 30 |
| `ORI` | property | Public |  | String | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-75 | Public | 5 | 35 | 0 | méthode spéciale |
| `Exist` | 77-84 | Public | 1 | 5 | 0 | portée réductible ? |
| `Search` | 86-93 | Public | 1 | 5 | 8 |  |
| `trouve` | 96-122 | Private | 7 | 23 | 0 |  |
| `Supprime` | 124-134 | Public | 3 | 9 | 8 |  |
| `String2Array` | 136-152 | Public | 4 | 14 | 9 |  |
| `Array2String` | 154-177 | Public | 5 | 18 | 2 |  |
| `AddTag` | 179-197 | Public | 3 | 15 | 11 |  |
| `AddTags` | 199-207 | Public | 3 | 7 | 10 |  |
| `DelAllTag` | 209-219 | Public | 3 | 9 | 3 |  |
| `DelTag` | 221-240 | Public | 4 | 16 | 0 | portée réductible ? |
| `EpurationTags` | 243-257 | Public | 3 | 12 | 1 |  |
| `EpurationDocs` | 259-273 | Public | 3 | 12 | 1 |  |
| `XdgMimeProc_Read` | 276-284 | Public | 1 | 5 | 0 | handler GUI |
| `CurlMimeProc_Read` | 286-300 | Public | 2 | 11 | 0 | handler GUI |
| `Get_Mime` | 302-335 | Public | 13 | 29 | 0 | portée réductible ? |
| `Get_Default_Extension` | 337-374 | Public | 14 | 32 | 0 | portée réductible ? |
| `MoveURL` | 376-408 | Public | 13 | 23 | 0 | portée réductible ? |
| `Commit` | 410-429 | Public | 3 | 14 | 0 | portée réductible ? |
| `Ouvrir` | 431-439 | Public | 4 | 7 | 5 |  |
| `Default_URL` | 442-497 | Public | 10 | 46 | 0 | portée réductible ? |
| `TTC_Read` | 503-505 | Private | 1 | 3 | 0 |  |
| `TTC_Write` | 507-509 | Private | 1 | 3 | 0 |  |
| `HT_Read` | 511-513 | Private | 1 | 3 | 0 |  |
| `HT_Write` | 515-517 | Private | 1 | 3 | 0 |  |
| `DTE_Read` | 519-521 | Private | 1 | 3 | 0 |  |
| `DTE_Write` | 523-525 | Private | 1 | 3 | 0 |  |
| `ORI_Read` | 527-529 | Private | 1 | 3 | 0 |  |
| `ORI_Write` | 531-533 | Private | 1 | 3 | 0 |  |
| `form_Open` | 538-576 | Public | 3 | 33 | 0 | handler GUI |
| `form_Close` | 578-582 | Public | 1 | 3 | 0 | handler GUI |
| `ftype_Change` | 584-596 | Public | 4 | 10 | 0 | handler GUI |
| `fcode_Change` | 598-602 | Public | 1 | 3 | 0 | handler GUI |
| `fcompte_Change` | 604-608 | Public | 1 | 3 | 0 | handler GUI |
| `furl_Change` | 610-612 | Public | 1 | 2 | 0 | handler GUI |
| `fMht_Change` | 614-618 | Public | 1 | 3 | 0 | handler GUI |
| `fMttc_Change` | 620-624 | Public | 1 | 3 | 0 | handler GUI |
| `fmime_Change` | 626-630 | Public | 1 | 3 | 0 | handler GUI |
| `forigin_Change` | 632-636 | Public | 1 | 3 | 0 | handler GUI |
| `ListTags_Change` | 638-640 | Public | 1 | 2 | 0 | handler GUI |
| `cptselect_Click` | 642-665 | Public | 5 | 20 | 0 | handler GUI |
| `Existant_Click` | 667-695 | Public | 3 | 22 | 0 | handler GUI |
| `OuvrirB_Click` | 697-701 | Public | 1 | 3 | 0 | handler GUI |
| `Supprimer_Click` | 703-710 | Public | 2 | 6 | 0 | handler GUI |
| `Enregistrer_Click` | 712-814 | Public | 29 | 83 | 0 | handler GUI |
| `Sortir_Click` | 816-824 | Public | 4 | 7 | 0 | handler GUI |
| `ScannerFinalize` | 826-860 | Public | 10 | 29 | 0 | portée réductible ? |
| `ScanGUI_Click` | 862-895 | Public | 6 | 30 | 0 | handler GUI |
| `ScanBatch_Click` | 897-936 | Public | 7 | 33 | 0 | handler GUI |
| `Copier_Click` | 938-982 | Public | 15 | 42 | 0 | handler GUI |
| `DefUrl_Click` | 984-988 | Public | 1 | 3 | 0 | handler GUI |
| `PDFDupli` | 990-1009 | Public | 3 | 16 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et recherche

- **`_New(lind, type, origin, code, compte)`** [portée : nécessaire] [nature : calcul + SQL].
  Initialise l'état (date = maintenant, montants 0). Si `lind <> 0` : `Select * From Docs_Ged where
  lind = &1`, puis les tags (`Docs_Tag inner join Fiches_Tag`) dans `$tags` (clé = `lind` du tag),
  et recopie les colonnes. Appel : `New LGed(Null, …)` (le `Null` est le parent de la fenêtre).
- **`Exist(type, code, compte, orig)`** [portée : réductible] : `trouve(…, True)`. Aucun appel
  externe (les `$lg.Exist` de `fourconsdroi` portent sur une `Collection`). Homonyme de la fonction
  native `Exist(chemin)` utilisée dans la même classe (l. 433, 737, 748, 764, 843) : le compilateur
  résout ces appels vers la fonction native (sinon il manquerait l'argument `code`), mais la
  lecture est trompeuse.
- **`Search(type, code, compte, orig)`** [portée : nécessaire] : `trouve(…, False)` ; renvoie le
  **premier** document correspondant ou `Null`. 8 fichiers appelants.
- **`trouve(…)`** (privé) [nature : SQL]. Quatre variantes de `Select lind From Docs_Ged where
  type = &1 and code = &2 [and compte = &3] [and origin = &4]` selon que `compte`/`orig` sont vides.
- **`Supprime(Epur)`** [portée : nécessaire] : `delete` de `Docs_Ged` et `Docs_Tag` pour `$index`,
  puis `EpurationTags` si demandé. Le **fichier n'est pas supprimé** du disque (à confirmer comme
  voulu). ⚠️ `Articles.class:4126` appelle `LGed.Supprime(True)` sur l'auto-instance
  (`$index = 0`) : seule l'épuration des tags s'exécute (probablement `Lg.Supprime` voulu).

### Tags

- **`String2Array(Tagstring)`** / **`Array2String(Tagarray)`** [portée : nécessaire] [nature :
  calcul] : conversion liste ↔ chaîne séparée par des virgules, sans doublon ni vide (virgules
  retirées des tags). Fonctions pures, appelées en statique (`ObjFac`, `commande1`, `Edbr`,
  `Tresor`, `Saisecrit`, `ValidBR*`, `FClient`, `FFournisseur`).
- **`AddTag(Tag)`** [portée : nécessaire] [nature : SQL]. Cherche le tag dans `Fiches_Tag` ;
  absent → `insert` puis `Goto Tag_exists`. Ajoute à `$tags` et, si le document existe, `insert
  ignore into Docs_Tag`. ⚠️ `$tags.Add(Tag, lind)` sur une clé déjà présente (tag déjà porté par le
  document, ou ajouté deux fois) lève une erreur de collection (à confirmer). ⚠️ Si l'`insert`
  échoue sans exception, la boucle `Goto` est infinie. ⚠️ `insert ignore` est propre à MySQL (non
  traduit pour SQLite).
- **`AddTags(Tags)`** [portée : nécessaire] : `AddTag` pour chaque tag non vide.
- **`DelAllTag(Epur)`** [portée : nécessaire] : vide `$tags`, `delete from Docs_Tag` du document,
  épuration optionnelle. Appelants : `Edbr`, `commande1`, `ObjFac` (`lg.DelAllTag(False)`).
- **`DelTag(Tag, Epur)`** [portée : réductible — aucun appelant] : retire un tag.
- **`EpurationTags()`** [portée : nécessaire] [nature : SQL]. Supprime les tags « orphelins » :
  `Fiches_Tag` en `left join Docs_Tag left join Docs_Ged`, condition `d.lind is null or doc_lind is
  null or tag_lind is null`, puis un `delete` par ligne. ⚠️ Un tag utilisé par un document valide
  **et** référencé par une ligne `Docs_Tag` pointant vers un document supprimé est supprimé (la
  ligne pendante suffit) ; les lignes `Docs_Tag` orphelines ne sont jamais purgées (anomalie
  LGED-A03). Renvoie le nombre de lignes (un tag peut être compté plusieurs fois).
- **`EpurationDocs()`** [portée : nécessaire] : supprime de `Docs_Ged` les documents sans tag (les
  fichiers restent sur disque). Appelant : `GedR.PB_Epuration`.

### Fichiers et type MIME

- **`XdgMimeProc_Read()` / `CurlMimeProc_Read()`** [portée : nécessaire, événements de `Process`]
  [nature : calcul] : lisent la sortie de `xdg-mime` / `curl` dans `$mimeout`.
- **`Get_Mime(url)`** [portée : réductible] [nature : calcul + processus externe]. Fichier local :
  `Shell "xdg-mime query filetype " & path` ; URL http(s) : `Shell "timeout 5 curl -s -k -I …"`.
  Effet de bord : met à jour `$filename`. ⚠️ Chemin **non échappé** : un nom de fichier avec espace
  ou caractère spécial casse la commande (ou l'injecte dans le shell) ; `-k` désactive la
  vérification TLS.
- **`Get_Default_Extension(Ext)`** [portée : réductible] : extension du fichier copié/scanné, sinon
  déduite du MIME (table en dur), `pdf` par défaut.
- **`MoveURL(NewUrl)`** [portée : réductible] [nature : mixte]. Déplace un fichier local vers un
  autre chemin local (crée le répertoire). Renvoie `True` en cas d'**échec**. ⚠️ Met à jour
  `$url` avec `furl.Text` (contrôle) et non avec `NewUrl` (identiques pour l'unique appelant).
- **`Commit()`** [portée : réductible] [nature : mixte + SQL]. Nouveau document : `Insert into
  Docs_Ged …` puis `SELECT * FROM Docs_Ged WHERE lind = LAST_INSERT_ID()` (⚠️ MySQL seulement).
  Puis `DelAllTag(False)` et `AddTag` de chaque entrée de **`ListTags.List` (contrôle du
  formulaire)**, puis `update Docs_Ged …` (redondant après un `insert`). Pour un objet jamais affiché
  (`PDFDupli`), `ListTags` est vide : tous les tags du document sont supprimés, et les appelants les
  rajoutent ensuite (`Edbr`, `EcrAuto`, `ObjFac`, `commande1`).
- **`Ouvrir()`** [portée : nécessaire] : `Visualiseur.Prog` du fichier temporaire (scan/copie non
  enregistrés) ou de l'URL.
- **`Default_URL(FileName)`** [portée : réductible] [nature : mixte]. Construit
  `file://<racine>/<compte>/<année>/<origine>/<FT>_<code>_<tags…>.<ext>` ou
  `…/<FileName>.<ext>`. Si l'origine est vide, la fixe à `Docs`. ⚠️ `Replace(tag, " ", "_")` et
  `Replace(tag, ".", "_")` sont appelés **sans affectation** : sans effet (anomalie LGED-A04) ; le
  calcul de longueur compte `Base` deux fois. Lit `ListTags.List` (contrôle).
- **`PDFDupli(InFile, filename)`** [portée : nécessaire] [nature : calcul + fichiers + SQL] :
  URL par défaut, création du répertoire, copie du PDF, `Commit`. Renvoie 1 si la copie échoue.
  Appelants : `ObjFac:921`, `commande1:652`, `Edbr:238`, `EcrAuto:584`.

### Propriétés (privé)

- `TTC`, `HT` (`LPrix`), `DTE` (`LDate`), `ORI` (origine) : accesseurs directs.

### Fiche d'édition (handlers, intouchables)

- **`form_Open()`** : remplit les champs depuis l'état, `ftype` (5 types), validation des champs
  (`fcode.reg`, `fcompte.reg`, `fdte.Type = EstDateTime`…), tags dans `ListTags`. Origine
  modifiable seulement si vide.
- **`form_Close()`** : `EpurationTags()`.
- **`ftype_Change`**, **`fcode_Change`**, **`fcompte_Change`**, **`fMht_Change`**,
  **`fMttc_Change`**, **`fmime_Change`**, **`forigin_Change`** : recopient le contrôle dans l'état.
  `furl_Change` et `ListTags_Change` sont vides. ⚠️ **Aucun handler pour `fdte`** : une date
  modifiée dans la fiche n'est jamais reportée dans `$dte`, donc jamais enregistrée (anomalie
  LGED-A01).
- **`cptselect_Click()`** : sélection de compte via `TriCpt` (retour par `Bsel`/`Bval`).
- **`Existant_Click()`** : choix d'un tag existant via `TriGen` sur `select * from Fiches_Tag`.
- **`OuvrirB_Click()`** : `Ouvrir()`.
- **`Supprimer_Click()`** : confirmation puis `Supprime(False)` et fermeture.
- **`Enregistrer_Click()`** (CC 29, max du fichier) : contrôles de saisie (date, code, compte
  pour Clients/Fournisseurs, URL) ; si un fichier temporaire existe : remplacement du fichier cible
  (avec confirmation), suppression de l'ancien fichier, copie, nettoyage ; sinon déplacement si
  l'URL a changé (`MoveURL`) ; puis `Get_Mime`, `Commit`, affichage de l'index.
- **`Sortir_Click()`** : confirmation si un fichier temporaire non enregistré existe.
- **`ScannerFinalize()`** [portée : réductible] : copie `~/multipageproject.pdf` dans un fichier
  temporaire, propose de l'afficher, ajuste MIME et extension de l'URL.
- **`ScanGUI_Click()`** / **`ScanBatch_Click()`** : préparent `~/multipageproject/`, lancent
  `xsane` ou `scanimage` (ou les scripts `/Soc<XX>/scangui`, `scanbatch`), puis `convert` (ou
  `/Soc<XX>/scanconvert`) via `LScript`, puis `ScannerFinalize`. Commandes construites par
  concaténation (chemins non échappés).
- **`Copier_Click()`** : sélection d'un fichier via `LBox` (mode `FileSelect`) et `LTrans`,
  contrôle du MIME, copie dans un fichier temporaire. `Copy` sans `Try`.
- **`DefUrl_Click()`** : `furl.Text = Default_URL(furl.Text)`.
- **`Bsel`/`Bval`** (`Public`) : écrits par `TriCpt`/`TriGen` via `Object.SetProperty` :
  **nécessaires** (faux positif de `deps.py`).

## État global utilisé

- `Utils.db` ; tables `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` écrites **en dur** (les clés
  `Cbase.Table("TabDocGed")`, `"TabDocTag"`, `"TabTag"` existent).
- `Start.LocalSettings["/Soc" & Start.Societe & "/Factchemin*" | "/scandevice" | "/scangui" |
  "/scanbatch" | "/scanconvert"]`.
- `User.Home` (`~/multipageproject*`), `Temp$()`.
- Programmes externes : `xdg-mime`, `curl`, `timeout`, `xsane`, `scanimage`, `convert`.
- `Visualiseur.Prog`, `Utils.Mkdir_p`, `Utils.Rmdir_rf`, `LScript`, `ProgBar`, `TriCpt`, `TriGen`,
  `ObjProp`, `LBox`, `LTrans`, `LPrix`, `LDate`, `TextReg`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `trouve` : construire la clause `WHERE` avec `Utils.db.Subst` (une seule requête au lieu de
  quatre branches).
- `AddTag` : remplacer le `Goto` par une boucle bornée (deux tentatives) ; comportement identique
  dans le cas nominal.
- `Commit` : séparer l'insertion de l'`UPDATE` (l'`UPDATE` n'est utile que pour un document
  existant) — le résultat en base est identique.
- `Enregistrer_Click` (CC 29) : extraire `RemplaceFichier(source, cible) As String` (message
  d'erreur ou vide) et `ControleSaisie() As String` ; le handler conserve messages et ordre.

### Commonalisation avec d'autres fichiers

- **Gestion des tags dupliquée** dans [`GedR`](../GedR.class/architecture.md)
  (`SupprimerTags_Click`, `AjoutTags_Click`, requêtes directes sur `Docs_Tag`/`Fiches_Tag`) :
  GedR devrait passer par `AddTag`/`DelTag` (ou des variantes par lot) de `LGed`.
- **Séquence « Search → New si Null → PDFDupli → Supprime si échec → AddTags »** répétée dans
  `ObjFac:913-934`, `commande1:644-663`, `Edbr:230-249`, `EcrAuto:580-592` : candidat d'une méthode
  statique `LGed.Archive(type, origine, code, compte, pdf, nom, tags[])`.
- **Lecture de `tag_def`** des fiches client/fournisseur puis `AddTags(String2Array(…))` répétée
  dans `Saisecrit`, `Tresor`, `ValidBR`, `ValidBR1`, `ObjFac`, `commande1`, `Edbr` : helper
  `AddTagsTiers(code, estFournisseur)`.
- Lancement de scan (`ScanGUI_Click`/`ScanBatch_Click`) : blocs de préparation et de conversion
  identiques → helper privé.
- Chemins `file:///` ↔ `/` (`Replace(…, "file:///", "/")`, tests `Left(url, 8) = "file:///" Or
  Left(url, 1) = "/"`) répétés 10 fois : helpers privés `EstLocal(url)` et `Chemin(url)`.

### Réduction de portée

- `Exist`, `DelTag`, `Get_Mime`, `Get_Default_Extension`, `MoveURL`, `Commit`, `Default_URL`,
  `ScannerFinalize` : aucun appel externe (vérifié par `grep`). `Private` possible, sous réserve de
  couverture par les replays de la fiche et par `PDFDupli`.
- **Ne pas réduire** : `Bsel`/`Bval` (accès par `Object.SetProperty`), `XdgMimeProc_Read`,
  `CurlMimeProc_Read` (événements de `Process`).

### Séparation traitement / GUI

- `Commit` et `Default_URL` lisent `ListTags.List` : leur passer la liste de tags en paramètre
  (le handler fournit `ListTags.List`, `PDFDupli` fournit une liste vide) — comportement identique.
- `MoveURL` : utiliser `NewUrl` au lieu de `furl.Text` (identiques pour l'unique appelant).
- Ces trois points préparent l'extraction future d'une classe métier « document GED » sans
  fenêtre (hors périmètre de ce plan).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `Docs_Tag.doc_lind → Docs_Ged.lind` et `Docs_Tag.tag_lind → Fiches_Tag.lind` avec
  `ON DELETE CASCADE` : plus de lignes pendantes, épuration simplifiée (corrige structurellement
  LGED-A03).
- Index unique sur `Fiches_Tag.tag` et clé primaire `(doc_lind, tag_lind)` sur `Docs_Tag` (prérequis
  de `insert ignore` ; à vérifier dans `db_control.csv`).
- Index `(type, code, compte, origin)` sur `Docs_Ged` pour `trouve`.
