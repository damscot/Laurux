# Cbordereaux — Tests

> Source : `.src/Reports/Cbordereaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CBORDEREAUX-T01 | gbtest | Bordereau de caisse | `Entete`, `Logo` (PNG versionné), 5 × `Entete2`, `Ligne`, `TitreB`, 10 × `Level5` | texte `pdftotext` de référence ; rendu raster (logo) | `tests/bordereau_caisse/` | implémenté |
| CBORDEREAUX-T02 | gbtest | Bordereau de chèques | `Entete`, `TitreB`, `Level6`, 30 × `Level7`, `Level8` | texte de référence | `tests/bordereau_cheques/` | implémenté |
| CBORDEREAUX-T03 | gbtest | Paiements multi-pages | `AliasNbPages`, 2 × (`EnteteP`, `Level1`, 40 × `Level2`, `Footer`), `Level3` | `Page 1/2`, `Page 2/2` | `tests/paiements/` | implémenté |
| CBORDEREAUX-T04 | gbtest | Logo invalide | `Logo` avec un chemin absent, puis un `.gif` | erreur capturée (`Try`) de référence (A01 figée) | `tests/logo_invalide/` | implémenté |
| CBORDEREAUX-T05 | replay | Bordereau de remise de chèques (`BordereauxC`) | jeu dérivé avec règlements par chèque | `pdftotext` identique entre clones ; dump BDD identique | `tests/replay_bordereauxC/` | à faire : test propre à la classe à écrire ; aujourd'hui couvert seulement par des tests d'autres classes (couvert par les scénarios existants Compta/bordereauxc_* (texte pdftotext comparé) — règle du 2026-11-14 : les tests d'une classe sont portés par la classe |
| CBORDEREAUX-T06 | replay | Liste des paiements (`Edpaiement`) | `Laurux01.sql` + règlements clients | `pdftotext` identique entre clones | `tests/replay_edpaiement/` | à faire : test propre à la classe à écrire ; aujourd'hui couvert seulement par des tests d'autres classes (couvert par les scénarios existants Gestion/edpaiement_* (texte pdftotext comparé) — règle du 2026-11-14 : les tests d'une classe sont portés par la classe |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (même module, mêmes
  scénarios) ; normalisation de la date et de l'utilisateur par le script commun `check_output.py`
  (voir [PdfWriter/test.md](../PdfWriter.class/test.md)).
- **Caisse** : le bordereau de caisse (`Caisse/Bordereaux`) est couvert par les replays de caisse
  (lancement `./Laurux -p`) ; scénario décrit dans [Bordereaux/test.md](../../Caisse/Bordereaux.class/test.md).
- **Couverture visée** : 100 %.
- **Module gb.test** : `.src/Tests/Reports/CbordereauxTest.test`, valeurs attendues dans `.hidden/Tests/Reports/assets/CbordereauxTest/expected.txt`. Chaque test vérifie le texte `pdftotext -layout` (une clé par ligne), `pdfinfo` (nombre et taille des pages) et l'empreinte md5 du PDF non compressé (date, `User.Name` et `/CreationDate` masqués). Les erreurs levées par une méthode sont figées par `Try` (chemin de l'application remplacé par `<app>`). Image PNG sans canal alpha : `.src/Images/monnaie/b100.png`.
