# TriEqu — Tests

> Source : `.src/Affichages/TriEqu.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre ouverte uniquement depuis une ligne de `Facture` : scénarios `replay` capturés dans le
clone **Laurux non modifié**, à valider avec l'utilisateur avec les autres scénarios de `Facture`
(module complexe, PLAN.md §0). Base `Laurux01.sql` + jeu dérivé `equivalents` : un code
équivalent partagé par au moins 2 pages d'articles (stocks min. nuls et non nuls), un type de
client avec remise sur la famille. Comparaison : article repris sur la ligne, dump normalisé de la
facture enregistrée (`Fiches_Bl`/`Fiches_Ligbl` ou historique), lignes `Exec_SQL` informatives.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIEQU-T01 | replay | Choix d'un équivalent | facture : saisie du code équivalent, clic sur le 2ᵉ article, quantité, validation | article choisi repris sur la ligne ; facture enregistrée (dump) | `tests/choix_equivalent/` | à faire |
| TRIEQU-T02 | replay | Annulation | même saisie, Échap ; puis F2 dans un en-tête ; puis fermeture par la croix | `Variables.Bsel = False`, code article vidé dans la ligne | `tests/annulation/` | à faire |
| TRIEQU-T03 | replay | Tri et double-clic (A01) | clic sur `Code`, `Qté`, `PA HT` ; double-clic ; PageDown | figer : tri décroissant à chaque double-clic, page suivante en croissant | `tests/tri/` | à faire |
| TRIEQU-T04 | replay | Pagination | PageDown, PageUp, molette, boutons, flèches en bord de page | `LIMIT` successifs de référence | `tests/pagination/` | à faire |
| TRIEQU-T05 | replay | Colonne « HT Pro » (A02) | client avec remise par type, `retro` non coché | figer : colonne vide ; 2 requêtes `Fiches_Art`/`Fiches_RemTypec` par ligne affichée | `tests/ht_pro/` | à faire |
| TRIEQU-T06 | gbtest | `RequeteEquivalents` (après TRIEQU-005) | code, `tri2` ∈ {`art_code`, `art_qte`, `art_paht`}, sens, pages | texte SQL identique au clone non modifié | `tests/requete_equivalents/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 à A03 figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` ; `Colart_Click` est rejoué par `Object.Call`
  (doit rester `Public`). Pas de `replay_missing`.
- **TRIEQU-002** (suppression de `Tarifclient`) : le replay T05 compare l'affichage (colonne vide)
  et le dump ; le diff `Exec_SQL` montrera les requêtes en moins (attendu, « SQL modifié »).
- **Couleur des lignes** : vérification visuelle (captures) seulement.
