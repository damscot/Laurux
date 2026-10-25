# Preparation — Tests

> Source : `.src/Gestion/Lcr/Preparation.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe** (création des bordereaux qui alimentent le fichier bancaire de `Bordrx`) :
> la liste des scénarios ci-dessous est **à faire valider par l'utilisateur avant la phase 2**.

Écran rejouable (`Utils.Observers(Me)`), mais `ColLcr` n'a pas de `ColLcr_Click` : les sélections
dans la grille doivent passer par l'événement `MouseUp` journalisé, sinon le scénario est à
adapter (REPLAYOBSERVER-A06). Jeu de données dérivé de `Laurux01.sql` : 2 banques, 8 LCR attribuées
(banques 1 et 2, codes entrée 0/1/5, une écartée, une déjà en bordereau), échéances sur 2 mois,
`Fiches_Bordereaux` vide puis avec un bordereau. Dates figées par `faketime`. Les replays sont
joués sur MariaDB en mode strict **et** non strict (A01).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PREPARATION-T01 | replay | Ouverture et totaux | ouverture | liste `banque <> 0 and ecartee <> 1 and bordereau = 0`, `Nb2`/`Mt2` | `tests/ouverture/` | à faire |
| PREPARATION-T02 | replay | Filtres banque et code entrée | `BQ` = banque 1 ; `Entree` = 1 ; `Entree` sans banque | listes, totaux, message « Vous devez sélectionner une banque… » | `tests/filtres/` | à faire |
| PREPARATION-T03 | replay | Tri et recherche par échéance | focus sur les en-têtes, tri montant ; frappe dans `DAE` | lignes `Exec_SQL` (`CAST`, `like`) | `tests/tri_recherche/` | à faire |
| PREPARATION-T04 | replay | Modification d'une LCR | clic gauche sur une ligne, changement banque/code entrée, Valider | dump `Fiches_Lcr` | `tests/modification/` | à faire |
| PREPARATION-T05 | replay | Code entrée sur lignes marquées | 2 clics droits sur 2 lignes, `Entree2`, Valider | dump `Fiches_Lcr` (`codeentree`) ; nombre de clics nécessaires figé (A04) | `tests/marquage/` | à faire |
| PREPARATION-T06 | replay | Génération d'un bordereau sans échéances | banque 1, « Attribuer », code entrée 1, référence, dates, Générer | dump `Fiches_Lcr` (`bordereau`, `codeentree`) et `Fiches_Bordereaux` (valeurs `banque`/`codeentree`, A01 figée selon le mode SQL) | `tests/bordereau/` | à faire |
| PREPARATION-T07 | replay | Génération avec échéances | `CheckBox1`, `Ech1`/`Ech2` | message « aucune LCR… » ou sélection figée (A02) | `tests/bordereau_echeances/` | à faire |
| PREPARATION-T08 | replay | Second bordereau | T06 puis une autre banque | numéro = dernier `lind` + 1 | `tests/numerotation/` | à faire |
| PREPARATION-T09 | replay | Suppression sans confirmation | sélection, Supprimer | dump `Fiches_Lcr` (A05 figée) | `tests/suppression/` | à faire |
| PREPARATION-T10 | replay | Impression | sans banque, puis banque 1, « Imprimer » | `~/Lcr.pdf` par `pdftotext` (LCR écartées et remises incluses, A06) | `tests/impression/` | à faire |
| PREPARATION-T11 | replay | SQLite | T06 sur `Laurux01.sqlite` | erreur `value` figée (A01) | `tests/sqlite/` | à faire |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** ; dump normalisé de `Fiches_Lcr`
  et `Fiches_Bordereaux` (dates de remise/valeur figées par `faketime`).
- T06 est le test pivot de la chaîne : son état final de base sert de jeu d'entrée aux tests de
  `Bordrx` (fichier bancaire).
- Le `sql_mode` de la base Docker de test doit être fixé explicitement (strict et non strict)
  pour caractériser A01.
- Le `Laurux.conf` de test est passé par `-c` ; `Settings` (l. 77) lit alors le fichier par défaut :
  prévoir le même fichier ou figer la couleur de fond (sans impact sur la base).
