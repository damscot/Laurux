# Fvendeurs — Architecture

> Source : `.src/Caisse/Fvendeurs.class`

## Vue d'ensemble

`Fvendeurs` est l'écran de **gestion de la table des vendeurs/caissières** (`Fiches_Vendeurs` :
code, nom, mot de passe chiffré, indicateur administrateur). Il est ouvert depuis le menu Gestion
sur son auto-instance, en modal (`Fmenu.Menu206_Click`) ou non modal (`Fmenu.Menu287_Click`,
menu « Vendeurs »).

Même gabarit que [`Fcaisses`](../Fcaisses.class/architecture.md) : liste `Vendeur`
(`ColumnView` : code, mot de passe chiffré dans une colonne de largeur 1, nom, et l'indicateur
administrateur dans une colonne fantôme `Item[3]`), zones du groupe `Cais` (code, nom, mot de
passe `Prenom`, confirmation `Mdp2`), case `Admin`, boutons du groupe `Btn`.

Le mot de passe est chiffré par `hexdblKey.crypt("en", …, "Laurux")` ; il est relu et
**déchiffré** dans la zone `Prenom` (masquée) quand on sélectionne un vendeur. Les vendeurs
`admin` (valeur `-1`, `Boolean` vrai) protègent l'accès aux préférences de caisse
(`Cmenu.Mdp_KeyPress` cherche `admin = '-1'`).

Nature globale : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-42 | Public | 1 | 13 | 0 | méthode spéciale |
| `Form_Open` | 44-59 | Public | 3 | 13 | 0 | handler GUI |
| `Refresh` | 61-68 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 70-82 | Public | 3 | 11 | 0 | portée réductible ? |
| `Cleanchamps` | 84-92 | Public | 1 | 7 | 0 | portée réductible ? |
| `Cais_GotFocus` | 97-103 | Public | 1 | 5 | 0 | handler GUI |
| `Cais_KeyPress` | 105-136 | Public | 9 | 25 | 0 | handler GUI |
| `Btn_KeyPress` | 138-147 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 149-164 | Public | 4 | 10 | 0 | handler GUI |
| `Vendeur_Click` | 166-170 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 172-206 | Public | 5 | 32 | 0 | portée réductible ? |
| `Button3_Click` | 208-220 | Public | 3 | 11 | 0 | portée réductible ? |
| `Vendeur_KeyPress` | 225-246 | Public | 8 | 18 | 0 | handler GUI |
| `Button4_Click` | 251-255 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI] : `Utils.Observers(Me)`,
  centrage, trois colonnes (la colonne 1, mot de passe chiffré, a une largeur de 1 pixel).
- **`Form_Open()`** [handler, rappelé par `Refresh`] [nature : mixte] : `SELECT * FROM
  <TabVendeurs>` (sans tri) ; ajoute chaque vendeur (clé = code) avec `Item[0]` code,
  `Item[1]` mot de passe chiffré, `Item[2]` nom, `Item[3]` admin (colonne fantôme).
- **`Refresh()`** [portée : réductible] : vide la liste, décoche `Admin`, `form_Open`,
  `Maj_Zones`.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : recopie l'élément courant ; le mot de
  passe est **déchiffré** dans `Prenom` (`hexdblKey.crypt("de", …)`), `Mdp2` n'est pas rempli
  (il faut retaper la confirmation pour réenregistrer). `With Utils` inutile.
- **`Cleanchamps()`** [portée : réductible] [nature : GUI] : vide les zones et décoche `Admin`.
- **`Cais_GotFocus()`** [handler du groupe `Cais`] : couleur d'édition (`Utils.SetEditColor`).
- **`Cais_KeyPress()`** [handler du groupe `Cais`] : Entrée/Retour/Tab → zone suivante (tags 1-4,
  puis `Button1`) ; F1 → aide.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 1 → `Button3_Click`, tag 2 → `Button1_Click`,
  tag 3 → fermeture.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : **toute touche** sur « Enregistrer » (tag 2)
  enregistre (FVENDEURS-A02).
