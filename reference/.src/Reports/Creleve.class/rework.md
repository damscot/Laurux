# Creleve — Rework

> Source : `.src/Reports/Creleve.class` · Message de commit (phase 4) : `reference/.src/Reports/Creleve.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 225 |
| Lignes de commentaire | 15 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 35 |
| Complexité max (fonction) | 12 (`Entete`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 225 | 35 | 12 | 0 | 16 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CRELEVE-001 — [documentation] En-tête de classe en français : gabarit des relevés et lettres
  de relance, tableau des étapes relevé/relance → méthodes, cadres et positions ; commentaire `'''`
  par méthode, en particulier les 17 paramètres d'`Entete` · appelants : aucun · tests : T01-T04 · sources : [Creleve.class:Entete](../../../../.src/Reports/Creleve.class#L42-L130), [Creleve.class:Entete2](../../../../.src/Reports/Creleve.class#L133-L161)
- [ ] CRELEVE-002 — [code mort] Supprimer `EnteteN` (aucun appelant, vérifié par grep), `_free` et
  la variable `Coln` (écrite, jamais lue) · appelants : aucun · tests : T01 · sources : [Creleve.class:EnteteN](../../../../.src/Reports/Creleve.class#L23-L31), [Creleve.class:_free](../../../../.src/Reports/Creleve.class#L18-L20), [Creleve.class:46](../../../../.src/Reports/Creleve.class#L46)
- [ ] CRELEVE-003 — [complexité] `Entete` : boucle sur les lignes optionnelles au lieu de 10 blocs
  `If` identiques, suppression du `SetXY(6, PosY)` sans effet ; ordre et polices conservés (CC 12 →
  3 visé, texte identique) · appelants : aucun · tests : T01, T03, T05, T06 · sources : [Creleve.class:Entete](../../../../.src/Reports/Creleve.class#L42-L130)
- [ ] CRELEVE-004 — [réduction de portée] `Logo` → `Private` (seul appel : `Entete`) · appelants :
  aucun · tests : T02 · sources : [Creleve.class:Logo](../../../../.src/Reports/Creleve.class#L163-L184)
- [ ] CRELEVE-005 — [code mort] Supprimer les paramètres inutilisés `Pays` et `Col` d'`Entete`,
  `Col` d'`Entete2`, `Jour` de `Level1` · appelants : `FEditrel`, `Ligcli`, `FRelCompte`,
  `FRelFacture` (8 appels d'`Entete`/`Entete2`, 4 de `Level1`, même commit) · tests : T01, T03,
  T05, T06 · sources : [Creleve.class:Entete](../../../../.src/Reports/Creleve.class#L42-L130), [Creleve.class:Level1](../../../../.src/Reports/Creleve.class#L187-L200), [FRelCompte.class:372](../../../../.src/Compta/Relances/FRelCompte.class#L372)
- [ ] CRELEVE-006 — [commonalisation] Helpers privés `EnTeteTableau(y, largeur_date)` pour
  `Level2`/`Level6` et `LigneTableau(largeur_date, …)` pour `Level3`/`Level7` ; rendu identique ·
  appelants : aucun · tests : T03, T04 · sources : [Creleve.class:Level2](../../../../.src/Reports/Creleve.class#L203-L213), [Creleve.class:Level6](../../../../.src/Reports/Creleve.class#L250-L260), [Creleve.class:Level3](../../../../.src/Reports/Creleve.class#L216-L226), [Creleve.class:Level7](../../../../.src/Reports/Creleve.class#L263-L273)
- [ ] CRELEVE-007 — [commonalisation] En-tête société commun (LIGCLI-004) : `EnteteSociete(hSoc As
  Collection)` qui appelle `Entete` avec les valeurs d'une lecture partagée (`WHERE cd_sc = &1`,
  `Cbase.Table("TabSoc")`), remplaçant les 4 blocs de 17 lignes des relances (et réutilisable par
  `Facturergbl`/`RelvMo` via `Cdocuments`) ; texte identique · appelants : `Ligcli`, `FEditrel`,
  `FRelCompte`, `FRelFacture` (même commit) · tests : T01, T05, T06 · sources : [Creleve.class:Entete](../../../../.src/Reports/Creleve.class#L42-L130), [Ligcli.class:238](../../../../.src/Compta/Relances/Ligcli.class#L238), [FEditrel.class:497](../../../../.src/Compta/Relances/FEditrel.class#L497), [FRelCompte.class:341](../../../../.src/Compta/Relances/FRelCompte.class#L341), [FRelFacture.class:358](../../../../.src/Compta/Relances/FRelFacture.class#L358)
- [ ] CRELEVE-008 — [séparation traitement/GUI] `Logo` : fonction privée `PositionLogo(chemin) As
  Float[]` (lecture de configuration, chargement de l'image, calcul de x/y, mêmes `Try`) puis
  `Me.Image` ; mêmes erreurs · appelants : aucun · tests : T02 · sources : [Creleve.class:Logo](../../../../.src/Reports/Creleve.class#L163-L184)
- [ ] CRELEVE-009 — [commonalisation] (phase 3) Dériver de `PdfLaurux` : `_new`, `Lines`,
  `LogoSociete` (partagé avec `Cfacture`, `Cdocuments*`) ; PDF identique · appelants : aucun ·
  tests : T01-T04 · sources : [Creleve.class:_new](../../../../.src/Reports/Creleve.class#L9-L16), [Creleve.class:Logo](../../../../.src/Reports/Creleve.class#L163-L184), [Cfacture.class:Logo](../../../../.src/Caisse/Reports/Cfacture.class#L309-L338)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CRELEVE-A01 — [anomalie, à confirmer par T04] `Level8` imprime le texte de la lettre en
  `MultiCell` de 294 mm sur une page de 210 mm : une ligne longue sans retour à la ligne est coupée
  au-delà du bord droit et devient illisible. Correction : largeur 196 (ou 0 = jusqu'à la marge) ·
  appelants : `FEditrel`, `Ligcli` · tests : T04, T06 · sources : [Creleve.class:280](../../../../.src/Reports/Creleve.class#L280)
- [ ] CRELEVE-A02 — [anomalie] `Logo` : une image de moins de 10 pixels de large donne `L2 = 0` et
  une division par zéro **hors `Try`** à l'appel `Me.Image` (édition interrompue) ; seul le dernier
  `Try` est contrôlé par `If Not Error` · appelants : `Entete` (tous les relevés et relances) ·
  tests : T02 · sources : [Creleve.class:176](../../../../.src/Reports/Creleve.class#L176), [Creleve.class:179](../../../../.src/Reports/Creleve.class#L179)
