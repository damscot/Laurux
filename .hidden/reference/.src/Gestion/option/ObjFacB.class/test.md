# ObjFacB — Tests

> Source : `.src/Gestion/option/ObjFacB.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (facturation)** : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle.

Les calculs (`calcul`, `borientation`, `poid`, `comptmat`, `transblfac`) sont testés en
`gbtest` sur une instance `New ObjFacB(num, choix)` ; les éditions (impression, `ProgBar`,
`ComMail`, `SaiReg`, messages) passent par des `replay` d'`OptFac`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| OBJFACB-T01 | gbtest | `calcul` sans option boisson | option `N` puis `P` ; BL simple du jeu `facturation_base` | totaux et collections identiques à OBJFAC-T04 ; `borientation` faux | `tests/calcul_sans_option/` | implémenté (gb.test ObjFacBTest.T01CalculSansOption, jeu objfacb_shared/bois_bl : BL B00101 en option N puis P ; totaux, ligne, tva, ecrit ; borientation faux) |
| OBJFACB-T02 | gbtest | `borientation` | option `B` : article `art_dra`, article consigné, déconsigne seule, BL sans rien | booléen attendu par cas | `tests/orientation/` | implémenté (gb.test ObjFacBTest.T02Orientation : droits, déconsigne seule, BL sans rien ; article consigné couvert par T03) |
| OBJFACB-T03 | gbtest | `calcul` : BL boisson non édité | lignes consignées P/C/B (`Fiches_ligcons` type B), régies `A`/`V`/`B`, suspendu/acquitté, `drfac` | `aimprimer`, `consigne`, `droit`, `secu`, `ascise`, volumes, `montht`, `monttva`, `montttc`, `tva`, `ecrit` | `tests/calcul_boisson_bl/` | implémenté (gb.test ObjFacBTest.T03CalculBoissonBl : consignes B/C, régies V suspendue, A non suspendue (sécu), B drfac non suspendue (cassise) ; régie acquittée seule non distinguée) |
| OBJFACB-T04 | gbtest | `calcul` : facture éditée et archive | lignes `Fiches_ligregie` existantes (mode `B`) ; facture archivée (`choix = archive`, mode `F`) | mêmes sorties que T03 | `tests/calcul_boisson_edite/` | implémenté (gb.test ObjFacBTest.T04CalculBoissonEdite : F00104 éditée avec Fiches_ligregie ; T04bCalculArchive : F00105 archivée par transblfac puis relue en mode archive) |
| OBJFACB-T05 | gbtest | Déconsignes | 2 BL avec déconsignes de même code (fin de mois, table `Bl`) | `decons`, `nbdecons`, `deconsigne` | `tests/deconsignes/` | implémenté (gb.test ObjFacBTest.T05Deconsignes : déconsigne du BL B00102 ; deux BL de même code en fin de mois (table Bl) non couverts : Bl/Facturefm construites par Facturefm) |
| OBJFACB-T06 | gbtest | TVA des droits (A03 figée) | régie dont le code TVA est absent des lignes ; droit seul ; droit + sécu | entrées de `tva` (clé, `num`, `taux`), erreur « clé existante » figée | `tests/tva_droits/` | implémenté (gb.test ObjFacBTest.T06TvaDroits : régie suspendue de TVA absente des lignes, puis droit + sécu ; A03 figée : entrées tva aliasées (même Ltva sous plusieurs clés), pas d'erreur « clé existante ») |
| OBJFACB-T07 | gbtest | Cumuls ≥ 1 000 € (A11) | consignes totalisant 1 234,56 | valeurs de `consigne`, `montttc` figées | `tests/cumul_milliers/` | implémenté (gb.test ObjFacBTest.T07CumulMilliers : consignes 1 234,56 ; consigne « 1234,56 », montttc figés) |
| OBJFACB-T08 | gbtest | `comptmat` facture | facture boisson suspendue / acquittée ; facture sans alcool (A02) | `Fiches_ligregie`, `Fiches_Parametres.nvign` (dump) ; état de transaction | `tests/comptmat_facture/` | implémenté (gb.test ObjFacBTest.T08ComptmatFacture : F00105 boisson, vignette et nvign ; F00106 sans alcool (A02 : sortie sans Commit, Rollback sans erreur)) |
| OBJFACB-T09 | gbtest | `comptmat` magasin | facture de caisse en `Fiches_HistoLigfac` avec et sans alcool | `Fiches_ligregie` (dump) | `tests/comptmat_magasin/` | implémenté (gb.test ObjFacBTest.T09ComptmatMagasin : comptmat magasin après archivage de F00105 ; F00107 sans alcool : aucune ligne ; archivage de F00107 en erreur A01) |
| OBJFACB-T10 | gbtest | `poid` | BL, facture, archive, `magasin`, `finmois`, BL `M` | chaîne renvoyée (A13 figée) | `tests/poids/` | implémenté (gb.test ObjFacBTest.T10Poids : BL, facture, archive, magasin, fin de mois ; BL `M` non couvert) |
| OBJFACB-T11 | gbtest | `transblfac` standard | facture non boisson ; facture existante (message) | `Fiches_HistoFac`, `Fiches_HistoLigfac`, suppression `Fiches_Bl`/`Ligbl`/`AdrlivBL` (dump) | `tests/archivage/` | implémenté (gb.test ObjFacBTest.T11Archivage : transblfac option N ; F00106 déjà archivée : Message.Warning acquitté par Timer) |
| OBJFACB-T12 | gbtest | `transblfac` options | option `B` (consignes/déconsignes renumérotées), `P`/`T` (TIPP, agri, adresse), `tab = M` (`HisentMat`), `gmateriel`, `doclet` (ligne `TD`, A08), `cdep` renseigné (A01 : erreur figée) | dump des tables ; erreur attendue pour `cdep` | `tests/archivage_options/` | implémenté partiellement (gb.test ObjFacBTest.T12ArchivageOptions : option B (consignes/déconsignes renumérotées), option T avec total en lettres (TD non écrit), cdep (A01 : « Unknown field: typel », transaction annulée) ; tab = M (HisentMat) et gmateriel à faire) |
| OBJFACB-T13 | replay | `editef` (OptFac) | facture non éditée, option `B` ; réédition (`imp = 1`) ; `/Rglt` actif (`SaiReg` incrusté, fermeture, A15) | `Fiches_Bl`, `Fiches_Mvt*`, `Fiches_ligregie`, GED ; PDF (texte) | `tests/editef/` | implémenté (gb.test ObjFacBTest.T13Editef, sans OptFac : F00105 écriture déséquilibrée (abandon, 3 messages), F00106 éditée (Fiches_Mvt, Fiches_Bl, PDF dans ~/Impressions), réédition F00104 ; texte PDF non comparé (gb.report) ; /Rglt (SaiReg) à faire) |
| OBJFACB-T14 | replay | `editebl` | BL, devis, commande, proforma ; chemin `testchem` en échec (A04) | PDF, `Fiches_Ligbl.dte_ligbl` ; curseur occupé figé | `tests/editebl/` | implémenté (gb.test ObjFacBTest.T14Editebl : BL B00101 (dte_ligbl, PDF) ; chemin PDF impossible : Message.Error, A04 figée (Application.Busy reste à 1) ; devis/commande/proforma à faire) |
| OBJFACB-T15 | replay | `editefm` | 2 clients (dont un divers), tri ; BL lié à un ticket (erreur) ; courriel | archives, écritures, table des verrous `DocActif` (A05 figée), courriels capturés (SMTP factice) | `tests/editefm/` | implémenté (scénario Gestion/objfacb_editefm, jeu objfacb_shared/bl_juin_tx : Facturefm › Imprimer › tri Nom › Éditer ; archives, écritures, verrous DocActif des clients précédents conservés (A05 figée) ; BL lié à un ticket et courriel à faire) |
| OBJFACB-T16 | replay | `mail` | document simple ; courriel vide (A07) ; fin de mois avec un client sans adresse | courriels capturés, `choix` après envoi | `tests/mail/` | implémenté partiellement (gb.test ObjFacBTest.T16Mail : BL par Thunderbird factice, texte prédéfini refusé ; courriel vide (A07 : message puis envoi quand même) ; fin de mois (Facturefm) à faire) |
| OBJFACB-T17 | replay | `visualisation` / `verifdat` | BL, facture ; période de droits close (`ClotDroi`) ; fin de mois (A06) | PDF ; messages | `tests/visu_dates/` | implémenté (gb.test ObjFacBTest.T17Visualisation : BL et facture (CmdVis), période de facturation close (ClotFac : message, editef refusé) ; ClotDroi et fin de mois (A06) à faire) |
| OBJFACB-T18 | gbtest | Performance | BL boisson de 300 lignes | durée (`gbx3 -p`) et nombre de requêtes de `calcul` | `tests/perf_calcul/` | implémenté (gb.test ObjFacBTest.T18Performance : BL de 300 lignes construit dans le test, calcul en option B ; durée relevée par le runner, nombre de requêtes non mesuré) |

## Détail des tests

- **Phase 2, vague 9 (implémenté)** : jeu `.hidden/Tests/Gestion/assets/objfacb_shared/bois_bl.sql` (options bois/pp
  recopiées de `modfichier_shared/options_bois_pp`, régies 01 V suspendue, 02 A sécu, 03 B drfac ; consignes P/C/B ;
  client et compte 411901 ; BL B00101-B00103, factures F00104-F00107, F00106 déjà archivée) et `bl_juin_tx.sql`
  (copie de `facturefm_shared/bl_juin` avec `mtx_ligfac`, article 003, comptes clients, `cptfrais`/`tvafrais`).
  Cause d'OBJFAC-A09 établie : `Fiches_Ligbl.mtx_ligfac` NULL (`ObjFac.calc:675`). Les éditions sont gb.report :
  seule la production des PDF est vérifiée.

- **Jeu `facturation_boisson`** : dérivé de `facturation_base` (voir
  [ObjFac/test.md](../../Facturation/ObjFac.class/test.md)) après exécution de
  `modfichier.fichierboisson` et `fichiercarbu` (MySQL uniquement : plusieurs `ALTER` échouent
  sous SQLite, MODFICHIER-A02) ; ajouter `Fiches_regie` (régies A/V/B, suspendue et acquittée,
  `drfac`, degré seuil sécu), `Fiches_consigne` (P/C/B), articles `art_dra`/`art_cons*`/`art_nb*`,
  `Fiches_Parametres` (`conscli`, `css`, `tvass`, `nvign`), clients `cli_cons`, lignes
  `Fiches_ligcons`/`Fiches_ligregie`. Script à produire dans `tests/_donnees/facturation_boisson.sql`.
- **Valeurs attendues** : produites dans le clone Laurux **non modifié** (sortie `id;valeur`),
  date figée (`faketime`), préférences `/Soc01/bois`, `/pp` fixées dans le `Laurux.conf` de test.
  Les anomalies (A01-A16) sont figées (tests de caractérisation).
- **Comparaison** : sérialiser `aimprimer` (clé + 8 valeurs), `decons`, `tva` (clé, `num`,
  `taux`, montants), `ecrit` triés par clé ; dump normalisé pour les écritures.
- **Transactions (A02)** : vérifier l'état réel après `comptmat` (requête de contrôle sur une
  seconde connexion) ; le résultat dépend de la gestion des transactions imbriquées de gb.db et
  des validations implicites de MySQL (`LOCK TABLES`).
- **Non testable en gbtest** : `Message.*`, impression, `ProgBar`, `ComMail`, `SaiReg`,
  `EnvMail` (stub SMTP en replay), `Visualiseur`.
- **Rejeu** : `ObjFacB` n'a pas de formulaire ; les scénarios sont enregistrés depuis `OptFac`
  et `Facture`. `ComMail` et `SaiReg` doivent être instrumentés par `Utils.Observers`, à vérifier.
