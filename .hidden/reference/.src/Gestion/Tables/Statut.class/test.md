# Statut — Tests

> Source : `.src/Gestion/Tables/Statut.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Mêmes scénarios que [Centrales](../Centrales.class/test.md), sur `Fiches_Statut`. Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATUT-T01 | replay | Création | menu Statut ; `P1`, `Prospect` ; Enregistrer | ligne insérée | `tests/creation/` | implémenté |
| STATUT-T02 | replay | Modification | clic `P1` ; libellé modifié | UPDATE | `tests/modification/` | implémenté |
| STATUT-T03 | replay | Suppression de la ligne sélectionnée | sélection `P1`, code saisi `P2` ; Supprimer | `P1` supprimée (A02 figée) | `tests/suppression_selection/` | implémenté |
| STATUT-T04 | replay | Ouverture depuis l'emailing | sans objet en l'état : `EmailingCarte.form` n'a pas de bouton `bstatut` (`bstatut_Click` jamais levé, EMAILINGCARTE-A06) ; test à écrire seulement si l'anomalie est corrigée | fenêtre Statut affichée puis masquée | `tests/emailing_visible/` | bloqué |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) ; jeu dérivé `P1`, `P2` pour T02-T03.
- **Comparaison** : dump normalisé de `Fiches_Statut` ; T04 contrôle le log de rejeu (pas d'écriture).
- **Non testable automatiquement** : couleurs `OBS_*`, cas apostrophe (identique à CENTRALES-T04).
- **Implémentation (phase 2)** : scénarios synthétisés `.hidden/Tests/Gestion/assets/statut_creation/`,
  `statut_modification/` et `statut_suppression_selection/` (préfixe `statut_` : les noms `tests/creation/`…
  sont partagés par d'autres classes du lot Gestion ; menu `Menu66 › Menu69 › Menu219` de `Fmenu`). T02/T03 utilisent le
  jeu `.src/Tests/Framework/datasets/statut_p1_p2.sql` (`P1 Prospect`, `P2 Partenaire`). T03 confirme la
  question « Oui » par `Keypress=16777220@FMessage#FMessage#` (fenêtre `FMessage` de gb.gui.base) ; le `DELETE`
  porte sur `P1` (ligne sélectionnée, A02 figée).
