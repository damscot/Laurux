# EdImpayes — Tests

> Source : `.src/Compta/Impressions/EdImpayes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

L'écran n'est atteignable par aucun menu : un replay classique (capturé depuis `Fmenu`) est
impossible. Les tests se limitent à vérifier l'absence d'usage et, si l'utilisateur refuse la
suppression, à une caractérisation par ouverture directe.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDIMPAYES-T01 | gbtest | Absence de référence | `grep -rn "EdImpayes" .src` hors du couple ; `gbc3 -agt` après suppression | aucune référence ; compilation sans erreur | `tests/absence_reference/` | à faire |
| EDIMPAYES-T02 | replay | Caractérisation (seulement si A01 refusée) | ouverture directe par un harnais (`EdImpayes.Show` depuis un module de test, à confirmer) ; jeu non lettré ; « Imprimer » | PDF `Enlettrees.pdf` comparé après `pdftotext` et normalisation (date, utilisateur) ; table `Ctrln` présente dans le dump | `tests/caracterisation/` | à faire |

## Détail des tests

- **Données** (T02) : `Laurux01.sql` ne contient **aucune écriture** : jeu dérivé commun aux
  éditions comptables décrit dans [Balance/test.md](../Balance.class/test.md#détail-des-tests),
  `faketime` à date fixe.
- **Non testable automatiquement** : l'ouverture depuis l'IHM (aucun menu).
