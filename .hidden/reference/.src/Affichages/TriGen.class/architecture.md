# TriGen — Architecture

> Source : `.src/Affichages/TriGen.class`

## Vue d'ensemble

`TriGen` est le **composant générique de liste filtrable et paginée** de Laurux. Ce n'est pas un
formulaire (pas de `.form`) ni une classe de base : il n'est **hérité par aucune classe**
(`Inherits TriGen` n'existe nulle part). Chaque écran l'**instancie** avec
`New TriGen(Parent, Col, Res, Req, Hauteur, ob, GroupBy) As "<Nom>"` et reçoit ses événements sous
le nom d'observateur choisi (`ColTri`, `TriGen`, `TriFou`, `TriBr`, `PanelGedDoc`, `coltri`,
`ColTriGenDoc`).

À la construction, `TriGen` crée **par code** dans le conteneur `Parent` (un `Panel` en général, ou
une fenêtre `Window` + `Form` créée à la volée si `Parent` est `Null`) :

- une ligne de champs de filtre `TextReg` (un par colonne, observateur `Filter`, chaînés au clavier
  par `Chainage`) ;
- une grille `GridView` (`Coltri`) remplie à la demande (`Coltri_Data`) depuis un `Result` paginé ;
- un compteur `ValueBox` (`Count`, numéro du premier enregistrement affiché) ;
- dans `_ready`, les boutons `Remonter`/`Descendre` (page précédente/suivante) et `Reset` (« Raz »).

