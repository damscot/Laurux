# ConVendeurs — Architecture

> Source : `.src/Gestion/Facturation/ConVendeurs.class`

## Vue d'ensemble

`ConVendeurs` est l'**écran de connexion d'un vendeur** en gestion commerciale (option
`/Soc<XX>/Vendeurs`). Il liste les vendeurs de `Fiches_Vendeurs` dans une ComboBox
(`Caissiere`), vérifie le mot de passe saisi (`Mdp`) contre le mot de passe déchiffré
(`hexdblKey.crypt("de", …, "Laurux")`), mémorise le vendeur connecté dans
`Start.LocalSettings["/Soc<XX>/CodeVendeur"]` (texte « code nom » de la ComboBox), puis ouvre la
saisie de documents (`New Facture(False)`).

Trois points d'entrée :
- `Fmenu.Menu42_Click` ([Fmenu.class:941](../../../../../.src/Communs/Fmenu.class#L941)) : `New ConVendeurs` puis `ShowModal` quand les
  vendeurs sont activés et qu'aucun vendeur n'est connecté ;
- `Fmenu.Menu193_Click` ([Fmenu.class:1788](../../../../../.src/Communs/Fmenu.class#L1788)) : `New ConVendeurs(True)` (saisie entretien) —
  **échoue** (voir CONVENDEURS-A01) ;
- `Facture` touche F5 ([Facture.class:889](../../../../../.src/Gestion/Facturation/Facture.class#L889)) : `ConVendeurs.ShowModal()` sur l'**auto-instance**,
  pour changer de vendeur en cours de saisie.

Contrôles : `Caissiere` (ComboBox), `Mdp` (TextBox mot de passe), `Button1` « Connecter »,
`Button2` « Annuler », `Button3` « Déconnecter ».

Nature globale : **GUI**, avec deux requêtes SQL simples.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$mdp` | var | Private |  | String | 3 |
| `b` | var | Private |  | Integer | 4 |
<!-- /AUTO:declarations -->

Les deux variables d'instance sont déclarées sans `Private`/`Public` (donc `Private`) : `$mdp`
(mot de passe déchiffré du vendeur choisi) et `b` (drapeau d'échec de contrôle, 0/1).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 6-26 | Public | 9 | 18 | 0 | méthode spéciale |
| `Mdp_KeyPress` | 28-39 | Public | 7 | 10 | 0 | handler GUI |
| `Mdp_Vendeurs` | 41-55 | Public | 3 | 13 | 0 | portée réductible ? |
| `Caissiere_Click` | 57-77 | Public | 6 | 18 | 0 | handler GUI |
| `Button2_Click` | 79-83 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 85-116 | Public | 6 | 29 | 0 | handler GUI |
| `Button3_Click` | 118-123 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte]. Charge le son
  `son/warning.ogg`, lit tous les vendeurs (`SELECT * FROM Cbase.Table("TabVendeurs")`) et remplit
  `Caissiere` : une entrée vide `"  "` insérée en position 0, puis `code & " " & nom` par vendeur
  (boucle `Do … Loop Until MoveNext()`, seul idiome non `Repeat` du fichier). `Catch` : son +
  `Message.Error`. Partie extractible : la lecture des vendeurs (liste de libellés).
- **`Mdp_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée/Retour/Tab →
  `Mdp_Vendeurs` ; si le contrôle échoue (`b = 1`), remet `b` à 0, sinon focus sur `Button1`.
- **`Mdp_Vendeurs()`** [portée : réductible (aucun appel externe, vérifié par `grep`)]
  [nature : mixte]. Compare `Mdp.Text` à `$mdp` ; en cas d'écart : son, `Message.Error`,
  sélection de `Mdp`, `b = 1` ; sinon `b = 0`. Partie extractible : la comparaison.
- **`Caissiere_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Si un vendeur est
  choisi : `SELECT * FROM TabVendeurs WHERE code = Left$(Caissiere.Text, 1)` puis
  `$mdp = hexdblKey.crypt("de", Rrslt!mdp, "Laurux")`, **sans test `Available`** (erreur
  rattrapée par le `Catch` si l'entrée vide est choisie). ⚠️ Le code vendeur est `char(2)` en
  base ; seul le **premier caractère** est utilisé (anomalie CONVENDEURS-A02). Focus sur `Mdp` (ou
  retour sur `Caissiere` si `b = 1`).
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Construit **d'abord**
  `New Facture(False)`, puis contrôle : vendeur vide → message ; mot de passe vide → message ;
  `Mdp_Vendeurs` en échec → resélection ; sinon écrit
  `Start.LocalSettings["/Soc<XX>/CodeVendeur"] = Caissiere.Text`, ferme la fenêtre et affiche la
  `Facture` construite en modal. Effets de bord : instance de `Facture` construite même en cas
  d'échec (cf. FMENU-A09) ; appelé depuis `Facture` (F5), ouvre une **seconde** saisie de
  documents par-dessus la première (CONVENDEURS-A04, à confirmer par replay).
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Vide
  `/Soc<XX>/CodeVendeur` puis masque **l'auto-instance** `ConVendeurs.Visible = False` au lieu de
  `Me` (CONVENDEURS-A03).

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/CodeVendeur"]` (écrit) : lu par `Fmenu`
  (l. 935, 1782) et `Facture` (l. 550-551, 890-894, 1180), qui extrait le nom par
  `Mid$(…, 3)` (hypothèse d'un code d'un caractère).
- `Start.son`, `Music` ; `hexdblKey.crypt` (déchiffrement des mots de passe vendeurs).
- `Utils.db`, `Cbase.Table("TabVendeurs")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button1_Click` : séparer contrôle (fonction `ControleConnexion() As Boolean`) et ouverture de
  `Facture`. Construire `Facture` **après** le contrôle supprimerait une instance inutile, mais
  change l'ordre des effets de bord de `Facture._new` : à traiter avec CONVENDEURS-A04.
- Remplacer le drapeau entier `b` par la valeur de retour de `Mdp_Vendeurs` (Boolean).
- Boucle `Do … Loop Until` → idiome `Repeat … Until` du dépôt (même comportement).

### Commonalisation avec d'autres fichiers

- La sélection et le contrôle d'un vendeur sont dupliqués dans
  [`Ouverture`](../../../Caisse/Ouverture.class/architecture.md) (`Caissiere_Click`, mais avec
  `Left$(…, 2)`) et [`Svendeur`](../../../Caisse/Svendeur.class/architecture.md) (`Left$(…, 1)`) :
  helper commun `LVendeur` (ou module) `Liste()`, `MotDePasse(code)`, `CodeDepuisLibelle(texte)`.
- Le motif « son + `Message.Error(Error.Text & Error.Where)` » est commun à de nombreux écrans
  (voir [`Fcaras`](../Fcaras.class/architecture.md)).

### Réduction de portée

- `Mdp_Vendeurs` → `Private` (appelé seulement par `Mdp_KeyPress` et `Button1_Click`).

### Séparation traitement / GUI

- Extraire `ListeVendeurs() As String[]` (SQL) de `_new` et `MotDePasseVendeur(code) As String`
  (SQL + déchiffrement) de `Caissiere_Click` ; les handlers gardent messages et focus.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Mots de passe vendeurs stockés chiffrés de façon réversible (`hexdblKey`, clé fixe
  « Laurux ») : un hachage (SHA-256 salé) serait préférable, mais demande une migration des
  données de `Fiches_Vendeurs.mdp` (et de `Ouverture`/`Svendeur`/`Fvendeurs`).
