# Fcaisses — Rework

> Source : `.src/Caisse/Fcaisses.class` · Message de commit (phase 4) : `reference/.src/Caisse/Fcaisses.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 293 |
| Lignes de commentaire | 35 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 26 (`Cais_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 293 | 122 | 26 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCAISSES-001 — [documentation] En-tête en français : champs d'une caisse, règles
  Monoposte/Réseau, conditions de suppression, stockage des champs cachés dans `Item[2..7]`, case
  « école » invisible · appelants : aucun · tests : T01-T07 · sources : [Fcaisses.class:_New](../../../../.src/Caisse/Fcaisses.class#L29-L43), [Fcaisses.class:Form_Open](../../../../.src/Caisse/Fcaisses.class#L45-L77)
- [ ] FCAISSES-002 — [code mort] Supprimer le `Case 6` de `Cais_KeyPress` (aucun contrôle de tag
  6 dans le groupe `Cais`), les variables `Tab2…Tab5` de `Button3_Click`, le `With Utils` inutile
  de `Maj_Zones`/`Button1_Click`, et le test `If Not rResult!ecole` redondant (toujours vrai à cet
  endroit) ; le membre `Tab` devient local · appelants : aucun · tests : T01, T05 · sources : [Fcaisses.class:181](../../../../.src/Caisse/Fcaisses.class#L181), [Fcaisses.class:Button3_Click](../../../../.src/Caisse/Fcaisses.class#L264-L317), [Fcaisses.class:284](../../../../.src/Caisse/Fcaisses.class#L284)
- [ ] FCAISSES-003 — [documentation] Tables en dur → `Cbase.Table("TabDepots")` et
  `Cbase.Table("TabEntTck")` (même nom de table, SQL identique) · appelants : aucun · tests : T04,
  T06 · sources : [Fcaisses.class:109](../../../../.src/Caisse/Fcaisses.class#L109), [Fcaisses.class:274](../../../../.src/Caisse/Fcaisses.class#L274)
- [ ] FCAISSES-004 — [complexité] `Cais_KeyPress` : table tag → contrôle suivant au lieu du
  `Select` (CC 26 → ≤ 6 visé) · appelants : aucun · tests : T01, T02 · sources : [Fcaisses.class:Cais_KeyPress](../../../../.src/Caisse/Fcaisses.class#L144-L189)
- [ ] FCAISSES-005 — [séparation traitement/GUI] Extraire `EnregistreCaisse(…)`,
  `ControleSuppression(sCode) As String`, `SupprimeCaisse(sCode)` et
  `ControleTypePoste(sType, sPoste) As String` (partagé par `Btn_Click` et `Cais_LostFocus`) ·
  appelants : aucun · tests : T01, T03, T05 · sources : [Fcaisses.class:Button1_Click](../../../../.src/Caisse/Fcaisses.class#L239-L262), [Fcaisses.class:Button3_Click](../../../../.src/Caisse/Fcaisses.class#L264-L317), [Fcaisses.class:Btn_Click](../../../../.src/Caisse/Fcaisses.class#L202-L231), [Fcaisses.class:Cais_LostFocus](../../../../.src/Caisse/Fcaisses.class#L350-L375)
- [ ] FCAISSES-006 — [commonalisation] Liste des dépôts (`Dep` sans `01`, format `code-libellé`)
  et relecture du libellé via le module `Depot` (MVTDEPOTS-004), partagé avec `Famille` et
  `Facture` ; `Left$(…, 2)` conservé tant que FCAISSES-A04 n'est pas tranchée · appelants : aucun ·
  tests : T04, tests de dépôts de FAMILLE · sources : [Fcaisses.class:Form_Open](../../../../.src/Caisse/Fcaisses.class#L45-L77), [Fcaisses.class:Maj_Zones](../../../../.src/Caisse/Fcaisses.class#L87-L116), [Famille.class:95](../../../../.src/Gestion/Tables/Famille.class#L95), [Facture.class:374](../../../../.src/Gestion/Facturation/Facture.class#L374)
- [ ] FCAISSES-007 — [commonalisation] Gabarit d'écran de table (`Refresh`, `Maj_Zones`,
  `Cleanchamps`, `Btn_Click`, `Btn_KeyPress`, Échap dans la liste) partagé avec `Fvendeurs` et le
  socle des tables de Gestion · appelants : aucun · tests : T01-T07, FVENDEURS-T01-T05 · sources : [Fcaisses.class:Refresh](../../../../.src/Caisse/Fcaisses.class#L79-L85), [Fvendeurs.class:Refresh](../../../../.src/Caisse/Fvendeurs.class#L61-L68)
- [ ] FCAISSES-008 — [commonalisation] `Chkcaisse` → helper de filtre de touches partagé avec
  `Fondcaisse.ChkFDC` (FONDCAISSE-008) · appelants : aucun · tests : T02 · sources : [Fcaisses.class:Chkcaisse](../../../../.src/Caisse/Fcaisses.class#L340-L348)
- [ ] FCAISSES-009 — [réduction de portée] `Refresh`, `Maj_Zones`, `Cleanchamps`, `Chkcaisse`,
  `Button1_Click`, `Button3_Click` → `Private` (aucun appelant externe ; `Button1`/`Button3` sont
  dans le groupe `Btn`) ; `Caisse_Click` reste `Public` (rejeu) · appelants : aucun · tests :
  T01-T07 · sources : [Fcaisses.class:Refresh](../../../../.src/Caisse/Fcaisses.class#L79-L85), [Fcaisses.class:Maj_Zones](../../../../.src/Caisse/Fcaisses.class#L87-L116), [Fcaisses.class:Cleanchamps](../../../../.src/Caisse/Fcaisses.class#L118-L130), [Fcaisses.class:Chkcaisse](../../../../.src/Caisse/Fcaisses.class#L340-L348), [Fcaisses.class:Button1_Click](../../../../.src/Caisse/Fcaisses.class#L239-L262), [Fcaisses.class:Button3_Click](../../../../.src/Caisse/Fcaisses.class#L264-L317)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCAISSES-A01 — [anomalie] Suppression : les contrôles portent sur `Code.Text` mais le
  `DELETE` vise `Caisse.Current[0]` (ligne sélectionnée), construit **par concaténation** ; une
  caisse connectée ou sans bande Z peut être supprimée si elle est sélectionnée pendant qu'une
  autre est saisie ; sans sélection, erreur interceptée · tests : T06 · sources : [Fcaisses.class:301](../../../../.src/Caisse/Fcaisses.class#L301), [Fcaisses.class:303](../../../../.src/Caisse/Fcaisses.class#L303)
- [ ] FCAISSES-A02 — [anomalie] `Not rTkt.Available Or If moulinage = 1` est toujours vrai (on est
  dans `If Moulinage = 1`) : le refus « il reste des tickets » n'est jamais appliqué ; à décider si
  la suppression doit être bloquée tant que des tickets non archivés existent · tests : T06 ·
  sources : [Fcaisses.class:302](../../../../.src/Caisse/Fcaisses.class#L302)
- [ ] FCAISSES-A03 — [anomalie] `Btn_KeyPress` : toute touche sur « Enregistrer » enregistre sans
  les contrôles Monoposte/Réseau faits par `Btn_Click` · tests : T03 · sources : [Fcaisses.class:Btn_KeyPress](../../../../.src/Caisse/Fcaisses.class#L191-L200), [Fcaisses.class:Btn_Click](../../../../.src/Caisse/Fcaisses.class#L202-L231)
- [ ] FCAISSES-A04 — [anomalie] Dépôt enregistré par `Left$(Dep.Text, 2)` alors que
  `Fiches_Depots.code` est `char(8)` : un dépôt de code long est tronqué puis introuvable (même
  convention dans `Famille` et `Facture`, à corriger ensemble) · appelants : `Caisse` (lecture de
  `depot`) · tests : T04 · sources : [Fcaisses.class:248](../../../../.src/Caisse/Fcaisses.class#L248), [Fcaisses.class:250](../../../../.src/Caisse/Fcaisses.class#L250), [Famille.class:190](../../../../.src/Gestion/Tables/Famille.class#L190)
- [ ] FCAISSES-A05 — [anomalie] Interface : « Type imp. » affiché seulement pour `/dev/ttyS*` alors
  que la liste propose `/dev/ttyUSB*`/`/dev/ttyACM*` (valeur cachée conservée à l'enregistrement) ;
  Échap/F2 masque définitivement la liste jusqu'à la réouverture ; `Chkcaisse` refuse le chiffre
  `0` (aucun code `10`, cohérent avec OUVERTURE-A01) · tests : T02, T07 · sources : [Fcaisses.class:101](../../../../.src/Caisse/Fcaisses.class#L101), [Fcaisses.class:245](../../../../.src/Caisse/Fcaisses.class#L245), [Fcaisses.class:331](../../../../.src/Caisse/Fcaisses.class#L331), [Fcaisses.class:342](../../../../.src/Caisse/Fcaisses.class#L342)
