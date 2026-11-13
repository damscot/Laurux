# Centrales — Tests

> Source : `.src/Gestion/Tables/Centrales.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie sans logique `Public` réutilisable : tests `replay` avec diff de `Fiches_Centrales`.
Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CENTRALES-T01 | replay | Création | menu Centrales ; `C1`, `Centrale test` ; Enregistrer | ligne insérée | `tests/creation/` | implémenté |
| CENTRALES-T02 | replay | Modification | clic sur `C1` ; libellé modifié ; Enregistrer | UPDATE du libellé | `tests/modification/` | implémenté |
| CENTRALES-T03 | replay | Suppression de la ligne sélectionnée | sélection `C1`, code saisi `C2` ; Supprimer, Oui | `C1` supprimée (A02 figée) | `tests/suppression_selection/` | implémenté |
| CENTRALES-T04 | replay | Code avec apostrophe | code `A'` ; Enregistrer | erreur SQL du `SELECT` concaténé (A01 figée) | `tests/apostrophe/` | implémenté |
| CENTRALES-T05 | replay | Touche sur le bouton Enregistrer | focus sur Button3 ; touche Tab | enregistrement déclenché (comportement figé) | `tests/keypress_bouton/` | implémenté |

## Détail des tests

- **Implémentation (vague 4)** : scénarios `Gestion/centrales_creation`, `centrales_modification`, `centrales_suppression_selection`, `centrales_apostrophe` (code de sortie 125, `Query failed` en `Centrales.Button3_Click.116`), `centrales_keypress_bouton` (Focus sur Button3 puis Tab : un seul INSERT) ; jeu partagé `.hidden/Tests/Gestion/assets/centrales_shared/centrales_c1_c2.sql`.

- **Données** : `Laurux01.sql` (table vide) ; T02-T03 partent d'un jeu dérivé contenant `C1` et `C2`.
- **Comparaison** : dump normalisé de `Fiches_Centrales`.
- **Non testable automatiquement** : couleurs de focus (`OBS_*`) ; cas `Current = Null` de
  `Button2_Click` (erreur interactive, à documenter comme replay manuel).
- Les mêmes scénarios, paramétrés par le nom de table, servent à Identite, Statut et Typec : un
  générateur commun (`gen_input.py`) est à prévoir en phase 2.
