# Fsystem — Architecture

> Source : `.src/Communs/Fsystem.class` (+ `Fsystem.form`)

## Vue d'ensemble

`Fsystem` est la fenêtre **« Information système »** (menu « ? > Information système »,
[`Fmenu.Menu266`](../Fmenu.class/architecture.md), auto-instance `Fsystem.show`). À l'ouverture,
elle copie le script `report.sh` du projet (script de rapport système de l'IDE Gambas : distribution,
bureau, versions…) dans un répertoire temporaire, l'exécute avec `/bin/sh`, puis ajoute les
bibliothèques Qt4/GTK2 trouvées dans `/usr/lib/`, la version du serveur SQL et la version de
Laurux. Le texte est affiché dans `txtInfo`.

Nature globale : **mixte** (exécution d'un script + affichage).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `btnClose_Click` | 3-7 | Public | 1 | 3 | 0 | handler GUI |
| `Form_Open` | 9-41 | Public | 6 | 26 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`btnClose_Click()`** [handler] [GUI]. Ferme.
- **`Form_Open()`** [handler] [mixte] (CC 6). `Temp$("report")` + `Try Mkdir`, `Try Kill` de
  l'ancien script, `Copy "report.sh"` (depuis l'archive du projet), `Exec ["/bin/sh", sTemp] To
  sText` (bloquant). Bibliothèques : `Dir("/usr/lib/", "libQtCore.so.*.*.*")` et
  `"libgtk-x11-2*.so.*.*.*"`, retenues seulement s'il y a **exactement une** correspondance ; sur les
  distributions multi-arch (`/usr/lib/x86_64-linux-gnu`), rien n'est trouvé. Ajoute
  `[Version Mysql]` + `Utils.db.Version` (même sous SQLite : le titre est alors trompeur) et
  `[Version Laurux]` + `Application.Version (Application.Path)`. Aucune gestion d'erreur sur `Copy`
  ni `Exec`.

## État global utilisé

- `Utils.db.Version`, `Application.Version`, `Application.Path`.
- Fichier `report.sh` (racine du projet) et commandes système qu'il appelle.

## Propositions d'amélioration

### Réécriture / refactorisation

- Rien de significatif (41 lignes).

### Commonalisation avec d'autres fichiers

- Aucune trouvée (seul usage de `report.sh` dans `.src`).

### Réduction de portée

- Rien (handlers).

### Séparation traitement / GUI

- Fonction pure `RapportSysteme() As String` (script + bibliothèques + versions) appelée par
  `Form_Open`, qui ne fait plus qu'affecter `txtInfo.Text` ; elle servirait aussi à un export en
  ligne de commande.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
