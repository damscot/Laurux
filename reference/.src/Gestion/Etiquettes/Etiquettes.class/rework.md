# Etiquettes — Rework

> Source : `.src/Gestion/Etiquettes/Etiquettes.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Etiquettes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 228 |
| Lignes de commentaire | 26 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 73 |
| Complexité max (fonction) | 7 (`init_ComboBox`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 228 | 73 | 7 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIQUETTES-001 — [documentation] En-tête en français : rôle, table `Fiches_Etiquettes`
  (clé `(code, page)`, unités en dixièmes de mm), format du libellé `"<code>- <libellé>"`, liste
  des écrans consommateurs · appelants : aucun · tests : T01 · sources : [Etiquettes.class:_New](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L35-L52)
- [ ] ETIQUETTES-002 — [commonalisation] Les 8 handlers `*_KeyPress` délèguent à un helper privé
  `Suivant(hSuivant)` ; noms et portée des handlers inchangés · appelants : aucun · tests : T05 · sources : [Etiquettes.class:Nblargeur_KeyPress](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L206-L216), [Etiquettes.class:Esphauteur_KeyPress](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L290-L299)
- [ ] ETIQUETTES-003 — [complexité] `Observers2` renvoie un booléen (`ZonesRemplies`) au lieu du
  drapeau chaîne `Err` ; suppression du membre `CoulZnaf` (affecté, jamais lu) ; `Etiqr` et `tab` deviennent locaux
  · appelants : aucun · tests : T01, T04 · sources : [Etiquettes.class:Observers2](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L311-L327), [Etiquettes.class:Button3_Click](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L134-L153)
- [ ] ETIQUETTES-004 — [complexité] `Cbase.Table("TabEtiq")` à la place du littéral
  `Fiches_Etiquettes` (SQL émis identique) · appelants : aucun · tests : T01-T03 · sources : [Etiquettes.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L54-L82), [Etiquettes.class:Button3_Click](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L134-L153), [Etiquettes.class:PageFormat_Click](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L155-L174)
- [ ] ETIQUETTES-005 — [réduction de portée] `init_ComboBox`, `SetObservers`, `IsValidKey`,
  `ChkInput`, `Observers2` → `Private` · appelants : aucun · tests : T01-T05 · sources : [Etiquettes.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L54-L82), [Etiquettes.class:SetObservers](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L107-L119), [Etiquettes.class:IsValidKey](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L121-L126), [Etiquettes.class:ChkInput](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L301-L309), [Etiquettes.class:Observers2](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L311-L327)
- [ ] ETIQUETTES-006 — [séparation traitement/GUI] `LitFormat(code, page) As Result` et
  `EnregistreFormat(code, page, valeurs, libelle)` sans contrôle ; mêmes requêtes · appelants :
  aucun · tests : T01-T03 · sources : [Etiquettes.class:PageFormat_Click](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L155-L174), [Etiquettes.class:Button3_Click](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L134-L153)
- [ ] ETIQUETTES-007 — [commonalisation] Corps de `OBS_GotFocus`/`OBS_LostFocus` →
  `Utils.CouleurFocus(…)` partagé avec `Eticli` (ETICLI-010) ; handlers conservés · appelants :
  `Eticli` · tests : T05, ETICLI-T06 · sources : [Etiquettes.class:OBS_GotFocus](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L87-L95), [Etiquettes.class:OBS_LostFocus](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L97-L105), [Eticli.class:OBS_GotFocus](../../../../../.src/Gestion/Etiquettes/Eticli.class#L901-L909)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIQUETTES-A01 — [anomalie] Enregistrement sans contrôle du code ni du format de page :
  `Code_etiq` vide → ligne de code `""` ; libellé lu par `Mid$(…, 4)` (un texte saisi sans
  `"X- "` perd ses premiers caractères) ; `PageFormat` vide accepté · tests : T06 · sources : [Etiquettes.class:136](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L136), [Etiquettes.class:141](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L141), [Etiquettes.class:143](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L143)
- [ ] ETIQUETTES-A02 — [anomalie] `Code_etiq_Click` lit le format avec la page **précédemment**
  sélectionnée, puis repositionne la page sur `idx`, qui n'est pas remis à -1 quand la lecture
  échoue : la page affichée et les valeurs peuvent provenir de deux formats différents (à
  confirmer en replay) · tests : T03 · sources : [Etiquettes.class:Code_etiq_Click](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L176-L185), [Etiquettes.class:171](../../../../../.src/Gestion/Etiquettes/Etiquettes.class#L171)
