# ImpDepots — Tests

> Source : `.src/Gestion/Depots/ImpDepots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition sans écriture en base : comparaison du PDF produit (texte extrait). L'écran
n'appelant pas `Utils.Observers`, les scénarios `replay` supposent une instrumentation par le
harnais (à valider en phase 2). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPDEPOTS-T01 | replay | Impression chiffrée | dépôt `02` avec 3 articles ; chiffrée ; Imprimer | `~/tmp/Depots.pdf` (texte de référence : prix HT/TVA/TTC/qté) | `tests/chiffree/` | à faire |
| IMPDEPOTS-T02 | replay | Impression non chiffrée | même dépôt ; non chiffrée | PDF codes/libellés/quantités | `tests/non_chiffree/` | à faire |
| IMPDEPOTS-T03 | replay | Dépôt vide ou inconnu | code `99` | message « aucun article » puis comportement de `Draw.End` figé (A01) | `tests/depot_vide/` | à faire |
| IMPDEPOTS-T04 | replay | Saut de page | dépôt de 60 articles | 2 pages, en-têtes répétés | `tests/saut_page/` | à faire |

## Détail des tests

- **Données** : jeu dérivé de `Laurux01.sql` (stock du dépôt `02` initialisé par DEPOTS-T01 puis
  quantités fixées ; une ligne de stock d'article inexistant).
- **Comparaison** : `pdftotext` du PDF, sans dates d'édition.
