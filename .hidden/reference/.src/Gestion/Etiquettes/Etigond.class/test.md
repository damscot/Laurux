# Etigond — Tests

> Source : `.src/Gestion/Etiquettes/Etigond.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Même principe qu'[Etiqart](../Etiqart.class/test.md) : `replay`, diff du dump (table temporaire
`Etiquettes` relevée par le log, elle disparaît avec la connexion) et du PDF normalisé
`~/tmp/EtiqGond.pdf`. Références capturées dans le clone **Laurux non modifié**, jeu
`etiquettes_base` (avec deux modèles A4 dont les libellés contiennent « Gondole » et « Article »).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIGOND-T01 | replay | Gondole A4, plage | menu Gondole ; modèle « Gondole » ; PV HT + TTC ; Imprimer | PDF (cadre, prix, TVA, EAN13) | `tests/etigond_gondole_a4/` | à faire |
| ETIGOND-T02 | replay | Mise en page « Article » | modèle « Article » ; prix au kg TTC | PDF mise en page article | `tests/etigond_article_a4/` | à faire |
| ETIGOND-T03 | replay | Modèle sans mot-clé | modèle `Z- Test` | PDF sans étiquette (A03 figée) | `tests/etigond_sans_mot_cle/` | à faire |
| ETIGOND-T04 | replay | Options | combinaisons `CheckBox1..4`, `RadioButton5/6`, `/Soc01/Kgl` | PDF par combinaison | `tests/etigond_options/` | à faire |
| ETIGOND-T05 | replay | Les 5 tris + bornes | `Radiobutton1..4`, `Radiobutton7` | ordre des articles | `tests/etigond_tris/` | à faire |
| ETIGOND-T06 | replay | Position de départ, deux impressions | `Posetiq` = 4, Imprimer ; puis `Posetiq` = 1, Imprimer | positions ; 2e PDF : 1re étiquette en (0, 0) figée (A04) | `tests/etigond_position/` | à faire |
| ETIGOND-T07 | replay | Mode liste et grille | `Liste` ; ajout (y compris article `art_etiq = 0`), cumul, remplacement, suppression par la grille | log de la table temporaire, PDF | `tests/etigond_liste/` | à faire |
| ETIGOND-T08 | replay | Stock | `EtiqStk` ; stocks 0, 0,5, 3 ; non stocké | nombres figés | `tests/etigond_stock/` | à faire |
| ETIGOND-T09 | replay | Dymo | `Impetiq = "3- Dymo"` ; `Posetiq` = 1 puis 3 | PDF `dymog` ; erreur figée avec `Posetiq` = 3 (A02) | `tests/etigond_dymo/` | à faire |
| ETIGOND-T10 | replay | Zebra | `Impetiq = "2- Zebra"` | « Null object » figé (A01) | `tests/etigond_zebra/` | à faire |
| ETIGOND-T11 | replay | Code TVA inconnu / article orphelin en liste | article avec `art_tva` absent de `Fiches_Tvaav` ; code de liste absent de `Fiches_Art` | erreurs figées (A05) | `tests/etigond_erreurs/` | à faire |
| ETIGOND-T12 | replay | Import portable | comme ETIQART-T09 | idem (A02 d'Etiqart reproduite) | `tests/etigond_portable/` | à faire |
| ETIGOND-T13 | gbtest | Calcul de position V2 (après ETIQART-010) | `PlancheEtiquettes` V2, A4 et Dymo | suites (X, Y, page) relevées en T06/T09 | `tests/planche_v2/` | à faire |

## Détail des tests

- **Rejeu** : `Utils.Observers(Me)` appelé deux fois dans `form_Open` (événements en double
  probables) ; `Gridbart_Click`/`Col*_Click` rejoués par `Object.Call` ; dialogues
  Cumuler/Remplacer à piloter.
- **Table temporaire** : invisible dans un dump pris par une autre connexion ; on relève son contenu
  par le log `Exec_SQL` ou par un `SELECT` injecté dans le scénario avant Imprimer.
- **Non testable** : imprimante physique, visionneuse, éditeur, aide, Zebra (ZEBRA-A01).
