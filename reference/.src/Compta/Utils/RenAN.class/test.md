# RenAN — Tests

> Source : `.src/Compta/Utils/RenAN.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RENAN-T01 | replay | Lancement par `Prgm` | `Laurux01.sql`, saisie `RenAN` | message d'erreur SQL (table `Fiches_Mvtoc` inexistante) figé ; dump inchangé | `tests/renan_prgm/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (texte du message
  d'erreur de `DB_Connection.Exec`, dump identique avant/après).
- Le cas « table présente » n'est pas testé : la table n'existe dans aucune base de référence.
- Ce test recoupe PRGM-T06 (même scénario) ; il est conservé pour documenter le retrait.
