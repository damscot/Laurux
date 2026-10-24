# Commerciaux — Architecture

> Source : `.src/Gestion/Tables/Commerciaux.class`

## Vue d'ensemble

Écran de la **table des commerciaux (vendeurs)** (`Fiches_Commerciaux` : `lind` auto-incrémenté
clé primaire, `code` char(2) **non unique**, `nom`, `prenom` char(35), `comm` decimal(5,2) = taux de
commission). Ouvert par `Fmenu.class:2378` (`Commerciaux.Show()`). Le code commercial est porté
par les fiches clients (`cli_comm`, `FClient.class:1560`) et exploité par `Facturefm`, `StatComm`,
`VisStatComm`, `VisStatComArt` et `Histocliart`.

Structure proche des écrans « table code/intitulé » du lot Compta
([FPostes](../../../Compta/Tables/FPostes.class/architecture.md),
[FCollectif](../../../Compta/Tables/FCollectif.class/architecture.md)) mais écrite indépendamment
(similarité 0,16 à 0,21) : `ColumnView` `Vendeur` (code, nom, commission masquée en largeur 1,
prénom), zones du groupe `Ven` (tags 1 code, 2 nom, 3 prénom, 4 commission), boutons du groupe
`Btn` (tags 1 supprimer = `Button3`, 2 enregistrer = `Button1`, 3 quitter = `Button2`), aide
`Button4` hors groupe. Pas de constructeur : tout est fait dans `Form_Open`.

Nature : **GUI** avec SQL dans les handlers ; table nommée en dur (`Fiches_Commerciaux`) alors que
`Cbase.Table("TabCommerciaux")` existe.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 3-34 | Public | 3 | 27 | 0 | handler GUI |
| `Ven_GotFocus` | 36-40 | Public | 1 | 3 | 0 | handler GUI |
| `Ven_LostFocus` | 42-63 | Public | 7 | 18 | 0 | handler GUI |
| `Btn_Click` | 65-80 | Public | 4 | 10 | 0 | handler GUI |
| `Btn_KeyPress` | 82-89 | Public | 2 | 6 | 0 | handler GUI |
| `Button1_Click` | 91-110 | Public | 3 | 17 | 0 | portée réductible ? |
| `Button3_Click` | 112-124 | Public | 3 | 11 | 0 | portée réductible ? |
| `Refresh` | 126-132 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Zones` | 134-146 | Public | 2 | 11 | 0 | portée réductible ? |
| `Cleanchamps` | 148-155 | Public | 1 | 6 | 0 | portée réductible ? |
| `Ven_KeyPress` | 157-188 | Public | 9 | 25 | 0 | handler GUI |
| `Vendeur_Click` | 190-194 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 199-203 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open()`** [handler] [nature : mixte] : `Utils.Observers(Me)`, centrage, définition des
  4 colonnes, puis `SELECT * FROM Fiches_Commerciaux order by code` et remplissage. Comme
  `Refresh` rappelle `Form_Open`, `Utils.Observers` est **réexécuté à chaque rafraîchissement**
  (observateurs de rejeu créés en double, à confirmer : anomalie A03).
- **`Ven_GotFocus()` / `Ven_LostFocus()`** [handlers du groupe `Ven`] : couleurs
  `Utils.ObsGotf`/`ObsLstf` ; à la sortie du code, formatage `00` (`Try`) ; à la sortie de la
  commission, `Utils.cpoint` puis contrôle `Val(...) = Null` (message et retour au champ) ou
  formatage `0.00`.
- **`Ven_KeyPress()`** [handler du groupe `Ven`] (CC 9, max du fichier) : navigation code → nom →
  prénom → commission → bouton Enregistrer ; F1 → aide.
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 `Button3_Click` (supprimer), 2 `Button1_Click`
  (enregistrer), 3 fermeture.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : toute touche sur le bouton Enregistrer (tag 2)
  enregistre.
- **`Button1_Click()`** [portée : réductible] [nature : mixte] — enregistrement : si le code n'est
  pas vide, `SELECT … WHERE code = &1`, puis `UPdate … SET nom, prenom, comm WHERE code = &1` (toutes
  les lignes de ce code, le code n'étant pas unique) ou `INSERT`, commission convertie par
  `Val(Utils.cpoint(...))`. Pseudo-handler (bouton groupé `Btn`).
- **`Button3_Click()`** [portée : réductible] [nature : mixte] — suppression : `Music.Play` **sans
  `Music.Load`** préalable et sans tenir compte du réglage `Start.Son` ; confirmation ;
  `DELETE FROM  Fiches_Commerciaux WHERE code = '<Vendeur.Current[0]>'` **par concaténation**
  (ligne 117) sur la ligne sélectionnée et non sur le code saisi (erreur sans sélection).
  Pseudo-handler (bouton groupé `Btn`).
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide la liste, `Form_Open`, `Maj_Zones`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI] : recopie `Vendeur.Item` (élément sous le
  curseur interne : élément cliqué pendant `Vendeur_Click`, dernier élément ajouté après un
  `Refresh`) dans les zones ; `With Utils` inutile.
- **`Cleanchamps()`** [portée : réductible] [nature : GUI] : vide les 4 zones.
- **`Vendeur_Click()`** [handler] : `Maj_Zones`. Rejoué par `ReplayObserver` (`replay_dynamic`) :
  **reste `Public`**.
- **`Button4_Click()`** [handler] : `Doc.Open("Table_Commerciaux")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`, `Utils.cpoint` ; `Start.son`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Séparer l'initialisation (colonnes) du chargement (`ChargeListe()`), en conservant l'appel de
  `Utils.Observers` tel quel tant que A03 n'est pas validée.
- `Cbase.Table("TabCommerciaux")` au lieu du nom en dur.

### Commonalisation avec d'autres fichiers

- Socle « table code/libellé » proposé dans [Centrales](../Centrales.class/architecture.md) : la
  partie liste/enregistrement/suppression s'y rattache avec des colonnes supplémentaires
  (nom, prénom, commission) ; à défaut, rapprochement avec
  [FPostes](../../../Compta/Tables/FPostes.class/architecture.md) (même découpage `Btn`/`Maj_Zones`/
  `Cleanchamps`/`Refresh`).
- La conversion de la commission (`Utils.cpoint` + `Val` + `Format$("0.00")`) relève de
  [LPrix](../../../Utils/LPrix.class/architecture.md) ou d'un helper de saisie numérique commun.

### Réduction de portée

`Button1_Click`, `Button3_Click` (pseudo-handlers), `Refresh`, `Maj_Zones`, `Cleanchamps` → `Private`.

### Séparation traitement / GUI

`EnregistreCommercial(sCode, sNom, sPrenom, fComm)`, `SupprimeCommercial(sCode)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique sur `Fiches_Commerciaux.code` (doublons possibles aujourd'hui).
- Clé étrangère `Fiches_Cli.cli_comm` → `Fiches_Commerciaux.code`.
