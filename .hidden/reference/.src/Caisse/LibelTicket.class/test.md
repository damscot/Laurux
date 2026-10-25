# LibelTicket — Tests

> Source : `.src/Caisse/LibelTicket.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie sans logique de calcul : tests `replay` avec comparaison du dump de `Fiches_LibelTicket`.
⚠️ L'écran n'appelle pas `Utils.Observers(Me)` (LIBELTICKET-A02) : seuls l'ouverture par
`Fmenu.Menu207_Click` et la fermeture sont journalisées. La saisie de `Txtbfac` et le clic
« Enregistrer » doivent être injectés par le harnais (à valider en phase 2), ou les scénarios
attendent la correction de A02.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LIBELTICKET-T01 | replay | Création puis modification | `Fiches_LibelTicket` vide ; saisie de 2 lignes, Enregistrer ; réouverture, modification, Enregistrer | 1 ligne dans `Fiches_LibelTicket` (INSERT puis UPDATE) ; texte relu à la réouverture | `tests/libelticket_saisie/` | à faire |
| LIBELTICKET-T02 | replay | Texte vide (A01) | texte existant ; champ vidé, Enregistrer | dump inchangé (texte non effacé) | `tests/libelticket_vide/` | à faire |
| LIBELTICKET-T03 | replay | `Utils.ReplaceLb` | texte avec `"` et `&` | stocké avec `''` et `et` | `tests/libelticket_caracteres/` | à faire |
| LIBELTICKET-T04 | replay | Limite de longueur (A03) | 4 lignes de 72 caractères (≈ 291 caractères) | contenu de `Fiches_LibelTicket` ou erreur SQL figés (selon `sql_mode` de la base de test) | `tests/libelticket_longueur/` | à faire |

## Détail des tests

- **Valeurs attendues** : dump de `Fiches_LibelTicket` produit en rejouant le scénario dans le clone Laurux
  non modifié (base `Laurux01.sql` dont `Fiches_LibelTicket` est vidée pour T01).
- **Lecture côté caisse** : l'effet sur le ticket (Caisse.class:4008) est couvert par les tests de
  `Caisse` / `Cfacture` (CFACTURE-T08), pas ici.
- **Non testable automatiquement** : `Button1_Click` (`Doc.Open`, navigateur externe) ; vérifier
  seulement l'absence d'erreur.
- Après la séparation LIBELTICKET-003, `LitTexte`/`EcritTexte` restent privés : la couverture reste
  assurée par les replays (règle de portée, PLAN §6).
