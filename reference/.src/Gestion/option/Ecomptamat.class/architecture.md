# Ecomptamat — Architecture

> Source : `.src/Gestion/option/Ecomptamat.class` (+ `Ecomptamat.report`)

## Vue d'ensemble

**État `gb.report`** de la déclaration mensuelle de la comptabilité matières (option boissons)
pour les régies en **régime suspendu** (entrepositaire agréé). Il est instancié par
[Caleditcmat](../Caleditcmat.class/architecture.md)`.Edit` (`Caleditcmat.class:427`,
`New Ecomptamat(tabl, mois, annee, False)`) quand l'option « Suspendu » est choisie ; la variante
« Acquitté » est [Einvmat](../Einvmat.class/architecture.md).

Par rapport à Einvmat, il ajoute : la plage des **numéros de vignette** du mois, les quantités
imposables, le tarif et le montant des **droits** par régie, la section **Sécurité sociale**
(volume, tarif, montant) et le montant total à payer.

**Ce fichier n'écrit rien** : ni `Fiches_ligregie`, ni écriture comptable (`Fiches_Mvt*`). Ce
n'est donc **pas** un module complexe au sens du plan ; les écritures de la clôture matières
(`UPDATE cloture`, lignes de stock `M`) sont faites par Caleditcmat, classé module complexe.
Aucune table `*M` du matériel n'est concernée (« mat » = matières).

Tables lues : `Fiches_Societes`, `Fiches_Parametres`, `Fiches_ligregie` (vignettes),
`Fiches_regie` (libellés).

Nature : **GUI** (report) avec un calcul de formatage (`convers`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$resreg` | var | Private |  | Result | 3 |
| `$snumed` | var | Private |  | String[] | 4 |
| `$tabl` | var | Private |  | Collection | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-60 | Public | 4 | 43 | 0 | méthode spéciale |
| `lib_Data` | 62-69 | Public | 1 | 5 | 0 | handler GUI |
| `vaehldp_Data` | 72-77 | Public | 1 | 4 | 0 | handler GUI |
| `vaeldp_Data` | 79-84 | Public | 1 | 4 | 0 | handler GUI |
| `vaecldp_Data` | 86-91 | Public | 1 | 4 | 0 | handler GUI |
| `vaehle_Data` | 94-99 | Public | 1 | 4 | 0 | handler GUI |
| `vaele_Data` | 101-106 | Public | 1 | 4 | 0 | handler GUI |
| `vaecle_Data` | 108-113 | Public | 1 | 4 | 0 | handler GUI |
| `vaehls_Data` | 116-121 | Public | 1 | 4 | 0 | handler GUI |
| `vaels_Data` | 123-128 | Public | 1 | 4 | 0 | handler GUI |
| `vaecls_Data` | 130-135 | Public | 1 | 4 | 0 | handler GUI |
| `vaehlfp_Data` | 138-143 | Public | 1 | 4 | 0 | handler GUI |
| `vaelfp_Data` | 145-150 | Public | 1 | 4 | 0 | handler GUI |
| `vaeclfp_Data` | 152-157 | Public | 1 | 4 | 0 | handler GUI |
| `vaphldp_Data` | 160-165 | Public | 1 | 4 | 0 | handler GUI |
| `vapldp_Data` | 167-172 | Public | 1 | 4 | 0 | handler GUI |
| `vapcldp_Data` | 174-179 | Public | 1 | 4 | 0 | handler GUI |
| `vaphle_Data` | 182-187 | Public | 1 | 4 | 0 | handler GUI |
| `vaple_Data` | 189-194 | Public | 1 | 4 | 0 | handler GUI |
| `vapcle_Data` | 196-201 | Public | 1 | 4 | 0 | handler GUI |
| `vaphls_Data` | 204-209 | Public | 1 | 4 | 0 | handler GUI |
| `vapls_Data` | 211-216 | Public | 1 | 4 | 0 | handler GUI |
| `vapcls_Data` | 218-223 | Public | 1 | 4 | 0 | handler GUI |
| `vaphlfp_Data` | 226-231 | Public | 1 | 4 | 0 | handler GUI |
| `vaplfp_Data` | 233-238 | Public | 1 | 4 | 0 | handler GUI |
| `vapclfp_Data` | 240-245 | Public | 1 | 4 | 0 | handler GUI |
| `qihl_Data` | 247-252 | Public | 1 | 4 | 0 | handler GUI |
| `qil_Data` | 254-259 | Public | 1 | 4 | 0 | handler GUI |
| `qicl_Data` | 261-266 | Public | 1 | 4 | 0 | handler GUI |
| `tarif_Data` | 268-273 | Public | 1 | 4 | 0 | handler GUI |
| `montant_Data` | 275-280 | Public | 1 | 4 | 0 | handler GUI |
| `ReportLlibss_Data` | 282-287 | Public | 2 | 3 | 0 | handler GUI |
| `qihlss_Data` | 289-294 | Public | 1 | 4 | 0 | handler GUI |
| `qilss_Data` | 296-301 | Public | 1 | 4 | 0 | handler GUI |
| `qiclss_Data` | 303-308 | Public | 1 | 4 | 0 | handler GUI |
| `tarifss_Data` | 310-315 | Public | 1 | 4 | 0 | handler GUI |
| `montss_Data` | 317-322 | Public | 1 | 4 | 0 | handler GUI |
| `vaehldp2_Data` | 324-337 | Public | 2 | 10 | 0 | handler GUI |
| `vaehle2_Data` | 339-352 | Public | 2 | 10 | 0 | handler GUI |
| `vaehls2_Data` | 354-367 | Public | 2 | 10 | 0 | handler GUI |
| `vaehlfp2_Data` | 369-382 | Public | 2 | 10 | 0 | handler GUI |
| `vaphldp2_Data` | 384-397 | Public | 2 | 10 | 0 | handler GUI |
| `vaphle2_Data` | 399-412 | Public | 2 | 10 | 0 | handler GUI |
| `vaphls2_Data` | 414-427 | Public | 2 | 10 | 0 | handler GUI |
| `vaphlfp2_Data` | 429-442 | Public | 2 | 10 | 0 | handler GUI |
| `montant2_Data` | 444-454 | Public | 2 | 8 | 0 | handler GUI |
| `convers` | 456-483 | Private | 6 | 26 | 0 |  |
| `ni_Data` | 485-489 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(tabl, mois, anne, edit)`** [portée : nécessaire (constructeur, appelé par Caleditcmat)]
  [nature : mixte] : identique à `Einvmat._new` (clés de `tabl`, `DataCount` de `ReportHlig` **et**
  de `ReportHBox14` (sécurité sociale), dates, `Fiches_Societes` **sans `WHERE`**, exercice depuis
  `arrete`, adresse, période), plus la plage de vignettes :
  `SELECT vignette FROM Fiches_ligregie WHERE dtmouv BETWEEN &1 AND &2 AND cloture=&3 AND vignette
  IS NOT NULL ORDER BY vignette` avec `cloture = edit`. Caleditcmat passe **toujours `False`** :
  en réédition d'un mois clôturé (`Redition_Click`, lignes `cloture = True`), la plage est vide
  ou fausse (CALEDITCMAT-A05). Aucun filtre de régime ni de type : les vignettes des entrées et
  des régies acquittées du mois sont comprises ; une vignette `''` (« mise à blanc » par
  `atribvignette`) peut apparaître en premier (ECOMPTAMAT-A02). `i` et `$resreg` inutilisés.
  Termine par `Application.Busy = 0`.
- **`lib_Data`** : libellé de la régie (`Fiches_regie`).
- **24 handlers `va{e,p}{h,l,c}l{dp,e,s,fp}_Data`** : copies conformes de ceux d'Einvmat (écrivent
  `Caleditcmat.ddcl`, puis `convers`).
