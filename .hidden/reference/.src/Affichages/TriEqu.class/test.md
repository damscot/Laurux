# TriEqu — Tests

> Source : `.src/Affichages/TriEqu.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre ouverte uniquement depuis une ligne de `Facture` (revue manuelle). Décision utilisateur du
2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle
(module gb.test `TriEquTest` de l'agent 5, jeu `assets/TriEquTest/equivalents`, fenêtre instanciée comme par `Facture` ; la reprise sur la ligne de
facture reste dans la revue manuelle de `Facture`). Base `Laurux01.sql` + jeu dérivé `equivalents` : un code
équivalent partagé par au moins 2 pages d'articles (stocks min. nuls et non nuls), un type de
client avec remise sur la famille. Comparaison : article repris sur la ligne, dump normalisé de la
facture enregistrée (`Fiches_Bl`/`Fiches_Ligbl` ou historique), lignes `Exec_SQL` informatives.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIEQU-T01 | gbtest | Choix d'un équivalent | facture : saisie du code équivalent, clic sur le 2ᵉ article, quantité, validation | article choisi repris sur la ligne ; facture enregistrée (dump) | `tests/choix_equivalent/` | implémenté (TriEquTest.T01ChoixEquivalent, gb.test écrit par l’agent 5, vérifié dans rework : 2e article, Bsel et $Codearticle) ; la reprise sur la ligne de facture passe par Facture (revue manuelle) |
| TRIEQU-T02 | gbtest | Annulation | même saisie, Échap ; puis F2 dans un en-tête ; puis fermeture par la croix | `Variables.Bsel = False`, code article vidé dans la ligne | `tests/annulation/` | implémenté (T02Annulation : fermeture sans choix, Form_Close) ; Échap / F2 : à faire (Key.Code) |
| TRIEQU-T03 | gbtest | Tri et double-clic (A01) | clic sur `Code`, `Qté`, `PA HT` ; double-clic ; PageDown | figer : tri décroissant à chaque double-clic, page suivante en croissant | `tests/tri/` | implémenté (T03TriDoubleClic ; A01 figée : double-clic toujours décroissant, page suivante en croissant) |
| TRIEQU-T04 | gbtest | Pagination | PageDown, PageUp, molette, boutons, flèches en bord de page | `LIMIT` successifs de référence | `tests/pagination/` | implémenté (T04Pagination : Descendre/Remonter, dernière page, Remonter sous 0) ; molette et PageDown/PageUp : à faire (Mouse.Delta, Key.Code) |
| TRIEQU-T05 | gbtest | Colonne « HT Pro » (A02) | client avec remise par type, `retro` non coché | figer : colonne vide ; 2 requêtes `Fiches_Art`/`Fiches_RemTypec` par ligne affichée | `tests/ht_pro/` | implémenté (T05HtPro ; A02 figée : colonne HT Pro vide, retro faux et vrai) |
| TRIEQU-T06 | gbtest | `RequeteEquivalents` (après TRIEQU-005) | code, `tri2` ∈ {`art_code`, `art_qte`, `art_paht`}, sens, pages | texte SQL identique au clone non modifié | `tests/requete_equivalents/` | à faire : après extraction de RequeteEquivalents (TRIEQU-005) ; le texte SQL n’est pas accessible en gb.test aujourd’hui |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 à A03 figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` ; `Colart_Click` est rejoué par `Object.Call`
  (doit rester `Public`). Pas de `replay_missing`.
- **TRIEQU-002** (suppression de `Tarifclient`) : le replay T05 compare l'affichage (colonne vide)
  et le dump ; le diff `Exec_SQL` montrera les requêtes en moins (attendu, « SQL modifié »).
- **Couleur des lignes** : vérification visuelle (captures) seulement.
