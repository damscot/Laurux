# StatFour — Tests

> Source : `.src/Statistiques/StatFour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : `replay` depuis Statistiques › « Chiffre d'affaire fournisseur » (`Fmenu.Menu169`).
`StatFour` est rejouable (`Utils.Observers` dans `_New`) mais l'écran `VisStatFour` qu'il ouvre
ne l'est pas : le scénario s'arrête à l'ouverture (fermeture manuelle ou par le harnais).
Comparaisons : dump normalisé de `Total` (trié par `cdfour`), messages `Balloon`. Jeu
`statistiques_ventes` (réceptions `Fiches_Entrecpt`, voir [StatComm/test.md](../StatComm.class/test.md)).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATFOUR-T01 | replay | Une réception par fournisseur | période N, une réception N et une N-1 par fournisseur | `montant`, `montant1` exacts | `tests/statfour_simple/` | implémenté (assets/statfour_simple, jeu statfour_shared/statfour_receptions) |
| STATFOUR-T02 | replay | N-1 multiplié | fournisseur avec 3 réceptions N et 2 N-1 | `montant1` = 3 × total N-1 (A01 figée) | `tests/statfour_n1/` | implémenté (couvert par statfour_simple : 401002 montant1 = 36 = 3 × 12, A01) |
| STATFOUR-T03 | replay | Fournisseur supprimé | réceptions d'un fournisseur absent de `Fiches_Four` après un autre | `nmfour` = nom du précédent (A03 figée) | `tests/statfour_four_absent/` | implémenté (couvert par statfour_simple : 409999 nmfour = C Divers, A03) |
| STATFOUR-T04 | replay | Réceptions non validées et montant NULL | `validee = 0` ; `montant` NULL | réception non validée comptée ; erreur figée pour NULL (A04) | `tests/statfour_validee/` | implémenté (non validée comptée : statfour_simple ; montant NULL : statfour_validee, code de sortie 125, A04) |
| STATFOUR-T05 | replay | Cas limites | période vide ; fin < début | `Message.Warning` « Aucune donnée » ; `Balloon.Warning` | `tests/statfour_cas_limites/` | implémenté (assets/statfour_cas_limites ; Balloon.Warning non capturé) |
| STATFOUR-T06 | replay | SQLite | `Laurux01.sqlite` + jeu de T01 | même dump que T01 | `tests/statfour_sqlite/` | à faire : rejeu sur base SQLite non outillé (runner sur MariaDB) |
| STATFOUR-T07 | gbtest | `CalculTotal` (après STATFOUR-006) | jeu de T01-T03 | `Total` identique | `tests/statfour_calcul/` | à faire : extraction STATFOUR-006 (CalculTotal) non faite |

## Détail des tests

- Valeurs attendues : clone **non modifié**, horloge figée.
- `Balloon.Warning` : vérifier que le journal du rejeu le capture, sinon contrôle manuel.
- T02-T04 caractérisent des anomalies.
