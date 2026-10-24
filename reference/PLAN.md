# PLAN — Rework des sources Laurux

Clone de travail : `Laurux_reworked` (branche de départ `Dockerfile`, commit `6b6b9dfc`, version 3.69.0).
Clone de référence (non modifié) : `Laurux` ; il sert à capturer les logs et à générer les données de référence.

Périmètre : **457 fichiers** (404 `.class` + 53 `.module`, environ 218 000 lignes) sous `.src/`.
Les fichiers `.form` ne sont **jamais** modifiés et le comportement de la GUI reste identique.

Le travail se déroule en 4 phases. Chaque phase se termine par une revue et un commit de l'utilisateur ;
seule la phase 4 autorise des commits par l'agent.

---

## 0. Décisions actées

| Sujet | Décision |
|---|---|
| Périmètre | Les 457 fichiers `.class`/`.module`, avec **le même traitement** pour les classes GUI et les classes de logique pure |
| Exécution | **Par lots, un lot par répertoire `.src/<X>`** (les gros répertoires sont découpés en sous-lots par sous-répertoire), avec des sous-agents en parallèle dans un lot ; validation utilisateur entre les lots |
| Tests | **Mixte** : tests unitaires **gb.test** (modules `.test`, lancés par `gbx3 -T`) pour la logique ; scénarios **log/replay** pilotés par Python pour la GUI |
| Harnais | Les `Internal_Test` existants (`LPrix`, `LScript`, `Start`) sont **convertis en gb.test**. `./Laurux -T <tests\|all>` et `./Laurux -T list` reproduisent le comportement de `gbx3 -T` et remplacent l'actuel `-t` |
| Couverture | **Maximale**, y compris pour les modules complexes. Mesure avec `gbx3 -t` (trace des lignes exécutées) et `gbx3 -p` (profilage, performance) |
| Modules complexes | Facture, Caisse, Moulinage, Clôture, Inventaire… : avant de générer leurs tests, l'agent **présente la liste des cas d'usage et scénarios prévus** et attend la validation ou l'ajustement du périmètre par l'utilisateur |
| BDD de test | **MySQL/MariaDB en Docker**, instance jetable ; import de `Laurux01.sql` ou d'un jeu dérivé pour chaque test |
| API | Une méthode `Public` peut être modifiée **si tous les appelants listés dans `dependencies.md` sont mis à jour dans le même commit**. Handlers d'événements `Objet_Evenement` (nom **et portée `Public`**, car `ReplayObserver` les appelle dynamiquement), noms de contrôles et `.form` : **intouchables** |
| Schéma BDD | **Aucune modification.** Les optimisations qui demanderaient un changement de schéma sont seulement notées dans une section finale « Optimisations possibles (changement de schéma futur) » de `architecture.md` et de `TODO.md`. Elles ne deviennent **jamais** des cases à cocher dans `rework.md` |
| Outillage | `reference/tools/`, versionné : scripts Python, `docker-compose` MariaDB, calcul des KPI et de la couverture |
| Commits phase 4 | Branche dédiée `rework/phase4` ; **1 commit par rework_id** ; message `<src_path>/rework.md <REWORK_ID>`. C'est une exception explicite à la règle « ne commit rien » d'AGENTS.md, **valable uniquement en phase 4** |
| Identifiant | `rework_id` = `<NOMFICHIER_MAJ>-NNN` (ex. `LPRIX-001`), unique dans tout le dépôt puisque les noms de classes Gambas sont uniques. Tests : `<NOMFICHIER_MAJ>-Tnn` |
| Migrations `LauruxMaj` | **Aucune refactorisation** des étapes `MajXXX` ni de leur dispatch (`Verif_Version`). Le rework se limite à la documentation d'en-tête ; le seul test est un replay de mise à jour depuis la base de la version taguée précédente. Les défauts des migrations ne peuvent être corrigés que par une future migration : ils sont notés dans « Optimisations possibles (changement de schéma futur) » |
| Code mort avec `.form` | Supprimer un couple `.class` + `.form` mort se classe en **anomalie** `<ID>-Annn` : documentée, puis exécutée seulement après validation utilisateur, au cas par cas |
| Critère replay | Le **dump normalisé de la base** fait foi. Le diff des lignes `Exec_SQL` est informatif, sauf pour un rework déclaré « sans changement SQL », où il est bloquant |
| Anomalies | Un défaut découvert pendant l'analyse dont la correction **change le comportement** est noté `<NOMFICHIER_MAJ>-Annn`, dans une section séparée de `rework.md`. Les tests de phase 2 figent le comportement actuel (caractérisation). Une anomalie n'est **jamais** exécutée en phase 4 sans validation explicite de l'utilisateur |
| Langue | Documentation en français ; les règles d'AGENTS.md s'appliquent partout |

