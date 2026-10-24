# LScript — Tests

> Source : `.src/Utils/LScript.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `gbtest` issus de la conversion de l'`Internal_Test` actuel, complétés par des assertions. Les
commandes lancées écrivent dans un répertoire temporaire du test, dont le contenu est comparé à
`expected/`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LSCRIPT-T01 | gbtest | `Run` mode shell | `LScript("/bin/bash", ["-c", "echo test > f"])` | code 0 ; contenu de `f` | `tests/run_shell/` | à faire |
| LSCRIPT-T02 | gbtest | `Run` mode exec | `LScript("/bin/bash", ["-c", "echo test2 > f"], False)` | code 0 ; contenu de `f` | `tests/run_exec/` | à faire |
| LSCRIPT-T03 | gbtest | Codes de retour | `/bin/faaalse` (exec), `/bin/false` (exec), `/bin/true` (shell), programme vide | 1, 0 (anomalie figée), 0, valeur figée | `tests/codes_retour/` | à faire |
| LSCRIPT-T04 | gbtest | Arguments avec espaces et métacaractères | shell et exec : `["-c", "printf '%s|' \"$@\"", "x", "a b", "c;d"]` | sortie de référence (figer le découpage du mode shell) | `tests/quotage/` | à faire |
| LSCRIPT-T05 | gbtest | `RunA` | liste [ok, échec, ok] ; liste vide | 1 et arrêt après l'échec (3e non lancé) ; 0 | `tests/run_liste/` | à faire |
| LSCRIPT-T06 | gbtest | Mode `debug2` | `LScript("debug2", ["a", "b"])` | 0 ; sortie console capturée | `tests/debug2/` | à faire |
| LSCRIPT-T07 | gbtest | Double `Run` (effet de bord) | même instance lancée deux fois ; tableau d'arguments de l'appelant | figer : programme inséré deux fois, tableau appelant modifié | `tests/double_run/` | à faire |
| LSCRIPT-T08 | gbtest | Journalisation | `Utils.Log` actif (`-d`) | lignes `[LScript]` dans `~/tmp/Debug/LScript.log` | `tests/journalisation/` | à faire |

## Détail des tests

- **Conversion de l'`Internal_Test`** : les 8 appels actuels deviennent T01 à T06 avec assertions ;
  l'appel au script configuré `/Soc<XX>/scanbatch` est retiré (dépend du poste et d'un scanner) et
  documenté comme test manuel de `LGed`.
- **Non testable automatiquement** : le mode `debug` (boîte `Message.Info`).
- `HOME` est redirigé vers le répertoire du test.
