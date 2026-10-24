# Tmail — Tests

> Source : `.src/Gestion/Tables/Tmail.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_TxtMail`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TMAIL-T01 | replay | Création (table vide) | menu Texte des courriels ; texte ; Enregistrer | INSERT `lind = 1` | `tests/creation/` | à faire |
| TMAIL-T02 | replay | Modification | après T01, texte modifié avec `"` | UPDATE, `"` → `''` | `tests/modification/` | à faire |
| TMAIL-T03 | replay | Table sans ligne `lind = 1` | jeu dérivé `lind = 5` ; Enregistrer | nouvelle ligne insérée, affichage inchangé (figé) | `tests/lind_absent/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) ; jeu dérivé pour T03.
- **Comparaison** : dump normalisé de `Fiches_TxtMail`.
- La lecture par `ObjFacB` (envoi de facture par courriel) est couverte par les scénarios du lot
  option/Mails.
