# Eticli — Tests

> Source : `.src/Gestion/Etiquettes/Eticli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec comparaison du PDF normalisé `~/tmp/EtiqCli.pdf` et du log (la table de travail est
temporaire). Références capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETICLI-T01 | replay | Plage par code | menu Clients ; modèle `Z- Test` ; bornes par défaut ; 1 étiquette | PDF : adresses dans l'ordre des codes | `tests/eticli_plage/` | à faire |
| ETICLI-T02 | replay | Type client | `CheckType` ; types `A`–`B` ; tri par type | PDF filtré/trié | `tests/eticli_type/` | à faire |
| ETICLI-T03 | replay | Code postal | `CheckCp` ; CP `44000`–`44999` ; tri CP | PDF **non filtré** par CP, trié (A01 figée) | `tests/eticli_cp/` | à faire |
| ETICLI-T04 | replay | Bornes texte / numérique | clients `5`, `9000`, `41100005`, `411000050` ; bornes `41100001`–`411999999` | sélection figée (A02) | `tests/eticli_bornes/` | à faire |
| ETICLI-T05 | replay | Mode liste | `Liste` ; 3 codes, un doublon, un inconnu ; Imprimer | `ListCli` (log), PDF ; code inconnu refusé | `tests/eticli_liste/` | à faire |
| ETICLI-T06 | replay | Grilles et tri | F2 sur `client1` ; clic en-tête Nom deux fois ; clic ligne ; idem `client2` | sélection, tri (log), A04 figée | `tests/eticli_grilles/` | à faire |
| ETICLI-T07 | replay | Position de départ | `Posetiq` = 4 ; planche 3 × 8 ; 30 clients | positions V1, pages | `tests/eticli_position/` | à faire |
| ETICLI-T08 | replay | Tri par type sans filtre | cocher `CheckType`, `RadioButton2`, décocher `CheckType` ; Imprimer | erreur `Null object` figée (A03) | `tests/eticli_type_masque/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé ≈ 30 clients sur 3 types et plusieurs CP, dont les codes
  « limites » de T04 ; format `Z- Test`.
- **Rejeu** : `Utils.Observers(Me)` appelé deux fois dans `_New` (doublons probables) ; écran non
  modal (auto-instance) ; `ColCli*_Click`/`ColType*_Click` rejoués par `Object.Call` ; `Colcli_Data`
  dépend de `Utils.rs1` (ne pas ouvrir d'autre écran utilisant `rs1` pendant le scénario).
- **Non testable** : imprimante, visionneuse, aide, couleurs de focus.
