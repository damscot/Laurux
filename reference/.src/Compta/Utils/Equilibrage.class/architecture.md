# Equilibrage — Architecture

> Source : `.src/Compta/Utils/Equilibrage.class`

## Vue d'ensemble

`Equilibrage` est un **utilitaire de réparation** (2014) qui « rééquilibre » les écritures du
journal `"70"` (code en dur) de `Fiches_Mvt` : pour chaque écriture dont le total crédit diffère du
total débit, il corrige le **crédit de la dernière ligne** (par ordre de compte) pour absorber
l'écart. Il n'est accessible que par le lanceur de programmes [`Prgm`](../../../Communs/Prgm.class/architecture.md)
(nom saisi `Equilibrage`, `Prgm.class:112`, `ShowModal`).

L'écran contient deux libellés et deux boutons du groupe `Btn` : `Button2` (tag 1, lancer) et
`Button6` (tag 2, fermer).

Nature globale : **mixte** (traitement SQL de masse déclenché par un bouton, puis message).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-36 | Public | 1 | 5 | 0 | méthode spéciale |
| `Btn_Click` | 41-53 | Public | 3 | 8 | 0 | handler GUI |
| `Button2_Click` | 58-102 | Public | 7 | 42 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [spéciale] [GUI]. Son, centrage, observateurs replay.
- **`Btn_Click()`** [handler du groupe `Btn`] [GUI]. Tag 1 → `Button2_Click` ; tag 2 → fermeture.
- **`Button2_Click()`** [appelé par `Btn_Click` ; `Button2` est dans le groupe `Btn`] [mixte].
  `SELECT * FROM Fiches_Mvt WHERE collectif is null and jour = '70' order by numero, compte` ;
  parcours en détectant le changement de `numero` ; à chaque changement, si le crédit cumulé de
  l'écriture précédente est non nul et différent du débit cumulé :
  `UPdate Fiches_Mvt SET montantc = <crédit de la dernière ligne + (débit − crédit)> where compte =
  &1 and numero = &2` (montant passé par `Utils.PointBase`). Les cumuls sont tenus dans des
  **chaînes** (`Val(Utils.cpoint(…))` à chaque opération). Puis `Message.Info("Traitement
  terminé")` et fermeture.
  Défauts relevés :
  - la **dernière écriture** du parcours n'est jamais traitée (pas de contrôle après la boucle) ;
  - une écriture sans crédit (`credit = 0`) n'est jamais corrigée ;
  - l'`UPDATE` cible toutes les lignes `compte` + `numero` (plusieurs lignes du même compte dans
    l'écriture reçoivent le même crédit) ;
  - la colonne `control` (clé chaînée `Sha1Calc`) **n'est pas recalculée** et les soldes
    (`Fiches_Comptes.solde`) ne sont pas mis à jour : les contrôles d'intégrité (`Sha1Calc`, clôture)
    signaleront les lignes modifiées ;
  - `Me.Mouse = Mouse.Default` sans `Mouse.Wait` préalable ; message sans forme `("…")`.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Utils.Observers` ; `Start.son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Cumuls en `Float` au lieu de chaînes (mêmes valeurs à l'arrondi `0.00` près, à vérifier par le
  dump) ; constante privée pour le journal `"70"` ; `Cbase.Table("TabMvt")`.

### Commonalisation avec d'autres fichiers

- Le calcul débit − crédit par écriture existe dans [`VarEcr.somme`](../VarEcr.class/architecture.md)
  et `Listextcpt.Controle` ; un contrôle d'équilibre par écriture en SQL (`GROUP BY numero HAVING
  SUM(montantd) <> SUM(montantc)`) serait plus simple, mais change le SQL émis (dump identique
  attendu, à valider).
- Après correction, le recalcul de la clé devrait passer par [`Sha1Calc`](../../../Utils/Sha1Calc.module/architecture.md)
  et le solde par la fonction commune de solde (anomalie : comportement modifié).

### Réduction de portée

- `Button2_Click` : nom de handler, appelé par `Btn_Click` ; à garder `Public` (règle des noms
  `Objet_Evenement`).

### Séparation traitement / GUI

- `Reequilibre(journal) As Integer` (nombre d'écritures corrigées) sans contrôle ; le handler garde
  la souris, le son et le message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un tel outil ne devrait plus être nécessaire si l'équilibre est garanti à l'écriture
  (`EcrAuto.ecriture` le contrôle déjà) ; une contrainte ou un contrôle à la clôture suffirait.
