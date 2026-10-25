# ObjFacB — Tests

> Source : `.src/Gestion/option/ObjFacB.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (facturation)** : la liste des scénarios ci-dessous est **à faire valider
> par l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5).

Les calculs (`calcul`, `borientation`, `poid`, `comptmat`, `transblfac`) sont testés en
`gbtest` sur une instance `New ObjFacB(num, choix)` ; les éditions (impression, `ProgBar`,
`ComMail`, `SaiReg`, messages) passent par des `replay` d'`OptFac`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| OBJFACB-T01 | gbtest | `calcul` sans option boisson | option `N` puis `P` ; BL simple du jeu `facturation_base` | totaux et collections identiques à OBJFAC-T04 ; `borientation` faux | `tests/calcul_sans_option/` | à faire |
| OBJFACB-T02 | gbtest | `borientation` | option `B` : article `art_dra`, article consigné, déconsigne seule, BL sans rien | booléen attendu par cas | `tests/orientation/` | à faire |
| OBJFACB-T03 | gbtest | `calcul` : BL boisson non édité | lignes consignées P/C/B (`Fiches_ligcons` type B), régies `A`/`V`/`B`, suspendu/acquitté, `drfac` | `aimprimer`, `consigne`, `droit`, `secu`, `ascise`, volumes, `montht`, `monttva`, `montttc`, `tva`, `ecrit` | `tests/calcul_boisson_bl/` | à faire |
| OBJFACB-T04 | gbtest | `calcul` : facture éditée et archive | lignes `Fiches_ligregie` existantes (mode `B`) ; facture archivée (`choix = archive`, mode `F`) | mêmes sorties que T03 | `tests/calcul_boisson_edite/` | à faire |
| OBJFACB-T05 | gbtest | Déconsignes | 2 BL avec déconsignes de même code (fin de mois, table `Bl`) | `decons`, `nbdecons`, `deconsigne` | `tests/deconsignes/` | à faire |
| OBJFACB-T06 | gbtest | TVA des droits (A03 figée) | régie dont le code TVA est absent des lignes ; droit seul ; droit + sécu | entrées de `tva` (clé, `num`, `taux`), erreur « clé existante » figée | `tests/tva_droits/` | à faire |
| OBJFACB-T07 | gbtest | Cumuls ≥ 1 000 € (A11) | consignes totalisant 1 234,56 | valeurs de `consigne`, `montttc` figées | `tests/cumul_milliers/` | à faire |
| OBJFACB-T08 | gbtest | `comptmat` facture | facture boisson suspendue / acquittée ; facture sans alcool (A02) | `Fiches_ligregie`, `Fiches_Parametres.nvign` (dump) ; état de transaction | `tests/comptmat_facture/` | à faire |
| OBJFACB-T09 | gbtest | `comptmat` magasin | facture de caisse en `Fiches_HistoLigfac` avec et sans alcool | `Fiches_ligregie` (dump) | `tests/comptmat_magasin/` | à faire |
| OBJFACB-T10 | gbtest | `poid` | BL, facture, archive, `magasin`, `finmois`, BL `M` | chaîne renvoyée (A13 figée) | `tests/poids/` | à faire |
| OBJFACB-T11 | gbtest | `transblfac` standard | facture non boisson ; facture existante (message) | `Fiches_HistoFac`, `Fiches_HistoLigfac`, suppression `Fiches_Bl`/`Ligbl`/`AdrlivBL` (dump) | `tests/archivage/` | à faire |
| OBJFACB-T12 | gbtest | `transblfac` options | option `B` (consignes/déconsignes renumérotées), `P`/`T` (TIPP, agri, adresse), `tab = M` (`HisentMat`), `gmateriel`, `doclet` (ligne `TD`, A08), `cdep` renseigné (A01 : erreur figée) | dump des tables ; erreur attendue pour `cdep` | `tests/archivage_options/` | à faire |
| OBJFACB-T13 | replay | `editef` (OptFac) | facture non éditée, option `B` ; réédition (`imp = 1`) ; `/Rglt` actif (`SaiReg` incrusté, fermeture, A15) | `Fiches_Bl`, `Fiches_Mvt*`, `Fiches_ligregie`, GED ; PDF (texte) | `tests/editef/` | à faire |
| OBJFACB-T14 | replay | `editebl` | BL, devis, commande, proforma ; chemin `testchem` en échec (A04) | PDF, `Fiches_Ligbl.dte_ligbl` ; curseur occupé figé | `tests/editebl/` | à faire |
| OBJFACB-T15 | replay | `editefm` | 2 clients (dont un divers), tri ; BL lié à un ticket (erreur) ; courriel | archives, écritures, table des verrous `DocActif` (A05 figée), courriels capturés (SMTP factice) | `tests/editefm/` | à faire |
| OBJFACB-T16 | replay | `mail` | document simple ; courriel vide (A07) ; fin de mois avec un client sans adresse | courriels capturés, `choix` après envoi | `tests/mail/` | à faire |
| OBJFACB-T17 | replay | `visualisation` / `verifdat` | BL, facture ; période de droits close (`ClotDroi`) ; fin de mois (A06) | PDF ; messages | `tests/visu_dates/` | à faire |
| OBJFACB-T18 | gbtest | Performance | BL boisson de 300 lignes | durée (`gbx3 -p`) et nombre de requêtes de `calcul` | `tests/perf_calcul/` | à faire |

## Détail des tests

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
