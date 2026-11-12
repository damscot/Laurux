# ReplayObserver — Rework

> Source : `.src/Utils/ReplayObserver.class` · Message de commit (phase 4) : `.hidden/reference/.src/Utils/ReplayObserver.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 261 |
| Lignes de commentaire | 27 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 86 |
| Complexité max (fonction) | 26 (`Replay_Event`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 261 | 86 | 26 | 0 | 15 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] REPLAYOBSERVER-001 — [documentation] En-tête : capture vs rejeu, format de la ligne `GUI`,
  classes de contrôles supportées par événement, limites connues · appelants : aucun · tests : aucun · sources : [ReplayObserver.class:_new](../../../../../.src/Utils/ReplayObserver.class#L5-L10), [ReplayObserver.class:Replay_Event](../../../../../.src/Utils/ReplayObserver.class#L229-L359)
- [ ] REPLAYOBSERVER-002 — [code mort] Supprimer `Object()`, `Source()`, les blocs commentés de
  `Observer_MouseUp`/`MouseDown` et les variables `Value`/`out`/`menu`/`Check` inutilisées ·
  appelants : aucun · tests : T02 à T05 · sources : [ReplayObserver.class:Object](../../../../../.src/Utils/ReplayObserver.class#L123-L127), [ReplayObserver.class:Source](../../../../../.src/Utils/ReplayObserver.class#L129-L133), [ReplayObserver.class:Observer_MouseUp](../../../../../.src/Utils/ReplayObserver.class#L73-L89), [ReplayObserver.class:Observer_MouseDown](../../../../../.src/Utils/ReplayObserver.class#L91-L105)
- [ ] REPLAYOBSERVER-003 — [séparation traitement/GUI] Extraire `AnalyseLigne(Action)` (pure, même
  découpage et mêmes erreurs) de `Replay_Event` (CC 26 → ≤ 12) · appelants : `Start.module` (inchangé) ·
  tests : T01, T02, T07 · sources : [ReplayObserver.class:Replay_Event](../../../../../.src/Utils/ReplayObserver.class#L229-L359), [ReplayObserver.class:246-264](../../../../../.src/Utils/ReplayObserver.class#L246-L264)
- [ ] REPLAYOBSERVER-004 — [commonalisation] Utiliser l'énumération des champs du log
  (DB_CONNECTION-013) dans `AnalyseLigne` · appelants : aucun · tests : T01 · sources : [ReplayObserver.class:Replay_Event](../../../../../.src/Utils/ReplayObserver.class#L229-L359)
- [ ] REPLAYOBSERVER-005 — [complexité] `Observer_Click` et `Replay_Click` : `Select Case` sur le nom
  de classe calculé une fois (CC 13 et 17 → ≤ 6 visé) · appelants : aucun · tests : T02, T04, T05 · sources : [ReplayObserver.class:Observer_Click](../../../../../.src/Utils/ReplayObserver.class#L12-L42), [ReplayObserver.class:Replay_Click](../../../../../.src/Utils/ReplayObserver.class#L136-L191)
- [ ] REPLAYOBSERVER-006 — [réduction de portée] `Replay_Click`, `Replay_Keypress`, `Replay_Close`,
  `Replay_Focus` → `Static Private` · appelants : aucun · tests : T02 à T05 · sources : [ReplayObserver.class:Replay_Click](../../../../../.src/Utils/ReplayObserver.class#L136-L191), [ReplayObserver.class:Replay_Keypress](../../../../../.src/Utils/ReplayObserver.class#L193-L212), [ReplayObserver.class:Replay_Close](../../../../../.src/Utils/ReplayObserver.class#L214-L218), [ReplayObserver.class:Replay_Focus](../../../../../.src/Utils/ReplayObserver.class#L221-L227)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] REPLAYOBSERVER-A01 — [anomalie] Analyse non robuste : valeur contenant `;`, `#`, `@`, `=` ;
  date supposée `MM/JJ/AAAA` avec millisecondes obligatoires · tests : T01 · sources : [ReplayObserver.class:246-264](../../../../../.src/Utils/ReplayObserver.class#L246-L264)
- [ ] REPLAYOBSERVER-A02 — [anomalie] `Replay_Keypress` appelle `SendKeys` (hérité) au lieu de
  `SendKey` : pas de rejeu clavier sous Wayland ; code non supporté → chaîne vide envoyée · tests : T03 · sources : [ReplayObserver.class:Replay_Keypress](../../../../../.src/Utils/ReplayObserver.class#L193-L212), [ReplayObserver.class:210](../../../../../.src/Utils/ReplayObserver.class#L210)
- [ ] REPLAYOBSERVER-A03 — [anomalie] `Observer_Keypress` journalise par code les caractères hors
  `Space..z` (accents, `{|}~`) que le rejeu ne sait pas reproduire · tests : T03 · sources : [ReplayObserver.class:Observer_Keypress](../../../../../.src/Utils/ReplayObserver.class#L44-L57), [ReplayObserver.class:50](../../../../../.src/Utils/ReplayObserver.class#L50)
- [ ] REPLAYOBSERVER-A04 — [anomalie] `Replay_Click` : `ListView` non rejoué ; `_Click` appelé sur
  `ctx.Window` (faux pour un `UserControl` ou un `Group`) ; clic `Label` sous Wayland asynchrone ·
  tests : T04, T05 · sources : [ReplayObserver.class:Replay_Click](../../../../../.src/Utils/ReplayObserver.class#L136-L191), [ReplayObserver.class:149](../../../../../.src/Utils/ReplayObserver.class#L149), [ReplayObserver.class:159-160](../../../../../.src/Utils/ReplayObserver.class#L159-L160), [ReplayObserver.class:173-175](../../../../../.src/Utils/ReplayObserver.class#L173-L175)
- [ ] REPLAYOBSERVER-A05 — [anomalie] `Replay_Event` quitte l'application (`Quit`) si la fenêtre active
  diffère ; recherche limitée aux enfants directs · tests : T06 · sources : [ReplayObserver.class:276-282](../../../../../.src/Utils/ReplayObserver.class#L276-L282), [ReplayObserver.class:298-326](../../../../../.src/Utils/ReplayObserver.class#L298-L326)
- [ ] REPLAYOBSERVER-A06 — [anomalie][harnais] Remplacer le contournement
  `Object.Call(ctx.window, ctx.Name & "_Click")` (GridView, ColumnView, ListBox) par
  `Object.Raise(ctx, "Click")`, et rétablir la branche `ListView` de la même façon. Le clic rejoué
  suit alors le chemin d'un vrai clic : handler du **groupe** si le contrôle est groupé (corrige
  `Saisecrit` : `Ecrit1_Click` inexistant), `Last` positionné sur le contrôle, routage correct pour un
  `UserControl`. Vérifié sur Gambas 3.19 par un projet de test (`ListBox` nommée et groupée) :
  `Object.Raise` appelle le bon handler `Public`, `Object.Call` ne voit jamais une méthode `Private`
  (même via `Me`), et un handler `Private` n'est jamais levé. Résout en grande partie A04 ; rend sans
  objet le champ `replay_dynamic` de `deps.py`. Modifie le harnais de rejeu (pas la GUI) : à appliquer
  **aux deux clones** avant l'enregistrement des scénarios de phase 2 si l'utilisateur le valide ·
  tests : T04 · sources : [ReplayObserver.class:149](../../../../../.src/Utils/ReplayObserver.class#L149), [ReplayObserver.class:158](../../../../../.src/Utils/ReplayObserver.class#L158), [ReplayObserver.class:159-160](../../../../../.src/Utils/ReplayObserver.class#L159-L160), [ReplayObserver.class:163](../../../../../.src/Utils/ReplayObserver.class#L163)
- [ ] REPLAYOBSERVER-A07 — [anomalie][harnais] Capture : les fenêtres que Laurux ne crée pas lui-même (`FMessage` des boîtes `Message.*` de gb.form, sélecteurs de fichiers `Dialog`) ne reçoivent jamais d'observateur (`Utils.Observers` n'est appelé que sur les formulaires de Laurux) : en mode journal (`-l`), la réponse de l'utilisateur à une boîte n'est pas journalisée et un scénario capturé n'est pas rejouable tel quel (lignes `FMessage` écrites à la main jusqu'ici). **Résolution proposée** : en mode journal seulement, un minuteur léger détecte toute nouvelle fenêtre active non observée et lui attache les observateurs (`Utils.Recursive_Observers`) ; il tourne aussi dans la boucle d'événements de la boîte modale (phase 2, vague 2 bis, 2026-11-12 ; correction différée, décision utilisateur) · tests : FMENU-T02, T04, T14, T20 (capture) · sources : [Utils.module:Observers](../../../../../.src/Utils/Utils.module#L1021), [Utils.module:Recursive_Observers](../../../../../.src/Utils/Utils.module#L869)
- [ ] REPLAYOBSERVER-A08 — [anomalie][harnais] (mesuré vague 2 bis : à la fermeture d'un `ShowModal`, la référence reprend l'horodatage de l'événement qui l'a ouvert, ce qui double la durée de chaque bloc modal : FMENU-T12 = 38 s de scénario → 142 s de rejeu) Délais du rejeu décalés d'un rang : `Replay_Event` rejoue l'événement N puis arme le minuteur avec l'écart (N-1 → N) au lieu de (N → N+1) ; de plus, quand un clic ouvre une fenêtre modale, la référence `Start.Ev` n'est mise à jour qu'à sa fermeture. Effets : rejeu environ deux fois plus long que les horodatages du `scenario.log` (`retime -n`), un clic qui suit une ouverture de fenêtre peut partir trop tôt (`mdp_mdp_local_ok` : clic Quitter 50 ms après Entrée, échec instable code 3 ; PREFS-T14 : Quitter rejoué deux fois). **Résolution proposée** : armer le minuteur avec l'écart entre l'événement rejoué et le suivant (`Start.Evens[Evc]`) et mettre à jour la référence à chaque événement ; puis `retime` et revalidation de tous les scénarios (phase 2, vague 2 bis, 2026-11-12 ; correction différée, décision utilisateur) · tests : MDP-T01 (`mdp_mdp_local_ok`), PREFS-T14, tous les rejeux (durée) · sources : [ReplayObserver.class:332](../../../../../.src/Utils/ReplayObserver.class#L332), [Start.module:ReplayTimer_Timer](../../../../../.src/Start.module#L391)
- [ ] REPLAYOBSERVER-A09 — [anomalie][harnais] Clic de `ListBox` exécuté deux fois au rejeu (affectation d'`Index`, qui déclenche `_Click`, puis appel explicite de `_Click`) : TriEcritures s'ouvre deux fois dans TRESOR-T05 (seconde fenêtre fermée par un `Close` du scénario). Correction : n'appeler `_Click` que si l'affectation ne l'a pas déclenché (phase 2, vague 2 bis, 2026-11-12 ; correction différée) · tests : TRESOR-T05 · sources : [ReplayObserver.class:Replay_Click](../../../../../.src/Utils/ReplayObserver.class#L136)
- [ ] REPLAYOBSERVER-A10 — [anomalie][harnais] Un écart de plus de 20 s entre deux événements est ramené à 1 s (`waiting > 20000`) : une attente longue (tick de minuteur à 60 s, FMENU-T19) doit être simulée par des événements inoffensifs intermédiaires. Correction possible : plafond supprimé ou porté au délai du scénario (phase 2, vague 2 bis, 2026-11-12 ; correction différée) · tests : FMENU-T19 · sources : [ReplayObserver.class:334](../../../../../.src/Utils/ReplayObserver.class#L334)
