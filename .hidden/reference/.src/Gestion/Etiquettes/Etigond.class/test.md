# Etigond — Tests

> Source : `.src/Gestion/Etiquettes/Etigond.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Même principe qu'[Etiqart](../Etiqart.class/test.md) : `replay`, diff du dump (table temporaire
`Etiquettes` relevée par le log, elle disparaît avec la connexion) et du PDF normalisé
`~/tmp/EtiqGond.pdf`. Références capturées dans le clone **Laurux non modifié**, jeu
`etiquettes_base` (avec deux modèles A4 dont les libellés contiennent « Gondole » et « Article »).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ETIGOND-T01 | replay | Gondole A4, plage | menu Gondole ; modèle « Gondole » ; PV HT + TTC ; Imprimer | PDF (cadre, prix, TVA, EAN13) | `tests/etigond_gondole_a4/` | implémenté |
| ETIGOND-T02 | replay | Mise en page « Article » | modèle « Article » ; prix au kg TTC | PDF mise en page article | `tests/etigond_article_a4/` | implémenté |
| ETIGOND-T03 | replay | Modèle sans mot-clé | modèle `Z- Test` | PDF sans étiquette (A03 figée) | `tests/etigond_sans_mot_cle/` | implémenté |
| ETIGOND-T04 | replay | Options | combinaisons `CheckBox1..4`, `RadioButton5/6`, `/Soc01/Kgl` | PDF par combinaison | `tests/etigond_options/` | implémenté |
| ETIGOND-T05 | replay | Les 5 tris + bornes | `Radiobutton1..4`, `Radiobutton7` | ordre des articles | `tests/etigond_tris/` | implémenté |
| ETIGOND-T06 | replay | Position de départ, deux impressions | `Posetiq` = 4, Imprimer ; puis `Posetiq` = 1, Imprimer | positions ; 2e PDF : 1re étiquette en (0, 0) figée (A04) | `tests/etigond_position/` | implémenté |
| ETIGOND-T07 | replay | Mode liste et grille | `Liste` ; ajout (y compris article `art_etiq = 0`), cumul, remplacement, suppression par la grille | log de la table temporaire, PDF | `tests/etigond_liste/` | implémenté |
| ETIGOND-T08 | replay | Stock | `EtiqStk` ; stocks 0, 0,5, 3 ; non stocké | nombres figés | `tests/etigond_stock/` | implémenté |
| ETIGOND-T09 | replay | Dymo | `Impetiq = "3- Dymo"` ; `Posetiq` = 1 puis 3 | PDF `dymog` ; erreur figée avec `Posetiq` = 3 (A02) | `tests/etigond_dymo/` | implémenté |
| ETIGOND-T10 | replay | Zebra | `Impetiq = "2- Zebra"` | « Null object » figé (A01) | `tests/etigond_zebra/` | implémenté |
| ETIGOND-T11 | replay | Code TVA inconnu / article orphelin en liste | article avec `art_tva` absent de `Fiches_Tvaav` ; code de liste absent de `Fiches_Art` | erreurs figées (A05) | `tests/etigond_erreurs/` | implémenté |
| ETIGOND-T12 | replay | Import portable | comme ETIQART-T09 | idem (A02 d'Etiqart reproduite) | `tests/etigond_portable/` | implémenté |
| ETIGOND-T13 | gbtest | Calcul de position V2 (après ETIQART-010) | `PlancheEtiquettes` V2, A4 et Dymo | suites (X, Y, page) relevées en T06/T09 | `tests/planche_v2/` | à faire : après extraction ETIQART-010 (PlancheEtiquettes) |

## Détail des tests

- **Implémentation (vague 4)** : assets `.hidden/Tests/Gestion/assets/etigond_{gondole_a4,article_a4,sans_mot_cle,options,tris,position,liste,stock,dymo,dymo_position,zebra,erreurs,portable}/`, jeu `etigond_shared/etigond_base.sql` (format `Z`, articles 001-005 avec stock, poids, unité, réf. fournisseur) et `etigond_erreurs/etigond_tva_inconnue.sql` (article 006, TVA 9). Texte du PDF par `pdftotext` en ajout (éditions successives concaténées). T09 en deux scénarios : `etigond_dymo` (Posetiq 1) et `etigond_dymo_position` (Posetiq 3 à la 1re édition : `Etigond.pos_Etiq.1021: Null object`, code 125 ; à la 2e édition l'objet PDF précédent est réutilisé et l'erreur ne se produit pas). T10 : Null object, code 125. T11 : seul le code TVA inconnu est testé (`Etigond.Imprime.905: Result is not available`, code 125) ; l'article orphelin en liste n'est pas atteignable par l'écran seul. T07 : 005 (`art_etiq` 0) accepté (contrôle commenté).

- **Rejeu** : `Utils.Observers(Me)` appelé deux fois dans `form_Open` (événements en double
  probables) ; `Gridbart_Click`/`Col*_Click` rejoués par `Object.Call` ; dialogues
  Cumuler/Remplacer à piloter.
- **Table temporaire** : invisible dans un dump pris par une autre connexion ; on relève son contenu
  par le log `Exec_SQL` ou par un `SELECT` injecté dans le scénario avant Imprimer.
- **Non testable** : imprimante physique, visionneuse, éditeur, aide, Zebra (ZEBRA-A01).
