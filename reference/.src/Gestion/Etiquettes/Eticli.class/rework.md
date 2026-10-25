# Eticli — Rework

> Source : `.src/Gestion/Etiquettes/Eticli.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Eticli.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 702 |
| Lignes de commentaire | 70 |
| Fonctions | 39 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 180 |
| Complexité max (fonction) | 31 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 702 | 180 | 31 | 0 | 39 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETICLI-001 — [documentation] En-tête en français : rôle, modes plage/liste, options type/CP
  (CP non appliqué), table temporaire `Etiquettes`, `Utils.rs1` · appelants : aucun · tests : T01 · sources : [Eticli.class:_New](../../../../../.src/Gestion/Etiquettes/Eticli.class#L59-L93)
- [ ] ETICLI-002 — [code mort] Supprimer les membres jamais lus (`nombretiq`, `SorP`, `txtWidth`,
  `CoulZnaf`), le paramètre inutilisé `hClass` de `SetObservers` (appel interne seul) et le
  `Shell "cd ~"` · appelants : aucun · tests : T01-T07 · sources : [Eticli.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Eticli.class#L736-L832), [Eticli.class:766](../../../../../.src/Gestion/Etiquettes/Eticli.class#L766), [Eticli.class:SetObservers](../../../../../.src/Gestion/Etiquettes/Eticli.class#L921-L933)
- [ ] ETICLI-003 — [commonalisation] Fusion interne `Tris`/`Tris2`, `AffClients`/`AffClients2`,
  `ToggleButton3`/`4`, `ColType_KeyPress`/`ColType2_KeyPress` en fonctions paramétrées par le
  contrôle ; handlers conservés · appelants : aucun · tests : T02, T06 · sources : [Eticli.class:Tris](../../../../../.src/Gestion/Etiquettes/Eticli.class#L139-L149), [Eticli.class:AffClients2](../../../../../.src/Gestion/Etiquettes/Eticli.class#L247-L257), [Eticli.class:ToggleButton3_Click](../../../../../.src/Gestion/Etiquettes/Eticli.class#L417-L449), [Eticli.class:ToggleButton4_Click](../../../../../.src/Gestion/Etiquettes/Eticli.class#L479-L511)
- [ ] ETICLI-004 — [complexité] `Button2_Click` (CC 31) : construction de la requête par options
  (`RequeteClients`) et boucle séparées ; **SQL émis identique** cas par cas (y compris les `cast`
  incohérents) · appelants : aucun · tests : T01-T04, T08 · sources : [Eticli.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/Eticli.class#L736-L832)
- [ ] ETICLI-005 — [commonalisation] Table de travail `Etiquettes` (temporaire) via
  `EtiqArticles.TableListe` (ETIQART-005) · appelants : `Etiqart`, `Etigond`, `Etiqcasier` ·
  tests : T05 · sources : [Eticli.class:liste_Click](../../../../../.src/Gestion/Etiquettes/Eticli.class#L591-L617), [Eticli.class:Cli_Man](../../../../../.src/Gestion/Etiquettes/Eticli.class#L301-L325)
- [ ] ETICLI-006 — [séparation traitement/GUI] `Cli_Man` : ajout en table sans `Message` ;
  requêtes dans `RequeteClients` sans accès aux contrôles · appelants : aucun · tests : T01-T05 · sources : [Eticli.class:Cli_Man](../../../../../.src/Gestion/Etiquettes/Eticli.class#L301-L325)
- [ ] ETICLI-007 — [réduction de portée] `init_ComboBox`, `Tris`, `Tris2`, `colinit`, `AffClients`,
  `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`, `Imprime`, `fin_impression`, `pos_Etiq`,
  `SetObservers` → `Private` · appelants : aucun · tests : T01-T08 · sources : [Eticli.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/Eticli.class#L95-L110), [Eticli.class:colinit](../../../../../.src/Gestion/Etiquettes/Eticli.class#L209-L227), [Eticli.class:Imprime](../../../../../.src/Gestion/Etiquettes/Eticli.class#L834-L860), [Eticli.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Eticli.class#L877-L899)
- [ ] ETICLI-008 — [commonalisation] Format, `pos_Etiq` (V1, identique à `Etiqart.pos_Etiq`),
  dessin d'adresse et sortie via `PlancheEtiquettes` (après ETIQART-010, avec FCLIENT-014) ; PDF
  identique · appelants : aucun · tests : T01, T07 · sources : [Eticli.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Eticli.class#L877-L899), [Eticli.class:Imprime](../../../../../.src/Gestion/Etiquettes/Eticli.class#L834-L860), [Eticli.class:fin_impression](../../../../../.src/Gestion/Etiquettes/Eticli.class#L862-L875), [Etiqart.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Etiqart.class#L957-L979), [FClient.class:Imprime](../../../../../.src/Gestion/Tables/FClient.class#L2517-L2534)
- [ ] ETICLI-009 — [complexité] `Cbase.Table` pour `Fiches_Cli`, `Fiches_Typec`,
  `Fiches_Etiquettes` (SQL identique) ; un seul `Utils.Observers(Me)` (dump inchangé, log sans
  doublons) · appelants : aucun · tests : T01-T08 · sources : [Eticli.class:72](../../../../../.src/Gestion/Etiquettes/Eticli.class#L72), [Eticli.class:90](../../../../../.src/Gestion/Etiquettes/Eticli.class#L90), [Eticli.class:Cli_Man](../../../../../.src/Gestion/Etiquettes/Eticli.class#L301-L325)
- [ ] ETICLI-010 — [commonalisation] Corps de `OBS_GotFocus`/`OBS_LostFocus` →
  `Utils.CouleurFocus` (ETIQUETTES-007) ; handlers conservés · appelants : `Etiquettes` · tests :
  T05 · sources : [Eticli.class:OBS_GotFocus](../../../../../.src/Gestion/Etiquettes/Eticli.class#L901-L909), [Eticli.class:OBS_LostFocus](../../../../../.src/Gestion/Etiquettes/Eticli.class#L911-L919)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETICLI-A01 — [anomalie] Les bornes de code postal `Cp1`/`Cp2` (option `CheckCp`) ne sont
  utilisées dans aucune requête : seul le tri par CP est appliqué · tests : T03 · sources : [Eticli.class:778](../../../../../.src/Gestion/Etiquettes/Eticli.class#L778), [Eticli.class:789](../../../../../.src/Gestion/Etiquettes/Eticli.class#L789)
- [ ] ETICLI-A02 — [anomalie] Bornes client comparées en texte (`cast(cli_code as char) >= &1`)
  pour la borne basse et en nombre pour la borne haute (3 requêtes sur 5) ; en mode liste
  `cli_code >= &1` sans `ORDER BY` au lieu de `=` · tests : T04, T05 · sources : [Eticli.class:777](../../../../../.src/Gestion/Etiquettes/Eticli.class#L777), [Eticli.class:781](../../../../../.src/Gestion/Etiquettes/Eticli.class#L781), [Eticli.class:805](../../../../../.src/Gestion/Etiquettes/Eticli.class#L805)
- [ ] ETICLI-A03 — [anomalie] `RadioButton2` coché puis `CheckType` décoché : aucune requête,
  `rCli` `Null` (ou résultat précédent) → erreur ou impression du jeu précédent ; `Imprime` lit
  `rCli` sans test `Available` · tests : T08 · sources : [Eticli.class:776](../../../../../.src/Gestion/Etiquettes/Eticli.class#L776), [Eticli.class:Imprime](../../../../../.src/Gestion/Etiquettes/Eticli.class#L834-L860)
- [ ] ETICLI-A04 — [anomalie] `colinit` appelle toujours `AffClients` : un tri sur `Colcli2`
  réinitialise les colonnes et le focus de `Colcli` ; format lu par `code` seul et PDF toujours en
  A4 Portrait (page du modèle ignorée) · tests : T06, T07 · sources : [Eticli.class:colinit](../../../../../.src/Gestion/Etiquettes/Eticli.class#L209-L227), [Eticli.class:750](../../../../../.src/Gestion/Etiquettes/Eticli.class#L750), [Eticli.class:769](../../../../../.src/Gestion/Etiquettes/Eticli.class#L769)
