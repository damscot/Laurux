# StatTypCli — Tests

> Source : `.src/Statistiques/StatTypCli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : `replay` depuis Statistiques › « Chiffre d'affaire type client » (`Fmenu.Menu176`).
`Utils.Observers(Me)` une fois dans `_New` : rejouable. Comparaisons : dump normalisé de `Total`
(trié par `cdtypclifac`), messages, journal `Exec_SQL` (informatif). Jeu `statistiques_ventes`
décrit dans [StatComm/test.md](../StatComm.class/test.md) ; replays du lot en série.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATTYPCLI-T01 | replay | CA par type, hors entretien | période N, `Facn` | une ligne par type + `*******` « Indéfini » ; brut, remises, net cumulés | `tests/stattypcli_facn/` | à faire |
| STATTYPCLI-T02 | replay | Sources entretien / toutes | `Face`, puis `Fact` | N selon la source ; N-1 toujours sur `HistoFac` (A02 figée) | `tests/stattypcli_sources/` | à faire |
| STATTYPCLI-T03 | replay | N-1 multiplié | client avec 3 factures N et 2 factures N-1 | `totfacn1` = 3 × N-1 du client (A01 figée) | `tests/stattypcli_n1/` | à faire |
| STATTYPCLI-T04 | replay | Client ou type supprimé | facture d'un client absent ; client dont le type est supprimé | erreur d'exécution figée (A03) | `tests/stattypcli_absents/` | à faire |
| STATTYPCLI-T05 | replay | Cas limites | période vide ; fin < début ; remise au format `"12.50"` | messages ; remise convertie par le repli | `tests/stattypcli_cas_limites/` | à faire |
| STATTYPCLI-T06 | replay | SQLite | `Laurux01.sqlite` + jeu de T01 | même dump que T01 | `tests/stattypcli_sqlite/` | à faire |
| STATTYPCLI-T07 | gbtest | `CalculTotal` (après STATTYPCLI-006) | jeu de T01-T03 | contenu de `Total` identique | `tests/stattypcli_calcul/` | à faire |

## Détail des tests

- **Valeurs attendues** : clone Laurux **non modifié**, horloge figée (`faketime`).
- T04 : l'erreur arrête `Traitement` (dialogue d'erreur Gambas) ; vérifier que le rejeu sait
  l'observer, sinon scénario manuel.
- T02, T03 et T04 caractérisent des anomalies.
- **Non testable automatiquement** : son, couleur du champ actif.
