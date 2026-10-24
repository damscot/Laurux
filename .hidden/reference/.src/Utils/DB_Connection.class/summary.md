# DB_Connection — Synthèse

> Source : `.src/Utils/DB_Connection.class` · Synthèse des autres documents.

## Rôle

Connexion à la base (hérite de `Connection`, gb.db), instanciée une seule fois : le singleton
`Utils.db`, utilisé par environ 340 fichiers. Elle ajoute à `Connection` la substitution des
paramètres `&N`, la journalisation des requêtes et des événements GUI (socle du log/replay), la
réécriture à la volée du SQL MySQL en SQLite et quelques fonctions métier (stock, compteurs,
recherche d'article).

## Points clés

- `Exec` (CC 42) : substitution (`Connection.Subst` natif via `Object.Call`), log `Exec_SQL`,
  réécriture SQLite par 14 règles regex appliquées **sur toute la chaîne, littéraux compris**,
  exécution avec curseur d'attente, `Error.Propagate` en cas d'erreur.
- Le SQL journalisé est le SQL substitué **avant** réécriture SQLite ; en replay (`-r`) le log est
  écrit dans `<logfile>.out`.
- Format de ligne : `<date>;<niveau>;<type>;<user>;<host>;<machine>;<pid>;<backtrace>;<message>`, types
  `Exec_SQL`, `GUI`, `Log`. Aucune protection des `;` dans le message.
- Filtres de log `Clé:regex` stockés dans le répertoire temporaire du processus (perdus à la sortie).
- Métier égaré : `Lockstock` (stock + PMP), `LockIncrement` (compteur verrouillé), `RecArt`.

## Dépendances principales

- Utilise : `Start` (arguments `-l`, `-r`, `--logfile`, niveaux), `Utils` (singleton, curseur,
  `Find_cbarre`, `Option`), `NetHandler` (log distant), commandes `cat`/`hostname`/`hostid`.
- Utilisé par : tout le projet via `Utils.db` ; `DB_Log` (pilotage du log), `DB_Sanity`,
  `ReplayObserver` (`GUI_Event`), `LLog` (`Log_Event`).

## Risques

- **Anomalies SQLite graves** : `COLLATE NOCASE` inséré dans `Fiches_Bordereaux` ou dans un
  littéral contenant `ORDER` (A01, corruption silencieuse possible) ; `LEFT` renvoie n-1 caractères
  (A02) ; `abs()` réécrit en SQL invalide (A03) ; `CopieTable` ne copie rien (A04, clôture
  annuelle) ; `Execute` inutilisable (A05).
- Log distant tenté au démarrage dès que `ServerLogIP` est renseigné (A06).
- Filtrage par regex probablement inopérant (A07, à confirmer).
- Fichier central : toute régression touche l'ensemble de l'application ; rework possible seulement
  derrière des tests de caractérisation complets.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 561 |
| Lignes de commentaire | 42 |
| Fonctions | 34 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 162 |
| Complexité max (fonction) | 42 (`Exec`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

16 tests prévus (DB_CONNECTION-T01 à T16), dont 15 `gbtest` sur base MariaDB Docker et SQLite :
substitution, format du log, corpus de réécriture SQLite (texte et résultats), filtres, dialecte,
erreurs, fonctions métier, requêtes préparées, `CopieTable`, performance ; et 1 `replay` qui valide
le cycle complet log → replay → `.out`.

## Rework

13 étapes sans changement de comportement (DB_CONNECTION-001 à 013) : documentation, code mort,
extraction d'une fonction pure `SqliteRewrite` (CC 42 → ≤ 10), helpers `SubstParam` et `LogLine`,
réduction de portée, renommage de la méthode `Start`, `Cbase.Table` dans le métier, enum partagée du
format de log. 11 anomalies (DB_CONNECTION-A01 à A11) soumises à validation utilisateur.
