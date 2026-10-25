# VarMajTar — Architecture

> Source : `.src/Gestion/Stock/VarMajTar.class`

## Vue d'ensemble

`VarMajTar` est l'**état tarifaire d'une ligne de saisie d'achat** (réception ou commande
fournisseur). Une instance est créée pour chaque ligne par `Achat.ajout`
(`Achat.class:476`, `AutresObj[Achat.Tarif] = New VarMajTar`) et rangée dans le tableau
`Sailig.AutresObj` de la ligne. L'écran de tarifs [`GesTar`](../../Entrées/GesTar.class/architecture.md)
la lit (`LecArt`, `ResArt`, `TarGen`, `TarCli`, `TarTcli`, `MajTar`, `DateTarif`, `IgnoreTarif`)
pour afficher et enregistrer les tarifs de vente provisoires de l'article (`Fiches_TarTemp`).

Elle contient trois listes de `Collection` (une collection par ligne de tarif, clé = nom du
contrôle de la grille `SaiTableau` de `GesTar`) :

| Propriété | Contenu | Source |
|---|---|---|
| `TarGen` | 2 collections : `[0]` = tarif général de la fiche article, `[1]` = tarif provisoire (`Fiches_TarTemp`, `temp_type = GesTar.TarGen`) ou à défaut la fiche | `LecArt` |
| `TarCli` | une collection par client ayant un tarif (`Fiches_Tarcli`) ou un tarif provisoire | requête préparée `requ_cli` |
| `TarTcli` | une collection par type de client (`Fiches_TarTypcli`, `Fiches_Typec`) | requête préparée `requ_typ` |

Chaque collection reçoit en plus les clés `sup` (ligne à supprimer) et `modif` (ligne modifiée
ou non encore enregistrée), et pour les tarifs client/type les prix recalculés `Px_HT`,
`Px_TTC`, `Px_HT_Ar`, `Px_TTC_Ar` (cascade `LPrix` + remise négative = marge + TVA).

