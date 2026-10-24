# FRestore — Synthèse

> Source : `.src/Communs/FRestore.class` · Synthèse des autres documents.

## Rôle

Écran de restauration de la base courante à partir de `<rep>/<base>.sql` ou `.sql.gz` (produits
par `FSauve`) : détection MariaDB/MySQL, décompression, contrôle des processus MySQL, `DROP` +
`CREATE DATABASE` + import par `mysql`, vidage de `Fiches_Docactif`, contrôle de version de la
base restaurée et restauration facultative de `Laurux.conf`.

## Points clés

- `Button2_Click` (CC 30) concentre shell, SQL et GUI.
- Propriétaire et date de la sauvegarde obtenus en découpant la sortie `ls -1 -g` (le
  « propriétaire » est en fait le groupe).
- Échec d'import détecté par une condition fragile sur la sortie de `mysql` (position de
  l'avertissement « Using a password »).
- `Process_Read` est du code mort ; l'écran est le jumeau de `FSauve` (4 handlers identiques).

## Dépendances principales

- Utilisé par : `Fmenu.Menu65_Click`, reprise sur erreur de démarrage (`Fmenu.class:280`).
- Utilise : `Utils.Clear_DataBase`/`Create_DataBase`/`Fill_DataBase`, `Utils.Exit`,
  `Mmysql.Process_List`/`Init`, `Recup.Utilisateur`, `Cbase.Table("TabActif")`, commandes `mysql`,
  `ls`.

## Risques

- Base supprimée avant l'import, sans filet (A07) ; erreurs d'import mal détectées (A02).
- Préférences restaurées probablement réécrites à la fermeture (A03) ; arrêt asynchrone (A04).
- Port et tunnel SSH ignorés, mot de passe visible dans `ps` (A05) ; archives journalières de
  `SauvesAuto` non restaurables (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 178 |
| Lignes de commentaire | 22 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 51 |
| Complexité max (fonction) | 30 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 replays (FRESTORE-T01 à T10) sur MariaDB Docker : restauration `.sql` et `.sql.gz`, fichier
absent, préférences, version différente ou ancienne, import en erreur, mot de passe invalide,
processus, aller-retour avec `FSauve`. Critère : dump complet de la base restaurée. Prérequis :
client `mysql` sur l'hôte, `127.0.0.1:3306`, `~/tmp`.

## Rework

9 étapes (FRESTORE-001 à 009) : documentation, code mort, portée de `Verif_Version`, extraction de
l'analyse `ls` et de la restauration, helpers communs avec `FSauve`/`SauvesAuto`/`Expbase`
(chemin de sauvegarde, choix de répertoire, contrôle des processus) et `Utils` (ligne de commande
MySQL). 8 anomalies (FRESTORE-A01 à A08).
