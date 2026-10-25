# Etiquettes — Architecture

> Source : `.src/Gestion/Etiquettes/Etiquettes.class`

## Vue d'ensemble

Écran de **paramétrage des formats de planches d'étiquettes** (menu Gestion › Étiquettes ›
« Types étiquettes », `Fmenu.Menu165_Click`, ouverture non modale de l'auto-instance). Il lit et
écrit la table `Fiches_Etiquettes` (clé primaire `(code, page)`) : pour un code d'une lettre et un
format de page (`A4 Portrait`…), le nombre d'étiquettes en largeur et en hauteur, leurs dimensions,
les marges et les espacements, en **dixièmes de millimètre** (les écrans d'impression divisent par
10).

Ces formats sont consommés par tous les écrans d'impression d'étiquettes
([`Etiqart`](../Etiqart.class/architecture.md), [`Etigond`](../Etigond.class/architecture.md),
[`Etiqcasier`](../Etiqcasier.class/architecture.md), [`Eticli`](../Eticli.class/architecture.md),
[`EtiqRecpt`](../EtiqRecpt.class/architecture.md), [`EtiqPromo`](../EtiqPromo.class/architecture.md),
[`Etiqfbtarif`](../Etiqfbtarif.class/architecture.md)) et par les fiches
[`FClient`](../../Tables/FClient.class/architecture.md) /
[`FFournisseur`](../../Tables/FFournisseur.class/architecture.md).

Le libellé de la liste `Code_etiq` est `"<code>- <libellé>"` ; le code est relu par `Left$(…, 1)`
et le libellé par `Mid$(…, 4)`. Les zones numériques n'acceptent que des chiffres (`ChkInput`) et
Entrée/Tab font passer à la zone suivante.

