# EtiqPromo — Tests

> Source : `.src/Gestion/Etiquettes/EtiqPromo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` en lecture seule (aucune écriture en base) : comparaison du PDF normalisé
`~/tmp/EtiqGond.pdf` et du log. Références capturées dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIQPROMO-T01 | replay | Prix début de promotion, A4 | menu Promotions › étiquettes ; clic sur la promo `P1` ; modèle `Z- Test` ; Imprimer | PDF : 3 exemplaires par article, prix promo | `tests/etiqpromo_debut/` | implémenté |
| ETIQPROMO-T02 | replay | Fin de promotion | T01 avec « Fin de promotion » | prix article | `tests/etiqpromo_fin/` | implémenté |
| ETIQPROMO-T03 | replay | Article dans deux promotions | article présent dans `P1` et `P2` | prix figés (A02) | `tests/etiqpromo_double/` | implémenté |
| ETIQPROMO-T04 | replay | Planche pleine | 30 articles, planche 3 × 8, `Esplargeur` ≠ 0 ; `Posetiq` = 5 | positions V5 et rangée en trop figées (A03) | `tests/etiqpromo_planche/` | implémenté |
| ETIQPROMO-T05 | replay | Dymo | `Impetiq = "3- Dymo"` | une étiquette par page | `tests/etiqpromo_dymo/` | implémenté |
| ETIQPROMO-T06 | replay | Zebra | `Impetiq = "2- Zebra"` | « Null object » figé (A01) | `tests/etiqpromo_zebra/` | implémenté |
| ETIQPROMO-T07 | replay | Promotion vide / article supprimé | promo sans article ; ligne `ArtPromo` orpheline | message « Aucun article » ; erreur figée (A04) | `tests/etiqpromo_vide/` | implémenté |

## Détail des tests

- **Implémentation (vague 4)** : assets `.hidden/Tests/Gestion/assets/etiqpromo_{debut,fin,double,planche,dymo,zebra,vide}/`, jeu `etiqpromo_shared/etiqpromo_base.sql` (format `Z`, promos P1 001+002, P2 002+003, P3 vide, P4 article 999 absent) et `etiqpromo_planche/etiqpromo_planche.sql` (format Z largeur 60 mm, espace 5 mm, promo P5 de 9 articles). Texte du PDF par `pdftotext`. T03 : 002 imprimé en P2 avec les prix de P1 (15,00 / 16,05 ; A02). T06 : `EtiqPromo.Button2_Click.130: Null object`, code 125. T07 : P3 « Aucun article » puis P4 `EtiqPromo.Imprime.228: Result is not available`, code 125.

- **Données** : `Laurux01.sql` + jeu dérivé de 2 promotions (`Fiches_Promo`, `Fiches_ArtPromo`) sur
  le jeu `etiquettes_base`.
- **Rejeu** : un seul `Utils.Observers(Me)` ; `Colpromo_Click` rejoué par `Object.Call`.
- **Non testable** : imprimante physique, visionneuse, aide, Zebra.
