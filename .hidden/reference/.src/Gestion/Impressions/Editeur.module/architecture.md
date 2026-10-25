# Editeur — Architecture

> Source : `.src/Gestion/Impressions/Editeur.module`

## Vue d'ensemble

Module utilitaire d'**ouverture d'un fichier produit par Laurux** (export texte, journal d'erreurs,
CSV…) dans un programme externe. Il est appelé à 37 endroits répartis dans 27 fichiers (exports
comptables, inventaires, étiquettes, sauvegarde/restauration…), toujours avec un seul argument :
`Editeur.Prog_Editeur(<chemin>)`.

Le programme utilisé est configurable par la clé **globale** `Start.LocalSettings["/CmdEditor<n>"]`
(`n` = type de fichier, `0` pour le texte). Si la clé est absente, Laurux délègue à
`Desktop.Open` (xdg-open). Aucune clé `/CmdEditor*` n'est écrite par Laurux (grep : seule lecture
dans ce module) : elle se règle à la main dans `Laurux.conf`, ce qui est aussi le moyen de la
neutraliser dans les tests (voir [Balance](../../../Compta/Impressions/Balance.class/test.md)).

La seconde fonction, `Prog_Email`, est un **reste inachevé** : elle choisit un client de messagerie
via [`CheckProg`](../../../Utils/CheckProg.module/architecture.md) mais n'en fait rien, et n'est
appelée nulle part.

Nature globale : **GUI/système** (lancement de processus), aucun accès à la base.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `FILE_TYPE_TXT` | enum | Public | oui |  | 8 |
| `FILE_TYPE_PDF` | enum | Public | oui |  | 8 |
| `FILE_TYPE_MAX` | enum | Public | oui |  | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Prog_Editeur` | 10-20 | Public | 2 | 8 | 27 |  |
| `Prog_Email` | 22-30 | Public | 3 | 6 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Prog_Editeur(Fic As String, Optional Type As Integer = FILE_TYPE_TXT) As String`**
  [portée : nécessaire, 27 fichiers appelants] [nature : GUI/système].
  Si `/CmdEditor<Type>` est renseignée, lance `Shell <commande> & " " & Fic` (sans `Wait`, sans
  quotes) ; sinon `Desktop.Open(Fic)`. Déclarée `As String` mais **ne renvoie rien** (`""`) ;
  aucun appelant n'utilise la valeur de retour (37 appels en instruction, vérifié par grep).
  Variable locale `$Exec` inutilisée. Le paramètre `Type` n'est jamais passé par un appelant :
  seule la clé `/CmdEditor0` est donc lue en pratique.
  ⚠️ Le chemin n'est pas protégé (`Shell.Quote`) : un chemin contenant un espace ou un caractère
  spécial du shell (répertoire personnel, nom de fichier) casse la commande (EDITEUR-A01). Le
  chemin `Desktop.Open` n'est pas concerné.
- **`Prog_Email(Fic As String) As String`** [portée : réductible — **code mort**] [nature : système].
  Teste `thunderbird`, puis `kmail`, puis `evolution` avec `CheckProg.Chk` (chaque test lance
  `which` et écrit un fichier temporaire), puis s'arrête : `$Exec` n'est pas utilisé, `Fic`
  non plus, la valeur de retour est `""`. Signalée `unused` et « portée réductible » par
  `deps.py`, confirmé par `grep -rn Prog_Email .src` (seule la déclaration). C'est le **seul
  appelant de `CheckProg.Chk`** : sa suppression rend `CheckProg` entièrement mort (CHECKPROG-003).

## État global utilisé

- `Start.LocalSettings["/CmdEditor" & Type]` (lecture seule, clé globale, hors section société).
- Aucun état propre (pas de variable de module).

## Appels inexistants signalés ailleurs

- `Bordrx.class:383` appelle `Impression.Prog_Editeur(…)` (méthode **inexistante** dans
  `Impression.module`) avec `Start.Soc` (membre inexistant) : IMPRESSION-A03. La correction attendue
  dans `Bordrx` est un appel à `Editeur.Prog_Editeur` avec `Start.Societe`. Ce module n'a rien à
  changer pour cela ; aucun fichier de ce lot n'utilise `Impression.Prog_Editeur` ni `Start.Soc`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Prog_Editeur` en `Sub` (aucun appelant n'utilise la valeur) et suppression de `$Exec`.
- Garder l'énumération `FILE_TYPE_*` et le paramètre `Type` (API publique, coût nul) ; documenter
  que seul `/CmdEditor0` est utilisé aujourd'hui.

### Commonalisation avec d'autres fichiers

- [`Impression`](../../../Utils/Impression.module/architecture.md) et `Visualiseur` suivent le même
  schéma « clé de configuration sinon programme par défaut » (`/CmdImp`, `/Soc<XX>/caisse/CmdVis`) :
  un helper commun `LanceProgramme(cle, fichier, defaut)` (avec quoting) éviterait trois variantes.
  À traiter avec les reworks de ces modules (phase 3).

### Réduction de portée

- `Prog_Email` : suppression plutôt que réduction (code mort, EDITEUR-002).

### Séparation traitement / GUI

- Sans objet (aucun calcul).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base. La clé `/CmdEditor<n>` pourrait être exposée dans `Prefs`.
