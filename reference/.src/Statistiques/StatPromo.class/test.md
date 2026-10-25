# StatPromo — Tests

> Source : `.src/Statistiques/StatPromo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI modal : `replay` depuis Statistiques › « Statistiques promotions » (`Fmenu.Menu223`).
Rejouable (`Utils.Observers` une fois). Le clic sur `ColPromo` est rejoué par `Object.Call`
(`ColPromo_Click` `Public`) ; **ne pas cliquer dans `Liste`** (`replay_missing`).
Comparaisons : contenu de `Liste` et des totaux (journal), messages ; base inchangée (lecture
seule). Jeu `statistiques_ventes` (promotion + `Fiches_ArtPromo`, voir
[StatComm/test.md](../StatComm.class/test.md)).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATPROMO-T01 | replay | Choix par liste | F2 dans `CodeP`, clic sur la 2e promotion, Afficher | `CodeP`/`Label1` remplis ; grille, `Tht`, `Tttc`, `Tqte`, `Tmarge` (A02 figée) | `tests/statpromo_liste/` | à faire |
| STATPROMO-T02 | replay | Saisie du code | code existant + Entrée, Afficher ; code inconnu + Entrée | grille ; « Cette promotion n'existe pas ! » | `tests/statpromo_saisie/` | à faire |
| STATPROMO-T03 | replay | Sans code | Afficher sans sélection | « Veuillez saisir un code promotion SVP ! » | `tests/statpromo_sans_code/` | à faire |
| STATPROMO-T04 | replay | Code modifié après validation | valider P1, retaper P2 sans Entrée, Afficher | articles de P2 affichés, `Label1` = P1 (A03 figée) | `tests/statpromo_code_modifie/` | à faire |
| STATPROMO-T05 | replay | Prix NULL / quantité NULL | article de promotion avec `pht` NULL ; un autre avec `qte` NULL | erreur figée (A01) ; marge vide pour `qte` NULL | `tests/statpromo_null/` | à faire |
| STATPROMO-T06 | gbtest | `LignesPromo` (après STATPROMO-004) | promotion du jeu | lignes et totaux identiques à T01 | `tests/statpromo_lignes/` | à faire |

## Détail des tests

- Valeurs attendues : clone **non modifié**.
- Les quantités sont produites par la caisse : le jeu les fixe directement dans
  `Fiches_ArtPromo.qte` (pas de rejeu de caisse nécessaire).
- Non testable automatiquement : son, `Balloon`.
