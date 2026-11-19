# RazInv — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZINV-T01 | replay | Suppression confirmée | base avec `Fiches_Inv` générée (Geninv) ; Gestion > Stock > Inventaire > Suppression ; « Supprimer » ; « Oui » | `Fiches_Inv` absente du dump ; message « Inventaire effacé ! » | `tests/raz_oui/` | implémenté (`Gestion/razinv_raz_oui`, jeu `validinv_shared/inv_fin_partiel`) |
| RAZINV-T02 | replay | Suppression refusée | idem, réponse « Non » | dump identique à l'entrée | `tests/raz_non/` | implémenté (`Gestion/razinv_raz_non`, jeu `validinv_shared/inv_fin_partiel`) |
| RAZINV-T03 | replay | Table absente | base sans `Fiches_Inv` ; « Supprimer » ; « Oui » | dump inchangé ; message de succès (comportement actuel figé) | `tests/raz_absente/` | implémenté (`Gestion/razinv_raz_absente`, jeu `Laurux01 seul`) |

## Détail des tests

- Valeurs attendues produites en rejouant le scénario dans le clone **Laurux non modifié** ; base
  `Laurux01.sql` + `Fiches_Inv` créée par le scénario GENINV-T01 (jeu dérivé `inv_genere.sql`).
- Le dump normalisé doit inclure la **liste des tables** (la présence de `Fiches_Inv` est l'objet
  du test).
- Écran instrumenté (`Utils.Observers` dans `_new`) : rejouable.
- Non testable automatiquement : l'échec du `DROP` masqué par `Try` (nécessite un verrou externe).
- Mise en œuvre (vague 9) : scénarios `Gestion/razinv_*` ; jeu `validinv_shared/inv_fin_partiel` (lecture seule) pour T01/T02, Laurux01 seul pour T03 ; générateur `ecarts_shared/gen_editions_inv.py`.
