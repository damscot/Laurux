# Visreglements — Architecture

> Source : `.src/Gestion/Reglements/Visreglements.class` · Formulaire : `.src/Gestion/Reglements/Visreglements.form`

## Vue d'ensemble

`Visreglements` est un ancien écran de **visualisation des règlements clients** : il liste les
clients (`411…`) ayant des écritures dans les journaux de caisse et de banque
(`Fiches_Parametres.jrnal2`/`jrnal3`), puis le détail de ces écritures pour le client choisi, et
permet de **supprimer un règlement** (touche Suppr), ce qui efface la ligne d'écriture dans
`Fiches_Mvt`, « délettre » le lot et recalcule le solde du compte client.

**Aucun point d'entrée** : `grep -rn Visreglements .src` ne renvoie que ce fichier (et son appel
d'aide `Doc.Open("Visreglements")`) ; il n'est ni dans `Fmenu`, ni dans le dispatcher `Prgm`, ni
instancié par `New`/`Class.Load`. Le couple `.class` + `.form` est **mort** (dernière modification
fonctionnelle : 2017). C'est un quasi-clone de
[`Visimpayes`](../../../Compta/Lettrages/Visimpayes.class/architecture.md) (Compta/Lettrages),
lui aussi mort ; l'en-tête « Facturation fin de mois » est copié de `Facturefm`.

À chaque ouverture, l'écran **détruit et recrée** deux tables de travail globales `Facturefm` et
`Detail` (noms en dur, hors `Cbase` et `db_control.csv`). `Facturefm` est aussi la table de travail
de `Facturefm`/`FacturefmA` : réactiver cet écran casserait une facturation de fin de mois en cours
(même constat que VISIMPAYES-A02).

Nature globale : **mixte** (SQL et contrôles mêlés dans chaque fonction).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Tab3` | var | Private |  | String | 29 |
| `Tab4` | var | Private |  | String | 30 |
| `Tab5` | var | Private |  | String | 31 |
| `Param` | var | Private |  | Result | 32 |
| `rResult` | var | Private |  | Result | 33 |
| `Coulfond` | var | Private |  | New String[] | 34 |
<!-- /AUTO:declarations -->

Membres déclarés sans mot-clé de portée (donc `Private`), absents du tableau généré : `Tab`,
`Tab3`, `Tab4`, `Tab5` (noms de tables), `Param As Result` (paramètres lus dans `recup_bl`, relus
par `Colbl_Click`), `rResult As Result` (affecté dans `Form_Open`, jamais lu), `Coulfond As New
String[]` (affecté, jamais lu).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 39-82 | Public | 1 | 39 | 0 | handler GUI |
| `recup_bl` | 87-154 | Public | 8 | 65 | 0 | portée réductible ? |
| `Colbl_Click` | 156-184 | Public | 4 | 25 | 0 | handler GUI |
| `Coldetail_Keypress` | 186-214 | Public | 6 | 26 | 0 | handler GUI |
| `Calc_solde` | 216-241 | Public | 3 | 23 | 0 | portée réductible ? |
| `Button2_Click` | 243-247 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 249-253 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Form_Open()`** [handler] [nature : GUI]. `SELECT * FROM Fiches_Parametres` (résultat inutilisé),
  `Utils.Coulfd`, `Utils.FColr` (résultats inutilisés), `Utils.Observers(Me)`, `Music.Load`,
  centrage ; configure `Colbl` (4 colonnes utiles sur 5 : code, nom, cp, ville) et `Coldetail`
  (**7 colonnes**, 0 à 6 : clé cachée, n° document, date, montants, n° de lot caché, journal) ;
  appelle `recup_bl`.
- **`recup_bl()`** [portée : réductible] [nature : mixte] (l. 87-154).
  - `SELECT * FROM Fiches_Parametres` → `Param` (journaux `jrnal2`, `jrnal3`).
  - `DROP TABLE IF EXISTS Facturefm` puis `CREATE TABLE Facturefm(code, nom, cp, ville, totald,
    totalc)` ; idem pour `Detail(num, code, date, mtd, mtc, numfac, jour, numlot, lind)` avec
    `Utils.db.Engine()`.
  - `SELECT * FROM Fiches_Mvt WHERE left(compte,3) = 411 AND collectif IS NULL AND jour = jrnal2
    OR … jour = jrnal3 ORDER BY numero` (arguments `&2` et `&5` passés mais inutilisés).
  - Par écriture : `SELECT * FROM Fiches_Cli WHERE cli_code = compte` (sans test `Available` :
    erreur si le compte n'a pas de fiche client, sauf que l'`INSERT` est sous `Try`), cumul dans
    `Facturefm` (`UPdate` ou `INSERT` sous `Try`), copie dans `Detail` (`INSERT` sous `Try` : les
    doublons de clé `(num, numfac, code)` sont ignorés silencieusement). Cumul par `+` sur des
    chaînes (`totf!totald + montantd`) : conversion implicite, à confirmer pour les montants
    décimaux.
  - Remplit `Colbl` depuis `SELECT * FROM Facturefm ORDER BY nom`.
