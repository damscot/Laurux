# modfichier — Tests

> Source : `.src/Gestion/option/modfichier.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le module affiche une fenêtre et pose une question : tests `replay` depuis les préférences
(`Prefs`, voir PREFS-T14). La comparaison porte sur le **dump de structure**
(`SHOW CREATE TABLE` normalisé) et le dump des données touchées.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MODFICHIER-T01 | replay | `fichierboisson` (MySQL) | `Laurux01.sql` ; cocher « bois », répondre NON | structure : 4 tables créées, colonnes ajoutées | `tests/boisson_mysql/` | à faire |
| MODFICHIER-T02 | replay | `fichiercarbu` (MySQL) | `Laurux01.sql` ; cocher « pp » | structure : tables, colonnes, types `MODIFY`, présence ou non de `numadr_*` (A04) | `tests/carbu_mysql/` | à faire |
| MODFICHIER-T03 | replay | `modiffrais` (A03) | base avec articles `art_frais <> 0` ; première activation, réponse OUI ; puis base sans article concerné | erreur figée ; état de `Fiches_Art` et de la transaction | `tests/copie_frais/` | à faire |
| MODFICHIER-T04 | replay | Idempotence | cocher deux fois chaque option | structure identique après la 2e exécution | `tests/idempotence/` | à faire |
| MODFICHIER-T05 | replay | SQLite (A02) | `Laurux01.sqlite` ; cocher « bois » puis « pp » | liste des colonnes réellement créées (figée) | `tests/sqlite/` | à faire |

## Détail des tests

- **Valeurs attendues** : structures produites dans le clone Laurux non modifié, sur MariaDB
  Docker de la version de référence (le comportement de `COLLATE` sur un entier dépend du
  serveur : noter la version).
- **Données** : `qte_ligbl` de plus de 8 caractères dans `Fiches_Ligbl` pour caractériser la
  réduction de type (A01).
- Ces scénarios produisent aussi la base du jeu `facturation_boisson` des autres fichiers de
  l'option.
