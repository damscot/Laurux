# StatComArt — Tests

> Source : `.src/Statistiques/StatComArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : `replay` depuis Statistiques › « CA articles/commerciaux » (`Fmenu.Menu314`).
Rejouable (`Utils.Observers` une fois). Comparaisons : dump normalisé de `Total` (trié par
`cdartfac, commercial`), messages. Jeu `statistiques_ventes` ([StatComm/test.md](../StatComm.class/test.md)) ;
replays du lot en série.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATCOMART-T01 | replay | Articles vendus une fois par commercial | période N, `Facn`, chaque article une seule fois par commercial | `nethtfac`, `qte` exacts | `tests/statcomart_simple/` | implémenté (`Statistiques/statcomart_simple` : Facn, Total ART1/01 cumulé, ligne M et client sans commercial ignorés) |
| STATCOMART-T02 | replay | Article vendu plusieurs fois au même commercial | 2 factures de clients du commercial `01` sur le même article | `nethtfac` cumulé ; `qte` = 1,00 (code commercial, A01 figée) | `tests/statcomart_cumul/` | implémenté (dans `Statistiques/statcomart_simple` : ART1/01 = F18101 + F18102, 250.00, qte = 1.00 = code commercial, A01 figée) |
| STATCOMART-T03 | replay | Factures d'entretien | `Face` puis `Fact`, numéro `HistoFacM` existant aussi dans `HistoFac` | lignes lues dans `HistoLigfac` (A02 figée) | `tests/statcomart_entretien/` | implémenté (`Statistiques/statcomart_entretien` : Face, lignes de F18103 lues dans HistoLigfac, M18101 sans ligne, A02 figée ; `Statistiques/statcomart_toutes` : Fact, union) |
| STATCOMART-T04 | replay | Clients sans commercial / supprimé | facture d'un client sans `cli_comm` ; facture d'un client supprimé | premier ignoré ; second : erreur figée (A04) | `tests/statcomart_clients/` | implémenté (`Statistiques/statcomart_clients` : client sans commercial ignoré ; client supprimé : « Result is not available » StatComArt.Traitement.192, code de sortie 125 figé, A04) |
| STATCOMART-T05 | replay | Cas limites | période vide ; fin < début | messages attendus | `tests/statcomart_cas_limites/` | implémenté (`Statistiques/statcomart_cas_limites`) |
| STATCOMART-T06 | replay | SQLite | `Laurux01.sqlite` + jeu de T01 | même dump que T01 | `tests/statcomart_sqlite/` | à faire : rejeu sur base SQLite non outillé (runner sur MariaDB) |
| STATCOMART-T07 | gbtest | `CalculTotal` (après STATCOMART-006) | jeu de T01-T03 | `Total` identique | `tests/statcomart_calcul/` | à faire : extraction STATCOMART-006 (CalculTotal) non faite |

## Détail des tests

- Valeurs attendues capturées dans le clone **non modifié**, horloge figée.
- T02, T03 et T04 caractérisent des anomalies.
- Non testable automatiquement : son, couleur du champ actif.