---

## 1. Arborescence de `reference/`

```
reference/
  PLAN.md                 ← ce plan + tableau de suivi
  TODO.md                 ← phase 3 : ordre global des rework_id
  KPI.md                  ← KPI globaux agrégés et historique
  tools/
    kpi.py                ← lignes hors commentaires, complexité cyclomatique, globales, nombre de Public
    coverage.py           ← agrège gbx3 -t (couverture de lignes) et gbx3 -p (profil) par fichier et par fonction
    deps.py               ← graphe des appels inter-fichiers (alimente dependencies.md)
    db/                   ← docker-compose.yml + scripts d'init MariaDB jetable
    runner.py             ← joue un test sur un clone (Laurux | Laurux_reworked), dump normalisé, diff
    replay/               ← aides de capture et de rejeu de log
  .src/<chemin>/<Fichier.class|.module>/
    summary.md
    architecture.md
    dependencies.md
    test.md
    rework.md
    tests/<nom_du_test>/  ← Laurux.conf, *.sql, data/, *.log, gen_input.py, check_output.py, expected/
```

Exemple : `reference/.src/Utils/LPrix.class/rework.md`.

---

## 2. Gabarit des documents (par fichier source)

### summary.md

Synthèse des quatre autres documents, d'environ **100 lignes maximum** et **sans case à cocher** :
- rôle ;
- points clés ;
- dépendances principales ;
- risques ;
- résumé des KPI ;
- résumé des tests et du rework.

### architecture.md

- Variables : portée, type, usage.
- Fonctions et méthodes : signature, comportement, effets de bord, SQL émis, tables touchées.
- Événements gérés.
- État global utilisé : `Start.*`, `Utils.*`, `Variables.*`.
- Chaque fonction reçoit deux étiquettes :
  - **portée** : `Public` nécessaire (appelée hors du fichier selon `dependencies.md`) ou `Public` réductible en `Private` ;
  - **nature** : *traitement/calcul* (SQL, règles métier, calculs), *GUI* (contrôles, affichage, événements) ou *mixte*.
    Pour une fonction *mixte*, la partie extractible est indiquée.
- Propositions de réécriture, de refactorisation et de commonalisation avec d'autres fichiers (avec liens vers ces fichiers).
- Section finale : **« Optimisations possibles (changement de schéma futur) »**, pour information uniquement.

### dependencies.md

- *Utilisé par* : fichiers et fonctions appelantes, avec références `fichier:ligne`.
- *Utilise* : classes, modules, tables (`Cbase.Table`), état global.
- `.form` associé, le cas échéant.

### test.md

Liste des tests à implémenter. Pour chaque test :
- identifiant ;
- type (`gbtest` | `replay`) ;
- entrées ;
- résultat attendu ;
- répertoire `tests/<nom>/` ;
- statut (à faire, implémenté, vert).

### rework.md

- **En-tête KPI** :
  - lignes de code hors commentaires ;
  - complexité cyclomatique (totale et maximale par fonction) ;
  - nombre de globales (`Public` non-`Const` dans un `.module`, ou `Static Public`) ;
  - nombre de fonctions `Public` ;
  - couverture des tests (`gbx3 -t`) ;
  - durée des tests et profil (`gbx3 -p`).
- **Historique des KPI** : ligne `initial` (commit `6b6b9dfc`, sans les données de couverture),
  ligne `baseline` (commit de fin de phase 2), puis une ligne par rework_id terminé (sha1 et valeurs).
- **Cases à cocher séquentielles** `- [ ] <REWORK_ID> — description`. Catégories :
  - réarchitecture ;
  - commonalisation de fonctions avec d'autres fichiers ;
  - réduction de complexité superflue ;
  - suppression de variables ou fonctions inutiles (code mort) ;
  - amélioration de la documentation en français ;
  - **réduction de portée** : `Public` → `Private` lorsqu'aucun appelant externe n'existe ;
  - **séparation traitement/GUI** : dans le **même fichier**, isoler les calculs et le SQL dans des fonctions
    sans accès aux contrôles, appelées par les handlers GUI. Cela prépare un futur plan qui les déplacera dans
    des classes ou modules distincts ; ce déplacement est hors périmètre de ce plan.

  Chaque case indique les fichiers appelants impactés et les tests à repasser.
