# rechcons — Tests

> Source : `.src/Gestion/option/rechcons.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre de recherche en lecture seule. Elle n'appelle pas `Utils.Observers` : elle n'est testable
en `replay` qu'après RECHCONS-A01 ; en attendant, test via l'écran appelant et `gbtest` sous Xvfb
(instanciation, lecture de la grille). Valeurs attendues produites dans le clone **Laurux non
modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RECHCONS-T01 | gbtest | Chargement par type | `New Rechcons("T")`, `"P"`, `"C"`, `"B"`, `"X"` (Xvfb) | `GridView1.Rows.Count` et contenu des cellules | `tests/chargement/` | à faire |
| RECHCONS-T02 | gbtest | Filtres | `Textcode.Text = "P"`, puis `Texlib.Text = "pal"` en mode `"T"` et `"C"` | nombre de lignes de référence | `tests/filtres/` | à faire |
| RECHCONS-T03 | gbtest | Sélection | `GridView1.Row = 1` ; `GridView1_Activate` | événement `trouver` reçu avec le code ; fenêtre fermée | `tests/selection/` | à faire |
| RECHCONS-T04 | replay | Recherche depuis `Tconsigne` | voir TCONSIGNE-T05 | fiche affichée | `tests/depuis_tconsigne/` | à faire |

## Détail des tests

- **Données** : jeu `option_boisson` (3 consignes de types différents + 1 de type inconnu).
- **gbtest** : la classe est un `Form` ; exécution sous Xvfb ; la grille est lue par
  `GridView1[row, col].Text` après forçage du rendu (`GridView1_Data`).
- **Rejeu** : impossible en l'état (pas d'observateurs, pas de `GridView1_Click`).
