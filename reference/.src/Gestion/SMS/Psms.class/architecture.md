# Psms — Architecture

> Source : `.src/Gestion/SMS/Psms.class`

## Vue d'ensemble

`Psms` est un petit formulaire de **paramétrage SMS** (support, clé API, type de contrat,
expéditeur) qui lit et écrit une table `Fiches_Psms`.

Constat vérifié : **le formulaire n'est ouvert nulle part** (`grep -rnw Psms .src` ne trouve que
le couple `Psms.class`/`Psms.form`), et la table `Fiches_Psms` **n'existe pas** : absente de
`db_control.csv`, de `Laurux01.sql` et de `LauruxMaj.module`. Le paramétrage SMS réellement
utilisé est celui des préférences ([`Prefs`](../../../Communs/Prefs.class/architecture.md),
clés `/Soc<XX>/Support`, `/Api`, `/Type`, `/Expediteur`), lu par
[`Gsm`](../Gsm.class/architecture.md) et [`Emailing`](../../Mails/Emailing.class/architecture.md).
`Psms` est donc un **couple `.class` + `.form` mort**, probable ébauche abandonnée d'un
paramétrage SMS en base.

Nature : **mixte** (SQL et contrôles dans les handlers).

### Dépendances externes

| Dépendance | Fonction | Remarque |
|---|---|---|
| `curl` + API HTTP Spot-Hit (`/api/credits/?key=`) | `api_LostFocus` | clé en clair dans l'URL HTTP et sur la ligne de commande |
| fichier `~/tmp/sms.txt` | `api_LostFocus` | réponse de l'API, partagé avec Gsm/Emailing/Prefs |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Rpost` | var | Private |  | Result | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 5-16 | Public | 2 | 10 | 0 | handler GUI |
| `api_LostFocus` | 18-35 | Public | 5 | 15 | 0 | handler GUI |
| `Button4_Click` | 37-41 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 43-54 | Public | 2 | 10 | 0 | handler GUI |
| `Button2_Click` | 56-66 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 68-72 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open`** [GUI, mixte] : centre la fenêtre, `SELECT * FROM Fiches_Psms` (nom en dur), et
  remplit `Support`, `Api`, `Type`, `Expediteur` si une ligne existe. Sur une base réelle, la
  table absente lèverait une erreur non interceptée.
- **`api_LostFocus`** [GUI, mixte] : si la clé est saisie, supprime `~/tmp/sms.txt`, interroge
  `curl "http://www.spot-hit.fr/api/credits/?key=<Api>"`, et si la réponse contient `erreur`
  affiche « Votre clé est mauvaise » et redonne le focus au champ. Même code que
  `Prefs.class:1328` (préférences).
- **`Button3_Click`** (Enregistrer) [GUI, mixte] : si une ligne existe,
  `UPdate Fiches_Psms SET support = &1, api = &2, type = &3, expediteur = &4 WHERE lind = &5`
  avec **4 arguments seulement** : `&5` n'a pas de valeur (comportement de `DB_Connection.Subst`
  à confirmer : erreur ou `WHERE lind = ` invalide). Sinon `INSERT INTO Fiches_Psms (…)`. Bloc
  `With utils` inutile.
- **`Button2_Click`** (Effacer) [GUI, mixte] : confirmation puis `Truncate Table Fiches_Psms`
  (non supporté par SQLite, non traduit par `DB_Connection`) et vidage des champs.
- **`Button4_Click`** [GUI] : fermeture. **`Button1_Click`** [GUI] : aide `Doc.Open("GSms")`.

Toutes les fonctions sont des handlers d'événements (`Public` nécessaire tant que le formulaire
existe).

## État global utilisé

- `Utils.db` ; `User.Home` (`~/tmp/sms.txt`). Aucune clé `Start.LocalSettings`.

## Sécurité (relevé)

- Clé API Spot-Hit envoyée en HTTP non chiffré et visible dans la liste des processus (`curl`
  lancé par `Shell` avec la clé dans l'URL) ; sans effet tant que le formulaire est inaccessible.
- La clé serait stockée en clair dans la base (`Fiches_Psms.api`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune tant que l'anomalie PSMS-A01 (suppression du couple mort) n'est pas tranchée.

### Commonalisation avec d'autres fichiers

- Contrôle de la clé Spot-Hit identique à [`Prefs`](../../../Communs/Prefs.class/architecture.md)
  (l. 1328), [`Gsm`](../Gsm.class/architecture.md) et
  [`Emailing`](../../Mails/Emailing.class/architecture.md) : module SMS commun (GSM-005).
- Les listes `Support` / `Type` du `.form` dupliquent celles de `Prefs.form`.

### Réduction de portée

- Sans objet : toutes les fonctions sont des handlers.

### Séparation traitement / GUI

- Sans objet si le couple est supprimé ; sinon `LitParametres()` / `EcritParametres(…)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Si un paramétrage SMS en base est souhaité (partagé entre postes, contrairement à
  `Laurux.conf`), créer `Fiches_Psms` par une migration `LauruxMaj` avec clé `lind`, et chiffrer
  la clé API ; sinon abandonner définitivement la table.
