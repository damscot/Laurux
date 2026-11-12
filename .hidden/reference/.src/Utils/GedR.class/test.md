# GedR — Tests

> Source : `.src/Utils/GedR.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : scénarios `replay` sur le jeu GED commun (`Laurux01.sql` + `ged.sql`, voir
[`LGed`](../LGed.class/test.md)). Comparaison du dump de `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` et
des lignes `Exec_SQL` du log.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GEDR-T01 | replay | Filtres | ouverture ; type Clients ; tags `fac, 2024` ; colonne « url » | requêtes `Exec_SQL` identiques | `tests/replay_filtres/` | implémenté |
| GEDR-T02 | replay | Sélection multiple | clic sur 2 lignes, tout sélectionner filtré, tout désélectionner | compteur et requêtes identiques | `tests/replay_selection/` | implémenté (compteur Selcnt non capturé ; requêtes comparées) |
| GEDR-T03 | replay | Suppression | 2 documents sélectionnés → Supprimer | lignes supprimées + épuration globale | `tests/replay_suppression/` | implémenté |
| GEDR-T04 | replay | Changement d'URL | voir LBOX-T01 (partagé) ; une URL contenant deux fois la base | `url` modifiées (remplacement multiple figé, A03) | `tests/replay_changer_url/` | à faire : dialogue LBox partagé avec LBOX-T01 (scénario à construire avec le lot de LBox) |
| GEDR-T05 | replay | Suppression de tags | voir LBOX-T03 (partagé) | `Docs_Tag`, `Fiches_Tag` | `tests/replay_supprimer_tags/` | à faire : dialogue LBox partagé avec LBOX-T03 |
| GEDR-T06 | replay | Ajout de tags | voir LBOX-T04 (partagé) ; un des tags déjà porté par un document | lignes ajoutées ; erreur éventuelle figée (LGED-A02) | `tests/replay_ajout_tags/` | à faire : dialogue LBox partagé avec LBOX-T04 |
| GEDR-T07 | replay | Édition | 1 document → Éditer → modifier le code → Enregistrer | `Docs_Ged.code` modifié, liste rafraîchie | `tests/replay_edition/` | à faire : sélection d'une ligne de la grille TriGen non rejouable (grille créée après Utils.ReplayObservers) ; enregistrement LGed soumis aux contrôles de fichier (Message.*) |
| GEDR-T08 | replay | Filtre avec guillemet (anomalie A02) | tag saisi `a"b` | erreur SQL figée (message) | `tests/replay_filtre_guillemet/` | xfail : erreur SQL non interceptée (A02), Laurux arrêté par le runner en code 125 (`code_sortie` 125), pas de message Laurux |

## Détail des tests

- **Valeurs attendues** : capture dans le clone non modifié puis rejeu sur les deux clones ;
  `lind` masqués dans les dumps.
- **Non testable automatiquement** : ouverture des documents (`Visualiseur`), aide HTML.
- **SQLite** : l'écran ne fonctionne pas (A01) ; pas de replay SQLite tant que l'anomalie n'est pas
  traitée.
- **Scénarios (phase 2)** : jeu `.hidden/Tests/Utils/assets/gedr_shared/ged.sql` (repris de LGed) ; `.hidden/Tests/Utils/assets/gedr_replay_filtres/` (T01),
  `.hidden/Tests/Utils/assets/gedr_replay_selection/` (T02 : Sel. Tous / Désel. Tous, la sélection ligne à ligne de la grille
  TriGen n'est pas rejouable), `.hidden/Tests/Utils/assets/gedr_replay_suppression/` (T03 : tag « urgent », docs 1 et 2),
  `.hidden/Tests/Utils/assets/gedr_replay_filtre_guillemet/` (T08 : si le rejeu sort en erreur, prévoir xfail ou outillage).
- **Rejeu (2026-11-08)** : T08 en xfail dans `meta.json` (`timeout` 60) : la requête invalide lève une erreur non
  interceptée (`Error.Propagate` de `DB_Connection.Exec`, backtrace désactivée donc pas de `Message.Error`) jusqu'à
  `TextBox1_Change` ; la boîte d'erreur native de Gambas bloque le rejeu (code 124). T03 : l'épuration supprime aussi
  le tag « compta » encore porté par le document 3, à cause de la ligne `Docs_Tag` pendante (99, 4) (LGED-A03).
- **Rejeu (2026-11-09)** : le runner détecte désormais l'erreur fatale et arrête Laurux (code 125) ; `code_sortie` 125 ajouté à `meta.json`, xfail conservé (le test.md attend un message Laurux et un code 0).
