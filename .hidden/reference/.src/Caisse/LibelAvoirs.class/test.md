# LibelAvoirs — Tests

> Source : `.src/Caisse/LibelAvoirs.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie sans logique de calcul : tests `replay` avec comparaison du dump de `Fiches_LibelAvoirs`.
⚠️ L'écran n'appelle pas `Utils.Observers(Me)` (LIBELAVOIRS-A02) : seuls l'ouverture par
`Fmenu.Menu208_Click` et la fermeture sont journalisées. La saisie de `TxtAvoirs` et le clic
« Enregistrer » doivent être injectés par le harnais (à valider en phase 2), ou les scénarios
attendent la correction de A02.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LIBELAVOIRS-T01 | replay | Création puis modification | `Fiches_LibelAvoirs` vide ; saisie de 2 lignes, Enregistrer ; réouverture, modification, Enregistrer | 1 ligne dans `Fiches_LibelAvoirs` (INSERT puis UPDATE) ; texte relu à la réouverture | `tests/libelavoirs_saisie/` | à faire |
| LIBELAVOIRS-T02 | replay | Texte vide (A01) | texte existant ; champ vidé, Enregistrer | dump inchangé (texte non effacé) | `tests/libelavoirs_vide/` | à faire |
| LIBELAVOIRS-T03 | replay | `Utils.ReplaceLb` | texte avec `"` et `&` | stocké avec `''` et `et` | `tests/libelavoirs_caracteres/` | à faire |

## Détail des tests

- **Valeurs attendues** : dump de `Fiches_LibelAvoirs` produit en rejouant le scénario dans le clone Laurux
  non modifié (base `Laurux01.sql` dont `Fiches_LibelAvoirs` est vidée pour T01).
- **Lecture côté caisse** : l'effet sur le ticket (Caisse.class:289) est couvert par les tests de
  `Caisse` / `Cfacture` (CFACTURE-T08), pas ici.
- **Non testable automatiquement** : `Button1_Click` (`Doc.Open`, navigateur externe) ; vérifier
  seulement l'absence d'erreur.
- Après la séparation LIBELAVOIRS-003, `LitTexte`/`EcritTexte` restent privés : la couverture reste
  assurée par les replays (règle de portée, PLAN §6).