- **Section « Anomalies »** : cases `- [ ] <ID>-Annn — [anomalie] …`, soumises à validation utilisateur.
- **Pointeurs vers les sources** : chaque case (rework ou anomalie) se termine par `· sources : …` avec des liens
  Markdown vers les lignes concernées. Deux formes, recalculées par `reference/tools/links.py` (appelé par `gendoc.py`) :
  - `[LPrix.class:_call](…#L76-L83)` : lien de **fonction**, chemin et plage de lignes mis à jour automatiquement ;
  - `[LPrix.class:80](…#L80)` : lien de **ligne**, chemin recalculé et existence de la ligne vérifiée ; le numéro de
    ligne est **mis à jour à la main** à chaque rework qui le décale.
  On privilégie le lien de fonction ; le lien de ligne sert à désigner une instruction précise (anomalie).
- Les blocs `<!-- AUTO:… -->` (KPI, historique, déclarations, fonctions, dépendances) sont générés par
  `reference/tools/gendoc.py` et ne sont jamais édités à la main. Modèle de référence : `reference/.src/Utils/LPrix.class/`.

---

## 3. Phase 1 : base documentaire

1. Créer `reference/tools/` :
   - `kpi.py` : parseur Gambas qui découpe les `Sub`/`Function`/`Procedure`.
     Complexité = 1 + nombre de `If`/`ElseIf`/`Case`/`For`/`While`/`Repeat`/`And`/`Or`/`Catch`/`Try`.
   - `deps.py` : index des symboles `Public`, puis recherche des usages `Classe.Membre`, `New Classe` et de l'héritage.
2. Calculer les KPI initiaux de tous les fichiers (commit `6b6b9dfc`).
3. Traiter les lots dans l'ordre du tableau de suivi (§7). Pour chaque lot :
   - des sous-agents en parallèle produisent les 5 documents de chaque fichier (sources lues avec Bash, voir AGENTS.md) ;
   - le tableau de suivi est mis à jour ;
   - l'utilisateur relit le lot.
4. Fin de phase : produire `KPI.md` global. **L'utilisateur commite la base documentaire.**

---

## 4. Phase 2 : tests de non-régression

1. **Infrastructure** : mettre en place `tools/db/` (MariaDB Docker) et `runner.py`. Le runner :
   - restaure la base ;
   - lance `./Laurux` du clone choisi avec `-c <conf de test>` ;
   - produit un dump normalisé (lignes triées, colonnes volatiles masquées : dates, pid…) ;
   - produit un diff.
2. **Migration du harnais** :
   - convertir les `Internal_Test` de `LPrix`, `LScript` et `Start` en modules gb.test (`.test`), avec ajout du composant `gb.test` dans `.project` ;
   - l'option `./Laurux -T <tests|all>` / `-T list` reproduit le comportement de `gbx3 -T` ;
   - retirer `Start_Test`, devenu inutile ;
   - mettre à jour `TESTING.md` et `README.md`.

   Point à valider en début de phase : peut-on déclencher les modules gb.test depuis l'exécutable `Laurux` ?
   Sinon, un wrapper shell `Laurux -T` → `gbx3 -T` sera utilisé.
3. **Logique** :
   - un module `.test` par fichier source testé, via l'API `Public` (gb.test n'a pas accès au `Private`) ;
   - les valeurs attendues sont stockées dans `tests/<nom>/expected/` ;
   - en phase 2, les seules modifications de source autorisées sont la migration du harnais et l'ajout des `.test`.
4. **GUI** : capturer les scénarios dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`), puis les
   rejouer sur les deux clones. La comparaison porte sur le dump de la base et sur les lignes `Exec_SQL` du log.
5. **Modules complexes** (Facture, Caisse, Moulinage, Clôture, Inventaire…) : présenter à l'utilisateur la liste
   des scénarios proposés pour chacun, attendre sa validation, puis générer les tests en visant une couverture maximale.
6. **Couverture et performance de base** : lancer `gbx3 -t` et `gbx3 -p` sur toute la suite.
   `coverage.py` reporte les résultats dans chaque `rework.md` (ligne `baseline`) et dans `KPI.md`.
7. **Critère de sortie** :
   - `gbc3 -agt` passe sans erreur ;
   - `./Laurux -T all` renvoie 0 ;
   - tous les replays donnent un diff vide entre les deux clones ;
   - les `test.md` sont à jour.

   **L'utilisateur commite.**

---

## 5. Phase 3 : ordonnancement

1. Construire le graphe de dépendances avec `deps.py` et l'ordonner topologiquement :
   - les feuilles d'abord (`L*`, `Utils`) ;
   - les commonalisations transverses avant les fichiers qui les consomment.
2. Produire `reference/TODO.md` :
   - liste ordonnée de liens `<src_path>/rework.md#<REWORK_ID>` ;
   - prérequis et risques pour chaque rework_id. Les gros fichiers legacy (`Facture.class`, `Caisse.class`) ne reçoivent que des changements minimaux et ciblés ;
   - section finale reprenant les « optimisations avec changement de schéma », pour information uniquement.
