# Abont — Rework

> Source : `.src/Compta/Tables/Abont.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/Abont.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 438 |
| Lignes de commentaire | 77 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 125 |
| Complexité max (fonction) | 16 (`Colecr_Activate`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 438 | 125 | 16 | 0 | 27 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ABONT-001 — [documentation] En-tête en français : tables, expressions évaluées par
  `Saisecrit`/`Tresor`, écriture immédiate des lignes, usage de `Compteur_Incr` ; commentaire sur le
  handler vide `Intitule_KeyPress` (conservé) · appelants : aucun · tests : aucun · sources : [Abont.class:_New](../../../../../.src/Compta/Tables/Abont.class#L37-L82), [Abont.class:Button7_Click](../../../../../.src/Compta/Tables/Abont.class#L257-L290), [Abont.class:Intitule_KeyPress](../../../../../.src/Compta/Tables/Abont.class#L613-L617)
- [ ] ABONT-002 — [code mort] Supprimer `ChkPrx`, les membres `Tri` et `Dbl` (jamais lus), la
  locale `rResult` de `Colecr_Activate` · appelants : aucun · tests : T01-T05 · sources : [Abont.class:ChkPrx](../../../../../.src/Compta/Tables/Abont.class#L141-L149), [Abont.class:27](../../../../../.src/Compta/Tables/Abont.class#L27), [Abont.class:28](../../../../../.src/Compta/Tables/Abont.class#L28), [Abont.class:297](../../../../../.src/Compta/Tables/Abont.class#L297)
- [ ] ABONT-003 — [commonalisation] `Reinit()` pour la remise à zéro dupliquée dans `Button3_Click`
  et `Button5_Click` (mêmes affectations, `type = "A"` compris) ; `Bgestion_Click`/`Bbilan_Click` →
  procédure commune paramétrée · appelants : aucun · tests : T01, T05 · sources : [Abont.class:Button3_Click](../../../../../.src/Compta/Tables/Abont.class#L322-L382), [Abont.class:Button5_Click](../../../../../.src/Compta/Tables/Abont.class#L429-L448), [Abont.class:Bgestion_Click](../../../../../.src/Compta/Tables/Abont.class#L531-L546), [Abont.class:Bbilan_Click](../../../../../.src/Compta/Tables/Abont.class#L548-L563)
- [ ] ABONT-004 — [complexité] `Colecr_Activate` : table de correspondance premier chiffre → type
  de compte, même ordre d'application (CC 16 → ≤ 5) · appelants : aucun · tests : T03 · sources : [Abont.class:Colecr_Activate](../../../../../.src/Compta/Tables/Abont.class#L295-L317)
- [ ] ABONT-005 — [séparation traitement/GUI] `ProchainNumero()`, `EnregistreMasque(...)`,
  `SupprimeMasque(sCode)`, `SupprimeLigne(sCode, iLind)` sans contrôle ; SQL inchangé · appelants :
  aucun · tests : T01-T05 · sources : [Abont.class:Button2_Click](../../../../../.src/Compta/Tables/Abont.class#L212-L246), [Abont.class:Button3_Click](../../../../../.src/Compta/Tables/Abont.class#L322-L382), [Abont.class:Button5_Click](../../../../../.src/Compta/Tables/Abont.class#L429-L448), [Abont.class:Supprim_ligne](../../../../../.src/Compta/Tables/Abont.class#L387-L409)
- [ ] ABONT-006 — [réduction de portée] `FillColecr`, `Supprim_ligne`, `Deb3`, `Compteman` →
  `Private` ; `Compteur_Incr`, `Bsel`, `Bval` restent `Public` · appelants : aucun · tests : T01-T06 · sources : [Abont.class:FillColecr](../../../../../.src/Compta/Tables/Abont.class#L159-L182), [Abont.class:Supprim_ligne](../../../../../.src/Compta/Tables/Abont.class#L387-L409), [Abont.class:Deb3](../../../../../.src/Compta/Tables/Abont.class#L450-L473), [Abont.class:Compteman](../../../../../.src/Compta/Tables/Abont.class#L478-L495)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ABONT-A01 — [anomalie] `Message.Erreur` n'existe pas : un masque dont `typem <> "1"` provoque
  une erreur d'exécution à l'ouverture de l'écran et au clic. Proposition : `Message.Error` ·
  tests : T07 · sources : [Abont.class:201](../../../../../.src/Compta/Tables/Abont.class#L201), [Abont.class:468](../../../../../.src/Compta/Tables/Abont.class#L468)
- [ ] ABONT-A02 — [anomalie] « Modifier une ligne » supprime la ligne en base avant la ressaisie :
  abandon = ligne perdue ; la ligne réenregistrée passe en dernière position · tests : T03, T04 · sources : [Abont.class:311](../../../../../.src/Compta/Tables/Abont.class#L311)
- [ ] ABONT-A03 — [anomalie] Suppression d'un masque et de ses lignes sans confirmation · tests : T05 · sources : [Abont.class:Button5_Click](../../../../../.src/Compta/Tables/Abont.class#L429-L448)
- [ ] ABONT-A04 — [anomalie] Après suppression, `type = "A"` (type de compte inexistant) : le
  contrôle de compte échoue jusqu'au clic sur un type ; après validation, `type` est corrigé par
  `Bfournisseur_Click` · tests : T05 · sources : [Abont.class:440](../../../../../.src/Compta/Tables/Abont.class#L440), [Abont.class:362](../../../../../.src/Compta/Tables/Abont.class#L362)
- [ ] ABONT-A05 — [anomalie] `Button3_Click` lit `Colabt.Current.Key` pour un masque existant :
  erreur si aucune ligne de `Colabt` n'est sélectionnée · tests : T01 · sources : [Abont.class:339](../../../../../.src/Compta/Tables/Abont.class#L339)
- [ ] ABONT-A06 — [anomalie] `Compteur_Incr` appelée sur l'auto-instance du formulaire depuis
  `Saisecrit`/`Tresor` : instancie un `Abont` caché (SQL de `Deb3`, observateurs). Proposition :
  méthode `Static` ou module ; impact sur les logs de replay à valider · appelants : `Saisecrit.LignAbt`,
  `Tresor.LignAbt` · tests : T06 · sources : [Abont.class:Compteur_Incr](../../../../../.src/Compta/Tables/Abont.class#L619-L623), [Saisecrit.class:3047](../../../../../.src/Compta/Saisecrit.class#L3047), [Tresor.class:2555](../../../../../.src/Compta/Tresor.class#L2555)
