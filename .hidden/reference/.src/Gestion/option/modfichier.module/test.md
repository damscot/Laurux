# modfichier — Tests

> Source : `.src/Gestion/option/modfichier.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le module affiche une fenêtre et pose une question : tests `replay` depuis les préférences
(`Prefs`, voir PREFS-T14). La comparaison porte sur le **dump de structure**
(`SHOW CREATE TABLE` normalisé) et le dump des données touchées.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MODFICHIER-T01 | replay | `fichierboisson` (MySQL) | `Laurux01.sql` ; cocher « bois », répondre NON | structure : 4 tables créées, colonnes ajoutées | `tests/boisson_mysql/` | implémenté |
| MODFICHIER-T02 | replay | `fichiercarbu` (MySQL) | `Laurux01.sql` ; cocher « pp » | structure : tables, colonnes, types `MODIFY`, présence ou non de `numadr_*` (A04) | `tests/carbu_mysql/` | implémenté |
| MODFICHIER-T03 | replay | `modiffrais` (A03) | base avec articles `art_frais <> 0` ; première activation, réponse OUI ; puis base sans article concerné | erreur figée ; état de `Fiches_Art` et de la transaction | `tests/copie_frais/` | implémenté partiellement (`Gestion/modfichier_copie_frais`, jeu `frais.sql` : réponse OUI avec articles à frais → erreur fatale « Unknown field: art_trspr », A03 figée, code 125) ; à faire : réponse OUI sur une base sans article concerné (Begin sans Commit) |
| MODFICHIER-T04 | replay | Idempotence | cocher deux fois chaque option | structure identique après la 2e exécution | `tests/idempotence/` | implémenté (`Gestion/modfichier_idempotence` : bois coché, décoché, recoché puis pp de même ; 2e exécution sans question modiffrais, art_trsp déjà présent) |
| MODFICHIER-T05 | replay | SQLite (A02) | `Laurux01.sqlite` ; cocher « bois » puis « pp » | liste des colonnes réellement créées (figée) | `tests/sqlite/` | à faire : base SQLite non utilisée par le framework de rejeu |

## Détail des tests

- **Implémentation (phase 2)** : scénarios `Gestion/assets/modfichier_boisson_mysql` (case bois, réponse NON) et `modfichier_carbu_mysql` (case pp, réponse NON), `modfichier_idempotence` (T04, vague 7), sur le modèle de PREFS-T14 ; le dump compare la structure.

- **Valeurs attendues** : structures produites dans le clone Laurux non modifié, sur MariaDB
  Docker de la version de référence (le comportement de `COLLATE` sur un entier dépend du
  serveur : noter la version).
- **Données** : `qte_ligbl` de plus de 8 caractères dans `Fiches_Ligbl` pour caractériser la
  réduction de type (A01).
- Ces scénarios produisent aussi la base du jeu `facturation_boisson` des autres fichiers de
  l'option.
