# Extrait — Tests

> Source : `.src/Compta/Extrait.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation : replays sur MariaDB Docker. Critères : contenu de la grille et des
totaux (capture `ReplayObserver`), lignes `Exec_SQL` (bloquant pour les reworks « sans
changement SQL »), dump de la base (inchangé, hormis la table `Ctrln` en mode centralisé),
fichier `~/tmp/Extrait.pdf` (texte extrait par `pdftotext`) et clé `/Col/LcolE` du `Laurux.conf`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXTRAIT-T01 | replay | Ouverture depuis le menu | `Laurux01.sql`, date figée | premier compte client, période `E0`, totaux | `tests/ouverture_menu/` | à faire |
| EXTRAIT-T02 | replay | Navigation | premier / suivant ×3 / précédent / dernier | compte affiché et grille à chaque étape | `tests/navigation/` | à faire |
| EXTRAIT-T03 | replay | Types de compte | clic sur fournisseur, gestion, bilan | liste et premier compte de chaque type | `tests/types_compte/` | à faire |
| EXTRAIT-T04 | replay | Filtres de lettrage | toutes / lettrées / non lettrées sur un 411 partiellement lettré | lignes et totaux | `tests/filtres_lettrage/` | à faire |
| EXTRAIT-T05 | replay | Tris | clic sur chaque en-tête, deux fois | ordre des lignes ; `Exec_SQL` | `tests/tris/` | à faire |
| EXTRAIT-T06 | replay | Exercices | `E1`, `N1`…`N5` (base avec au moins deux exercices archivés) | périodes et lignes ; erreur figée pour un exercice absent (A07) | `tests/exercices/` | à faire |
| EXTRAIT-T07 | replay | Compte centralisé | compte `cent_cc = 1`, `Ctrl` coché, `detail` décoché puis coché | lignes « Centralisation » par mois ; totaux période figés (A01) ; table `Ctrln` | `tests/centralisation/` | à faire |
| EXTRAIT-T08 | replay | Saisie manuelle du compte | `cpt` = préfixe valide, préfixe d'un autre type, compte absent | compte complété ; messages de type ; message « n'existe pas » | `tests/saisie_compte/` | à faire |
| EXTRAIT-T09 | replay | Modification d'écriture | double-clic sur écriture non clôturée, clôturée, pointée (banque) | bouton Modifier visible ou message ; ouverture de `Saisecrit`/`Tresor` | `tests/modification/` | à faire |
| EXTRAIT-T10 | replay | Impression | compte client, puis compte de gestion | texte du PDF (en-tête société, adresse, lignes, totaux) | `tests/impression/` | à faire |
| EXTRAIT-T11 | replay | Largeurs de colonnes | redimensionnement puis Quitter ; réouverture | `/Soc01/Col/LcolE` écrit puis relu | `tests/largeurs_colonnes/` | à faire |
| EXTRAIT-T12 | replay | Ouverture depuis `FClient` | `Org = "S"`, code client | compte positionné, `Colcli_Activate` sans effet | `tests/ouverture_fclient/` | à faire |
| EXTRAIT-T13 | replay | SQLite, compte centralisé | `Laurux01.sqlite` | échec de `CREATE TABLE Ctrln … ENGINE = MYISAM` figé (A02) | `tests/sqlite_centralisation/` | à faire |
| EXTRAIT-T14 | gbtest | Cumuls (après EXTRAIT-009) | `Result` simulé : écritures avant, dans et après la période | totaux hors période / période identiques à T01-T04 | `tests/cumuls/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**,
  rejoués dans les deux clones ; date figée (`faketime`) car la période `E0` dépend du jour.
- **Données** : `Laurux01.sql` ; jeu dérivé pour T06 (exercices archivés `Fiches_Mvt1`/`Mvt2`),
  T07 (compte centralisé avec plusieurs mois) et T09 (écritures clôturée et pointée).
- **Écrans appelés** : `Saisecrit`, `Tresor`, `Lettrage`, `TriCpt` sont fermés par le scénario
  (Échap) ; leur contenu n'est pas comparé ici.
- **Non testable automatiquement** : ouverture de documents GED (`LGed.Ouvrir`), documentation
  HTML, visualiseur PDF externe (le fichier seul est comparé).
