# MDP — Architecture

> Source : `.src/Communs/MDP.class` (+ `MDP.form`)

## Vue d'ensemble

`MDP` est la **boîte de saisie du mot de passe administrateur**, ouverte en modal avant les
écrans protégés. Elle ne renvoie rien directement : elle écrit le résultat dans le global
`Start.Motdepasse` (`"OK"` si le mot de passe est bon, `""` sinon), que l'appelant teste puis remet
à `""`.

Deux modes : local (`/Soc<XX>/MdpPrefs`, utilisé par l'auto-instance `MDP.ShowModal()`) et global
(`/Soc<XX>/MdpPrefsG`, `New MDP(Null, True)` : parent `Null`, puis `Glob = True`). Les mots de
passe sont stockés chiffrés par `hexdblKey.Crypt` (clé `"Laurux"`) et écrits par
[`Prefs`](../Prefs.class/architecture.md) (`Prefs.class:531, 536`).

Nature globale : **mixte** (comparaison + messages).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `global` | var | Private |  | Boolean | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-10 | Public | 1 | 4 | 0 | méthode spéciale |
| `Mdp2_KeyPress` | 15-19 | Public | 4 | 3 | 0 | handler GUI |
| `Mdp2_LF` | 21-49 | Public | 6 | 25 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Optional Glob As Boolean = False)`** [portée : nécessaire (spéciale)] [nature : GUI].
  Mémorise le mode dans `global` et centre la fenêtre. Pas d'appel à `Utils.Observers(Me)` : la
  saisie n'est pas enregistrée par le replay (à confirmer, voir test.md).
- **`Mdp2_KeyPress()`** [handler] [GUI]. Entrée, Retour ou **Tab** → `Mdp2_LF()`.
- **`Mdp2_LF()`** [portée : réductible, nom de type handler conservé] [nature : mixte]. Choisit la
  clé (`MdpPrefs` ou `MdpPrefsG`), déchiffre `Start.LocalSettings["/Soc<XX>/<clé>"]` et compare au
  texte saisi. Échec : son (si `Start.son` ; `Music.Play` sans `Music.Load` préalable, joue le
  dernier son chargé), `Message.Error`, `Start.Motdepasse = ""`, fermeture. Succès :
  `Start.Motdepasse = "OK"`, effacement, fermeture. La variable `admn` (Integer 0/1) sert de booléen.
  Le mot de passe global est lu dans les réglages **locaux** : il y est recopié depuis les réglages
  globaux par `Prefs.ApplyGlobal` (au démarrage et après `Fmenu.Menu329`).

Fermer la fenêtre sans valider (bouton de fenêtre) laisse `Start.Motdepasse` inchangé ; tous les
appelants le remettent à `""` après usage, donc il vaut normalement `""`. Le texte d'aide « Escape
pour sortir » n'est pas implémenté dans la classe (pas de bouton `Cancel` dans le `.form`, à
confirmer).

## État global utilisé

- `Start.Motdepasse` (écrit), `Start.LocalSettings`, `Start.Societe`, `Start.son`.
- `hexdblKey.Crypt("de", …, "Laurux")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `admn` → `Boolean`, deux `If` successifs → `If … Else`.

### Commonalisation avec d'autres fichiers

- **Vérification** : la même comparaison existe dans [`Prgm.Mdp_LF`](../Prgm.class/architecture.md)
  et `Prefs.Mdp_LF` (`Prefs.class:461-480`). Fonction statique pure
  `MDP.Verifie(sSaisie As String, Optional bGlobal As Boolean) As Boolean`.
- **Protocole d'appel** : 8 handlers de [`Fmenu`](../Fmenu.class/architecture.md) et
  `Fsoc.class:400-408` répètent « si `/Admin` : `MDP.ShowModal`, tester `Start.Motdepasse = "OK"`,
  remettre à `""` ». Fonction statique `MDP.Autorise(Optional bGlobal As Boolean) As Boolean`
  (renvoie `True` sans dialogue si `/Admin` est faux ; pour le global, test de `/AdminG` dans
  `Start.GlobalSettings`, comme `Fmenu.Menu329`).

### Réduction de portée

- `Mdp2_LF` n'a pas d'appelant externe, mais son nom suit le schéma `Objet_Evenement` : conservé.

### Séparation traitement / GUI

- `Verifie` (pure) d'un côté, son/message/fermeture dans `Mdp2_LF`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès base). Le stockage réversible du mot de passe est traité par HEXDBLKEY-A01.
