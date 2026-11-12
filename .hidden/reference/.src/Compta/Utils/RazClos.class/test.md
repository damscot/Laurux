# RazClos — Tests

> Source : `.src/Compta/Utils/RazClos.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZCLOS-T01 | replay | Déblocage d'une écriture clôturée | `Laurux01.sql` + écriture clôturée à 3 lignes ; saisie du numéro, Débloquer | dump `Fiches_Mvt` (`cloturee`, `control`) ; message | `tests/razclos_deblocage/` | implémenté (Compta/razclos_deblocage) |
| RAZCLOS-T02 | replay | Numéro inexistant ou vide | `999999`, `""`, `abc` | dump inchangé ; « Ecriture débloquée ! » figé (A02) | `tests/razclos_numero_invalide/` | implémenté (Compta/razclos_numero_invalide) |
| RAZCLOS-T03 | replay | Effet sur le contrôle des clés | après T01, modification de la ligne puis `Anomalies` | rapport « Aucune anomalie » figé si la modification passe par une écriture re-scellée (A01) | `tests/razclos_inalterabilite/` | implémenté (Compta/razclos_inalterabilite ; altération portée par le jeu, pas par Saisecrit) |
| RAZCLOS-T04 | replay | Lancement par `Prgm` | saisie `RazClos` | fenêtre `RazClos` ouverte | `tests/razclos_prgm/` | implémenté (couvert par Communs/prgm_dispatch_ecrans_6, PRGM-T02) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; base restaurée avant
  chaque test.
- T03 dépend du scénario de modification d'écriture (`Saisecrit`) : à préciser en phase 2.
- Jeu partagé : `.hidden/Tests/Compta/assets/razclos_shared/razclos_cloturee.sql` (écriture 10 à 3 lignes et
  écriture 11 à 2 lignes, clôturées, clés factices). T01 : `Compta/razclos_deblocage` ; T02 :
  `Compta/razclos_numero_invalide` (999999, vide → `numero = NULL`, `abc` ; message affiché à chaque fois, A02).
- T03 : `Compta/razclos_inalterabilite` : déblocage de 10 puis Anomalies des clés 2018 ; `sql.log` : les lignes de 10
  (re-scellées) ne sont plus recalculées pour le rapport, celles de 11 (clés factices) le sont (anomalies). Le
  rapport lui-même (PDF/message) n'est pas comparé.
