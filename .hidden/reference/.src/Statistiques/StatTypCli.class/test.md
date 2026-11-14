# StatTypCli — Tests

> Source : `.src/Statistiques/StatTypCli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : `replay` depuis Statistiques › « Chiffre d'affaire type client » (`Fmenu.Menu176`).
`Utils.Observers(Me)` une fois dans `_New` : rejouable. Comparaisons : dump normalisé de `Total`
(trié par `cdtypclifac`), messages, journal `Exec_SQL` (informatif). Jeu `statistiques_ventes`
décrit dans [StatComm/test.md](../StatComm.class/test.md) ; replays du lot en série.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATTYPCLI-T01 | replay | CA par type, hors entretien | période N, `Facn` | une ligne par type + `*******` « Indéfini » ; brut, remises, net cumulés | `tests/stattypcli_facn/` | implémenté (assets/stattypcli_facn, jeu stattypcli_shared/stattypcli) |
| STATTYPCLI-T02 | replay | Sources entretien / toutes | `Face`, puis `Fact` | N selon la source ; N-1 toujours sur `HistoFac` (A02 figée) | `tests/stattypcli_sources/` | implémenté (stattypcli_sources : Fact ; stattypcli_sources_entretien : Face, N-1 sur HistoFac, A02) |
| STATTYPCLI-T03 | replay | N-1 multiplié | client avec 3 factures N et 2 factures N-1 | `totfacn1` = 3 × N-1 du client (A01 figée) | `tests/stattypcli_n1/` | implémenté (couvert par stattypcli_facn : 02 Plombier totfacn1 = 60 = 3 × 20, A01) |
| STATTYPCLI-T04 | replay | Client ou type supprimé | facture d'un client absent ; client dont le type est supprimé | erreur d'exécution figée (A03) | `tests/stattypcli_absents/` | implémenté (stattypcli_absents : Traitement.204 ; stattypcli_type_supprime : Traitement.206 ; code de sortie 125, A03) |
| STATTYPCLI-T05 | replay | Cas limites | période vide ; fin < début ; remise au format `"12.50"` | messages ; remise convertie par le repli | `tests/stattypcli_cas_limites/` | implémenté (stattypcli_cas_limites ; remise « 12.50 » couverte par stattypcli_facn) |
| STATTYPCLI-T06 | replay | SQLite | `Laurux01.sqlite` + jeu de T01 | même dump que T01 | `tests/stattypcli_sqlite/` | à faire : rejeu sur base SQLite non outillé (runner sur MariaDB) |
| STATTYPCLI-T07 | gbtest | `CalculTotal` (après STATTYPCLI-006) | jeu de T01-T03 | contenu de `Total` identique | `tests/stattypcli_calcul/` | à faire : extraction STATTYPCLI-006 (CalculTotal) non faite |

## Détail des tests

- **Valeurs attendues** : clone Laurux **non modifié**, horloge figée (`faketime`).
- T04 : l'erreur arrête `Traitement` (dialogue d'erreur Gambas) ; vérifier que le rejeu sait
  l'observer, sinon scénario manuel.
- T02, T03 et T04 caractérisent des anomalies.
- **Non testable automatiquement** : son, couleur du champ actif.
