# ConVendeurs — Rework

> Source : `.src/Gestion/Facturation/ConVendeurs.class` · Message de commit (phase 4) : `reference/.src/Gestion/Facturation/ConVendeurs.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 97 |
| Lignes de commentaire | 1 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 33 |
| Complexité max (fonction) | 9 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 97 | 33 | 9 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CONVENDEURS-001 — [documentation] En-tête : rôle, trois points d'entrée (Menu42, Menu193,
  F5 de `Facture`), contrat de `/Soc<XX>/CodeVendeur` (« code nom », lu par `Mid$(…, 3)`) ·
  appelants : aucun · tests : aucun · sources : [ConVendeurs.class:_new](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L6-L26), [ConVendeurs.class:Button1_Click](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L85-L116)
- [ ] CONVENDEURS-002 — [réduction de portée] `Mdp_Vendeurs` → `Private` · appelants : aucun
  (vérifié par `grep`) · tests : T01, T02 · sources : [ConVendeurs.class:Mdp_Vendeurs](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L41-L55)
- [ ] CONVENDEURS-003 — [complexité] Drapeau `b` remplacé par la valeur de retour Boolean de
  `Mdp_Vendeurs` ; `Do … Loop Until` → `Repeat … Until` (même comportement) · appelants : aucun ·
  tests : T01, T02 · sources : [ConVendeurs.class:Mdp_KeyPress](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L28-L39), [ConVendeurs.class:Mdp_Vendeurs](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L41-L55), [ConVendeurs.class:_new](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L6-L26)
- [ ] CONVENDEURS-004 — [séparation traitement/GUI] Extraire `ListeVendeurs() As String[]` et
  `MotDePasseVendeur(code) As String` (SQL + déchiffrement, SQL identique) ; les handlers gardent
  messages et focus · appelants : aucun · tests : T01-T03 · sources : [ConVendeurs.class:_new](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L6-L26), [ConVendeurs.class:Caissiere_Click](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L57-L77)
- [ ] CONVENDEURS-005 — [commonalisation] Helper commun de sélection de vendeur avec
  `Caisse/Ouverture` et `Caisse/Svendeur` (liste, mot de passe), en conservant la longueur de code
  propre à chaque appelant (1 ici, 2 dans `Ouverture`) · appelants : aucun (helpers internes) ·
  tests : T01-T03 et tests d'`Ouverture` · sources : [ConVendeurs.class:Caissiere_Click](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L57-L77), [Ouverture.class:130-131](../../../../../.src/Caisse/Ouverture.class#L130-L131), [Svendeur.class:26](../../../../../.src/Caisse/Svendeur.class#L26)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CONVENDEURS-A01 — [anomalie] `Fmenu.Menu193_Click` appelle `New ConVendeurs(True)` alors
  que `_new` n'a pas de paramètre : l'argument part au constructeur de `Form` → « Type mismatch »
  (vérifié sur projet minimal). De plus `Button1_Click` ouvre toujours `New Facture(False)` : le
  mode entretien serait perdu. Correction : `_new(Optional bEntretien As Boolean)` mémorisé et
  transmis à `Facture` · appelants : `Fmenu` (Menu42, Menu193), `Facture` (F5) · tests : T06, T01 ·
  sources : [Fmenu.class:1788](../../../../../.src/Communs/Fmenu.class#L1788), [ConVendeurs.class:_new](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L6-L26), [ConVendeurs.class:89](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L89)
- [ ] CONVENDEURS-A02 — [anomalie] Code vendeur `char(2)` lu par `Left$(Caissiere.Text, 1)` :
  un vendeur `12` est cherché sous le code `1` (mauvais mot de passe ou erreur) ; `Facture`
  extrait le nom par `Mid$(…, 3)` avec la même hypothèse. `Ouverture` utilise `Left$(…, 2)` ·
  tests : T03 · sources : [ConVendeurs.class:62](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L62), [Facture.class:551](../../../../../.src/Gestion/Facturation/Facture.class#L551), [Ouverture.class:130](../../../../../.src/Caisse/Ouverture.class#L130)
- [ ] CONVENDEURS-A03 — [anomalie] `Button3_Click` masque l'auto-instance
  (`ConVendeurs.Visible = False`) au lieu de `Me` : ouverte par `New ConVendeurs` (Fmenu), la
  fenêtre reste affichée après « Déconnecter » · tests : T04 · sources : [ConVendeurs.class:121](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L121)
- [ ] CONVENDEURS-A04 — [anomalie, à confirmer] `Button1_Click` construit `New Facture(False)`
  avant tout contrôle et l'ouvre en modal après connexion : appelé depuis `Facture` (F5), il
  empile une **seconde** saisie de documents ; en cas d'échec de contrôle, une `Facture` est
  construite pour rien (cf. FMENU-A09) · tests : T05, T02 · sources : [ConVendeurs.class:89](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L89), [ConVendeurs.class:111](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L111), [Facture.class:889](../../../../../.src/Gestion/Facturation/Facture.class#L889)
- [ ] CONVENDEURS-A05 — [anomalie] `Caissiere_Click` lit `Rrslt!mdp` sans tester `Available` :
  le choix de l'entrée vide `"  "` déclenche le `Catch` (message d'erreur technique) · tests : T02 ·
  sources : [ConVendeurs.class:62-63](../../../../../.src/Gestion/Facturation/ConVendeurs.class#L62-L63)
