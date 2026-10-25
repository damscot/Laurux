# Svendeur — Architecture

> Source : `.src/Caisse/Svendeur.class`

## Vue d'ensemble

`Svendeur` est la petite fenêtre « Caissière » qui permet, **en cours de saisie caisse et avant
la première ligne du ticket**, de choisir un autre vendeur pour le ticket. Elle est ouverte par
`Caisse` sur son auto-instance (`Svendeur.showmodal()`, raccourcis `Alt+V` et `Ctrl+X`,
[Caisse.class:919](../../../../.src/Caisse/Caisse.class#L919) et [Caisse.class:975](../../../../.src/Caisse/Caisse.class#L975)).

Le choix est transmis par deux variables globales : `Start.$Cai` (libellé « code nom » choisi) et
`Caisse.$Vendeur` (`True` si un vendeur a été choisi). `Caisse` relit ensuite le vendeur par
`Left$(Start.$Cai, 2)` et l'affiche sur le ticket.

⚠️ `Caisse.$Vendeur` est une variable **d'instance** (`Public $Vendeur As Boolean`,
[Caisse.class:139](../../../../.src/Caisse/Caisse.class#L139)) : `Svendeur` l'écrit sur
l'**auto-instance** de `Caisse`, alors que la saisie affichée est créée par `New Caisse`
([Cmenu.class:253](../../../../.src/Caisse/Cmenu.class#L253)). La saisie ouverte lit son propre
`$Vendeur`, toujours `False` : le changement de vendeur ne serait jamais appliqué, et une
instance cachée de `Caisse` est construite (SVENDEUR-A01 / CAISSE-A04, à confirmer à l'exécution). `Caisse.$Vendeur` doit rester `Public`.

Aucun mot de passe n'est demandé (contrairement à `Ouverture` et `ConVendeurs`) : à confirmer
comme choix fonctionnel.

Nature globale : **GUI**, une requête de contrôle.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-19 | Public | 6 | 14 | 0 | méthode spéciale |
| `Caissiere_Click` | 21-40 | Public | 6 | 17 | 0 | handler GUI |
| `Button2_Click` | 42-52 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 54-59 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] : `Utils.Observers(Me)`,
  centrage, `SELECT * FROM <TabVendeurs>` → liste `Caissiere` (entrée vide `""` puis « code
  nom ») ; erreur de requête ignorée (`Try` + `If Not Error`). Même code que `Ouverture._new`
  (partie vendeurs) et `ConVendeurs._new`.
- **`Caissiere_Click()`** [handler] [nature : mixte] : si une entrée est choisie,
  `SELECT * FROM <TabVendeurs> WHERE code = &1` avec **`Left$(Caissiere.Text, 1)`** ; message
  « Ce vendeur n'existe pas… » si absent ; focus sur la liste dans les deux cas. Le code sur un
  caractère trouve le vendeur `1` pour le vendeur `12` (SVENDEUR-A02). `Catch` : son + message.
- **`Button2_Click()`** (« Utiliser ») [handler] [nature : mixte] : entrée choisie →
  `Start.$Cai = Caissiere.Text` et `Caisse.$Vendeur = True` ; sinon `Caisse.$Vendeur = False` ;
  fermeture.
- **`Button1_Click()`** (« Quitter ») [handler] : `Caisse.$Vendeur = False`, fermeture.

## État global utilisé

- `Start.$Cai` (écrit), `Start.son`, auto-instance `Caisse` (`$Vendeur`, écrit).
- `Utils.db`, `Utils.Observers`.
- Table : `Fiches_Vendeurs` (`TabVendeurs`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Retour du choix par une propriété de `Svendeur` (ou une valeur de retour de `ShowModal`)
  plutôt que par deux globales ; nécessite de corriger SVENDEUR-A01 dans le même temps
  (changement de comportement).
- `Do … Loop Until` → `Repeat … Until` (idiome du dépôt).

### Commonalisation avec d'autres fichiers

- Liste et recherche des vendeurs via le helper `LVendeur` partagé avec
  [`Ouverture`](../Ouverture.class/architecture.md), [`Fvendeurs`](../Fvendeurs.class/architecture.md),
  [`Cmenu`](../Cmenu.class/architecture.md) et
  [`ConVendeurs`](../../Gestion/Facturation/ConVendeurs.class/architecture.md) (CONVENDEURS-005) ;
  longueur de code conservée (1 caractère) tant que SVENDEUR-A02 n'est pas tranchée.

### Réduction de portée

Aucune : les quatre fonctions sont le constructeur et des handlers (`Public` obligatoire).

### Séparation traitement / GUI

`VendeurExiste(sCode) As Boolean` (requête de `Caissiere_Click`), sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le vendeur d'un ticket est stocké par son **nom** (`Fiches_EntTicketz.vendeur varchar(35)`) :
  stocker le code vendeur permettrait des statistiques fiables par vendeur.
