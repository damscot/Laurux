# GedR — Architecture

> Source : `.src/Utils/GedR.class` · Formulaire : `.src/Utils/GedR.form`

## Vue d'ensemble

`GedR` est l'**écran de recherche et de gestion en masse de la GED** (menu principal →
`Fmenu.class:2366`, `GedR.Show()`). Il affiche, dans un `TriGen` placé sur `Panel1`, la liste des
documents (`Docs_Ged` joint à `Docs_Tag` et `Fiches_Tag`, regroupés par document avec la liste de
leurs tags en `GROUP_CONCAT`), filtrable par type (boutons radio du groupe `Select`) et par tags
(`TextBox1`, valeurs séparées par des virgules). L'utilisateur construit une **sélection multiple**
(`Selected`, identifiants `doc_lind`) par clic ou par « tout sélectionner / désélectionner le
filtré », puis :
- ouvre les documents (`LGed.Ouvrir`) ou en édite un (`LGed` en modal) ;
- supprime les documents sélectionnés (puis épuration globale) ;
- remplace la base commune de leurs URL (`UPDATE … REPLACE(url, …)`, sans déplacer les fichiers) ;
- retire ou ajoute des tags en masse (dialogues [`LBox`](../LBox.class/architecture.md) +
  [`LTrans`](../LTrans.class/architecture.md)).

Nature globale : **GUI**, avec du SQL direct dans plusieurs handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tableau` | var | Private |  | String[] | 3 |
| `tr` | var | Private |  | TriGen | 4 |
| `Col` | var | Private |  | Collection | 5 |
| `Obj` | var | Private |  | Object | 6 |
| `Bsel` | var | Public |  | Boolean | 7 |
| `Bval` | var | Public |  | String | 8 |
| `List` | var | Public |  | String[] | 9 |
| `CB1Conv` | var | Private |  | Collection | 10 |
| `Selected` | var | Private |  | String[] | 11 |
| `seltags` | var | Private |  | String[] | 12 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 16-33 | Public | 1 | 13 | 0 | méthode spéciale |
| `Button2_Click` | 35-39 | Public | 1 | 3 | 0 | handler GUI |
| `TextBox1_Change` | 41-45 | Public | 1 | 3 | 0 | handler GUI |
| `CB1_Click` | 47-51 | Public | 1 | 3 | 0 | handler GUI |
| `Select_Click` | 53-57 | Public | 1 | 3 | 0 | handler GUI |
| `SelectAllFil_Click` | 59-76 | Public | 4 | 15 | 0 | handler GUI |
| `DeSelectAllFil_Click` | 78-95 | Public | 4 | 15 | 0 | handler GUI |
| `Ouvrir_Click` | 97-113 | Public | 3 | 14 | 0 | handler GUI |
| `PB_Epuration` | 115-130 | Public | 1 | 13 | 0 | portée réductible ? |
| `Supprimer_Click` | 132-151 | Public | 3 | 16 | 0 | handler GUI |
| `Editer_Click` | 153-168 | Public | 3 | 11 | 0 | handler GUI |
| `Button1_Click` | 173-177 | Public | 1 | 3 | 0 | handler GUI |
| `Filter_Calc` | 179-217 | Private | 11 | 33 | 0 |  |
| `Update_Req` | 219-269 | Public | 2 | 44 | 0 | portée réductible ? |
| `TriGen_MajSel` | 273-295 | Public | 4 | 19 | 0 | handler GUI |
| `TriGen_Raz` | 297-302 | Public | 1 | 4 | 0 | handler GUI |
| `TriGen_Data` | 304-315 | Public | 2 | 7 | 0 | handler GUI |
| `Selcnt_MouseDown` | 317-321 | Public | 1 | 2 | 0 | handler GUI |
| `ChangerUrl_Click` | 323-403 | Public | 20 | 70 | 0 | handler GUI |
| `SupprimerTags_Click` | 405-467 | Public | 14 | 53 | 0 | handler GUI |
| `AjoutTags_Click` | 469-507 | Public | 9 | 33 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et liste

- **`_New()`** [portée : nécessaire] [nature : GUI]. Centre, remplit `CB1` (colonne variable :
  tags, nom de fichier ou URL) et la table de correspondance `CB1Conv` (libellé → champ), vide la
  sélection, `Update_Req()`.
- **`Update_Req()`** [portée : réductible] [nature : mixte, SQL]. Exécute une première requête
  limitée à une ligne pour obtenir les `ResultField` et décrire 8 colonnes (`ObjProp`), puis crée un
  nouveau `TriGen(Panel1, …, Me) As "TriGen"` sur la requête complète
  `select *, GROUP_CONCAT(tag SEPARATOR ',') as parse_having_tags from Fiches_Tag inner join
  Docs_Tag … inner join Docs_Ged …` avec `group by doc_lind`, applique le filtre et rafraîchit.
  ⚠️ `GROUP_CONCAT(… SEPARATOR …)` est propre à MySQL (SQLite : `group_concat(tag, ',')`), non
  traduit par `DB_Connection` (anomalie GEDR-A01). Si la base GED est vide, la fonction sort sans
  créer la liste. `TriGen` supprime les anciens enfants de `Panel1` : pas d'empilement.
- **`Filter_Calc()`** (privé) [nature : calcul]. Construit le filtre :
  `type = "<n>"` selon le bouton radio, puis `(tag like "%t1%" or tag like "%t2%" …)`.
  ⚠️ Les tags saisis sont **concaténés** dans le SQL entre guillemets doubles : un `"` casse la
  requête (et permet une injection) (anomalie GEDR-A02). Transmis par `tr.ExtraSel`.
