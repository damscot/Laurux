# Parametre — Rework

> Source : `.src/Communs/Parametre.class` · Message de commit (phase 4) : `reference/.src/Communs/Parametre.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 539 |
| Lignes de commentaire | 25 |
| Fonctions | 26 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 208 |
| Complexité max (fonction) | 62 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 539 | 208 | 62 | 0 | 24 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PARAMETRE-001 — [documentation] En-tête en français : rôle, colonnes éditées, options B/P et
  leurs colonnes créées par `modfichier`, verrou `DocActif`, enregistrement à la fermeture, lien
  avec `conf` (non modifié ici) ; commentaire sur les groupes `Par`/`Btn`/`cpts`/`jrnal` · appelants : aucun · tests : aucun · sources : [Parametre.class:_New](../../../../.src/Communs/Parametre.class#L33-L84), [Parametre.class:Form_Open](../../../../.src/Communs/Parametre.class#L86-L182)
- [ ] PARAMETRE-002 — [code mort] Supprimer la variable `son` jamais affectée et les 6 blocs
  `If son Then Music.Play` (jamais exécutés), ainsi que `Music.Load` devenu inutile ; supprimer les
  `With Utils` sans usage, la relecture `Jod.Text = rResult!jrnod` (doublon de la l.129) et `obj`
  inutilisé · appelants : aucun · tests : T01 à T06 · sources : [Parametre.class:29](../../../../.src/Communs/Parametre.class#L29), [Parametre.class:97](../../../../.src/Communs/Parametre.class#L97), [Parametre.class:149](../../../../.src/Communs/Parametre.class#L149), [Parametre.class:cpts_LostFocus](../../../../.src/Communs/Parametre.class#L326-L354), [Parametre.class:jrnal_LostFocus](../../../../.src/Communs/Parametre.class#L392-L441)
- [ ] PARAMETRE-003 — [documentation] Noms de tables via `Cbase.Table` : `TabParam`, `TabSoc`,
  `TabJour`, `TabTvav`, `TabArt` (mêmes noms physiques, SQL identique) ; `Art_Tipp` reste en dur
  (pas d'entrée `Cbase`) · appelants : aucun · tests : T01, T02, T05, T08, T09 · sources : [Parametre.class:92](../../../../.src/Communs/Parametre.class#L92), [Parametre.class:150](../../../../.src/Communs/Parametre.class#L150), [Parametre.class:402](../../../../.src/Communs/Parametre.class#L402), [Parametre.class:Veriftva](../../../../.src/Communs/Parametre.class#L586-L593), [Parametre.class:code_LostFocus](../../../../.src/Communs/Parametre.class#L652-L666)
- [ ] PARAMETRE-004 — [complexité] `Button2_Click` : boucle sur la liste des contrôles
  obligatoires (`IsNull(ctl.Text)`), exceptions explicites (`IsNan` de `datefedec` conservé, cas
  `Caisse`, vérifications de comptes) · CC 50 → ≤ 15 visé · appelants : aucun · tests : T02, T03, T04, T10 · sources : [Parametre.class:Button2_Click](../../../../.src/Communs/Parametre.class#L493-L553)
- [ ] PARAMETRE-005 — [séparation traitement/GUI] `EnregistrerParametres(aValeurs)`,
  `EnregistrerConsignes(…)`, `EnregistrerTipp(sReg)` : les quatre familles d'`UPDATE` sans accès
  aux contrôles ; `Button2_Click` collecte les valeurs (même ordre d'arguments, SQL identique) ·
  appelants : aucun · tests : T02, T08, T09 · sources : [Parametre.class:Button2_Click](../../../../.src/Communs/Parametre.class#L493-L553)
- [ ] PARAMETRE-006 — [séparation traitement/GUI] `JournalTypeAttendu(hCtl)` et lecture SQL du
  journal hors du handler `jrnal_LostFocus` ; `mcdt` séparé en `PeriodeNormalisee(s) As String`
  (pure) + gestion du focus · appelants : aucun · tests : T05, T06, T12 · sources : [Parametre.class:jrnal_LostFocus](../../../../.src/Communs/Parametre.class#L392-L441), [Parametre.class:mcdt](../../../../.src/Communs/Parametre.class#L474-L491)
- [ ] PARAMETRE-007 — [commonalisation] `ProposerCreation(txtbox, bTva)` remplace `meserrc`,
  `meserrt` et les deux blocs identiques de `Par_lostfocus` (Tag 33 et 38) ; messages inchangés ·
  appelants : aucun · tests : T04 · sources : [Parametre.class:meserrc](../../../../.src/Communs/Parametre.class#L555-L562), [Parametre.class:meserrt](../../../../.src/Communs/Parametre.class#L564-L571), [Parametre.class:Par_lostfocus](../../../../.src/Communs/Parametre.class#L228-L293)
- [ ] PARAMETRE-008 — [réarchitecture] `Btn_Click` Tag 3 : `Me.Close` seul (le `Form_Close`
  enregistre déjà) — **SQL modifié, dump identique** (une série d'`UPDATE` au lieu de deux) ;
  messages d'erreur identiques · appelants : aucun · tests : T01, T03 · sources : [Parametre.class:Btn_Click](../../../../.src/Communs/Parametre.class#L295-L311), [Parametre.class:Form_Close](../../../../.src/Communs/Parametre.class#L313-L323)
- [ ] PARAMETRE-009 — [réduction de portée] `mcdt`, `meserrc`, `meserrt`, `Verif_Compte` →
  `Private` (aucun appelant externe ; couverts par replay) · appelants : aucun · tests : T04, T06 · sources : [Parametre.class:mcdt](../../../../.src/Communs/Parametre.class#L474-L491), [Parametre.class:meserrc](../../../../.src/Communs/Parametre.class#L555-L562), [Parametre.class:meserrt](../../../../.src/Communs/Parametre.class#L564-L571), [Parametre.class:Verif_Compte](../../../../.src/Communs/Parametre.class#L573-L584)
- [ ] PARAMETRE-010 — [commonalisation] `Verif_Compte` → `Utils.CompteExiste(sCompte)` et
  `Veriftva` → `Utils.TvaExiste(sCode)`, partagés avec `Moulinage`, `Calcsolde`, `Csolde`,
  `ClotureF`, `Facturergbl`, `ValidBR`, `ValidBR1`, `Fclientc`, `CPrix`, `Caisse` (chacun migré
  dans son propre rework) · appelants : aucun ici · tests : T04, T12 · sources : [Parametre.class:Verif_Compte](../../../../.src/Communs/Parametre.class#L573-L584), [Parametre.class:Veriftva](../../../../.src/Communs/Parametre.class#L586-L593), [CPrix.module:18](../../../../.src/Utils/CPrix.module#L18)
- [ ] PARAMETRE-011 — [séparation traitement/GUI] Grille TICPE : `LireArtTipp() As Result` et
  `EcrireArtTipp(aLignes)` (Edit/Create/Update identiques, transaction inchangée tant que
  PARAMETRE-A01 n'est pas validée) · appelants : aucun · tests : T09 · sources : [Parametre.class:Form_Open](../../../../.src/Communs/Parametre.class#L86-L182), [Parametre.class:Valtip_Click](../../../../.src/Communs/Parametre.class#L668-L688)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PARAMETRE-A01 — [anomalie] `Valtip_Click` ouvre une transaction (`Utils.db.Begin`) sans
  `Commit` : les lignes `Art_Tipp` ne sont validées que par le prochain `Commit` d'un autre écran,
  ou perdues à la déconnexion · tests : T09 · sources : [Parametre.class:675](../../../../.src/Communs/Parametre.class#L675)
- [ ] PARAMETRE-A02 — [anomalie] `IsNan(datefedec.dte.G)` au lieu de `IsNull` : une date de fin du
  dernier exercice clôturé vide n'est pas refusée (à confirmer : comportement de `IsNan` sur `Null`) · tests : T03 · sources : [Parametre.class:505](../../../../.src/Communs/Parametre.class#L505)
- [ ] PARAMETRE-A03 — [anomalie] Résultat de `DocActif.Get_Lock` ignoré : deux postes peuvent
  éditer les paramètres en même temps ; la fermeture libère ensuite un verrou qui peut appartenir à
  l'autre poste (dialogue « Forcer Libérer ») · tests : T11 · sources : [Parametre.class:95](../../../../.src/Communs/Parametre.class#L95), [Parametre.class:317](../../../../.src/Communs/Parametre.class#L317)
- [ ] PARAMETRE-A04 — [anomalie] `version` (version du schéma utilisée par `LauruxMaj` pour choisir
  les migrations) est modifiable par double-clic et réécrite à chaque enregistrement · tests : T02 · sources : [Parametre.class:Version_DblClick](../../../../.src/Communs/Parametre.class#L601-L605), [Parametre.class:537](../../../../.src/Communs/Parametre.class#L537)
- [ ] PARAMETRE-A05 — [anomalie] `Fiches_Societes` lue sans `WHERE` (première ligne) et mise à jour
  sans `WHERE` (`ident`, `caution`, `tipp`) : si la table contient plusieurs sociétés (cas prévu par
  `Fsoc` hors mode `Prefixe`, à confirmer), toutes reçoivent les mêmes valeurs · tests : T08 · sources : [Parametre.class:150](../../../../.src/Communs/Parametre.class#L150), [Parametre.class:541](../../../../.src/Communs/Parametre.class#L541), [Parametre.class:544](../../../../.src/Communs/Parametre.class#L544)
- [ ] PARAMETRE-A06 — [anomalie] Toute fermeture enregistre et la fenêtre ne peut pas être fermée
  sans saisie valide (`Stop Event`), même pour abandonner les modifications (le double
  enregistrement, lui, est traité sans changement de comportement par PARAMETRE-008) · tests : T03 · sources : [Parametre.class:Form_Close](../../../../.src/Communs/Parametre.class#L313-L323)
- [ ] PARAMETRE-A07 — [anomalie] `Dnbon_LostFocus`, `Dnfac_LostFocus`, `Dnclient_LostFocus`
  (préfixe 411) et `Dnfournisseur_LostFocus` (préfixe 401) ne sont jamais déclenchés : les
  contrôles appartiennent au groupe `Par` (à confirmer par replay). Les rebrancher (dans
  `Par_lostfocus`, selon le `Tag`) active des contrôles aujourd'hui absents · tests : T07 · sources : [Parametre.class:Dnclient_LostFocus](../../../../.src/Communs/Parametre.class#L444-L456), [Parametre.class:Dnfournisseur_LostFocus](../../../../.src/Communs/Parametre.class#L458-L472), [Parametre.class:Dnbon_LostFocus](../../../../.src/Communs/Parametre.class#L358-L369), [Parametre.class:Dnfac_LostFocus](../../../../.src/Communs/Parametre.class#L371-L382)
