# Visimpayes — Tests

> Source : `.src/Compta/Lettrages/Visimpayes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran n'a aucun point d'entrée : aucun replay n'est possible depuis l'application. Le seul test
prévu instancie directement le formulaire, et n'a d'intérêt que si l'utilisateur décide de garder
le fichier (VISIMPAYES-A01).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISIMPAYES-T01 | gbtest | Instanciation directe (sous Xvfb) | `Laurux01.sql` ; `New Visimpayes` puis fermeture | contenu de `Facturefm`/`Detail`, `Label1` ; destruction de `Facturefm` figée | `tests/instanciation/` | à faire |

## Détail des tests

- **Conditionnel** : à implémenter seulement si A01 est refusée.
- **Données** : `Laurux01.sql` ; une écriture `411…` sans fiche `Fiches_Cli` provoque l'erreur décrite
  (cas exclu du jeu nominal).
- **Non testable** : `Coldetail_Keypress` (Suppr + `Message.Question`) sans pilotage GUI.
