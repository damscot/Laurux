# Edbl — Architecture

> Source : `.src/Gestion/Impressions/Edbl.class` (+ `Edbl.form`)

## Vue d'ensemble

Écran « Réimpression d'un bon de réception fournisseur » (menu `Menu90`, `Fmenu.class:1034`).
L'utilisateur tape un numéro de BR dans `Nbl` (Entrée → impression immédiate) ou ouvre la liste
`Colbl` des réceptions (`Fiches_Entrecpt` + nom du fournisseur), triable en cliquant sur les
`TextBox` d'en-tête (`Nm`, `Cd`, `Nr`, `Dt`, `Mt`), puis imprime par `Button2`. L'impression est
entièrement déléguée à [`Edbr.Ed`](../Edbr.module/architecture.md) (`sOrg = ""`).

Le fournisseur (`codef`) et la date (`dater`) du BR sont gardés en **membres** entre deux
impressions. Groupes : `Nbl` dans `Cmpt` (tag 1). Boutons sans handler : `Button1` (aide),
`Button6`.

Nature : **GUI** (deux requêtes de sélection, aucune écriture).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 27 |
| `Tab2` | var | Private |  | String | 28 |
| `dater` | var | Private |  | String | 29 |
| `codef` | var | Private |  | String | 30 |
| `Tri` | var | Private |  | String | 31 |
| `b` | var | Private |  | Integer | 32 |
| `Coulfond` | var | Private |  | New String[] | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-42 | Public | 1 | 5 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 47-75 | Public | 6 | 22 | 0 | handler GUI |
| `ToggleButton1_Click` | 80-102 | Public | 2 | 21 | 0 | handler GUI |
| `Aff_Data` | 104-138 | Public | 4 | 30 | 0 | portée réductible ? |
| `Colbl_KeyPress` | 143-161 | Public | 5 | 16 | 0 | handler GUI |
| `cache_bl` | 163-172 | Public | 1 | 8 | 0 | portée réductible ? |
| `Colbl_Click` | 177-190 | Public | 1 | 12 | 0 | handler GUI |
| `Nm_GotFocus` | 192-205 | Public | 2 | 12 | 0 | handler GUI |
| `Cd_GotFocus` | 207-220 | Public | 2 | 12 | 0 | handler GUI |
| `Nr_GotFocus` | 222-235 | Public | 2 | 12 | 0 | handler GUI |
| `Dt_GotFocus` | 237-250 | Public | 2 | 12 | 0 | handler GUI |
| `Mt_GotFocus` | 252-265 | Public | 2 | 12 | 0 | handler GUI |
| `Cmpt_GotFocus` | 270-276 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 278-303 | Public | 5 | 22 | 0 | handler GUI |
| `Button3_Click` | 305-310 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : `Utils.Observers(Me)`, centrage, `Music.Load`.
- **`Cmpt_KeyPress()`** [handler] [mixte] : Entrée/Retour/Tab dans `Nbl` → `SELECT * FROM
  Fiches_Ligrecpt WHERE numrecpt = &1` (sans le fournisseur : si deux fournisseurs ont le même
  numéro, le premier trouvé est pris, EDBL-A02) ; `codef`, `dater` (valeur `Date` du résultat)
  puis `Edbr.Ed(Nbl.Text, codef, dater, coulfond, "")`, sinon message « Ce numéro de bon n'existe
  pas ! ».
- **`ToggleButton1_Click()`** [handler] : `Tri = "ddate desc"`, bascule la liste et ses en-têtes,
  appelle `Aff_Data`.
- **`Aff_Data()`** [portée : réductible] [mixte] : colonnes calées sur les en-têtes ; `SELECT *
  From Fiches_Entrecpt Left join Fiches_Four on fo_code = four order by <Tri>` ; une ligne par
  réception (nom, code, numéro, date `Cdate_Aff`, montant).
- **`Colbl_KeyPress()`** [handler] : Entrée → `Nbl` = numéro ; la variable **locale** `codef`
  masque le membre : ni `codef` ni `dater` ne sont mis à jour (EDBL-A01) ; Échap/F2 → retour sur
  `Nbl` ; puis `cache_bl`.
- **`cache_bl()`** [portée : réductible] [GUI] : masque la liste et `Cd`, `Nm`, `Nr`, `Dt` mais
  **pas `Mt`** (en-tête « montant » laissé visible, EDBL-A03).
- **`Colbl_Click()`** [handler ; `replay_dynamic` : reste `Public`] : `Nbl`, `codef`, `dater`
  (texte `dd.mm.yyyy` de la colonne) depuis la ligne, masque tout.
- **`Nm_GotFocus`, `Cd_GotFocus`, `Nr_GotFocus`, `Dt_GotFocus`, `Mt_GotFocus`** [handlers] :
  alternent l'ordre croissant/décroissant (`b`) de la colonne et réaffichent la liste ; cinq corps
  identiques à la clause de tri près.
- **`Cmpt_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Button2_Click()`** [handler] : si `codef` ou `dater` est vide, même recherche que
  `Cmpt_KeyPress` ; sinon `Edbr.Ed` avec les valeurs **mémorisées** : après une première
  impression, un nouveau numéro tapé est imprimé avec le fournisseur précédent (souvent « Aucun
  mouvement », EDBL-A01).
- **`Button3_Click()`** [handler] : supprime `~/tmp//Edbl.ps` (fichier jamais produit), ferme.

## État global utilisé

- Membres : `Tab`, `Tab2`, `dater` (tantôt `Date`, tantôt texte `dd.mm.yyyy`, transmis à `Edbr`
  qui l'imprime sur les pages suivantes et l'utilise pour la GED : EDBL-A04, à confirmer), `codef`,
  `Tri`, `b`, `Coulfond` (tableau vide transmis à `Edbr`).
- `Utils.Observers`, `SetEditColor`, `Cdate_Aff`, `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Un helper `TrierPar(sColonne)` pour les cinq `*_GotFocus` (handlers conservés).
- Un helper `ImprimeBon(sNumero)` partagé par `Cmpt_KeyPress` et `Button2_Click`.
- Supprimer `Button3`'s `Kill …Edbl.ps` (sans effet) et `Tab`/`Tab2` membres (locaux suffisent).

### Commonalisation avec d'autres fichiers

- Liste triable par en-têtes `TextBox` : même schéma que d'autres écrans de `Gestion/Tables`
  (« grille triable par en-têtes » relevée au lot Gestion-1) → helper commun en phase 3.
- Liste de documents fournisseur : schéma proche de la liste des commandes d'[`Edcom`](../Edcom.class/architecture.md).

### Réduction de portée

- `Aff_Data`, `cache_bl` → `Private`.

### Séparation traitement / GUI

- `ReceptionParNumero(sNumero) As Result` et `ListeReceptions(sTri) As Result` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La recherche par numéro seul suppose l'unicité de `numrecpt`, qui n'est pas garantie par la clé
  primaire de `Fiches_Ligrecpt` (`code, numrecpt, four, daterecpt`).
