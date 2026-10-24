# Fpromo — Architecture

> Source : `.src/Gestion/Tables/Fpromo.class`

## Vue d'ensemble

Écran de la **table des promotions** (`Fiches_Promo` : `code` varchar(15) clé primaire, `libelle`,
`datedeb`, `datefin`). Ouvert en modal par `Fmenu.class:1921` (`Fpromo.ShowModal()`). Les
articles d'une promotion sont gérés par [FpromoArt](../FpromoArt.class/architecture.md)
(`Fiches_ArtPromo`) ; les promotions sont appliquées par `Caisse`, `Facture`, `Articles`,
`ArtPromo.module`, éditées par `EtiqPromo` et analysées par `StatPromo`.

Contrôles : `GridView` `Colpromo` alimentée par `Utils.Base`/`Utils.rs1` et `ColPromo_Data` ;
en-têtes `CO`, `Inte`, `FO`, `FA` (simples libellés, sans filtre) ; zones du groupe `Cmpt`
(1 code, 2 libellé, 3 date de début, 4 date de fin) ; `DateChooser1` ouvert par les boutons
bascule ou un clic sur une date ; boutons `Button2` (supprimer) et `Button3` (enregistrer) du
groupe `Btn`, `Button1` (aide) et `Button4` (quitter) hors groupe.

