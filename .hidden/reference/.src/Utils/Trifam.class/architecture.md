# Trifam — Architecture

> Source : `.src/Utils/Trifam.class`

## Vue d'ensemble

`Trifam` construit l'**arbre hiérarchique des familles d'articles** à partir des codes
`Fiches_Fam.code_fam` et des **points de rupture** paramétrés par société
(`Start.LocalSettings["/Soc<XX>/ipr"]`, tableau d'entiers : longueurs cumulées des niveaux, ex.
`[1, 3, 5]` → niveaux `A`, `A01`, `A0101`).

Chaque nœud est un objet `Trifam` : la racine (`New Trifam("1")`) n'a pas de famille ; chaque
nœud fils porte une clé (`cle` = préfixe du code), un libellé (`Text`, lu dans `Fiches_Fam`), des
liens `parent`, `enfant`, `suivant`, `precedant`, et deux sous-totaux cumulatifs (`soustotpa`,
`soustotpmp`) qui se propagent vers la racine à l'écriture.

Sémantique des liens (déduite du code et des appelants) : `enfant` désigne le **dernier** fils
créé (chaque fils écrase `parent.enfant` à sa construction) ; les frères sont chaînés par
`precedant`/`suivant`. Les appelants (`Edinv`, `Edinv1`, `Edart4`, `Stockmvt`, `Histocliart`)
parcourent l'arbre dans l'ordre par `For Each fm In noeud` (énumération `_next` qui descend la
chaîne des derniers fils) et une récursion sur `fm.precedant`.

