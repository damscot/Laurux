# LLog — Tests

> Source : `.src/Utils/LLog.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Logger sans accès SQL direct : tests `gbtest`. Le contenu des fichiers `~/tmp/Debug/<Module>.log` et
les lignes `Log` du journal de `DB_Connection` sont comparés après normalisation de la date et de la
backtrace. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LLOG-T01 | gbtest | Construction | `New LLog("TestMod", True)` avec un `TestMod.log` existant | fichier recréé vide ; niveaux des handlers = `Start.*LogLevel` | `tests/construction/` | à faire |
| LLOG-T02 | gbtest | Écriture et format | messages aux niveaux 0 à 6, niveaux console/fichier 3 | lignes du fichier (format `[date] [niveau-n] [TestMod] [bt] message`) | `tests/format_niveaux/` | à faire |
| LLOG-T03 | gbtest | Logger inactif | `Enabled = False` puis `Log` | aucun fichier écrit, aucune ligne `Log` dans le journal | `tests/inactif/` | à faire |
| LLOG-T04 | gbtest | Relais vers `DB_Connection` | journal applicatif actif sans filtre | ligne `Log;…;[TestMod]message` | `tests/relais_dbconnection/` | à faire |
| LLOG-T05 | gbtest | `Level_Id`, `Level_Name` | libellés valides, inconnu ; niveaux -1, 0, 8, 12 | indices et libellés (-1, bornage) | `tests/libelles_niveaux/` | à faire |
| LLOG-T06 | gbtest | Rotation | 70 Ko de messages | présence du fichier tourné | `tests/rotation/` | à faire |
| LLOG-T07 | gbtest | Via `Utils.Log` | `Utils.Log("TestMod", …)` deux fois, avec et sans `-d` | une seule instance dans `Start.LLogColl` ; activation par défaut | `tests/fabrique_utils/` | à faire |

## Détail des tests

- `HOME` est redirigé vers un répertoire temporaire du test pour isoler `~/tmp/Debug`.
- **Non testable en gb.test** : le niveau `MessageBox` (boîte modale) ; à couvrir après la séparation
  LLOG-003 par le test de `DoitAfficher`, ou manuellement.
- Les piles courtes (`bt.Length < 6`) sont testées en appelant `Log` directement depuis la méthode de
  test (pile minimale), pour figer le comportement actuel.
