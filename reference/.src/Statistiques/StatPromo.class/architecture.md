# StatPromo — Architecture

> Source : `.src/Statistiques/StatPromo.class`

## Vue d'ensemble

`StatPromo` est l'écran « Statistiques promotions » (menu Statistiques › « Statistiques
promotions », `Fmenu.Menu223_Click`, `StatPromo.ShowModal()` : auto-instance modale).
L'utilisateur choisit un code promotion (`CodeP` + Entrée, ou liste `ColPromo` ouverte par F2 /
`Button3`), puis **Afficher** (`Button1`) montre dans le panneau `Panel1` la grille `Liste` des
articles de la promotion (`Fiches_ArtPromo` : code, désignation, PMP, PV HT, PV TTC, quantité,
marge) et les totaux `Tht`, `Tttc`, `Tqte`, `Tmarge`.

La quantité `Fiches_ArtPromo.qte` est alimentée par la **caisse** (`ArtPromo.Maj_qteplus`
appelé par `Caisse` lors de la validation d'un ticket) : c'est la seule statistique du lot qui
reflète directement les ventes en caisse. Elle ne lit aucune table de ventes et n'utilise pas la
table de travail `Total` (le texte « Total » du `.form` est un libellé).

Nature globale : **GUI** avec SQL de lecture seule ; pas de couple `VisStat*`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoulZns` | var | Private |  | Integer | 27 |
| `CoulZnaf` | var | Private |  | Integer | 28 |
| `Coulfc` | var | Private |  | Integer | 29 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 31-48 | Public | 1 | 14 | 0 | méthode spéciale |
| `Button2_Click` | 50-54 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 59-90 | Public | 5 | 29 | 0 | handler GUI |
| `CodeP_KeyPress` | 95-112 | Public | 5 | 15 | 0 | handler GUI |
| `ColPromo_Click` | 117-124 | Public | 1 | 6 | 0 | handler GUI |
| `ColPromo_KeyPress` | 129-137 | Public | 5 | 7 | 0 | handler GUI |
| `Button1_Click` | 139-148 | Public | 2 | 8 | 0 | handler GUI |
| `Button5_Click` | 150-154 | Public | 1 | 3 | 0 | handler GUI |
| `Affichage` | 156-212 | Public | 12 | 54 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : `Balloon.Delay = 1500`, lecture
  des couleurs `CoulZnaf`, `CoulZns`, `Coulfc` (**jamais relues**), `Frmt` (`/Coul/Fnets`,
  inutilisé), `Utils.Observers(Me)` une fois, `Music.Load`, centrage.
- **`Button2_Click()`** (« Quitter ») [handler] : fermeture.
- **`Button3_Click()`** [handler] [nature : mixte] : bascule l'affichage de `ColPromo` ; à
  l'ouverture, `SELECT * FROM <TabPromo>` et remplissage (code, libellé), sélection de la
  première ligne. `With Utils … End With` sans usage.
- **`CodeP_KeyPress()`** [handler] [nature : mixte] : Entrée → `SELECT * FROM <TabPromo> WHERE
  code = &1` ; trouvé : `CodeP`/`Label1` remplis ; sinon `Message.Warning("Cette promotion
  n'existe pas !")`. F2 → `Button3_Click`.
- **`ColPromo_Click()`** [handler, **appelé par le rejeu via `Object.Call` : doit rester
  `Public`**, signal `replay_dynamic`] [nature : GUI] : recopie code et libellé, masque et vide la
  liste.
- **`ColPromo_KeyPress()`** [handler] : Entrée → `ColPromo_Click` ; F2/Échap → masque la liste.
- **`Button1_Click()`** (« Afficher ») [handler] : si `Label1` est renseigné, affiche `Panel1` et
  `Affichage` ; sinon `Message.Warning("Veuillez saisir un code promotion SVP !")`. Le test porte
  sur `Label1` (dernier code **validé**) mais `Affichage` lit `CodeP.Text` (éventuellement
  modifié depuis, STATPROMO-A03).
- **`Button5_Click()`** [handler] : masque `Panel1`.
- **`Affichage()`** (CC 12, max) [portée : réductible] [nature : mixte] : configure 7 colonnes,
  `SELECT * FROM <TabArtPromo> WHERE code_promo = &1 ORDER BY code` ; formats par `Try`
  (`"0.00"`, quantité `"0.000"`) ; marge de ligne = `(pht − pmp) × qte` si la quantité est
  renseignée, cumulée dans `Tmarge` (relecture du texte affiché par `Val(cpoint())`).
  Totaux : `Pvht += pht` et `Pvttc += pttc` **sans `Try`** (colonnes nullables : erreur probable
  si un prix est NULL, STATPROMO-A01) et **non pondérés par la quantité** (somme de prix
  unitaires, alors que la marge l'est : STATPROMO-A02) ; `Qte` et `Pmp` par `Try` (`Pmp` jamais
  affiché). Partie extractible : lecture et calculs.

## État global utilisé

- `Start.LocalSettings["/Coul/…"]` (inutilisés), `Start.Musique`.
- `Utils.Observers`, `Utils.FColr`, `Utils.cpoint`, `Utils.db`,
  `Cbase.Table("TabPromo"/"TabArtPromo")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `CoulZns`, `CoulZnaf`, `Coulfc`, `Frmt`, `With Utils` inutile, le cumul `Pmp`.
- Configurer les colonnes de `Liste` une seule fois (dans `_new`) : même affichage.

### Commonalisation avec d'autres fichiers

- Sélecteur de promotion (liste `ColPromo` + saisie du code) dupliqué dans
  [`FpromoArt`](../../Gestion/Tables/FpromoArt.class/architecture.md) (`Colpromo`) et proche de
  [`EtiqPromo`](../../Gestion/Etiquettes/EtiqPromo.class/architecture.md) : une fonction
  `RemplirListePromo(hListe)` commune (requête `TabPromo`) est envisageable ; recouvrement
  mesuré faible avec `EtiqPromo` (24 lignes, ratio 0,11).
- Aucune commonalisation avec la famille `Stat*`/`VisStat*` (12 lignes communes avec `StatComm`).

### Réduction de portée

- `Affichage` → `Private` (aucun appelant externe, vérifié par `grep`). `ColPromo_Click` reste
  `Public` (handler, `replay_dynamic`).

### Séparation traitement / GUI

- `Affichage` : extraire `LignesPromo(sCode) As Variant[]` + totaux (sans contrôles).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_ArtPromo.qte` cumule les ventes sans date : une table de mouvements de promotion
  (date, ticket, quantité, prix réel) permettrait une statistique par période.
