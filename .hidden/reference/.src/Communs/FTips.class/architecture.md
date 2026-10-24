# FTips — Architecture

> Source : `.src/Communs/FTips.class` (+ `FTips.form`)

## Vue d'ensemble

`FTips` affiche l'**astuce du jour** (code repris de Benoît Minisini). Le fichier `tips/tips.fr`
(24 sections `[Nom]` suivies de HTML) est indexé une fois au chargement de la classe (`_init`
statique) ; chaque ouverture affiche l'astuce suivant la dernière vue (`/LastTip`). Une case permet
de ne plus afficher les astuces au démarrage (`/Tips`).

Ouverture : `Start.Lancement` (`New FTips` puis `Show`, si `/Tips` est vrai, sans `-p` et sans
`Start.NoTips`, `Start.module:328-330`) et menu « ? > Astuces » de
[`Fmenu`](../Fmenu.class/architecture.md) (`Menu125`, auto-instance `FTips.Show`).

Nature globale : **GUI**, avec une petite logique de parcours circulaire.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$aOrder` | var | Private | oui | New String[] | 8 |
| `$iTip` | var | Private | oui | Integer | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 12-16 | Public | 1 | 3 | 0 | handler GUI |
| `Form_Close` | 18-22 | Public | 1 | 3 | 0 | handler GUI |
| `_init` | 24-38 | Public Static | 4 | 11 | 0 | méthode spéciale |
| `_new` | 40-57 | Public | 2 | 14 | 0 | méthode spéciale |
| `ShowNextTip` | 59-64 | Private | 1 | 4 | 0 |  |
| `GetNextTip` | 66-103 | Private | 8 | 28 | 0 |  |
| `chkShowTip_Click` | 105-109 | Public | 1 | 3 | 0 | handler GUI |
| `btnNext_Click` | 111-115 | Public | 1 | 3 | 0 | handler GUI |
| `Form_Resize` | 117-129 | Public | 1 | 10 | 0 | handler GUI |
| `btnClose_Click` | 131-135 | Public | 1 | 3 | 0 | handler GUI |
| `btnPrev_Click` | 137-141 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_init()`** [statique, spéciale] [nature : calcul]. Ouvre `tips/tips.fr` (chemin relatif au
  projet) et ajoute à `$aOrder` le nom de chaque section (`[Nom]`). Pas de `Catch` : fichier absent
  → erreur au premier usage de la classe, donc au démarrage (FTIPS-A01). Le fichier n'est pas
  refermé explicitement.
- **`_new()`** [spéciale] [GUI]. Si `/Soc<XX>/Coul_fen`, fond de la fenêtre et de la case selon
  `/Coul/Fnets` (`Utils.FColr`) ; la couleur `/Coul/Btns` est calculée puis **jamais utilisée**.
  Observateurs de replay, `$iTip = /LastTip` (0 par défaut), case = `/Tips` (vrai par défaut),
  centrage, `ShowNextTip`.
- **`ShowNextTip(Optional bPrev)`** [privée] [GUI]. Texte de l'astuce et titre « Astuce du jour #n ».
- **`GetNextTip(Optional bPrev) As String`** [privée] [mixte] (CC 8). Avance ou recule `$iTip` de
  façon circulaire (1…`Count`), **relit tout le fichier** à chaque appel (`File.Load`), extrait le
  texte entre l'en-tête `[Nom]` et la section suivante. `Catch` → `Message.Error("Impossible de lire
  l'astuce du jour !")`. Si `/LastTip` dépasse le nombre de sections et qu'on recule, l'indice sort
  du tableau (erreur rattrapée par le `Catch`, FTIPS-A02).
- **`Form_Open()`** [handler] [GUI]. Centre.
- **`Form_Close()`** [handler] [mixte]. Enregistre `/LastTip` (sans `Save` explicite : écrit à
  l'enregistrement suivant des réglages).
- **`Form_Resize()`** [handler] [GUI]. Mise en page manuelle (titre, panneau bas, boutons, zone de
  texte).
- **`chkShowTip_Click()`** [handler] [mixte]. `/Tips = chkShowTip.Value`.
- **`btnNext_Click()`**, **`btnPrev_Click()`**, **`btnClose_Click()`** [handler] [GUI].

## État global utilisé

- `Start.LocalSettings["/LastTip"]`, `["/Tips"]`, `["/Coul/Fnets"]`, `["/Coul/Btns"]`,
  `["/Soc<XX>/Coul_fen"]`, `Start.Societe`.
- Membres **statiques** `$aOrder`, `$iTip` : partagés entre l'instance de démarrage et celle du menu.
- `Utils.FColr`, `Utils.Observers`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Charger le contenu du fichier une seule fois (dans `_init`) et ne garder que le découpage dans
  `GetNextTip` ; comportement identique tant que le fichier ne change pas pendant la session.

### Commonalisation avec d'autres fichiers

- Le bloc « `Coul_fen` → `Me.Background = Val(Utils.FColr(…)[0])` » est répété dans 36 fichiers
  (`grep -rl Coul_fen`). Un helper `Utils.FondFenetre(hForm, aCtrl)` le factoriserait (transverse,
  phase 3).

### Réduction de portée

- Rien : seules des fonctions spéciales et des handlers sont `Public`.

### Séparation traitement / GUI

- `IndiceSuivant(i, n, bPrev) As Integer` et `TexteAstuce(sContenu, sNom) As String` statiques et
  pures (testables en gb.test), `GetNextTip` ne gardant que l'appel et le `Message.Error`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès base).
