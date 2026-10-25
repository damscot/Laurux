# MajFbtarif1 — Tests

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran n'est ouvert par aucun menu ni aucune classe : il ne peut être ni capturé ni rejoué
dans le clone Laurux non modifié. Aucun test fonctionnel n'est réalisable sans modifier un
menu, ce qui est interdit. Le seul contrôle utile est celui qui accompagne la suppression
(MAJFBTARIF1-A01).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MAJFBTARIF1-T01 | replay | Non-régression après suppression (A01) | `grep -rn MajFbtarif1 .src` vide, `gbc3 -agt` sans erreur, replay du menu « Future base tarif » (`MajFbtarif2`, `Etiqfbtarif`) | build vert, replays MAJFBTARIF2-T01 et Etiqfbtarif inchangés | `tests/suppression/` | à faire |

## Détail des tests

- **Cas non testables** : `Button2_Click` (import), `Button4_Click`/`fourList_*` (listes),
  `RadioButton*_Click`. Si l'utilisateur décide de **conserver** l'écran (A01 refusée), il faudra
  d'abord le rendre accessible (décision fonctionnelle hors rework), puis écrire un replay d'import
  sur un fichier `tests/import_fbt/fichier.csv` (modes fournisseur et centrale, code-barre de 13
  chiffres, vide, et ligne incomplète).
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` une seule fois ; `fourList_Click` est appelé
  dynamiquement par `ReplayObserver`.
