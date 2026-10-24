# Cpostaux — Rework

> Source : `.src/Gestion/Tables/Cpostaux.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Cpostaux.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 286 |
| Lignes de commentaire | 23 |
| Fonctions | 34 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 70 |
| Complexité max (fonction) | 8 (`Cpost_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 286 | 70 | 8 | 0 | 34 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CPOSTAUX-001 — [documentation] En-tête : principe du filtre par en-têtes (`sel`, `Tri`,
  `Dbl`), dépendance à `Utils.rs1`, pseudo-handlers des contrôles groupés · appelants : aucun ·
  tests : aucun · sources : [Cpostaux.class:20](../../../../../.src/Gestion/Tables/Cpostaux.class#L20), [Cpostaux.class:Colcpost_Data](../../../../../.src/Gestion/Tables/Cpostaux.class#L66-L76)
- [ ] CPOSTAUX-002 — [code mort] Supprimer `cpoint` (copie locale de `Utils.cpoint`, jamais
  appelée) et la ligne commentée de `Form_Open` · appelants : aucun · tests : T01 · sources : [Cpostaux.class:cpoint](../../../../../.src/Gestion/Tables/Cpostaux.class#L48-L52), [Cpostaux.class:59](../../../../../.src/Gestion/Tables/Cpostaux.class#L59)
- [ ] CPOSTAUX-003 — [complexité] `Button1_Click` : remplacer le couple SELECT/UPDATE inopérant/INSERT
  par `Enrgcp.Ecp(Cpostal.Text, Burdist.Text)` (SQL modifié : l'UPDATE sans effet disparaît, dump
  identique) · appelants : aucun · tests : T01, T02 · sources : [Cpostaux.class:Button1_Click](../../../../../.src/Gestion/Tables/Cpostaux.class#L215-L235), [Enrgcp.module:Ecp](../../../../../.src/Utils/Enrgcp.module#L4-L13)
- [ ] CPOSTAUX-004 — [réarchitecture] `Cbase.Table("TabCpostaux")` au lieu des noms en dur ;
  `CpTable` initialisé une seule fois · appelants : aucun · tests : T01-T05 · sources : [Cpostaux.class:Form_Open](../../../../../.src/Gestion/Tables/Cpostaux.class#L54-L64), [Cpostaux.class:Button3_Click](../../../../../.src/Gestion/Tables/Cpostaux.class#L237-L252), [Cpostaux.class:Cpman](../../../../../.src/Gestion/Tables/Cpostaux.class#L254-L273), [Cpostaux.class:Colcpost_Data](../../../../../.src/Gestion/Tables/Cpostaux.class#L66-L76)
- [ ] CPOSTAUX-005 — [commonalisation] Socle « grille filtrable » partagé avec Marques et Depots
  (`Tris`, `Deb2`/`Deb3`, `Dbclk`, `Ref`, `CP_*`/`BD_*`, `ChkCp`) ; SQL identique · appelants :
  aucun · tests : T04, T06, MARQUES-T04, DEPOTS-T04 · sources : [Cpostaux.class:Deb2](../../../../../.src/Gestion/Tables/Cpostaux.class#L90-L95), [Cpostaux.class:Deb3](../../../../../.src/Gestion/Tables/Cpostaux.class#L97-L102), [Cpostaux.class:Dbclk](../../../../../.src/Gestion/Tables/Cpostaux.class#L388-L398), [Cpostaux.class:CP_KeyPress](../../../../../.src/Gestion/Tables/Cpostaux.class#L329-L341), [Marques.class:Deb2](../../../../../.src/Gestion/Tables/Marques.class#L88-L92), [Depots.class:Deb2](../../../../../.src/Gestion/Depots/Depots.class#L79-L83)
- [ ] CPOSTAUX-006 — [séparation traitement/GUI] `SupprimeCp(iLind)` et `BureauxDuCp(sCp)` sans
  contrôle, appelés par `Button3_Click`, `Cpman` et `aff_cp` · appelants : aucun · tests : T03, T05 ·
  sources : [Cpostaux.class:Button3_Click](../../../../../.src/Gestion/Tables/Cpostaux.class#L237-L252), [Cpostaux.class:Cpman](../../../../../.src/Gestion/Tables/Cpostaux.class#L254-L273), [Cpostaux.class:aff_cp](../../../../../.src/Gestion/Tables/Cpostaux.class#L275-L295)
- [ ] CPOSTAUX-007 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`,
  `Cleanchamps`, `Cpostal_GotFocus`, `Burdist_GotFocus`, `Cpostal_LostFocus`, `Button1_Click`,
  `Button3_Click`, `Cpman`, `aff_cp`, `ChkCp`, `Ref`, `Dbclk` → `Private` (pseudo-handlers et
  fonctions internes) ; `Colcpost_Click`, `Colcp_Click` restent `Public` (rejeu) · appelants :
  aucun · tests : T01-T06 · sources : [Cpostaux.class:Tris](../../../../../.src/Gestion/Tables/Cpostaux.class#L78-L88), [Cpostaux.class:Cpostal_GotFocus](../../../../../.src/Gestion/Tables/Cpostaux.class#L197-L201), [Cpostaux.class:Cpostal_LostFocus](../../../../../.src/Gestion/Tables/Cpostaux.class#L209-L213), [Cpostaux.class:Dbclk](../../../../../.src/Gestion/Tables/Cpostaux.class#L388-L398)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CPOSTAUX-A01 — [anomalie] UPDATE `WHERE cp = &2` (bureau comparé au code postal) : la
  modification d'un bureau crée un doublon au lieu de remplacer la ligne · tests : T02 · sources : [Cpostaux.class:225](../../../../../.src/Gestion/Tables/Cpostaux.class#L225)
- [ ] CPOSTAUX-A02 — [anomalie] Filtres `Deb2`/`Deb3` par concaténation de la frappe (`"` casse la
  requête) · tests : T04 · sources : [Cpostaux.class:92](../../../../../.src/Gestion/Tables/Cpostaux.class#L92), [Cpostaux.class:99](../../../../../.src/Gestion/Tables/Cpostaux.class#L99)
- [ ] CPOSTAUX-A03 — [anomalie] Suppression de la ligne sélectionnée de la grille, même si le code
  saisi est différent ; recherche `Cpman` seulement au clavier (pas à la perte de focus souris) ·
  tests : T05 · sources : [Cpostaux.class:247](../../../../../.src/Gestion/Tables/Cpostaux.class#L247), [Cpostaux.class:Cpostal_LostFocus](../../../../../.src/Gestion/Tables/Cpostaux.class#L209-L213)
