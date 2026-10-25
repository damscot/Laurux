# menuopt — Architecture

> Source : `.src/Gestion/option/menuopt.class`

## Vue d'ensemble

`menuopt` ajoute au menu principal les **entrées des options métier** et en porte les handlers.
[`Fmenu`](../../../Communs/Fmenu.class/architecture.md) l'instancie au démarrage :
`New Menuopt(menu69, menu35, menu77, menu306)` (menus « Constantes », « Tables », « Stock » et
« Regroupement des BL »).

| Option (`/Soc<XX>/…`) | Menu parent | Entrée (groupe) | Écran ouvert |
|---|---|---|---|
| `bois` | Constantes | Consignes (`Tconsigne`) | `Tconsigne.Show` |
| `bois` | Constantes | Régie (`Tregie`) | `Tregie.Show` |
| `bois` | Stock | Attribution des vignettes SS (`vign`) | `atribvignette.Show` |
| `bois` | Stock | Saisie des déconsignes fournisseurs (`decfour`) | `Saisiedecons.Show` |
| `bois` | Stock | Suivi des consignes (`suivcons`) | `Edconsigne.Show` |
| `bois` | Stock | Comptabilité matière (`cmat`) | `Caleditcmat.ShowModal` |
| `pp` | Constantes | Tipp régionale (`tipp`) | `Tregion.Show` |
| `pp` | Tables | Tarif fioul (`Tfioul`) | `Ttarfioul.Show` |
| `pp` | Stock | Édition de la TIPP (`edtipp`) | fenêtre mois/année → `Edittipp` (PDF) |

Avec l'une ou l'autre option, le menu « Regroupement des BL » (`Menu306`) est masqué.

Toutes les fenêtres sont ouvertes sur leur **auto-instance** ; leurs `_new` n'ont pas de
paramètre obligatoire (`Saisiedecons._new` et `Ttarfioul._new` n'ont que des optionnels).

Nature globale : **GUI**. Pas de `.form` ; `Utils.Observers` non appelé.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$men` | var | Private |  | Menu | 3 |
| `$win` | var | Private |  | Window | 4 |
| `$mois` | var | Private |  | String | 5 |
| `$anne` | var | Private |  | String | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-35 | Public | 3 | 26 | 0 | méthode spéciale |
| `Tconsigne_click` | 37-41 | Public | 1 | 3 | 0 | handler GUI |
| `Tregie_click` | 43-47 | Public | 1 | 3 | 0 | handler GUI |
| `decfour_click` | 49-53 | Public | 1 | 3 | 0 | handler GUI |
| `tipp_click` | 55-59 | Public | 1 | 3 | 0 | handler GUI |
| `Tfioul_click` | 61-65 | Public | 1 | 3 | 0 | handler GUI |
| `cmat_click` | 67-71 | Public | 1 | 3 | 0 | handler GUI |
| `suivcons_click` | 73-77 | Public | 1 | 3 | 0 | handler GUI |
| `vign_click` | 79-83 | Public | 1 | 3 | 0 | handler GUI |
| `edtipp_click` | 86-142 | Public | 1 | 48 | 0 | handler GUI |
| `mois_lostfocus` | 144-153 | Public | 3 | 8 | 0 | handler GUI |
| `annee_lostfocus` | 155-159 | Public | 1 | 3 | 0 | handler GUI |
| `btn_Click` | 161-174 | Public | 1 | 11 | 0 | handler GUI |
| `win_close` | 176-180 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(constante, table, stock, regbl)`** [portée : nécessaire] [GUI]. Crée les entrées selon
  `Start.LocalSettings["/Soc<XX>/bois"]` et `["/Soc<XX>/pp"]` ; `$men` ne garde que la dernière
  (les menus sont tenus par leur parent).
- **`Tconsigne_click`, `Tregie_click`, `decfour_click`, `tipp_click`, `Tfioul_click`,
  `cmat_click`, `suivcons_click`, `vign_click`** [handlers de menus, restent `Public`] [GUI].
  Ouvrent l'écran correspondant. Les groupes `Tconsigne`/`Tregie` portent le nom des classes
  ouvertes (homonymie sans conséquence, mais trompeuse pour `deps.py`).
- **`edtipp_click`** [handler] [GUI]. Fenêtre modale `$win` (`As "win"`) : mois (`TextReg` du
  groupe `mois`, valeur initiale du mois courant), année (observateur `annee`), bouton OK
  (observateur `btn`), chaînage.
- **`mois_lostfocus`** [handler] [GUI]. Mémorise le mois ; hors 1-12, re-sélectionne et
  `Stop Event` (sans effet sur une perte de focus, à confirmer).
- **`annee_lostfocus`** [handler] [GUI]. Mémorise l'année (aucun contrôle).
- **`btn_Click`** [handler] [mixte]. Ferme la fenêtre, imprime `New Edittipp($mois, $anne)` dans
  `~/tmp/tipce.pdf` et l'ouvre (`Visualiseur.Prog`).
- **`win_close`** [handler de `Close` de `$win`] [GUI]. Rappelle `$win.Close` pendant la
  fermeture : inutile, ré-entrance à confirmer (A01).

## État global utilisé

`Start.LocalSettings["/Soc" & Start.Societe & "/bois" | "/pp"]`, `User.Home`, `Visualiseur`,
`Chainage`, `TextReg`, classes d'écrans de l'option.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : table `[option, parent, groupe, libellé]` parcourue par une boucle (même ordre de
  création).
- `edtipp_click` : fenêtre de saisie mois/année commune avec d'autres éditions périodiques.

### Commonalisation avec d'autres fichiers

- Saisie d'une période (mois/année) : proche des sélecteurs de période de `Caleditcmat`,
  `Edconsigne` et du calendrier proposé en commonalisation dans le lot Gestion-1.

### Réduction de portée

Aucune (handlers et constructeur).

### Séparation traitement / GUI

Sans objet (aucun SQL) ; `btn_Click` peut appeler une fonction `EditeTipp(mois, annee)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
