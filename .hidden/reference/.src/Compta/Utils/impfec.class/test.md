# impfec — Tests

> Source : `.src/Compta/Utils/impfec.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre d'import : l'essentiel se teste par **replay** (menu Comptabilité > Outils > Import
fichier FEC). Chaque test fournit un fichier FEC d'entrée de référence (`tests/<nom>/data/`) et
compare, après import, le **dump normalisé** des tables `Fiches_Mvt` (y compris `control`),
`Fiches_Parametres` (`numecriture`) et `Fiches_Comptes` (`solde`, après `Calcsolde`), ainsi que le
texte de `TextArea1`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPFEC-T01 | replay | Import nominal sans renumérotation | FEC 18 colonnes, séparateur `\|`, CRLF, 3 écritures (VE, AC, BQ), comptes existants, un compte avec `coll_cc` | lignes `Fiches_Mvt` (dont ligne collectif), SHA1 `control`, soldes ; message de succès | `tests/import_nominal/` | implémenté (scénario `impfec_import_nominal`) |
| IMPFEC-T02 | replay | Import avec renumérotation | même fichier, « Renuméroter » coché | numéros = `numecriture` + 1…n ; `Fiches_Parametres.numecriture` final | `tests/import_renumerote/` | implémenté (scénario `impfec_import_renumerote`) |
| IMPFEC-T03 | replay | Contrôle bloquant | journal inconnu, compte inconnu, numéro existant, numéro non numérique | messages `TextArea1` ; base inchangée (dump identique) | `tests/controle_bloquant/` | implémenté (scénario `impfec_controle_bloquant` : base inchangée ; texte de TextArea1 non comparé) |
| IMPFEC-T04 | replay | Séparateurs | même FEC en tabulation, `;`, `,`, « Autre » ; puis mauvais séparateur | import identique ; message « problème soit sur le séparateur… » | `tests/separateurs/` | implémenté (scénarios `impfec_separateur_pipe`, `impfec_separateur_pv`, `impfec_separateur_virgule`, `impfec_separateur_faux`) |
| IMPFEC-T05 | replay | Comptes auxiliaires et correspondances | `CompAuxNum` court (complété), trop long, non numérique ; `Textcrt` = 3 et 5 ; entrées dans `Ciel_Lrx` / `Ciel_Lrx_Jo` | comptes et journaux retenus ; messages « non bloquant » | `tests/comptes_auxiliaires/` | implémenté partiellement (scénario `impfec_comptes_auxiliaires` : contrôle en échec dans ref, rien importé ; cause non visible sans TextArea1, à confirmer) |
| IMPFEC-T06 | replay | Arrêt pendant le contrôle | gros FEC (≥ 5 000 lignes), clic « Arret » | contrôle interrompu, aucune écriture, boutons réactivés | `tests/arret_controle/` | à faire : arrêt pendant le contrôle dépendant du minutage (clic « Arret » pendant la boucle ctrl), non tenté |
| IMPFEC-T07 | replay | Fin de ligne LF (caractérisation IMPFEC-A05) | FEC valide en fin de ligne Unix | message de séparateur, rien importé (comportement actuel figé) | `tests/fin_ligne_lf/` | implémenté (scénario `impfec_fin_ligne_lf` : aucun message, rien importé, A05 figée sous une autre forme que prévu) |
| IMPFEC-T08 | replay | Erreur en cours d'import (caractérisation IMPFEC-A02) | FEC dont une date est invalide (`20231399`) après des lignes valides | état de la base et des boutons figé (transaction ouverte, fenêtre non fermable) | `tests/erreur_import/` | implémenté (scénario `impfec_erreur_import`, `code_sortie` 125 : `impfec.trat.259` « Invalid date ») |
| IMPFEC-T09 | gbtest | `CompteFec` (après IMPFEC-003) | couples (`CompteNum`, `CompAuxNum`, nb car.) : vide, `111`/4, `12345`/4, `AB1`/4 | compte calculé identique à `ctrl`/`trat` actuels | `tests/compte_fec/` | à faire : CompteFec n'existe qu'après l'extraction IMPFEC-003 (ctrl/trat privés) |

## Détail des tests

- **Valeurs attendues** : capturées en phase 2 en rejouant chaque scénario dans le clone **Laurux
  non modifié**, sur une base `Laurux01.sql` importée dans le conteneur MariaDB jetable ; le dump
  est normalisé (tri des lignes, colonne `lind` masquée). Les FEC d'entrée sont générés par
  `gen_input.py` à partir d'un petit jeu d'écritures tiré de `Laurux01.sql` (comptes et journaux
  existants), puis altérés selon le cas.
- **T01/T02** couvrent aussi l'ouverture de `Calcsolde` (fermée par le scénario) : comparer
  `Fiches_Comptes.solde`/`soldep`.
- **T07/T08** sont des tests de caractérisation d'anomalies : ils figent le comportement actuel et
  seront mis à jour avec la correction validée.
- **T09** n'existe qu'après l'extraction de `CompteFec` ; la fonction doit être `Public` dans un
  module (ou testée via l'API publique) pour être visible de gb.test.
- **Non testable automatiquement** : comportement sous SQLite des `LOCK TABLES` (neutralisés) ;
  concurrence multi-postes sur `numecriture`.

- **Phase 2, vague 3** : aucun test implémentable aujourd'hui. Le fichier est lu par `Open FileChooser1.Value`
  (`ctrl`, `trat`) ; le rejeu ne sait pas renseigner un `FileChooser` (besoin d'outillage : action `Click=<chemin>`
  ou `Value=` pour FileChooser dans `ReplayObserver`, chemin relatif au HOME de test avec un FEC fourni dans les
  assets du scénario).
- **Phase 2, vague 5** : le `FileChooser` se renseigne au rejeu par `Focus=@FileChooser1#impfec#FileChooser1#` puis la
  frappe du nom du fichier (`f`,`e`,`c`,`.`,`t`,`x`,`t`) et Entrée : le fichier `~/fec.txt` (déposé par `entrees`, le
  FileChooser s'ouvre sur le HOME de test) est sélectionné. FEC produits par le générateur déterministe
  `.hidden/Tests/Compta/assets/impfec_shared/gen_fec.py` (`fec_nominal_tab/pipe/pv/virg/lf`, `fec_bloquant`, `fec_aux`,
  `fec_erreur`, montants entiers pour le séparateur virgule) ; jeu `impfec_shared/impfec_corresp` (Ciel_Lrx, Ciel_Lrx_Jo
  créées avec le schéma de `Utils.Ciel`). Après Traitement réussi : `Calcsolde` (Button2) puis son message (Entrée).
  Constats : T01 (numéros du FEC 101-103) et T02 (renumérotés 1-3) ; les lignes de tiers lettrées (`AA`) ont
  `lettree = 1` et `numlot` = lettre ; T07 : un FEC en LF passe le contrôle et affiche « succès » sans rien importer
  (lu comme une seule ligne, sautée comme en-tête) ; T08 : date `20231399` → erreur non interceptée après les 3 premières
  lignes (fenêtre bloquée, code 125).
