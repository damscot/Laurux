# FCloture — Tests

> Source : `.src/Compta/Clotures/FCloture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de traitement : tests **replay** sur MariaDB Docker, critère = dump normalisé de
`Fiches_Mvt` et `Fiches_Parametres`. La clôture fait partie des **modules complexes** du plan
(PLAN §0) : la liste de scénarios ci-dessous est à présenter à l'utilisateur avant implémentation.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLOTURE-T01 | replay | Clôture d'un mois nominal | jeu dérivé de `Laurux01.sql` : mois M avec écritures validées, certaines avec `numerodef` déjà posé ; Oui | `cloturee = 1`, `dteval`, `numerodef` attribués dans l'ordre des `numero` ; `dtepc` = dernier jour de M ; `numecriture2` incrémenté | `tests/cloture_mois/` | à faire |
| FCLOTURE-T02 | replay | Écritures provisoires restantes | une écriture `provisoire = 1` dans M | message « non validées », aucune modification de la base | `tests/provisoires/` | à faire |
| FCLOTURE-T03 | replay | Clé SHA-1 altérée | `control` d'une écriture de M modifié | message « clé calculée… », fermeture ; écritures précédentes de la boucle déjà clôturées (comportement figé), `Fiches_Parametres` inchangé | `tests/sha1_invalide/` | à faire |
| FCLOTURE-T04 | replay | Clôture de décembre | `dtepc` au 30/11/N | `dtepc` = 31/12/N ; affichage suivant « janvier N+1 » | `tests/decembre/` | à faire |
| FCLOTURE-T05 | replay | Interruption par la barre de progression | clic sur Arrêter après k écritures | k écritures clôturées, `dtepc` avancé malgré tout (A01 figée) | `tests/interruption/` | à faire |
| FCLOTURE-T06 | replay | Mois sans écriture | aucun mouvement dans M | `Fiches_Mvt` inchangé ; `dtepc` avancé ; `numecriture2` inchangé | `tests/mois_vide/` | à faire |
| FCLOTURE-T07 | replay | Mois postérieur à la fin d'exercice | `dtepc` = `dteclec` | clôture acceptée (aucun contrôle, A02 figée) | `tests/hors_exercice/` | à faire |
| FCLOTURE-T08 | gbtest | Calcul période suivante / dernier jour (après FCLOTURE-005) | `dtepc` en fin de mois, décembre, février bissextile | mois suivant et dernier jour attendus | `tests/periode_suivante/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est capturé dans le clone **Laurux non
  modifié** puis rejoué sur les deux clones ; les dumps normalisés sont comparés.
- **Date du jour** : `dteval = Format$(Now, "yyyymmdd")`. Le runner fige la date (`faketime`) ou
  masque `dteval` dans la normalisation du dump.
- **Données** : jeu dérivé de `Laurux01.sql` construit par `gen_input.py` (écritures d'un mois
  donné, clés `control` recalculées par `Sha1Calc.CalcSha1_all` dans le clone de référence).
- **Non testable automatiquement** : `Aff_date` sur table `Fiches_Parametres` vide (appelle
  `Quit` ; scénario manuel), son, documentation HTML (`xdg-open`).
