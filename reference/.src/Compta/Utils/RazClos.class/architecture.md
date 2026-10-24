# RazClos — Architecture

> Source : `.src/Compta/Utils/RazClos.class` · Formulaire : `.src/Compta/Utils/RazClos.form`

## Vue d'ensemble

Écran **« Déblocage d'une écriture clôturée »** (menu « Déblocage écritures », `Fmenu.Menu311_Click`,
et `Prgm` nom `RazClos`). L'utilisateur saisit un numéro d'écriture ; `Débloquer` remet
`cloturee = 0` sur toutes ses lignes dans `Fiches_Mvt` puis **recalcule et réécrit la clé
d'inaltérabilité** (`Sha1Calc.CalcSha1`, mise à jour par défaut).

C'est une fonction sensible : elle rend modifiable une écriture validée définitivement et
**re-scelle** la clé SHA-1, ce qui masque la modification au contrôle « Anomalies des clés »
(`Anomalies`). Aucun mot de passe sur l'entrée de menu (à la différence de `Dup`), aucune
confirmation, aucune trace.

Nature : **mixte** (`Raz` lit `TextBox1` et affiche le message).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

Contrôles : `TextBox1` (numéro), `Button1` Débloquer, `Button2` Quitter, `Label1`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-7 | Public | 1 | 3 | 0 | méthode spéciale |
| `Raz` | 9-15 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 17-21 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 23-27 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [constructeur] [GUI] : focus sur `TextBox1`.
- **`Raz()`** [portée : réductible — aucun appelant externe (grep)] [nature : mixte, partie
  extractible : les deux instructions SQL] : `UPdate Fiches_Mvt SET cloturee = 0 WHERE numero =
  TextBox1.Text` (paramétré, mais sans contrôle de saisie ni d'existence) ;
  `Sha1Calc.CalcSha1("Fiches_Mvt", TextBox1.Text)` (toutes les lignes de l'écriture, clé réécrite
  si différente) ; `Message.Info("Ecriture débloquée !")` même si aucune ligne n'a été modifiée.
  Seul l'exercice en cours (`Fiches_Mvt`) est concerné ; noms de table en dur.
- **`Button2_Click()`** [handler] : ferme.
- **`Button1_Click()`** [handler] : `Raz()`.

## État global utilisé

- `Utils.db` ; `Sha1Calc.CalcSha1` ; table `Fiches_Mvt` en dur (deux fois).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Private Sub Debloque(sNumero As String)` sans accès aux contrôles, appelée par `Button1_Click`
  avec `TextBox1.Text` ; `Raz` disparaît ou passe `Private`.
- `Cbase.Table("TabMvt")` pour l'`UPDATE` et l'appel `Sha1Calc`.

### Commonalisation avec d'autres fichiers

- `Fiches_Mvt` passé en dur à `Sha1Calc` : même constat que `Tresor`, `Saisecrit`, `Moulinage`
  (notes transverses) ; correction commune `Cbase.Table("TabMvt")`.

### Réduction de portée

- `Raz` → `Private` (seul appelant : `Button1_Click`).

### Séparation traitement / GUI

- Voir `Debloque` ci-dessus.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table de journal des déblocages (date, utilisateur, écriture, ancienne clé) permettrait de
  garder la trace exigée pour l'inaltérabilité.
