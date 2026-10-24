# ClotureF — Tests

> Source : `.src/Gestion/ClotureF.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module à risque (clôture) : la liste de scénarios ci-dessous est à **valider par l'utilisateur**
avant la phase 2 (règle « modules complexes » de PLAN.md).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CLOTUREF-T01 | replay | Clôture nominale | jeu dérivé : `dtepec = 03.2026`, 3 factures imprimées (`imp=1`, `type='F'`) dans `Fiches_Bl` datées de mars, 1 non imprimée, 1 d'avril ; Fmenu → Clôture mensuelle facturation → Lancer → Oui | dump de `Fiches_Bl`, `Fiches_Ligbl`, `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Parametres` (`dtepp`, `dtepec`), `Fiches_Comptes.solde` identique à la référence | `tests/cloture_nominale/` | à faire |
| CLOTUREF-T02 | replay | Factures « entretien » et borne de fin de mois | facture `Fiches_BlM` datée du dernier jour du mois et une du jour précédent ; idem dans `Fiches_Bl` | dump identique (fige l'anomalie A01 : la `BlM` du dernier jour reste non archivée) | `tests/borne_fin_mois/` | à faire |
| CLOTUREF-T03 | replay | Facture déjà archivée | même `numfac` présent dans `Fiches_HistoFac` et dans `Fiches_Bl` | avertissement de `transblfac` acquitté ; facture non transférée ; période avancée malgré tout | `tests/deja_archivee/` | à faire |
| CLOTUREF-T04 | replay | Refus de la confirmation | Lancer → Non | aucune modification de la base (dump identique au dump initial) ; fenêtre fermée | `tests/annulation/` | à faire |
| CLOTUREF-T05 | replay | Recalcul des soldes | écritures validées et non validées sur 3 comptes, solde initial faux | `Fiches_Comptes.solde` = Σ(débit − crédit) des écritures validées de `Fiches_Mvt` | `tests/recalcul_soldes/` | à faire |
| CLOTUREF-T06 | replay | Décembre → janvier | `dtepec = 12.2025` | `dtepp = 12.2025`, `dtepec = 01.2026` | `tests/changement_annee/` | à faire |
| CLOTUREF-T07 | replay | Paramètres vides / dates nulles | `dtepec` nul ou `00.0000` | affichage de la période courante (`Now`, horloge figée) ; fige le comportement actuel | `tests/dates_nulles/` | à faire |
| CLOTUREF-T08 | gbtest | Calcul « période suivante » | après séparation (CLOTUREF-006) : `03.2026`, `12.2025`, `01.2026` | `04.2026`, `01.2026`, `02.2026` | `tests/periode_suivante/` | à faire |

## Détail des tests

- **Valeurs attendues** : chaque replay est joué dans le clone **Laurux non modifié**, sur MariaDB
  Docker, et le dump normalisé est capturé dans `tests/<nom>/expected/`.
- **Données** : `Laurux01.sql` ne contient pas de facture imprimée non archivée ; un jeu dérivé
  (`tests/<nom>/*.sql`) ajoute les BL/factures, lignes et écritures nécessaires. Prévoir des
  factures avec matériel (`Fiches_Materiels`) pour couvrir la mise à jour `mat_bl` de
  `transblfac`.
- **Horloge** : `Aff_date` et `ObjFacB` utilisent `Now` → figer l'horloge (faketime) pour T07.
- **Non testable automatiquement** : le cas « table des paramètres vide » termine l'application
  (`Quit`) ; il est documenté et vérifié manuellement. L'interruption via la `ProgBar` n'est pas
  disponible (barre non interruptible).
