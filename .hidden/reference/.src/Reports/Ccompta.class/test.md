# Ccompta — Tests

> Source : `.src/Reports/Ccompta.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit PDF sans accès à la base : la classe se teste directement en gb.test (instanciation,
appel des niveaux avec des valeurs fixes, `Output` dans un fichier), puis comparaison du **texte**
extrait par `pdftotext -layout` et, pour les reworks de mise en page, d'un rendu raster
(`pdftoppm -r 72` + comparaison pixel). Deux replays vérifient le rendu de bout en bout depuis les
éditions comptables, sur le jeu comptable dérivé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CCOMPTA-T01 | gbtest | Famille grand livre / extraits | `Entete`, `Level0C`, `Level1C`, `Level1CA`, `Level3C`, `Level2C`, `Level2CA`, `Level2s` (`"0"`, `""`, `"12.5"`), `Level4C`, `Level4T`, `Level5C`, `BasPage` | texte `pdftotext` de référence | `tests/grand_livre/` | à faire |
| CCOMPTA-T02 | gbtest | Famille extraits / impayés / échéancier | `Level0`, `Level1`, `level2`, `Level3`, `Level4`, `Level5`, `Level6`, `Level1E`, `level2E`, `Level4E`, `Level5E` | texte de référence | `tests/extraits_echeancier/` | à faire |
| CCOMPTA-T03 | gbtest | Famille journaux et écritures modifiées | `Level0J`, `Level1J`, `level2J` (solde `-0.001`, `0`, `-12.5`), `Level1JT`, `level2JT`, `Level5J`, `level6J`, `level7J` (débit Float non formaté), `Level1M`, `level2M`, `BasPage2("3")` | texte de référence ; `-0,00` affiché `0,00` ; débit de centralisation brut (A02 figée) | `tests/journaux/` | à faire |
| CCOMPTA-T04 | gbtest | Plan comptable, anomalies, analytique | `Level0P`, `Level1P`, `level2P` (intitulé > 24 car.), `Level1A2`, `level2A2`, `Level0A`, `Level1A`, `Level2A` | texte de référence (troncatures) | `tests/plan_anomalies_analytique/` | à faire |
| CCOMPTA-T05 | gbtest | Rapprochement et traites | `Level0R`, `Level1R`, `Level2R`, `Level3R`, `Level1T`, `Level2T` (adresse complète, `PosY` de l'appelant inchangé) | texte de référence | `tests/rapprochement_traites/` | à faire |
| CCOMPTA-T06 | gbtest | Multi-pages | `AliasNbPages`, 3 × (`Entete` + 50 `level2` + `BasPage`) ; puis une cellule à `PosY = 292` | `Page 1/3` … `Page 3/3` ; saut de page automatique de `PdfWriter` sans en-tête (nombre de pages = 4) | `tests/multipages/` | à faire |
| CCOMPTA-T07 | gbtest | Couleur de remplissage héritée | `Level4C` après `Level1C`, après `Level2s`, après `Level4T`, après `Level5C` | rendu raster de référence (A01 figée : fond blanc après `Level2s`) | `tests/couleur_heritee/` | à faire |
| CCOMPTA-T08 | gbtest | Conversion des montants `String` par `Format$` | `level2`/`Level4` avec `"1234.5"`, `"1234,5"`, `""`, `"abc"` (locale `fr_FR.UTF-8`) | texte ou erreur capturée (`Try`) de référence | `tests/format_montants/` | à faire |
| CCOMPTA-T09 | replay | Extrait de compte (`Editcompte` → `EditcompteM`) | jeu comptable dérivé, compte de > 60 écritures et sous-comptes, impression PDF | `pdftotext` de `~/tmp/*.pdf` identique entre clones (date et utilisateur normalisés) ; dump BDD inchangé | `tests/replay_extrait_compte/` | à faire |
| CCOMPTA-T10 | replay | Journaux et centralisation (`Journaux` → `JournauxM`, `Jourcent`) | jeu dérivé, un journal sur 2 pages | `pdftotext` identique entre clones | `tests/replay_journaux/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées en exécutant le même module gb.test dans le clone **Laurux non
  modifié** (PDF produits puis `pdftotext -layout`, et `pdftoppm` pour T07), stockées dans
  `tests/<nom>/expected/`. Anomalies comprises (tests de caractérisation).
- **Normalisation** : le pied de page contient la date du jour et `User.Name` ; `check_output.py`
  remplace `\d\d/\d\d/\d\d\d\d` et le nom d'utilisateur par des jetons, ou le test fixe l'horloge
  (`faketime`) et l'utilisateur. Les métadonnées du PDF (date de création) ne sont pas comparées.
- **Couleurs** : `_new` lit `Start.R/G/B` ; le test fixe `/Coul/...` dans le `Laurux.conf` de test
  pour que le rendu raster soit stable.
- **Données des replays** : `Laurux01.sql` n'a aucune écriture ; T09/T10 utilisent le jeu comptable
  dérivé décrit dans [Balance/test.md](../../Compta/Impressions/Balance.class/test.md) (dont un
  compte de plus de 60 écritures pour le saut de page). `Visualiseur.Prog` est neutralisé par la
  configuration (script de capture du PDF).
- **Cas non testables tels quels** : les appels à arité fausse des appelants (EDITCOMPTEA-A01,
  JOURNAUXA-A01) font échouer les éditions `EditcompteA` et `JournauxA` ; ils sont couverts par les
  tests de ces écrans, pas ici.
- **Couverture visée** : 100 % des lignes hors `Level2sbis`, `Level3T` et `_free` (suppression
  prévue, CCOMPTA-002).
