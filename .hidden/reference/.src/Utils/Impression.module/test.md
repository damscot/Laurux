# Impression — Tests

> Source : `.src/Utils/Impression.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPRESSION-T01 | gbtest | `Ticket` | `lpr` factice journalisé ; `/Soc01/caisse/Cimp` vide/renseigné, `CmdImp` vide/renseigné, `TKpdf` 0/1, `nb` 1 et 2 | commandes journalisées (et appel du visualiseur factice) | `tests/ticket/` | implémenté |
| IMPRESSION-T02 | gbtest | `Facture` | `lpr` factice ; clés globales `/CmdImp`, `/Cimp`, `/choiximp2`, `/FACpdf` absentes/présentes ; paramètre `Imprimante` ; `nb` = 2 | commandes journalisées ; aucune commande si `/choiximp2` (figé) | `tests/facture/` | implémenté |
| IMPRESSION-T03 | replay | Impression d'un ticket en caisse | `./Laurux -p`, vente simple sur `Laurux01.sql`, `lpr` factice | commande `lpr` journalisée, tables de tickets comparées | `tests/replay_ticket/` | à faire : vente en caisse (touches ImageButton non rejouées) et lpr factice impossible dans l'environnement du rejeu (PATH fixé par le runner) |

## Détail des tests

- `lpr` et le visualiseur sont remplacés par des scripts factices qui journalisent leurs arguments ;
  références produites dans le clone **Laurux non modifié**.
- `Bordrx` (`Impression.Prog_Editeur`) relève des tests de `Bordrx` ; le cas d'erreur y est figé.
- **Implémentation (phase 2)** : `.src/Tests/Utils/ImpressionTest.test` ; faux `lpr`, `monimp`, `vis` créés par le test et placés en tête du `PATH` du processus.
