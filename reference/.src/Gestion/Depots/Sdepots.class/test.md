# Sdepots — Tests

> Source : `.src/Gestion/Depots/Sdepots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_StkDepots` et `Fiches_Sdepots`. L'écran n'appelle pas
`Utils.Observers` : la capture des scénarios suppose une instrumentation par le harnais (à valider
en phase 2). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SDEPOTS-T01 | replay | Sortie partielle | dépôt `02` (stock 5) ; article ; qté 2 ; Valider | stock 3, sortie `S` « Sortie manuelle » | `tests/sortie_partielle/` | à faire |
| SDEPOTS-T02 | replay | Sortie supérieure au stock | stock 2 ; qté 5 | ligne de stock supprimée, sortie de 5 enregistrée | `tests/sortie_totale/` | à faire |
| SDEPOTS-T03 | replay | Dépôt magasin refusé | dépôt `01` au clavier ou par la liste | message, aucune écriture | `tests/refus_01/` | à faire |
| SDEPOTS-T04 | replay | Liste des articles du dépôt | bouton liste articles | erreur `Start.Soc` (A01 figée) | `tests/liste_articles/` | à faire |
| SDEPOTS-T05 | replay | Article absent du dépôt | code non présent dans `StkDepots` | message, aucune écriture | `tests/article_absent/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + stock du dépôt `02` (jeu dérivé de DEPOTS-T01).
- **Comparaison** : dump normalisé de `Fiches_StkDepots` et `Fiches_Sdepots` (`mind` masqué).
- **SQLite** : `art_man` par `db.Exec` (classe `DB`) à rejouer sur `Laurux01.sqlite` (A03).
