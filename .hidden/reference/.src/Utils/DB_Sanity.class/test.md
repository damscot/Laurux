# DB_Sanity — Tests

> Source : `.src/Utils/DB_Sanity.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de fenêtre : les tests actuels sont des `replay` (contrôle, export, correction) avec
comparaison du dump de structure (`SHOW CREATE TABLE` normalisé) et du CSV exporté. Après la
séparation traitement/GUI (DB_SANITY-003/004), les fonctions pures deviennent testables en gb.test
(T07, T08). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DB_SANITY-T01 | replay | Contrôle base conforme | `Laurux01.sql` ; Admin → contrôle ; bouton **Contrôle**, radio **Tous** ; export CSV | `~/tmp/db_control.csv` identique à la référence (après défilement complet, voir A03) | `tests/controle_conforme/` | à faire : sortie non comparée (~/tmp/db_control.csv) ; scénario rejoué (requêtes du contrôle comparées, fumée) |
| DB_SANITY-T02 | replay | Contrôle base dégradée | jeu dérivé : type modifié, défaut modifié, `NULL` modifié, collation, champ en trop, champ et table manquants, index manquant, `AUTO_INCREMENT` absent | CSV exporté (réel et attendu) ; codes couleurs relevés par capture | `tests/controle_ecarts/` | à faire : sortie non comparée (~/tmp/db_control.csv, couleurs) ; scénario rejoué (requêtes du contrôle comparées, fumée) |
| DB_SANITY-T03 | replay | Filtres d'affichage | même jeu que T02 ; radios **Contrôlés**, **Contrôlés en erreur**, **Supplémentaires**, **Manquants** | nombre de lignes et CSV exporté par filtre | `tests/filtres_affichage/` | à faire : nombre de lignes et CSV par filtre non capturés ; scénario rejoué (requêtes comparées, fumée) |
| DB_SANITY-T04 | replay | Correction (`Corriger`) | jeu de T02 ; **Contrôle** puis **Corriger** | dump de structure après correction ; dump des données (`RenumAI`) | `tests/correction/` | à faire : rejeu bloqué, le traitement sous ProgBar ne démarre pas après la confirmation (aucune requête, dump inchangé, ProgBar reste active ; outillage) |
| DB_SANITY-T05 | replay | Correction des clés (`SyncKeys`, `RenumAI`) | table avec clé primaire absente, doublons et 0 dans la colonne `PRI_AI`, index secondaire différent | `SHOW INDEX` et données renumérotées | `tests/correction_cles/` | à faire : rejeu bloqué, le traitement sous ProgBar ne démarre pas après la confirmation (aucune requête, dump inchangé, ProgBar reste active ; outillage) |
| DB_SANITY-T06 | replay | Nettoyage (`Nettoyer`) | jeu avec champ en trop et table entièrement en trop | structure après nettoyage | `tests/nettoyage/` | à faire : rejeu bloqué, le traitement sous ProgBar ne démarre pas après la confirmation (aucune requête, dump inchangé, ProgBar reste active ; outillage) |
| DB_SANITY-T07 | gbtest | `SortKeys`, `AddKeyCol`, `KeyDef`, `KeyCols` (après DB_SANITY-004) | listes `PRI(2),idx_a(1)`, `PRI_AI`, types `text`/`blob` | chaînes de référence | `tests/clefs_pures/` | à faire : après extraction DB_SANITY-004 |
| DB_SANITY-T08 | gbtest | `ComparerLigne` (après DB_SANITY-003) | lignes réelles/attendues avec jokers `?`, `integer` SQLite | tableau de codes de validité | `tests/comparaison/` | à faire : après extraction DB_SANITY-003 |
| DB_SANITY-T09 | replay | Contrôle sous SQLite | `Laurux01.sqlite` ; **Contrôle** ; export | CSV exporté (moteur et collation simulés) | `tests/controle_sqlite/` | à faire : rejeu sur base SQLite non géré par le runner |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker ; le jeu dégradé de T02/T04 est produit par un
  script SQL `degrade.sql` appliqué après import (`ALTER TABLE` ciblés). `db_control.csv` du dépôt est
  copié dans le répertoire de lancement.
- **Comparaison** : `check_output.py` normalise le dump `SHOW CREATE TABLE` (ordre des index,
  `AUTO_INCREMENT=n`) et compare les CSV ligne à ligne.
- **Non testable automatiquement** : les couleurs de la grille (capture d'écran manuelle), les
  boîtes `Message.Warning` de confirmation (le replay rejoue le clic sur le bouton de la boîte, à
  confirmer avec le harnais) ; l'anomalie A01 (`ENGINE` sans espace) n'est atteignable qu'avec un
  moteur différent dans le jeu dégradé (MyISAM), à inclure dans T02.
- **Phase 2** : jeux `.hidden/Tests/Utils/assets/db_sanity_shared/db_sanity_degrade.sql`, `db_sanity_cles.sql`, `db_sanity_nettoyage.sql` ; scénarios `.hidden/Tests/Utils/assets/db_sanity_{controle_conforme,controle_ecarts,filtres_affichage,correction,correction_cles,nettoyage}/`. Le CSV exporté (HOME temporaire) n'est pas comparé par le runner : seuls le SQL et le dump le sont. Confirmation du 2ᵉ bouton de `Message.Warning` : Tab puis Espace sur `FMessage` (à valider au rejeu).
- **Rejeu (phase 2, 2026-11-08)** : `db_control.csv` est bien trouvé au rejeu (chemin relatif Gambas résolu dans
  l'archive du projet, indépendant du répertoire courant). Tab + Espace (ou Tab + Entrée) sur `FMessage` confirme
  bien le 2ᵉ bouton (la ProgBar s'ouvre). En revanche, pour T04 à T06, le traitement ne démarre jamais sous rejeu :
  aucune requête de correction/nettoyage, dump inchangé (même `Docs_Tag`, ligne 14 du CSV, n'est pas recréée),
  la ProgBar reste la fenêtre active (essayé avec 90 s, 240 s, Tab + Entrée, Espace sur la ProgBar). Hypothèse :
  `Wait` de `ProgBar.Avancement` appelé dans le gestionnaire du ReplayTimer après une boîte modale. Les attendus de
  ces trois scénarios ne sont pas produits.
