# RazInv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZINV-T01 | replay | Suppression confirmée | base avec `Fiches_Inv` générée (Geninv) ; Gestion > Stock > Inventaire > Suppression ; « Supprimer » ; « Oui » | `Fiches_Inv` absente du dump ; message « Inventaire effacé ! » | `tests/raz_oui/` | à faire |
| RAZINV-T02 | replay | Suppression refusée | idem, réponse « Non » | dump identique à l'entrée | `tests/raz_non/` | à faire |
| RAZINV-T03 | replay | Table absente | base sans `Fiches_Inv` ; « Supprimer » ; « Oui » | dump inchangé ; message de succès (comportement actuel figé) | `tests/raz_absente/` | à faire |

## Détail des tests

- Valeurs attendues produites en rejouant le scénario dans le clone **Laurux non modifié** ; base
  `Laurux01.sql` + `Fiches_Inv` créée par le scénario GENINV-T01 (jeu dérivé `inv_genere.sql`).
- Le dump normalisé doit inclure la **liste des tables** (la présence de `Fiches_Inv` est l'objet
  du test).
- Écran instrumenté (`Utils.Observers` dans `_new`) : rejouable.
- Non testable automatiquement : l'échec du `DROP` masqué par `Try` (nécessite un verrou externe).
