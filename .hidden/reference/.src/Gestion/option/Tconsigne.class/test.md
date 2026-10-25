# Tconsigne — Tests

> Source : `.src/Gestion/option/Tconsigne.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie sans logique de calcul : tests `replay` (journal `Utils.Observers` présent) avec
diff du dump de `Fiches_consigne`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TCONSIGNE-T01 | replay | Navigation | Option → Consignes ; premier, suivant ×2, précédent, dernier | aucune écriture ; champs affichés (log) | `tests/navigation/` | à faire |
| TCONSIGNE-T02 | replay | Création | Création ; code `PX`, libellé, prix 1,50, type palette ; Valider | INSERT dans `Fiches_consigne` | `tests/creation/` | à faire |
| TCONSIGNE-T03 | replay | Création refusée | Création ; code existant puis code vide ; Valider ; Annuler | aucune écriture, `Rollback` | `tests/creation_refusee/` | à faire |
| TCONSIGNE-T04 | replay | Modification | fiche 2 ; Modification ; prix 2,00 ; Valider | UPDATE ; fiche affichée après validation (index `$ind` figé) | `tests/modification/` | à faire |
| TCONSIGNE-T05 | replay | Recherche | Recherche ; saisie de code dans `rechcons` ; double-clic | fiche choisie affichée | `tests/recherche/` | à faire |
| TCONSIGNE-T06 | replay | Fermeture pendant une saisie | Création ; code ; fermer la fenêtre ; « Oui » | erreur « Not enough arguments » figée (A01) ; état de la transaction | `tests/fermeture_saisie/` | à faire |

## Détail des tests

- **Données** : jeu dérivé `option_boisson` (voir `Consigne/test.md`) avec 3 consignes.
- **Comparaison** : dump normalisé de `Fiches_consigne` ; vérifier en fin de scénario que la
  connexion n'est plus en transaction (A02).
- **Rejeu** : la recherche passe par `rechcons`, qui n'appelle pas `Utils.Observers` et n'a pas de
  `GridView1_Click` (`replay_missing`) : T05 doit utiliser le filtre `Textcode` et l'activation
  (double-clic/Entrée) ou attendre RECHCONS-A01.
- **Non testable** : bouton Supprimer (handler vide, aucun effet observable hors retour de barre).