- **`Vendeur_Click()`** [handler, `replay_dynamic`] : `Maj_Zones` ; doit rester `Public`.
- **`Vendeur_KeyPress()`** [handler] : Entrée/Tab → élément suivant + `Vendeur_Click` ; F1 →
  aide ; Échap/F2 → **masque et vide la liste** jusqu'à la réouverture (FVENDEURS-A03).
- **`Button1_Click()`** (Enregistrer) [portée : réductible — non levé, groupe `Btn`] [nature :
  mixte] : mots de passe identiques et longueur ≥ 3, sinon message ; code non vide ;
  `SELECT … WHERE code = &1` puis `UPdate <TabVendeurs> SET nom, mdp, admin` ou
  `INSERT INTO <TabVendeurs> (code, nom, mdp, admin)` ; `Refresh` + `Cleanchamps`. Aucun contrôle
  de longueur du code (`char(2)`) ni de caractères ; pas de `Catch`.
- **`Button3_Click()`** (Supprimer) [portée : réductible — non levé, groupe `Btn`] [nature :
  mixte] : si `Code.Text` n'est pas vide, confirmation puis `DELETE FROM <TabVendeurs> WHERE code =
  '<Vendeur.Current[0]>'` **par concaténation**, sur la ligne **sélectionnée** et non sur le code
  saisi ; sans sélection, `Vendeur.Current[0]` lève une erreur **non interceptée** (pas de
  `Catch`) (FVENDEURS-A01). Aucun contrôle d'usage du vendeur (caisse connectée, dernier
  administrateur). Branche `Else` vide.
- **`Button4_Click()`** [handler] : aide `Table_Vendeurs`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `hexdblKey.crypt`.
- Table : `Fiches_Vendeurs` (`TabVendeurs` : lecture, insertion, mise à jour, suppression).
- Contrat : `admin` stocké `-1`/`0` (valeur d'un `Boolean`), lu par `Cmenu.Mdp_KeyPress`
  (`admin = '-1'`) ; `mdp` chiffré lu par `Ouverture`, `Cmenu`, `ConVendeurs`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les `With Utils` vides de sens et la branche `Else` vide.
- Ne plus transporter le mot de passe chiffré dans une colonne de la liste : le relire par code
  au clic (même affichage ; SQL modifié, dump identique) — à décider avec FVENDEURS-A04.

### Commonalisation avec d'autres fichiers

- **Gabarit d'écran de table** avec [`Fcaisses`](../Fcaisses.class/architecture.md) et les écrans
  de tables de Gestion ([`Typec`](../../Gestion/Tables/Typec.class/architecture.md)…).
- **Vendeurs** : chiffrement/déchiffrement et liste via le helper `LVendeur` partagé avec
  [`Ouverture`](../Ouverture.class/architecture.md), [`Svendeur`](../Svendeur.class/architecture.md),
  [`Cmenu`](../Cmenu.class/architecture.md) et
  [`ConVendeurs`](../../Gestion/Facturation/ConVendeurs.class/architecture.md).

### Réduction de portée

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Button1_Click`, `Button3_Click` → `Private` (aucun appelant
externe, vérifié par `grep` ; `Button1`/`Button3` sont dans le groupe `Btn`). `Vendeur_Click`
reste `Public` (rejeu).

### Séparation traitement / GUI

`EnregistreVendeur(sCode, sNom, sMdpClair, bAdmin)`, `SupprimeVendeur(sCode)` et
`ControleMotDePasse(s1, s2) As String` (message de refus), sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Mot de passe stocké chiffré de façon réversible (`hexdblKey`, clé fixe « Laurux ») dans un
  `varchar(15)` : un hachage salé non réversible imposerait une colonne plus longue et la fin de
  l'affichage du mot de passe existant.
- Index unique sur `Fiches_Vendeurs.code` (la clé primaire est `lind`) ; `admin` en `tinyint(1)`.
