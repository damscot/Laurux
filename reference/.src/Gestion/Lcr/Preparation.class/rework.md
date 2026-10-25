# Preparation — Rework

> Source : `.src/Gestion/Lcr/Preparation.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Preparation.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 644 |
| Lignes de commentaire | 45 |
| Fonctions | 51 |
| Fonctions Public | 51 |
| Complexité cyclomatique totale | 135 |
| Complexité max (fonction) | 16 (`Imp_Lcr`) |
| Variables globales | 0 |
| Variables Public | 8 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 644 | 135 | 16 | 0 | 51 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PREPARATION-001 — [documentation] En-tête en français : étape 3 de la chaîne LCR, rôle du code
  entrée, contenu d'une ligne de `Fiches_Bordereaux`, marquage par clic droit · appelants : aucun ·
  tests : aucun · sources : [Preparation.class:_New](../../../../../.src/Gestion/Lcr/Preparation.class#L63-L95), [Preparation.class:Button12_Click](../../../../../.src/Gestion/Lcr/Preparation.class#L601-L656)
- [ ] PREPARATION-002 — [code mort] Supprimer `N_click`, `A_click`, `Button5_Click` (contrôles
  absents), `Button7_Click`/`compte` (bouton invisible), la lecture de `Fiches_Lcr` de `_New` (`Nb`
  jamais lu ; SQL modifié, dump identique), le second `Total()` de `Form_Open`, les membres
  inutilisés (`tab`, `rs1`, `txt`, `rResult`, `Dbl`, `CoulB`, `CoulF`, `Fnt`, `CoulZns`, `CoulZnaf`,
  `Coulfond`, `nv`, `Dte1`, `Type`, `PosX`, `sCmpt`, `sdesg`) et les locales inutilisées ·
  appelants : aucun · tests : T01-T10 · sources : [Preparation.class:N_click](../../../../../.src/Gestion/Lcr/Preparation.class#L453-L458),
  [Preparation.class:A_click](../../../../../.src/Gestion/Lcr/Preparation.class#L460-L465), [Preparation.class:Button5_Click](../../../../../.src/Gestion/Lcr/Preparation.class#L706-L710), [Preparation.class:Button7_Click](../../../../../.src/Gestion/Lcr/Preparation.class#L712-L716),
  [Preparation.class:92](../../../../../.src/Gestion/Lcr/Preparation.class#L92), [Preparation.class:102](../../../../../.src/Gestion/Lcr/Preparation.class#L102)
- [ ] PREPARATION-003 — [réduction de portée] `Entete`, `Tris`, `Deb`, `Deb2`, `Deb3`, `Deb4`, `Total`,
  `Refresh`, `CleanChamps`, `Maj_Zones`, `compteman`, `Imp_Lcr`, `Nb`, `sDate`, `iLind`,
  `ControleCombobox` → `Private` (handlers et `Bsel`/`Bval` restent `Public`) · appelants : aucun ·
  tests : T01-T10 · sources : [Preparation.class:Deb3](../../../../../.src/Gestion/Lcr/Preparation.class#L387-L405), [Preparation.class:Total](../../../../../.src/Gestion/Lcr/Preparation.class#L417-L451),
  [Preparation.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Preparation.class#L767-L837)
- [ ] PREPARATION-004 — [complexité] `ColLcr_Data` : cache des noms de banques, `Lcrtable`
  initialisé une fois (SQL modifié, affichage identique) · appelants : aucun · tests : T01, T02 ·
  sources : [Preparation.class:ColLcr_Data](../../../../../.src/Gestion/Lcr/Preparation.class#L295-L328)
- [ ] PREPARATION-005 — [séparation traitement/GUI] Extraire `GenereBordereau(…) As Integer`,
  `MajCodeEntree(linds, code)`, `MajLcr(…)` et les requêtes `Deb*`/`Imp_Lcr` ; SQL inchangé ·
  appelants : aucun · tests : T04-T10 · sources : [Preparation.class:Button12_Click](../../../../../.src/Gestion/Lcr/Preparation.class#L601-L656),
  [Preparation.class:Button3_Click](../../../../../.src/Gestion/Lcr/Preparation.class#L677-L695)
- [ ] PREPARATION-006 — [commonalisation] Fonctions communes avec `Attribution`/`Lcr` (module LCR de
  phase 3) : `Total`, `Deb4`, `DAE_KeyPress`, `ColLcr_Data`, `Maj_Zones`, `compteman`, `Imp_Lcr`,
  liste des banques, boucle d'application aux lignes de la grille · appelants : aucun · tests :
  T01-T10 et replays d'`Attribution` · sources : [Preparation.class:Total](../../../../../.src/Gestion/Lcr/Preparation.class#L417-L451),
  [Attribution.class:Total](../../../../../.src/Gestion/Lcr/Attribution.class#L390-L424), [Preparation.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Preparation.class#L767-L837), [Attribution.class:Button10_Click](../../../../../.src/Gestion/Lcr/Attribution.class#L511-L541)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PREPARATION-A01 — [anomalie] **Grave** : l'`INSERT` de `Fiches_Bordereaux` passe `BQ.Text`
  (« 1 - Banque ») et `Entree3.Text` (« 1- Escompte ») dans des colonnes `int(1)` et utilise `value` :
  en MariaDB strict (et sous SQLite) il échoue **après** le marquage des LCR (pas de transaction) →
  LCR rattachées à un bordereau inexistant, invisibles partout (`bordereau <> 0`). Passer
  `Left$(…, 1)` et une transaction · tests : T06, T11 · sources : [Preparation.class:639](../../../../../.src/Gestion/Lcr/Preparation.class#L639),
  [Preparation.class:630](../../../../../.src/Gestion/Lcr/Preparation.class#L630)
- [ ] PREPARATION-A02 — [anomalie] Sélection du bordereau (`Deb3`) : dates d'échéance concaténées
  sans guillemets (filtre faux) et LCR écartées non exclues · tests : T07 · sources :
  [Preparation.class:395](../../../../../.src/Gestion/Lcr/Preparation.class#L395), [Preparation.class:Deb3](../../../../../.src/Gestion/Lcr/Preparation.class#L387-L405)
- [ ] PREPARATION-A03 — [anomalie] Recherche par échéance : `Deb4` `And`/`Or` sans parenthèses
  (liste et comptage), motif `DAE_KeyPress` retransformé · tests : T03 · sources :
  [Preparation.class:Deb4](../../../../../.src/Gestion/Lcr/Preparation.class#L407-L415), [Preparation.class:DAE_KeyPress](../../../../../.src/Gestion/Lcr/Preparation.class#L199-L218)
- [ ] PREPARATION-A04 — [anomalie] Marquage : premier clic droit sans effet visible (`""` → `"False"`)
  et boucle `For x = 0 To Enrg` d'une ligne au-delà de la grille · tests : T05 · sources :
  [Preparation.class:ColLcr_MouseUp](../../../../../.src/Gestion/Lcr/Preparation.class#L507-L524), [Preparation.class:683](../../../../../.src/Gestion/Lcr/Preparation.class#L683)
- [ ] PREPARATION-A05 — [anomalie] `Button2_Click` supprime la LCR **sans confirmation** (et lève une
  erreur sans sélection) · tests : T09 · sources : [Preparation.class:Button2_Click](../../../../../.src/Gestion/Lcr/Preparation.class#L661-L672)
- [ ] PREPARATION-A06 — [anomalie] `Imp_Lcr` imprime aussi les LCR écartées et déjà en bordereau ;
  pas d'en-tête de colonnes après un saut de page · tests : T10 · sources : [Preparation.class:787](../../../../../.src/Gestion/Lcr/Preparation.class#L787),
  [Preparation.class:822](../../../../../.src/Gestion/Lcr/Preparation.class#L822)
- [ ] PREPARATION-A07 — [anomalie] Couleur de fond lue par `Settings[...]` au lieu de
  `Start.LocalSettings` (ignore `-c`) ; premier `Chainage` écrasé (enchaînement de `Entree3`,
  `Dteremise`, `refremise`, `Dtevaleur` à confirmer) · tests : T06 · sources : [Preparation.class:77](../../../../../.src/Gestion/Lcr/Preparation.class#L77),
  [Preparation.class:80](../../../../../.src/Gestion/Lcr/Preparation.class#L80)
- [ ] PREPARATION-A08 — [anomalie] Numéro de bordereau = dernier `lind` + 1 : après une suppression
  du dernier bordereau dans `Bordrx`, le numéro est réutilisé ; la fin de la boucle de marquage
  repose sur un `MoveTo` hors bornes (à confirmer) · tests : T08 · sources : [Preparation.class:619](../../../../../.src/Gestion/Lcr/Preparation.class#L619),
  [Preparation.class:628](../../../../../.src/Gestion/Lcr/Preparation.class#L628)
