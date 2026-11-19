# Caleditcmat — Tests

> Source : `.src/Gestion/option/Caleditcmat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> **Module complexe (clôture de la comptabilité matières)** : la clôture écrit de façon
> irréversible dans `Fiches_ligregie` (lignes clôturées et stock de début du mois suivant).
> Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle.
> Implémentation : module gb.test `CaleditcmatTest` (écran instancié, gestionnaires appelés, Message.Question par Timer),
> jeu `caleditcmat_shared/cmat_base`.

L'écran n'appelle pas `Utils.Observers(Me)` : il n'est pas journalisé en l'état. Les scénarios
supposent son instrumentation dans les deux clones avant capture (CALEDITCMAT-A08) ou une
exécution manuelle guidée. Le dump normalisé de `Fiches_ligregie` fait foi pour la clôture ; pour
les éditions, texte des PDF (`pdftotext -layout`, dates masquées) et lignes `Exec_SQL`. Horloge
figée (`faketime`) ; valeurs attendues produites dans le clone Laurux non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALEDITCMAT-T01 | gbtest | Contrôle d'un mois propre | jeu `cmat_base`, mois M, régime suspendu → Control | `Textcontrol` vide ; aucune écriture | `tests/controle_ok/` | implémenté (CaleditcmatTest.T01ControleOk, gb.test : écran instancié, Control_Click appelé ; Textcontrol vide en suspendu et en acquitté) |
| CALEDITCMAT-T02 | gbtest | Contrôle avec anomalies | BL non facturé du mois, ligne de facture archivée sans ligne de régie, article à régie inexistante | messages de `Textcontrol` de référence | `tests/controle_anomalies/` | implémenté (T02ControleAnomalies : BL non facturés juin/mai, article à régie 99, facture archivée dont une ligne n’a pas de ligne de régie) |
| CALEDITCMAT-T03 | gbtest | Édition provisoire, régime suspendu | mois M → Edition | PDF Ecomptamat de référence ; dump inchangé | `tests/provisoire_suspendu/` | implémenté (T03ProvisoireSuspendu : dernière Declaration lue par le rapport (Caleditcmat.ddcl), PDF produit, Fiches_ligregie inchangée ; texte PDF vide : gb.report) |
| CALEDITCMAT-T04 | gbtest | Édition provisoire, régime acquitté | mois M, « Acquitté » → Edition | PDF Einvmat ; dump inchangé | `tests/provisoire_acquitte/` | implémenté (T04ProvisoireAcquitte : même méthode que T03) |
| CALEDITCMAT-T05 | gbtest | **Clôture** du mois, régime suspendu | mois M, mois M-1 clôturé, inventaire < 12 mois → Clôture → Oui | `Fiches_ligregie` : mouvements `S/E/C` du mois et du régime `cloture=1` ; une ligne `M` par régie au 1er de M+1 (volumes de fin) ; régime acquitté intact | `tests/cloture_suspendu/` | implémenté (T05ClotureSuspendu : « Oui » par Timer ; lignes S/E/C clôturées et lignes M du 2018-07-01 relevées) |
| CALEDITCMAT-T06 | gbtest | Clôture refusée | mois déjà clôturé ; mois précédent non clôturé ; inventaire > 12 mois ; aucun inventaire ; anomalie de contrôle | dump inchangé ; message affiché | `tests/cloture_refusee/` | implémenté (T06ClotureRefusee : réponse Non, mois précédent non clôturé, mois déjà clôturé, inventaire > 12 mois, aucun inventaire ; Application.Busy laissé à 1 sur refus figé) |
| CALEDITCMAT-T07 | gbtest | Réédition d'un mois clôturé | après T05 → Rédition | PDF identique à T05 sauf plage de vignettes (figer A05) | `tests/reedition/` | implémenté (T07Reedition : ddcl et PDF produit ; plage de vignettes : voir ECOMPTAMAT-T04) |
| CALEDITCMAT-T08 | gbtest | Modes de calcul et arrondis | `calcregie` coché/décoché × `math`/`inf`/`sup` × décimales 0 et 2 | 12 PDF de référence (droits, SS, tarifs) | `tests/calcul_arrondis/` | implémenté (T08CalculArrondis : 12 combinaisons, ddcl (droit, secu) et lignes M écrites par la clôture ; les PDF ne sont pas relevables) |
| CALEDITCMAT-T09 | gbtest | Détail des mouvements | mois M → Detail | texte de `~/tmp/tarif.pdf` de référence | `tests/detail/` | implémenté (T09Detail : PDF ~/tmp/tarif.pdf produit, texte vide : rapport gb.report construit par code) |
| CALEDITCMAT-T10 | gbtest | Éditions de stock | Inventaire, Inventaire tournant, Stock de départ, Stock | PDF d'EditStkDepart (voir ses tests) | `tests/editions_stock/` | implémenté (T10EditionsStock : chaque bouton sur le jeu de la classe (erreurs figées : tables d’inventaire absentes, Type mismatch sur Stock de départ) puis sur editstkdepart_shared/cmat_base) |
| CALEDITCMAT-T11 | gbtest | Date invalide (A01, A02) | mois `13` → Control puis Edition provisoire | figer : ballons, `Application.Busy` non revenu à 0, période utilisée | `tests/date_invalide/` | implémenté (T11DateInvalide : Textcontrol vide, Application.Busy 1 puis 2 (A01/A02 figées), aucun PDF) |
| CALEDITCMAT-T12 | replay | Clôture sous SQLite (A06) | base `Laurux01.sqlite` + option boissons, T05 | figer l'erreur de l'`UPDATE` multi-tables | `tests/cloture_sqlite/` | à faire : SQLite (limite du framework : rejeu et gb.test sur MariaDB seulement) |
| CALEDITCMAT-T13 | gbtest | Détail sans régie (A07) | option boissons activée, `Fiches_regie` vide → Detail | figer l'erreur « Null object » | `tests/detail_sans_regie/` | implémenté (T13DetailSansRegie : « Null object » figé, A07) |
| CALEDITCMAT-T14 | gbtest | Cœur de calcul (après CALEDITCMAT-003) | `CalculDeclaration(...)` sur le jeu `cmat_base`, toutes combinaisons de T08 | collections de référence (volumes, droits, SS) identiques aux PDF de T03/T04/T08 | `tests/calcul_declaration/` | à faire : après extraction de CalculDeclaration (CALEDITCMAT-003) |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md). Pour ce module il
  faut en plus : deux mois consécutifs (M-1 clôturé avec ses lignes `M`, M ouvert), une ligne `I`
  d'inventaire de moins de 12 mois, des entrées et sorties sur trois degrés et deux régies par
  régime, des BL non facturés, des factures archivées, et une ligne `type='C'`.
- **Scénarios (module complexe)** — Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests
  implémentés sans validation individuelle (T05 clôture nominale, T06 refus, T07 réédition, T08 modes de calcul).
  Reste non couvert : le comportement en cas d'échec au milieu de la clôture (A04), qui ne peut être provoqué qu'en
  simulant une erreur SQL.
- **T14** est écrit après l'extraction de `CalculDeclaration` (CALEDITCMAT-003) ; ses valeurs
  attendues sont celles des PDF de T03/T04/T08 capturés dans le clone non modifié.
- **Cas non testables** : mise en page des reports (visuel), durée du contrôle sur une base
  volumineuse (mesurée par `gbx3 -p` seulement).
