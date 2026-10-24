# Sha1Calc — Architecture

> Source : `.src/Utils/Sha1Calc.module`

## Vue d'ensemble

`Sha1Calc` calcule et vérifie les **clés de contrôle chaînées** (inaltérabilité des données,
exigence réglementaire type NF525 / loi anti-fraude TVA) stockées dans la colonne `control`
(`varchar(40)`) :

- des **écritures comptables** (`Fiches_Mvt`, `Fiches_Mvt1-5` et tables temporaires de mouvements
  passées en paramètre) : chaque écriture est chaînée à la clé de l'écriture précédente (numéro
  inférieur), en tenant compte de l'historique des modifications de la table « M » associée
  (`Fiches_MvtM`, `Fiches_MvtM1-5`) ;
- des **tickets de caisse** (`Fiches_EntTicketz`) : chaque ticket est chaîné à la clé du ticket
  précédent, cherché dans la même table puis dans `Fiches_HisEntTickets`.

La clé est `Base64$(Digest["sha1"](concaténation des champs))` : 28 caractères (le `Left$(…, 40)` est
sans effet).

Nature globale : **calcul + SQL** ; seule `CalcSha1_all` affiche une barre de progression.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `CalcSha1` | 6-75 | Public | 15 | 52 | 13 |  |
| `CalcSha1_all` | 77-94 | Public | 4 | 15 | 3 |  |
| `CalcSha1_Verify` | 96-119 | Public | 6 | 19 | 2 |  |
| `CalcSha1T` | 122-156 | Public | 6 | 28 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`CalcSha1(Tab, numecr, lind, update)`** (CC 15) [portée : nécessaire, environ 25 appels]
  [nature : calcul].
  1. Lit les lignes de l'écriture `numecr` (ou la seule ligne `lind`) : champs `$champ` = `jour,
     numero, compte, intitule, dte, numdoc, libelle, montantd, montantc, collectif, lind, control`.
  2. Détermine `TabM` : `Fiches_Mvt` → `Fiches_MvtM`, `Fiches_Mvt3` → `Fiches_MvtM3` (règle sur le
     dernier caractère numérique).
  3. Clé précédente `$cle2` : contrôle de l'écriture de numéro immédiatement inférieur dans `Tab`
     (ou, si elle a été modifiée, sa **première** version dans `TabM`, `lind2` croissant) ; si `TabM`
     contient une écriture inférieure plus récente que celle de `Tab` (suppression), c'est elle qui
     sert ; chaîne vide pour la première écriture de l'exercice.
  4. Si l'écriture courante a été modifiée, concatène les **deux dernières** clés de `TabM`
     (`lind desc limit 2`).
  5. Pour chaque ligne : `$cle = Trim($cle2) & jour & numero & … & lind` ; clé SHA1 Base64 ; si
     `update` et différente, `UPDATE <Tab> SET control = … WHERE lind = …`.
  Renvoie la clé de la **dernière** ligne traitée (ou `""` si l'écriture n'existe pas).
  Toutes les lignes d'une écriture sont chaînées à la même clé précédente (pas de chaînage entre
  lignes). SQL : 4 à 5 `SELECT` + jusqu'à n `UPDATE`, tables par concaténation (`Tab` fourni par
  l'appelant, souvent `"Fiches_Mvt"` en dur). ⚠️ La conversion des champs en texte dépend des types
  renvoyés par le pilote (Date, Float vs chaîne décimale) : la même base peut produire des clés
  différentes sous MySQL et SQLite, ou selon la version de gb.db (à confirmer, test SHA1CALC-T05).
  ⚠️ `numero < &1` : comparaison numérique ou textuelle selon le type de la colonne et du paramètre
  (`numecr` est une `String`) ; `CInt(mResult!numero)` ligne 43.
- **`CalcSha1_all(Tab)`** [portée : nécessaire, `LauruxMaj:4843,6105`, `Prgm:90,92`,
  `FClotureAn:631`] [nature : mixte ; GUI = `ProgBar`] : recalcule toutes les écritures par numéro
  croissant (`GROUP BY numero`), interruptible par la barre. Variable `s2Result` inutilisée.
- **`CalcSha1_Verify(Tab, numecr, lind)`** [portée : nécessaire, `Anomalies.class:53`,
  `FCloture.class:126`] : recalcule sans mise à jour la clé de chaque ligne et la compare à `control` ;
  une ligne au `control` `NULL` est considérée valide. Variables `s2Result`, `$cle2` inutilisées.
  Coût : `CalcSha1` refait 4 à 5 requêtes par ligne vérifiée.
- **`CalcSha1T($Tab, $numero, prev_numero, update)`** [portée : nécessaire, `Caisse.class:6153`,
  `Moulinage.class:1046`] : concatène 31 champs du ticket et la clé (`Trim`) du ticket précédent ;
  si le ticket précédent est introuvable, `prev_numero` devient `""`. Si `update` : `UPDATE … SET
  control, prev_numero WHERE lInd = …`. La requête du ticket précédent est répétée à chaque ligne de
  la boucle (une seule ligne attendue par numéro). `Fiches_HisEntTickets` en dur.

## État global utilisé

- `Utils.db` ; `ProgBar` (dans `CalcSha1_all`).
- Constante privée `$champ` (liste des colonnes hachées : **contrat** à ne jamais modifier sans
  recalcul complet des clés).

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire `CleEcriture(cle2, ligne As Result) As String` et `CleTicket(ticket, clePrec) As String`
  (pures) : testables sans base et réutilisées par `CalcSha1`, `CalcSha1_Verify`, `CalcSha1T`.
- Extraire `ClePrecedente(Tab, TabM, numecr) As String` (requêtes de chaînage) de `CalcSha1`
  (CC 15 → ≤ 6).
- `TabM` : fonction `TableModif(Tab)` ; à rapprocher du mapping `Cbase` (voir ci-dessous).
- Supprimer les variables inutilisées (`s2Result`, `$cle2` dans `CalcSha1_Verify` et `CalcSha1_all`).

### Commonalisation avec d'autres fichiers

- Les appelants passent `"Fiches_Mvt"` en dur (
  [`Tresor`](../../Compta/Tresor.class/architecture.md), [`Saisecrit`](../../Compta/Saisecrit.class/architecture.md),
  [`EcrAuto`](../../Compta/Utils/EcrAuto.class/architecture.md), [`impfec`](../../Compta/Utils/impfec.class/architecture.md),
  [`Moulinage`](../../Caisse/Moulinage.class/architecture.md)…) ou `Cbase.Table("TabMvt")`
  ([`Tresor`](../../Compta/Tresor.class/architecture.md):376) : homogénéiser vers `Cbase.Table` dans
  les appelants (reworks de ces fichiers).
- `Fiches_HisEntTickets` → `Cbase.Table` (clé `TabHisEntTickets` si elle existe, à vérifier dans
  [`Cbase`](../Cbase.module/architecture.md)).

### Réduction de portée

- Aucune : les quatre fonctions ont des appelants externes.

### Séparation traitement / GUI

- `CalcSha1_all` : la boucle de recalcul peut recevoir un callback de progression ; la `ProgBar` reste
  dans la fonction publique (même affichage).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker la clé précédente utilisée (`prev_control`) dans chaque écriture rendrait la vérification
  locale (une requête par ligne au lieu de 4 à 5) et robuste aux suppressions.
- Un index `(numero, lind)` sur `Fiches_Mvt*` et `(numero, lind2)` sur `Fiches_MvtM*` accélère les
  requêtes de chaînage (à vérifier dans `db_control.csv`).
- Colonne `control` en `CHAR(28)` (Base64 de SHA1) au lieu de `varchar(40)`, ou passage à SHA-256
  (changement de format de clé : recalcul complet nécessaire).
