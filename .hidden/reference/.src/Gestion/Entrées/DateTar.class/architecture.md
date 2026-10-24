# DateTar — Architecture

> Source : `.src/Gestion/Entrées/DateTar.class`

## Vue d'ensemble

`DateTar` (« Tarif par date ») a deux rôles :

1. **Écran de planification** des tarifs temporaires (`Fiches_TarTemp`) saisis lors des achats
   (voir [`GesTar.EnrTarTemp`](../GesTar.class/architecture.md)) : à gauche (`ListFour`) les
   articles qui ont un tarif temporaire (filtrés par fournisseur), à droite (`ListArt`) la
   sélection ; boutons pour fixer une date d'application (`Enr`), supprimer les tarifs
   (`Sup`), sélectionner les articles déjà planifiés à la date saisie (`Rech`). Ouvert depuis
   l'écran d'achat (`commande1.tardt_Click`, `commande1:856`, `New DateTar(Null, fcode.Text)`).
2. **Application des tarifs échus** au démarrage : `Fmenu:225` appelle
   `DateTar.EnrTouTar(rResult)` avec les lignes `Fiches_TarTemp` dont `dtmaj` est vrai et la
   date atteinte. Cet appel passe par l'**auto-instance** du formulaire : le constructeur
   s'exécute (requête `fournisseur_LostFocus` sur tous les tarifs temporaires) et un formulaire
   caché reste en mémoire.

Les lignes des deux listes sont identifiées par leur **texte** (`art  designation [date]`), que
quatre fonctions recalculent à l'identique pour retrouver la ligne de `$restar`.

