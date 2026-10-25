# EtiqPromo — Tests

> Source : `.src/Gestion/Etiquettes/EtiqPromo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` en lecture seule (aucune écriture en base) : comparaison du PDF normalisé
`~/tmp/EtiqGond.pdf` et du log. Références capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQPROMO-T01 | replay | Prix début de promotion, A4 | menu Promotions › étiquettes ; clic sur la promo `P1` ; modèle `Z- Test` ; Imprimer | PDF : 3 exemplaires par article, prix promo | `tests/etiqpromo_debut/` | à faire |
| ETIQPROMO-T02 | replay | Fin de promotion | T01 avec « Fin de promotion » | prix article | `tests/etiqpromo_fin/` | à faire |
| ETIQPROMO-T03 | replay | Article dans deux promotions | article présent dans `P1` et `P2` | prix figés (A02) | `tests/etiqpromo_double/` | à faire |
| ETIQPROMO-T04 | replay | Planche pleine | 30 articles, planche 3 × 8, `Esplargeur` ≠ 0 ; `Posetiq` = 5 | positions V5 et rangée en trop figées (A03) | `tests/etiqpromo_planche/` | à faire |
| ETIQPROMO-T05 | replay | Dymo | `Impetiq = "3- Dymo"` | une étiquette par page | `tests/etiqpromo_dymo/` | à faire |
| ETIQPROMO-T06 | replay | Zebra | `Impetiq = "2- Zebra"` | « Null object » figé (A01) | `tests/etiqpromo_zebra/` | à faire |
| ETIQPROMO-T07 | replay | Promotion vide / article supprimé | promo sans article ; ligne `ArtPromo` orpheline | message « Aucun article » ; erreur figée (A04) | `tests/etiqpromo_vide/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé de 2 promotions (`Fiches_Promo`, `Fiches_ArtPromo`) sur
  le jeu `etiquettes_base`.
- **Rejeu** : un seul `Utils.Observers(Me)` ; `Colpromo_Click` rejoué par `Object.Call`.
- **Non testable** : imprimante physique, visionneuse, aide, Zebra.
