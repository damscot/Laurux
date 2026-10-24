# Plancomptable — Architecture

> Source : `.src/Compta/Impressions/Plancomptable.class` · Formulaire : `.src/Compta/Impressions/Plancomptable.form`

## Vue d'ensemble

Écran **« Impression du plan comptable »** (menu Compta « Plan comptable », `Fmenu.Menu70_Click`).
L'utilisateur choisit un type de comptes (Clients, Fournisseurs, Gestion, Bilan, qui préremplit
une plage de numéros), ajuste la plage (saisie ou sélection par `TriCpt` avec F2 / boutons) et
imprime la liste `compte – intitulé` dans un PDF (`Ccompta`, `~/tmp/Plan.pdf`) ouvert par
`Visualiseur.Prog`.

Nature : **mixte** ; la requête et la mise en page PDF sont dans le handler `Button2_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `type` | var | Private |  | String | 29 |
| `PosY` | var | Private |  | Integer | 30 |
| `Bsel` | var | Public |  | Boolean | 32 |
| `Bval` | var | Public |  | String | 33 |
<!-- /AUTO:declarations -->

`Bsel`/`Bval` sont **écrites par `TriCpt`** via `Object.SetProperty($obj, "Bsel"|"Bval")`
(`TriCpt.class:112-113`) : elles doivent rester `Public` (faux positif « portée réductible » de
`deps.py`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-43 | Public | 1 | 6 | 0 | méthode spéciale |
| `ToggleButton2_Click` | 45-56 | Public | 2 | 9 | 0 | handler GUI |
| `ToggleButton3_Click` | 58-69 | Public | 2 | 9 | 0 | handler GUI |
| `Btn_Click` | 71-87 | Public | 6 | 11 | 0 | handler GUI |
| `Cpt_KeyPress` | 89-97 | Public | 5 | 7 | 0 | handler GUI |
| `Cpt2_KeyPress` | 99-107 | Public | 5 | 7 | 0 | handler GUI |
| `cpt_GotFocus` | 109-113 | Public | 2 | 3 | 0 | handler GUI |
| `cpt_LostFocus` | 115-119 | Public | 2 | 3 | 0 | handler GUI |
| `cpt2_GotFocus` | 121-125 | Public | 2 | 3 | 0 | handler GUI |
| `cpt2_LostFocus` | 127-131 | Public | 2 | 3 | 0 | handler GUI |
| `Bclient_Click` | 133-141 | Public | 1 | 7 | 0 | handler GUI |
| `Bfournisseur_Click` | 143-151 | Public | 1 | 7 | 0 | handler GUI |
| `Bgestion_Click` | 153-161 | Public | 1 | 7 | 0 | handler GUI |
| `Bbilan_Click` | 163-171 | Public | 1 | 7 | 0 | handler GUI |
| `Button2_Click` | 173-234 | Public | 8 | 59 | 0 | portée réductible ? |
| `Button1_Click` | 236-238 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [constructeur] [GUI] : observateurs, son, centrage, sélection initiale « Clients »
  (`Bclient_Click`).
- **`ToggleButton2_Click()` / `ToggleButton3_Click()`** [handlers] [GUI] : ouvrent
  `New TriCpt(type, TriCpt.Sans_Solde, Me)` en modal ; si `Bsel`, recopient `Bval` dans `Cpt2`
  (resp. `Cpt`). ⚠️ `ToggleButton2` (placé à côté de `Cpt2`) remplit `Cpt2`, `ToggleButton3`
  remplit `Cpt` ; mais F2 dans `Cpt` appelle `ToggleButton2_Click` (remplit `Cpt2`) et F2 dans
  `Cpt2` appelle `ToggleButton3_Click` (remplit `Cpt`) : le compte choisi par F2 arrive dans
  **l'autre** champ (à confirmer à l'écran, anomalie A01). `Bsel` n'est jamais remis à `False`.
- **`Btn_Click()`** [handler du groupe `btn` : `Button2` (tag 2), `Button3` (tag 3)] : 2 →
  `Button2_Click()` ; 3 → suppression du PDF puis fermeture. Le cas 1 est inatteignable
  (`Button1` n'est pas dans le groupe).
- **`Cpt_KeyPress()` / `Cpt2_KeyPress()`** [handlers] [GUI] : Entrée/Tab → champ suivant ; F2 →
  sélection (voir ci-dessus).
- **`cpt_GotFocus` … `cpt2_LostFocus`** [handlers] [GUI] : `Utils.ObsGotf` / `ObsLstf` sous `Try`.
- **`Bclient_Click` / `Bfournisseur_Click` / `Bgestion_Click` / `Bbilan_Click`** [handlers]
  [GUI] : plages `41100001-41199999` (C), `40100001-40199999` (F), `600000-79999999` (G),
  `100000-59999999` (B) et `type`.
- **`Button2_Click()`** (CC 8) [appelé par `Btn_Click`, pas par l'événement du bouton, qui est
  regroupé] [mixte ; partie extractible : requête + boucle PDF] :
  - `SELECT * FROM Fiches_Societes WHERE cd_sc = Start.Societe` (sans test `Available`) pour le
    titre ;
  - `SELECT * FROM Fiches_Comptes WHERE cast(compte_cc as char) BETWEEN cpt AND cpt2 (comparaison
    de chaînes) AND type_cc = type ORDER BY cast(compte_cc AS char)` ;
  - PDF `Ccompta` : `Entete`, `Level0P`, `Level1P`, une ligne `Level2P` par compte, saut de page
    à `PosY > 283`, `Lines`, `BasPage`, `Output` dans `~/tmp/Plan.pdf`, `Visualiseur.Prog` ;
  - sinon `Message(" Aucun compte pour cette demande", "OK")`.
  - Variables mortes : `Nbpage`, `dte` (calculée trois fois, jamais utilisée), `PosY + 160`
    immédiatement écrasé ; `Shell "cd ~"` sans effet. Curseur final `Mouse.Pointing` au lieu de
    `Mouse.Default`.
- **`Button1_Click()`** [handler] : vide (bouton `Button1` sans texte dans le `.form`).

## État global utilisé

- `Start.Musique`, `Start.Societe` ; `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`,
  `Utils.db` ; `TriCpt` (constantes `Sans_Solde`), `Ccompta`, `Visualiseur`.
- Tables en dur : `Fiches_Societes`, `Fiches_Comptes` (clés Cbase `TabSoc`, `TabComptes`
  disponibles).

## Propositions d'amélioration

### Réécriture / refactorisation

- Les quatre handlers de type ne diffèrent que par les bornes et la lettre : helper privé
  `ChoixType(sDebut, sFin, sType)`.
- `ToggleButton2_Click`/`ToggleButton3_Click` : helper `ChoixCompte(hCible, hSuivant)`.
- Supprimer les variables mortes de `Button2_Click` et le `Shell "cd"`.

### Commonalisation avec d'autres fichiers

- Le motif « en-tête + boucle `LevelN` + saut de page à 283 + `BasPage` + `Output` +
  `Visualiseur.Prog` » se répète dans tous les états `Ccompta` (`Anomalies`, `Balance`,
  `EdNlettrees`…) : helper `Ccompta.NouvellePageSi(PosY, titre, ste, procEntete)` à proposer au
  rework de `Ccompta`.
- Les plages par type de compte se retrouvent dans `Balance` et `Fmontant` : constantes partagées
  (ex. `LCompte.Plage("C")`) à étudier.
- Titre société : `SELECT int_sc FROM Fiches_Societes` répété dans de nombreux états (voir
  `Balance.class:641`) ; helper `Utils.NomSociete()`.

### Réduction de portée

- Aucune : `Bsel`/`Bval` sont écrites par `TriCpt` (appel dynamique), les autres fonctions sont des
  handlers.

### Séparation traitement / GUI

- Extraire `Private Function ListeComptes(sDebut, sFin, sType) As Result` et
  `Private Sub ImprimePlan(r As Result, sTitre)` ; `Button2_Click` lit les contrôles et les appelle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `compte_cc` est un entier comparé et trié comme chaîne (`cast(… as char)`) : une colonne
  `VARCHAR` indexée éviterait le parcours complet de la table.
