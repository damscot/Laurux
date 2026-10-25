# Dymo — Tests

> Source : `.src/Gestion/Etiquettes/Dymo.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module mort, copie de `Zebra.module`. Un seul test, qui prouve l'équivalence avant suppression.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DYMO-T01 | gbtest | Équivalence `Dymo.Gondole1` = `Zebra.Gondole1` | jeu d'entrées de ZEBRA-T01 envoyé aux deux procédures sur deux sockets locales | flux reçus identiques octet par octet | `tests/dymo_equivalence/` | à faire |

## Détail des tests

- **Montage** : comme ZEBRA-T01 (`ServerSocket` gb.net en écoute sur `127.0.0.1`, port libre),
  aucune imprimante requise.
- Après DYMO-001, le test est retiré ; seul `gbc3 -agt` (compilation sans `Dymo.module`) et les
  replays des écrans d'étiquettes (ETIQART, ETIGOND, ETIQCASIER, ETIQPROMO, ETIQRECPT, ETIQFBTARIF :
  choix « Imprimante Dymo ») restent à repasser, pour vérifier que `Dymo.Value` vise toujours le
  contrôle.
