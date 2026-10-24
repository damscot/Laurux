# RazArt — Architecture

> Source : `.src/Utils/RazArt.class` · Form : `RazArt.form`

## Vue d'ensemble

Fenêtre de **réinitialisation en masse de zones des fiches articles** (`Fiches_Art`), menu Gestion
« RAZ zones article » (`Fmenu.Menu279_Click`). Quatre traitements cumulables selon les cases :
- `Chk1` « Remise à zéro : stock réel, quantité de départ et de commande » ;
- `Chk2` « Pamp égal au Paht » ;
- `Stk1`/`Stk2` (boutons radio) : tous les produits non stockés / stockés ;
- `Chk3` « Raz codes barre » (tous, ou ceux qui contiennent le texte saisi dans `TextBox1`).

Aucune transaction ; opérations irréversibles sur toute la table. Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-7 | Public | 1 | 3 | 0 | méthode spéciale |
| `form_Open` | 9-11 | Public | 1 | 2 | 0 | handler GUI |
| `Button2_Click` | 13-17 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 19-72 | Public | 13 | 51 | 0 | handler GUI |
| `Chk3_Click` | 74-83 | Public | 2 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [spéciale] [GUI]. Centre la fenêtre.
- **`form_Open()`** [handler] [GUI]. Vide.
- **`Button2_Click()`** [handler] [GUI]. Ferme.
- **`Chk3_Click()`** [handler] [GUI]. Affiche/masque `TextBox1` (préfixe de code-barres).
- **`Button1_Click()`** [handler] [mixte]. Après confirmation (`Message.Question`) :
  - `Chk1` : `SELECT * FROM TabArt` (seulement pour tester qu'il y a des articles), puis
    `UPdate TabArt SET art_stocke = 0, art_com = 0, art_stkdep = 0` sur **toute** la table.
    ⚠️ Le libellé annonce « stock réel » mais c'est le **drapeau stocké** (`art_stocke`) qui est remis
    à 0 ; `art_qte` (stock réel) n'est pas touché.
  - `Chk2` : pour chaque article, `UPdate TabArt SET art_pmp = &1 WHERE art_code = &2` avec
    `art_prvt` (prix de revient) — ⚠️ le libellé annonce le **Paht**. Code identique à
    [`Papmp.run`](../Papmp.class/architecture.md). Les variables `pmp` sont affectées sans être lues.
  - `Stk1` / `Stk2` : `Update TabArt SET art_stocke = "0"` / `"1"`.
  - `Chk3` : seconde confirmation. Avec texte : `Update Fiches_Art SET art_cbarre = " "` (un
    **espace**) `WHERE art_cbarre like "%<texte>%"` et deux `DELETE FROM Fiches_CdBarre WHERE codep|codeb
    like "%<texte>%"` — SQL **concaténé** avec des guillemets doubles, et filtre « contient » alors que
    le message annonce « commençant par ». Sans texte : `art_cbarre = ""` et `Truncate Table
    Fiches_CdBarre` (non supporté par SQLite). Réponse « Non » : `Return` sans remettre le curseur.
  - Fin : curseur par défaut et « Traitement terminé ! », **même si** l'utilisateur a répondu « Non »
    à la première question.
  Tables : `Fiches_Art` (via `Cbase.Table("TabArt")` sauf pour les codes-barres), `Fiches_CdBarre`
  (en dur). Partie extractible : une fonction par traitement (`RazStocks()`, `PmpEgalPrvt()`,
  `MarquerStocke(b)`, `RazCodesBarre(sFiltre)`).

## État global utilisé

- `Utils.db`, `Cbase.Table("TabArt")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le `SELECT * FROM TabArt` de `Chk1` (le `UPDATE` sans ligne est sans effet) — modifie le
  log SQL mais pas la base.
- Paramétrer les requêtes `LIKE` (`&1` avec `"%" & texte & "%"`) : même résultat sur MySQL, corrige
  l'injection.

### Commonalisation avec d'autres fichiers

- `Chk2` = [`Papmp.run`](../Papmp.class/architecture.md) : une fonction commune
  `PmpEgalPrvt()` (ou un seul `UPDATE … SET art_pmp = art_prvt`, voir optimisations).
- Le parcours « une requête `UPDATE` par article » est aussi celui de
  [`Epurfour`](../Epurfour.class/architecture.md).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Les quatre traitements en fonctions privées sans contrôle, le handler gardant les questions et
  messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune liée au schéma. (Sans changement de schéma : `UPDATE TabArt SET art_pmp = art_prvt` en une
  requête remplacerait la boucle ; le résultat en base est identique mais le log SQL diffère.)
