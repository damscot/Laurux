# FacturefmA — Tests

> Source : `.src/Gestion/Facturation/FacturefmA.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis Gestion › Facturation › Facturation périodique (`/Faca` = 1),
sur le jeu `facturation_base` ([ObjFac.class/test.md](../ObjFac.class/test.md)) avec des BL
d'abonnement (`type = "A"`) et des clients de chaque périodicité. Comparaisons : tables de travail
`Facturefm`/`Bl`, affichage des listes (journal de rejeu), dump normalisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FACTUREFMA-T01 | replay | Sélection mensuelle | clients « 1- Mensuel » : jamais facturé, facturé le mois précédent avant/après `cli_datab`, facturé ce mois | clients retenus dans `Facturefm`/`Bl` | `tests/mensuel/` | implémenté (`Gestion/facturefma_mensuel`) |
| FACTUREFMA-T02 | replay | Bimensuel, trimestriel, semestriel | dates saisies en janvier, février, juillet | figer la sélection (A03 en début d'année) | `tests/periodicites/` | implémenté (`Gestion/facturefma_periodicites_janvier`, `_fevrier`, `_juillet` ; A03 figée : en janvier, bimensuel facturé le 05.11.2017 non retenu et semestriel facturé le 05.10.2017 retenu) |
| FACTUREFMA-T03 | replay | Annuel | client facturé il y a un an jour pour jour | figer la sélection (A02) | `tests/annuel/` | implémenté (`Gestion/facturefma_annuel` ; A02 figée : aucun client annuel retenu, même facturé il y a un an jour pour jour) |
| FACTUREFMA-T04 | replay | Client sans périodicité, client unique | `cli_aban` nul ; `RadioButton2` + code | avertissement ; sélection limitée au client | `tests/sans_periodicite/` | implémenté (`Gestion/facturefma_sans_periodicite`) |
| FACTUREFMA-T05 | replay | Retraits | Suppr client, Suppr BL | tables de travail ; colonne Ville modifiée (A01 figée) | `tests/retraits/` | implémenté (`Gestion/facturefma_retraits` : Suppr client, Suppr BL ; tables de travail dans le dump ; colonne Ville (A01) à l'écran seulement, non comparée) |
| FACTUREFMA-T06 | replay | Édition | `Imprimer`, date du panneau modifiée, `OK` | factures émises (dump complet) ; date utilisée = `Datej` (A05 figée) | `tests/edition/` | implémenté (replay `Gestion/facturefma_edition` : Dtef remplacée par 20.06.2018, OK, OptFac › Éditer ; factures datées de Datej (A05 figée) ; jeu `assets/facturefma_edition/edition_abonnements.sql`) |
| FACTUREFMA-T07 | replay | Client divers abonné | client `cli_div = 1` | figer l'erreur SQL de `ObjFac.calcul` (colonne `nom` absente, A04) | `tests/client_divers/` | implémenté (replay `Gestion/facturefma_client_divers` : erreur fatale « Unknown column 'nom' » de `ObjFac.calcul` figée, code 125 ; jeu `client_divers.sql`) |
| FACTUREFMA-T08 | gbtest | Conversion de `dtefac` | `Date` → `String` implicite pour des dates à 00:00 (été, hiver, 1er du mois) | chaînes de référence ; `Left$(…, 2)`, `Right$(…, 4)` | `tests/conversion_dtefac/` | à faire : expression dans `recup_bl` (non publique), extraction de phase 4 |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, avec `faketime` (la
  sélection utilise `Now`) et `TZ=Europe/Paris` (la conversion Date → String se fait en temps
  universel : `Date(2024,3,6)` donne « 03/05/2024 22:00:00 » sur le poste de test, vérifié).
- **Données** : BL `A` avec `dtefac` nulle, du mois précédent, d'il y a 2, 3, 6 et 12 mois ;
  `cli_datab` avant/après le jour saisi ; un client sans `cli_aban`, un client divers.
- T08 isole l'expression de conversion (fonction non publique) : caractérisation de A02/A03.
- L'envoi FTP (code mort) n'est pas testé.

- **Assets** (`.hidden/Tests/Gestion/assets/`) : jeu `facturefma_shared/abonnements.sql` (clients 411911–411915,
  BL `A` A00001–A00005, `dtepec` = `06.2018` pour éviter l'avertissement de `Quittedate`). Les scénarios posent
  `"/Soc01/Faca": 0` (entier : la chaîne « 0 » est vraie pour `If`) : avec `/Faca` = 1, `Fmenu.Form_Open` appelle
  `Abonnement()` qui ouvre une boîte avant le démarrage du rejeu (START-A09) ; le menu masqué `Menu299` reste
  cliquable par le rejeu.
- T02, T03, T05 (vague 7) : jeux `facturefma_shared/periodicites_01|02|07.sql` (clients bimensuels 41192x,
  trimestriels 41193x, semestriels 41194x, facturés les 05.07, 05.10, 05.11 et 05.12.2017 ; `dtepec` du mois du
  scénario, date du scénario le 15 de ce mois), `annuel.sql` (41195x), `retraits.sql` (41196x, dont un client à deux
  BL : seul le premier est retenu par `recup_bl`). Générateur : `facturefma_shared/gen_facturefma.py`. Dates de
  facturation au 5 du mois pour éviter le décalage UTC de la conversion `dtefac` → chaîne.
- **T06 (phase 2, vague 9)** : jeu `edition_abonnements.sql`, copie de `facturefma_shared/abonnements` sans 411915, complétée (article 003, `mtx_ligfac`, comptes clients). `datefac` porte l'heure du rejeu (Datej = Now), comparée avec la tolérance des horodatages.
