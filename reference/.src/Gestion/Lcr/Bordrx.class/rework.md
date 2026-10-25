# Bordrx — Rework

> Source : `.src/Gestion/Lcr/Bordrx.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Bordrx.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 460 |
| Lignes de commentaire | 43 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 78 |
| Complexité max (fonction) | 21 (`Button3_Click`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 460 | 78 | 21 | 0 | 17 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BORDRX-001 — [documentation] En-tête en français : étape finale de la chaîne LCR, structure
  des enregistrements `0360`/`0660`/`1660`/`0860` (positions et longueurs), règles d'impression des
  adresses, nommage des fichiers produits · appelants : aucun · tests : aucun ·
  sources : [Bordrx.class:Button3_Click](../../../../../.src/Gestion/Lcr/Bordrx.class#L390-L539)
- [ ] BORDRX-002 — [code mort] Supprimer le `Print Error, Error.Text` de débogage, `filename2`, les
  `Shell "cd …"`, les membres `Public` inutilisés (`sCmpt`, `sdesg`, `Nb`, `sDate`, `iLind`,
  `ControleCombobox`, `Bsel`) et privés inutilisés (`tab`, `rs1`, `txt`, `B`, `rResult`, `sKey`,
  `Dbl`, `CoulB`, `CoulF`, `Fnt`, `CoulZns`, `CoulZnaf`, `Coulfc`, `nv`, `Dte1`, `Type`), les
  locales inutilisées de `Gen_Bordereau`/`Button3_Click` · appelants : aucun · tests : T01-T10 ·
  sources : [Bordrx.class:325](../../../../../.src/Gestion/Lcr/Bordrx.class#L325), [Bordrx.class:Gen_Bordereau](../../../../../.src/Gestion/Lcr/Bordrx.class#L285-L387), [Bordrx.class:Button3_Click](../../../../../.src/Gestion/Lcr/Bordrx.class#L390-L539)
- [ ] BORDRX-003 — [réduction de portée] `Tris`, `Entete`, `Deb`, `Deb2`, `Gen_Bordereau` → `Private`
  (`ColBrd_Click` et handlers restent `Public`) · appelants : aucun · tests : T01, T02 ·
  sources : [Bordrx.class:Gen_Bordereau](../../../../../.src/Gestion/Lcr/Bordrx.class#L285-L387), [Bordrx.class:Deb](../../../../../.src/Gestion/Lcr/Bordrx.class#L162-L166)
- [ ] BORDRX-004 — [séparation traitement/GUI] Extraire de `Button3_Click` une fonction pure
  `EnregistrementsLcr(banque, bordereau, lignes) As String[]` et la lecture des données ; fichier
  produit identique octet par octet (y compris les erreurs actuelles de complétion) · appelants :
  aucun · tests : T03-T08, T11 · sources : [Bordrx.class:Button3_Click](../../../../../.src/Gestion/Lcr/Bordrx.class#L390-L539)
- [ ] BORDRX-005 — [complexité] `Button10_Click` : un seul `UPdate … WHERE bordereau = &1` au lieu
  de sa répétition pour chaque LCR (SQL modifié, dump identique) · appelants : aucun · tests : T09 ·
  sources : [Bordrx.class:223](../../../../../.src/Gestion/Lcr/Bordrx.class#L223)
- [ ] BORDRX-006 — [commonalisation] Lecture des coordonnées bancaires commune à `Gen_Bordereau` et
  `Button3_Click` (et `Preparation.Button10_Click`) · appelants : aucun · tests : T02-T05 ·
  sources : [Bordrx.class:337](../../../../../.src/Gestion/Lcr/Bordrx.class#L337), [Bordrx.class:438](../../../../../.src/Gestion/Lcr/Bordrx.class#L438), [Preparation.class:583](../../../../../.src/Gestion/Lcr/Preparation.class#L583)
- [ ] BORDRX-007 — [complexité] `ColBrd_Data` : cache des noms de banques, `Brdtable` initialisé une
  fois (SQL modifié, affichage identique) · appelants : aucun · tests : T01 ·
  sources : [Bordrx.class:ColBrd_Data](../../../../../.src/Gestion/Lcr/Bordrx.class#L134-L160)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BORDRX-A01 — [anomalie] **Grave** : l. 383 `Impression.Prog_Editeur(… Start.Soc …)` —
  méthode et membre inexistants (IMPRESSION-A03) : l'envoi à une banque ayant un mail lève une
  erreur non interceptée **après** l'écriture du fichier et le passage à `etat = 1` ; le mail n'est
  jamais envoyé. Correction : supprimer l'ouverture (ou `Visualiseur.Prog`) avec `Start.Societe` ·
  tests : T06 · sources : [Bordrx.class:383](../../../../../.src/Gestion/Lcr/Bordrx.class#L383)
- [ ] BORDRX-A02 — [anomalie] Pièce jointe PDF `<Fichiers>/Lcr<société>.pdf` alors que le bordereau
  est écrit dans `Lcr<société><n°>.pdf` : PDF absent ou ancien (visible après A01) · tests : T06 ·
  sources : [Bordrx.class:518](../../../../../.src/Gestion/Lcr/Bordrx.class#L518), [Bordrx.class:328](../../../../../.src/Gestion/Lcr/Bordrx.class#L328)
- [ ] BORDRX-A03 — [anomalie] Montant converti par `Val(montant)` sans `Utils.cpoint` : en locale
  française, un montant stocké avec un point donne `Null` → « Type mismatch » (vérifié) ; le total
  cumule les mêmes valeurs · tests : T08 · sources : [Bordrx.class:489](../../../../../.src/Gestion/Lcr/Bordrx.class#L489), [Bordrx.class:507](../../../../../.src/Gestion/Lcr/Bordrx.class#L507)
- [ ] BORDRX-A04 — [anomalie] Complétions `String$(n - Len(x))` : erreur « Bad argument » si un champ
  dépasse sa longueur (SIREN complété à 5 alors qu'il compte 9 chiffres, adresses `varchar(35)` sur
  32, CP + ville) ; aucun `Catch`, fichier partiel. Tronquer/compléter avec un helper ; longueur du
  SIREN à confirmer selon la norme · tests : T07 · sources : [Bordrx.class:447](../../../../../.src/Gestion/Lcr/Bordrx.class#L447), [Bordrx.class:497](../../../../../.src/Gestion/Lcr/Bordrx.class#L497),
  [Bordrx.class:503](../../../../../.src/Gestion/Lcr/Bordrx.class#L503)
- [ ] BORDRX-A05 — [anomalie] Fin d'enregistrement : toute valeur autre que `Ws` est ajoutée en texte
  (`" $0D0A$"`) à chaque enregistrement → longueur ≠ 160 ; intention probable : CRLF · tests : T05 ·
  sources : [Bordrx.class:461](../../../../../.src/Gestion/Lcr/Bordrx.class#L461)
- [ ] BORDRX-A06 — [anomalie] Référence tireur de la banque (`banques_reftireur`) écrasée par le n° de
  facture, non tronqué à 10 (12 caractères possibles → enregistrement trop long) ; code
  d'acceptation lu dans une colonne hors bornes de `ColLcr` (à confirmer) · tests : T03, T08 ·
  sources : [Bordrx.class:448](../../../../../.src/Gestion/Lcr/Bordrx.class#L448), [Bordrx.class:492](../../../../../.src/Gestion/Lcr/Bordrx.class#L492), [Bordrx.class:483](../../../../../.src/Gestion/Lcr/Bordrx.class#L483)
- [ ] BORDRX-A07 — [anomalie] `etat = 1` (envoyé) est écrit avant la vérification du mail et même si
  l'envoi échoue : le bordereau ne peut plus être réinjecté · tests : T03, T06 ·
  sources : [Bordrx.class:511](../../../../../.src/Gestion/Lcr/Bordrx.class#L511)
- [ ] BORDRX-A08 — [anomalie] PDF : arguments de `Level1B` décalés (émetteur / domiciliation), code
  entrée non imprimé, client lu sans test `Available` (erreur si client supprimé, aussi dans le
  fichier bancaire) · tests : T02 · sources : [Bordrx.class:346](../../../../../.src/Gestion/Lcr/Bordrx.class#L346), [Bordrx.class:354](../../../../../.src/Gestion/Lcr/Bordrx.class#L354),
  [Bordrx.class:470](../../../../../.src/Gestion/Lcr/Bordrx.class#L470)
- [ ] BORDRX-A09 — [anomalie] Dates du fichier bancaire extraites du texte `Str(date)` de la grille :
  dépendent de la locale (`mmjjaa` en locale `C`, vérifié) · tests : T03 · sources :
  [Bordrx.class:434](../../../../../.src/Gestion/Lcr/Bordrx.class#L434), [Bordrx.class:ColBrd_Data](../../../../../.src/Gestion/Lcr/Bordrx.class#L134-L160)