- **`Colbl_Click()`** [handler, `replay_dynamic` : doit rester `Public`] [nature : mixte]
  (l. 156-184). `SELECT * FROM Detail WHERE code = &1 ORDER BY num` (arguments `&2`, `&3`
  inutilisés) et remplit `Coldetail`. ⚠️ l. 178 : `Coldetail.Item[7] = lind` alors que la grille n'a
  que 7 colonnes (0 à 6) ; erreur d'indice probable (à confirmer sous gb.qt), ce qui interromprait
  le remplissage dès la première ligne et priverait la suppression de son `lind`.
- **`Coldetail_Keypress()`** [handler] [nature : mixte] (l. 186-214). Sur Suppr et confirmation :
  - `DELETE FROM Detail WHERE numfac = &1 AND numlot = &2` ;
  - `DELETE FROM Fiches_Mvt WHERE lind = &1` (**une seule ligne** d'écriture supprimée, sans
    contrôle `validee`/`cloturee`, sans la contrepartie banque/caisse : écriture déséquilibrée) ;
  - boucle `SELECT … WHERE numlot = &1` puis, **à chaque ligne**, le même
    `UPDATE Fiches_Mvt SET lettree = 0 WHERE numlot = &2` (N fois la même requête) ;
  - `Calc_solde` du client seulement (pas du compte de trésorerie), puis rechargement complet
    (`recup_bl` recrée les tables).
- **`Calc_solde(Nmcompte)`** [portée : réductible] [nature : calcul] (l. 216-241). Somme
  débit − crédit des écritures validées de `Cbase.Table("TabMvt")` pour le compte, puis
  `UPdate Cbase.Table("TabComptes") SET solde`. Même algorithme que
  [`Csolde.Solde_caisse`](../../../Utils/Csolde.module/architecture.md) (qui utilise les noms en dur)
  et copie exacte de `TresorFac.Calc_solde`.
- **`Button2_Click()`** [handler] [GUI] : ferme. **`Button1_Click()`** [handler] [GUI] :
  `Doc.Open("Visreglements")`.

## État global utilisé

- `Utils.db`, `Utils.Coulfd`, `Utils.FColr`, `Utils.Observers`, `Utils.Cdate_Aff`,
  `Utils.PointBase`, `Cbase.Table` (`TabMvt`, `TabComptes`), `Start.LocalSettings["/Coul/Fnets"]`,
  `Start.Musique`, `Doc`.
- Tables : `Fiches_Parametres`, `Fiches_Mvt` (lecture, suppression, mise à jour `lettree`),
  `Fiches_Cli`, `Fiches_Comptes` (solde), tables de travail `Facturefm` et `Detail` (DROP/CREATE).

## Propositions d'amélioration

### Réécriture / refactorisation

- La recommandation principale est la **suppression** du couple `.class` + `.form`
  (VISREGLEMENTS-A01). Les reworks ci-dessous ne valent que si l'utilisateur la refuse.
- Remplacer la boucle de `Coldetail_Keypress` par un seul `UPDATE` (SQL modifié, dump identique).
- Supprimer les lectures inutiles de `Form_Open` (`rResult`, `Coulfond`, `Frmt`) et les arguments
  SQL superflus.

### Commonalisation avec d'autres fichiers

- `Calc_solde` → [`Csolde.Solde_caisse`](../../../Utils/Csolde.module/architecture.md) ; même
  copie dans [`TresorFac`](../TresorFac.class/architecture.md) et
  [`ClotureF`](../../ClotureF.class/architecture.md).
- 90 % du code est commun avec
  [`Visimpayes`](../../../Compta/Lettrages/Visimpayes.class/architecture.md) (même `recup_bl`,
  mêmes tables de travail) : sans objet si les deux couples morts sont supprimés.

### Réduction de portée

- `recup_bl`, `Calc_solde` → `Private` (aucun appelant). Handlers inchangés (`Colbl_Click` est
  rejoué par `ReplayObserver` via `Object.Call`).

### Séparation traitement / GUI

- Extraire `ChargeReglements()` (DDL + agrégation SQL, sans contrôle) et
  `SupprimeReglement(numfac, numlot, lind, compte)` ; les handlers gardent la confirmation et le
  remplissage des grilles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables de travail `Facturefm`/`Detail` créées à l'exécution devraient être des tables
  temporaires (`CREATE TEMPORARY TABLE`) ou des requêtes agrégées (`GROUP BY compte`) : aucune
  structure persistante n'est nécessaire.
