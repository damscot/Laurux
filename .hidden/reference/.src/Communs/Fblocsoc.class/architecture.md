# Fblocsoc — Architecture

> Source : `.src/Communs/Fblocsoc.class` (+ `Fblocsoc.form`)

## Vue d'ensemble

`Fblocsoc` règle le **blocage de la table des sociétés** pour la société courante : une case
(`CheckBox1`) et un mot de passe (`TextBox1`). Il est lancé uniquement par
[`Prgm`](../Prgm.class/architecture.md) (nom `Blocsoc`). L'état est enregistré dans
`/Soc<XX>/Blocsoc` et le mot de passe chiffré dans `/Soc<XX>/BlocsocMdp`.

Effets du blocage ailleurs : [`Fmenu`](../Fmenu.class/architecture.md) masque le menu
« Paramètres > Sociétés » (`Menu26`) ; [`LauruxConf`](../LauruxConf.class/architecture.md)
désactive le choix de base (`Nbase`), ne liste pas les bases et fige l'option `Maj`. **Le mot de
passe `BlocsocMdp` n'est lu nulle part** (FBLOCSOC-A01).

Nature globale : **mixte** (écriture de réglages).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 3-7 | Public | 2 | 3 | 0 | handler GUI |
| `Button1_Click` | 9-17 | Public | 4 | 7 | 0 | handler GUI |
| `Form_Close` | 19-28 | Public | 4 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open()`** [handler] [mixte]. `Try CheckBox1.Value = /Soc<XX>/Blocsoc`. Le mot de passe
  enregistré n'est **pas** rechargé dans `TextBox1`.
- **`Button1_Click()`** [handler] [GUI]. « Quitter » : si la case est cochée sans mot de passe,
  `Message.Warning` et retour ; sinon fermeture.
- **`Form_Close()`** [handler] [mixte]. Même avertissement (sans empêcher la fermeture), puis
  enregistre **toujours** `Blocsoc` et `BlocsocMdp = hexdblKey.Crypt("en", TextBox1.Text,
  "Laurux")`, et `Save`. Rouvrir l'écran et le refermer efface donc le mot de passe précédent.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Blocsoc"]`, `["/Soc<XX>/BlocsocMdp"]`, `Start.Societe`.
- `hexdblKey.Crypt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Test « case cochée sans mot de passe » et message dupliqués entre `Button1_Click` et
  `Form_Close` → fonction privée `MdpManquant() As Boolean` + message unique.

### Commonalisation avec d'autres fichiers

- Lecture « `/Soc<XX>/Blocsoc` vrai » répétée dans `Fmenu` et trois fois dans `LauruxConf` (avec
  `IsNull`) : une fonction `Start.SocieteBloquee() As Boolean` simplifierait ces tests (transverse).

### Réduction de portée

- Rien (handlers).

### Séparation traitement / GUI

- `Enregistre(bBloque, sMdp)` privé (écriture des deux clés + `Save`), appelé par `Form_Close`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (réglages locaux, pas de base).
