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
| IMPFEC-T01 | replay | Import nominal sans renumérotation | FEC 18 colonnes, séparateur `\|`, CRLF, 3 écritures (VE, AC, BQ), comptes existants, un compte avec `coll_cc` | lignes `Fiches_Mvt` (dont ligne collectif), SHA1 `control`, soldes ; message de succès | `tests/import_nominal/` | à faire |
| IMPFEC-T02 | replay | Import avec renumérotation | même fichier, « Renuméroter » coché | numéros = `numecriture` + 1…n ; `Fiches_Parametres.numecriture` final | `tests/import_renumerote/` | à faire |
| IMPFEC-T03 | replay | Contrôle bloquant | journal inconnu, compte inconnu, numéro existant, numéro non numérique | messages `TextArea1` ; base inchangée (dump identique) | `tests/controle_bloquant/` | à faire |
| IMPFEC-T04 | replay | Séparateurs | même FEC en tabulation, `;`, `,`, « Autre » ; puis mauvais séparateur | import identique ; message « problème soit sur le séparateur… » | `tests/separateurs/` | à faire |
| IMPFEC-T05 | replay | Comptes auxiliaires et correspondances | `CompAuxNum` court (complété), trop long, non numérique ; `Textcrt` = 3 et 5 ; entrées dans `Ciel_Lrx` / `Ciel_Lrx_Jo` | comptes et journaux retenus ; messages « non bloquant » | `tests/comptes_auxiliaires/` | à faire |
| IMPFEC-T06 | replay | Arrêt pendant le contrôle | gros FEC (≥ 5 000 lignes), clic « Arret » | contrôle interrompu, aucune écriture, boutons réactivés | `tests/arret_controle/` | à faire |
| IMPFEC-T07 | replay | Fin de ligne LF (caractérisation IMPFEC-A05) | FEC valide en fin de ligne Unix | message de séparateur, rien importé (comportement actuel figé) | `tests/fin_ligne_lf/` | à faire |
| IMPFEC-T08 | replay | Erreur en cours d'import (caractérisation IMPFEC-A02) | FEC dont une date est invalide (`20231399`) après des lignes valides | état de la base et des boutons figé (transaction ouverte, fenêtre non fermable) | `tests/erreur_import/` | à faire |
| IMPFEC-T09 | gbtest | `CompteFec` (après IMPFEC-003) | couples (`CompteNum`, `CompAuxNum`, nb car.) : vide, `111`/4, `12345`/4, `AB1`/4 | compte calculé identique à `ctrl`/`trat` actuels | `tests/compte_fec/` | à faire |

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
