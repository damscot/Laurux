# Edcom — Rework

> Source : `.src/Gestion/Impressions/Edcom.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/Edcom.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 279 |
| Lignes de commentaire | 45 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 49 |
| Complexité max (fonction) | 23 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 279 | 49 | 23 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDCOM-001 — [documentation] Corriger l'en-tête recopié (réimpression de commande
  fournisseur), documenter le rôle de `Codefour`/`dater`, `Colcom_click` à garder `Public` ·
  appelants : aucun · tests : aucun · sources : [Edcom.class:21](../../../../../.src/Gestion/Impressions/Edcom.class#L21), [Edcom.class:24](../../../../../.src/Gestion/Impressions/Edcom.class#L24)
- [ ] EDCOM-002 — [code mort] Supprimer `Level1`, `Level2`, `Level3`, `Level3bis`, `Level4`
  (routines `Draw` jamais appelées ; `deps.py` ne détecte que `Level3bis`) · appelants : aucun ·
  tests : T01, T05 · sources : [Edcom.class:Level1](../../../../../.src/Gestion/Impressions/Edcom.class#L299-L306), [Edcom.class:Level2](../../../../../.src/Gestion/Impressions/Edcom.class#L309-L329), [Edcom.class:Level3](../../../../../.src/Gestion/Impressions/Edcom.class#L332-L345), [Edcom.class:Level3bis](../../../../../.src/Gestion/Impressions/Edcom.class#L347-L354), [Edcom.class:Level4](../../../../../.src/Gestion/Impressions/Edcom.class#L357-L367)
- [ ] EDCOM-003 — [code mort] Supprimer `hfile` et le fichier `Edcom.kdf` (ouvert, jamais écrit ni
  fermé), `Piece`, `Logo`, `Cfac`, `Coulfond`, `p`, `Shell "cd …"` ; `Filename` ne sert plus qu'au
  PDF · appelants : aucun · tests : T01, T04 · sources : [Edcom.class:47](../../../../../.src/Gestion/Impressions/Edcom.class#L47), [Edcom.class:228](../../../../../.src/Gestion/Impressions/Edcom.class#L228), [Edcom.class:229](../../../../../.src/Gestion/Impressions/Edcom.class#L229), [Edcom.class:286](../../../../../.src/Gestion/Impressions/Edcom.class#L286), [Edcom.class:371](../../../../../.src/Gestion/Impressions/Edcom.class#L371)
- [ ] EDCOM-004 — [séparation traitement/GUI] `LignesCommande(numcom, four)` et lecture du
  fournisseur sans contrôle ; `Cbase.Table` pour `TabEntcom`, `TabLigcom`, `TabFour`, `TabSoc` (SQL
  identique) · appelants : aucun · tests : T01, T05 · sources : [Edcom.class:230](../../../../../.src/Gestion/Impressions/Edcom.class#L230), [Edcom.class:243](../../../../../.src/Gestion/Impressions/Edcom.class#L243), [Edcom.class:94](../../../../../.src/Gestion/Impressions/Edcom.class#L94)
- [ ] EDCOM-005 — [commonalisation] En-tête société par `Creleve.EnteteSociete` (LIGCLI-004), même
  texte imprimé · appelants : aucun · tests : T01 · sources : [Edcom.class:211](../../../../../.src/Gestion/Impressions/Edcom.class#L211), [Ligcli.class:Buttonedit_Click](../../../../../.src/Compta/Relances/Ligcli.class#L181-L343)
- [ ] EDCOM-006 — [complexité] `Button2_Click` (CC 23) : extraire `ImprimeEntetes(pdf)` (appelé au
  début et à chaque saut de page) · appelants : aucun · tests : T01, T05 · sources : [Edcom.class:Button2_Click](../../../../../.src/Gestion/Impressions/Edcom.class#L162-L296)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDCOM-A01 — [anomalie] `Codefour` n'est renseigné que par le clic souris : Entrée dans la
  liste ou numéro tapé dans `Ncom` → « Aucun mouvement » (ou commande d'un autre fournisseur si un
  `Codefour` précédent subsiste) · tests : T02, T03 · sources : [Edcom.class:Colcom_KeyPress](../../../../../.src/Gestion/Impressions/Edcom.class#L118-L134), [Edcom.class:230](../../../../../.src/Gestion/Impressions/Edcom.class#L230)
- [ ] EDCOM-A02 — [anomalie] La date imprimée (« Commande n° … du … ») est celle de la dernière
  commande de la liste, pas celle de la commande choisie · tests : T01 · sources : [Edcom.class:102](../../../../../.src/Gestion/Impressions/Edcom.class#L102), [Edcom.class:254](../../../../../.src/Gestion/Impressions/Edcom.class#L254)
- [ ] EDCOM-A03 — [anomalie] Lecture du fournisseur sans test `Available` à l'affichage de la liste :
  une commande orpheline provoque une erreur · tests : T06 · sources : [Edcom.class:99](../../../../../.src/Gestion/Impressions/Edcom.class#L99), [Edcom.class:100](../../../../../.src/Gestion/Impressions/Edcom.class#L100)
- [ ] EDCOM-A04 — [anomalie] (relevée au lot Reports, voir CDOCUMENTS) l. 249 : `tel = fourResult!fo_tel_std`
  écrase la variable `tel` qui porte le téléphone de la société : l'en-tête société imprime celui du
  fournisseur · tests : T01 · sources : [Edcom.class:249](../../../../../.src/Gestion/Impressions/Edcom.class#L249)