La description des colonnes est une `Collection` d'[`ObjProp`](../../Utils/ObjProp.class/architecture.md)
(nom du champ SQL, libellé d'en-tête, tri initial `tri`, colonne clé `cle`, formats). La requête de
base `Req` (sans `WHERE`) est complétée à chaque rafraîchissement par les filtres saisis
(`LIKE "%…%"`), un filtre imposé par l'appelant (`ExtraSel`/`ExtraHave`), un `GROUP BY`, un tri et
un `LIMIT début, lg` (`DB_Incr`/`DB_Decr`).

### Protocole de retour de la sélection

1. `_new` mémorise l'objet de retour `Obj` (= `ob`, sinon `Parent`) et y **remet à zéro**
   `Bsel = False` et `Bval = Null` par `Object.SetProperty` (lignes 138-139).
2. Un clic ou Entrée sur la grille appelle `Close(valeur)` ; Échap appelle `Close(Null)`.
3. `Close` écrit `Bsel`/`Bval` sur `Obj` (`True` + valeur, ou `False` + `Null`), puis lève
   l'événement `MajSel(valeur)`. Si l'appelant fait `Stop Event`, la liste reste ouverte (sinon
   fermeture du `Form`/de la `Window`, ou destruction des contrôles créés dans le `Panel`).
4. La valeur est le texte de la **colonne 0** de la ligne, ou, si au moins une colonne est
   déclarée `cle`, une `Collection` {nom de champ → texte} des colonnes clés.

**Conséquence** : tout objet passé en `ob` (ou le `Parent` à défaut) doit exposer des membres
`Public Bsel` et `Public Bval` (sinon `Object.SetProperty` lève une erreur). Appelants vérifiés,
tous conformes : `TriArticles`, `TriCpt`, [`TriFacture`](../TriFacture.class/architecture.md),
[`GedR`](../../Utils/GedR.class/architecture.md), [`LGed`](../../Utils/LGed.class/architecture.md),
[`Pointage`](../../Compta/Pointage.class/architecture.md), `Visucmat`, `commande1` (`Bval` Variant),
`ValidBR1` (`Bval` Variant), `TarTypeCli`, `Articles`, `FClient`, `FFournisseur`, `TriTest`.
`Bval` reçoit une `Collection` chez les appelants à colonnes `cle` (`commande1:286-299`,
`ValidBR1:61-80`) : il y est déclaré `Variant` (comme chez `Pointage`, sans colonne `cle`).

### Événements levés vers l'appelant

| Événement | Levé par | Usage par l'appelant (annulable par `Stop Event`) |
|---|---|---|
| `MajSel(Bval)` | `Close` | valider/annuler la sélection ; sélection multiple (GedR, TriFacture, Pointage) |
| `Activate(Bval)` | `Coltri_Activate` (double-clic) | `ValidBR1.TriBr_Activate` |
| `Data(id, key, Data)` | `Coltri_Data` | coloration/formatage personnalisé (GedR, TriFacture, Pointage, ValidBR1) |
| `keyPress()` | `Coltri_KeyPress` | `TarTypeCli`, `commande1` |
| `Resize()` | F2 dans la grille | `Articles.ColTri_Resize` |
| `ReDim(w)` | `_ready` | `TriArticles`, `TriCpt` (largeur de la fenêtre) |
| `Raz()` | `Reset_Click` | GedR, TriFacture, Pointage |

### Sélection multiple

`TriGen` ne gère qu'une sélection simple. Les écrans [`GedR`](../../Utils/GedR.class/architecture.md),
[`TriFacture`](../TriFacture.class/architecture.md) et [`Pointage`](../../Compta/Pointage.class/architecture.md)
construisent une sélection multiple **au-dessus** : `TriGen_MajSel` mémorise la valeur et fait
`Stop Event` (la liste reste ouverte), `TriGen_Data` colore les lignes sélectionnées,
`TriGen_Raz` vide la sélection, et `GetAllFiltered()` renvoie toutes les lignes filtrées (sans
`LIMIT`) pour « tout sélectionner ».

**Banc d'essai** : le formulaire [`Tests/TriTest`](../../Tests/TriTest.class/architecture.md)
(« Test de la Classe TriGen », ajouté avec TriGen au commit `71fff6f2`) crée une TriGen en mode
`Panel` sur les articles, reçoit `MajSel` et teste `ExtraSel`. Il est considéré comme
l'implémentation d'un test de TriGen (décision utilisateur) et sera enrichi pour couvrir les
scénarios TRIGEN-T01 à T09 (TRITEST-002). Toute évolution de l'API de TriGen (`_new`, `ExtraSel`,
`Close`, `MajSel`, protocole `Bsel`/`Bval`) doit mettre TriTest à jour dans le même commit.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `NbEnreg` | var | Private |  | Integer | 5 |
| `Col_Def` | var | Private |  | Collection | 6 |
| `Col_Order` | var | Private |  | String[] | 7 |
| `FilterRegex` | var | Private |  | Collection | 8 |
| `Dbl` | var | Private |  | Boolean | 9 |
| `Request` | var | Private |  | String | 10 |
| `Tri` | var | Private |  | String | 11 |
| `Group` | var | Private |  | String | 12 |
| `Sel` | var | Private |  | String | 13 |
| `Having` | var | Private |  | String | 14 |
| `lg` | var | Private |  | Integer | 15 |
| `cl` | var | Private |  | Integer | 16 |
| `Coltri` | var | Private |  | GridView | 17 |
| `Colfil` | var | Private |  | TextReg[] | 18 |
| `Remonter` | var | Private |  | Button | 19 |
| `Descendre` | var | Private |  | Button | 20 |
| `Reset` | var | Private |  | Button | 21 |
| `Count` | var | Private |  | ValueBox | 22 |
| `Obj` | var | Private |  | Object | 23 |
| `Parent` | var | Private |  | Object | 24 |
| `CellHeight` | var | Private |  | Integer | 25 |
| `Win` | var | Private |  | Window | 26 |
| `Res` | var | Private |  | Result | 27 |
| `where` | var | Private |  | String | 28 |
| `has` | var | Private |  | String | 29 |
| `Extra_sel` | var | Private |  | String | 30 |
| `Extra_selcomb` | var | Private |  | String | 31 |
| `Extra_have` | var | Private |  | String | 32 |
| `Extra_havecomb` | var | Private |  | String | 33 |
| `xoffset` | var | Private |  | Integer | 34 |
| `policewidth` | var | Private |  | Integer | 35 |
| `prop` | var | Private |  | ObjProp | 36 |
| `$nup` | var | Private |  | Boolean | 37 |
| `MajSel` | event | Public |  |  | 39 |
| `Resize` | event | Public |  |  | 40 |
| `ReDim` | event | Public |  |  | 41 |
| `keyPress` | event | Public |  |  | 42 |
| `Raz` | event | Public |  |  | 43 |
| `Data` | event | Public |  |  | 44 |
| `Activate` | event | Public |  |  | 45 |
| `NoUp` | property | Public |  | Boolean | 47 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 50-165 | Public | 17 | 103 | 0 | méthode spéciale |
| `_ready` | 167-182 | Public | 1 | 14 | 0 | méthode spéciale |
| `Refresh_Height` | 184-207 | Public | 1 | 22 | 1 |  |
| `Show` | 209-219 | Public | 3 | 9 | 7 |  |
| `Close` | 221-255 | Public | 9 | 32 | 2 |  |
| `ExtraSel` | 257-264 | Public | 1 | 6 | 13 |  |
| `ExtraHave` | 266-273 | Public | 1 | 6 | 0 | portée réductible ? |
| `GroupBy` | 275-281 | Public | 1 | 5 | 2 |  |
| `Filter_GotFocus` | 283-290 | Public | 2 | 6 | 0 | handler GUI |
| `Filter_LostFocus` | 292-299 | Public | 2 | 6 | 0 | handler GUI |
| `GenFilter` | 301-327 | Public | 6 | 23 | 0 | portée réductible ? |
| `Filter_Change` | 329-337 | Public | 2 | 7 | 0 | handler GUI |
| `Filter_DblClick` | 339-349 | Public | 2 | 9 | 0 | handler GUI |
| `Filter_KeyPress` | 351-370 | Public | 7 | 16 | 0 | handler GUI |
| `Refresh_Data` | 372-377 | Public | 1 | 4 | 3 |  |
| `Coltri_Data` | 379-403 | Public | 8 | 21 | 0 | handler GUI |
| `Coltri_Click` | 405-425 | Public | 5 | 18 | 0 | handler GUI |
| `Coltri_KeyPress` | 428-468 | Public | 16 | 37 | 0 | handler GUI |
| `Coltri_MouseWheel` | 470-480 | Public | 5 | 9 | 0 | handler GUI |
| `Coltri_Scroll` | 483-495 | Public | 2 | 9 | 0 | handler GUI |
| `Coltri_Activate` | 497-517 | Public | 5 | 18 | 0 | handler GUI |
| `Descendre_Click` | 519-529 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 531-539 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 541-549 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 551-559 | Public | 5 | 7 | 0 | handler GUI |
| `Reset_Click` | 561-578 | Public | 3 | 14 | 0 | handler GUI |
| `Count_Change` | 580-589 | Public | 2 | 8 | 0 | handler GUI |
| `GetAllFiltered` | 591-616 | Public | 7 | 19 | 4 |  |
| `Update` | 618-652 | Public | 8 | 21 | 9 |  |
| `DB_Incr` | 654-676 | Public | 7 | 19 | 0 | portée réductible ? |
| `DB_Decr` | 678-698 | Public | 7 | 17 | 0 | portée réductible ? |
| `imprime` | 700-745 | Public | 5 | 43 | 0 | portée réductible ? |
| `FontSize` | 747-764 | Public | 3 | 13 | 4 |  |
| `NoUp_Read` | 767-771 | Private | 1 | 3 | 0 |  |
| `NoUp_Write` | 773-792 | Private | 4 | 17 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et mise en page

