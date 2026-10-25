# Cbordereaux — Tests

> Source : `.src/Reports/Cbordereaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CBORDEREAUX-T01 | gbtest | Bordereau de caisse | `Entete`, `Logo` (PNG versionné), 5 × `Entete2`, `Ligne`, `TitreB`, 10 × `Level5` | texte `pdftotext` de référence ; rendu raster (logo) | `tests/bordereau_caisse/` | à faire |
| CBORDEREAUX-T02 | gbtest | Bordereau de chèques | `Entete`, `TitreB`, `Level6`, 30 × `Level7`, `Level8` | texte de référence | `tests/bordereau_cheques/` | à faire |
| CBORDEREAUX-T03 | gbtest | Paiements multi-pages | `AliasNbPages`, 2 × (`EnteteP`, `Level1`, 40 × `Level2`, `Footer`), `Level3` | `Page 1/2`, `Page 2/2` | `tests/paiements/` | à faire |
| CBORDEREAUX-T04 | gbtest | Logo invalide | `Logo` avec un chemin absent, puis un `.gif` | erreur capturée (`Try`) de référence (A01 figée) | `tests/logo_invalide/` | à faire |
| CBORDEREAUX-T05 | replay | Bordereau de remise de chèques (`BordereauxC`) | jeu dérivé avec règlements par chèque | `pdftotext` identique entre clones ; dump BDD identique | `tests/replay_bordereauxC/` | à faire |
| CBORDEREAUX-T06 | replay | Liste des paiements (`Edpaiement`) | `Laurux01.sql` + règlements clients | `pdftotext` identique entre clones | `tests/replay_edpaiement/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (même module, mêmes
  scénarios) ; normalisation de la date et de l'utilisateur par le script commun `check_output.py`
  (voir [PdfWriter/test.md](../PdfWriter.class/test.md)).
- **Caisse** : le bordereau de caisse (`Caisse/Bordereaux`) est couvert par les replays de caisse
  (lancement `./Laurux -p`) ; scénario décrit dans [Bordereaux/test.md](../../Caisse/Bordereaux.class/test.md).
- **Couverture visée** : 100 %.
