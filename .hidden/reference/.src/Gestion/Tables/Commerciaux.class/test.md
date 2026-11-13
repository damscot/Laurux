# Commerciaux — Tests

> Source : `.src/Gestion/Tables/Commerciaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Commerciaux`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMMERCIAUX-T01 | replay | Création | menu Commerciaux ; `1` (→ `01`), `Durand`, `Paul`, `5.5` ; Enregistrer | INSERT, `comm = 5.50` | `tests/creation/` | implémenté |
| COMMERCIAUX-T02 | replay | Modification | clic `01` ; commission `7,25` ; Enregistrer | UPDATE de `comm` | `tests/modification/` | implémenté |
| COMMERCIAUX-T03 | replay | Commission invalide | commission `abc`, Tab | message, focus conservé, aucune écriture | `tests/commission_invalide/` | à faire : Message.Warning ouvert depuis Ven_LostFocus (boîte non vue comme fenêtre active au rejeu) |
| COMMERCIAUX-T04 | replay | Suppression | sélection `01` ; Supprimer, Oui | ligne supprimée (clients `cli_comm = 01` orphelins, figé) | `tests/suppression/` | implémenté |
| COMMERCIAUX-T05 | replay | Rafraîchissements multiples | 3 enregistrements successifs | dump identique ; nombre d'événements journalisés (A03) relevé | `tests/observers_multiples/` | implémenté (3 enregistrements successifs, 16,2 s mesurées hors charge ; nombre d'événements journalisés non comparé) |

## Détail des tests

- **Implémentation (vague 4)** : scénarios `Gestion/commerciaux_creation`, `commerciaux_modification`, `commerciaux_suppression` (client 411001 garde `cli_comm = 01`), `commerciaux_observers_multiples` (cadence traitement 400 ms) ; jeu partagé `.hidden/Tests/Gestion/assets/commerciaux_shared/commerciaux_01.sql`.

- **Données** : `Laurux01.sql` (table vide) ; jeu dérivé `01` + un client `cli_comm = 01` pour T04.
- **Comparaison** : dump normalisé de `Fiches_Commerciaux` et `Fiches_Cli` (T04).
- **Non testable automatiquement** : son (`Music.Play` sans `Music.Load`), couleurs de focus.
