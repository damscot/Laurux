# FSetFormat — Architecture

> Source : `.src/Utils/FSetFormat.class` · Formulaire : `.src/Utils/FSetFormat.form`

## Vue d'ensemble

`FSetFormat` est une **boîte de dialogue modale** « Paramétrer le format » qui modifie un objet
[`CFormat`](../CFormat.class/architecture.md) partagé : couleur de fond (`ColorButton1`),
réinitialisation du fond (`Button3`), aperçu (`lblExemple`) et, dans un cadre `Panlogo`, choix
d'une image de fond pour une touche de caisse (`Logo2`/`Lgo2`). Les contrôles couleur du texte
(`ColorButton2`), police (`Button1`) et leurs libellés sont **masqués** dans le `.form`
(`Visible = False`) mais leurs handlers existent.

Protocole d'appel : l'appelant affecte `FSetFormat.Format` (membre `Static Public`), appelle
`FSetFormat.Run()` (affichage modal de l'auto-instance), puis relit `FSetFormat.Format`. Comme
l'objet est passé **par référence**, les modifications sont appliquées directement à l'objet de
l'appelant ; il n'y a pas d'annulation (« Fermer » se contente de fermer).

Appelants : [`SetColors`](../SetColors.class/architecture.md) (couleurs d'écran) et `Attrib`
(touches de caisse, deux endroits).

Nature : **GUI**, avec une écriture SQL (`Fiches_Touches`) dans `Lgo2_Click`.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Button1_Click` | 5-11 | Public | 3 | 5 | 0 | handler GUI |
| `ColorButton1_Change` | 13-25 | Public | 1 | 10 | 0 | handler GUI |
| `ColorButton2_Change` | 27-32 | Public | 1 | 4 | 0 | handler GUI |
| `Run` | 34-38 | Public Static | 1 | 3 | 2 |  |
| `Form_Open` | 40-50 | Public | 4 | 9 | 0 | handler GUI |
| `Button2_Click` | 52-56 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 58-63 | Public | 1 | 4 | 0 | handler GUI |
| `Lgo2_Click` | 65-76 | Public | 3 | 10 | 0 | handler GUI |
| `FileFilter` | 78-88 | Private | 1 | 8 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Run()`** [Static, portée : nécessaire, `SetColors:49`, `Attrib:131,357`] [nature : GUI].
  `FSetFormat.ShowModal` sur l'auto-instance.
- **`Form_Open()`** [handler] [GUI]. `Utils.Observers(Me)`, initialise les deux `ColorButton`
  (repli `Color.TextBackground`/`TextForeground` si -1) et l'aperçu (police, fond, texte,
  alignement avec repli `Align.Left`). ⚠️ `lblExemple.Background = Format.Background` sans repli :
  `-1` est appliqué tel quel (à confirmer : couleur « par défaut » de Gambas).
- **`Button1_Click()`** [handler, contrôle masqué] [GUI]. Sélection de police par
  `Dialog.SelectFont`, appliquée au format et à l'aperçu.
- **`ColorButton1_Change()`** [handler] [GUI]. Fond du format et de l'aperçu. Code mort : `Rouge`,
  `Vert`, `Bleu`, `Couleur` calculés et jamais utilisés (et nommés à l'envers : l'octet de poids
  faible est le bleu).
- **`ColorButton2_Change()`** [handler, contrôle masqué] [GUI]. Couleur du texte.
- **`Button2_Click()`** [handler] [GUI]. « Fermer » : `Me.Close`.
- **`Button3_Click()`** [handler] [GUI]. « Réinitialiser » : fond `&HDFE7FF&` (format et aperçu).
  ⚠️ `ColorButton1.Color` n'est pas mis à jour.
- **`Lgo2_Click()`** [handler] [mixte]. Sélection d'une image (`*.png`, `*.jpeg *.jpg`) dans
  `User.Home`, affichage du chemin dans `Logo2` puis
  `UPDATE Fiches_Touches (Cbase.Table("TabTouches")) SET fond = &1 WHERE touche = &2` avec
  `Attrib.fnd`. Erreur → `Message.Warning`. ⚠️ Pas de filtre sur la caisse (`cai`), contrairement
  aux autres requêtes d'`Attrib` ; ⚠️ appelé depuis `SetColors`, `Attrib.fnd` instancie
  implicitement le formulaire `Attrib` et vaut `""` (à confirmer).
- **`FileFilter(All)`** [privé] [calcul]. Liste de filtres de fichiers image ; le paramètre `All`
  est inutilisé.

## Événements gérés

`Form_Open`, `Button1_Click`, `Button2_Click`, `Button3_Click`, `ColorButton1_Change`,
`ColorButton2_Change`, `Lgo2_Click` (contrôles du `.form`, noms intouchables).

## État global utilisé

- `FSetFormat.Format` (`Static Public`, partagé entre appelants).
- `Attrib.fnd` (variable publique d'un **formulaire** de la caisse).
- `Utils.Observers`, `Utils.db`, `Cbase.Table("TabTouches")`, `Dialog`, `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les variables mortes de `ColorButton1_Change` et le paramètre `All` de `FileFilter`.
- Passer la touche (`fnd`) en paramètre de `Run` (ou en membre `Static Public` comme `Format`)
  au lieu de lire `Attrib.fnd` : supprime le couplage vers un formulaire de la caisse
  (appelants à mettre à jour : `Attrib`, `SetColors`). Le comportement est identique si `Attrib`
  passe sa propre valeur.

### Commonalisation avec d'autres fichiers

- Application du format sur l'aperçu (`Form_Open`) : même bloc que `SetColors.InitTxtB` →
  `CFormat.Applique` (voir [CFormat](../CFormat.class/architecture.md), CFORMAT-004).
- Décomposition RVB d'une couleur : code identique (mais mort ici) dans
  [`SetColors.Coul_DblClick`](../SetColors.class/architecture.md).

### Réduction de portée

- Aucune : `Run` et `Format` sont utilisés par `SetColors` et `Attrib` ; les autres membres sont
  des handlers.

### Séparation traitement / GUI

- `Lgo2_Click` : extraire l'`UPDATE` dans une fonction privée `MajFondTouche(chemin, touche)` ; le
  dialogue de fichier et le `Message.Warning` restent dans le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Touches.fond` stocke un chemin absolu local (`User.Home`) : non portable entre postes ;
  un stockage de l'image en GED (`Docs_Ged`) ou un chemin relatif à la société serait plus robuste.
