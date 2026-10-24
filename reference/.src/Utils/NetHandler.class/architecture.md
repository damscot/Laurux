# NetHandler — Architecture

> Source : `.src/Utils/NetHandler.class`

## Vue d'ensemble

`NetHandler` hérite de `LogHandler` (gb.logging) et envoie chaque ligne de log sur une **socket TCP**
(`host:port`). Il est utilisé uniquement par [`DB_Connection.Start`](../DB_Connection.class/architecture.md)
comme handler `"remote"` du journal applicatif, lorsque `/Soc<XX>/ServerLogIP` ou
`/Soc<XX>/ServerLogPort` est renseigné (préférences, `Prefs.class:436-438`). Côté serveur, la
réception se fait par exemple avec `nc -l -k -p <port> > laurux_log.csv` (aide affichée par
`DB_Connection.Get_Remotefile_Path`).

La classe est déclarée `Export` (visible par d'autres projets utilisant Laurux comme bibliothèque ;
sans usage connu à l'extérieur).

États (`Me.Step`, propriété de `LogHandler`) : 0 = non connecté, 1 = connecté, 2 = fermé.

Nature globale : **calcul** (réseau).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$sock` | var | Private |  | Socket | 7 |
| `$host` | var | Private |  | String | 8 |
| `$port` | var | Private |  | Integer | 9 |
| `$sLogStream` | var | Private |  | Stream | 12 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-23 | Public | 1 | 6 | 0 | méthode spéciale |
| `Open` | 25-44 | Public | 5 | 12 | 0 | portée réductible ? |
| `Write` | 46-54 | Public | 3 | 5 | 0 | portée réductible ? |
| `Close` | 56-64 | Public | 3 | 5 | 0 | portée réductible ? |
| `GetOutput` | 66-76 | Public | 4 | 9 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Host, Port, iMinLevel)`** [portée : nécessaire] : crée la socket, mémorise hôte et port,
  fixe le niveau minimal (défaut `LogLevel.Info`).
- **`Open()`** (CC 5) [portée : nécessaire, appelée par gb.logging lors de `ComplexLogger.Begin`]
  [nature : calcul]. Erreur si déjà initialisé ; `Connect`, puis attente active
  `Do While Status <> Connected And Status > 0 : Wait 0.1` — **sans délai maximal** : un hôte qui ne
  répond pas bloque le démarrage de l'application jusqu'au timeout TCP du système (à confirmer).
  En cas d'échec, `Step` reste à 0 (aucune erreur levée, les écritures sont ignorées).
  `$sLogStream` est affecté mais jamais lu.
- **`Write(sMessage, iLevel)`** [portée : nécessaire, appelée par gb.logging] : écrit
  `sMessage & "\n"` si connecté et si le niveau est accepté. Pas de reconnexion si la socket tombe
  (erreur d'écriture non interceptée, à confirmer).
- **`Close()`** [portée : nécessaire] : `Step` 1 → 2 et fermeture de la socket (`Try`).
- **`GetOutput()`** [portée : nécessaire, `DB_Connection.Get_Remotefile_Path` via `logh["remote"]`] :
  texte d'état « Fail to Connect… », « Successfully connected… », « Connection closed… ».

## État global utilisé

- Aucun ; réseau uniquement.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `$sLogStream` (code mort).
- Borner l'attente de connexion (ex. 2 s) : changement de comportement (une connexion lente
  aujourd'hui acceptée serait abandonnée) → anomalie A01.

### Commonalisation avec d'autres fichiers

- Aucune autre classe réseau de journalisation dans le projet. Le choix de créer ou non le handler
  (condition `Or`) est dans [`DB_Connection`](../DB_Connection.class/architecture.md) (DB_CONNECTION-A06).

### Réduction de portée

- `Open`, `Write`, `GetOutput` signalés par `deps.py` : **faux positifs**. `Open`/`Write`/`Close` sont
  des surcharges appelées par gb.logging et doivent rester `Public` ; `GetOutput` est appelé via une
  `Collection` non typée. La classe étant `Export`, aucune réduction n'est proposée.

### Séparation traitement / GUI

- Sans objet (aucun accès GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
