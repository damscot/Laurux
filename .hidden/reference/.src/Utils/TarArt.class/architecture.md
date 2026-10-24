# TarArt — Architecture

> Source : `.src/Utils/TarArt.class`

## Vue d'ensemble

`TarArt` détermine le **prix de vente HT applicable** à un article pour un client (ou un type de
client) et liste tous les tarifs candidats dans une grille (`GridView1`, formulaire `TarArt.form`).
C'est un **formulaire** dont **tout le calcul est fait dans le constructeur** `_new` ; les
résultats sont exposés par des variables publiques :

| Membre | Contenu |
|---|---|
| `prixht` | prix HT retenu (arrondi à 3 décimales) |
| `prixrht` | prix de revient HT (`art_prvt`) |
| `nego` | un tarif négocié (remise, coefficient, tarif client) s'applique |
| `promo` | une promotion s'applique |
| `remise` | taux de remise retenu (%) |
| `detail` | libellé du tarif retenu |
| `cdr` | droits sur alcools (`Calculdroit`), options B/T |

Priorité (le dernier qui s'applique gagne) : prix de base `art_pvht` → remise type client ×
famille (`Fiches_RemTypec`) → coefficient type client × famille sur prix de revient
(`Fiches_CoeffTypec`) → coefficient type client × article (`Fiches_TarTypcli`) → remise client ×
famille (`Fiches_RemCliFam`) → coefficient client × article (`Fiches_Tarcli`) → promotion
(`ArtPromo`) si moins chère. En options `B`/`T` (licences boissons), les droits (`cdr.droit +
cdr.secu`) sont déduits de chaque prix quand ils sont suspendus ou facturés à part.

Utilisateurs : `Facture` (`Facture.class:4967-4978`, fenêtre cachée, `Show` sur demande, événement
`selec` → `trf_selec`) et l'édition de tarifs `Edart4` (`Edart4.class:141-158`, une instance par
article imprimé, jamais affichée ni détruite).

Nature : **mixte** — calcul SQL dans `_new`, puis configuration de la grille.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$lstpx` | var | Private |  | New Collection | 3 |
| `prixht` | var | Public |  | Float | 4 |
| `prixrht` | var | Public |  | Float | 5 |
| `nego` | var | Public |  | Boolean | 6 |
| `promo` | var | Public |  | Boolean | 7 |
| `detail` | var | Public |  | String | 8 |
| `remise` | var | Public |  | Float | 9 |
| `cdr` | var | Public |  | Calculdroit | 10 |
| `$option` | var | Private |  | String | 11 |
| `selec` | event | Public |  |  | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-145 | Public | 32 | 120 | 0 | méthode spéciale |
| `GridView1_Data` | 147-155 | Public | 2 | 6 | 0 | handler GUI |
| `GridView1_Activate` | 157-163 | Public | 1 | 5 | 0 | handler GUI |
| `GridView1_KeyPress` | 165-173 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(nart, ncli, typec, cpromo)`** (CC 32, LOC ~110) [portée : nécessaire (spéciale)]
  [nature : mixte, calcul extractible].
  1. `$option = Utils.Option()` ; lecture article ⋈ famille (`Fiches_Art, Fiches_Fam` en jointure
     implicite : un article sans famille valide est introuvable), avec `art_dra/art_volm/art_deg`
     en options B/T.
     ⚠️ `prixrht = resart!art_prvt` est lu **avant** le test `Available` : article inconnu →
     erreur « résultat non disponible » levée vers l'appelant.
  2. Options B/T et `art_dra` : `cdr = New Calculdroit(...)`, `tax = droit + secu` si
     `suspendu` ou `drsurfac`.
  3. Lecture du client / type client (`Fiches_Cli`, `Fiches_Typec`) selon `typec`/`ncli` ; si
     `ncli` est donné sans `typec`, `typec = cli_typec`. Retour anticipé si non trouvé : grille non
     configurée, `prixht` **non arrondi**.
  4. Cinq sources de tarif (voir tableau ci-dessus), chacune ajoutée à `$lstpx` (clé `Str(i)`).
     ⚠️ `Fiches_CoeffTypec` : le libellé de **toutes** les lignes est `rescli!libelle` (type du
     client courant), et si ni `typec` ni `ncli` ne sont fournis, `rescli` est `Null` → erreur
     dès qu'un coefficient existe pour la famille.
     `Fiches_TarTypcli` : `prixht` et `nego` affectés deux fois (redondance).
  5. Promotion : `ArtPromo.art_Promo` puis `ArtPromo.Prix_Promo` (String → Float). Comparaison
     `pxprom < prixht` alors que `prixht` est déjà diminué de `tax` et que le prix retenu est
     `pxprom - tax` : comparaison incohérente en options B/T (à confirmer).
  6. `prixht = Round(prixht, -3)` ; configuration de `GridView1` (2 colonnes, sélection simple).
  SQL : 3 à 8 `SELECT`, tables en dur sans `Cbase.Table`.
- **`GridView1_Data(Row, Column)`** [portée : nécessaire, handler] [nature : GUI]. Affiche
  `$lstpx[Str(row)]` ; assombrit une ligne sur deux par soustraction sur la couleur
  (`Background - 50`, manipulation arithmétique d'une couleur RGB).
- **`GridView1_Activate()`** [handler] : lève `selec(prix)` puis `Hide` + `Close`.
- **`GridView1_KeyPress()`** [handler] : Échap → `Hide` + `Close`.

## État global utilisé

- `Utils.Option()` (option de licence), `Utils.db`.
- `ArtPromo.art_Promo`, `ArtPromo.Prix_Promo` ; `Calculdroit` (droits alcools).
- 7 variables `Public` de résultat (dont `remise`, lue nulle part à l'extérieur : l'usage dans
  `Facture` est commenté, ligne 4977).

## Propositions d'amélioration

### Réécriture / refactorisation

- **Séparer le calcul du formulaire** : une fonction (ou classe non graphique) `CalculTarif(nart,
  ncli, typec, cpromo)` remplissant les mêmes résultats et la liste des candidats ; `_new` l'appelle
  puis configure la grille. `Edart4` n'aurait plus besoin d'instancier une fenêtre par article
  (le remplacement dans `Edart4` est un changement d'appelant, à faire dans le même commit).
- Factoriser l'ajout d'un candidat (`AjouteTarif(libelle, prix, retenu)`) répété 6 fois.

### Commonalisation avec d'autres fichiers

- La même cascade de tarifs existe probablement dans la caisse (`Caisse.class` appelle aussi
  `ArtPromo.Prix_Promo`) et dans les écrans de tarifs (`TarTypeCli`, `GesTar`) : à vérifier en
  phase 3 pour une fonction de tarification unique.
- `Calculdroit` / déduction des droits : partagé avec [`LPrix`](../LPrix.class/architecture.md)
  et `calculdroit1` (taxes `LTaxe`).

### Réduction de portée

- `remise` : lue nulle part à l'extérieur (`deps.py` et grep) → `Private` possible ; à conserver si
  l'utilisateur souhaite réactiver la ligne commentée de `Facture`.
- `prixht`, `prixrht`, `nego`, `promo`, `detail`, `cdr` : utilisés par `Facture`/`Edart4`.

### Séparation traitement / GUI

- Voir `CalculTarif` ci-dessus ; la grille ne fait plus que présenter `$lstpx`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les 5 tables de conditions tarifaires (`Fiches_RemTypec`, `Fiches_CoeffTypec`, `Fiches_TarTypcli`,
  `Fiches_RemCliFam`, `Fiches_Tarcli`) pourraient être unifiées en une table de règles avec
  priorité explicite.