Nature globale : **GUI + SQL** (aucun calcul).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Etiqr` | var | Private |  | Result | 27 |
| `tab` | var | Private |  | String | 28 |
| `CoulZns` | var | Private |  | Integer | 29 |
| `CoulZnaf` | var | Private |  | Integer | 30 |
| `CoulFc` | var | Private |  | Integer | 31 |
| `Err` | var | Private |  | String | 32 |
| `idx` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-52 | Public | 1 | 15 | 0 | méthode spéciale |
| `init_ComboBox` | 54-82 | Public | 7 | 24 | 0 | portée réductible ? |
| `OBS_GotFocus` | 87-95 | Public | 5 | 7 | 0 | handler GUI |
| `OBS_LostFocus` | 97-105 | Public | 4 | 7 | 0 | handler GUI |
| `SetObservers` | 107-119 | Public | 4 | 10 | 0 | portée réductible ? |
| `IsValidKey` | 121-126 | Public | 4 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 128-132 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 134-153 | Public | 3 | 18 | 0 | handler GUI |
| `PageFormat_Click` | 155-174 | Public | 2 | 18 | 0 | handler GUI |
| `Code_etiq_Click` | 176-185 | Public | 2 | 8 | 0 | handler GUI |
| `Button2_Click` | 187-198 | Public | 1 | 10 | 0 | handler GUI |
| `Button3_KeyPress` | 200-204 | Public | 3 | 3 | 0 | handler GUI |
| `Nblargeur_KeyPress` | 206-216 | Public | 3 | 9 | 0 | handler GUI |
| `Nbhauteur_KeyPress` | 218-228 | Public | 3 | 9 | 0 | handler GUI |
| `Largeur_KeyPress` | 230-240 | Public | 3 | 9 | 0 | handler GUI |
| `Hauteur_KeyPress` | 242-252 | Public | 3 | 9 | 0 | handler GUI |
| `Mrghaut_KeyPress` | 254-264 | Public | 3 | 9 | 0 | handler GUI |
| `Mrgauche_KeyPress` | 266-276 | Public | 3 | 9 | 0 | handler GUI |
| `Esplargeur_KeyPress` | 278-288 | Public | 3 | 9 | 0 | handler GUI |
| `Esphauteur_KeyPress` | 290-299 | Public | 3 | 8 | 0 | handler GUI |
| `ChkInput` | 301-309 | Public | 7 | 7 | 0 | portée réductible ? |
| `Observers2` | 311-327 | Public | 4 | 14 | 0 | portée réductible ? |
| `Button1_Click` | 329-333 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Centre la fenêtre, charge le
  son, lit les couleurs `/Coul/Znaff`, `/Coul/Focus`, `/Coul/Znss`, instrumente l'écran
  (`Utils.Observers`), pose des observateurs de focus `OBS` sur tous les `TextBox`
  (`SetObservers`), puis remplit les listes (`init_ComboBox`).
- **`init_ComboBox()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Etiquettes`
  (nom en dur ; la clé `Cbase` `TabEtiq` existe), ajoute chaque `code- libellé` une seule fois
  (dédoublonnage par `Find`, car un même code peut exister pour plusieurs pages) ; remplit
  `PageFormat` avec `Utils.PageFormatSupported()` et ne sélectionne rien. Erreur SQL ignorée
  (`Try`). Partie extractible : la requête.

### Focus (observateurs)

- **`OBS_GotFocus()` / `OBS_LostFocus()`** [portée : nécessaire (handlers d'`Observer`)] [nature :
  GUI]. Colorent la zone qui prend/perd le focus si `/Soc<XX>/Coul_fen` est vrai ; `GotFocus`
  sélectionne le texte.
- **`SetObservers(hClass, hCont)`** [portée : réductible] [nature : GUI]. Parcours récursif des
  conteneurs, `New Observer(hCtrl) As "OBS"` sur chaque `TextBox` (le paramètre `hClass` est
  inutilisé). Idiome présent dans 16 fichiers du projet.

### Saisie

- **`IsValidKey()`** [portée : réductible] [nature : GUI]. Vrai pour Entrée, Retour, Tab, BackTab.
- **`ChkInput()`** [portée : réductible] [nature : GUI]. Bloque (`Stop Event`) toute touche qui
  n'est ni un chiffre ni BackSpace/Tab/Suppr/Entrée.
- **`Nblargeur_KeyPress` … `Esphauteur_KeyPress`** (8 handlers) [portée : nécessaire (handlers)]
  [nature : GUI]. Même corps : `ChkInput`, puis, sur touche de validation non vide, focus sur la
  zone suivante (ordre : Nblargeur → Nbhauteur → Largeur → Hauteur → Mrghaut → Mrgauche →
  Esplargeur → Esphauteur → bouton Enregistrer).
- **`Observers2(hCont)`** [portée : réductible] [nature : GUI]. Contrôle que tous les `TextBox`
  **enfants directs** de `hCont` (le panneau `Param`, où sont bien les 8 zones) sont remplis ;
  sinon `Message.Warning`, focus et `Err = "1"`. `Code_etiq` et `PageFormat` (ComboBox) ne sont
  pas contrôlés.

### Lecture / écriture d'un format

- **`Code_etiq_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Appelle
  `PageFormat_Click` (lecture avec le format de page **courant**), puis positionne `PageFormat` sur
  `idx` (page trouvée) ou sur « A4 Portrait ». Voir ETIQUETTES-A02 : `idx` n'est pas remis à -1 si
  la lecture échoue, et la lecture précède le positionnement de la page.