Nature : **mixte** (écran) et **calcul + SQL** (`EnrTouTar`, à la `ProgBar` près).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$restar` | var | Private |  | Result | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-12 | Public | 1 | 6 | 0 | méthode spéciale |
| `affiche` | 14-28 | Private | 5 | 12 | 0 |  |
| `selec_Click` | 30-39 | Public | 4 | 7 | 0 | handler GUI |
| `fournisseur_LostFocus` | 41-50 | Public | 2 | 8 | 0 | handler GUI |
| `deselec_Click` | 52-61 | Public | 4 | 7 | 0 | handler GUI |
| `Sup_Click` | 63-89 | Public | 8 | 24 | 0 | handler GUI |
| `anul_Click` | 91-95 | Public | 1 | 3 | 0 | handler GUI |
| `Enr_Click` | 97-119 | Public | 6 | 20 | 0 | handler GUI |
| `Quit_Click` | 121-125 | Public | 1 | 3 | 0 | handler GUI |
| `ajou` | 127-132 | Private | 1 | 4 | 0 |  |
| `ListFour_Activate` | 134-138 | Public | 1 | 3 | 0 | handler GUI |
| `ListArt_Activate` | 140-144 | Public | 1 | 3 | 0 | handler GUI |
| `Rech_Click` | 146-163 | Public | 6 | 14 | 0 | handler GUI |
| `supr` | 165-170 | Private | 1 | 4 | 0 |  |
| `EnrTouTar` | 172-254 | Public | 13 | 77 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Écran

- **`_new(four)`** [portée : nécessaire (spéciale)] [GUI]. Arguments réels `(Parent, four)`.
  Date du jour, fournisseur, puis `fournisseur_LostFocus`.
- **`fournisseur_LostFocus()`** [handler] [mixte]. `SELECT art,dtmaj,date,art_design FROM
  Fiches_TarTemp JOIN Fiches_Art ON art_code=art WHERE [art_four=&1 AND] temp_sup = False GROUP BY
  art,dtmaj,date,art_design` dans `$restar`, puis `affiche`.
- **`affiche()`** (privé) [GUI]. Vide et remplit `ListFour`. ⚠️ Résultat vide : `Return`
  **avant** le vidage, les listes gardent l'affichage précédent.
- **`selec_Click` / `deselec_Click` / `ListFour_Activate` / `ListArt_Activate`** + `ajou(i)` /
  `supr(i)` (privés) [GUI]. Déplacement des lignes sélectionnées entre les deux listes.
- **`Rech_Click()`** [handler] [GUI]. Passe à droite les articles dont la date de tarif est la
  date saisie.
- **`Enr_Click()`** [handler] [mixte]. Pour chaque ligne de `ListArt`, retrouve l'article dans
  `$restar` puis `UPDATE Fiches_TarTemp SET dtmaj = True, date = &2 WHERE art = &3` (tous les
  `temp_type` de l'article) ; rafraîchit.
- **`Sup_Click()`** [handler] [mixte]. Confirmation, `Utils.db.Begin`, même recherche,
  `Utils.db.Delete("Fiches_TarTemp", "art = &1")`, `Commit`.
  ⚠️ Dans `Enr_Click` et `Sup_Click` : boucle `For i = 0 To ListArt.Count` (une itération de
  trop → erreur d'indice probable à la fin, après les mises à jour) ; la recherche reprend au
  curseur courant de `$restar` et `j` n'est jamais réinitialisé (article non trouvé → article
  précédent ou premier) ; `Sup_Click` sort par `Return` après `Begin` si `$restar` est vide
  (transaction laissée ouverte).
- **`anul_Click()`** [handler] : `affiche` ; **`Quit_Click()`** : ferme.

### Application des tarifs

- **`EnrTouTar(rResult)`** (CC 13) [portée : nécessaire, `Fmenu:225`] [calcul + `ProgBar`].
  Dans une transaction, pour chaque ligne de `Fiches_TarTemp` :
  - au **changement d'article** (`art <> rResult!art`) : relit la fiche (`Utils.db.Edit`) et la
    TVA (`Fiches_Tvaav`, sans test `Available`), construit
    `LPrix(pxrev, 1, art_cdarr)` + `LTaxe((temp_coef − 1) × −100 %, Remise)` + TVA, et met à jour
    `art_prvt`, `art_pauaht = pbht`, `art_pvht`, `art_pvttc`, `art_frais`, `art_pbht`, `art_paht`,
    `art_txconv`, `art_tr` ; supprime le tarif temporaire général de l'article ;
  - selon `temp_type` : général → `art_pvht`, `art_pvttc`, `art_coef` ; client → `Edit`/`Create9`
    ou `Delete` (si `temp_sup`) de `Fiches_Tarcli` ; type → idem `Fiches_TarTypcli` ; puis
    suppression de la ligne temporaire.
  `Catch` : message et `Rollback`.
  ⚠️ Le prix général écrit au changement d'article utilise le coefficient de la **première**
  ligne rencontrée, quel que soit son `temp_type` : sans ligne de tarif général, `art_pvht` et
  `art_pvttc` reçoivent le coefficient d'un tarif client ou type. ⚠️ `art_pauaht` reçoit le prix
  brut, alors que `GesTar.EnrTarArt` y écrit le prix net unitaire × conversion (à confirmer).
  `rResult` n'est pas trié par article (`Fmenu:223`, pas d'`ORDER BY`) : une fiche peut être
  réécrite plusieurs fois (mêmes valeurs).

## État global utilisé

- `Utils.db` (`Exec`, `Edit`, `Create9`, `Delete`, `Begin`, `Commit`, `Rollback`).
- `GesTar.TarGen/TarCli/TarTcli` (valeurs de `temp_type`).
- Tables en dur : `Fiches_TarTemp`, `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Tarcli`,
  `Fiches_TarTypcli`.
- Membre `$restar` (résultat partagé par tous les handlers, curseur déplacé par chacun).

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `TexteLigne() As String` (texte d'une ligne de `$restar`, répété 4 fois) et
  `ChercheArticle(txt) As Integer` (recherche depuis le début) pour `Enr_Click`/`Sup_Click` —
  à faire **sans** corriger la borne ni le point de départ de la recherche (anomalies).
- `EnrTouTar` : séparer la mise à jour de la fiche article (changement d'article) du traitement
  par `temp_type`.

### Commonalisation avec d'autres fichiers

- Cascade de prix de vente : même calcul que
  [`GesTar`](../GesTar.class/architecture.md) (`Coef_lostfocus`, `EnrTarArt`) et
  [`VarMajTar`](../../Stock/VarMajTar.class/architecture.md) (fabrique commune proposée en
  GESTAR-008). Ici le coefficient est passé en `Remise` négative, ailleurs en `Marge`.
- Application d'un tarif client / type (`Edit` sinon `Create9`, ou `Delete`) : même logique que
  `GesTar.EnrTar` (qui supprime puis recrée), à unifier.
- Listes de transfert gauche/droite (`selec`/`deselec`) : patron présent dans d'autres écrans
  de sélection (à recenser en phase 3).

### Réduction de portée

- Aucune : les fonctions publiques sont des handlers ou `EnrTouTar` (`Fmenu`).
- `EnrTouTar` peut devenir `Static Public` : l'appel `DateTar.EnrTouTar` de `Fmenu` reste
  identique et n'instancie plus le formulaire caché.

### Séparation traitement / GUI

- `EnrTouTar` : la seule partie GUI est la `ProgBar` ; passer la barre (ou un rappel) en
  paramètre optionnel permettrait un gb.test sans affichage.
- `Enr_Click`/`Sup_Click` : séparer la liste des articles sélectionnés (lecture de `ListArt`)
  des requêtes (`PlanifieTarifs(articles, date)`, `SupprimeTarifs(articles)`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un index sur `Fiches_TarTemp(dtmaj, date)` accélérerait la requête de démarrage
  (`Fmenu:223`).
- Clé `Cbase` absente pour `Fiches_TarTemp`.
