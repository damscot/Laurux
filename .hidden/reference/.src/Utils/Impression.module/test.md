# Impression — Tests

> Source : `.src/Utils/Impression.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPRESSION-T01 | gbtest | `Ticket` | `lpr` factice journalisé ; `/Soc01/caisse/Cimp` vide/renseigné, `CmdImp` vide/renseigné, `TKpdf` 0/1, `nb` 1 et 2 | commandes journalisées (et appel du visualiseur factice) | `tests/ticket/` | à faire |
| IMPRESSION-T02 | gbtest | `Facture` | `lpr` factice ; clés globales `/CmdImp`, `/Cimp`, `/choiximp2`, `/FACpdf` absentes/présentes ; paramètre `Imprimante` ; `nb` = 2 | commandes journalisées ; aucune commande si `/choiximp2` (figé) | `tests/facture/` | à faire |
| IMPRESSION-T03 | replay | Impression d'un ticket en caisse | `./Laurux -p`, vente simple sur `Laurux01.sql`, `lpr` factice | commande `lpr` journalisée, tables de tickets comparées | `tests/replay_ticket/` | à faire |

## Détail des tests

- `lpr` et le visualiseur sont remplacés par des scripts factices qui journalisent leurs arguments ;
  références produites dans le clone **Laurux non modifié**.
- `Bordrx` (`Impression.Prog_Editeur`) relève des tests de `Bordrx` ; le cas d'erreur y est figé.