- **`_new(Par, Col, Resu, Req, Height, [ob], [GroupB])`** [portée : nécessaire (spéciale)]
  [nature : GUI] (CC 17, 103 LOC). Si `Par` est `Null` : crée une `Window` 800×480 et un `Form`
  enfant ; sinon **supprime tous les enfants** du conteneur (`Try ObjPan.Delete`), ce qui permet
  de reconstruire la liste dans le même `Panel` (`TriCpt`, `TriArticles.CB1_Click`). Crée la grille,
  un `TextReg` par colonne (largeur = libellé + icône), les enregistre dans `ObjProp.filter`, fixe
  le tri initial (premier `ObjProp`, ou celui marqué `tri`), crée `Count`, remet `Bsel`/`Bval` de
  `Obj` à zéro, centre et instrumente (`Utils.Observers`) seulement si `Parent` n'est pas un
  `Panel`. `GroupB` est implicitement optionnel (après `Optional ob`). `Resu` sert seulement à
  initialiser `Res` : le premier affichage vient de la requête relancée par `_ready`.
  Variables locales `ch` (chaînage clavier conservé par ses observateurs) et `i`, `offset`.
- **`_ready()`** [nécessaire (spéciale)] [GUI] : appelée par l'interpréteur après `_new` ; lève
  `ReDim(largeur)`, crée `Remonter`/`Descendre`/`Reset`, puis `Refresh_Height()` (premier
  `Update()`, donc **première requête**).
