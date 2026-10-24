# Serveur — Architecture

> Source : `.src/Serveur.module`

## Vue d'ensemble

`Serveur` alimente un **« serveur de mise à jour » externe** (historiquement Thelia, commit
`5165796d` « Remplacement "Thelia" par "Serveur" », 2017) par des **fichiers texte d'échange**.
Chaque création, modification ou suppression d'article, famille, fournisseur, client, contact,
équivalence, code-barres, référence liée ou étiquette ajoute une ligne `;`-séparée à un fichier
`<Variables.Schmprix>/<Origine>_Serveur.txt`. Aucun fichier `*_Serveur.txt` n'est relu par Laurux :
le consommateur est un programme tiers. **Le format des lignes est donc un contrat externe** qui
doit rester identique à l'octet près.

Les appels sont tous conditionnés côté appelant par les préférences société (écran `Prefs`) :
`Variables.Sprix And Variables.Sexport And Variables.SMajArt` (ou `SMajFour`, `SMajCli`), lues une
fois au chargement de `Variables` depuis `/Soc<XX>/Sprix`, `/Sexport`, `/SMajArt`, `/SMajFour`,
`/SMajCli` ; le répertoire est `/Soc<XX>/Schmprix` (`Variables.module:4-8`).

Nature globale : **calcul / entrée-sortie**, sans GUI. Le module émet du SQL en lecture seule
(noms de table **en dur**, sans `Cbase.Table`) et écrit des fichiers.

