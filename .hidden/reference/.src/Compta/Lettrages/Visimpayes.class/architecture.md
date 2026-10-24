# Visimpayes — Architecture

> Source : `.src/Compta/Lettrages/Visimpayes.class`

## Vue d'ensemble

Écran « Visualisation des impayés clients » : liste les clients (comptes `411…` non collectifs)
ayant des écritures non lettrées dans `Fiches_Mvt`, avec leur solde, puis le détail des écritures du
client sélectionné ; la touche Suppr « sort » une écriture de la liste en la marquant lettrée.

**Aucun point d'entrée** : ni `Fmenu` ni aucun autre fichier ne référence `Visimpayes`
(`grep -rni visimp .src` ne trouve que la classe et son `.form`). L'en-tête du fichier parle de
« Facturation fin de mois » et le titre du formulaire est « Facturation » : copie d'un ancien écran.
Le couple `.class` + `.form` est **mort** (anomalie VISIMPAYES-A01).

Le traitement **détruit et recrée** deux tables de travail, `Facturefm` et `Detail`. `Facturefm`
est aussi la table de travail de la facturation de fin de mois (`FacturefmA`, `ObjFacB`) avec une
structure différente : ouvrir cet écran casserait ce traitement.

Nature : **mixte** (SQL dans le constructeur et les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 27 |
| `Tab3` | var | Private |  | String | 28 |
| `Tab4` | var | Private |  | String | 29 |
| `rResult` | var | Private |  | Result | 30 |
| `Coulfond` | var | Private |  | New String[] | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-78 | Public | 1 | 38 | 0 | méthode spéciale |
| `recup_bl` | 83-154 | Public | 7 | 68 | 0 | portée réductible ? |
| `Colbl_Click` | 156-181 | Public | 4 | 23 | 0 | handler GUI |
| `Coldetail_Keypress` | 183-202 | Public | 4 | 17 | 0 | handler GUI |
| `Button2_Click` | 204-208 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 210-214 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (résultat
  `rResult` jamais lu), `Coulfond = Utils.Coulfd()` (jamais lu), observateurs, colonnes de `Colbl`
  et `Coldetail`, puis `recup_bl()`.
- **`recup_bl()`** (CC 7) [portée : réductible] [nature : mixte].
  1. `drop Table IF exists Facturefm` puis `CREATE TABLE Facturefm (code, nom, cp, ville, totald,
     totalc, lind)` ; idem pour `Detail (num, code, date, mtd, mtc, numfac, intitule, lind)`
     (`Utils.db.Engine()`).
  2. `SELECT * FROM Fiches_Mvt where left(compte,3) = &1 and collectif is null and lettree = &2
     order by numero` (411, 0).
  3. Pour chaque ligne : `SELECT * FROM Fiches_Cli WHERE cli_code = &1` (sans test `Available` :
     erreur si le compte n'a pas de fiche client) ; cumul dans `Facturefm` (UPDATE ou INSERT) ;
     INSERT dans `Detail`.
  4. Remplit `Colbl` depuis `Facturefm order by nom`, total des impayés dans `Label1`.
  `Tot` est une `String` initialisée avec l'entier 0 ; les cumuls `totald`/`totalc` sont stockés en
  `Char(12)`.
- **`Colbl_Click()`** [handler] : détail du client depuis `Detail where code = &1 order by num`.
- **`Coldetail_Keypress()`** [handler] : Suppr + confirmation → `delete from Detail WHERE num = &1`
  et `Update Fiches_Mvt set lettree = 1 where numero = &1` : **toutes** les lignes de l'écriture
  (y compris les lignes de produits et de TVA) passent lettrées, sans lot, sans SHA1, sans passer par
  `Listextcpt`. Puis reconstruction complète (`recup_bl`).
- **`Button2_Click()`** : fermeture. **`Button1_Click()`** : `Doc.Open("Visimpayes")`.

## État global utilisé

- `Utils.db`, `Utils.Coulfd`, `Utils.Observers`, `Utils.Cdate_Aff`, `Start.Musique`, `Doc`.
- Tables : `Fiches_Parametres`, `Fiches_Mvt`, `Fiches_Cli` (en dur) ; tables de travail `Facturefm`,
  `Detail` (créées à la volée).

## Propositions d'amélioration

### Réécriture / refactorisation

Aucune tant que la décision sur VISIMPAYES-A01 (suppression du couple mort) n'est pas prise. Si
l'écran devait être réactivé, la liste des impayés se calcule par une requête agrégée
(`GROUP BY compte`) sans tables de travail.

### Commonalisation avec d'autres fichiers

- Les impayés clients sont aussi calculés par les écrans de relance et par
  [Listextcpt](../../Utils/Listextcpt.class/architecture.md) (`dteech`, `lettree`) : c'est la
  voie à garder.
- Le lettrage d'une écriture doit passer par `Listextcpt.letcpt` (voir [Lettrage](../Lettrage.class/architecture.md)).

### Réduction de portée

`recup_bl` → `Private` (aucun appelant), sans objet si le couple est supprimé.

### Séparation traitement / GUI

Sans objet (code mort).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables de travail `Facturefm`/`Detail` ne figurent pas dans `db_control.csv` ; toute table de
  travail devrait avoir un nom propre à l'écran (ou être temporaire).
