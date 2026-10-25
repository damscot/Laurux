# Fclientc — Rework

> Source : `.src/Caisse/Fclientc.class` · Message de commit (phase 4) : `reference/.src/Caisse/Fclientc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 122 |
| Lignes de commentaire | 31 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 28 |
| Complexité max (fonction) | 5 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 122 | 28 | 5 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FCLIENTC-001 — [documentation] En-tête corrigé (le fichier se présente comme
  « Fclient.class ») : rôle (compte client caisse, table d'une ligne), lecteurs de la donnée
  (`Moulinage`, `BordereauxC`, `Cmenu`) · appelants : aucun · tests : T01-T04 · sources : [Fclientc.class:_New](../../../../.src/Caisse/Fclientc.class#L31-L43)
- [ ] FCLIENTC-002 — [code mort] Supprimer `Maj_Zones`, `Cleanchamps`, `Compteman` (jamais
  appelées) et la branche `Else` vide de `Button3_Click` · appelants : aucun · tests : T01-T04 · sources : [Fclientc.class:Maj_Zones](../../../../.src/Caisse/Fclientc.class#L66-L73), [Fclientc.class:Cleanchamps](../../../../.src/Caisse/Fclientc.class#L75-L80), [Fclientc.class:Compteman](../../../../.src/Caisse/Fclientc.class#L174-L187), [Fclientc.class:110](../../../../.src/Caisse/Fclientc.class#L110)
- [ ] FCLIENTC-003 — [commonalisation] Noms de tables via `Cbase.Table("TabCliCaisse")` et
  `Cbase.Table("TabCli")` (texte SQL identique) ; suppression de la variable d'instance `Tab` ·
  appelants : aucun · tests : T01-T04 · sources : [Fclientc.class:Form_Open](../../../../.src/Caisse/Fclientc.class#L45-L56), [Fclientc.class:Button1_Click](../../../../.src/Caisse/Fclientc.class#L82-L97), [Fclientc.class:Button3_Click](../../../../.src/Caisse/Fclientc.class#L99-L113), [Fclientc.class:Button4_Click](../../../../.src/Caisse/Fclientc.class#L115-L143)
- [ ] FCLIENTC-004 — [séparation traitement/GUI] `EnregistreCompteCaisse(code, nom)` (SELECT +
  UPDATE/INSERT inchangés), `SupprimeCompteCaisse(code)`, `ListeClients() As Result` ; les handlers
  gardent sons, messages et remplissage · appelants : aucun · tests : T01-T03 · sources : [Fclientc.class:Button1_Click](../../../../.src/Caisse/Fclientc.class#L82-L97), [Fclientc.class:Button3_Click](../../../../.src/Caisse/Fclientc.class#L99-L113), [Fclientc.class:Button4_Click](../../../../.src/Caisse/Fclientc.class#L115-L143)
- [ ] FCLIENTC-005 — [commonalisation] `CompteClientCaisse() As Result` (`SELECT * FROM
  Fiches_ClientCaisse`, même texte) utilisée par `Form_Open`, `Moulinage`, `BordereauxC` et
  `Cmenu.Button1_Click` · appelants : `Moulinage`, `BordereauxC`, `Cmenu` (même commit) · tests :
  T01, T04, tests de moulinage et de bordereaux · sources : [Fclientc.class:Form_Open](../../../../.src/Caisse/Fclientc.class#L45-L56), [Moulinage.class:1528](../../../../.src/Caisse/Moulinage.class#L1528), [BordereauxC.class:242](../../../../.src/Compta/Impressions/BordereauxC.class#L242), [Cmenu.class:Button1_Click](../../../../.src/Caisse/Cmenu.class#L124-L158)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FCLIENTC-A01 — [anomalie] Après « Supprimer », `Refresh` → `Form_Open` ne vide pas les zones
  quand la table est vide : le compte supprimé reste affiché (et « Enregistrer » le recrée) · tests :
  T03 · sources : [Fclientc.class:107](../../../../.src/Caisse/Fclientc.class#L107), [Fclientc.class:Form_Open](../../../../.src/Caisse/Fclientc.class#L45-L56)
- [ ] FCLIENTC-A02 — [anomalie] `Button1_Click` joue le son sans tester `Start.Son` (les autres
  handlers le testent) · tests : T01 · sources : [Fclientc.class:93](../../../../.src/Caisse/Fclientc.class#L93)
- [ ] FCLIENTC-A03 — [anomalie] Pas d'appel à `Utils.Observers(Me)` : l'écran n'est ni journalisé ni
  rejouable (ajouter l'appel modifie le log produit) · tests : T01-T04 · sources : [Fclientc.class:_New](../../../../.src/Caisse/Fclientc.class#L31-L43)
- [ ] FCLIENTC-A04 — [anomalie] Liste de recherche : `SELECT * FROM Fiches_Cli` sans `ORDER BY`
  (ordre non garanti, base entière chargée) et aucun contrôle que le code saisi à la main existe
  dans `Fiches_Cli` ; `Moulinage` utilisera un client inexistant · tests : T02 · sources : [Fclientc.class:130](../../../../.src/Caisse/Fclientc.class#L130), [Fclientc.class:Button1_Click](../../../../.src/Caisse/Fclientc.class#L82-L97)
