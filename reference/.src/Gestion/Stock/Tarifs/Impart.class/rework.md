# Impart — Rework

> Source : `.src/Gestion/Stock/Tarifs/Impart.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/Impart.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1647 |
| Lignes de commentaire | 93 |
| Fonctions | 48 |
| Fonctions Public | 48 |
| Complexité cyclomatique totale | 548 |
| Complexité max (fonction) | 186 (`Import`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1647 | 548 | 186 | 0 | 48 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPART-001 — [documentation] En-tête de classe en français : options et traitement associé,
  formats `S`/`F`, numéros de champs 1 à 31 (table de correspondance), fichiers de compte rendu ;
  commentaires `'''` sur `Import` et les `Maj_*` · appelants : aucun · tests : T01-T08 · sources : [Impart.class:Import](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L889-L1327), [Impart.class:rechercheKey](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1742-L1847)
- [ ] IMPART-002 — [code mort] Supprimer `Controle`, `InitCode`, `TrC`, `Calc_Marge` (résultats
  jamais lus) et les variables `Ecotaxe`, `Tvavente`, `Derart`, `PHTn`, `Divers`, `Margem`,
  `Margep`, `Pmp`, `Stocke`, `stck`, tableaux `db_`, `lg_`, `pos_`, `porg_`, double calcul de `Prvt`
  (sans changement SQL ; `Button4_MouseDown` conservé, handler) · appelants : aucun · tests : T01-T03 · sources : [Impart.class:Controle](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L604-L606), [Impart.class:InitCode](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1365-L1371), [Impart.class:TrC](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1473-L1491), [Impart.class:Calc_Marge](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1546-L1559), [Impart.class:ChargementFichierDef](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1708-L1740)
- [ ] IMPART-003 — [réduction de portée] `FamMan`, `fourMan`, `Fam2`, `Maj_Equ`, `Maj_Divers`,
  `Maj_Centrale`, `Maj_Ref_fournisseur`, `Import`, `Maj_Etiqp`, `Maj_Etiqg`, `Initialisation`,
  `prix_base`, `Prix_achat`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `ChargementFichierDef`,
  `rechercheKey` → `Private` (couverts par T01-T08) · appelants : aucun · tests : T01-T08 · sources : [Impart.class:Import](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L889-L1327), [Impart.class:rechercheKey](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1742-L1847)
- [ ] IMPART-004 — [complexité] Découpage d'`Import` (CC 186) en `LitLigne`, `ChercheArticle`,
  `CreeArticle`, `MajArticle`, `EcritCompteRendu`, et fonction unique `AffecteChamp(iChamp, sValeur,
  bFixe)` pour les deux `Select Case` 1-31 (différences du mode fixe en paramètre) ; même ordre de
  requêtes · appelants : aucun · tests : T01-T05, T11 · sources : [Impart.class:Import](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L889-L1327), [Impart.class:rechercheKey](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1742-L1847)
- [ ] IMPART-005 — [commonalisation] Listes famille/fournisseur/définition et chargement de la
  définition via la classe `LImpDef` partagée avec `ImpartParam` (IMPARTPARAM-005) ; `FamMan` et
  `Fam2` fusionnées · appelants : aucun · tests : T01, T03, IMPARTPARAM-T06 · sources : [Impart.class:DefList_Click](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1670-L1706), [Impart.class:FamMan](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L243-L278), [Impart.class:Fam2](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L379-L414), [ImpartParam.class:affiche_Selection](../../../../../../.src/Gestion/Stock/Tarifs/ImpartParam.class#L271-L330)
- [ ] IMPART-006 — [complexité] `SELECT` de la définition sorti des boucles de lecture dans
  `Import`, `Maj_Equ`, `Maj_Divers`, `Maj_Centrale`, `Maj_Ref_fournisseur` (SQL modifié : une
  requête par import au lieu d'une par ligne, dump identique) · appelants : aucun · tests : T01,
  T06-T08 · sources : [Impart.class:Maj_Equ](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L608-L703), [Impart.class:Maj_Divers](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L705-L765), [Impart.class:Maj_Centrale](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L767-L829), [Impart.class:Maj_Ref_fournisseur](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L831-L887)
- [ ] IMPART-007 — [commonalisation] `PvTTC_arrondi` → `ArrondiPvTTC` (ARTICLES-012, après
  comparaison) ; `Maj_Etiqp`/`Maj_Etiqg` → module `EtiqMaj` (MAJFBTARIF2-005) ; garde d'export →
  `Serveur.Actif` (SERVEUR-008) · appelants : aucun · tests : T01, T05 · sources : [Impart.class:PvTTC_arrondi](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1574-L1611), [Impart.class:Maj_Etiqp](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1330-L1346), [Impart.class:Maj_Etiqg](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1349-L1363)
- [ ] IMPART-008 — [séparation traitement/GUI] Lecture unique des options et champs de l'écran
  dans une structure passée aux fonctions de traitement (`Import`, `prix_base`, `Prix_achat`,
  `Maj_*`), `Message.*` restant dans les handlers · appelants : aucun · tests : T01-T08 · sources : [Impart.class:Import](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L889-L1327), [Impart.class:prix_base](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1430-L1468), [Impart.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L523-L602)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPART-A01 — [anomalie] **Boucle infinie** : `Type_Champs` n'est affecté que par
  `DefList_Click` ; avec une définition saisie au clavier, `Import` boucle sur `While Not Eof`
  sans lire de ligne (application figée) · tests : T09 · sources : [Impart.class:941](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L941), [Impart.class:Cmpt_KeyPress](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L112-L188), [Impart.class:DefList_Click](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1670-L1706)
- [ ] IMPART-A02 — [anomalie] Contrôle « référence fournisseur déjà utilisée » fait sur
  `art_code = FourImport` (code fournisseur) : si un article a ce code, aucune ligne n'est importée ·
  tests : T10 · sources : [Impart.class:1173](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1173)
- [ ] IMPART-A03 — [anomalie] `Button2_Click` : fichier non saisi → avertissement mais l'import
  est lancé quand même · tests : T13 · sources : [Impart.class:553](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L553)
- [ ] IMPART-A04 — [anomalie] `MajEqu.Maj(Cequ, art_code)` : arguments inversés (signature
  `Maj(code, cequ)`) ; `art_cequ` de l'article équivalent écrasé, export inversé · tests : T05 ·
  sources : [Impart.class:1290](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1290), [MajEqu.module:Maj](../../../../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L3-L43)
- [ ] IMPART-A05 — [anomalie] `arr` remis à `""` et jamais affecté : le PV TTC importé n'est
  jamais arrondi selon l'arrondi de l'article · tests : T01 · sources : [Impart.class:PvTTC_arrondi](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1574-L1611), [Impart.class:1404](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1404)
- [ ] IMPART-A06 — [anomalie] État résiduel entre lignes : `Initialisation` ne réinitialise ni
  `remise2-4`, `Intitule2`, `CodeA`, `Codecentrale`, `FamImport`, `FourImport`, `$cond`, `$unite`,
  `$ua`, ni `Maj` ; `prix_base` garde `IsNull(remise2)` pour `remise3`/`remise4` (IMPART-A11
  regroupée ici) · tests : T11 · sources : [Impart.class:Initialisation](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1388-L1425), [Impart.class:1443](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1443), [Impart.class:1444](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1444)
- [ ] IMPART-A07 — [anomalie] Ligne courte : `Lig2[n - 1]` hors bornes sans `Try` (`rechercheKey`,
  `Maj_Centrale`, `Maj_Ref_fournisseur`) → erreur non interceptée ; fichier jamais fermé dans les
  quatre `Maj_*` · tests : T11 · sources : [Impart.class:1749](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1749), [Impart.class:796](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L796), [Impart.class:860](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L860)
- [ ] IMPART-A08 — [anomalie] Création : `INSERT` sous `Try` sans compte rendu en cas d'échec ;
  `dnart` non mis à jour, codes générés par `Next_Code` sans contrôle d'existence (second import :
  articles non créés, silencieusement) · tests : T02, T12 · sources : [Impart.class:1218](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1218), [Impart.class:565](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L565)
- [ ] IMPART-A09 — [anomalie] Champs 17 (copie privée) et 18 (écotaxe) lus mais jamais enregistrés ;
  option `Remfam` sans effet ; coefficient enregistré à la création = `Coef.Text` et non le
  coefficient calculé · tests : T02 · sources : [Impart.class:1035](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1035), [Impart.class:1039](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1039), [Impart.class:1218](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1218)
- [ ] IMPART-A10 — [anomalie] Comptes rendus ouverts dans `~/tmp` hors `Try` : erreur non
  interceptée si le répertoire n'existe pas · tests : T13 · sources : [Impart.class:922](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L922), [Impart.class:923](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L923)
- [ ] IMPART-A12 — [anomalie] `Utils.Observers(Me)` appelé deux fois dans `Form_Open`
  (observateurs cumulés pour le log/replay) · tests : T01 · sources : [Impart.class:93](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L93), [Impart.class:97](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L97)
- [ ] IMPART-A13 — [anomalie] SQL concaténé : filtres `left(code_fam, 'n') = '<saisie>'` et
  `left(fo_code, …)` (apostrophe dans la saisie → erreur SQL) ; fichier lu sans conversion
  d'encodage · tests : T14 · sources : [Impart.class:319](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L319), [Impart.class:437](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L437), [Impart.class:1699](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1699)
- [ ] IMPART-A14 — [anomalie] `MajPrix` remet `art_pbfbt`/`art_datefbt` à `''` (au lieu de `NULL`),
  ce qui expose ces articles à MAJFBTARIF2-A01 (date vide) · tests : T01 · sources : [Impart.class:1259](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1259)
