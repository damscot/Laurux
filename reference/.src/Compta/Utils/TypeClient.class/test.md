# TypeClient — Tests

> Source : `.src/Compta/Utils/TypeClient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TYPECLIENT-T01 | gbtest | Chargement | `Laurux01.sql` + 3 types dans `Fiches_Typec` ; `New TypeClient(fenêtre de test)` (Xvfb) | clés et libellés des éléments dans l'ordre | `tests/typeclient_chargement/` | à faire |
| TYPECLIENT-T02 | gbtest | Propriété `where` | aucune sélection ; 1 type ; 3 types ; code avec apostrophe | `""`, `cli_typec IN('A')`, `cli_typec IN('A','B','C')`, quote échappée | `tests/typeclient_where/` | à faire |
| TYPECLIENT-T03 | replay | Balance filtrée par type | écran Balance, sélection de 2 types, impression | lignes `Exec_SQL` et texte PDF de référence | `tests/typeclient_balance/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**.
- T01/T02 instancient un contrôle graphique : gb.test sous Xvfb (décision en attente, voir notes
  transverses) ; après TYPECLIENT-003, T02 porte sur la fonction pure `WhereTypes` sans interface.
- T03 dépend de la prise en charge de `TypeClient` par `ReplayObserver` (voir dependencies.md).
