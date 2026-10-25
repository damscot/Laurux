# RazInv — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class`

## Vue d'ensemble

Écran de **suppression de l'inventaire de fin d'exercice** : après confirmation, il supprime la
table de travail `Fiches_Inv` (`DROP TABLE IF EXISTS`). Aucun contrôle n'est fait sur l'état de
l'inventaire (comptage en cours, validé ou non) ; le texte du `.form` le dit explicitement.
Ouvert en modal par [`Fmenu.Menu232_Click`](../../../../../Communs/Fmenu.class/architecture.md)
(`Fmenu.class:1977`).

Jumeau quasi identique de [RazInvT](../../Tournant/RazInvT.class/architecture.md) (11 lignes de
code communes sur 13, 3 fonctions homonymes sur 3) : seule la clé `Cbase` (`TabInv` / `TabInvT`) et
le texte de la question diffèrent.

`Fiches_Inv` est une **table de travail** créée par [Geninv](../Geninv.class/architecture.md) et
absente de `db_control.csv` : la supprimer n'altère pas le schéma de référence, mais rend
inopérants [SaisieInv](../SaisieInv.class/architecture.md), [Validinv](../Validinv.class/architecture.md),
les éditions ([Ecarts](../Ecarts.class/architecture.md), [Ednsaisis](../Ednsaisis.class/architecture.md),
[Edinv](../Edinv.class/architecture.md)) et `EditStkDepart` jusqu'à la prochaine génération.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

Aucune variable membre.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-8 | Public | 1 | 4 | 0 | méthode spéciale |
| `Button2_Click` | 10-14 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 16-23 | Public | 3 | 6 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre et instrumente
  l'écran pour le log/replay (`Utils.Observers(Me)`).
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Bouton « Quitter » :
  ferme la fenêtre.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Bouton « Supprimer » :
  `Message.Question` (Oui = 1), puis `Try Utils.db.Exec("drop Table IF exists " &
  Cbase.Table("TabInv"))` et `Message.Info("Inventaire effacé !")`. Le `Try` masque toute erreur :
  le message de succès s'affiche même si le `DROP` échoue (base verrouillée, droits). En mode
  backtrace, `DB_Connection.Exec` affiche déjà un `Message.Error` avant que le `Try` n'absorbe
  l'erreur. Partie extractible : le `DROP` (fonction sans contrôle, renvoyant un booléen).

## État global utilisé

- `Utils.db` (`Exec`), `Cbase.Table("TabInv")`, `Utils.Observers`.
- Aucun accès à `Start.*` ni `Variables.*`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Isoler le `DROP` dans une fonction privée `Supprimer() As Boolean` (même SQL), le handler gardant
  la question et le message.

### Commonalisation avec d'autres fichiers

- **Socle commun inventaire** (proposition transverse du lot, voir
  [Geninv](../Geninv.class/architecture.md)) : un module
  `Inventaire` paramétré par le type (`"F"` fin d'exercice / `"T"` tournant, sur le modèle déjà
  adopté par [Edinv](../Edinv.class/architecture.md) `_New(choix)`) exposerait
  `Inventaire.Table(sType)` et `Inventaire.Supprimer(sType)`. `RazInv`, [RazInvT](../../Tournant/RazInvT.class/architecture.md),
  [Geninv](../Geninv.class/architecture.md) et [GeninvT](../../Tournant/GeninvT.class/architecture.md)
  (qui font chacun le même `DROP`) l'utiliseraient. Les deux `.form` restent distincts.

### Réduction de portée

- Aucune : les trois fonctions sont la méthode spéciale et deux handlers (`Public` obligatoire).

### Séparation traitement / GUI

- `Button1_Click` : extraire le `DROP` (voir ci-dessus).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer les tables de travail `Fiches_Inv` / `Fiches_InvT`, créées et supprimées à
  l'exécution, par une table permanente `Fiches_Inv` avec une colonne `inv_type` (`F`/`T`) et un
  statut (`en cours`, `validé`) : la « remise à zéro » deviendrait un `DELETE … WHERE inv_type = 'F'`
  et la table serait contrôlée par `DB_Sanity` (`db_control.csv`).
