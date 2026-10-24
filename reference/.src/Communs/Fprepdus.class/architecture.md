# Fprepdus — Architecture

> Source : `.src/Communs/Fprepdus.class`

## Vue d'ensemble

`Fprepdus` est une fenêtre de **synthèse des dus clients et fournisseurs** à la date du jour,
ouverte par un clic sur le libellé `lblClm3` de la fenêtre principale (`Fmenu.lblClm3_MouseDown`).
Tout est calculé dans le constructeur : deux parcours de `Fiches_Comptes` (comptes de type `C` puis
`F` à solde non nul), qui affichent le nombre de tiers concernés et le total dans `TextLabel1`
et `TextLabel2`, avec la devise de `Fiches_Parametres.devise` (« Euros » par défaut).

Nature globale : **mixte** (calculs SQL et affichage dans les mêmes fonctions).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Dte` | var | Private |  | String | 3 |
| `Devises` | var | Private |  | String | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 6-23 | Public | 3 | 15 | 0 | méthode spéciale |
| `Button3_Click` | 25-29 | Public | 1 | 3 | 0 | handler GUI |
| `TraitementC` | 31-59 | Public | 8 | 26 | 0 | portée réductible ? |
| `TraitementF` | 61-89 | Public | 8 | 26 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : mixte]. Centre la fenêtre ;
  `SELECT * FROM Cbase.Table("TabParam")` pour `devise` (« Euros » si `NULL` ; reste vide si la
  table n'a pas de ligne) ; titre « Synthèse au jj.mm.aaaa » ; reformate ensuite `Dte` en
  `aaaammjj`, valeur **jamais utilisée** ; curseur d'attente pendant `TraitementC` et `TraitementF`.
- **`TraitementC()`** [portée : réductible] [nature : mixte] (CC 8). SQL
  `SELECT * FROM Fiches_Comptes WHERE type_cc = &1 AND solde <> &2 ORDER BY compte_cc` avec
  (`"C"`, 0) (nom de table en dur). Additionne les soldes **positifs** (`Val(Utils.cpoint(solde))`)
  et les compte. Affiche « n clients vous doivent un total de x,xx Euros » ou « Aucun dû client à
  ce jour ! ». Ajoute un « s » à la devise si le total est positif et qu'elle ne finit pas déjà par
  « s » : la variable membre `Devises` est **modifiée** et réutilisée par `TraitementF`.
- **`TraitementF()`** [portée : réductible] [nature : mixte] (CC 8). Même requête avec `"F"`, sans
  `ORDER BY`. Additionne les soldes **négatifs** : le total est négatif, il est affiché avec son
  signe (« Vous devez un montant de -1234,56 … ») et le test `Tot > 0` du pluriel n'est jamais vrai.
- **`Button3_Click()`** [handler] : `Me.Close`.

Le test `If rResult.Available` répété à l'intérieur des boucles `Repeat` est redondant.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Cbase.Table("TabParam")`.
- Aucune clé de configuration.

## Propositions d'amélioration

### Réécriture / refactorisation

- Une fonction pure `SyntheseDus(sType As String, iSigne As Integer) As Float[]` (nombre, total)
  remplace les deux boucles dupliquées ; l'affichage reste dans deux procédures courtes.
- Variante SQL : `SELECT COUNT(*), SUM(solde) … AND solde > 0` (ou `< 0`) — **SQL modifié**, aucune
  écriture en base ; l'ordre de sommation des flottants peut différer au dernier chiffre, sans effet
  visible au format `0.00` (à vérifier par test).

### Commonalisation avec d'autres fichiers

- Les soldes par type de compte sont aussi calculés dans les états de relance et de lettrage
  (`Lettragesoldes` l.87 utilise `type_cc = &1 AND solde = &2`). Une fonction
  `Csolde.TotalParType(type, signe)` partagée serait à étudier avec
  [Csolde](../../Utils/Csolde.module/architecture.md).
- Le libellé « devise au pluriel » est propre à ce fichier.

### Réduction de portée

`TraitementC`, `TraitementF` : aucun appelant externe (grep `Fprepdus\.`).

### Séparation traitement / GUI

`SyntheseDus` ci-dessus (pur SQL + calcul) ; `_new` et deux procédures d'affichage gardent les
textes à l'identique.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `(type_cc, solde)` sur `Fiches_Comptes` pour les synthèses par type de tiers.