Nature globale : **traitement** (SQL + calculs de prix), avec une dépendance aux contrôles
de la ligne (`Sailig.MonControle["Code"]`, `["Px_Rev"]`) et aux requêtes préparées par
[`commande1`](../commande1.class/architecture.md) (`commande1.class:83-84`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$var` | var | Private |  | New VarMajTar[] | 3 |
| `$ligach` | var | Private |  | Sailig | 4 |
| `IgnoreTarif` | property | Public |  | Boolean | 6 |
| `MajTar` | property | Public |  | Boolean | 7 |
| `DateTarif` | property | Public |  | LDate | 8 |
| `TarGen` | property | Public |  | Collection[] | 9 |
| `TarCli` | property | Public |  | Collection[] | 10 |
| `TarTcli` | property | Public |  | Collection[] | 11 |
| `ResArt` | property | Public |  | Result | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-23 | Public | 1 | 5 | 0 | méthode spéciale |
| `Delete` | 25-31 | Public | 4 | 5 | 0 | portée réductible ? |
| `LecArt` | 33-87 | Public | 15 | 48 | 1 |  |
| `constructiontableau` | 89-143 | Private | 11 | 47 | 0 |  |
| `SauvColl` | 146-152 | Public | 1 | 5 | 0 | portée réductible ? |
| `affecttar` | 154-174 | Private | 4 | 18 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : calcul]. Initialise `IgnoreTarif = True`,
  `MajTar = False`, `DateTarif = Null`.
- **`Delete()`** [portée : nécessaire, appel dynamique] [nature : calcul]. Vide `TarGen`, `TarTcli`,
  `TarCli` (`Try … .Clear`). `deps.py` la signale `unused` : **faux positif**, elle est appelée
  par `Sailig.Delete` (`Sailig.class:104`, `Try obj.Delete` sur chaque élément de `AutresObj`).
  ⚠️ `$targen` (casse différente de `$TarGen`) désigne la même variable : Gambas est insensible à
  la casse.
- **`LecArt(Value, targ, tarc, tart)`** (CC 15, max du fichier) [portée : nécessaire, `GesTar.class:367`]
  [nature : mixte ; lecture de `Value.MonControle["Code"].Text` et `["Px_Rev"].Value`].
  1. Sort si le code article est vide ; mémorise la ligne dans `$ligach`.
  2. `SELECT * FROM Fiches_Art JOIN Fiches_Tvaav ON art_tva=code_tva LEFT JOIN Fiches_TarTemp
     ON art_code=art AND temp_type=&2 WHERE art_code=&1` (`&2 = GesTar.TarGen = 1`) → `ResArt`.
     Tables en dur (pas de `Cbase.Table`).
  3. `MajTar` = `dtmaj` du tarif provisoire ; `DateTarif = LDate(date)` si vrai.
     `IgnoreTarif` est **remis à `True`** à chaque lecture (la valeur saisie dans `GesTar` est
     ensuite réécrite par `GesTar.class:754`, et relue de `Fiches_Ligbr` par `Achat.class:622`).
  4. Construit `TarGen[0]` et `TarGen[1]` en parcourant `targ` (`ObjProp` de la grille générale
     de `GesTar` : `Px_Rev`, `Coef`, `Px_HT`, `Px_TTC`) : pour `Coef`/`Coef_Ar`, la marge
     affichée est `Str((coef - 1) * 100) & "%"` ; pour `i = 0` ou si `temp_coef` est nul, on prend
     `art_coef` et on ajoute `Px_HT`/`Px_TTC` de la fiche, sinon `temp_coef` **sans** `Px_HT`/`Px_TTC`
     (recalculés ensuite par `GesTar.affichetarif`, à confirmer).
  5. `Utils.db.Set("@code", art_code)` puis `Utils.db.Execute("requ_cli")` et `("requ_typ")` :
     requêtes préparées dans `commande1._new` (`commande1.class:83-84`). Sous MySQL :
     `EXECUTE requ_cli`. Sous **SQLite**, `DB_Connection.Execute` évalue le SQL comme une
     expression Gambas et échoue (anomalie DB_CONNECTION-A05, voir
     [`DB_Connection`](../../../Utils/DB_Connection.class/architecture.md)) : l'écran de tarifs des
     achats est inutilisable sous SQLite (VARMAJTAR-A02).
  6. `TarCli`/`TarTcli` = `constructiontableau(…)` si la requête renvoie des lignes, sinon la
     valeur précédente est **conservée** (pas de remise à `Null`, à confirmer : une même instance
     n'est relue que pour le même article en pratique).
  Variables locales inutilisées : `res1`, `req`, `obs` ; ligne 45 commentée.
- **`constructiontableau(tar, res, Px_Rev)`** [portée : Private] [nature : calcul].
  Pour chaque ligne de `res` : collection des champs de `tar` (marge `Coef`/`Coef_Ar` en `%`,
  repli sur `art_coef` ou `coef` du type client si la colonne est nulle ; `Px_Rev` = paramètre),
  `sup`, `modif`, puis **cascade de prix** :
  `LPrix(col["Px_Rev_Ar"], 1, art_cdarr)` + `LTaxe("-" & col["Coef_Ar"], Remise)` +
  `LTaxe(taux_tva & "%", TVA)` → `Px_HT_Ar = PuNHT.G`, `Px_TTC_Ar = PuNTC.G` ; idem avec `Px_Rev`
  et `Coef` → `Px_HT`, `Px_TTC`. La remise négative `-x %` vaut une marge de `x %`
  (`LTaxe.Ttx_Write` inverse le signe, voir [`LPrix`](../../../Utils/LPrix.class/architecture.md)).
  ⚠️ Ligne 121 : `sup` prend `$resart!temp_sup` (tarif **général**) au lieu de `res!temp_sup`
  (tarif de la ligne client/type) dès que ce dernier n'est pas nul (VARMAJTAR-A01).
  ⚠️ Une marge négative (`coef < 1`) donne `"--5%"` après concaténation du signe : comportement
  de `LTaxe` à confirmer (VARMAJTAR-A03).
  Variable locale `obs` inutilisée ; ligne 107 commentée.
- **`SauvColl(tg, tc, tt)`** [portée : nécessaire, appel dynamique] [nature : mixte].
  Recopie l'état des trois grilles `SaiTableau` de `GesTar` dans `TarGen`/`TarCli`/`TarTcli` via
  `affecttar`. `deps.py` la signale `unused` : **faux positif**, elle est appelée par
  `GesTar.Ligne_lostfocus` (`GesTar.class:230`) à travers un `Variant`
  (`$ligach.AutresObj[Achat.Tarif].SauvColl(…)`), que l'heuristique ne résout pas.
- **`affecttar(tar)`** [portée : Private] [nature : GUI] — signalée `unused_transitive` à tort
  (appelée par `SauvColl`, vivante). Pour chaque `Sailig` du tableau : texte de chaque
  `TextReg` (clé = nom du contrôle), `sup = AutresObj[GesTar.SupLigne]`, `modif = valide`.

## État global utilisé

- `Utils.db` : `Exec`, `Set`, `Execute` (requêtes préparées nommées `requ_cli`, `requ_typ`,
  partagées par toute la connexion et créées par `commande1`).
- `GesTar.TarGen` (énumération = 1), `GesTar.SupLigne` (énumération).
- Aucun accès à `Start.*` ni `Variables.*`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `LecArt` : extraire la construction de `TarGen[i]` dans une fonction privée
  `ConstruitTarGen(targ, i) As Collection` (CC 15 → ≤ 8).
- Helper privé `MargeTexte(coef) As String` pour les 4 occurrences de
  `Str((x - 1) * 100) & "%"` (lignes 61, 65, 106, 109).
- Tables en dur → `Cbase.Table("TabArt")`, `Cbase.Table("TabTvav")` (même nom physique ; `Fiches_TarTemp`
  n'a pas de clé `Cbase`, il reste en littéral).

### Commonalisation avec d'autres fichiers

- **Cascade de prix de vente** (lignes 123-137) : c'est l'un des consommateurs de la fabrique
  `PrixVente(pxrev, coef, tauxTva, arrondi) As LPrix` proposée par GESTAR-008
  ([`GesTar`](../../Entrées/GesTar.class/architecture.md)), DATETAR-005
  ([`DateTar`](../../Entrées/DateTar.class/architecture.md)) et TARTYPECLI-007
  ([`TarTypeCli`](../../Tables/TarTypeCli.class/architecture.md)). Ici la variante est exactement
  « `LPrix(pxrev, 1, art_cdarr)` + `Remise -marge %` + `TVA %` → `PuNHT.G`/`PuNTC.G` », c'est-à-dire
  la forme de référence de GESTAR-008. La substitution (VARMAJTAR-003) n'est faite qu'après la
  preuve gb.test d'équivalence (VARMAJTAR-T03), dans le même lot que GESTAR-008.
- [`MajTarifM`](../Tarifs/MajTarifM.class/architecture.md) calcule aussi un PV à partir d'un prix de
  revient et d'un coefficient, mais par chaînes formatées et arrondi au 0,05 par découpage de
  chaîne : **pas équivalent** (voir MAJTARIFM-T09) ; il n'est pas candidat à `PrixVente`.

### Réduction de portée

- Aucune : `Delete` et `SauvColl` (signalées `scope_reducible`) sont appelées dynamiquement
  (`Sailig.Delete`, `GesTar.class:230`). Les propriétés sont lues par `GesTar`.

### Séparation traitement / GUI

- `LecArt` lit deux contrôles de la ligne (`Code`, `Px_Rev`). Proposition : fonction privée
  `LecArtCode(sCode, fPxRev, targ, tarc, tart)` sans accès aux contrôles, appelée par `LecArt`
  qui garde sa signature (`GesTar` inchangé).
- `affecttar` reste GUI par nature (lecture des `TextReg`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_TarTemp` stocke un coefficient (`temp_coef`) et `Fiches_Art` un prix de revient : les
  prix HT/TTC provisoires sont recalculés à chaque lecture. Stocker la règle d'arrondi et la
  TVA appliquées éviterait les écarts quand la famille ou la TVA change entre la saisie et
  l'application (`DateTar`).
- Une clé `Cbase` pour `Fiches_TarTemp`, `Fiches_Tarcli`, `Fiches_TarTypcli`.
