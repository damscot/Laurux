# barselection — Tests

> Source : `.src/Gestion/option/barselection.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La barre n'a de sens que dans un écran appelant : tests `replay` sur `Tconsigne` (barre
complète) et `Mreglement` (barre réduite), à mutualiser avec leurs propres tests.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BARSELECTION-T01 | replay | Navigation | `Tconsigne` : premier, suivant, précédent, dernier, recherche, sortie | fiche affichée à chaque étape (log) | `tests/navigation/` | à faire |
| BARSELECTION-T02 | replay | Création | création puis Valider ; création puis Annuler | `Fiches_consigne` (dump) ; barre reconstruite | `tests/creation/` | à faire |
| BARSELECTION-T03 | replay | Modification et suppression | modification validée ; suppression validée et annulée | dump ; `estcreer`/`estmodif` (log) | `tests/modif_suppression/` | à faire |
| BARSELECTION-T04 | replay | Refus de l'appelant (A01) | `Mreglement` : Modification sans ligne sélectionnée ; Valider avec code vide (`Stop Event`) | barre restée en mode validation (figé) | `tests/refus_appelant/` | à faire |

## Détail des tests

- **Données** : schéma boisson (`modfichier`) pour `Tconsigne` ; `Laurux01.sql` pour `Mreglement`.
- **Rejeu** : les boutons sont créés par code sans nom ; vérifier en phase 2 que `ReplayObserver`
  les identifie (sinon scénarios manuels documentés).
- **gbtest** : seule `visible` est de la logique pure, mais `Private` ; non retenu.
