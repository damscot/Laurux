# Histocliart — Rework

> Source : `.src/Statistiques/Histocliart.class` · Message de commit (phase 4) : `reference/.src/Statistiques/Histocliart.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 836 |
| Lignes de commentaire | 67 |
| Fonctions | 26 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 245 |
| Complexité max (fonction) | 141 (`crearequ`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 836 | 245 | 141 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] HISTOCLIART-001 — [documentation] En-tête en français : rôle, critères, sources et forme de la
  requête générée (colonnes communes, tickets exclusifs), sorties PDF/CSV, contrat `Bsel`/`Bval` avec
  `TriCpt`/`TriArticles` · appelants : aucun · tests : aucun · sources : [Histocliart.class:_New](../../../../.src/Statistiques/Histocliart.class#L44-L82), [Histocliart.class:crearequ](../../../../.src/Statistiques/Histocliart.class#L316-L666)
- [ ] HISTOCLIART-002 — [code mort] Supprimer `Cclient` (jamais lu ni écrit), `Coulfond`, `Frmt`,
  `PosY`, `PosX`, le membre `Filename` masqué dans `edition`, les variables locales inutilisées et le
  code commenté de `_New` · appelants : aucun · tests : T01, T02 · sources : [Histocliart.class:34](../../../../.src/Statistiques/Histocliart.class#L34), [Histocliart.class:_New](../../../../.src/Statistiques/Histocliart.class#L44-L82), [Histocliart.class:edition](../../../../.src/Statistiques/Histocliart.class#L681-L806)
- [ ] HISTOCLIART-003 — [complexité] `crearequ` : description des 5 sources (tables, préfixe, colonne
  de date) et helpers privés `SousRequete(…)` / `FiltresCommuns(…)` ; **texte SQL identique**
  (comparaison bloquante des lignes `Exec_SQL`), défauts actuels reproduits (`UNION ALL` manquant,
  `=` de la branche tickets sur `TextArea1`) (CC 141 → ≤ 20 visé) · appelants : aucun · tests :
  T01-T08 · sources : [Histocliart.class:crearequ](../../../../.src/Statistiques/Histocliart.class#L316-L666)
- [ ] HISTOCLIART-004 — [séparation traitement/GUI] `ConstruitRequete(c As Collection) As String`
  pure + `LitCriteres() As Collection` (lecture des contrôles) ; `crearequ` garde le curseur, le
  message et l'exécution · appelants : aucun · tests : T01-T08, T11 · sources : [Histocliart.class:crearequ](../../../../.src/Statistiques/Histocliart.class#L316-L666)
- [ ] HISTOCLIART-005 — [commonalisation] Noms de tables via `Cbase.Table` dans `crearequ`,
  `Cli_man`, `Buttype_Click`, `btn_Click`, `attribres`, `attrires1` (texte SQL identique, colonnes
  qualifiées comprises) · appelants : aucun · tests : T01-T07 · sources : [Histocliart.class:Cli_man](../../../../.src/Statistiques/Histocliart.class#L124-L151), [Histocliart.class:Buttype_Click](../../../../.src/Statistiques/Histocliart.class#L232-L251), [Histocliart.class:btn_Click](../../../../.src/Statistiques/Histocliart.class#L261-L287), [Histocliart.class:attribres](../../../../.src/Statistiques/Histocliart.class#L892-L907)
- [ ] HISTOCLIART-006 — [séparation traitement/GUI] `Butexp_Click` : `EcritCsv(res, mode, chemin)`
  sans accès aux contrôles ; le handler garde la question et l'ouverture · appelants : aucun · tests :
  T01, T03 · sources : [Histocliart.class:Butexp_Click](../../../../.src/Statistiques/Histocliart.class#L958-L987)
- [ ] HISTOCLIART-007 — [complexité] `Butcli_Click`/`Butcli2_Click`/`butfour_click` → helper privé
  `ChoisitTiers(type, zone, suivante, bRaz)` (`bRaz` conserve l'absence de remise à zéro de `Bsel`
  dans `Butcli2`/`butfour`) · appelants : aucun · tests : T09 · sources : [Histocliart.class:Butcli_Click](../../../../.src/Statistiques/Histocliart.class#L154-L168), [Histocliart.class:Butcli2_Click](../../../../.src/Statistiques/Histocliart.class#L170-L183), [Histocliart.class:butfour_click](../../../../.src/Statistiques/Histocliart.class#L209-L230)
- [ ] HISTOCLIART-008 — [réduction de portée] `Cli_man` → `Private` (appelée seulement dans le
  fichier) ; `Bsel`/`Bval` restent `Public` (écrits par `Object.SetProperty`) · appelants : aucun ·
  tests : T09 · sources : [Histocliart.class:Cli_man](../../../../.src/Statistiques/Histocliart.class#L124-L151)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] HISTOCLIART-A01 — [anomalie] `UNION ALL` manquant : seules les branches BL positionnent `un` ;
  factures + factures matériel sans document en cours produisent deux `SELECT` collés (SQL invalide),
  dans les trois modes · tests : T05 · sources : [Histocliart.class:405](../../../../.src/Statistiques/Histocliart.class#L405), [Histocliart.class:422](../../../../.src/Statistiques/Histocliart.class#L422), [Histocliart.class:507](../../../../.src/Statistiques/Histocliart.class#L507), [Histocliart.class:524](../../../../.src/Statistiques/Histocliart.class#L524), [Histocliart.class:609](../../../../.src/Statistiques/Histocliart.class#L609), [Histocliart.class:626](../../../../.src/Statistiques/Histocliart.class#L626)
- [ ] HISTOCLIART-A02 — [anomalie] Familles : `Checktfam` décochée sans nœud sélectionné →
  `Utils.fam` renvoie `" AND champ IN)"` (SQL invalide, UTILS-A02 ; à corriger dans `Utils` ou à
  contrôler ici avec un message) · tests : T08 · sources : [Histocliart.class:369](../../../../.src/Statistiques/Histocliart.class#L369), [Utils.module:fam](../../../../.src/Utils/Utils.module#L1439-L1452)
- [ ] HISTOCLIART-A03 — [anomalie] `Cli_man` contrôle toujours `Cli.Text`, même pour `Cli2` : le code
  de fin n'est jamais vérifié · tests : T09 · sources : [Histocliart.class:128](../../../../.src/Statistiques/Histocliart.class#L128)
- [ ] HISTOCLIART-A04 — [anomalie] `Butcli2_Click` et `butfour_click` ne remettent pas `Bsel` à
  `False` : après une sélection précédente, une annulation de `TriCpt` réécrit l'ancienne valeur ·
  tests : T09 · sources : [Histocliart.class:Butcli2_Click](../../../../.src/Statistiques/Histocliart.class#L170-L183), [Histocliart.class:butfour_click](../../../../.src/Statistiques/Histocliart.class#L209-L230)
- [ ] HISTOCLIART-A05 — [anomalie] `Butexp_Click` ne vérifie ni le nombre de sources (`nbfic`) ni
  `$res.Available` : aucune source → SQL `FROM ( ) AS a` invalide ; résultat vide → erreur à la lecture
  de `$res` ; `Butedit` sans résultat ne dit rien · tests : T10 · sources : [Histocliart.class:962](../../../../.src/Statistiques/Histocliart.class#L962), [Histocliart.class:968](../../../../.src/Statistiques/Histocliart.class#L968), [Histocliart.class:312](../../../../.src/Statistiques/Histocliart.class#L312)
- [ ] HISTOCLIART-A06 — [anomalie] Édition détaillée : pas d'`ORDER BY`, les sous-totaux supposent
  l'ordre implicite du `GROUP BY` (non garanti selon le moteur) ; les lignes dont le libellé est
  introuvable (client ou article supprimé) sont sautées et manquent dans les totaux · tests : T02 ·
  sources : [Histocliart.class:444](../../../../.src/Statistiques/Histocliart.class#L444), [Histocliart.class:763](../../../../.src/Statistiques/Histocliart.class#L763)
- [ ] HISTOCLIART-A07 — [anomalie] Détails visibles : titre « des famille par article » inversé pour
  le mode famille, couleur du titre fausse si une composante `Start.R/G/B` < 16 (hexadécimal non
  complété), `Mouse.Normal` à confirmer (constante absente ailleurs dans le projet) · tests : T02 ·
  sources : [Histocliart.class:707](../../../../.src/Statistiques/Histocliart.class#L707), [Histocliart.class:698](../../../../.src/Statistiques/Histocliart.class#L698), [Histocliart.class:662](../../../../.src/Statistiques/Histocliart.class#L662)
