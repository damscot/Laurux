# Extrait — Tests

> Source : `.src/Compta/Extrait.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de consultation : replays sur MariaDB Docker. Critères : contenu de la grille et des
totaux (capture `ReplayObserver`), lignes `Exec_SQL` (bloquant pour les reworks « sans
changement SQL »), dump de la base (inchangé, hormis la table `Ctrln` en mode centralisé),
fichier `~/tmp/Extrait.pdf` (texte extrait par `pdftotext`) et clé `/Col/LcolE` du `Laurux.conf`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXTRAIT-T01 | replay | Ouverture depuis le menu | `Laurux01.sql`, date figée | premier compte client, période `E0`, totaux | `.hidden/Tests/Compta/assets/extrait_ouverture_menu/` | implémenté (requêtes comparées ; grille et totaux non comparés) |
| EXTRAIT-T02 | replay | Navigation | premier / suivant ×3 / précédent / dernier | compte affiché et grille à chaque étape | `.hidden/Tests/Compta/assets/extrait_navigation/` | implémenté (requêtes de chaque compte comparées) |
| EXTRAIT-T03 | replay | Types de compte | clic sur fournisseur, gestion, bilan | liste et premier compte de chaque type | `.hidden/Tests/Compta/assets/extrait_types_compte/` | implémenté |
| EXTRAIT-T04 | replay | Filtres de lettrage | toutes / lettrées / non lettrées sur un 411 partiellement lettré | lignes et totaux | `.hidden/Tests/Compta/assets/extrait_filtres_lettrage/` | implémenté |
| EXTRAIT-T05 | replay | Tris | clic sur chaque en-tête, deux fois | ordre des lignes ; `Exec_SQL` | `tests/tris/` | à faire : clic d'en-tête (TextLabel `Tdate`… _MouseDown) non rejoué |
| EXTRAIT-T06 | replay | Exercices | `E1`, `N1`…`N5` (base avec au moins deux exercices archivés) | périodes et lignes ; erreur figée pour un exercice absent (A07) | `.hidden/Tests/Compta/assets/extrait_exercices/` | implémenté (N1, E1, E0, N2 ; pas d'erreur pour N2 sans écriture) |
| EXTRAIT-T07 | replay | Compte centralisé | compte `cent_cc = 1`, `Ctrl` coché, `detail` décoché puis coché | lignes « Centralisation » par mois ; totaux période figés (A01) ; table `Ctrln` | `.hidden/Tests/Compta/assets/extrait_centralisation/` | implémenté (table Ctrln dans dump et SQL) |
| EXTRAIT-T08 | replay | Saisie manuelle du compte | `cpt` = préfixe valide, préfixe d'un autre type, compte absent | compte complété ; messages de type ; message « n'existe pas » | `.hidden/Tests/Compta/assets/extrait_saisie_compte/` | implémenté (partiel : préfixe complété) ; cas d'erreur à faire (Message.Warning ouvert pendant cpt_LostFocus : FMessage n'est pas la fenêtre active au rejeu) |
| EXTRAIT-T09 | replay | Modification d'écriture | double-clic sur écriture non clôturée, clôturée, pointée (banque) | bouton Modifier visible ou message ; ouverture de `Saisecrit`/`Tresor` | `tests/modification/` | à faire : sélection d'une ligne de Colcli impossible (ColumnView sans Colcli_Click : REPLAYOBSERVER-A06) ; Entrée sans ligne courante → Null object (Colcli_Activate.1148) |
| EXTRAIT-T10 | replay | Impression | compte client, puis compte de gestion | texte du PDF (en-tête société, adresse, lignes, totaux) | `tests/impression/` | à faire : sortie non comparée (~/tmp/Extrait.pdf) |
| EXTRAIT-T11 | replay | Largeurs de colonnes | redimensionnement puis Quitter ; réouverture | `/Soc01/Col/LcolE` écrit puis relu | `tests/largeurs_colonnes/` | à faire : redimensionnement de colonnes non rejoué ; sortie non comparée (Laurux.conf /Col/LcolE) |
| EXTRAIT-T12 | replay | Ouverture depuis `FClient` | `Org = "S"`, code client | compte positionné, `Colcli_Activate` sans effet | `.hidden/Tests/Compta/assets/extrait_ouverture_fclient/` | implémenté (via Fichiers › Clients, Button21) |
| EXTRAIT-T13 | replay | SQLite, compte centralisé | `Laurux01.sqlite` | échec de `CREATE TABLE Ctrln … ENGINE = MYISAM` figé (A02) | `tests/sqlite_centralisation/` | à faire : le runner ne rejoue que sur MariaDB (pas de base SQLite de test) |
| EXTRAIT-T14 | gbtest | Cumuls (après EXTRAIT-009) | `Result` simulé : écritures avant, dans et après la période | totaux hors période / période identiques à T01-T04 | `tests/cumuls/` | à faire : exige l'extraction EXTRAIT-009 |

## Détail des tests

- **Génération des valeurs attendues** : scénarios capturés dans le clone **Laurux non modifié**,
  rejoués dans les deux clones ; date figée (`faketime`) car la période `E0` dépend du jour.
- **Données** : `Laurux01.sql` ; jeu dérivé pour T06 (exercices archivés `Fiches_Mvt1`/`Mvt2`),
  T07 (compte centralisé avec plusieurs mois) et T09 (écritures clôturée et pointée).
- **Écrans appelés** : `Saisecrit`, `Tresor`, `Lettrage`, `TriCpt` sont fermés par le scénario
  (Échap) ; leur contenu n'est pas comparé ici.
- **Non testable automatiquement** : ouverture de documents GED (`LGed.Ouvrir`), documentation
  HTML, visualiseur PDF externe (le fichier seul est comparé).

### Implémentation (phase 2, agent 5)

- Scénarios `.hidden/Tests/Compta/assets/extrait_*/`, date figée **2018-06-15** (exercice en cours 2018 de
  `Laurux01`), jeu `.hidden/Tests/Compta/assets/extrait_shared/extrait_base.sql` (5 écritures 2018 dans `Fiches_Mvt` : facture et règlement lettrés,
  règlement banque pointé, facture non lettrée, facture clôturée sur 411002, achat 606100 ; une écriture 2017 dans
  `Fiches_Mvt1` ; 707000 centralisé). Menu `Fmenu#Menu67#Menu9#Menu16`.
- Écran de consultation : le critère comparé est la suite des requêtes `Listextcpt` (compte, période, filtre de
  lettrage, table d'exercice) dans `sql.log`, plus `Ctrln` (T07). La grille et les totaux ne sont pas comparés.
- Leçon de rejeu : une boîte `Message.*` ouverte depuis un `LostFocus` (ici `cpt_LostFocus` → `cpt_LF`/`compteman`)
  n'est pas la fenêtre active pour le rejeu (code 3) ; non rejouable aujourd'hui.
- T07 : le premier affichage du compte centralisé exécute `CREATE TABLE Ctrln … ENGINE = MYISAM` sans `DROP`
  préalable (le `DROP` n'intervient qu'aux affichages suivants).