Nature : **GUI** avec SQL dans les handlers (SQL paramétré, `Cbase.Table("TabPromo")` et
`Cbase.Table("TabArtPromo")`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 27 |
| `Promotable` | var | Private |  | New String[4] | 28 |
| `rResult` | var | Private |  | Result | 29 |
| `son` | var | Private |  | Integer | 30 |
| `CoulZns` | var | Private |  | Integer | 31 |
| `CoulZnaf` | var | Private |  | Integer | 32 |
| `Coulfc` | var | Private |  | Integer | 33 |
| `Org` | var | Private |  | Integer | 34 |
<!-- /AUTO:declarations -->

Remarque : `Tri`, `Promotable`, `rResult`, `son`, `CoulZns`, `CoulZnaf`, `Coulfc`, `Org`
(lignes 27-34, sans mot-clé, donc `Private`) ne figurent pas dans le tableau généré.
`CoulZns`, `CoulZnaf`, `Coulfc` sont calculées dans `_New` mais jamais utilisées.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-66 | Public | 1 | 27 | 0 | méthode spéciale |
| `ColPromo_Data` | 68-80 | Public | 5 | 11 | 0 | handler GUI |
| `Cmpt_GotFocus` | 85-89 | Public | 1 | 3 | 0 | handler GUI |
| `Cmpt_MouseUp` | 91-105 | Public | 3 | 10 | 0 | handler GUI |
| `Cmpt_Keypress` | 107-134 | Public | 8 | 22 | 0 | handler GUI |
| `ToggleButton1_Click` | 136-145 | Public | 2 | 8 | 0 | handler GUI |
| `ToggleButton2_Click` | 147-156 | Public | 2 | 8 | 0 | handler GUI |
| `DateChooser1_Activate` | 158-171 | Public | 2 | 12 | 0 | handler GUI |
| `Deb2` | 173-177 | Public | 1 | 3 | 0 | portée réductible ? |
| `Deb3` | 179-183 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 185-189 | Public | 1 | 3 | 0 | handler GUI |
| `Btn_Click` | 191-202 | Public | 3 | 8 | 0 | handler GUI |
| `Button3_Click` | 207-226 | Public | 4 | 18 | 0 | portée réductible ? |
| `Button2_Click` | 231-248 | Public | 4 | 16 | 0 | portée réductible ? |
| `ColPromo_Click` | 250-257 | Public | 1 | 6 | 0 | handler GUI |
| `CleanChamps` | 259-266 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 268-281 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button1_Click` | 286-290 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : mixte] : couleurs (inutilisées), `Utils.Observers`,
  `Music.Load`, libellés et largeurs de colonnes, `Tri = "code"`, `Deb2` (chargement avant
  l'ouverture), focus code.
- **`ColPromo_Data(Row, Column)`** [handler] : affichage depuis `Utils.rs1` ; colonnes 2 et 3 au
  format `dd.mm.yyyy`.
- **`Deb2()`** [portée : réductible] [nature : mixte] : `Utils.Base(Colpromo, "select * from
  <TabPromo> order by <Tri>")`.
- **`Deb3()`** [portée : réductible] : tri décroissant ; **jamais appelée** (`unused`, code mort :
  aucun en-tête ne déclenche de tri dans cet écran).
- **`Cmpt_GotFocus()`** [handler du groupe `Cmpt`] : `Utils.SetEditColor`.
- **`Cmpt_MouseUp()`** [handler du groupe `Cmpt`] : clic sur une date → bascule du calendrier.
- **`Cmpt_Keypress()`** [handler du groupe `Cmpt`] : navigation code → libellé → début → fin → code.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [handlers] : affichent/masquent le
  calendrier et mémorisent la date cible (`Org` = 1 ou 2).
- **`DateChooser1_Activate()`** [handler] : date choisie → zone cible, focus suivant.
- **`Btn_Click()`** [handler du groupe `Btn`] : 2 `Button2_Click`, 3 `Button3_Click`.
- **`Button3_Click()`** [portée : réductible] [nature : mixte] — enregistrement : si le code n'est
  pas vide, `SELECT`, puis `INSERT (code, libelle, datedeb, datefin)` ou `UPdate … SET code = &1, …
  where code = &1`, dates converties par `Utils.Cdate_Dbase` (une date vide donne `''` : erreur ou
  `0000-00-00` selon le mode SQL) ; aucun contrôle début ≤ fin ; puis `Deb2` et `CleanChamps`.
  Pseudo-handler (bouton groupé).
- **`Button2_Click()`** [portée : réductible] [nature : mixte] — suppression : confirmation puis
  `DELETE` des articles de la promotion (`<TabArtPromo>`, `code_promo = &1`) et de la promotion,
  sans transaction ; nettoyage et rechargement même si l'utilisateur répond « Non ». Pseudo-handler.
- **`ColPromo_Click()`** [handler] : `CleanChamps`, `Maj_Zones`. Rejoué par `ReplayObserver`
  (`replay_dynamic`) : **reste `Public`**.
- **`CleanChamps()`** [portée : réductible] : vide les 4 zones.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : code de la ligne courante, relecture
  `SELECT … where code = &1` sans test `Available`, dates formatées ; `Catch` muet.
- **`Button4_Click()`** [handler] : ferme. **`Button1_Click()`** [handler] : `Doc.Open("Promo")`.

## État global utilisé

- `Utils.db`, `Utils.Base`, **`Utils.rs1`**, `Utils.Observers`, `Utils.SetEditColor`,
  `Utils.FColr`, `Utils.Cdate_Dbase`, `Cbase.Table("TabPromo"/"TabArtPromo")` ; `Start.Son`,
  `Start.Musique`, `Start.LocalSettings["/Coul/*"]`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Deb3` et les trois couleurs inutilisées ; `UPdate … SET libelle, datedeb, datefin`
  sans réécrire la clé (SQL modifié, dump identique).

### Commonalisation avec d'autres fichiers

- [FpromoArt](../FpromoArt.class/architecture.md) : même en-tête de colonnes, `Colxxx_Data` sur
  `Utils.rs1`, `Deb2`, `Button1_Click` (`Doc.Open("Promo")`) ; un module `Promo` (lecture d'une
  promotion, liste, suppression en cascade) servirait aux deux écrans et à `ArtPromo.module`.
- Calendrier ouvert par bouton bascule / double-clic / F2 : même code dans
  [Edsdepots](../../Depots/Edsdepots.class/architecture.md), [MvtDepots](../../Depots/MvtDepots.class/architecture.md),
  [Sdepots](../../Depots/Sdepots.class/architecture.md) → helper `BasculeCalendrier(hDc, iCible)`.
- `Colxxx_Data` sur `Utils.rs1` : même idiome que [Cpostaux](../Cpostaux.class/architecture.md)
  (socle « grille filtrable »).

### Réduction de portée

`Deb2`, `Deb3` (supprimée), `Button3_Click`, `Button2_Click`, `CleanChamps`, `Maj_Zones` →
`Private` (pseudo-handlers et fonctions internes).

### Séparation traitement / GUI

`EnregistrePromo(sCode, sLib, sDeb, sFin)`, `SupprimePromo(sCode)` (cascade sur les articles),
`LitPromo(sCode) As Result` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_ArtPromo.code_promo` char(6) alors que `Fiches_Promo.code` est varchar(15) : aligner, et
  clé étrangère avec suppression en cascade.
- Contrainte `datedeb <= datefin`.
