# Tconsigne — Tests

> Source : `.src/Gestion/option/Tconsigne.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie sans logique de calcul : tests `replay` (journal `Utils.Observers` présent) avec
diff du dump de `Fiches_consigne`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TCONSIGNE-T01 | replay | Navigation | Option → Consignes ; premier, suivant ×2, précédent, dernier | aucune écriture ; champs affichés (log) | `tests/navigation/` | implémenté |
| TCONSIGNE-T02 | replay | Création | Création ; code `PX`, libellé, prix 1,50, type palette ; Valider | INSERT dans `Fiches_consigne` | `tests/creation/` | implémenté |
| TCONSIGNE-T03 | replay | Création refusée | Création ; code existant puis code vide ; Valider ; Annuler | aucune écriture, `Rollback` | `tests/creation_refusee/` | implémenté |
| TCONSIGNE-T04 | replay | Modification | fiche 2 ; Modification ; prix 2,00 ; Valider | UPDATE ; fiche affichée après validation (index `$ind` figé) | `tests/modification/` | implémenté |
| TCONSIGNE-T05 | replay | Recherche | Recherche ; saisie de code dans `rechcons` ; double-clic | fiche choisie affichée | `tests/recherche/` | implémenté (gb.test `TconsigneTest.T05Recherche` : Rechcons("T") attachée sous « rech », GridView1_Activate appelé sur les lignes 2 puis 0 ; ShowModal de bar1_recherche non exercé) |
| TCONSIGNE-T06 | replay | Fermeture pendant une saisie | Création ; code ; fermer la fenêtre ; « Oui » | erreur « Not enough arguments » figée (A01) ; état de la transaction | `tests/fermeture_saisie/` | implémenté |

## Détail des tests

- **Données** : jeu dérivé `option_boisson` (voir `Consigne/test.md`) avec 3 consignes.
- **Comparaison** : dump normalisé de `Fiches_consigne` ; vérifier en fin de scénario que la
  connexion n'est plus en transaction (A02).
- **Rejeu** : la recherche passe par `rechcons`, qui n'appelle pas `Utils.Observers` et n'a pas de
  `GridView1_Click` (`replay_missing`) : T05 doit utiliser le filtre `Textcode` et l'activation
  (double-clic/Entrée) ou attendre RECHCONS-A01.
- **Non testable** : bouton Supprimer (handler vide, aucun effet observable hors retour de barre).
- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Gestion/assets/tconsigne_navigation/` (T01),
  `tconsigne_creation/` (T02), `tconsigne_creation_refusee/` (T03), `tconsigne_modification/` (T04),
  `tconsigne_fermeture_saisie/` (T06, `code_sortie` 125 : `Tconsigne.form_Close.158: Not enough arguments`). Conf
  `/Soc01/bois = True` : `menuopt` ajoute le menu dynamique `Tconsigne` sous Menu66 › Menu69 (nom du menu = nom
  d'événement, rejouable). Jeu `consigne_shared/consigne_base`. Barselection : 1er bouton « bout » par son nom, les
  suivants par Focus sur « bout » + Tab × n + Espace ; Valider = Focus « butval » + Tab + Espace. **Ne pas taper
  Entrée dans un champ** : `butval` Valider est le bouton par défaut (Entrée valide la création). T05 : sélection dans
  `Rechcons` non rejouable (GridView sans `_Click`).
