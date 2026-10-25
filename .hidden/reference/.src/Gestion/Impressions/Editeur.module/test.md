# Editeur — Tests

> Source : `.src/Gestion/Impressions/Editeur.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans base de données : tests `gbtest` qui interceptent le programme lancé. Les valeurs
attendues sont produites dans le clone **Laurux non modifié** (anomalie A01 figée).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDITEUR-T01 | gbtest | `Prog_Editeur` avec `/CmdEditor0` | clé = script de capture qui écrit ses arguments ; fichier `~/tmp/a.txt` | arguments reçus par le script (`~/tmp/a.txt`) | `tests/cmd_editor/` | à faire |
| EDITEUR-T02 | gbtest | Chemin avec espace | `/CmdEditor0` = script de capture ; fichier `~/tmp/a b.txt` | arguments découpés (`…/a`, `b.txt`) : A01 figée | `tests/chemin_espace/` | à faire |
| EDITEUR-T03 | gbtest | Repli `Desktop.Open` | clé absente ; `xdg-open` remplacé par un script de capture dans le `PATH` | `xdg-open` appelé avec le chemin | `tests/desktop_open/` | à faire |
| EDITEUR-T04 | gbtest | Type explicite | `Prog_Editeur(f, FILE_TYPE_PDF)` avec `/CmdEditor1` seule renseignée | commande `/CmdEditor1` lancée | `tests/type_pdf/` | à faire |

## Détail des tests

- `Shell` est lancé sans `Wait` : le test attend l'apparition du fichier de capture (délai borné).
- `Prog_Email` n'est pas testé (code mort, supprimé par EDITEUR-002) ; s'il était conservé, il
  faudrait seulement vérifier qu'il renvoie `""` sans effet de bord autre que les appels `which`.
- Les replays des écrans appelants (exports, inventaires…) neutralisent l'ouverture du fichier en
  positionnant `/CmdEditor0` sur un script de capture : ce module en est le point d'interception.