- **`qihl_Data`/`qil_Data`/`qicl_Data`** : quantité imposable (`qteimp`) en hl/l/cl ;
  **`tarif_Data`** (`tarifdr`, 4 décimales) ; **`montant_Data`** (`droit`, 2 décimales).
- **`ReportLlibss_Data`** : libellé « Sécurité Sociale (taux en litre) » sur la première ligne
  seulement.
- **`qihlss_Data`/`qilss_Data`/`qiclss_Data`/`tarifss_Data`/`montss_Data`** : volume, tarif et
  montant de la sécurité sociale.
- **8 handlers `*2_Data`** de totaux (comme Einvmat) et **`montant2_Data`** : somme
  `droit + secu` de toutes les régies.
- **`convers(vol, choix)`** [Private] [nature : calcul] : comme Einvmat, mais avec
  `Round(vol, -2)` **avant** le découpage hl/l/cl (cohérent aux arrondis). Même perte de signe
  sur les litres d'un volume ≤ -100 (ECOMPTAMAT-A03).
- **`ni_Data(Index)`** : vide. Le contrôle `ni` (n° d'identification) est hors de toute boîte à
  `DataCount` ; on ignore si `gb.report` lève `Data` pour lui et, s'il le fait, si un handler qui
  ne renseigne pas `.Data` efface le texte posé dans `_new` (ECOMPTAMAT-A01, à confirmer).

`deps.py` signale les 46 handlers `*_Data` comme `unused`/`scope_reducible` et `convers` comme
`unused_transitive` : **faux positifs** (contrôles déclarés dans `Ecomptamat.report`, non analysé).

## État global utilisé

- `Caleditcmat.ddcl` (écrit par chaque handler de cellule).
- `Application.Busy` (mis à 0), `Utils.db.Exec`, `Utils.lastday`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Variable locale au lieu de `Caleditcmat.ddcl` (comme EINVMAT-002).
- Handlers de cellule réduits à un appel générique (`Cellule`, `Total`).
- Supprimer `i`, `$resreg` et les lignes commentées (`ReportHss.DataCount`, `pg1`,
  `ReportPageBreak1`, bordure de `ReportLlibss`).

### Commonalisation avec d'autres fichiers

- **[Einvmat](../Einvmat.class/architecture.md)** : ~280 lignes communes (`_new`, 32 handlers,
  `convers`) → module commun de l'option (voir EINVMAT-004) avec
  `Convers(vol, choix, arrondiInitial = True)` pour Ecomptamat.
- **En-tête société** : `Creleve.EnteteSociete`, proposé dans
  [Ligcli](../../../Compta/Relances/Ligcli.class/architecture.md).
- **Plage de vignettes** : fonction `PlageVignettes(debut, fin, cloture) As String` à placer avec
  les fonctions de vignette d'[atribvignette](../atribvignette.class/architecture.md)
  (`FormatVignette`).

### Réduction de portée

Rien à réduire (constructeur et handlers du report).

### Séparation traitement / GUI

`convers` et `PlageVignettes` deviennent des fonctions pures testables dans le module commun.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Vignette numérique (voir atribvignette) : `MIN`/`MAX` en SQL au lieu du tri complet.
- `Fiches_Parametres.arrete` en `DATE`.