- **`TextBox1_Change()`**, **`Select_Click()`** (groupe des boutons radio), **`CB1_Click()`**
  [nature : GUI] : `Filter_Calc()` ou `Update_Req()`.

### Sélection multiple

- **`TriGen_MajSel(val)`** [nature : GUI] : bascule `val` dans `Selected` si `Bsel` (positionné
  par `TriGen` via `Object.SetProperty`), met à jour le compteur et la liste, remet `Bsel` à
  `False`. `Val = ""` affecte le **paramètre** (sans effet) — probablement `Bval = ""` voulu.
  `Stop Event`.
- **`TriGen_Raz()`** : vide la sélection.
- **`TriGen_Data(id, key, Data)`** : fond « sélectionné » pour les lignes de `Selected`.
- **`SelectAllFil_Click()`** / **`DeSelectAllFil_Click()`** : ajoutent / retirent tous les
  documents du filtre courant (`tr.GetAllFiltered()`).
- **`Selcnt_MouseDown()`** : vide.

### Actions

- **`Ouvrir_Click()`** [nature : mixte, SQL] : pour chaque document sélectionné, vérifie son
  existence (`select * from Docs_Ged where lind = &1`, redondant avec le chargement de `LGed`),
  puis `New LGed(Null, idx).Ouvrir()`.
- **`Editer_Click()`** : un seul document → `LGed` en modal, puis `Update_Req()`.
- **`Supprimer_Click()`** [nature : mixte] : ⚠️ **aucune confirmation** ; pour chaque document,
  `New LGed(Null, idx).Supprime(False)` (barre de progression interruptible), puis
  `PB_Epuration()` et `Update_Req()`.
- **`PB_Epuration()`** [portée : réductible] : vide la sélection, `LGed.EpurationTags()` puis
  `LGed.EpurationDocs()` — épuration **globale** (tous les documents sans tag, pas seulement la
  sélection).
- **`ChangerUrl_Click()`** (CC 20, max du fichier) [nature : mixte, SQL]. Exige au moins deux
  documents et une confirmation ; calcule le plus long préfixe commun des URL (comparaison
  caractère par caractère via `Left`), le réduit au répertoire, demande la partie à remplacer puis
  la nouvelle valeur (deux `LBox` en mode `TextReg`, chemins se terminant par `/`), puis
  `update Docs_Ged set url = REPLACE(url, &2, &3) where lind = &1` par document.
  ⚠️ `REPLACE` remplace **toutes** les occurrences dans l'URL, pas seulement le préfixe (anomalie
  GEDR-A03).
