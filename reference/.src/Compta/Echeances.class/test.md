# Echeances — Tests

> Source : `.src/Compta/Echeances.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI sans API publique de calcul : tous les tests sont des **replays**. Le critère est le dump
normalisé de `Fiches_Echeances` (et de la base entière pour vérifier l'absence d'effet de bord) ;
les valeurs affichées (`Dateech`, messages) sont comparées dans le log GUI.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECHEANCES-T01 | replay | Ouverture et liste | `Laurux01.sql`, menu Paramètres → Échéances | `Colech` rempli dans l'ordre de `num` ; aucune écriture en base | `tests/ouverture_liste/` | à faire |
| ECHEANCES-T02 | replay | Création | code `99`, libellé, durée `30`, jours `10`, `Finm` décoché, Enregistrer | 1 ligne `Fiches_Echeances` ajoutée ; champs **non** vidés (figé) ; valeur stockée de `finmois` | `tests/creation/` | à faire |
| ECHEANCES-T03 | replay | Modification | sélection d'une échéance existante, libellé et `Finm` modifiés, Enregistrer | ligne modifiée ; champs vidés après enregistrement | `tests/modification/` | à faire |
| ECHEANCES-T04 | replay | Suppression | sélection, Supprimer, « Non » puis « Oui » | « Non » : base inchangée ; « Oui » : ligne supprimée, message « echéance supprimée » | `tests/suppression/` | à faire |
| ECHEANCES-T05 | replay | Simulateur (`Button5`) | échéances 30 j, 45 j fin de mois, 60 j le 10 ; dates 15.01, 31.01, 28.02 | `Dateech` de référence (calcul `Utils.Calcech`) ; aucune écriture en base | `tests/simulateur/` | à faire |
| ECHEANCES-T06 | replay | Contrôles de saisie | code vide, libellé vide, durée `5` (1 car.), durée `0`, jours vides sans `Finm` | messages et focus attendus ; `"0"` devient `"00"` | `tests/controles_saisie/` | à faire |
| ECHEANCES-T07 | replay | Rappel par code (`echman`) | saisie d'un code existant + Entrée | champs remplis depuis la base, `Finm` cohérent | `tests/rappel_code/` | à faire |
| ECHEANCES-T08 | replay | Date du simulateur | `Datej` = `310299`, `0`, vide | date normalisée ; sentinelle → date du jour (masquée dans le dump du log) | `tests/date_simulateur/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**
  (`./Laurux -l --logfile …`, `-c <conf de test>`), puis rejoués sur les deux clones ; dump
  normalisé de la base et diff.
- **Données** : `Laurux01.sql` ; T05 ajoute trois échéances de référence (jeu dérivé
  `echeances_ref.sql`) pour couvrir fin de mois, 45 jours et jour fixe.
- **Date du jour** : T05 et T08 dépendent de `Now` quand `Datej` est vide ; le runner fixe la date
  (variable `faketime` ou saisie explicite) ou masque la valeur.
- **Non testable automatiquement** : sons, couleurs de focus, bouton d'aide (corps vide).
