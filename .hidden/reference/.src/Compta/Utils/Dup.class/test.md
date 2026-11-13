# Dup — Tests

> Source : `.src/Compta/Utils/Dup.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'administration à effet massif sur une **autre base** : tests `replay` sur MariaDB Docker,
base source `Laurux01` importée de `Laurux01.sql`, `HOME` isolé (fichier `~/bases.txt`). Le résultat
comparé est le **dump normalisé de la base cible** (données **et** structure : `SHOW CREATE TABLE`)
et la liste de `Nbase`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DUP-T01 | replay | Liste des bases | serveur avec `Laurux01`, `Laurux02`, `Laurux`, `autre` | items de `Nbase` (`Laurux01`, `Laurux02`) ; `~/bases.txt` | `tests/dup_liste_bases/` | à faire : bases Laurux02/Laurux/autre non créables par un jeu (serveur de test réduit à Laurux01) ; ~/bases.txt comparé par T05 |
| DUP-T02 | replay | Duplication vers une base inexistante | `Laurux01` → `Laurux03`, aucune option | dump et structure de `Laurux03` (clés perdues, A01 figée) | `tests/dup_nouvelle_base/` | à faire : erreur fatale dans ref ([gb.logging].FileHandler.Write « Uninitialized or already closed handler », utils.Fill_DataBase.1536 ← LauruxConf.Createbase.398 ← Dup.Button1_Click.89) sous journalisation du rejeu, à analyser |
| DUP-T03 | replay | Duplication vers une base existante | `Laurux01` → `Laurux02` existante, toutes options | dump de `Laurux02` ; confirmations « Oui » | `tests/dup_toutes_options/` | à faire : base cible existante non créable par un jeu |
| DUP-T04 | replay | Comptes 411/401 | options Clients seule, Fournisseurs seule, aucune | `Fiches_Comptes` cible ; `dnc`/`dnf` dans `Fiches_Parametres` | `tests/dup_comptes_tiers/` | à faire : passe par la duplication (voir T02) |
| DUP-T05 | replay | Refus et abandon | même base source/cible ; « Non » à la question ; « Non » à l'écrasement | message d'erreur ; base cible inchangée | `tests/dup_refus/` | implémenté (sans la variante « Non » à l'écrasement : base existante non créable) |
| DUP-T06 | replay | `sql_mode` de session | après duplication, insertion d'une écriture dans la base courante | valeur de `@@session.sql_mode` figée (A03) | `tests/dup_sql_mode/` | à faire : passe par la duplication (voir T02) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; dumps normalisés
  (`mysqldump --skip-dump-date`, tri des lignes) de la base cible, structure comprise, pour que
  la correction d'A01 soit détectée.
- **Après DUP-002 (helper)** : le diff des lignes `Exec_SQL` doit être vide (rework déclaré sans
  changement SQL).
- **Non testable automatiquement** : SQLite (écran MySQL uniquement, A04 figée par un simple
  constat manuel), aide `Doc.Open`.
- **Implémentation (phase 2, vague 4)** : scénario `.hidden/Tests/Compta/assets/dup_refus/` (T05) depuis
  `Fmenu#Menu67#Menu75#Menu150#` (Admin non activé) : cible Laurux01 → erreur « sur elle-même » ; cible saisie
  Laurux03 → « Non » à la question ; `~/bases.txt` comparé, sql.log comparé (ordered). La duplication (« Oui »)
  enchaîne la question de `LauruxConf.Createbase` (2e boîte) puis plante dans ref (voir T02) ; scénario d'essai
  non conservé.
