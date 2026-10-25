# VarMajTar — Rework

> Source : `.src/Gestion/Stock/VarMajTar.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/VarMajTar.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 137 |
| Lignes de commentaire | 3 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 15 (`LecArt`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 137 | 36 | 15 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VARMAJTAR-001 — [documentation] En-tête de classe en français : rôle (état tarifaire d'une
  ligne d'achat rangé dans `Sailig.AutresObj[Achat.Tarif]`), contenu des collections `TarGen`/
  `TarCli`/`TarTcli` et de leurs clés `sup`/`modif`, dépendance aux requêtes préparées de
  `commande1`, et mention explicite que `Delete` (appelée par `Sailig.Delete`) et `SauvColl`
  (appelée par `GesTar.class:230`) sont des appels dynamiques signalés `unused` à tort ·
  appelants : aucun · tests : T01, T07 · sources : [VarMajTar.class:LecArt](../../../../../.src/Gestion/Stock/VarMajTar.class#L33-L87), [VarMajTar.class:Delete](../../../../../.src/Gestion/Stock/VarMajTar.class#L25-L31), [VarMajTar.class:SauvColl](../../../../../.src/Gestion/Stock/VarMajTar.class#L146-L152)
- [ ] VARMAJTAR-002 — [code mort] Supprimer les variables locales inutilisées (`res1`, `req`,
  `obs` dans `LecArt`, `obs` dans `constructiontableau`) et les lignes commentées 45 et 107
  (sans changement SQL) · appelants : aucun · tests : T01, T02 · sources : [VarMajTar.class:LecArt](../../../../../.src/Gestion/Stock/VarMajTar.class#L33-L87), [VarMajTar.class:constructiontableau](../../../../../.src/Gestion/Stock/VarMajTar.class#L89-L143)
- [ ] VARMAJTAR-003 — [commonalisation] Cascade de prix de `constructiontableau` (lignes 123-137)
  remplacée par la fabrique `PrixVente` (GESTAR-008) **après** preuve d'équivalence par gb.test
  (T03, même jeu que GESTAR-T05 et DATETAR-T05) ; même lot que GESTAR-008, DATETAR-005 et
  TARTYPECLI-007 · appelants : aucun · tests : T02, T03 · sources : [VarMajTar.class:constructiontableau](../../../../../.src/Gestion/Stock/VarMajTar.class#L89-L143), [GesTar.class:Coef_lostfocus](../../../../../.src/Gestion/Entrées/GesTar.class#L270-L293)
- [ ] VARMAJTAR-004 — [complexité] `LecArt` : extraire la construction de `TarGen[i]` dans une
  fonction privée `ConstruitTarGen(targ, i)` et la mise en forme de la marge dans
  `MargeTexte(coef)` (4 occurrences, partagée avec `constructiontableau`) ; CC 15 → ≤ 8 visé ·
  appelants : aucun · tests : T01, T02 · sources : [VarMajTar.class:LecArt](../../../../../.src/Gestion/Stock/VarMajTar.class#L33-L87), [VarMajTar.class:constructiontableau](../../../../../.src/Gestion/Stock/VarMajTar.class#L89-L143)
- [ ] VARMAJTAR-005 — [complexité] Noms de tables `Fiches_Art`/`Fiches_Tvaav` de `LecArt` via
  `Cbase.Table("TabArt")`/`Cbase.Table("TabTvav")` (même SQL émis, dump identique) ·
  appelants : aucun · tests : T01 · sources : [VarMajTar.class:46](../../../../../.src/Gestion/Stock/VarMajTar.class#L46)
- [ ] VARMAJTAR-006 — [séparation traitement/GUI] `LecArt` lit `Code` et `Px_Rev` sur la ligne
  puis délègue à une fonction privée `LecArtCode(sCode, fPxRev, targ, tarc, tart)` sans accès aux
  contrôles (signature publique de `LecArt` inchangée) · appelants : aucun (`GesTar` inchangé) ·
  tests : T01, T02 · sources : [VarMajTar.class:LecArt](../../../../../.src/Gestion/Stock/VarMajTar.class#L33-L87)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VARMAJTAR-A01 — [anomalie] `constructiontableau` : le drapeau `sup` d'un tarif client ou
  type de client prend `$resart!temp_sup` (tarif général) au lieu de `res!temp_sup` dès que ce
  dernier n'est pas nul ; une ligne provisoire peut être supprimée ou conservée à tort lors de
  l'enregistrement par `GesTar` · tests : T05 · sources : [VarMajTar.class:121](../../../../../.src/Gestion/Stock/VarMajTar.class#L121)
- [ ] VARMAJTAR-A02 — [anomalie] SQLite : `LecArt` appelle `Utils.db.Execute("requ_cli"/"requ_typ")`,
  cassé sous SQLite (DB_CONNECTION-A05) ; le panneau tarif des achats échoue. La correction se
  fait dans `DB_Connection.Execute` ; ce fichier doit seulement être retesté · tests : T06 ·
  sources : [VarMajTar.class:79](../../../../../.src/Gestion/Stock/VarMajTar.class#L79), [VarMajTar.class:82](../../../../../.src/Gestion/Stock/VarMajTar.class#L82), [DB_Connection.class:Execute](../../../../../.src/Utils/DB_Connection.class#L508-L519)
- [ ] VARMAJTAR-A03 — [anomalie] Marge négative (`coef < 1`) : la remise passée à `LTaxe` vaut
  `"-" & "-5%"` = `"--5%"` ; résultat à confirmer par T04 (valeur nulle ou erreur probable) ·
  tests : T04 · sources : [VarMajTar.class:124](../../../../../.src/Gestion/Stock/VarMajTar.class#L124), [VarMajTar.class:132](../../../../../.src/Gestion/Stock/VarMajTar.class#L132)
