# Cmenu — Rework

> Source : `.src/Caisse/Cmenu.class` · Message de commit (phase 4) : `reference/.src/Caisse/Cmenu.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 325 |
| Lignes de commentaire | 20 |
| Fonctions | 25 |
| Fonctions Public | 25 |
| Complexité cyclomatique totale | 107 |
| Complexité max (fonction) | 16 (`_new`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 325 | 107 | 16 | 0 | 25 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CMENU-001 — [documentation] En-tête en français : rôle (accueil PDV, deux points d'entrée
  `Start` et `Fmenu`), cycle connexion/déconnexion (`Fiches_Caisses`, `~/Caisse<n>.lock`,
  `/Soc<XX>/caisse/Ncai`), accès administrateur ; corriger le libellé du commentaire « CTRL + F12 »
  dans le code uniquement (le `.form` n'est pas touché) · appelants : aucun · tests : T01-T14 ·
  sources : [Cmenu.class:_new](../../../../.src/Caisse/Cmenu.class#L16-L94), [Cmenu.class:form_close](../../../../.src/Caisse/Cmenu.class#L184-L216)
- [ ] CMENU-002 — [code mort] Supprimer `intitule` (lu, jamais utilisé), la variable `b` de
  `Button1_Click` et le membre `hForm` (remplacé par une variable locale de `Button10_Click`) ·
  appelants : aucun · tests : T01, T03, T05 · sources : [Cmenu.class:30](../../../../.src/Caisse/Cmenu.class#L30), [Cmenu.class:Button1_Click](../../../../.src/Caisse/Cmenu.class#L124-L158), [Cmenu.class:Button10_Click](../../../../.src/Caisse/Cmenu.class#L218-L230)
- [ ] CMENU-003 — [documentation] `"Fiches_ClientCaisse"` et `"Fiches_EntTicketz"` en dur →
  `Cbase.Table("TabCliCaisse")` / `Cbase.Table("TabEntTck")` (même nom de table, SQL identique) ·
  appelants : aucun · tests : T03, T04 · sources : [Cmenu.class:128](../../../../.src/Caisse/Cmenu.class#L128), [Cmenu.class:380](../../../../.src/Caisse/Cmenu.class#L380)
- [ ] CMENU-004 — [complexité] `_new` : extraire l'ouverture de connexion dans `OuvreConnexion()`
  privée et remplacer les `If` imbriqués du `Catch` par une table préfixe → message (mêmes
  messages, même ordre de test) (CC 16 → ≤ 8 visé) · appelants : aucun · tests : T01, T02 ·
  sources : [Cmenu.class:_new](../../../../.src/Caisse/Cmenu.class#L16-L94)
- [ ] CMENU-005 — [commonalisation] Les quatre `ButtonN_KeyPress` délèguent à un helper privé
  `ToucheBouton(bCtrlF1)` (F1 avec `Ctrl` pour `Button1` seulement, F12, Entrée) ; handlers
  conservés, `Public` · appelants : aucun · tests : T04, T05, T13 · sources : [Cmenu.class:Button1_KeyPress](../../../../.src/Caisse/Cmenu.class#L273-L281), [Cmenu.class:Button2_KeyPress](../../../../.src/Caisse/Cmenu.class#L166-L172), [Cmenu.class:Button10_KeyPress](../../../../.src/Caisse/Cmenu.class#L232-L238), [Cmenu.class:Button11_KeyPress](../../../../.src/Caisse/Cmenu.class#L259-L265)
- [ ] CMENU-006 — [complexité] `form_close` : remplacer `Split(…)[0]` protégé par le `Catch` par
  un test explicite du paramètre `Ncai` vide (fermeture sans question, `Start.UnLock()` en mode
  `-p` : comportement identique) · appelants : aucun · tests : T07, T08 · sources : [Cmenu.class:form_close](../../../../.src/Caisse/Cmenu.class#L184-L216)
- [ ] CMENU-007 — [séparation traitement/GUI] Extraire `DeconnecteCaisse(sCaisse)` (UPDATE
  `Fiches_Caisses`, suppression du verrou, `Ncai` vidé), `CaisseDisponible() As String` (les deux
  `SELECT` de `Button1_Click`) et `EstMotDePasseAdmin(sMdp) As Boolean` (`Mdp_KeyPress`), sans
  accès aux contrôles · appelants : aucun · tests : T03, T04, T07, T10, T11 · sources : [Cmenu.class:form_close](../../../../.src/Caisse/Cmenu.class#L184-L216), [Cmenu.class:Button1_Click](../../../../.src/Caisse/Cmenu.class#L124-L158), [Cmenu.class:Mdp_KeyPress](../../../../.src/Caisse/Cmenu.class#L330-L374)
- [ ] CMENU-008 — [commonalisation] Survol des boutons : `SetObservers`/`Obs_Enter`/`Obs_Leave`
  remplacés par la classe helper `SurvolBoutons` partagée avec `Ouverture`, `Fondcaisse`,
  `Preferences` (et les 12 autres copies) · appelants : aucun · tests : T01 (visuel non comparé) ·
  sources : [Cmenu.class:SetObservers](../../../../.src/Caisse/Cmenu.class#L96-L108), [Cmenu.class:Obs_Enter](../../../../.src/Caisse/Cmenu.class#L110-L115), [Cmenu.class:Obs_Leave](../../../../.src/Caisse/Cmenu.class#L117-L122), [Ouverture.class:SetObservers](../../../../.src/Caisse/Ouverture.class#L44-L56), [Fondcaisse.class:SetObservers](../../../../.src/Caisse/Fondcaisse.class#L114-L126), [Preferences.class:SetObservers](../../../../.src/Caisse/Preferences.class#L76-L88)
- [ ] CMENU-009 — [commonalisation] `EstMotDePasseAdmin` et la vérification du mot de passe
  vendeur d'`Ouverture` passent par le helper `LVendeur` (proposé par CONVENDEURS-005) ·
  appelants : aucun · tests : T10, T11, OUVERTURE-T04 · sources : [Cmenu.class:Mdp_KeyPress](../../../../.src/Caisse/Cmenu.class#L330-L374), [Ouverture.class:Caissiere_Click](../../../../.src/Caisse/Ouverture.class#L125-L147), [ConVendeurs.class:Caissiere_Click](../../../../.src/Gestion/Facturation/ConVendeurs.class#L57-L77)
- [ ] CMENU-010 — [réduction de portée] `SetObservers`, `ControleCai`, `Config`, `mdp_admin2`,
  `mdp_admin3`, `init_ecole`, `Soc`, `intitule` → `Private` (aucun appelant externe ni appel
  dynamique ; vérifié par `grep`) · appelants : aucun · tests : T01-T13 · sources : [Cmenu.class:SetObservers](../../../../.src/Caisse/Cmenu.class#L96-L108), [Cmenu.class:ControleCai](../../../../.src/Caisse/Cmenu.class#L174-L182), [Cmenu.class:Config](../../../../.src/Caisse/Cmenu.class#L267-L271), [Cmenu.class:mdp_admin2](../../../../.src/Caisse/Cmenu.class#L298-L308), [Cmenu.class:mdp_admin3](../../../../.src/Caisse/Cmenu.class#L310-L323), [Cmenu.class:init_ecole](../../../../.src/Caisse/Cmenu.class#L376-L409)

- [ ] CMENU-011 — [commonalisation] Test du client caisse de `Button1_Click` via
  `CompteClientCaisse()` (FCLIENTC-005, partagé avec `Fclientc`, `Moulinage`, `BordereauxC`) ;
  remplace CMENU-003 pour `Fiches_ClientCaisse` (SQL identique) · appelants : aucun · tests : T03,
  T04, FCLIENTC-T04 · sources : [Cmenu.class:137](../../../../.src/Caisse/Cmenu.class#L137), [Moulinage.class:1528](../../../../.src/Caisse/Moulinage.class#L1528), [BordereauxC.class:242](../../../../.src/Compta/Impressions/BordereauxC.class#L242)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CMENU-A01 — [anomalie] (FMENU-A13) `_new` lit et écrit `Fmenu.text` sur l'auto-instance
  de `Fmenu` : une instance cachée de `Fmenu` est créée et le titre « Société en cours » n'est
  affiché nulle part ; correction attendue : `Me.Text` (mode `-p`) ou `Start.MainWindow` (mode
  Gestion), à corriger avec FMENU-A13 · appelants : `Start`, `Fmenu` · tests : T01, T12 ·
  sources : [Cmenu.class:29](../../../../.src/Caisse/Cmenu.class#L29), [Cmenu.class:64](../../../../.src/Caisse/Cmenu.class#L64)
- [ ] CMENU-A02 — [anomalie, à confirmer] `ALTER DATABASE … COLLATE` et `SET NAMES` exécutés
  sans test `Utils.db.IsType(Utils.db.type_mysql)` : sous SQLite l'erreur est propagée par
  `DB_Connection.Exec`, le `Catch` de `_new` affiche un message et ouvre `LauruxConf` ; le mode
  `-p` serait inutilisable sur SQLite (`Fmenu` est protégé) · tests : T14 · sources : [Cmenu.class:52](../../../../.src/Caisse/Cmenu.class#L52), [Cmenu.class:53](../../../../.src/Caisse/Cmenu.class#L53), [Cmenu.class:61](../../../../.src/Caisse/Cmenu.class#L61), [Fmenu.class:168](../../../../.src/Communs/Fmenu.class#L168)
- [ ] CMENU-A03 — [anomalie] Avec `/caisse/admin2` actif, `Alt+L` (`mdp_admin3`) affiche le cadre
  de mot de passe commun et `Mdp_KeyPress` ouvre toujours `Preferences` : le journal `DB_Log`
  n'est jamais accessible quand la protection est active · tests : T10 · sources : [Cmenu.class:mdp_admin3](../../../../.src/Caisse/Cmenu.class#L310-L323), [Cmenu.class:345](../../../../.src/Caisse/Cmenu.class#L345)
- [ ] CMENU-A04 — [anomalie] Caisse école : `init_ecole` exécute `Quit 1` avant la mise à jour
  `statut = 'E'` des tickets, la suppression du verrou et le message (lignes 397-403
  inatteignables) ; `Ncai` et `~/Caisse<n>.lock` restent, l'application sort en code 1. Réponse
  « Non » : `Efface` reste à 0 (plus aucune déconnexion aux fermetures suivantes) et
  `Start.UnLock()` est appelé alors que la fenêtre reste ouverte. À traiter avec la décision sur les
  caisses école (message « TODO ») · tests : T09 · sources : [Cmenu.class:396](../../../../.src/Caisse/Cmenu.class#L396), [Cmenu.class:397](../../../../.src/Caisse/Cmenu.class#L397), [Cmenu.class:405](../../../../.src/Caisse/Cmenu.class#L405), [Cmenu.class:211](../../../../.src/Caisse/Cmenu.class#L211)
- [ ] CMENU-A05 — [anomalie] `form_close` lit `Cai!ecole` sans tester `Available` : si la caisse
  du paramètre `Ncai` n'existe plus, l'erreur part dans le `Catch` et la fenêtre se ferme **sans
  déconnecter** ni vider `Ncai` · tests : T08 (variante caisse supprimée) · sources : [Cmenu.class:195](../../../../.src/Caisse/Cmenu.class#L195)
