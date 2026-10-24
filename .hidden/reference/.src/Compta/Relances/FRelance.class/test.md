# FRelance — Tests

> Source : `.src/Compta/Relances/FRelance.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran sans API publique hors handlers : tous les tests sont des `replay` lancés depuis le menu
Relances › Saisie des textes ; on compare le dump de `Fiches_Txt_Relances`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRELANCE-T01 | replay | Ouverture et navigation | ouvrir l'écran, choisir chaque niveau de `Laurux01.sql` | textes affichés = contenu de la table | `tests/navigation/` | à faire |
| FRELANCE-T02 | replay | Modification d'un niveau existant | niveau 1, nouveaux textes, Enregistrer | dump `Fiches_Txt_Relances` (UPDATE) | `tests/modification/` | à faire |
| FRELANCE-T03 | replay | Création d'un niveau | saisir niveau 4 + textes, Enregistrer | ligne ajoutée, niveau ajouté à la liste | `tests/creation/` | à faire |
| FRELANCE-T04 | replay | Suppression confirmée / refusée | niveau 4 : Supprimer → Oui ; niveau 1 : Supprimer → Non | ligne 4 supprimée ; ligne 1 conservée mais zones vidées (A01 figée) | `tests/suppression/` | à faire |
| FRELANCE-T05 | replay | Niveau vide ou non numérique | Enregistrer sans niveau ; niveau « abc » | aucun SQL ; comportement actuel figé (erreur ou 0) | `tests/saisie_invalide/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB, `Laurux01.sql`),
  dump normalisé de `Fiches_Txt_Relances`.
- T04 fige l'anomalie FRELANCE-A01 ; T05 fige le comportement sur saisie non numérique (MySQL et
  SQLite peuvent différer : capturer les deux si le harnais SQLite est disponible).
- Non testable automatiquement : `Button4_Click` (ouverture de l'aide externe).
