# Copie — Tests

> Source : `.src/Utils/Copie.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COPIE-T01 | gbtest | `Dupli`, répertoire existant | `HOME` de test avec `Impressions/`, PDF source | fichier copié, `spiece`/`schemin` de référence | `tests/dupli_existant/` | à faire |
| COPIE-T02 | gbtest | `Dupli`, répertoire absent | `HOME` sans `Impressions/` | répertoire créé, **pas** de copie, `spiece` inchangé (anomalie A01 figée) | `tests/dupli_absent/` | à faire |
| COPIE-T03 | replay | Validation d'un bon de réception (`Edbr` via `ValidBR`) | `Laurux01.sql`, BR d'un fournisseur | PDF présent dans `~/Impressions/BonReception-<four>.pdf` | `tests/replay_br_copie/` | à faire |

## Détail des tests

- Valeurs de référence produites dans le clone **Laurux non modifié**, `HOME` isolé.
- `Message.Error` (échec de `Mkdir`) : non testé en gb.test ; couvert par un replay manuel avec un
  `HOME` en lecture seule.
- Envoi FTP de `FacturefmA` : non testable sans serveur FTP de test (à documenter en phase 2).
