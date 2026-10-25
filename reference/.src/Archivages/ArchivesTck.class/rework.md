# ArchivesTck — Rework

> Source : `.src/Archivages/ArchivesTck.class` · Message de commit (phase 4) : `reference/.src/Archivages/ArchivesTck.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 557 |
| Lignes de commentaire | 4 |
| Fonctions | 42 |
| Fonctions Public | 42 |
| Complexité cyclomatique totale | 157 |
| Complexité max (fonction) | 46 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 557 | 157 | 46 | 0 | 42 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ARCHIVESTCK-001 — [documentation] En-tête en français : rôle (consultation et réimpression
  des tickets moulinés), tables, rôle des zones d'en-tête (tri / filtre / inversion), table de
  travail `Tottva` partagée, anomalies A01 à A08 · appelants : aucun · tests : aucun · sources : [ArchivesTck.class:_New](../../../../.src/Archivages/ArchivesTck.class#L19-L43), [ArchivesTck.class:Button4_Click](../../../../.src/Archivages/ArchivesTck.class#L558-L696)
- [ ] ARCHIVESTCK-002 — [code mort] Supprimer `cpoint` (copie de `Utils.cpoint`, jamais appelée) et
  `Refresh` (jamais appelée ; masque `Control.Refresh`, appel inexistant sur cette fenêtre) ·
  appelants : aucun · tests : T01-T05 · sources : [ArchivesTck.class:cpoint](../../../../.src/Archivages/ArchivesTck.class#L45-L49), [ArchivesTck.class:Refresh](../../../../.src/Archivages/ArchivesTck.class#L145-L149)
- [ ] ARCHIVESTCK-003 — [code mort] Supprimer les traces `Print` (`Date_KeyPress`, `dKeyPress`), le
  `Shell "cd ~"` et la première affectation de `Filename`, la variable `Total` (cumulée, jamais
  imprimée) et la variable locale `d` d'`affiche` · appelants : aucun · tests : T03, T06-T08 · sources : [ArchivesTck.class:220](../../../../.src/Archivages/ArchivesTck.class#L220), [ArchivesTck.class:376](../../../../.src/Archivages/ArchivesTck.class#L376), [ArchivesTck.class:580-581](../../../../.src/Archivages/ArchivesTck.class#L580-L581), [ArchivesTck.class:646](../../../../.src/Archivages/ArchivesTck.class#L646), [ArchivesTck.class:105](../../../../.src/Archivages/ArchivesTck.class#L105)
- [ ] ARCHIVESTCK-004 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `affiche`, `Dbclk`,
  `KeyPress`, `dKeyPress`, `init_Tk`, `Deplacement`, `TabTva` → `Private` (aucun appelant externe,
  vérifié ; couverts par les replays) · appelants : aucun · tests : T01-T07 · sources : [ArchivesTck.class:Tris](../../../../.src/Archivages/ArchivesTck.class#L64-L86), [ArchivesTck.class:Deb2](../../../../.src/Archivages/ArchivesTck.class#L88-L93), [ArchivesTck.class:Deb3](../../../../.src/Archivages/ArchivesTck.class#L95-L100), [ArchivesTck.class:affiche](../../../../.src/Archivages/ArchivesTck.class#L102-L143), [ArchivesTck.class:TabTva](../../../../.src/Archivages/ArchivesTck.class#L546-L556)
- [ ] ARCHIVESTCK-005 — [complexité] Handlers d'en-tête : aides privées `ChoisirTri(hZone, sTri)`
  et `InverserTri(hZone, sTri)` appelées par les 12 handlers `*_GotFocus`/`*_Dblclick` (noms
  conservés, comportement identique) ; `Deb2`/`Deb3` → `Charge(bDesc)` (SQL identique) ·
  appelants : aucun · tests : T01-T04 · sources : [ArchivesTck.class:Nm_GotFocus](../../../../.src/Archivages/ArchivesTck.class#L163-L172), [ArchivesTck.class:cli_Dblclick](../../../../.src/Archivages/ArchivesTck.class#L331-L340), [ArchivesTck.class:Deb2](../../../../.src/Archivages/ArchivesTck.class#L88-L93), [ArchivesTck.class:Deb3](../../../../.src/Archivages/ArchivesTck.class#L95-L100)
- [ ] ARCHIVESTCK-006 — [séparation traitement/GUI] Fonction pure `RequeteTickets(sTri, sSel,
  bDesc, iDebut, iNb) As String` (texte SQL identique) et `LitLignesTicket(numero) As Result`,
  utilisées par `Charge`, `Coltk_Click` et `Button4_Click` · appelants : aucun · tests : T01-T07 · sources : [ArchivesTck.class:Deb2](../../../../.src/Archivages/ArchivesTck.class#L88-L93), [ArchivesTck.class:Coltk_Click](../../../../.src/Archivages/ArchivesTck.class#L504-L544), [ArchivesTck.class:602](../../../../.src/Archivages/ArchivesTck.class#L602)
- [ ] ARCHIVESTCK-007 — [complexité] Découper `Button4_Click` (CC 46) en `ImprimeEntete`,
  `CumulTva`, `ImprimeLignes`, `ImprimePied` ; SQL et `Tottva` identiques, anomalies A01 à A03
  conservées · appelants : aucun · tests : T06-T08 · sources : [ArchivesTck.class:Button4_Click](../../../../.src/Archivages/ArchivesTck.class#L558-L696)
- [ ] ARCHIVESTCK-008 — [commonalisation] Pagination (`Coltk_MouseWheel`, `Descendre_*`,
  `Remonter_*`, `Deplacement`, flèches de `Coltk_KeyPress`) vers la classe d'aide `PaginationListe`
  (TRICARTES-005), partagée avec `Archives`, `Tricartes`, `TriclientsD` et les `Tri*` · prérequis :
  TRICARTES-005 · appelants : aucun · tests : T04 · sources : [ArchivesTck.class:Descendre_Click](../../../../.src/Archivages/ArchivesTck.class#L450-L460), [ArchivesTck.class:Remonter_Click](../../../../.src/Archivages/ArchivesTck.class#L462-L470), [ArchivesTck.class:Coltk_MouseWheel](../../../../.src/Archivages/ArchivesTck.class#L413-L422), [Tricartes.class:Descendre_Click](../../../../.src/Caisse/Affichages/Tricartes.class#L127-L137)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ARCHIVESTCK-A01 — [anomalie] Réimpression : le cumul `ttva2` est commun à tous les taux ; dès
  qu'un taux réapparaît après un autre, il reçoit le cumul de l'autre taux → TVA par taux fausse sur
  le ticket réimprimé (le HT est ensuite « corrigé » par différence). Correction : cumuler sur
  `rtva!mtva` du taux concerné · tests : T07 · sources : [ArchivesTck.class:620-626](../../../../.src/Archivages/ArchivesTck.class#L620-L626)
- [ ] ARCHIVESTCK-A02 — [anomalie] Le filtre d'exclusion des lignes `C` teste `rntck!type` (1re ligne
  du ticket) au lieu de `rtva2!type` : lignes `C` comptées dans la TVA, ou aucune TVA si la 1re
  ligne est de type `C` · tests : T07 · sources : [ArchivesTck.class:607](../../../../.src/Archivages/ArchivesTck.class#L607)
- [ ] ARCHIVESTCK-A03 — [anomalie, à confirmer] `ttvam` n'est calculé que pour les lignes `A` et
  `S` : pour les autres types porteurs d'un code TVA, la valeur de la ligne précédente est cumulée à
  nouveau · tests : T07, T08 · sources : [ArchivesTck.class:611-619](../../../../.src/Archivages/ArchivesTck.class#L611-L619)
- [ ] ARCHIVESTCK-A04 — [anomalie] `TabTva` supprime et recrée la table **permanente** `Tottva`
  partagée avec la caisse (CAISSE-A17) : une réimpression pendant l'encaissement d'un ticket sur un
  autre poste vide le cumul de TVA de la caisse. Correction : cumul en `Collection` (SQL modifié,
  dump identique hors table de travail) · tests : T06 (scénario manuel à deux postes) · sources : [ArchivesTck.class:TabTva](../../../../.src/Archivages/ArchivesTck.class#L546-L556)
- [ ] ARCHIVESTCK-A05 — [anomalie, à confirmer] « Caisse n° » = 1er caractère du numéro de ticket
  et « Ticket n° » = 6 derniers : les numéros viennent d'un compteur global à 7 chiffres (`cutk`),
  le 1er chiffre n'est pas le numéro de caisse (colonne `caisse`). Correction : afficher `caisse` et
  le numéro complet · tests : T05, T06 · sources : [ArchivesTck.class:530-531](../../../../.src/Archivages/ArchivesTck.class#L530-L531), [ArchivesTck.class:595](../../../../.src/Archivages/ArchivesTck.class#L595)
- [ ] ARCHIVESTCK-A06 — [anomalie] Filtre construit par concaténation (`like "%<saisie>%"`) : un `"`
  saisi provoque une erreur SQL, un `%` ou `_` élargit le filtre. Correction : `LIKE &1` paramétré
  (SQL modifié) · tests : T09 · sources : [ArchivesTck.class:90](../../../../.src/Archivages/ArchivesTck.class#L90), [ArchivesTck.class:97](../../../../.src/Archivages/ArchivesTck.class#L97)
- [ ] ARCHIVESTCK-A07 — [anomalie, à confirmer] Bouton d'aide `Button1` (groupe `Btn`) sans handler
  `Btn_Click` : inerte (constat commun à de nombreux formulaires) · tests : aucun · sources : [ArchivesTck.class:_New](../../../../.src/Archivages/ArchivesTck.class#L19-L43)
- [ ] ARCHIVESTCK-A08 — [anomalie, à confirmer] Détail et réimpression lus par `numero` seul
  (non unique) : deux tickets de même numéro mélangent leurs lignes. Correction : sélection par
  `lInd` d'en-tête · tests : T10 · sources : [ArchivesTck.class:515](../../../../.src/Archivages/ArchivesTck.class#L515), [ArchivesTck.class:537](../../../../.src/Archivages/ArchivesTck.class#L537), [ArchivesTck.class:602](../../../../.src/Archivages/ArchivesTck.class#L602)
