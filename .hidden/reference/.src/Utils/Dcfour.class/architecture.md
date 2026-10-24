# Dcfour — Architecture

> Source : `.src/Utils/Dcfour.class` · Form : `Dcfour.form`

## Vue d'ensemble

Programme de contrôle « **doublons de références fournisseurs** » : écrit dans `~/Doublon.txt` les
articles qui partagent la même `art_cfour`, puis ouvre le fichier dans l'éditeur
(`Editeur.Prog_Editeur`). Lancé par « Appel programme » (`Prgm`, programme `Dcfour`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-9 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button3_Click` | 11-15 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 17-72 | Public | 14 | 52 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [spéciale] [GUI]. `Utils.Observers(Me)`, centrage, `Dcfour.SetFocus` (la fenêtre
  elle-même : aucun contrôle ne porte ce nom).
- **`Button3_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [mixte].
  1. Ouvre `~/Doublon.txt` en écriture.
  2. **Passe 1** : `SELECT * FROM TabArt` ; pour chaque article dont `art_cfour` n'est pas vide,
     `SELECT * FROM TabArt WHERE art_cfour = &1` ; si plus d'une ligne, écrit `code;désignation;
     Doublon dans les références fournisseurs` pour chacune, puis un séparateur. Un groupe de *k*
     doublons est donc écrit **k fois**. *n* + 1 requêtes pour *n* articles.
  3. **Passe 2** : relit tous les articles et cherche `art_code = art_cfour` avec plus d'une ligne :
     `art_code` étant la clé primaire, la condition `count > 1` n'est **jamais** vraie (passe sans
     effet). La boucle n'est pas protégée par `If Available`.
  4. Curseur, musique si `Start.Son`, « Traitement terminé. », `Me.Close`, ouverture de l'éditeur,
     **puis** `Close #HFil` (le fichier est fermé après le lancement de l'éditeur).
  Table vide : « Il n'existe aucun doublon. » (le message ne couvre pas le cas « articles sans
  doublon », qui ouvre un fichier vide).
  Partie extractible : `ListerDoublons(sFichier) As Integer`.

## État global utilisé

- `Start.Son` (variable locale initialisée), `Utils.db`, `Utils.Observers`, `Cbase.Table("TabArt")`,
  `Editeur.Prog_Editeur`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les *n* + 1 requêtes par une requête groupée (`… WHERE art_cfour IN (SELECT art_cfour
  FROM TabArt GROUP BY art_cfour HAVING COUNT(*) > 1) ORDER BY art_cfour`) : compatible SQLite,
  supprime les répétitions (changement de contenu du fichier : anomalie A01).
- Supprimer la passe 2 (sans effet), ou la corriger (anomalie A02).

### Commonalisation avec d'autres fichiers

- [`VisPmp`](../VisPmp.class/architecture.md) : même squelette (50 % de ce fichier, 60 % de `VisPmp`) —
  `_new`, ouverture d'un fichier dans `~`, boucle, `Me.Close`, `Editeur.Prog_Editeur`, `Close`
  tardif. Helper commun proposé : `RapportTexte(sFichier, aLignes, sMsgVide)` (écrit, ferme, puis
  ouvre l'éditeur), à placer dans le socle commun d'import/export (voir
  [`Impclient`](../Exports-Imports/Impclient.class/architecture.md)).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ListerDoublons(sFichier As String) As Integer` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un index sur `Fiches_Art.art_cfour` accélérerait la recherche (à vérifier dans `db_control.csv`).