3. **Revue et commit par l'utilisateur.**

---

## 6. Phase 4 : exécution autonome

Boucle sur `TODO.md`, dans l'ordre, sur la branche `rework/phase4`. Pour chaque rework_id :

1. Implémenter le rework_id. Si une API `Public` change, mettre à jour les appelants. Aucun `.form` ni schéma n'est modifié.
2. Valider : `gbc3 -agt`, puis `./Laurux -T all`, puis les replays concernés (selon `dependencies.md`). Le diff entre les deux clones doit être vide.
3. Mettre à jour les KPI dans `rework.md` et `KPI.md`, puis cocher la case. Mettre à jour les liens de ligne
   décalés par le rework dans les documents du fichier **et** de ses appelants, puis lancer `gendoc.py` et
   `links.py --check` (aucun problème toléré).
4. `git commit` avec le message `<src_path>/rework.md <REWORK_ID>`. Le code, les docs et les KPI sont dans le même commit.
5. En cas d'échec non résolu :
   - `git restore` des changements du rework_id ;
   - mention `BLOQUÉ` dans `TODO.md` ;
   - passage au rework_id suivant et signalement à l'utilisateur.

**Règle de portée** : une réduction `Public` → `Private` n'est permise que si le comportement reste couvert,
soit par une autre fonction `Public` testée, soit par un replay. En effet, gb.test ne voit que l'API `Public`.

---

## 7. Suivi

| Phase | Lot | Fichiers | État | Date | Commit utilisateur |
|---|---|---|---|---|---|
| 0 | PLAN.md | – | fait | 2026-10-24 | `92b99f46` |
| 1 | `tools/` (kpi, deps, gendoc, links, diffdeps) + KPI initiaux + modèle LPrix | – | fait | 2026-10-24 | `6704e828`, `fb4ecebc` |
| 1 | `.src/Utils` (412 reworks, 239 anomalies, 503 tests) | 92 | fait | 2026-10-24 | `e066f50c` |
| 1 | `.src/Communs` (134 reworks, 110 anomalies, 164 tests) | 22 | fait | 2026-10-24 | `b94efc2e` |
| 1 | `.src/Start.module`, `.src/Serveur.module` + `.src/Compta` (561 reworks, 381 anomalies, 635 tests) | 85 | fait | 2026-10-24 | `70fd50e4` |
| 1 | `.src/Gestion` — sous-lot 1 : Facturation, Tables, Reglements, Entrées, Depots, fichiers racine (393 reworks, 290 anomalies, 413 tests) + passe d'outillage (deps.py, gambas_parse, gendoc, diffdeps) | 54 | en revue | 2026-10-25 | |
| 1 | `.src/Gestion` — sous-lot 2 : Stock, option, Impressions, Etiquettes, Lcr, Mails, SMS | 108 | à faire | | |
| 1 | `.src/Caisse` | 28 | à faire | | |
| 1 | `.src/Statistiques` | 19 | à faire | | |
| 1 | `.src/Affichages` | 16 | à faire | | |
| 1 | `.src/Archivages` | 8 | à faire | | |
| 1 | `.src/Reports` | 24 | à faire | | |
| 1 | `.src/Tests` | 1 | à faire | | |
| 1 | `KPI.md` global | 457 | à faire | | |
| 2 | Infra Docker + runner + migration gb.test | – | à faire | | |
| 2 | Tests par lot (même ordre que la phase 1) | 457 | à faire | | |
| 2 | Couverture et performance de base | – | à faire | | |
| 3 | Graphe + `TODO.md` | – | à faire | | |
| 4 | Exécution `TODO.md` (branche `rework/phase4`) | – | à faire | | |
