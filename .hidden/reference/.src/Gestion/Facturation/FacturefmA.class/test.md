# FacturefmA — Tests

> Source : `.src/Gestion/Facturation/FacturefmA.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis Gestion › Facturation › Facturation périodique (`/Faca` = 1),
sur le jeu `facturation_base` ([ObjFac.class/test.md](../ObjFac.class/test.md)) avec des BL
d'abonnement (`type = "A"`) et des clients de chaque périodicité. Comparaisons : tables de travail
`Facturefm`/`Bl`, affichage des listes (journal de rejeu), dump normalisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FACTUREFMA-T01 | replay | Sélection mensuelle | clients « 1- Mensuel » : jamais facturé, facturé le mois précédent avant/après `cli_datab`, facturé ce mois | clients retenus dans `Facturefm`/`Bl` | `tests/mensuel/` | à faire |
| FACTUREFMA-T02 | replay | Bimensuel, trimestriel, semestriel | dates saisies en janvier, février, juillet | figer la sélection (A03 en début d'année) | `tests/periodicites/` | à faire |
| FACTUREFMA-T03 | replay | Annuel | client facturé il y a un an jour pour jour | figer la sélection (A02) | `tests/annuel/` | à faire |
| FACTUREFMA-T04 | replay | Client sans périodicité, client unique | `cli_aban` nul ; `RadioButton2` + code | avertissement ; sélection limitée au client | `tests/sans_periodicite/` | à faire |
| FACTUREFMA-T05 | replay | Retraits | Suppr client, Suppr BL | tables de travail ; colonne Ville modifiée (A01 figée) | `tests/retraits/` | à faire |
| FACTUREFMA-T06 | replay | Édition | `Imprimer`, date du panneau modifiée, `OK` | factures émises (dump complet) ; date utilisée = `Datej` (A05 figée) | `tests/edition/` | à faire |
| FACTUREFMA-T07 | replay | Client divers abonné | client `cli_div = 1` | figer l'erreur SQL de `ObjFac.calcul` (colonne `nom` absente, A04) | `tests/client_divers/` | à faire |
| FACTUREFMA-T08 | gbtest | Conversion de `dtefac` | `Date` → `String` implicite pour des dates à 00:00 (été, hiver, 1er du mois) | chaînes de référence ; `Left$(…, 2)`, `Right$(…, 4)` | `tests/conversion_dtefac/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, avec `faketime` (la
  sélection utilise `Now`) et `TZ=Europe/Paris` (la conversion Date → String se fait en temps
  universel : `Date(2024,3,6)` donne « 03/05/2024 22:00:00 » sur le poste de test, vérifié).
- **Données** : BL `A` avec `dtefac` nulle, du mois précédent, d'il y a 2, 3, 6 et 12 mois ;
  `cli_datab` avant/après le jour saisi ; un client sans `cli_aban`, un client divers.
- T08 isole l'expression de conversion (fonction non publique) : caractérisation de A02/A03.
- L'envoi FTP (code mort) n'est pas testé.
