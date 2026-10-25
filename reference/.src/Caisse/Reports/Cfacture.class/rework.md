# Cfacture — Rework

> Source : `.src/Caisse/Reports/Cfacture.class` · Message de commit (phase 4) : `reference/.src/Caisse/Reports/Cfacture.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 267 |
| Lignes de commentaire | 15 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 59 |
| Complexité max (fonction) | 8 (`Level1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 267 | 59 | 8 | 0 | 20 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CFACTURE-001 — [documentation] En-tête de classe : rôle (gabarit PDF caisse), table des
  rapports par format, appelants, usage de `Typel` (`"K"` commentaire), paramètre `Bold`
  d'`Entete` ignoré, dépendance à `Caisse.Ba4` · appelants : aucun · tests : aucun · sources : [Cfacture.class:_new](../../../../../.src/Caisse/Reports/Cfacture.class#L11-L47), [Cfacture.class:Entete](../../../../../.src/Caisse/Reports/Cfacture.class#L60-L70)
- [ ] CFACTURE-002 — [code mort] Supprimer `Logo` (remplacé par `Logo2`), `Level1T` et `_free`
  (jamais appelés, vérifié par `grep`) · appelants : aucun · tests : T01-T07 · sources : [Cfacture.class:Logo](../../../../../.src/Caisse/Reports/Cfacture.class#L309-L338), [Cfacture.class:Level1T](../../../../../.src/Caisse/Reports/Cfacture.class#L169-L192), [Cfacture.class:_free](../../../../../.src/Caisse/Reports/Cfacture.class#L49-L51)
- [ ] CFACTURE-003 — [complexité] Fusionner les branches identiques : `Typel = "TA"` de `Level1`,
  `If Caisse.Ba4` de `Level2F`/`Level4`, double `SetXY` d'`Entete3` (PDF identique, CC 59 → ~50)
  · appelants : aucun · tests : T02-T04 · sources : [Cfacture.class:Level1](../../../../../.src/Caisse/Reports/Cfacture.class#L135-L166), [Cfacture.class:Level2F](../../../../../.src/Caisse/Reports/Cfacture.class#L244-L258), [Cfacture.class:Level4](../../../../../.src/Caisse/Reports/Cfacture.class#L261-L284), [Cfacture.class:Entete3](../../../../../.src/Caisse/Reports/Cfacture.class#L86-L97)
- [ ] CFACTURE-004 — [commonalisation] Helper privé `Taille(bA4, iA4, iAutre)` pour les choix de
  police A4/autre (11 blocs) et `Trait(PosY, largeur)` pour `Lines`/`Lines2` ; signatures `Public`
  inchangées · appelants : aucun · tests : T01-T05 · sources : [Cfacture.class:Entete](../../../../../.src/Caisse/Reports/Cfacture.class#L60-L70), [Cfacture.class:Entete2](../../../../../.src/Caisse/Reports/Cfacture.class#L73-L83), [Cfacture.class:Level2T](../../../../../.src/Caisse/Reports/Cfacture.class#L118-L132), [Cfacture.class:Com](../../../../../.src/Caisse/Reports/Cfacture.class#L230-L241), [Cfacture.class:Lines](../../../../../.src/Caisse/Reports/Cfacture.class#L100-L106), [Cfacture.class:Lines2](../../../../../.src/Caisse/Reports/Cfacture.class#L109-L115)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CFACTURE-A01 — [anomalie] `Caisse.Ba4` est lu sur l'**auto-instance** de `Caisse` alors que
  la caisse affichée est créée par `New Caisse` (`Cmenu.class:253`) : `Caisse.Ba4` vaut toujours
  `False`. En A4, les lignes de ticket (`Level2T`, `Level1`, `Com`) prennent les polices et
  troncatures 80 mm, et l'intitulé des lignes de facture est tronqué à 28 caractères au lieu de 40
  (`Level4`). Effet de bord : lecture qui crée l'auto-instance du formulaire `Caisse`, aussi depuis
  `Moulinage.Livre_caisse`. Correction proposée : rapport A4 déduit de `GetFormat()` dans `_new`
  (à valider : change le rendu des tickets A4) · tests : T02, T04, T06, T08 · sources : [Cfacture.class:121](../../../../../.src/Caisse/Reports/Cfacture.class#L121), [Cfacture.class:138](../../../../../.src/Caisse/Reports/Cfacture.class#L138), [Cfacture.class:233](../../../../../.src/Caisse/Reports/Cfacture.class#L233), [Cfacture.class:275](../../../../../.src/Caisse/Reports/Cfacture.class#L275), [Caisse.class:140](../../../../../.src/Caisse/Caisse.class#L140), [Cmenu.class:253](../../../../../.src/Caisse/Cmenu.class#L253)
- [ ] CFACTURE-A02 — [anomalie] `Error.Raise("Unsupported Facture page format: " & form)` :
  `form` non déclaré (résolu en la classe `Form`), le message prévu n'est pas produit pour un format
  non géré (`dymoc`, `dymog`) ; branche aujourd'hui inatteignable par les appelants · tests : T01 · sources : [Cfacture.class:44](../../../../../.src/Caisse/Reports/Cfacture.class#L44)
- [ ] CFACTURE-A03 — [anomalie] `Logo2` : un logo absent ou d'un type autre que JPG/PNG fait
  lever `PdfWriter.Image`, non intercepté (`Caisse.Defaut_Tk` sans `Catch`) : l'impression du
  ticket s'arrête ; les coordonnées du logo ne suivent pas `$xratio`/`$yratio` · tests : T07 · sources : [Cfacture.class:Logo2](../../../../../.src/Caisse/Reports/Cfacture.class#L286-L307), [PdfWriter.class:1355](../../../../../.src/Reports/PdfWriter.class#L1355), [PdfWriter.class:1364](../../../../../.src/Reports/PdfWriter.class#L1364)
