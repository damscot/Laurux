# Utils — Dépendances

> Source : `.src/Utils/Utils.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Utils.module` — module
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `do_pcre_extract`, `Form_Close`, `Cdate_Comp2`, `Cdate_Com`, `convStr`, `Nsoc`, `Fcoulfond`, `PageFormatGetX`, `PageFormatGetY`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [1616](../../../../.src/Utils/Utils.module#L1616)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/ACom.class` | `CDec`, `db` |
| `.src/Affichages/AFacture.class` | `CDec`, `db` |
| `.src/Affichages/TriArticles.class` | `Fcolr`, `Log`, `ObsGotf`, `Observers`, `Obstch`, `db` |
| `.src/Affichages/TriBl.class` | `Base2`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `cpoint`, `db`, `rs2` |
| `.src/Affichages/TriCpt.class` | `db` |
| `.src/Affichages/TriEcritures.class` | `Base`, `ObsGotf`, `ObsLstf`, `Observers`, `rs1` |
| `.src/Affichages/TriEcritures2.class` | `Base`, `ObsGotf`, `ObsLstf`, `Observers`, `rs1` |
| `.src/Affichages/TriEqu.class` | `Base2`, `Observers`, `cpoint`, `db`, `rs2` |
| `.src/Affichages/TriFac.class` | `Base2`, `Fcolr`, `cpoint`, `rs2` |
| `.src/Affichages/TriFac2.class` | `Base2`, `Fcolr`, `cpoint`, `rs2` |
| `.src/Affichages/TriFacture.class` | `Observers`, `db` |
| `.src/Affichages/TriGen.class` | `Observers`, `db` |
| `.src/Affichages/TriHistos.class` | `CDec`, `Cdate_Aff`, `ObsGotf`, `ObsLstf`, `cpoint`, `db` |
| `.src/Affichages/TriMat.class` | `Base2`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |
| `.src/Affichages/TriMo.class` | `Base4`, `Observers`, `rs4` |
| `.src/Affichages/Tricp.class` | `Base2`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |
| `.src/Archivages/Archives.class` | `Base`, `Cdate_Aff`, `Fcolr`, `ObsLstf`, `Observers`, `Option`, `cpoint`, `db`, `orientation`, `rs1` |
| `.src/Archivages/ArchivesTck.class` | `Cdate_Carte`, `Cdate_Comp`, `Observers`, `cpoint`, `db` |
| `.src/Archivages/RazClientd.class` | `db` |
| `.src/Archivages/RazDevis.class` | `db` |
| `.src/Archivages/RazHistoFac.class` | `db` |
| `.src/Archivages/RazHistoFbl.class` | `db` |
| `.src/Archivages/RazHistoTk.class` | `db` |
| `.src/Archivages/RazRlvb.class` | `db` |
| `.src/Caisse/Affichages/Tricartes.class` | `Base2`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |
| `.src/Caisse/Affichages/TriclientsD.class` | `Base2`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |
| `.src/Caisse/Attrib.class` | `Observers`, `convBool`, `db` |
| `.src/Caisse/Bordereaux.class` | `cpoint`, `db` |
| `.src/Caisse/Caisse.class` | `Bip`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Observers`, `Remplace`, `Replace`, `convBool`, `cpoint`, `db` |
| `.src/Caisse/Clavier.class` | `Observers` |
| `.src/Caisse/Cmenu.class` | `Observers`, `db`, `glb`, `monteTunnel` |
| `.src/Caisse/FClientcarte.class` | `Base`, `Calcode`, `Cdate_Aff`, `Cdate_Dbase`, `Fcolr`, `Fill_Civilite`, `Find_cbarre`, `ObsGotf`, `ObsLstf`, `Observers`, `Remplace`, `SetEditColor`, `chkEmail`, `cpoint`, `db`, `rs1` |
| `.src/Caisse/Fcaisses.class` | `Observers`, `db` |
| `.src/Caisse/Fclientc.class` | `db` |
| `.src/Caisse/Fondcaisse.class` | `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Caisse/Fvendeurs.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Caisse/LibelAvoirs.class` | `ReplaceLb`, `db` |
| `.src/Caisse/LibelTicket.class` | `ReplaceLb`, `db` |
| `.src/Caisse/Moulinage.class` | `Bip`, `Cdate_Dbase`, `Find_nbdec`, `MouseDefault`, `MouseProcessing`, `Option`, `PointBase`, `Replace`, `arrondi`, `cpoint`, `db` |
| `.src/Caisse/Ouverture.class` | `Observers`, `db` |
| `.src/Caisse/Preferences.class` | `Observers` |
| `.src/Caisse/Statcai.class` | `Observers`, `cpoint`, `db` |
| `.src/Caisse/Svendeur.class` | `Observers`, `db` |
| `.src/Communs/Deblockbl.class` | `db` |
| `.src/Communs/DocActif.class` | `Base2`, `Bip`, `db`, `rs2` |
| `.src/Communs/FAbout.class` | `Observers` |
| `.src/Communs/FRestore.class` | `Clear_DataBase`, `Create_DataBase`, `Exit`, `Fill_DataBase`, `db`, `fermeTunnel` |
| `.src/Communs/FSauve.class` | `Observers`, `db` |
| `.src/Communs/FTips.class` | `Fcolr`, `Observers` |
| `.src/Communs/Fmenu.class` | `Base`, `Cdate_Dbase`, `ControlTunnel`, `Exit`, `Observers`, `db`, `fermeTunnel`, `glb`, `monteTunnel`, `rs1` |
| `.src/Communs/Fprepdus.class` | `cpoint`, `db` |
| `.src/Communs/Fsoc.class` | `Observers`, `SetEditColor`, `chkEmail`, `db` |
| `.src/Communs/Fsystem.class` | `db` |
| `.src/Communs/Fusers.class` | `Fcolr`, `Observers`, `db` |
| `.src/Communs/LauruxConf.class` | `Fill_DataBase`, `MysqlServeur`, `Observers`, `RemotePort`, `SshHost`, `SshPassphrase`, `SshPassw`, `SshPort`, `SshUser`, `db`, `fermeTunnel`, `monteTunnel` |
| `.src/Communs/LauruxMaj.module` | `cpoint`, `db` |
| `.src/Communs/Majversion.class` | `db` |
| `.src/Communs/Parametre.class` | `Cdate_Aff`, `Cdate_calc`, `Observers`, `Option`, `db` |
| `.src/Communs/Prefs.class` | `Observers`, `cpoint`, `db`, `totobs` |
| `.src/Communs/Prgm.class` | `Observers`, `db` |
| `.src/Communs/Raz.class` | `db` |
| `.src/Communs/SauvesAuto.module` | `db` |
| `.src/Compta/Analytique.class` | `cpoint`, `db` |
| `.src/Compta/Ccomptes.module` | `Base3`, `cpoint`, `rs3` |
| `.src/Compta/Cecrit.module` | `Base`, `rs1` |
| `.src/Compta/Cielcorsp.class` | `Ciel`, `Observers`, `db` |
| `.src/Compta/Cielcorspj.class` | `Ciel`, `Observers`, `db` |
| `.src/Compta/Cielimp.class` | `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Compta/Clotures/FCloture.class` | `Cdate_Aff`, `Cdate_Dbase`, `Observers`, `db`, `fermeTunnel` |
| `.src/Compta/Clotures/FClotureAn.class` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Compta/Echeances.class` | `Calcech`, `Cdate_Aff`, `Cdate_calc`, `Observers`, `SetEditColor`, `convBool`, `db` |
| `.src/Compta/Extrait.class` | `Cdate_Comp`, `Cdate_Dbase`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Impressions/Anomalies.class` | `Cdate_Dbase`, `db` |
| `.src/Compta/Impressions/Balance.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Impressions/BalanceM.module` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `db` |
| `.src/Compta/Impressions/BordereauxC.class` | `Cdate_Dbase`, `Fcolr`, `cpoint`, `db` |
| `.src/Compta/Impressions/Echeancier.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `db` |
| `.src/Compta/Impressions/EcrM.class` | `Calc_mois`, `Cdate2_Dbase`, `Cdate_Aff`, `Cdate_calc`, `Observers`, `db` |
| `.src/Compta/Impressions/EdImpayes.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Impressions/EdNjustifiees.class` | `Cdate_Aff`, `Coulfd`, `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |
| `.src/Compta/Impressions/EdNlettrees.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `db` |
| `.src/Compta/Impressions/Editcompte.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Impressions/EditcompteA.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Impressions/EditcompteM.module` | `Cdate_Aff`, `Cdate_Dbase`, `db` |
| `.src/Compta/Impressions/ExportA47.class` | `Accent`, `Observers`, `db` |
| `.src/Compta/Impressions/FTVA.class` | `Cdate_Aff`, `Cdate_Comp`, `Coulfd`, `cpoint`, `db` |
| `.src/Compta/Impressions/Imp_Bilan.module` | `Cdate_Dbase`, `PointBase`, `cpoint`, `db` |
| `.src/Compta/Impressions/Imp_Sig.module` | `Cdate_Dbase`, `cpoint`, `db` |
| `.src/Compta/Impressions/Jourcent.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Observers`, `db` |
| `.src/Compta/Impressions/Journaux.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `cpoint`, `db` |
| `.src/Compta/Impressions/JournauxA.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `db` |
| `.src/Compta/Impressions/JournauxM.module` | `Cdate_Aff`, `Cdate_Dbase`, `db` |
| `.src/Compta/Impressions/Plancomptable.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `.src/Compta/Impressions/RubImp.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Impressions/journauxSetting.class` | `Observers` |
| `.src/Compta/Lettrages/Lettrage.class` | `Cdate_Aff`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Lettrages/Lettragemontant.class` | `Observers`, `db` |
| `.src/Compta/Lettrages/Lettragesoldes.class` | `Observers`, `db` |
| `.src/Compta/Lettrages/Visimpayes.class` | `Cdate_Aff`, `Coulfd`, `Observers`, `db` |
| `.src/Compta/Pointage.class` | `Bip`, `Cdate_Aff`, `db` |
| `.src/Compta/Relances/FEditrel.class` | `Cdate_Aff`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Relances/FPrepRel2.class` | `Cdate_Aff`, `Cdate_calc`, `Observers`, `db` |
| `.src/Compta/Relances/FRelCompte.class` | `Cdate_Aff`, `Cdate_calc`, `Coulfd`, `Observers`, `db` |
| `.src/Compta/Relances/FRelFacture.class` | `Cdate_Aff`, `Cdate_calc`, `Coulfd`, `Observers`, `cpoint`, `db` |
| `.src/Compta/Relances/FRelance.class` | `Observers`, `db` |
| `.src/Compta/Relances/Ligcli.class` | `Cdate_Aff`, `cpoint`, `db` |
| `.src/Compta/Relances/Ligext.class` | `db` |
| `.src/Compta/Saisecrit.class` | `Calcech`, `Cdate_Aff`, `Cdate_calc`, `Observers`, `Remplace`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Tables/Abont.class` | `Bip`, `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Tables/FCollectif.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Tables/FComptes.class` | `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `PointBase`, `convBool`, `db` |
| `.src/Compta/Tables/FJournaux.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Tables/FLibelle.class` | `Observers`, `Remplace`, `db` |
| `.src/Compta/Tables/FPostes.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Tables/FTvac.class` | `Observers`, `PointBase`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Tables/FTvav.class` | `Find_nbdec`, `Observers`, `PointBase`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Trecarts.class` | `Observers`, `cpoint`, `db` |
| `.src/Compta/Tresor.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `Remplace`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Utils/Dup.class` | `Observers`, `db` |
| `.src/Compta/Utils/EcrAuto.class` | `arrondi`, `db` |
| `.src/Compta/Utils/EcrReg.class` | `db` |
| `.src/Compta/Utils/Ecritures.class` | `Cdate_Aff`, `Observers`, `cpoint`, `db` |
| `.src/Compta/Utils/Epurjdv.class` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Observers`, `db` |
| `.src/Compta/Utils/Equilibrage.class` | `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Compta/Utils/ExportJdv.class` | `Accent`, `CSlash`, `Calc_mois`, `Cdate_Aff`, `Cdate_Cador`, `Cdate_Ciel`, `Cdate_Dbase`, `Cdate_Sage`, `Cdate_calc`, `Observers`, `db` |
| `.src/Compta/Utils/Exprub.class` | `db` |
| `.src/Compta/Utils/Fmontant.class` | `Cdate_Aff`, `Observers`, `PointBase`, `SetEditColor`, `db` |
| `.src/Compta/Utils/ImpJdv.class` | `Cdate_Dbase`, `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Compta/Utils/ImpSage.class` | `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Compta/Utils/Intjdv.class` | `Cdate_Aff`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Utils/Listextcpt.class` | `arrondi`, `db` |
| `.src/Compta/Utils/RazClos.class` | `db` |
| `.src/Compta/Utils/Recalcsolde.module` | `PointBase`, `db` |
| `.src/Compta/Utils/RecupDech.class` | `db` |
| `.src/Compta/Utils/RenAN.class` | `db` |
| `.src/Compta/Utils/RenMvt.module` | `db` |
| `.src/Compta/Utils/Renech.class` | `db` |
| `.src/Compta/Utils/Rubcompt.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Compta/Utils/Rubresult.class` | `Observers`, `Remplace`, `SetEditColor`, `db` |
| `.src/Compta/Utils/TypeClient.class` | `db` |
| `.src/Compta/Utils/VarEcr.class` | `arrondi` |
| `.src/Compta/Utils/Verbal.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Compta/Utils/impfec.class` | `Ciel`, `Observers`, `db` |
| `.src/Gestion/ClotureF.class` | `Cdate_Aff`, `Observers`, `Option`, `PointBase`, `db`, `fermeTunnel` |
| `.src/Gestion/Depots/Depots.class` | `Base`, `ObsGotf`, `Observers`, `SetEditColor`, `db`, `rs1` |
| `.src/Gestion/Depots/Edsdepots.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Depots/ImpDepots.class` | `Coulfd`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `db` |
| `.src/Gestion/Depots/MvtDepots.class` | `CDec`, `Cdate_Dbase`, `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Depots/Sdepots.class` | `CDec`, `Cdate_Dbase`, `Coulfd`, `ObsGotf`, `ObsLstf`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Entrées/Achat.class` | `Find_cbarre`, `cpoint`, `db` |
| `.src/Gestion/Entrées/DateTar.class` | `db` |
| `.src/Gestion/Entrées/GesTar.class` | `db`, `totobs` |
| `.src/Gestion/Etiquettes/Dymo.module` | `Remplace` |
| `.src/Gestion/Etiquettes/Eticli.class` | `Base`, `Fcolr`, `Observers`, `db`, `rs1` |
| `.src/Gestion/Etiquettes/Etigond.class` | `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Etiquettes/EtiqPromo.class` | `Cdate_Aff`, `Find_nbdec`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Etiquettes/EtiqRecpt.class` | `Fcolr`, `Find_nbdec`, `Observers`, `db` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `Fcolr`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Etiquettes/Etiqfbtarif.class` | `Cdate_Dbase`, `Find_nbdec`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Etiquettes/Etiquettes.class` | `Fcolr`, `Observers`, `PageFormatSupported`, `db` |
| `.src/Gestion/Etiquettes/Zebra.module` | `Remplace` |
| `.src/Gestion/Facturation/ConVendeurs.class` | `db` |
| `.src/Gestion/Facturation/Facture.class` | `Base`, `Base3`, `Base4`, `Calcech`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Commande`, `ControlTunnel`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `Option`, `PointBase`, `Remplace`, `ReplaceLb`, `SetEditColor`, `cpoint`, `db`, `rs1`, `rs3`, `rs4`, `totobs` |
| `.src/Gestion/Facturation/Facturefm.class` | `Cdate_Aff`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `Option`, `cpoint`, `db`, `lastday`, `orientation`, `totobs` |
| `.src/Gestion/Facturation/FacturefmA.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Facturation/Facturergbl.class` | `Calcech`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Facturation/ObjFac.class` | `CDec`, `Calcech`, `arrondi`, `cpoint`, `db`, `totobs` |
| `.src/Gestion/Facturation/OptFac.class` | `db` |
| `.src/Gestion/Facturation/SaiReg.class` | `Observers`, `arrondi`, `cpoint`, `db` |
| `.src/Gestion/Impressions/EdArt1.class` | `Coulfd`, `Fcolr`, `Find_nbdec`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/EdArt2.class` | `Find_nbdec`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/EdArt3.class` | `Coulfd`, `Fcolr`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Impressions/EdClient.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/EdDocs.class` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Impressions/EdFam.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/EdFour.class` | `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/EdMat.class` | `Find_nbdec`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/EdPrep.class` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Impressions/EdReg.class` | `db` |
| `.src/Gestion/Impressions/EdRup.class` | `Coulfd`, `Fcolr`, `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Impressions/EdStk.class` | `CDec`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Impressions/Edart4.class` | `ObsGotf`, `ObsLstf`, `Observers`, `Option`, `db`, `totobs` |
| `.src/Gestion/Impressions/Edbl.class` | `Cdate_Aff`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/Edbr.module` | `cpoint`, `db` |
| `.src/Gestion/Impressions/Edcom.class` | `Cdate_Aff`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/Edmo.class` | `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Impressions/Edpaiement.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Impressions/Edregul.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/Edregulprdc.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Impressions/Traites.class` | `Cdate_Aff`, `Coulfd`, `Observers`, `db` |
| `.src/Gestion/Lcr/Attribution.class` | `Base`, `Coulfd`, `Fcolr`, `ObsLstf`, `convBool`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Lcr/Banque.class` | `Base`, `Fcolr`, `ObsLstf`, `Remplace`, `db`, `rs1` |
| `.src/Gestion/Lcr/Bordrx.class` | `Base`, `Coulfd`, `Fcolr`, `Observers`, `Replace`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Lcr/CLcr.class` | `cpoint` |
| `.src/Gestion/Lcr/Glcr.class` | `Cdate_Aff`, `Fcolr`, `Observers`, `convBool`, `cpoint`, `db` |
| `.src/Gestion/Lcr/Lcr.class` | `Base`, `Cdate_Aff`, `Coulfd`, `Fcolr`, `ObsLstf`, `convBool`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Lcr/Portables/Majcasier.class` | `Fcolr`, `Find_cbarre`, `Observers`, `db` |
| `.src/Gestion/Lcr/Portables/Portable.module` | `Find_cbarre`, `cpoint`, `db` |
| `.src/Gestion/Lcr/Preparation.class` | `Base`, `Cdate_Aff`, `Coulfd`, `Fcolr`, `ObsLstf`, `Observers`, `convBool`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Mails/Emailing.class` | `Base`, `Fcolr`, `Observers`, `db`, `rs1` |
| `.src/Gestion/Mails/EmailingCarte.class` | `Base`, `Fcolr`, `Observers`, `db`, `rs1` |
| `.src/Gestion/Reglements/TresorFac.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `PointBase`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Reglements/Visreglements.class` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `Observers`, `PointBase`, `db` |
| `.src/Gestion/SMS/Gsm.class` | `Observers`, `db` |
| `.src/Gestion/SMS/Psms.class` | `db` |
| `.src/Gestion/SMS/Sms.class` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |
| `.src/Gestion/Stock/Epurmvtexp.class` | `Cdate_Aff`, `Cdate_Comp`, `Cdate_calc`, `Observers`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` | `Observers`, `PointBase`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` | `CDec`, `Coulfd`, `Find_nbdec`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` | `CDec`, `Coulfd`, `Find_nbdec`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` | `CDec`, `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` | `Cdate_Dbase`, `Coulfd`, `Observers`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` | `Observers`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` | `CDec`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` | `Observers`, `Option`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` | `Coulfd`, `Fcolr`, `Observers`, `PointBase`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` | `CDec`, `Coulfd`, `Find_nbdec`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` | `CDec`, `Coulfd`, `Observers`, `PointBase`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` | `Cdate_Dbase`, `Coulfd`, `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` | `Observers`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` | `CDec`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` | `Observers`, `db` |
| `.src/Gestion/Stock/Listecom.class` | `Observers`, `db` |
| `.src/Gestion/Stock/MvtProdcomp.class` | `CDec`, `Cdate_Dbase`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Stock/Mvtex.class` | `CDec`, `Find_cbarre`, `Observers`, `Option`, `cpoint`, `db`, `totobs` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `Cdate_Dbase`, `Fcolr`, `Next_Code`, `Observers`, `SetEditColor`, `convBool`, `cpoint`, `db` |
| `.src/Gestion/Stock/Tarifs/ImpartParam.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `.src/Gestion/Stock/Tarifs/MajEqu.module` | `db` |
| `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` | `Cdate_Dbase`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` | `Cdate_Dbase`, `Find_nbdec`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Stock/Tarifs/MajTarifM.class` | `Base`, `CDec`, `Fcolr`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `ObsLstf2`, `Observers`, `Obstch`, `SetEditColor`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Stock/Tarifs/MajTarifP.class` | `Find_nbdec`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Stock/ValidBR.class` | `Calcech`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `Option`, `convBool`, `cpoint`, `db`, `totobs` |
| `.src/Gestion/Stock/ValidBR1.class` | `Option`, `db` |
| `.src/Gestion/Stock/VarMajTar.class` | `db` |
| `.src/Gestion/Stock/commande1.class` | `Option`, `db` |
| `.src/Gestion/Stockmvt.class` | `Observers`, `db`, `fam`, `totobs` |
| `.src/Gestion/Suivi.class` | `Cdate_Aff`, `Cdate_Dbase`, `Coulfonds`, `Formattage`, `ObsGotf`, `ObsLstf`, `cpoint`, `db` |
| `.src/Gestion/SupprArt.class` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `db` |
| `.src/Gestion/Tables/ArtPromo.module` | `db` |
| `.src/Gestion/Tables/Articles.class` | `Bip`, `CDec`, `Calcode`, `Cdate_Aff`, `Cdate_Dbase`, `Commande`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `Next_Code`, `ObsGotf`, `ObsLstf`, `Observers`, `Option`, `Remplace`, `SetEditColor`, `convBool`, `cpoint`, `db` |
| `.src/Gestion/Tables/Btqart.class` | `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `.src/Gestion/Tables/Centrales.class` | `Fcolr`, `Observers`, `db` |
| `.src/Gestion/Tables/CoefTypeC.class` | `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Tables/ComMail.class` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |
| `.src/Gestion/Tables/Comment.class` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |
| `.src/Gestion/Tables/Commerciaux.class` | `ObsGotf`, `ObsLstf`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Tables/ConsultArt.class` | `Base`, `CDec`, `Fcolr`, `Find_cbarre`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `ObsLstf2`, `Observers`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Cpostaux.class` | `Base`, `Observers`, `SetEditColor`, `db`, `rs1` |
| `.src/Gestion/Tables/FClient.class` | `Base`, `Cdate_Dbase`, `Fcolr`, `Fill_Civilite`, `ObsGotf`, `ObsLstf`, `Observers`, `Option`, `Remplace`, `SetEditColor`, `chkEmail`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/FFournisseur.class` | `Base`, `Calcode`, `Fcolr`, `Fill_Civilite`, `Find_cbarre`, `ObsGotf`, `ObsLstf`, `Observers`, `Remplace`, `SetEditColor`, `chkEmail`, `convBool`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Famille.class` | `Fcolr`, `Observers`, `PointBase`, `Remplace`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Tables/Fpromo.class` | `Base`, `Cdate_Dbase`, `Fcolr`, `Observers`, `SetEditColor`, `db`, `rs1` |
| `.src/Gestion/Tables/FpromoArt.class` | `Base`, `Cdate_Aff`, `Fcolr`, `Find_cbarre`, `Observers`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Identite.class` | `Fcolr`, `Observers`, `db` |
| `.src/Gestion/Tables/LibelFac.class` | `Observers`, `ReplaceLb`, `db` |
| `.src/Gestion/Tables/Marques.class` | `Base`, `Observers`, `SetEditColor`, `db`, `rs1` |
| `.src/Gestion/Tables/Materiel.class` | `Base`, `CDec`, `Cdate_Aff`, `Cdate_Dbase`, `Fcolr`, `Find_nbdec`, `ObsGotf`, `ObsLstf`, `Observers`, `Remplace`, `SetEditColor`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Movr.class` | `Base`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `PointBase`, `Remplace`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Mreglement.class` | `Observers`, `db` |
| `.src/Gestion/Tables/Prodcomposes.class` | `Base`, `Fcolr`, `Find_nbdec`, `Observers`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Remisec.class` | `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Gestion/Tables/Remisecli.class` | `Base`, `Fcolr`, `Observers`, `cpoint`, `db`, `rs1` |
| `.src/Gestion/Tables/Statut.class` | `Fcolr`, `Observers`, `db` |
| `.src/Gestion/Tables/TarTypeCli.class` | `db` |
| `.src/Gestion/Tables/Tleg.class` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |
| `.src/Gestion/Tables/Tmail.class` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |
| `.src/Gestion/Tables/Txmo.class` | `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Gestion/Tables/Typec.class` | `Fcolr`, `Observers`, `db` |
| `.src/Gestion/option/Caleditcmat.class` | `db` |
| `.src/Gestion/option/Consigne.class` | `db` |
| `.src/Gestion/option/Ecomptamat.class` | `db`, `lastday` |
| `.src/Gestion/option/Edconsigne.class` | `Observers`, `db` |
| `.src/Gestion/option/EditStkDepart.class` | `db` |
| `.src/Gestion/option/EditfacB.class` | `Option`, `totobs` |
| `.src/Gestion/option/Edittipp.class` | `db` |
| `.src/Gestion/option/Einvmat.class` | `db`, `lastday` |
| `.src/Gestion/option/ObjFacB.class` | `Option`, `arrondi`, `db`, `totobs` |
| `.src/Gestion/option/Saisiedecons.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db`, `totobs` |
| `.src/Gestion/option/Tconsigne.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `.src/Gestion/option/Tregie.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db`, `mois` |
| `.src/Gestion/option/Tregion.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `.src/Gestion/option/Ttarfioul.class` | `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `.src/Gestion/option/Ttourne.class` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `.src/Gestion/option/Visucmat.class` | `db` |
| `.src/Gestion/option/artopt.class` | `ObsGotf`, `ObsLstf`, `db` |
| `.src/Gestion/option/atribvignette.class` | `db` |
| `.src/Gestion/option/calculdroit.class` | `arrondi`, `db` |
| `.src/Gestion/option/calculdroit1.class` | `Option`, `db` |
| `.src/Gestion/option/facopt.class` | `ObsGotf`, `ObsLstf`, `db`, `totobs` |
| `.src/Gestion/option/fourconsdroi.class` | `db`, `totobs` |
| `.src/Gestion/option/modfichier.module` | `db` |
| `.src/Gestion/option/rechcons.class` | `db` |
| `.src/Gestion/option/rechtipp.class` | `db` |
| `.src/Gestion/option/rechtour.class` | `db` |
| `.src/Gestion/option/ticpe.class` | `db` |
| `.src/Reports/Cbalances.class` | `cpoint` |
| `.src/Reports/Cbilan.class` | `cpoint` |
| `.src/Reports/Ccompta.class` | `cpoint` |
| `.src/Reports/Cetiquettes.class` | `cpoint` |
| `.src/Reports/Csig.class` | `cpoint` |
| `.src/Reports/Editfac.class` | `db`, `totobs` |
| `.src/Serveur.module` | `db` |
| `.src/Start.module` | `Clear_DataBase`, `ControlTunnel`, `Create_DataBase`, `Exit`, `Fill_DataBase` |
| `.src/Statistiques/Histocliart.class` | `Coulfd`, `Fcolr`, `Observers`, `db`, `fam` |
| `.src/Statistiques/Histovmo.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/HitCarte.class` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/RelMoprod.class` | `Base2`, `CDec`, `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `SetEditColor`, `db`, `rs2` |
| `.src/Statistiques/RelvMo.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Comp`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/StatClimo.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/StatComArt.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/StatComm.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/StatFour.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `db` |
| `.src/Statistiques/StatPromo.class` | `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Statistiques/StatTypCli.class` | `Calc_mois`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Fcolr`, `Observers`, `SetEditColor`, `cpoint`, `db` |
| `.src/Statistiques/Statbase.class` | `Fcolr`, `Observers`, `db` |
| `.src/Statistiques/TBord.class` | `Cdate_Dbase`, `PointBase`, `cpoint`, `db` |
| `.src/Statistiques/VisHitCartes.class` | `Coulfd`, `Fcolr`, `Observers`, `db` |
| `.src/Statistiques/VisStatClimo.class` | `Coulfd`, `Fcolr`, `Observers`, `db` |
| `.src/Statistiques/VisStatComArt.class` | `Coulfd`, `Fcolr`, `Observers`, `db` |
| `.src/Statistiques/VisStatComm.class` | `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Statistiques/VisStatFour.class` | `Coulfd`, `db` |
| `.src/Statistiques/VisStatTypCli.class` | `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `.src/Tests/TriTest.class` | `db` |
| `.src/Utils/AffRdv.module` | `db` |
| `.src/Utils/Agenda.class` | `db` |
| `.src/Utils/CPrix.module` | `cpoint`, `db` |
| `.src/Utils/Calc.class` | `cpoint` |
| `.src/Utils/CalcRem.class` | `PointBase`, `cpoint`, `db` |
| `.src/Utils/Calcsolde.class` | `MouseDefault`, `MouseProcessing`, `Observers`, `db` |
| `.src/Utils/Calcstock.class` | `Observers`, `db` |
| `.src/Utils/Changefam.class` | `Find_cbarre`, `Observers`, `db` |
| `.src/Utils/Changefour.class` | `Find_cbarre`, `Observers`, `db` |
| `.src/Utils/CompArt.class` | `db` |
| `.src/Utils/Crupt.module` | `cpoint`, `db` |
| `.src/Utils/Csolde.module` | `PointBase`, `db` |
| `.src/Utils/Cstock.module` | `db` |
| `.src/Utils/DB_Connection.class` | `Find_cbarre`, `MouseDefault`, `MouseProcessing`, `Option`, `db` |
| `.src/Utils/DB_Sanity.class` | `db` |
| `.src/Utils/Dcfour.class` | `Observers`, `db` |
| `.src/Utils/Enrgcp.module` | `db` |
| `.src/Utils/Epurfour.class` | `db` |
| `.src/Utils/Exports-Imports/Expart.class` | `Find_nbdec`, `Observers`, `db` |
| `.src/Utils/Exports-Imports/Expbase.class` | `Observers`, `db` |
| `.src/Utils/Exports-Imports/Expclient.class` | `Observers`, `db` |
| `.src/Utils/Exports-Imports/Expcontact.class` | `db` |
| `.src/Utils/Exports-Imports/Impclient.class` | `Observers`, `db` |
| `.src/Utils/Exports-Imports/Impcpostaux.class` | `db` |
| `.src/Utils/Exports-Imports/ImportStk.class` | `db` |
| `.src/Utils/Exports-Imports/ImptartypeC.class` | `cpoint`, `db` |
| `.src/Utils/FCalc.class` | `Observers`, `cpoint` |
| `.src/Utils/FSetFormat.class` | `Observers`, `db` |
| `.src/Utils/GedR.class` | `db` |
| `.src/Utils/HistoCom.class` | `db` |
| `.src/Utils/LCoul.class` | `Fcolr` |
| `.src/Utils/LDate.class` | `db` |
| `.src/Utils/LGed.class` | `Mkdir_p`, `Rmdir_rf`, `db` |
| `.src/Utils/LLog.class` | `db` |
| `.src/Utils/LPrix.class` | `FloatParse` |
| `.src/Utils/LScript.class` | `Log` |
| `.src/Utils/LTaxe.class` | `FloatParse` |
| `.src/Utils/Mmysql.module` | `db` |
| `.src/Utils/ObjProp.class` | `CDec` |
| `.src/Utils/Papmp.class` | `db` |
| `.src/Utils/ProgBar.class` | `Observers` |
| `.src/Utils/RazArt.class` | `db` |
| `.src/Utils/RecupN.class` | `db` |
| `.src/Utils/RenumBl.class` | `cpoint`, `db` |
| `.src/Utils/ReplayObserver.class` | `db`, `de` |
| `.src/Utils/RichDataGrid.class` | `Cdate_Aff` |
| `.src/Utils/SaiTableau.class` | `Accent`, `Option` |
| `.src/Utils/SetColors.class` | `Observers` |
| `.src/Utils/Sha1Calc.module` | `db` |
| `.src/Utils/TarArt.class` | `Option`, `db` |
| `.src/Utils/TextReg.class` | `db`, `de` |
| `.src/Utils/Trifam.class` | `db` |
| `.src/Utils/VerifDate.class` | `Option`, `db` |
| `.src/Utils/VerifNumfac.module` | `db` |
| `.src/Utils/VisPmp.class` | `Observers`, `db` |
| `.src/Utils/chainage.class` | `ObsGotf`, `ObsLstf` |
| `.src/Utils/gridv.module` | `db`, `mois` |
| `.src/Utils/gridvi.class` | `db`, `lastday`, `mois`, `totobs` |
| `.src/Utils/gridvi2.class` | `db`, `lastday`, `mois` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `<type>`, `Backtrace`, `Exec` |
| `DB_Desktop` | `<type>` |
| `LDate` | `<type>`, `GnT`, `_call` |
| `LLog` | `<type>` |
| `ReplayObserver` | `<type>` |
| `Start` | `Arg_Debug`, `Arg_Devel`, `Exit`, `LLogColl`, `LocalSettings`, `MainWindow`, `Musique`, `Societe`, `Success`, `son` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_CdBarre`, `Fiches_Identite`, `Fiches_Ligbl`, `Fiches_Ligcom`, `Fiches_Parametres`, `Fiches_ligcons`, `Fiches_ligregie`

### Membres Public sans usage externe détecté (portée réductible ?)

`do_pcre_extract`, `Form_Close`, `Cdate_Comp2`, `Cdate_Com`, `convStr`, `Nsoc`, `Fcoulfond`, `Recursive_Observers`, `PageFormatGetX`, `PageFormatGetY`, `Play`, `mysqlPort`, `TunnelPid`, `ROArray`
<!-- /AUTO:dependances -->

## Notes d'analyse

### Ce que l'heuristique rate : les blocs `With Utils`

194 fichiers contiennent environ 820 blocs `With Utils … End With` dans lesquels les membres sont
appelés sous la forme `.cpoint(…)`, `.rs1!champ`. `deps.py` ne les résout pas. Comptage par grep
(appels `.X` au premier niveau d'un bloc `With Utils`) :

| Membre | Occ. via `With` | Fichiers | Occ. via `Utils.X` | Fichiers |
|---|---|---|---|---|
| `cpoint` | 1 119 | 80 | 1 006 | 94 |
| `Cdate_Aff` | 213 | 66 | 44 | 20 |
| `Cdate_Dbase` | 169 | 45 | 87 | 24 |
| `PointBase` | 141 | 23 | 14 | 7 |
| `SetEditColor` | 74 | 66 | 14 | 12 |
| `Cdate_calc` | 72 | 41 | 6 | 5 |
| `rs1` | 65 | 27 | 2 | 1 |
| `Calc_mois` | 61 | 14 | 7 | 7 |
| `Remplace` | 47 | 8 | 25 | 12 |
| `Cdate_Comp` | 46 | 13 | 15 | 5 |
| `db` | 43 | 14 | 7 464 | 347 |
| `CDec` | 36 | 16 | 18 | 11 |
| `convBool` | 35 | 5 | 12 | 7 |
| `rs2` | 19 | 10 | 2 | 2 |
| `Find_nbdec` | 15 | 11 | 36 | 23 |
| `arrondi` | 15 | 1 | 43 | 7 |
| `Replace` | 13 | 1 | 10 | 3 |
| `rs3` | 8 | 2 (`Ccomptes`, `Facture`) | 0 | 0 |
| `Accent` | 6 | 2 | 1 | 1 |
| `rs4` | 2 | 1 (`TriMo`) | 2 | 1 |
| `CSlash`, `Cdate_Ciel`, `Cdate_Cador`, `Cdate_Sage` | 1 chacun | `ExportJdv` | 0 (sauf `Cdate_Sage` : 1) | |

**Faux positifs de « portée réductible »** dans le bloc AUTO : `CSlash`, `Cdate_Ciel`, `Cdate_Cador`
et `rs3` sont utilisés via `With Utils` (`ExportJdv.class:676-747`, `Ccomptes.module:17-18`). Ils
restent `Public`.

**Confirmés sans appelant externe** (grep `Utils.X` et `.X` dans `With Utils`) : `do_pcre_extract`,
`Form_Close`, `Cdate_Comp2`, `Cdate_Com`, `convStr`, `Nsoc`, `Fcoulfond`, `PageFormatGetX`,
`PageFormatGetY` (code mort) ; `Recursive_Observers`, `Play`, `TunnelPid`, `ROArray` (usage interne
seulement) ; `mysqlPort` (écrit par `glb`, jamais lu).

**Membres écrits mais jamais lus** : `SshPassw`, `SshPassphrase` (écrits par `glb` et
`LauruxConf.class:248,251` ; `sshpass` est commenté dans `monteTunnel`).

### Contrat implicite `BaseN` ↔ `rsN`

Les handlers `GridView_Data` des écrans lisent `Utils.rs1`…`rs4` remplis par `Base`…`Base4` :

- `Base`/`rs1` : `Archives`, `Attribution`, `Banque`, `Bordrx`, `Cecrit`, `ConsultArt`, `Cpostaux`,
  `Depots`, `Emailing`, `EmailingCarte`, `Eticli`, `Facture`, `FClient`, `FClientcarte`, `FFournisseur`,
  `Fmenu`, `Fpromo`, `FpromoArt`, `Lcr`, `MajTarifM`, `Marques`, `Materiel`, `Movr`, `Preparation`,
  `Prodcomposes`, `Remisecli`, `TriEcritures`, `TriEcritures2` ;
- `Base2`/`rs2` : `DocActif`, `RelMoprod`, `TriBl`, `Tricartes`, `TriclientsD`, `Tricp`, `TriEqu`,
  `TriFac`, `TriFac2`, `TriMat` ;
- `Base3`/`rs3` : `Archives`, `Ccomptes`, `Facture` ;
- `Base4`/`rs4` : `Facture`, `TriMo`.

Toute modification de `BaseN` doit être rejouée sur ces écrans (replays UTILS-T22).

### Appels dynamiques

- `Fill_Civilite` : `Object.Call(obj, "Add", [libelle])` (ligne 1616) ; `obj` est une `ComboBox`
  chez les trois appelants (`FClient`, `FFournisseur`, `FClientcarte`).
- `Recursive_Observers` teste `hCont Is Fmenu` : dépendance vers une classe GUI précise.

### Appels internes non qualifiés

`Bip` → `Utils.Play()` ; `Observers` → `Recursive_Observers` ; `SetEditColor`, `ObsGotf`, `ObsLstf`,
`Observers`, `ObsLstf2`, `Coulfd` → `Fcolr` ; `Commande` → `CDec`, `.cpoint` ; `orientation` →
`Option` ; `Form_Close` → `fermeTunnel` ; `CDec`, `Formattage`, `Coulfonds` → `Utils.cpoint`.

### Dépendances circulaires

- `Utils` ↔ `DB_Connection` : `Utils.db` est une `DB_Connection`, et `DB_Connection` appelle
  `Utils.Option`, `Utils.MouseProcessing`, `Utils.MouseDefault` et `Utils.db` (via `With Utils`).
- `Utils` ↔ `LPrix`/`LTaxe` (`FloatParse`), `Utils` ↔ `LDate` (`Cdate_Comp` utilise `LDate` ;
  `LDate` utilise `With Utils`).
- `Utils` ↔ `Start` (lecture de `Start.*`, et `Start.module` appelle `Exit`, `ControlTunnel`,
  `*_DataBase`).
- `Utils` ↔ `ReplayObserver`/`TextReg` (`Utils.de`).
- `Utils` → `Fmenu` (test de type dans `Recursive_Observers`).

### Contraintes d'ordre de rework

- `Utils` est en tête du graphe : ses reworks doivent **précéder** ceux des fichiers qui recopient
  ses fonctions (`cpoint` locaux, `arrondi` homonymes, `LauruxConf` pour le SSH).
- Ne pas modifier la signature des 30 fonctions les plus appelées (`cpoint`, `Cdate_*`, `Observers`,
  `ObsGotf`/`ObsLstf`, `Fcolr`, `BaseN`…) : toute factorisation reste interne.
- `Fill_DataBase` est utilisé par la restauration en ligne de commande (`Start.module:466-468`),
  donc par le futur harnais de tests (import de `Laurux01.sql`) : à reworker en dernier dans ce
  fichier.
