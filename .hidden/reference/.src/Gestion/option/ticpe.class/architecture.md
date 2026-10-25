# ticpe — Architecture

> Source : `.src/Gestion/option/ticpe.class`

## Vue d'ensemble

`ticpe` est une **ébauche** d'objet de règle TICPE (taxe intérieure de consommation sur les
produits énergétiques, ex-TIPP) pour l'option carburants : catégories `GnrAgri` (« GNR détaxé »,
gazole non routier agricole) et `Carburant`, adresse de référence (`Adlivraison`/`Adcli`),
propriétés prévues `date`, `NumAgri`, `NumCarb`, `region`. Le commentaire de
`modfichier.fichiercarbu` (« modif juillet 24 ticpe agri ») et la table `Art_Tipp` (`code`,
`ticpe` = catégorie de l'article) en sont la contrepartie en base.

Classe `Create Static` sans formulaire : `ticpe(client)` (`_call`) fabrique une instance pour un
client donné par son code (`String`) ou par un `Result` déjà lu (fiche client ou adresse de
livraison).

**Aucun appelant dans le projet** (vérifié par `grep`) : `Parametre.class:626-682` gère la
colonne `ticpe` d'`Art_Tipp` mais cite `ticpe(Null).categorie` seulement en commentaire (« ne
fonctionne pas, renvoi erreur paramètre manquant ») et code la liste en dur. La règle métier
n'est donc pas implémentée : rien n'est calculé.

Nature globale : **calcul + SQL** (ébauche).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `GnrAgri` | enum | Public | oui |  | 5 |
| `Carburant` | enum | Public | oui |  | 5 |
| `Adlivraison` | enum | Public | oui |  | 6 |
| `Adcli` | enum | Public | oui |  | 6 |
| `$categorie` | var | Private |  | String[] | 7 |
| `$adr` | var | Private |  | Integer | 9 |
| `$val` | var | Private |  | Boolean | 10 |
| `$rcli` | var | Private |  | Result | 11 |
| `date` | property | Public |  | LDate | 13 |
| `NumAgri` | property | Public |  | String | 14 |
| `NumCarb` | property | Public |  | String | 15 |
| `region` | property | Public |  | String | 16 |
| `categorie` | property | Public |  | String[] | 17 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 19-35 | Public | 5 | 14 | 0 | méthode spéciale |
| `_call` | 37-44 | Public | 1 | 5 | 0 | méthode spéciale |
| `Valide` | 46-55 | Public | 2 | 6 | 0 | portée réductible ? |
| `categorie_Read` | 57-61 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(client As Variant)`** [portée : nécessaire (constructeur)] [nature : calcul]. Sort si
  `client` est `Null` ; si `String` : `SELECT * FROM Fiches_Cli WHERE cli_code = &1`,
  `Error.Raise("Client innexistant")` si absent ; sinon prend le `Result` tel quel. `$adr` =
  `Adcli` si le résultat a une colonne `cli_code`, sinon `Adlivraison`. `$adr` n'est jamais relu.
- **`_call(client)`** [portée : nécessaire (fabrique)] : `New Ticpe(client)`. Sur l'auto-instance
  `Create Static`, `_new` est d'abord appelé sans argument : `client` obligatoire manquant, d'où
  l'erreur « paramètre manquant » rapportée dans `Parametre.class:630` (explication probable, à
  confirmer).
- **`Valide(art)`** [portée : réductible, `unused`] [nature : calcul]. ⚠️ SQL erroné :
  `"… WHERE art_code=&1,art"` — la virgule et `art` sont **dans** la chaîne et aucun argument n'est
  passé : la requête est invalide ; le bloc `If res.Available` est vide. Code mort.
- **`categorie_Read()`** : renvoie `["GNR détaxé", "Carburant"]`.
- Propriétés `date`, `NumAgri`, `NumCarb`, `region` (`Use $dtval`, `$numa`, `$numc`, `$regi`) :
  jamais alimentées (toujours `Null`/`""`). `$val` : jamais utilisée.

## État global utilisé

- `Utils.db.Exec`. Tables `Fiches_Cli`, `Art_Tipp` (créée par `modfichier.fichiercarbu`, absente de
  `db_control.csv`), `Fiches_Art`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Valide` et `$val` (morts) ; documenter l'état d'ébauche.
- `_new(Optional client)` permettrait l'auto-instance (et donc `ticpe(Null).categorie` dans
  `Parametre`) : c'est une évolution, à décider par l'utilisateur.

### Commonalisation avec d'autres fichiers

- La liste des catégories est dupliquée en dur dans `Parametre.class:648` : une fois `ticpe`
  utilisable, `Parametre` devrait lire `ticpe.categorie`.

### Réduction de portée

`Valide` → suppression (code mort).

### Séparation traitement / GUI

Sans objet.

### Requêtes signalées par `sql_params` (après le lot Gestion-2)

- l. 50 : `",art"` est à l'intérieur de la chaîne SQL au lieu d'être un argument (signal `sql_params`) : erreur SQL à l'exécution ; sans effet tant que la classe n'a pas d'appelant (TICPE-A01).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Art_Tipp` et les colonnes `numtipp`, `numagri`, `dtagri` (`Fiches_Cli`,
  `Fiches_AdrlivC`, lignes de BL/factures) dans `db_control.csv`.
