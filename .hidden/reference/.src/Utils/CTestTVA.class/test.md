# CTestTVA — Tests

> Source : `.src/Utils/CTestTVA.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CTESTTVA-T01 | gbtest | `CleTVAIntra` | SIREN réels connus (dont un avec clé < 10), `"000000000"`, `"999999999"` | clés de référence | `tests/cle/` | à faire |
| CTESTTVA-T02 | gbtest | `CleTVAIntra` erreurs | `"ABC"`, `""`, `"12345678901234"` | figer : erreur levée | `tests/cle_erreurs/` | à faire |
| CTESTTVA-T03 | gbtest | `isIntraComValide` FR | numéros valides avec/sans espaces, minuscules ; clé fausse ; longueur fausse ; avec et sans `siren` | booléens de référence (dont clé `"05"` vs 5) | `tests/validation_fr/` | à faire |
| CTESTTVA-T04 | gbtest | `isIntraComValide` hors FR | `"DE123456789"`, `"BE0123456789"` | `False` | `tests/validation_autres/` | à faire |
| CTESTTVA-T05 | replay | Fiche société | `Fsoc` : SIRET saisi, touche de calcul de la TVA, puis contrôle | numéro proposé et message (log GUI) | `tests/fsoc_tva/` | à faire |

## Détail des tests

- Valeurs attendues générées dans le clone **Laurux non modifié** (caractérisation).
- Le cas « moins de 3 caractères » déclenche `Message.Warning` : exclu de gb.test, couvert par T05
  ou après la séparation traitement/GUI (CTESTTVA-003).
