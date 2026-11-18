# barselection — Tests

> Source : `.src/Gestion/option/barselection.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La barre n'a de sens que dans un écran appelant : tests `replay` sur `Tconsigne` (barre
complète) et `Mreglement` (barre réduite), à mutualiser avec leurs propres tests.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| BARSELECTION-T01 | replay | Navigation | `Tconsigne` : premier, suivant, précédent, dernier, recherche, sortie | fiche affichée à chaque étape (log) | `tests/navigation/` | implémenté (`Gestion/barselection_navigation` : suivant ×2, premier, suivant ×2 (le 2e sans effet en fin), précédent, dernier, précédent, Sortie ; Recherche : gb.test `BarselectionTest.T01Recherche` : 9e bouton cliqué par Value = True sur Tconsigne affichée, Rechcons modale pilotée par un Timer du module, ligne 2 → fiche P1) |
| BARSELECTION-T02 | replay | Création | création puis Valider ; création puis Annuler | `Fiches_consigne` (dump) ; barre reconstruite | `tests/creation/` | implémenté, découpé en deux scénarios (23 s mesurées réunis) : `Gestion/barselection_creation` (création PX validée, Dernier, fermeture) et `Gestion/barselection_creation_annulee` (création PY annulée, Dernier, fermeture) |
| BARSELECTION-T03 | replay | Modification et suppression | modification validée ; suppression validée et annulée | dump ; `estcreer`/`estmodif` (log) | `tests/modif_suppression/` | implémenté (`Gestion/barselection_modif_suppression` : modification validée, suppression annulée puis validée, Suivant, fermeture ; Tconsigne.bar1_suprimer vide : aucune suppression) |
| BARSELECTION-T04 | replay | Refus de l'appelant (A01) | `Mreglement` : Modification sans ligne sélectionnée ; Valider avec code vide (`Stop Event`) | barre restée en mode validation (figé) | `tests/refus_appelant/` | implémenté (gb.test `BarselectionTest.T04RefusAppelant`, vague 8 : Mreglement affiché, ligne -1, Modification par `Value = True` : barre en mode validation (étiquette + 2 boutons) alors que `bar1_modif` a refusé (A01) ; Valider code vide : boîte « Code obligatoire » (Timer), puis barre **reconstruite** (bar1_valide ne pose pas `Stop Event`), Fiches_Reglements inchangée) |

## Détail des tests

- **Implémentation (phase 2, vague 7)** : scénarios propres `Gestion/assets/barselection_navigation` (T01), `barselection_creation` et `barselection_creation_annulee` (T02), `barselection_modif_suppression` (T03) ; gb.test `BarselectionTest` (Recherche, T01), sur l'écran `Tconsigne` (barre « 111111111 », `/Soc01/bois`, jeu `consigne_shared/consigne_base`). La barre est aussi exercée par les scénarios Tregie, Tregion, Ttourne et Tconsigne. Boutons homonymes `bout` : Focus sur le 1er, Tab x (n-1), Espace ; `butval` : Focus (Annuler), Tab, Espace (Valider).

- **Données** : schéma boisson (`modfichier`) pour `Tconsigne` ; `Laurux01.sql` pour `Mreglement`.
- **Rejeu** : les boutons sont créés par code sans nom ; vérifier en phase 2 que `ReplayObserver`
  les identifie (sinon scénarios manuels documentés).
- **gbtest** : seule `visible` est de la logique pure, mais `Private` ; non retenu.
