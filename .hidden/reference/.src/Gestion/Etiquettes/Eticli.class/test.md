# Eticli — Tests

> Source : `.src/Gestion/Etiquettes/Eticli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec comparaison du PDF normalisé `~/tmp/EtiqCli.pdf` et du log (la table de travail est
temporaire). Références capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETICLI-T01 | replay | Plage par code | menu Clients ; modèle `Z- Test` ; bornes par défaut ; 1 étiquette | PDF : adresses dans l'ordre des codes | `tests/eticli_plage/` | implémenté |
| ETICLI-T02 | replay | Type client | `CheckType` ; types `A`–`B` ; tri par type | PDF filtré/trié | `tests/eticli_type/` | implémenté |
| ETICLI-T03 | replay | Code postal | `CheckCp` ; CP `44000`–`44999` ; tri CP | PDF **non filtré** par CP, trié (A01 figée) | `tests/eticli_cp/` | implémenté |
| ETICLI-T04 | replay | Bornes texte / numérique | clients `5`, `9000`, `41100005`, `411000050` ; bornes `41100001`–`411999999` | sélection figée (A02) | `tests/eticli_bornes/` | implémenté |
| ETICLI-T05 | replay | Mode liste | `Liste` ; 3 codes, un doublon, un inconnu ; Imprimer | `ListCli` (log), PDF ; code inconnu refusé | `tests/eticli_liste/` | implémenté |
| ETICLI-T06 | replay | Grilles et tri | F2 sur `client1` ; clic en-tête Nom deux fois ; clic ligne ; idem `client2` | sélection, tri (log), A04 figée | `tests/eticli_grilles/` | à faire : F2, clic d'en-tête de colonne et grilles ouvertes par F2 non rejouables |
| ETICLI-T07 | replay | Position de départ | `Posetiq` = 4 ; planche 3 × 8 ; 30 clients | positions V1, pages | `tests/eticli_position/` | implémenté |
| ETICLI-T08 | replay | Tri par type sans filtre | cocher `CheckType`, `RadioButton2`, décocher `CheckType` ; Imprimer | erreur `Null object` figée (A03) | `tests/eticli_type_masque/` | implémenté |

## Détail des tests

- **Implémentation (vague 4)** : assets `.hidden/Tests/Gestion/assets/eticli_{plage,type,cp,bornes,liste,position,type_masque}/`, jeu `eticli_shared/eticli_base.sql` (9 clients typés A/B/C, CP variés, codes limites 5, 9000, 41100005, 411000050, format `Z`) ; texte du PDF par `pdftotext`. Constats : bornes par défaut 41100001-4119999999 incluent 41100005 et 411000050 (comparaison texte >=) ; en T03 le PDF est trié par CP sans filtre (A01) ; T05 : la table temporaire n'est visible que par sql.log, le PDF relit `cli_code >= code` ; T08 : `Eticli.Button2_Click.810: Null object`, code 125.

- **Données** : `Laurux01.sql` + jeu dérivé ≈ 30 clients sur 3 types et plusieurs CP, dont les codes
  « limites » de T04 ; format `Z- Test`.
- **Rejeu** : `Utils.Observers(Me)` appelé deux fois dans `_New` (doublons probables) ; écran non
  modal (auto-instance) ; `ColCli*_Click`/`ColType*_Click` rejoués par `Object.Call` ; `Colcli_Data`
  dépend de `Utils.rs1` (ne pas ouvrir d'autre écran utilisant `rs1` pendant le scénario).
- **Non testable** : imprimante, visionneuse, aide, couleurs de focus.