- **`Refresh_Height()`** [nécessaire : `Articles:686`] [GUI] : hauteur de la grille, `lg` (lignes
  par page = hauteur / hauteur de ligne − 1), position des boutons et du compteur, puis `Update()`.
- **`Show([Modal])`** [nécessaire : `TriCpt`, `Articles`, `FClient`, `FFournisseur`, `LGed`,
  `ValidBR1`, `Visucmat`] [GUI] : affiche la `Window` créée quand `Parent` est `Null` ; **sans effet**
  quand la liste est dans un `Panel` (cas de `TriCpt.tricond`, `ValidBR1`, `Visucmat`,
  `Articles:4456`, `FClient:3080`, `FFournisseur:2584`).
- **`FontSize(Increment)`** [nécessaire : `GedR`, `Pointage`, `FClient`, `FFournisseur`] [GUI] :
  ajoute `Increment` à la police de la grille et des filtres. La variable `fts` (lue sur `Parent`
  ou `Me.Font`) n'est jamais utilisée ; la branche `Me.Font` n'a pas de sens pour une classe non
  graphique (jamais atteinte : `Parent` est toujours renseigné).
- **`NoUp_Read` / `NoUp_Write`** (propriété `NoUp`) [nécessaire : `GedR:261-264`] [GUI] : suspend
  les rafraîchissements (`Update` s'arrête avant la requête) et verrouille (`Object.Lock`) les
  `ObjProp`, leurs filtres et la grille. `Object.Lock(Coltri)` est répété à chaque tour de boucle.

### Filtres

- **`Filter_GotFocus` / `Filter_LostFocus`** [handler] [GUI] : efface le libellé d'en-tête
  (`Tag`) à l'entrée, le remet à la sortie si le champ est vide ; chacun relance `Update()` (une
  requête à chaque passage de focus).