- **`SupprimerTags_Click()`** [nature : mixte, SQL] : collecte les tags des documents sélectionnés,
  sélection via `LBox` (`ListView`), puis pour chaque tag `Delete from Docs_Tag where doc_lind in
  (<200 ids max par lot>) and tag_lind = &1` (identifiants concaténés : valeurs numériques issues de
  la base), puis épuration et rafraîchissement. Variable locale `seltags` qui masque le membre
  privé du même nom (inutilisé).
- **`AjoutTags_Click()`** [nature : mixte] : saisie de tags via `LBox` (`ListEditor`), puis pour
  chaque document **et pour chaque tag** `New LGed(Null, idx).AddTag(tag)` (un objet `LGed` — donc
  une fenêtre non affichée et 2 requêtes de chargement — par couple document × tag). Hérite de
  l'anomalie LGED-A02 si le document porte déjà le tag.
- **`Button1_Click()`** : aide HTML `Doc.Open("Ged")`. **`Button2_Click()`** : fermeture.

## État global utilisé

- `Utils.db` ; tables `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` écrites **en dur** (clés `Cbase`
  `TabDocGed`, `TabDocTag`, `TabTag` disponibles).
- `LGed` (constantes de type, épurations, objets), `TriGen`, `ObjProp`, `ProgBar`, `LBox`,
  `LTrans`, `TextReg`, `Doc`.
- Membres `Public` : `Bsel`/`Bval` (écrits par `TriGen` via `Object.SetProperty`), `List`
  (inutilisé). Membres privés inutilisés : `Tableau`, `Obj`, `seltags`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `AjoutTags_Click` : créer **un** `LGed` par document puis `AddTags(seltags)` (mêmes écritures en
  base, moins d'objets).
- `Ouvrir_Click` : supprimer la requête d'existence redondante (garder le message si le document
  n'est pas trouvé : tester `lg` après chargement) — à valider car l'ordre des requêtes du log
  change (diff `Exec_SQL`).
- `ChangerUrl_Click` : fonction pure `PrefixeCommun(urls As String[]) As String`.
- Supprimer `Tableau`, `Obj`, le membre `seltags`, le `Public List` inutilisés.

### Commonalisation avec d'autres fichiers

- **Sélection multiple sur `TriGen`** (`Selected`, `Selcnt`, `SelectAllFil_Click`,
  `DeSelectAllFil_Click`, `TriGen_MajSel`, `TriGen_Data`, `TriGen_Raz`) dupliquée dans
  [`TriFacture`](../../Affichages/TriFacture.class/architecture.md) et
  [`Pointage`](../../Compta/Pointage.class/architecture.md) : candidat d'une option de sélection
  multiple dans [`TriGen`](../../Affichages/TriGen.class/architecture.md) ou d'une classe d'aide
  commune (phase 3).
- **Opérations de tags** : `SupprimerTags_Click` réécrit en SQL direct ce que fait
  `LGed.DelTag` ; proposer `LGed.DelTagLot(tag, docs[])` / `LGed.AddTagLot(tag, docs[])` dans
  [`LGed`](../LGed.class/architecture.md).
- Filtre par type : les constantes `LGed.<type>` sont concaténées entre guillemets ; utiliser
  `Utils.db.Subst("type = &1", …)`.

### Réduction de portée

- `Update_Req`, `PB_Epuration` : internes → `Private`.
- `Select_Click` : **nécessaire** (handler du groupe `Select` des boutons radio : faux positif).
- `Bsel`/`Bval` : **nécessaires** (accès dynamique de `TriGen`). `List` : code mort.

### Séparation traitement / GUI

- Extraire les écritures SQL (`ChangerUrl`, `SupprimerTags`) dans des fonctions privées sans accès
  aux contrôles : `RemplaceUrl(ids, ancien, nouveau)`, `RetireTag(tag, ids)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les mêmes que pour [`LGed`](../LGed.class/architecture.md) : clés étrangères avec cascade, index
  sur `Fiches_Tag.tag`, clé `(doc_lind, tag_lind)`.
- Stocker séparément la racine et le chemin relatif des documents (`url` = racine + relatif)
  rendrait `ChangerUrl` inutile (changement de racine par paramètre).
