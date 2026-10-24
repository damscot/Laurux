# GesTar — Architecture

> Source : `.src/Gestion/Entrées/GesTar.class`

## Vue d'ensemble

`GesTar` est le **panneau de gestion des tarifs de vente** affiché dans l'onglet « Tarifs » de
l'écran d'achat [`commande1`](../../Stock/commande1.class/architecture.md). C'est un formulaire
**incrusté** : `commande1:66` l'instancie par `New GesTar(Ptarif) As "Tarif"` et reçoit ses
événements `EnrTar` et `CoulBout`.

Pour l'article de la ligne d'achat courante, il présente trois tableaux de saisie
[`SaiTableau`](../../../Utils/SaiTableau.class/architecture.md), tous créés `As "Tarif"` :

- `$targen` : tarif général (ligne 0 = valeurs actuelles en lecture, ligne 1 = nouveau tarif) ;
- `$tarpcli` : tarifs par client (`Fiches_Tarcli`) ;
- `$tartypcli` : tarifs par type de client (`Fiches_TarTypcli`).

Chaque ligne porte un prix de revient (`Px_Rev`), un coefficient exprimé en marge (`Coef`,
`"25,00%"`), le prix de vente HT et TTC ; les colonnes `*_Ar` rappellent les valeurs actuelles.
Le calcul est une **cascade `LPrix` + `LTaxe`** : `LPrix(Px_Rev, 1, art_cdarr)` +
`LTaxe(coef, Marge)` + `LTaxe(taux_tva %, TVA)`, lue par `PuNHT`/`PuNTC`.

Les valeurs saisies sont conservées par ligne d'achat dans un objet
[`VarMajTar`](../../Stock/VarMajTar.class/architecture.md) (`Sailig.AutresObj[Achat.Tarif]`,
collections `TarGen`/`TarCli`/`TarTcli`). À l'enregistrement de l'achat, `commande1` appelle :