Le mot « Serveur » ne désigne ni un processus ni une socket : il n'y a aucun échange
inter-processus actif, seulement un dépôt de fichiers dans un répertoire (partage réseau
possible, à confirmer auprès de l'utilisateur).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hfile` | var | Private | oui | File | 3 |
| `Filename` | var | Private | oui | String | 4 |
| `Lig` | var | Private | oui | String | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Pass` | 7-224 | Public | 90 | 204 | 9 |  |
| `Docs` | 226-272 | Public | 22 | 42 | 0 | portée réductible ? |
| `ReplaceFam` | 274-313 | Public | 29 | 37 | 0 | portée réductible ? |
| `convBStr` | 315-326 | Public | 2 | 9 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### `Pass(Origine, type, code, code2, Optional code3) As String`

[portée : nécessaire, 9 fichiers appelants, 44 appels] [nature : calcul (SQL + fichier)] (CC 90,
204 LOC). Douze blocs `If Origine = …` **indépendants** (pas de `Else If`), chacun sur le même
schéma :

1. `Filename = Variables.Schmprix & "/<Origine>_Serveur.txt"` ;
2. ouverture `For Read Write` si le fichier existe, sinon `For Write Create`, les deux sous `Try`
   (une erreur d'ouverture est ignorée, puis `Eof(hFile)` échoue sur un `hFile` nul ou fermé :
   erreur non interceptée remontée à l'appelant) ;
3. lecture de toutes les lignes jusqu'à `Eof` pour se placer en fin de fichier (`Lig` est écrasé à
   chaque ligne, jamais utilisé) ;
4. construction de la ligne `$Serveur`, `Print #hFile` (ajout d'un saut de ligne), `Close`.

`type` vaut `C` (création), `M` (modification), `S` (suppression), `P`/`G` (étiquettes) selon
l'appelant. La fonction est déclarée `As String` mais ne renvoie rien (`""`).

| Origine | Fichier | SQL émis (si `type <> "S"`) | Ligne écrite |
|---|---|---|---|
| `Art` | `Art_Serveur.txt` | `SELECT * FROM Fiches_Art where art_code = &1` | `type;code;` + 65 colonnes de `Fiches_Art` (dont `art_ect` deux fois, en 21ᵉ et dernière position) ; `S` : `S;code;code2;code3;` |
| `EQ` | `EQ_Serveur.txt` | — | `EQ;type;code;code2;` |
| `CB` | `CB_Serveur.txt` | — | `CB;type;code;code2;` |
| `Fam` | `Fam_Serveur.txt` | `SELECT * FROM Fiches_Fam where code_fam = &1` | `type;code;` + 30 colonnes, **sans `;` final** ; `S` : `S;code;` |
| `Four` | `Four_Serveur.txt` | `select * from Fiches_Four Left join Fiches_Comptes on compte_cc = fo_code where fo_code = &1` | `type;code;` + 38 colonnes dont `lettrable` (compte) ; `S` : `S;code;` |
| `ContactF` | `ContactF_Serveur.txt` | `select * from Fiches_ContactF where code = &1 and num = &2` | `type;code;num;` + 6 colonnes ; `S` : `S;code;num;` |
| `Cli` | `Cli_Serveur.txt` | `select * from Fiches_Cli Left join Fiches_Comptes on compte_cc = cli_code where cli_code = &1` | `type;code;` + 51 colonnes (dont `cli_typec` deux fois) ; **pas de cas `S`** : une suppression lirait un client absent |
| `ContactC` | `ContactC_Serveur.txt` | `select * from Fiches_ContactC where code = &1 and num = &2` | comme `ContactF` |
| `Stock` | `Stock_Serveur.txt` | — | `code;` — **aucun appelant** (bloc mort) |
| `Rpl1`, `Rpl2`, `Etiq` | `<Origine>_Serveur.txt` | — | `type;code;code2;` |

Points d'attention :
- **Pas de test `rResult.Available`** : si l'enregistrement n'existe pas (code supprimé entre-temps,
  faute de frappe), la lecture `rResult!champ` lève une erreur non interceptée chez l'appelant.
- Les valeurs `Null` sont concaténées en chaîne vide ; les montants et dates suivent la conversion
  implicite Gambas → String (format dépendant de la locale, à confirmer pour les `Float`).
- Aucune protection des `;` ou retours à la ligne contenus dans les champs (désignation, observations) :
  une ligne peut être cassée pour le consommateur.
- Tables en dur : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Comptes`, `Fiches_ContactF`,
  `Fiches_Cli`, `Fiches_ContactC` (règle AGENTS.md : passer par `Cbase.Table`).
- Le `SELECT *` avec jointure `Fiches_Comptes` sur `Four`/`Cli` ne sert qu'à lire `lettrable`.

### `Docs(Origine, type, compte, nomfichier, Etiq) As String`

[portée : réductible — **aucun appelant** (grep `Serveur.Docs`, `Docs(` sans résultat ; `deps.py`
ne le signale pas car le nom `Docs` apparaît en chaîne littérale ailleurs, par exemple
`LGed.class:469`)] [nature : calcul]. Même schéma que `Pass` pour `DocA_`, `DocF_`, `DocC_Serveur.txt`
(`type;compte;nomfichier;Etiq;`), mais **sans `Close`** : le fichier reste ouvert jusqu'à la
réaffectation suivante de `hFile`. **Code mort**.

### `ReplaceFam(mtt) As String`

[portée : réductible — **aucun appelant**] [nature : calcul]. Convertit un code famille : passage en
minuscules, insertion d'un `0` devant chaque chiffre entre les positions 3 et 10 (en modifiant la
variable de boucle `i` dans le `For`), puis remplacement de chaque lettre `a`…`z` par `10`…`35`.
**Code mort** (aucun appelant depuis au moins le commit initial du fichier, à confirmer dans
l'historique).

### `convBStr(bln) As String`

[portée : réductible — **aucun appelant**] [nature : calcul]. `False` → `"0"`, sinon `"1"`. **Code mort**.

## État global utilisé

- `Variables.Schmprix` (répertoire d'échange) ; les drapeaux `Variables.Sprix`, `Sexport`, `SMajArt`,
  `SMajFour`, `SMajCli` sont testés **par les appelants**, pas par le module.
- `Utils.db` (lecture).
- Variables de module `Private` : `hfile`, `Filename`, `Lig` — utilisées comme des locales
  (aucun état n'a besoin de survivre entre deux appels, sauf le fichier non fermé de `Docs`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les 12 blocs de `Pass` (et les 3 de `Docs`) autour d'un helper privé
  `AjouteLigne(sFichier As String, sLigne As String)` qui ouvre en ajout, écrit et ferme. Le
  remplacement de l'ouverture `Read Write` + lecture complète par `Open … For Append` donne le même
  contenu de fichier (à confirmer : comportement si le fichier ne se termine pas par un saut de
  ligne) et supprime une lecture intégrale à chaque appel.
- Construire les lignes `Art`, `Fam`, `Four`, `Cli` à partir d'une **liste ordonnée de colonnes**
  (`String[]`) jointe par `;`, en conservant les doublons (`art_ect`, `cli_typec`) et l'absence de
  `;` final de `Fam`. CC 90 → environ 15.
- `Pass` → table de correspondance `Origine` → (fichier, requête, colonnes), puis un seul chemin
  de code.
- Variables `hfile`, `Filename`, `Lig` → locales.

### Commonalisation avec d'autres fichiers

- Les 44 appels de 9 fichiers répètent la garde `Variables.Sprix And Variables.Sexport And
  Variables.SMaj…` ; un helper `Serveur.Actif(sDomaine As String) As Boolean` (domaines `Art`,
  `Four`, `Cli`) supprimerait la duplication. Appelants :
  [`Articles`](../Gestion/Tables/Articles.class/architecture.md),
  [`FClient`](../Gestion/Tables/FClient.class/architecture.md),
  [`FFournisseur`](../Gestion/Tables/FFournisseur.class/architecture.md),
  [`Famille`](../Gestion/Tables/Famille.class/architecture.md),
  [`Impart`](../Gestion/Stock/Tarifs/Impart.class/architecture.md),
  [`MajTarifM`](../Gestion/Stock/Tarifs/MajTarifM.class/architecture.md),
  [`MajTarifP`](../Gestion/Stock/Tarifs/MajTarifP.class/architecture.md),
  [`MajFbtarif2`](../Gestion/Stock/Tarifs/MajFbtarif2.class/architecture.md),
  [`MajEqu`](../Gestion/Stock/Tarifs/MajEqu.module/architecture.md).
- `convBStr` est l'inverse de `Utils.convBool` (`Utils.module:482`) : sans objet puisque la
  fonction est morte.

### Réduction de portée

- `Docs`, `ReplaceFam`, `convBStr` : aucun appelant → suppression (code mort) plutôt que `Private`.
- `Pass` reste `Public`.

### Séparation traitement / GUI

- Sans objet (aucune GUI). Séparer la **construction de la ligne** (fonction pure testable,
  `LigneServeur(Origine, type, code, code2, code3, rResult)`) de l'**écriture du fichier** faciliterait
  les tests gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer l'échange par fichiers par une table de journal des modifications
  (`Fiches_ServeurMaj` : origine, type, code, horodatage) lue par le serveur externe ; nécessite une
  évolution du consommateur.