- **`PageFormat_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Vide les zones
  (`Button2_Click`), `SELECT * FROM Fiches_Etiquettes WHERE code = &1 and page = &2` (code =
  1er caractère de `Code_etiq`), recopie les 8 valeurs et mémorise `idx`.
- **`Button3_Click()`** (Enregistrer) [portée : nécessaire (handler, appelé aussi par
  `Button3_KeyPress`)] [nature : mixte]. `Observers2(Param)` ; si tout est rempli : `SELECT` du
  couple `(code, page)`, puis `UPdate … SET code = &1, nblargeur = &2 … libelle = &{10} WHERE
  code = &1 and page = &{11}` ou `INSERT INTO Fiches_Etiquettes (…11 colonnes…)`. Les valeurs
  sont les `.Text` bruts (chaînes de chiffres). Recharge les listes et vide les zones. Sinon remet
  `Err = "0"`. Le `SET code = &1` est redondant avec le `WHERE`.
- **`Button3_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée → `Button3_Click`.
- **`Button2_Click()`** (RAZ) [portée : nécessaire (handler)] [nature : GUI]. Vide les 8 zones.
- **`Button4_Click()`** (Quitter) / **`Button1_Click()`** (aide, `Doc.Open("Etiquette")` →
  `xdg-open`) [portée : nécessaire (handlers)] [nature : GUI].

## État global utilisé

- `Start.Musique`, `Start.Societe`, `Start.LocalSettings` (`/Coul/Znaff`, `/Coul/Focus`,
  `/Coul/Znss`, `/Soc<XX>/Coul_fen`).
- `Utils.db`, `Utils.FColr`, `Utils.Observers`, `Utils.PageFormatSupported`, `Doc.Open`.
- Membres d'instance : `Etiqr` (résultat partagé entre `PageFormat_Click` et `Button3_Click`),
  `tab`, `Err` (drapeau chaîne `"0"`/`"1"`, homonyme de la fonction `Error`), `idx`, couleurs.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les 8 `*_KeyPress` dans un helper privé `Suivant(hSuivant As Control)` ; les
  handlers restent `Public` et d'une ligne (ETIQUETTES-002).
- Remplacer le drapeau chaîne `Err` par le retour booléen de `Observers2` (renommé
  `ZonesRemplies`) (ETIQUETTES-003).
- `Cbase.Table("TabEtiq")` à la place du littéral (SQL émis identique) (ETIQUETTES-004).

### Commonalisation avec d'autres fichiers

- `init_ComboBox` existe en 10 variantes (tous les écrans d'étiquettes, `FClient`,
  `FFournisseur`) avec trois formats de libellé : la lecture de `Fiches_Etiquettes` relève du socle
  `PlancheEtiquettes` décrit dans [`Etiqart`](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers)
  (méthode `Modeles()`) ; ce fichier est la seule **écriture** de la table et en serait le
  propriétaire naturel (`PlancheEtiquettes.Enregistre`).
- `OBS_GotFocus`/`OBS_LostFocus`/`SetObservers` : copie quasi exacte dans
  [`Eticli`](../Eticli.class/architecture.md) (8 fichiers du projet ont ces handlers) ; le corps
  peut devenir `Utils.CouleurFocus(Last, couleur, entree)`, les handlers restant ici (l'événement
  `OBS` est levé vers l'instance qui crée l'`Observer`).

### Réduction de portée

- `init_ComboBox`, `SetObservers`, `IsValidKey`, `ChkInput`, `Observers2` : aucun appelant externe
  (grep) → `Private` (ETIQUETTES-005). Couverture par le replay.

### Séparation traitement / GUI

- Extraire `LitFormat(code, page) As Result` et `EnregistreFormat(code, page, valeurs As
  String[], libelle)` sans accès aux contrôles ; `PageFormat_Click` et `Button3_Click` ne font plus
  que l'affichage (ETIQUETTES-006).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `code char(1)` limite à ~36 formats et impose le découpage `Left$(…, 1)`/`Mid$(…, 4)` du
  libellé : un identifiant entier et une colonne `libelle` saisie à part simplifieraient l'écran.
- Les dimensions en `decimal(5,0)` (dixièmes de mm) obligent chaque écran à diviser par 10 : un
  `decimal(6,1)` en mm supprimerait ces conversions.
- Ajouter le type d'imprimante (A4, Dymo, Zebra) au format éviterait les dimensions Dymo codées en
  dur dans `Etiqart`, `Etigond` et `EtiqRecpt`.
