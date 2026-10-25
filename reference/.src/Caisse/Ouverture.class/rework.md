# Ouverture — Rework

> Source : `.src/Caisse/Ouverture.class` · Message de commit (phase 4) : `reference/.src/Caisse/Ouverture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 212 |
| Lignes de commentaire | 5 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 19 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 212 | 67 | 19 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] OUVERTURE-001 — [documentation] En-tête en français : rôle, étapes de la connexion (verrou,
  `Ncai`, `Start.$tcai`, `UPDATE Fiches_Caisses`), contrat avec `Clavier` (auto-instance, `Mdp`,
  `Button1_Click`), format de `Ncai` · appelants : aucun · tests : T01-T10 · sources : [Ouverture.class:_new](../../../../.src/Caisse/Ouverture.class#L11-L42), [Ouverture.class:Button1_Click](../../../../.src/Caisse/Ouverture.class#L155-L227)
- [ ] OUVERTURE-002 — [code mort] Supprimer `Rcai` et `Org` (jamais appelées), le membre `$clav`
  (jamais utilisé) et les lignes commentées ; `hfile`, `sFiletxt`, `sNcaisse` deviennent locales à
  `Button1_Click` · appelants : aucun · tests : T03 · sources : [Ouverture.class:Rcai](../../../../.src/Caisse/Ouverture.class#L229-L234), [Ouverture.class:Org](../../../../.src/Caisse/Ouverture.class#L250-L255), [Ouverture.class:9](../../../../.src/Caisse/Ouverture.class#L9)
- [ ] OUVERTURE-003 — [réarchitecture] Déplacer `Rvdr` dans un module (`CaisseEtat` proposé, ou
  `TestCaisses`) : `Fondcaisse` n'instancie plus l'auto-instance cachée d'`Ouverture` (SQL
  modifié : deux `SELECT` de moins à l'ouverture de `Fondcaisse`, dump identique) ·
  appelants : `Fondcaisse` · tests : T11, FONDCAISSE-T01, FONDCAISSE-T02 · sources : [Ouverture.class:Rvdr](../../../../.src/Caisse/Ouverture.class#L236-L248), [Fondcaisse.class:30](../../../../.src/Caisse/Fondcaisse.class#L30)
- [ ] OUVERTURE-004 — [complexité] `Button1_Click` : sorties anticipées au lieu des six niveaux
  de `If`, mêmes messages et même ordre de contrôle (CC 19 → ≤ 8 visé) · appelants : `Clavier`
  (inchangé) · tests : T03-T09 · sources : [Ouverture.class:Button1_Click](../../../../.src/Caisse/Ouverture.class#L155-L227)
- [ ] OUVERTURE-005 — [complexité] `Mdp_Vendeurs` renvoie un `Boolean` et le drapeau membre `b`
  disparaît (comme CONVENDEURS-003) · appelants : aucun · tests : T03, T04 · sources : [Ouverture.class:Mdp_Vendeurs](../../../../.src/Caisse/Ouverture.class#L87-L102), [Ouverture.class:Mdp_KeyPress](../../../../.src/Caisse/Ouverture.class#L74-L85), [Ouverture.class:Caissiere_Click](../../../../.src/Caisse/Ouverture.class#L125-L147)
- [ ] OUVERTURE-006 — [séparation traitement/GUI] Extraire `ConnecteCaisse(sCaisse,
  sVendeurLibelle)` (verrou, `Ncai`, `Start.$tcai`, `UPDATE`) et `InfosCaisse(sCode)` (fond, date
  de fermeture), sans accès aux contrôles ; les handlers gardent messages et focus · appelants :
  aucun · tests : T02, T03 · sources : [Ouverture.class:Button1_Click](../../../../.src/Caisse/Ouverture.class#L155-L227), [Ouverture.class:Combobox1_Click](../../../../.src/Caisse/Ouverture.class#L104-L123)
- [ ] OUVERTURE-007 — [commonalisation] Liste des vendeurs, recherche et déchiffrement du mot de
  passe via le helper `LVendeur` partagé avec `ConVendeurs`, `Svendeur` et `Cmenu` ; longueurs de
  code conservées (2 pour la requête, 1 pour `TestCai`) · appelants : aucun · tests : T01, T03,
  T04, CONVENDEURS-T01-T03, SVENDEUR-T01 · sources : [Ouverture.class:_new](../../../../.src/Caisse/Ouverture.class#L11-L42), [Ouverture.class:Caissiere_Click](../../../../.src/Caisse/Ouverture.class#L125-L147), [ConVendeurs.class:Caissiere_Click](../../../../.src/Gestion/Facturation/ConVendeurs.class#L57-L77), [Svendeur.class:_new](../../../../.src/Caisse/Svendeur.class#L3-L19)
- [ ] OUVERTURE-008 — [commonalisation] Module `CaisseEtat` (fichiers verrou via `VerrouCaisse`,
  proposé par TESTCAISSES, partagé avec `Fondcaisse` et `Dcaisses`) : connexion (`ConnecteCaisse`),
  déconnexion (`Cmenu.DeconnecteCaisse`, CMENU-007), vendeur connecté (`Rvdr`) et contrôle du
  vendeur déjà utilisé (`TestCaisses.TestCai`) au même endroit · appelants : `Cmenu`, `Fondcaisse` ·
  tests : T03, T06, CMENU-T07 · sources : [Ouverture.class:Rvdr](../../../../.src/Caisse/Ouverture.class#L236-L248), [Cmenu.class:form_close](../../../../.src/Caisse/Cmenu.class#L184-L216), [TestCaisses.module:TestCai](../../../../.src/Caisse/TestCaisses.module#L3-L31)
- [ ] OUVERTURE-009 — [commonalisation] Survol des boutons via `SurvolBoutons` (voir CMENU-008) ·
  appelants : aucun · tests : T01 · sources : [Ouverture.class:SetObservers](../../../../.src/Caisse/Ouverture.class#L44-L56), [Ouverture.class:Obs_Enter](../../../../.src/Caisse/Ouverture.class#L58-L64), [Ouverture.class:Obs_Leave](../../../../.src/Caisse/Ouverture.class#L66-L72)
- [ ] OUVERTURE-010 — [réduction de portée] `SetObservers`, `Mdp_Vendeurs` → `Private` (aucun
  appelant externe, vérifié par `grep`) ; `Mdp` (contrôle public) et `Button1_Click` restent
  publics pour `Clavier` · appelants : aucun · tests : T01-T09 · sources : [Ouverture.class:SetObservers](../../../../.src/Caisse/Ouverture.class#L44-L56), [Ouverture.class:Mdp_Vendeurs](../../../../.src/Caisse/Ouverture.class#L87-L102)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] OUVERTURE-A01 — [anomalie] Code caisse lu par `Left$(Combobox1.Text, 1)` alors que
  `Fiches_Caisses.code` est `char(2)` : la caisse `10` est connectée comme `1` (verrou, `Ncai`,
  `UPDATE`) ; même hypothèse dans `Fondcaisse` (`Left$($cai, 1)`) et `TestCaisses` (boucle 1 à 10) ;
  `Fcaisses.Chkcaisse` interdit le chiffre 0 · appelants : `Fondcaisse`, `TestCaisses`, `Cmenu` ·
  tests : T07 · sources : [Ouverture.class:109](../../../../.src/Caisse/Ouverture.class#L109), [Ouverture.class:158](../../../../.src/Caisse/Ouverture.class#L158), [Fondcaisse.class:29](../../../../.src/Caisse/Fondcaisse.class#L29), [TestCaisses.module:13](../../../../.src/Caisse/TestCaisses.module#L13)
- [ ] OUVERTURE-A02 — [anomalie] Code vendeur incohérent : `Left$(…, 2)` pour la recherche, `Ncai`
  et `vdr_code` (avec espace final pour un code d'un caractère, introuvable sous SQLite, à
  confirmer), `Left$(…, 1)` pour `TestCai`, `Mid$(…, 2)` pour le nom affiché ; les vendeurs `10` et `11` se
  bloquent mutuellement dans `TestCai` (TESTCAISSES-A02) ; voir CONVENDEURS-A02 · tests : T07, T10 · sources : [Ouverture.class:130](../../../../.src/Caisse/Ouverture.class#L130), [Ouverture.class:132](../../../../.src/Caisse/Ouverture.class#L132), [Ouverture.class:200](../../../../.src/Caisse/Ouverture.class#L200), [Ouverture.class:207](../../../../.src/Caisse/Ouverture.class#L207), [Ouverture.class:218](../../../../.src/Caisse/Ouverture.class#L218)
- [ ] OUVERTURE-A03 — [anomalie] `Combobox1_Click` et `Caissiere_Click` lisent le `Result` sans
  tester `Available` : le choix de la ligne vide de `Combobox1` affiche une erreur technique
  (`Catch`) au lieu d'effacer le fond et la date · tests : T02 · sources : [Ouverture.class:110](../../../../.src/Caisse/Ouverture.class#L110), [Ouverture.class:131](../../../../.src/Caisse/Ouverture.class#L131)
- [ ] OUVERTURE-A04 — [anomalie] `button1_KeyPress` lance la connexion sur **n'importe quelle
  touche** du bouton « Connecter » (Tab, Échap, flèches) · tests : T08 · sources : [Ouverture.class:button1_KeyPress](../../../../.src/Caisse/Ouverture.class#L257-L261)
- [ ] OUVERTURE-A05 — [anomalie] Le contrôle « vendeur vide » teste `caissiere.Text = "  "` alors
  que l'entrée vide de la liste vaut `""` : le message « Veuillez saisir votre code vendeur » n'est
  jamais affiché (on obtient « Mot de passe erroné ») · tests : T04 · sources : [Ouverture.class:21](../../../../.src/Caisse/Ouverture.class#L21), [Ouverture.class:167](../../../../.src/Caisse/Ouverture.class#L167)
- [ ] OUVERTURE-A06 — [anomalie, à confirmer] La connexion ne consulte que le verrou du compte
  Unix courant (`User.Home`) et ignore `Fiches_Caisses.connecte` : la même caisse peut être
  connectée depuis un autre compte du même poste · tests : T05 (variante second compte) · sources : [Ouverture.class:188](../../../../.src/Caisse/Ouverture.class#L188)
- [ ] OUVERTURE-A07 — [anomalie] `Button1_Click` ferme `Clavier` par son auto-instance
  (`Try Clavier.Close()`) alors que le clavier affiché est créé par `New Clavier`
  (`Button3_Click`) : le clavier visible reste ouvert après la connexion et une instance cachée est
  créée ; correction : mémoriser l'instance de `Button3_Click` · appelants : `Clavier` · tests : T09 ·
  sources : [Ouverture.class:157](../../../../.src/Caisse/Ouverture.class#L157), [Ouverture.class:198](../../../../.src/Caisse/Ouverture.class#L198), [Ouverture.class:267](../../../../.src/Caisse/Ouverture.class#L267)