- `EnrTarTemp` (via l'événement `Achat.EnrTarTemp`) : tarifs **temporaires** dans
  `Fiches_TarTemp` (appliqués plus tard par [`DateTar.EnrTouTar`](../DateTar.class/architecture.md)
  si une date de mise à jour est fixée) ;
- `EnrTar` / `EnrTarArt` : application immédiate dans `Fiches_Art`, `Fiches_Tarcli`,
  `Fiches_TarTypcli` ;
- `EnrArt` (dernier fournisseur, dernier prix, date) et `EnrEtiqu` (étiquettes à imprimer).

Nature globale : **mixte** ; le calcul et le SQL sont mêlés aux accès aux contrôles des lignes.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TarGen` | enum | Public | oui |  | 3 |
| `TarCli` | enum | Public | oui |  | 3 |
| `TarTcli` | enum | Public | oui |  | 3 |
| `SupLigne` | enum | Public | oui |  | 4 |
| `ModLigne` | enum | Public | oui |  | 4 |
| `SupFin` | enum | Public | oui |  | 4 |
| `Bsel` | var | Public |  | Boolean | 6 |
| `Bval` | var | Public |  | Variant | 7 |
| `$resart` | var | Private |  | Result | 9 |
| `$targen` | var | Private |  | SaiTableau | 10 |
| `$tarpcli` | var | Private |  | SaiTableau | 11 |
| `$tartypcli` | var | Private |  | SaiTableau | 12 |
| `$ligart` | var | Private |  | SaiLig | 13 |
| `$ligach` | var | Private |  | Sailig | 14 |
| `$prop` | var | Private |  | New ObjProp[] | 15 |
| `$lv` | var | Private |  | ListView | 16 |
| `LecArt` | property | Public |  | Sailig | 18 |
| `ligachat` | property | Public |  | Sailig | 19 |
| `EnrTar` | event | Public |  |  | 21 |
| `CoulBout` | event | Public |  |  | 22 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 24-116 | Public | 2 | 73 | 0 | méthode spéciale |
| `_ready` | 118-131 | Public | 1 | 11 | 0 | méthode spéciale |
| `cre1` | 133-172 | Private | 1 | 34 | 0 |  |
| `cre2` | 174-210 | Private | 1 | 31 | 0 |  |
| `LpxTar_change` | 213-219 | Public | 1 | 5 | 0 | handler GUI |
| `ligne_gotfocus` | 222-226 | Public | 1 | 3 | 0 | handler GUI |
| `Ligne_lostfocus` | 228-233 | Public | 2 | 4 | 0 | handler GUI |
| `Rechc_click` | 235-246 | Public | 3 | 9 | 0 | handler GUI |
| `Recht_click` | 248-268 | Public | 4 | 18 | 0 | handler GUI |
| `Coef_lostfocus` | 270-293 | Public | 6 | 21 | 0 | handler GUI |
| `Px_HT_lostfocus` | 295-304 | Public | 3 | 7 | 0 | handler GUI |
| `Px_TTC_lostfocus` | 306-312 | Public | 2 | 5 | 0 | handler GUI |
| `Numero_lostfocus` | 314-320 | Public | 3 | 5 | 0 | handler GUI |
| `Type_lostfocus` | 322-328 | Public | 3 | 5 | 0 | handler GUI |
| `ListView_click` | 331-337 | Public | 2 | 5 | 0 | handler GUI |
| `ListView_keypress` | 339-345 | Public | 2 | 5 | 0 | handler GUI |
| `LecArt_Read` | 347-351 | Private | 1 | 3 | 0 |  |
| `LecArt_Write` | 353-378 | Private | 4 | 23 | 0 |  |
| `Tarif_ajou` | 380-406 | Public | 4 | 24 | 0 | handler GUI |
| `ligne_SupLig` | 408-418 | Public | 3 | 10 | 0 | handler GUI |
| `SupLig` | 420-432 | Private | 4 | 9 | 0 |  |
| `climan` | 435-458 | Private | 7 | 20 | 0 |  |
| `typeman` | 460-483 | Private | 5 | 20 | 0 |  |
| `affman` | 485-496 | Private | 2 | 10 | 0 |  |
| `Delete` | 498-513 | Public | 5 | 12 | 1 |  |
| `Enreg_Click` | 516-522 | Public | 1 | 5 | 0 | handler GUI |
| `Etiqu_Click` | 524-528 | Public | 1 | 3 | 0 | handler GUI |
| `ButArt_Click` | 530-540 | Public | 2 | 8 | 0 | handler GUI |
| `EnrArt` | 542-552 | Public | 1 | 8 | 1 |  |
| `EnrTarArt` | 554-592 | Public | 8 | 33 | 0 | portée réductible ? |
| `EnrTar` | 594-643 | Public | 14 | 43 | 1 |  |
| `EnrTarTemp` | 645-695 | Public | 12 | 47 | 1 |  |
| `dettartemp` | 697-715 | Private | 2 | 15 | 0 |  |
| `SupTarTemp` | 718-722 | Public | 1 | 3 | 1 |  |
| `EnrEtiqu` | 724-748 | Public | 4 | 21 | 1 |  |
| `majtarif_Click` | 751-762 | Public | 3 | 9 | 0 | handler GUI |
| `dtmaj_Click` | 764-775 | Public | 2 | 10 | 0 | handler GUI |
| `dte_LostFocus` | 777-785 | Public | 2 | 7 | 0 | handler GUI |
| `ligachat_Read` | 787-791 | Private | 1 | 3 | 0 |  |
| `ligachat_Write` | 793-819 | Private | 5 | 24 | 0 |  |
| `affichetarif` | 821-874 | Private | 14 | 48 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(lig)`** [portée : nécessaire (spéciale)] [nature : GUI]. Argument réel :
  `(Parent, lig)` (`commande1` ne passe que le parent). Lit un article quelconque
  (`SELECT * FROM Fiches_Art JOIN Fiches_Tvaav … LEFT JOIN Fiches_TarTemp … LIMIT 1`) pour les
  `Fields` des colonnes ; **base sans article → `Return` avant la création des tableaux** (les
  méthodes suivantes échouent alors sur des objets nuls, à confirmer). Construit les trois
  `SaiTableau` (`cre1` : colonnes `*_Ar` en lecture, `cre2` : colonnes saisissables) avec des
  requêtes `LIMIT 1` sur `Fiches_Tarcli,Fiches_Cli,Fiches_TarTemp` et
  `Fiches_TarTemp,Fiches_TarTypcli,Fiches_Typec` (produits cartésiens, seulement pour les
  `Fields`).
- **`_ready()`** [portée : nécessaire (spéciale)] [GUI]. Ajoute les deux lignes du tarif général
  et des observateurs sur la ligne 1. L'observateur `As "Px_Rev"` n'a **aucun handler**
  `Px_Rev_*` : code mort.
- **`cre1`, `cre2`** (privés) [GUI]. Descriptions `ObjProp` des colonnes (décimales `art_nbd`).

### Saisie (handlers d'observateurs)

- **`Tarif_ajou(sl)`** [handler : événement `ajou` des trois `SaiTableau`] [mixte]. Pose les
  observateurs `Ligne`, `Coef`, `Px_HT`, `Px_TTC`, `Rechc`/`Numero` ou `Recht`/`Type` ; crée
  `sl.prx = New LPrix(Px_Rev, 1, art_cdarr) As "LpxTar"` et `AutresObj[SupLigne/ModLigne]`.
- **`LpxTar_change(value)`** [handler] [GUI]. Écrit `Px_Rev`, `Px_HT`, `Px_TTC` de la ligne
  **courante** `$ligart` (pas forcément celle du `LPrix` qui change).
- **`ligne_gotfocus` / `Ligne_lostfocus` / `ligne_SupLig`** [handlers de l'observateur `Ligne`]
  [mixte]. Mémorise la ligne ; à la sortie, sauvegarde les trois tableaux dans le `VarMajTar` de
  la ligne d'achat (`SauvColl`) — ⚠️ `$ligach` nul si aucun article n'a encore été lu (erreur,
  à confirmer) ; suppression : barre et désactive la ligne (`SupLig`, `AutresObj[SupLigne]`).
- **`Coef_lostfocus()`** [handler] [mixte]. Normalise le coefficient (`.`→`,`, un coefficient
  multiplicateur `1,25` devient `25,00%`), applique `Marge` + `TVA` au `LPrix` de la ligne,
  colore le bouton Enregistrer et lève `CoulBout`.
- **`Px_HT_lostfocus()`** [handler] [mixte]. Coefficient = `Px_HT / Px_Rev − 1` ; ⚠️ division
  par zéro si `Px_Rev = 0` (ligne 300). **`Px_TTC_lostfocus()`** : HT = TTC / (1 + TVA).
- **`Rechc_click`** [handler] [mixte]. `TriCpt` clients (écrit `Bsel`/`Bval` par
  `Object.SetProperty`) puis `climan`. **`Recht_click`**, **`ListView_click`**,
  **`ListView_keypress`** : liste des types de client (`Fiches_Typec`) dans un `ListView` créé par
  code. **`Numero_lostfocus`**, **`Type_lostfocus`** : contrôles `climan`/`typeman`.
- **`climan()` / `typeman()`** (privés) [mixte]. Existence du client (`Fiches_Cli`) ou du type
  (`Fiches_Typec`) et unicité dans le tableau ; `affman` recopie les valeurs actuelles de
  l'article et le prix de revient du tarif général.
- **`SupLig()`** (privé) [GUI]. Police barrée, contrôles désactivés, `valide = True`.

### Liaison avec la ligne d'achat

- **Propriété `LecArt`** [portée : nécessaire, `commande1:243`] [mixte]. `LecArt_Write` : lit
  l'article dans le `VarMajTar` de la ligne (`maj.LecArt`, qui exécute les requêtes de tarifs),
  libellé, couleur du bouton, visibilité du bouton Étiquettes. Huit variables locales inutilisées (`res`, `res1`, `obj`, `i`, `req`, `obs`, `col`, `lcol`).
- **Propriété `ligachat`** [portée : nécessaire, `commande1:203`] [mixte]. `ligachat_Write` :
  réaffiche les trois tableaux depuis les collections du `VarMajTar` (`affichetarif`).
- **`affichetarif(tar, lcol, Px_Rev, bgen)`** (privé, CC 14) [mixte]. Remplit les contrôles
  `TextReg` par nom de colonne, recalcule la cascade de prix, rétablit suppression/modification.

### Enregistrement

- **`Enreg_Click()`** [handler du bouton public `!Enreg`] [mixte]. `Utils.db.Begin`,
  `Raise EnrTar` (→ `commande1.Tarif_EnrTar`, qui fait lui-même `Begin`/`EnrTar`/`Commit`), puis
  `Commit` : transactions imbriquées (comportement du pilote à confirmer).
- **`EnrTarArt(ach)`** [portée : réductible, appelée seulement par `EnrTar`] [nature : calcul].
  Si la mise à jour est demandée (`IgnoreTarif`, nom inversé) et la date atteinte : met à jour
  `Fiches_Art` (`art_prvt`, `art_pauaht`, `art_pvht`, `art_pvttc`, `art_frais`, `art_pbht`,
  `art_paht`, `art_txconv`, `art_tr`, `art_coef`) et supprime le tarif temporaire général.
  ⚠️ `art_tr = Val(Left(Rem, -1))` suppose un `%` final (ligne 583).
- **`EnrTar(ach, fournisseur)`** (CC 14, max du fichier) [portée : nécessaire, `commande1:610,818,844,873`]
  [mixte]. `EnrTarArt`, puis remplace les tarifs client (`DELETE` puis `Create9` de
  `Fiches_Tarcli`) et type client (`Fiches_TarTypcli`) et supprime les `Fiches_TarTemp`
  correspondants. `fournisseur` est inutilisé.
- **`EnrTarTemp(…, ach)`** [portée : nécessaire, `commande1:880`] [calcul]. Pour chaque tarif non
  modifié (`col["modif"]` faux) : `Edit` ou `Create9` de `Fiches_TarTemp` (`temp_type` 1/2/3,
  `code`), détail par `dettartemp` (privé).
- **`SupTarTemp()`** [portée : nécessaire, `commande1:508`] [calcul]. Supprime les tarifs
  temporaires de l'article **`$resart` courant** ; ⚠️ `commande1.suppr_Click` l'appelle dans une
  boucle sur les lignes sans changer d'article.
- **`EnrArt(fournisseur, dte)`** [portée : nécessaire, `commande1:611,819`] [calcul].
  `art_dfour`, `art_dpa = $resart!art_pbht`, `art_ddate`. ⚠️ `$resart` est la fiche lue avant
  `EnrTarArt` : `art_dpa` reçoit l'**ancien** prix brut (à confirmer).
- **`EnrEtiqu(sl)`** [portée : nécessaire, `commande1:820`] [calcul]. Incrémente
  `Fiches_EtiProd.nombre` de la quantité et crée `Fiches_EtiGond` si absent.
- **`Delete()`** [portée : nécessaire, `commande1:541`] [GUI]. Vide le tarif général, détruit
  les tableaux client et type.

### Autres handlers

- **`majtarif_Click`** [handler du contrôle public `!majtarif`] : `IgnoreTarif` ; active la date.
  **`dtmaj_Click`**, **`dte_LostFocus`** : date de mise à jour (`DateTarif`).
  **`Etiqu_Click`** : `EtiqRecpt.Show`. **`ButArt_Click`** : fiche article puis relecture.

## État global utilisé

- `Utils.db` (`Exec`, `Edit`, `Create9`, `Delete`, `Begin`, `Commit`), `Utils.totobs`.
- `Achat.Tarif`, `Achat.FicheArt` (index de `Sailig.AutresObj`), `VarMajTar`.
- Tables en dur : `Fiches_Art`, `Fiches_Tvaav`, `Fiches_TarTemp`, `Fiches_Tarcli`,
  `Fiches_TarTypcli`, `Fiches_Cli`, `Fiches_Typec`, `Fiches_EtiProd`, `Fiches_EtiGond`.
- `Bsel`/`Bval` `Public`, écrits par `TriCpt` (`Object.SetProperty`).
- Énumérations publiques `TarGen/TarCli/TarTcli` (valeurs 1/2/3 de `Fiches_TarTemp.temp_type`)
  et `SupLigne/ModLigne`, lues par `DateTar`, `VarMajTar`, `commande1`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `EnrTar` : les deux blocs client / type sont identiques au nom de table, de colonne et de
  `temp_type` près → helper privé `EnrTarifs(lcol, table, colonne, ttype)`.
- `EnrTarTemp` : trois blocs `Edit`/`Create9` identiques → helper `TarTempLigne(ttype, code)`.
- `_new` : `cre1`/`cre2` sont appelés avec les mêmes arguments pour deux tableaux ; une table de
  description par tableau simplifierait la construction.
- Supprimer les variables locales et l'observateur `Px_Rev` inutilisés.

### Commonalisation avec d'autres fichiers

- **Cascade de prix de vente** `LPrix(pxrev, 1, arrondi)` + coefficient (`Marge`, ou `Remise`
  négative) + `TVA` → `PuNHT`/`PuNTC` : `Coef_lostfocus`, `affichetarif`, `EnrTarArt` (ici),
  [`DateTar.EnrTouTar`](../DateTar.class/architecture.md) (lignes 191-195, 214-217),
  [`VarMajTar.constructiontableau`](../../Stock/VarMajTar.class/architecture.md) (lignes 123-136, appelée par `LecArt`),
  [`TarTypeCli`](../../Tables/TarTypeCli.class/architecture.md) (`Tcoeff_Lostfocus`,
  `Remise_LostFocus`, `Tpvht_LostFocus`) et
  [`calculdroit1`](../../option/calculdroit1.class/architecture.md). Proposition phase 3 : une
  fabrique `PrixVente(pxrev, coef, tauxTva, arrondi) As LPrix` (module ou méthode statique de
  `LPrix`). Les variantes doivent être prouvées équivalentes par test : `Marge x %` ≡
  `Remise −x %` (le signe de `Remise` est inversé par `LTaxe.Ttx_Write`), mais `TarTypeCli`
  passe un **montant** de remise et
  [`TarArt`](../../../Utils/TarArt.class/architecture.md) calcule `art_prvt × coef` sans `LPrix`
  ni arrondi `art_cdarr` (écart possible avec les prix affichés ici).
- `climan` / liste des types (`Recht_click`) : mêmes recherches dans `TarTypeCli`
  (`TypeC_man`, `Button4_click`).
- `Coef_lostfocus` (coefficient ↔ pourcentage de marge) et la conversion inverse
  `1 + Val(Left(coef, -1)) / 100` (répétée 4 fois) : helper `CoefDepuisMarge`/`MargeDepuisCoef`
  partageable avec `DateTar` (`(temp_coef − 1) × −100`).

### Réduction de portée

- `EnrTarArt` → `Private` (seul appelant : `EnrTar`, vérifié par `grep -rn`).
- `Enreg_Click` et `majtarif_Click` sont des handlers de contrôles publics du `.form`
  (`!Enreg`, `!majtarif`) : faux positifs « unused » de `deps.py`, ils restent `Public`.
- `Bsel`/`Bval` restent `Public` (`TriCpt`).

### Séparation traitement / GUI

- `EnrTarArt`/`EnrTar`/`EnrTarTemp` lisent surtout des collections et des `Result` ; seuls
  `ach.MonControle[…]` et `Enreg.Background` touchent la GUI → passer les valeurs de la ligne en
  paramètres et laisser la couleur du bouton à l'appelant.
- `Coef_lostfocus`/`Px_HT_lostfocus` : extraire la conversion coefficient ↔ prix dans des
  fonctions pures.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_TarTemp` mélange trois natures de tarif (`temp_type` 1/2/3) avec un `code` texte
  (`" "` pour le tarif général) : une table par nature ou un `code` nullable clarifierait les
  requêtes.
- Coefficients stockés en multiplicateur (`coef`, `temp_coef`, `art_coef`) mais saisis en
  pourcentage de marge : stocker une seule représentation éviterait les conversions.
- Clé `Cbase` absente pour `Fiches_TarTemp`.