- **`Filter_Change`** [handler] [GUI] : met à jour `FilterRegex[Tag]` puis `GenFilter()`.
- **`GenFilter()`** [portée : réductible] [nature : mixte] : construit `Sel` (et `Having` pour les
  champs dont le nom contient `parse_having_`) sous la forme `champ like "%texte%" and …`, après
  suppression des guillemets doubles ; `NbEnreg = 0` ; `Update()`. **Le texte saisi est concaténé
  dans le SQL** : `\`, `%`, `_` ne sont pas neutralisés (TRIGEN-A02). Partie extractible :
  `ConstruitFiltre(FilterRegex, Col_Def) As String[]` (pure).
- **`Filter_DblClick`** [handler] [GUI] : inverse le sens (`Dbl`) et trie sur la colonne du champ.
- **`Filter_KeyPress`** [handler] [GUI] : Ctrl+P imprime, Échap ferme (`Close(Null)`), flèche bas
  passe dans la grille.
- **`Reset_Click`** [handler] [GUI] : lève `Raz` (annulable), remet libellés et filtres à vide, tri
  et sens initiaux, `GenFilter()`.
- **`ExtraSel(Req, Comb)`** [nécessaire : 13 fichiers] [mixte] : filtre imposé par l'appelant
  (`Extra_sel`) et opérateur de combinaison avec les filtres saisis (`Comb`, `"and"`/`"AND"`/`""`) ;
  `NbEnreg = 0` ; `Update()` (une requête).
- **`ExtraHave(Req, Comb)`** [portée : réductible] — **code mort** (signal `unused` vérifié :
  aucun appel dans `.src`). Même rôle pour la clause `HAVING`.
- **`GroupBy(Grp)`** [nécessaire : `GedR`, `ValidBR1`] [mixte] : remplace la clause `GROUP BY`
  (l'appelant doit fournir le mot-clé `GROUP BY` ; le constructeur, lui, l'ajoute). `Update()`.

### Requêtes et pagination

- **`Update()`** [nécessaire : 9 fichiers] [mixte] : borne `NbEnreg` à 0, l'affiche dans `Count`,
  calcule les mots-clés `where`/`having`, puis (sauf `NoUp`) `DB_Decr()` ou `DB_Incr()` selon
  `Dbl`. Écrire `Count.Value` lève probablement `Count_Change`, qui rappelle `Update()` : double
  requête possible quand `NbEnreg` change (à confirmer en phase 2 avec la trace `Exec_SQL`).
- **`DB_Incr()` / `DB_Decr()`** [portée : réductible] [mixte] : `Utils.db.Exec(Request & where &
  Extra_sel & " " & comb & " " & Sel & " " & Group & " " & has & … & " order by " & Tri [desc] &
  " limit " & NbEnreg & ", " & lg)` ; tout est concaténé (requête sans `&N`). Fixe
  `Coltri.Rows.Count = Res.Count`. ⚠️ Si la requête renvoie **0 ligne**, le nombre de lignes de la
  grille n'est **pas** remis à 0 (les anciennes lignes restent affichées vides et cliquables) ;
  `DB_Decr` ne le remet pas non plus à 0 quand le `Result` n'est pas disponible (TRIGEN-A01). Les
  deux fonctions ne diffèrent que par `desc`.
- **`GetAllFiltered() As Result`** [nécessaire : `GedR`, `TriFacture`, `Pointage`, `ValidBR1`]
  [mixte] : même requête **sans `LIMIT`**, curseur souris « attente » pendant l'exécution.
- **`Refresh_Data()`** [nécessaire : `GedR`, `TriFacture`, `Pointage`] [GUI] : `Refresh` de la
  grille et `Wait 0.001` (traitement des événements en attente).
- **`Coltri_MouseWheel`** [handler] [GUI] : page suivante si la page est pleine, sinon page
  précédente (`Coltri.Rows.Count <= lg` est toujours vrai) ; `Update()`.
- **`Descendre_Click` / `Remonter_Click`** [handler] [GUI] : page suivante (si pleine) /
  précédente, curseur en première ligne. **`Descendre_KeyPress` / `Remonter_KeyPress`** : Échap/F2
  ferme, PageUp/PageDown.
- **`Count_Change`** [handler] [GUI] : saisie directe du premier enregistrement à afficher.
- **`Coltri_Scroll`** [handler] [GUI] : décale horizontalement les champs de filtre avec la grille.

### Affichage et sélection

- **`Coltri_Data(Row, Column)`** [handler] [GUI] (CC 8) : `Res.MoveTo(Row)`, texte du champ, lève
  `Data(id, clé de colonne, Data)` (si annulé, pas de format), applique les formats de l'`ObjProp`,
  fond `bgcolor` si le champ existe dans le résultat, sinon alternance blanc / fond. `Frmt` et
  `Frmt2` sont déclarés et jamais utilisés.
- **`Coltri_Click`** [handler ; non rejoué : `TriGen` n'a pas de `.form`] [GUI] : construit la
  valeur (colonne 0 ou `Collection` des colonnes `cle`) et `Close(valeur)`. Variable `cle` inutile.
- **`Coltri_Activate`** [handler] [GUI] : même construction, lève `Activate(valeur)` sans fermer.
  Duplication exacte du corps de `Coltri_Click`.
- **`Coltri_KeyPress`** [handler] [GUI] (CC 16) : lève `keyPress` (annulable) ; Ctrl+P imprime ;
  Entrée sélectionne ; flèche haut en première ligne / bas en dernière ligne = page
  précédente/suivante ; PageUp/PageDown ; F2 lève `Resize` puis `Refresh_Height` ; Échap ferme.
- **`Close(Selected_Value)`** [nécessaire : `Articles:4753`, `TarTypeCli:227`] [mixte] : protocole
  décrit plus haut. En mode `Panel`, détruit boutons, filtres et grille mais **pas** le compteur
  `Count` (il reste dans le panneau jusqu'à la reconstruction suivante, qui vide le conteneur).
  Une valeur sélectionnée vide (`""`, colonne 0 vide) est traitée comme une annulation.
- **`imprime()`** [portée : réductible] [GUI] : aperçu `Report` (en-têtes = textes des filtres,
  largeurs proportionnelles sur 220 mm) des lignes de `Res`, c'est-à-dire de la **page affichée
  seulement** (le `Result` porte le `LIMIT`). Sur un résultat vide, `Repeat … Until MoveNext()`
  exécute une fois le corps avec `Res.Index` invalide (erreur probable, TRIGEN-A03). La variable
  locale `obj` masque le membre `Obj` (identifiants insensibles à la casse).

## État global utilisé

- `Utils.db` (toutes les requêtes) ; `Utils.Observers(Parent)` si la liste est dans une fenêtre.
- Aucun `Start.*` ni `Variables.*` : `TriGen` est indépendant du paramétrage société.
- État d'instance : `Res` (page courante), `NbEnreg`/`lg` (pagination), `Tri`/`Dbl` (tri),
  `Sel`/`Having`/`Extra_*`/`Group` (filtres), `Obj` (destinataire de `Bsel`/`Bval`).
- `Create Static` (ligne 3) : inutile, aucun accès statique `TriGen.membre` n'existe ; il crée
  seulement une auto-instance si un tel accès apparaissait.

## Propositions d'amélioration

### Réécriture / refactorisation

- `DB_Incr`, `DB_Decr` et `GetAllFiltered` : une seule fonction privée `Requete(bDesc, bLimite)
  As String` (texte SQL identique, espaces compris), utilisée par les trois.
- `Coltri_Click` / `Coltri_Activate` : `ValeurLigne() As Variant` commune.
- Supprimer les variables inutilisées (`Frmt`, `Frmt2`, `cle`, `fts`) et `ExtraHave`.
- `NoUp_Write` : sortir `Object.Lock(Coltri)` de la boucle (même effet).

### Commonalisation avec d'autres fichiers

- **Pagination** : `TriGen` porte déjà la logique `NbEnreg`/`lg`/molette/PageUp/PageDown que
  dupliquent [`Tricp`](../Tricp.class/architecture.md), [`TriMat`](../TriMat.class/architecture.md),
  [`TriEqu`](../TriEqu.class/architecture.md), `TriFac`, `TriBl`,
  [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md) et
  [`TriclientsD`](../../Caisse/Affichages/TriclientsD.class/architecture.md). Ces écrans ont leurs
  contrôles dans le `.form` (intouchable) : on ne peut pas les remplacer par `TriGen`. La classe
  d'aide `PaginationListe` proposée par TRICARTES-005 doit reprendre **le comportement de
  `TriGen`** comme référence (bornage à 0, page pleine) ; `TriGen` lui-même peut l'utiliser en
  interne.
- **Sélection multiple** (GedR, TriFacture, Pointage) : les trois écrans répètent `TriGen_MajSel`
  + `Stop Event`, `TriGen_Data` (coloration) et `TriGen_Raz`. Un mode optionnel de `TriGen`
  (ou une classe `TriSelection`) éviterait la triple duplication (voir POINTAGE-005) ; les
  handlers des appelants restent, réduits à un appel.

### Réduction de portée

- `ExtraHave` (mort, à supprimer), `GenFilter`, `DB_Incr`, `DB_Decr`, `imprime` : aucun appelant
  externe (vérifié par `grep` ; `commande1.imprime` est une autre classe) → `Private`.
- Les autres méthodes `Public` sont appelées par les écrans listés ci-dessus. Les handlers
  (`Filter_*`, `Coltri_*`, `Remonter_*`, `Descendre_*`, `Reset_Click`, `Count_Change`) restent
  `Public`.

### Séparation traitement / GUI

- `GenFilter` : construction de `Sel`/`Having` en fonction pure (testable en gbtest).
- `Requete(bDesc, bLimite)` : texte SQL pur, testable sans base ni contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La pagination par `LIMIT début, n` relit et trie toute la sélection à chaque page ; sur les
  grosses tables (`Fiches_Art`, `Docs_Ged`, écritures), des index sur les colonnes de tri usuelles
  (`art_design`, `intitule_cc`…) accéléreraient l'affichage. `LIKE "%…%"` n'utilise aucun index :
  une recherche plein texte serait nécessaire pour les filtres.
