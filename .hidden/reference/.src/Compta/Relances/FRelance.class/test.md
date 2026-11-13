# FRelance — Tests

> Source : `.src/Compta/Relances/FRelance.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran sans API publique hors handlers : tous les tests sont des `replay` lancés depuis le menu
Relances › Saisie des textes ; on compare le dump de `Fiches_Txt_Relances`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FRELANCE-T01 | replay | Ouverture et navigation | ouvrir l'écran, choisir chaque niveau de `Laurux01.sql` | textes affichés = contenu de la table | `tests/navigation/` | implémenté |
| FRELANCE-T02 | replay | Modification d'un niveau existant | niveau 1, nouveaux textes, Enregistrer | dump `Fiches_Txt_Relances` (UPDATE) | `tests/modification/` | implémenté |
| FRELANCE-T03 | replay | Création d'un niveau | saisir niveau 4 + textes, Enregistrer | ligne ajoutée, niveau ajouté à la liste | `tests/creation/` | implémenté |
| FRELANCE-T04 | replay | Suppression confirmée / refusée | niveau 4 : Supprimer → Oui ; niveau 1 : Supprimer → Non | ligne 4 supprimée ; ligne 1 conservée mais zones vidées (A01 figée) | `tests/suppression/` | implémenté |
| FRELANCE-T05 | replay | Niveau vide ou non numérique | Enregistrer sans niveau ; niveau « abc » | aucun SQL ; comportement actuel figé (erreur ou 0) | `tests/saisie_invalide/` | implémenté |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié (MariaDB, `Laurux01.sql`),
  dump normalisé de `Fiches_Txt_Relances`.
- T04 fige l'anomalie FRELANCE-A01 ; T05 fige le comportement sur saisie non numérique (MySQL et
  SQLite peuvent différer : capturer les deux si le harnais SQLite est disponible).
- Non testable automatiquement : `Button4_Click` (ouverture de l'aide externe).
- **Implémentation (phase 2, vague 4)** : scénarios `.hidden/Tests/Compta/assets/frelance_<nom>/` depuis
  Relances › Saisie des textes (`Menu27`, fenêtre `Frelance`). T01 `navigation` (lecture seule, sql.log comparé ;
  l'affectation de `niveau.Text` dans `Form_Open` déclenche déjà `niveau_Click`), T02 `modification`, T03 `creation`
  (la frappe dans la ComboBox déclenche `niveau_Click` : zones vidées avant la saisie), T04 `suppression` (jeu
  `frelance_suppression/frelance_niveau4.sql` ; Oui = Entrée, Non = Tab + Espace ; puis Enregistrer avec niveau
  vide : aucun SQL), T05 `saisie_invalide` (`MaxLength` = 1 : « abc » impossible, « a » saisi ; MariaDB
  non strict : ligne insérée avec `niveau` = 0, comportement figé ; variante SQLite non capturée).
