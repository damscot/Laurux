# Caleditcmat — Tests

> Source : `.src/Gestion/option/Caleditcmat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (clôture de la comptabilité matières)** : la clôture écrit de façon
> irréversible dans `Fiches_ligregie` (lignes clôturées et stock de début du mois suivant). La
> liste de scénarios ci-dessous est une **proposition à faire valider par l'utilisateur** avant la
> génération des tests en phase 2 (périmètre, régimes, cas d'erreur, réglementation à couvrir).

L'écran n'appelle pas `Utils.Observers(Me)` : il n'est pas journalisé en l'état. Les scénarios
supposent son instrumentation dans les deux clones avant capture (CALEDITCMAT-A08) ou une
exécution manuelle guidée. Le dump normalisé de `Fiches_ligregie` fait foi pour la clôture ; pour
les éditions, texte des PDF (`pdftotext -layout`, dates masquées) et lignes `Exec_SQL`. Horloge
figée (`faketime`) ; valeurs attendues produites dans le clone Laurux non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALEDITCMAT-T01 | replay | Contrôle d'un mois propre | jeu `cmat_base`, mois M, régime suspendu → Control | `Textcontrol` vide ; aucune écriture | `tests/controle_ok/` | à faire |
| CALEDITCMAT-T02 | replay | Contrôle avec anomalies | BL non facturé du mois, ligne de facture archivée sans ligne de régie, article à régie inexistante | messages de `Textcontrol` de référence | `tests/controle_anomalies/` | à faire |
| CALEDITCMAT-T03 | replay | Édition provisoire, régime suspendu | mois M → Edition | PDF Ecomptamat de référence ; dump inchangé | `tests/provisoire_suspendu/` | à faire |
| CALEDITCMAT-T04 | replay | Édition provisoire, régime acquitté | mois M, « Acquitté » → Edition | PDF Einvmat ; dump inchangé | `tests/provisoire_acquitte/` | à faire |
| CALEDITCMAT-T05 | replay | **Clôture** du mois, régime suspendu | mois M, mois M-1 clôturé, inventaire < 12 mois → Clôture → Oui | `Fiches_ligregie` : mouvements `S/E/C` du mois et du régime `cloture=1` ; une ligne `M` par régie au 1er de M+1 (volumes de fin) ; régime acquitté intact | `tests/cloture_suspendu/` | à faire |
| CALEDITCMAT-T06 | replay | Clôture refusée | mois déjà clôturé ; mois précédent non clôturé ; inventaire > 12 mois ; aucun inventaire ; anomalie de contrôle | dump inchangé ; message affiché | `tests/cloture_refusee/` | à faire |
| CALEDITCMAT-T07 | replay | Réédition d'un mois clôturé | après T05 → Rédition | PDF identique à T05 sauf plage de vignettes (figer A05) | `tests/reedition/` | à faire |
| CALEDITCMAT-T08 | replay | Modes de calcul et arrondis | `calcregie` coché/décoché × `math`/`inf`/`sup` × décimales 0 et 2 | 12 PDF de référence (droits, SS, tarifs) | `tests/calcul_arrondis/` | à faire |
| CALEDITCMAT-T09 | replay | Détail des mouvements | mois M → Detail | texte de `~/tmp/tarif.pdf` de référence | `tests/detail/` | à faire |
| CALEDITCMAT-T10 | replay | Éditions de stock | Inventaire, Inventaire tournant, Stock de départ, Stock | PDF d'EditStkDepart (voir ses tests) | `tests/editions_stock/` | à faire |
| CALEDITCMAT-T11 | replay | Date invalide (A01, A02) | mois `13` → Control puis Edition provisoire | figer : ballons, `Application.Busy` non revenu à 0, période utilisée | `tests/date_invalide/` | à faire |
| CALEDITCMAT-T12 | replay | Clôture sous SQLite (A06) | base `Laurux01.sqlite` + option boissons, T05 | figer l'erreur de l'`UPDATE` multi-tables | `tests/cloture_sqlite/` | à faire |
| CALEDITCMAT-T13 | replay | Détail sans régie (A07) | option boissons activée, `Fiches_regie` vide → Detail | figer l'erreur « Null object » | `tests/detail_sans_regie/` | à faire |
| CALEDITCMAT-T14 | gbtest | Cœur de calcul (après CALEDITCMAT-003) | `CalculDeclaration(...)` sur le jeu `cmat_base`, toutes combinaisons de T08 | collections de référence (volumes, droits, SS) identiques aux PDF de T03/T04/T08 | `tests/calcul_declaration/` | à faire |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md). Pour ce module il
  faut en plus : deux mois consécutifs (M-1 clôturé avec ses lignes `M`, M ouvert), une ligne `I`
  d'inventaire de moins de 12 mois, des entrées et sorties sur trois degrés et deux régies par
  régime, des BL non facturés, des factures archivées, et une ligne `type='C'`.
- **Scénarios à valider par l'utilisateur** (module complexe) : T05 (clôture nominale), T06
  (refus), T07 (réédition), T08 (modes de calcul) et le comportement attendu en cas d'échec au
  milieu de la clôture (A04), qui ne peut être provoqué qu'en simulant une erreur SQL.
- **T14** est écrit après l'extraction de `CalculDeclaration` (CALEDITCMAT-003) ; ses valeurs
  attendues sont celles des PDF de T03/T04/T08 capturés dans le clone non modifié.
- **Cas non testables** : mise en page des reports (visuel), durée du contrôle sur une base
  volumineuse (mesurée par `gbx3 -p` seulement).
