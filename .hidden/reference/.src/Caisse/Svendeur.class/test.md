# Svendeur — Tests

> Source : `.src/Caisse/Svendeur.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI ouvert depuis la saisie `Caisse` (`Alt+V` ou `Ctrl+X`, ticket vide), caisse connectée
(`./Laurux -p`, `Cmenu` → « Saisie caisse »). `Utils.Observers(Me)` est appelé une seule fois dans
`_new` : rejouable ; sélection par `ComboBox` (pas de grille). Comparaisons : vendeur affiché sur
le ticket, colonne `vendeur` du ticket enregistré (`Fiches_EntTicketz`), messages.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SVENDEUR-T01 | replay | Liste des vendeurs | `caisse_base` | entrée vide puis « code nom » de chaque vendeur | `tests/liste/` | à faire |
| SVENDEUR-T02 | replay | Changement de vendeur | caisse connectée avec le vendeur `1`, `Alt+V`, vendeur `12`, « Utiliser », puis un ticket encaissé | figer : vendeur du ticket inchangé (`Caisse.$Vendeur` écrit sur l'auto-instance, A01) | `tests/changement_vendeur/` | à faire |
| SVENDEUR-T03 | replay | Quitter / entrée vide | « Quitter » ; puis entrée vide et « Utiliser » | aucun changement de vendeur | `tests/quitter/` | à faire |
| SVENDEUR-T04 | replay | Code sur deux caractères | vendeur `12` choisi dans la liste | figer : recherche sur `1` (A02) | `tests/code_deux_car/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié**.
- **Données** : jeu dérivé `caisse_base` (vendeurs `1` et `12`, caisse `1` du poste de test,
  client caisse, un article vendable).
- T02 est le test de référence de l'anomalie A01 : après correction, le ticket doit porter le nom
  du vendeur choisi ; le test sera mis à jour.
- **Non testable automatiquement** : sons.
