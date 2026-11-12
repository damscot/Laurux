# Impcpostaux — Tests

> Source : `.src/Utils/Exports-Imports/Impcpostaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPCPOSTAUX-T01 | replay | Import nominal | `Cpostaux.csv` : 5 lignes dont 1 cp à 4 chiffres et 1 doublon existant | diff `Fiches_Cpostaux` (4 insertions, cp complété) | `tests/import_nominal/` | à faire : fichier d'entrée inaccessible au rejeu (HOME temporaire ; chemin relatif résolu dans l'archive) ; outillage requis |
| IMPCPOSTAUX-T02 | replay | Réimport | même fichier importé deux fois | aucune insertion au second passage | `tests/reimport/` | à faire : idem T01 (fichier d'entrée) |
| IMPCPOSTAUX-T03 | replay | Ligne sans `;` et cp vide | ligne `PARIS` ; ligne `PARIS;` | figer les lignes insérées (anomalies A01, A03) | `tests/ligne_invalide/` | à faire : idem T01 (fichier d'entrée) |
| IMPCPOSTAUX-T04 | replay | Fichier absent | chemin inexistant | avertissement, table inchangée | `tests/fichier_absent/` | implémenté (`assets/impcpostaux_fichier_absent/`) : avertissement, table inchangée |

## Détail des tests

- Capture dans le clone **Laurux non modifié** (menu « Import des codes postaux », chemin saisi dans
  `FilePath`, `Button1`). Comparaison du dump trié de `Fiches_Cpostaux`.
- Fichiers d'entrée générés par `gen_input.py` à partir de `Laurux01.sql`.
- Le `FileChooser` intégré n'est pas piloté (chemin saisi directement).
- **Phase 2** : jeu `.hidden/Tests/Utils/assets/impcpostaux_fichier_absent/impcpostaux.sql` (75001 PARIS 01 existant) ; T04 : `.hidden/Tests/Utils/assets/impcpostaux_fichier_absent/`. Fichiers d'entrée prêts pour T01/T03 : `assets/impcpostaux_import_nominal/Cpostaux.csv`, `assets/impcpostaux_ligne_invalide/Cpostaux.csv` ; il faut que le runner les copie dans le HOME du rejeu (`FilePath` vaut `~/Cpostaux.csv` par défaut).
