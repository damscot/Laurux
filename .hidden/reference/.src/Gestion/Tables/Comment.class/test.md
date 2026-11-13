# Comment — Tests

> Source : `.src/Gestion/Tables/Comment.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : `replay` avec diff de `Fiches_Commentaires`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMMENT-T01 | replay | Création multiligne | menu Commentaires ; `03`, texte sur 2 lignes avec `"` et `&` ; Enregistrer | ligne insérée, `"` → `''`, `&` → `et` ; liste : 1re ligne seulement | `tests/creation/` | implémenté |
| COMMENT-T02 | replay | Modification par la liste | clic `01` ; texte modifié ; Enregistrer | UPDATE, ligne `01` resélectionnée | `tests/modification/` | implémenté |
| COMMENT-T03 | replay | Modification sans sélection | saisie du code `02` existant sans clic ; Enregistrer | UPDATE puis erreur `Current = Null` (figée) | `tests/modif_sans_selection/` | implémenté |
| COMMENT-T04 | replay | Suppression | sélection `01`, code saisi `02` ; Supprimer, Oui | `01` supprimé (ligne sélectionnée) | `tests/suppression/` | implémenté |
| COMMENT-T05 | replay | Appel depuis la facture | saisie facture, zone commentaire, F4 ; création `04` ; Quitter | ligne insérée, retour à la facture | `tests/depuis_facture/` | à faire : passe par la saisie de facture (Facture, écran complexe) et la touche F4 (non rejouable) |

## Détail des tests

- **Implémentation (vague 4)** : scénarios `Gestion/comment_creation` (`"` stocké `''`, `&` → `et`, 2 lignes), `comment_modification`, `comment_modif_sans_selection` (code 125 : `Comment.Button2_Click.189: #13: Null object`), `comment_suppression` ; données de Laurux01 (01, 02), aucun jeu dérivé.

- **Données** : `Laurux01.sql` (commentaires `01` et `02`).
- **Comparaison** : dump normalisé de `Fiches_Commentaires`.
- **Non testable automatiquement** : couleur de focus, ouverture de l'aide.
- T05 dépend des scénarios de facturation (lot Facturation) : à enregistrer avec eux.
