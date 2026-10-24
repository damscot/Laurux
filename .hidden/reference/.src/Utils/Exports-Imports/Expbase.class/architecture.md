# Expbase — Architecture

> Source : `.src/Utils/Exports-Imports/Expbase.class` · Form : `Expbase.form`

## Vue d'ensemble

Fenêtre d'**envoi par courriel de la dernière sauvegarde de la base** (« Envoi base »). Le fichier
joint est `<Rep_Sauv>/<nom de la base>.sql` ou `.sql.gz` selon le réglage `/Compression` (écrits par
`Communs/FSauve.class`). L'adresse destinataire est préremplie depuis
`/Soc<XX>/Adr-base` (réglée dans `Prefs`). L'envoi est délégué à `EnvMail.Envoi2`.

Ouverte par `Fmenu.Menu171_Click` (« Envoi base »). Pas d'accès SQL direct (seulement
`Utils.db.Name`). En-tête de commentaire erroné (« Exportjdv.class »). Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-37 | Public | 2 | 6 | 0 | méthode spéciale |
| `button2_Click` | 39-72 | Public | 10 | 30 | 0 | handler GUI |
| `Button1_Click` | 74-77 | Public | 1 | 2 | 0 | handler GUI |
| `Button3_Click` | 79-83 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [nécessaire (spéciale)] [GUI]. `Utils.Observers`, `Music.Load`,
  `Adrbase.Text = Start.LocalSettings["/Soc" & Start.Societe & "/Adr-base"]` (sous `Try`), centrage.
- **`button2_Click()`** [handler] [mixte]. Construit l'objet (« Envoi de la sauvegarde du
  jj.mm.aaaa ») et le corps (« … de la société » & `/intitule`), puis le chemin du fichier sous
  `Try`. La branche « La base n'existe pas ! » ne se déclenche que si la construction du chemin
  lève une erreur (concaténation de chaînes : pratiquement jamais) ; l'**existence du fichier n'est
  pas vérifiée**. Adresse vide → `Message.Error`. Sinon `EnvMail.Envoi2(adresse, objet, corps,
  fichier)`. Toute erreur (`Catch`) → message « Le fichier n'a pas pu être envoyé… ». Pas de
  fermeture de la fenêtre après envoi.
  Partie extractible : `CheminSauvegarde() As String` (calcul pur depuis les réglages).
- **`Button1_Click()`** [handler] [GUI]. Vide (aide `Doc.Open` commentée). Le handler est lié au
  bouton du `.form` : il ne peut pas être supprimé sans modifier le `.form`.
- **`Button3_Click()`** [handler] [GUI]. Ferme.

## État global utilisé

- `Start.LocalSettings` : `/Soc<XX>/Adr-base`, `/intitule`, `/Compression`, `/Rep_Sauv` ;
  `Start.Societe`, `Start.Son`, `Start.Musique`.
- `Utils.db.Name`, `Utils.Observers`, `EnvMail.Envoi2`.

## Anomalies relevées

- Fichier de sauvegarde inexistant : aucune vérification, l'erreur éventuelle vient de `EnvMail`.
- Message « La base n'existe pas ! » pratiquement inatteignable.
- Messages utilisateur hors i18n (`("…")` absent).

## Propositions d'amélioration

### Réécriture / refactorisation

- `CheminSauvegarde()` privé + test `Exist()` (changement de comportement : anomalie A01).

### Commonalisation avec d'autres fichiers

- Le chemin `/Rep_Sauv` + `Utils.db.Name` + extension selon `/Compression` est aussi calculé par
  `Communs/FSauve.class` et `Communs/SauvesAuto.module` : un helper commun
  `Utils.FichierSauvegarde() As String` (à vérifier lors de la documentation de ces fichiers).
- Le bloc « musique si `son` + `Message.Error` » est répété trois fois : helper local
  `Erreur(sMsg)` ou `FinTraitement` du socle commun (voir [`Impclient`](../Impclient.class/architecture.md)).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `CheminSauvegarde()` sans contrôle ; le handler lit `Adrbase.Text` et affiche les messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