Nature : **calcul** (construction d'arbre, SQL), avec un `Message.Error` + `Quit` en cas de
paramétrage absent.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$enfant` | var | Private |  | Trifam | 3 |
| `$parent` | var | Private |  | Trifam | 4 |
| `$suivant` | var | Private |  | Trifam | 5 |
| `$precedant` | var | Private |  | Trifam | 6 |
| `$fsoustotpmp` | var | Private |  | Float | 7 |
| `$fsoustotpa` | var | Private |  | Float | 8 |
| `$ipr` | var | Private |  | New Integer[] | 9 |
| `$resfam` | var | Private |  | Result | 10 |
| `$sfamille` | var | Private |  | String[] | 11 |
| `$stext` | var | Private |  | String | 12 |
| `$scle` | var | Private |  | String | 13 |
| `enfant` | property | Public |  | Trifam | 15 |
| `parent` | property | Public |  | Trifam | 16 |
| `suivant` | property | Public |  | Trifam | 17 |
| `precedant` | property | Public |  | Trifam | 18 |
| `soustotpmp` | property | Public |  | String | 19 |
| `soustotpa` | property | Public |  | String | 20 |
| `Text` | property | Public |  | String | 21 |
| `cle` | property | Public |  | String | 22 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 25-91 | Public | 18 | 60 | 0 | méthode spéciale |
| `_next` | 93-99 | Public | 3 | 5 | 0 | méthode spéciale |
| `txt` | 100-111 | Private | 2 | 9 | 0 |  |
| `enfant_Read` | 113-117 | Private | 1 | 3 | 0 |  |
| `enfant_Write` | 119-123 | Private | 1 | 3 | 0 |  |
| `parent_Read` | 125-129 | Private | 1 | 3 | 0 |  |
| `suivant_Read` | 131-135 | Private | 1 | 3 | 0 |  |
| `suivant_Write` | 137-141 | Private | 1 | 3 | 0 |  |
| `precedant_Read` | 143-147 | Private | 1 | 3 | 0 |  |
| `soustotpmp_Read` | 149-153 | Private | 1 | 3 | 0 |  |
| `soustotpmp_Write` | 155-160 | Private | 2 | 4 | 0 |  |
| `soustotpa_Read` | 162-166 | Private | 1 | 3 | 0 |  |
| `soustotpa_Write` | 168-173 | Private | 2 | 4 | 0 |  |
| `Text_Read` | 175-179 | Private | 1 | 3 | 0 |  |
| `cle_Read` | 181-185 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(choix, niveau, ipr, fam, prec, par)`** (CC 18) [portée : nécessaire (spéciale)]
  [nature : calcul, avec couplage GUI en erreur].
  - `choix = "1"` (racine) : lit `ipr` dans la configuration ; tableau vide ou erreur →
    `Message.Error("Erreur de parametrage des familles")` puis **`Quit`** (arrêt de l'application).
    `SELECT LEFT(code_fam, ipr[0]) AS famille FROM Fiches_Fam GROUP BY famille ORDER BY famille`,
    puis création d'un fils `"+"` de niveau 1 par préfixe. `$scle` de la racine = premier préfixe
    (valeur sans usage connu).
  - `choix = "+"` (nœud) : relie `precedant`/`parent`, écrase `parent.enfant`, lit le libellé
    (`txt(fam)`), relie `prec.suivant`. Si `niveau <= ipr.Max` : bornes `binf = fam & " "×n` et
    `bsup = fam & "z"×n` (n = `ipr[niveau] − ipr[niveau−1] + 1`), puis
    `SELECT LEFT(code_fam, ipr[niveau]) … WHERE LEFT(…) > binf AND LEFT(…) < bsup GROUP BY famille`,
    et création récursive des fils.
    ⚠️ Bornes strictes : un code dont la suite contient des caractères `>= 'z'` (ex. `Az`, `{`,
    lettres accentuées en collation binaire) est exclu de l'arbre (à confirmer selon la collation
    `utf8mb4_unicode_ci`).
    ⚠️ Le fils est relié deux fois (`prec.suivant` dans le constructeur du fils et dans la boucle
    du parent) : redondant mais sans effet.
  - Requêtes : 1 (`txt`) + 1 (fils) par nœud : N+1 requêtes pour l'arbre complet. Les entiers de
    `ipr` sont concaténés dans le SQL (pas de valeur utilisateur).
- **`_next()`** [portée : nécessaire (spéciale)] [nature : calcul]. Énumère le nœud puis ses
  `enfant` successifs (chaîne des derniers fils).
- **`txt(fam)`** [privé] [nature : calcul]. Libellé de la famille (`""` si inconnue, cas des préfixes
  intermédiaires sans fiche famille).
- **Propriétés** : `enfant` (L/E), `parent` (L), `suivant` (L/E), `precedant` (L), `Text` (L),
  `cle` (L) ; `soustotpa`/`soustotpmp` (L : `Format(…, "0.00")` ; E : **ajoute** `Val(value)` au cumul
  et propage au parent par `Try Me.parent.soustotpa = value` ; à la racine le `Try` absorbe l'erreur
  d'objet nul). L'écriture d'un sous-total est donc une **accumulation** déguisée en affectation.

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/ipr"]`, `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Charger **une seule fois** la liste des `code_fam`/`libell_fam` triée, puis construire l'arbre en
  mémoire (même structure, mêmes liens) : suppression des N+1 requêtes. Le log SQL change : à
  valider par l'utilisateur (le diff des replays porte sur le log), sinon le garder en anomalie.
- Documenter la sémantique « `enfant` = dernier fils » ou renommer en interne (`$dernierEnfant`)
  sans changer la propriété publique.
- Remplacer `Quit` par la levée d'une erreur gérée par l'appelant (changement de comportement :
  anomalie).

### Commonalisation avec d'autres fichiers

- [`textfamille`](../textfamille.class/architecture.md) lit le même paramètre `ipr` et applique la
  même découpe du code famille par niveaux : une fonction commune `Utils.NiveauxFamille() As
  Integer[]` (avec le contrôle d'erreur) servirait aux deux.
- Les 5 appelants dupliquent la même procédure récursive `TriArticles(fam)` (parcours `For Each` +
  récursion sur `precedant`) : une méthode `Parcours() As Trifam[]` (liste ordonnée des nœuds)
  éviterait cette duplication (changement d'appelants : `Edart4`, `Edinv`, `Edinv1`, `Stockmvt`,
  `Histocliart`).

### Réduction de portée

- Aucun membre public réductible (propriétés utilisées par les appelants).

### Séparation traitement / GUI

- Seul couplage : `Message.Error` + `Quit` dans le constructeur.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker la hiérarchie des familles explicitement (`code_parent`, `niveau`) au lieu de la déduire
  des préfixes de code et d'un paramètre local `ipr`.
