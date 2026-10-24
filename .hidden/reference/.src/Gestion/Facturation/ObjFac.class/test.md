# ObjFac — Tests

> Source : `.src/Gestion/Facturation/ObjFac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`ObjFac` est une classe de traitement (sans formulaire) qui lit la base et `Start.LocalSettings` :
les tests `gbtest` l'instancient directement (`New ObjFac(num, choix)`, possible bien qu'aucun
code ne le fasse) sur la base Docker chargée avec le jeu `facturation_base`, puis comparent les
collections et totaux produits. Les chemins qui affichent un message (`verifdat`, `testchem`,
`ecriturecompt` en erreur) ou impriment (`CopieGedFac`) sont couverts par des `replay` via
`OptFac`. Module complexe (facturation) : la liste ci-dessous est à **valider par l'utilisateur**
avant la phase 2.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| OBJFAC-T01 | gbtest | `_new` : lecture des options | `Laurux.conf` de test avec les ≈ 40 clés `/Soc01/…` à des valeurs distinctes | valeur de chaque membre d'option ; `devise`, `journal` | `tests/options/` | à faire |
| OBJFAC-T02 | gbtest | `_new` : recherche du document | n° BL en `Fiches_Bl`, en `Fiches_BlM`, n° facture, n° archivé (`HistoFac`/`HistoFacM`), fin de mois `""`/`"M"` | `numbl`, `numfac`, `tab` | `tests/recherche_document/` | à faire |
| OBJFAC-T03 | gbtest | `numcli` : fiche client et règlement | clients : standard, auto-entrepreneur, avec échéance 30 j fin de mois, BL acquitté, `breg` actif, règlement inconnu ; client inexistant | adresses, `$exemplaire`, événements levés, `tsaisreg`, `dteech.L` ; erreur levée | `tests/fiche_client/` | à faire |
| OBJFAC-T04 | gbtest | `calcul` : BL simple | BL 2 articles (TVA 20 % et 5,5 %) + 1 MO, remise ligne | `montht`, `monttva`, `montttc`, `montart`, `montmo`, clés et `Ledit` de `ligne`, `tva`, `ecrit` | `tests/calcul_bl/` | à faire |
| OBJFAC-T05 | gbtest | `calcul` : types de lignes | lignes `C` multi-lignes, `R`, `T` (avec/sans `ligne2`), `O` (article composé ou non), `E`/`D`/`P` | contenu et numérotation de `ligne` | `tests/types_lignes/` | à faire |
| OBJFAC-T06 | gbtest | `calcul` : frais de gestion, exonération | BL avec `gestbl` ; client exonéré ; auto-entrepreneur ; les deux | écriture `cptfrais`, TVA des frais (A03 figée) | `tests/frais_exoneration/` | à faire |
| OBJFAC-T07 | gbtest | `calcul` : avoir et total en lettres | BL négatif ; `doclet` actif | libellés « AVOIR … » ; ligne `TD` | `tests/avoir_lettres/` | à faire |
| OBJFAC-T08 | gbtest | `calcul` : facture archivée | facture en `Fiches_HistoFac` et en `HistoFacM` | mêmes sorties que T04 via les alias `entetef`/`detailf` | `tests/archive/` | à faire |
| OBJFAC-T09 | gbtest | `calcul` : fin de mois | table `Bl` de travail préparée (2 BL), client normal et client divers (`nom`) ; option `nblfac` | lignes « Bon n° … », totaux, échéance | `tests/fin_de_mois/` | à faire |
| OBJFAC-T10 | gbtest | Écotaxes et options d'affichage | article avec `art_ect`/`art_ect2`, `ttc` vrai/faux, `pxsdec`, `simpcond`, `remise` sur BL | `eco.tee`/`eco.tea` (A01 figée : 0 en TTC), montants formatés | `tests/ecotaxe_options/` | à faire |
| OBJFAC-T11 | gbtest | Cumul de remises entre deux `calcul` | même objet, deux clients successifs (comme `editefm`) | `remart`/`remmo` cumulés (A02 figée) | `tests/cumul_remises/` | à faire |
| OBJFAC-T12 | gbtest | `ecriturecompt` | BL facturable ; BL réglé par ticket non mouliné (sans message : à exclure ou doubler) | `Fiches_Mvt` (dump), `Fiches_Bl` (`numfac`, `imp`, `reg`, dates), `Fiches_Suivis` | `tests/ecriture_comptable/` | à faire |
| OBJFAC-T13 | gbtest | `FactType2Orig` / `Orig2FactType` | toutes les énumérations, -1, 99 ; `"BL"`, `"Facture"`, `"x"` | libellés ; `Orig2FactType("BL") = 0` (figé) | `tests/origine/` | à faire |
| OBJFAC-T14 | replay | `CopieGedFac` et `testchem` | client `cli_copie = 1` avec `tag_def`, puis `cli_copie = 0` ; édition d'une facture via `OptFac` | `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` (dump), fichiers PDF créés (noms sans horodatage) | `tests/copie_ged/` | à faire |
| OBJFAC-T15 | replay | `verifdat` | facture sans date d'échéance ; date en période close ; `dtmouv` | messages ; `Fiches_Ligbl.dte_ligbl` | `tests/verif_dates/` | à faire |
| OBJFAC-T16 | gbtest | Performance de `calcul` | BL de 500 lignes | durée de référence (`gbx3 -p`) ; nombre de requêtes | `tests/perf_calcul/` | à faire |

## Détail des tests

- **Jeu `facturation_base`** (dérivé de `Laurux01.sql`, qui ne contient ni BL ni vendeur) : à
  partager avec `Facture`, `OptFac`, `Facturefm`, `FacturefmA`, `Facturergbl`, `SaiReg`.
  Contenu : `Fiches_Parametres` (`devise`, `jrnal4`, `cptfrais`, `tvafrais`, `dnbon`,
  `dtepec`), 3 taux de TVA (`Fiches_Tvaav`) et leurs comptes, 2 familles (`compt_fam`,
  `compt5_fam`), articles (dont écotaxe, article composé `art_prdcomp`/`art_impdetail`), une MO,
  clients (standard, exonéré, auto-entrepreneur, divers, avec échéance, `cli_copie`, `tag_def`,
  `cli_regr` = D/Q/M, `cli_aban`/`cli_datab` pour l'abonnement), échéances, règlements,
  `Fiches_Tleg`, `Fiches_LibelFac`, BL `B` en `Fiches_Bl` et `Fiches_BlM` avec lignes de tous
  types, BL facturés (`F`, `imp = 1`), BL d'abonnement (`A`), factures archivées
  (`Fiches_HistoFac`/`HistoLigfac` et `M`), `Fiches_Suivis`, `Fiches_AdrlivC`, `Fiches_AdrlivBL`.
  Le script SQL du jeu est à produire en phase 2 dans `tests/_donnees/facturation_base.sql`.
- **Valeurs attendues** : produites en exécutant les mêmes appels dans le clone Laurux **non
  modifié** (sortie `id;valeur` capturée dans `tests/<nom>/expected/`), date figée (`faketime`)
  car `_new` utilise `LDate(Now)` par défaut. Les anomalies A01-A03 sont figées.
- **Comparaison des collections** : sérialiser `ligne` (clé, `type`, `libel`, montants), `tva`
  (clé, `totht`, `tottc`, `tottva`) et `ecrit` (compte, débit, crédit, libellé), triés par clé.
- **Écritures (`T12`)** : le dump normalisé fait foi ; `EcrAuto` affecte des numéros séquentiels,
  la base doit être réinitialisée avant chaque test.
- **Non testable en gbtest** : messages (`Message.*`), impression, `Music` ; ces chemins passent
  par T14/T15 (replay) ou sont exclus.
