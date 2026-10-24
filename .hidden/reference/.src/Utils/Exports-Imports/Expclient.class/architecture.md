# Expclient — Architecture

> Source : `.src/Utils/Exports-Imports/Expclient.class` · Form : `Expclient.form`

## Vue d'ensemble

Fenêtre d'**export des clients** (`Fiches_Cli`) en CSV `;` dans `Liste_clients.csv` (répertoire
choisi, `~` par défaut). Pas d'en-tête ; 10 colonnes : code, raison sociale, nom, prénom, adresse 1
et 2, code postal, ville, portable, mail, suivies d'un `;` final.

Ouverte par `Fmenu.Menu170_Click` (« Export des clients »). Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 26 |
| `Num` | var | Private |  | String | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-37 | Public | 1 | 6 | 0 | méthode spéciale |
| `Svs_Click` | 39-49 | Public | 2 | 9 | 0 | handler GUI |
| `Button3_Click` | 51-55 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 57-99 | Public | 5 | 39 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [nécessaire (spéciale)] [GUI]. Identique à [`Expart._New`](../Expart.class/architecture.md).
- **`Svs_Click()`** [nécessaire (handler)] [GUI]. Identique à `Expart.Svs_Click` (annulation →
  `User.Home`).
- **`Button3_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [nécessaire (handler)] [mixte]. Ouvre le fichier, `SELECT * FROM Fiches_Cli`
  (sans `ORDER BY` : ordre d'insertion du SGBD, donc non garanti), écrit une ligne par client.
  Table vide : fichier vide créé + `Message.Error`. Musique si `son`, `Message.Info`, `Close`,
  fermeture. Partie extractible : `ExporterClients(sChemin) As Integer`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.db`, `Utils.Observers`.
- Membres `son`, `Num` (`Num` devrait être local).

## Anomalies relevées

- Ordre des lignes non déterministe (pas d'`ORDER BY`).
- `;` non échappés ; un champ `Null` est écrit vide (concaténation `&`), sans erreur.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les 9 variables intermédiaires (lecture directe `rClient!…` dans un `String[]`).

### Commonalisation avec d'autres fichiers

- [`Expart`](../Expart.class/architecture.md) : 22 lignes normalisées communes (46 % de ce fichier),
  mêmes `_New`/`Svs_Click`/`Button3_Click`/fin de traitement.
- [`Expcontact`](../Expcontact.class/architecture.md) : 31 lignes communes (65 % de ce fichier),
  lecture des mêmes colonnes d'adresse client.
- Socle commun d'import/export : voir [`Impclient`](../Impclient.class/architecture.md).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ExporterClients(sChemin As String) As Integer` appelée par le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune spécifique.
