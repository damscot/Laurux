# DB_Connection — Dépendances

> Source : `.src/Utils/DB_Connection.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/DB_Connection.class` — classe, hérite de `Connection`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Enable_Log`, `Disable_Log`, `Print`
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [342](../../../../.src/Utils/DB_Connection.class#L342), [467](../../../../.src/Utils/DB_Connection.class#L467), [677](../../../../.src/Utils/DB_Connection.class#L677)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Affichages/ACom.class` | `Exec` |
| `.src/Affichages/AFacture.class` | `Exec` |
| `.src/Affichages/TriArticles.class` | `Exec` |
| `.src/Affichages/TriBl.class` | `Exec` |
| `.src/Affichages/TriCpt.class` | `Exec` |
| `.src/Affichages/TriEqu.class` | `Exec` |
| `.src/Affichages/TriFacture.class` | `Exec` |
| `.src/Affichages/TriGen.class` | `Exec` |
| `.src/Affichages/TriHistos.class` | `AutoIncrement`, `Engine`, `Exec` |
| `.src/Archivages/Archives.class` | `Engine`, `Exec` |
| `.src/Archivages/ArchivesTck.class` | `Engine`, `Exec` |
| `.src/Archivages/RazClientd.class` | `Exec` |
| `.src/Archivages/RazDevis.class` | `Exec` |
| `.src/Archivages/RazHistoFac.class` | `Exec` |
| `.src/Archivages/RazHistoFbl.class` | `Exec` |
| `.src/Archivages/RazHistoTk.class` | `Exec` |
| `.src/Archivages/RazRlvb.class` | `Exec` |
| `.src/Caisse/Attrib.class` | `Exec` |
| `.src/Caisse/Bordereaux.class` | `Exec` |
| `.src/Caisse/Caisse.class` | `Exec`, `LockIncrement` |
| `.src/Caisse/Cmenu.class` | `Exec` |
| `.src/Caisse/FClientcarte.class` | `Exec` |
| `.src/Caisse/Fcaisses.class` | `Exec` |
| `.src/Caisse/Fclientc.class` | `Exec` |
| `.src/Caisse/Fondcaisse.class` | `Exec` |
| `.src/Caisse/Fvendeurs.class` | `Exec` |
| `.src/Caisse/LibelAvoirs.class` | `Exec` |
| `.src/Caisse/LibelTicket.class` | `Exec` |
| `.src/Caisse/Moulinage.class` | `AutoIncrement`, `Create9`, `Engine`, `Exec`, `LockIncrement` |
| `.src/Caisse/Ouverture.class` | `Exec` |
| `.src/Caisse/Statcai.class` | `Engine`, `Exec` |
| `.src/Caisse/Svendeur.class` | `Exec` |
| `.src/Communs/Deblockbl.class` | `Exec` |
| `.src/Communs/DocActif.class` | `Exec` |
| `.src/Communs/FRestore.class` | `Close`, `Exec` |
| `.src/Communs/FSauve.class` | `<hérité>` |
| `.src/Communs/Fmenu.class` | `Close`, `Exec`, `IsType`, `type_mysql` |
| `.src/Communs/Fprepdus.class` | `Exec` |
| `.src/Communs/Fsoc.class` | `Close`, `Exec` |
| `.src/Communs/Fsystem.class` | `<hérité>` |
| `.src/Communs/Fusers.class` | `Exec` |
| `.src/Communs/LauruxConf.class` | `Close`, `Exec` |
| `.src/Communs/LauruxMaj.module` | `AutoIncrement`, `Create9`, `Engine`, `Exec` |
| `.src/Communs/Majversion.class` | `Exec` |
| `.src/Communs/Parametre.class` | `Edit`, `Exec` |
| `.src/Communs/Prefs.class` | `Exec` |
| `.src/Communs/Prgm.class` | `Exec` |
| `.src/Communs/Raz.class` | `Exec` |
| `.src/Communs/SauvesAuto.module` | `<hérité>` |
| `.src/Compta/Analytique.class` | `Exec` |
| `.src/Compta/Cielcorsp.class` | `Exec` |
| `.src/Compta/Cielcorspj.class` | `Exec` |
| `.src/Compta/Cielimp.class` | `Engine`, `Exec` |
| `.src/Compta/Clotures/FCloture.class` | `Close`, `Exec` |
| `.src/Compta/Clotures/FClotureAn.class` | `AutoIncrement`, `CopieTable`, `Engine`, `Exec` |
| `.src/Compta/Echeances.class` | `Exec` |
| `.src/Compta/Extrait.class` | `Exec` |
| `.src/Compta/Impressions/Anomalies.class` | `Exec` |
| `.src/Compta/Impressions/Balance.class` | `Exec` |
| `.src/Compta/Impressions/BalanceM.module` | `Exec` |
| `.src/Compta/Impressions/BordereauxC.class` | `Exec` |
| `.src/Compta/Impressions/Echeancier.class` | `Exec` |
| `.src/Compta/Impressions/EcrM.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/EdImpayes.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/EdNjustifiees.class` | `Exec` |
| `.src/Compta/Impressions/EdNlettrees.class` | `Exec` |
| `.src/Compta/Impressions/Editcompte.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/EditcompteA.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/EditcompteM.module` | `Engine`, `Exec` |
| `.src/Compta/Impressions/ExportA47.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/FTVA.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/Imp_Bilan.module` | `Engine`, `Exec` |
| `.src/Compta/Impressions/Imp_Sig.module` | `Engine`, `Exec` |
| `.src/Compta/Impressions/Jourcent.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/Journaux.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/JournauxA.class` | `Engine`, `Exec` |
| `.src/Compta/Impressions/JournauxM.module` | `Engine`, `Exec` |
| `.src/Compta/Impressions/Plancomptable.class` | `Exec` |
| `.src/Compta/Impressions/RubImp.class` | `Engine`, `Exec` |
| `.src/Compta/Lettrages/Lettrage.class` | `Exec` |
| `.src/Compta/Lettrages/Lettragemontant.class` | `Exec` |
| `.src/Compta/Lettrages/Lettragesoldes.class` | `Exec` |
| `.src/Compta/Lettrages/Visimpayes.class` | `Engine`, `Exec` |
| `.src/Compta/Pointage.class` | `Exec` |
| `.src/Compta/Relances/FEditrel.class` | `Engine`, `Exec` |
| `.src/Compta/Relances/FPrepRel2.class` | `Engine`, `Exec` |
| `.src/Compta/Relances/FRelCompte.class` | `AutoIncrement`, `Engine`, `Exec` |
| `.src/Compta/Relances/FRelFacture.class` | `Engine`, `Exec` |
| `.src/Compta/Relances/FRelance.class` | `Exec` |
| `.src/Compta/Relances/Ligcli.class` | `Exec` |
| `.src/Compta/Relances/Ligext.class` | `Create9`, `Exec` |
| `.src/Compta/Saisecrit.class` | `Engine`, `Exec` |
| `.src/Compta/Tables/Abont.class` | `Exec` |
| `.src/Compta/Tables/FCollectif.class` | `Exec` |
| `.src/Compta/Tables/FComptes.class` | `Exec` |
| `.src/Compta/Tables/FJournaux.class` | `Exec` |
| `.src/Compta/Tables/FLibelle.class` | `Exec` |
| `.src/Compta/Tables/FPostes.class` | `Exec` |
| `.src/Compta/Tables/FTvac.class` | `Exec` |
| `.src/Compta/Tables/FTvav.class` | `Exec` |
| `.src/Compta/Trecarts.class` | `Exec` |
| `.src/Compta/Tresor.class` | `Exec` |
| `.src/Compta/Utils/Dup.class` | `Exec` |
| `.src/Compta/Utils/EcrAuto.class` | `Create9`, `Edit`, `Exec`, `LockIncrement` |
| `.src/Compta/Utils/EcrReg.class` | `Exec` |
| `.src/Compta/Utils/Ecritures.class` | `Exec` |
| `.src/Compta/Utils/Epurjdv.class` | `AutoIncrement`, `Engine`, `Exec` |
| `.src/Compta/Utils/Equilibrage.class` | `Exec` |
| `.src/Compta/Utils/ExportJdv.class` | `Engine`, `Exec` |
| `.src/Compta/Utils/Exprub.class` | `Exec` |
| `.src/Compta/Utils/Fmontant.class` | `Exec` |
| `.src/Compta/Utils/ImpJdv.class` | `Engine`, `Exec` |
| `.src/Compta/Utils/ImpSage.class` | `Engine`, `Exec` |
| `.src/Compta/Utils/Intjdv.class` | `Engine`, `Exec` |
| `.src/Compta/Utils/Listextcpt.class` | `Exec` |
| `.src/Compta/Utils/RazClos.class` | `Exec` |
| `.src/Compta/Utils/Recalcsolde.module` | `Exec` |
| `.src/Compta/Utils/RecupDech.class` | `Exec` |
| `.src/Compta/Utils/RenAN.class` | `Exec` |
| `.src/Compta/Utils/RenMvt.module` | `Exec` |
| `.src/Compta/Utils/Renech.class` | `Exec` |
| `.src/Compta/Utils/Rubcompt.class` | `Exec` |
| `.src/Compta/Utils/Rubresult.class` | `Engine`, `Exec` |
| `.src/Compta/Utils/TypeClient.class` | `Exec` |
| `.src/Compta/Utils/Verbal.class` | `Exec` |
| `.src/Compta/Utils/impfec.class` | `Create9`, `Exec` |
| `.src/Gestion/ClotureF.class` | `Close`, `Exec` |
| `.src/Gestion/Depots/Depots.class` | `Exec` |
| `.src/Gestion/Depots/Edsdepots.class` | `Exec` |
| `.src/Gestion/Depots/ImpDepots.class` | `Exec` |
| `.src/Gestion/Depots/MvtDepots.class` | `Exec` |
| `.src/Gestion/Depots/Sdepots.class` | `Exec` |
| `.src/Gestion/Entrées/Achat.class` | `Create9`, `Edit`, `Exec`, `Lockstock`, `RecArt` |
| `.src/Gestion/Entrées/DateTar.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/Entrées/GesTar.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/Etiquettes/Eticli.class` | `Engine`, `Exec` |
| `.src/Gestion/Etiquettes/Etigond.class` | `Engine`, `Exec` |
| `.src/Gestion/Etiquettes/EtiqPromo.class` | `Exec` |
| `.src/Gestion/Etiquettes/EtiqRecpt.class` | `Exec` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `Engine`, `Exec` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `Engine`, `Exec` |
| `.src/Gestion/Etiquettes/Etiqfbtarif.class` | `Exec` |
| `.src/Gestion/Etiquettes/Etiquettes.class` | `Exec` |
| `.src/Gestion/Facturation/ConVendeurs.class` | `Exec` |
| `.src/Gestion/Facturation/Facture.class` | `Engine`, `Exec` |
| `.src/Gestion/Facturation/Facturefm.class` | `Engine`, `Exec` |
| `.src/Gestion/Facturation/FacturefmA.class` | `Engine`, `Exec` |
| `.src/Gestion/Facturation/Facturergbl.class` | `Engine`, `Exec` |
| `.src/Gestion/Facturation/ObjFac.class` | `Edit`, `Exec` |
| `.src/Gestion/Facturation/OptFac.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/Facturation/SaiReg.class` | `Create9`, `Engine`, `Exec` |
| `.src/Gestion/Impressions/EdArt1.class` | `Exec` |
| `.src/Gestion/Impressions/EdArt2.class` | `Exec` |
| `.src/Gestion/Impressions/EdArt3.class` | `Exec` |
| `.src/Gestion/Impressions/EdClient.class` | `Exec` |
| `.src/Gestion/Impressions/EdDocs.class` | `Exec` |
| `.src/Gestion/Impressions/EdFam.class` | `Exec` |
| `.src/Gestion/Impressions/EdFour.class` | `Exec` |
| `.src/Gestion/Impressions/EdMat.class` | `Exec` |
| `.src/Gestion/Impressions/EdPrep.class` | `Exec` |
| `.src/Gestion/Impressions/EdReg.class` | `Exec` |
| `.src/Gestion/Impressions/EdRup.class` | `Exec` |
| `.src/Gestion/Impressions/EdStk.class` | `Exec` |
| `.src/Gestion/Impressions/Edart4.class` | `Exec` |
| `.src/Gestion/Impressions/Edbl.class` | `Exec` |
| `.src/Gestion/Impressions/Edbr.module` | `Exec` |
| `.src/Gestion/Impressions/Edcom.class` | `Exec` |
| `.src/Gestion/Impressions/Edmo.class` | `Exec` |
| `.src/Gestion/Impressions/Edpaiement.class` | `AutoIncrement`, `Engine`, `Exec` |
| `.src/Gestion/Impressions/Edregul.class` | `Exec` |
| `.src/Gestion/Impressions/Edregulprdc.class` | `Exec` |
| `.src/Gestion/Impressions/Traites.class` | `AutoIncrement`, `Engine`, `Exec` |
| `.src/Gestion/Lcr/Attribution.class` | `Exec` |
| `.src/Gestion/Lcr/Banque.class` | `Exec` |
| `.src/Gestion/Lcr/Bordrx.class` | `Exec` |
| `.src/Gestion/Lcr/Glcr.class` | `Exec` |
| `.src/Gestion/Lcr/Lcr.class` | `Exec` |
| `.src/Gestion/Lcr/Portables/Majcasier.class` | `Exec` |
| `.src/Gestion/Lcr/Portables/Portable.module` | `Exec` |
| `.src/Gestion/Lcr/Preparation.class` | `Exec` |
| `.src/Gestion/Mails/Emailing.class` | `Engine`, `Exec` |
| `.src/Gestion/Mails/EmailingCarte.class` | `Engine`, `Exec` |
| `.src/Gestion/Reglements/TresorFac.class` | `Exec` |
| `.src/Gestion/Reglements/Visreglements.class` | `Engine`, `Exec` |
| `.src/Gestion/SMS/Gsm.class` | `Exec` |
| `.src/Gestion/SMS/Psms.class` | `Exec` |
| `.src/Gestion/SMS/Sms.class` | `Exec` |
| `.src/Gestion/Stock/Epurmvtexp.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` | `Engine`, `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/SaisieInv.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` | `Create9`, `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` | `AutoIncrement`, `Engine`, `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/SaisieInvT.class` | `Exec` |
| `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` | `Engine`, `Exec` |
| `.src/Gestion/Stock/Listecom.class` | `Exec` |
| `.src/Gestion/Stock/MvtProdcomp.class` | `Exec` |
| `.src/Gestion/Stock/Mvtex.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/Stock/Tarifs/Impart.class` | `Exec` |
| `.src/Gestion/Stock/Tarifs/ImpartParam.class` | `Exec` |
| `.src/Gestion/Stock/Tarifs/MajEqu.module` | `Exec` |
| `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` | `Exec` |
| `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` | `Exec` |
| `.src/Gestion/Stock/Tarifs/MajTarifM.class` | `Exec` |
| `.src/Gestion/Stock/Tarifs/MajTarifP.class` | `Exec` |
| `.src/Gestion/Stock/ValidBR.class` | `Create9`, `Edit`, `Engine`, `Exec` |
| `.src/Gestion/Stock/ValidBR1.class` | `Edit`, `Exec` |
| `.src/Gestion/Stock/VarMajTar.class` | `Exec`, `Execute`, `Set` |
| `.src/Gestion/Stock/commande1.class` | `Exec`, `LockIncrement`, `Prepare` |
| `.src/Gestion/Stockmvt.class` | `Exec` |
| `.src/Gestion/Suivi.class` | `Exec` |
| `.src/Gestion/SupprArt.class` | `Engine`, `Exec` |
| `.src/Gestion/Tables/ArtPromo.module` | `Exec` |
| `.src/Gestion/Tables/Articles.class` | `Exec` |
| `.src/Gestion/Tables/Btqart.class` | `Engine`, `Exec` |
| `.src/Gestion/Tables/Centrales.class` | `Exec` |
| `.src/Gestion/Tables/CoefTypeC.class` | `Exec` |
| `.src/Gestion/Tables/ComMail.class` | `Exec` |
| `.src/Gestion/Tables/Comment.class` | `Exec` |
| `.src/Gestion/Tables/Commerciaux.class` | `Exec` |
| `.src/Gestion/Tables/ConsultArt.class` | `Exec` |
| `.src/Gestion/Tables/Cpostaux.class` | `Exec` |
| `.src/Gestion/Tables/FClient.class` | `AutoIncrement`, `Create9`, `Edit`, `Engine`, `Exec` |
| `.src/Gestion/Tables/FFournisseur.class` | `Exec` |
| `.src/Gestion/Tables/Famille.class` | `Exec` |
| `.src/Gestion/Tables/Fpromo.class` | `Exec` |
| `.src/Gestion/Tables/FpromoArt.class` | `Exec` |
| `.src/Gestion/Tables/Identite.class` | `Exec` |
| `.src/Gestion/Tables/LibelFac.class` | `Exec` |
| `.src/Gestion/Tables/Marques.class` | `Exec` |
| `.src/Gestion/Tables/Materiel.class` | `Exec` |
| `.src/Gestion/Tables/Movr.class` | `Exec` |
| `.src/Gestion/Tables/Mreglement.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/Tables/Prodcomposes.class` | `Exec` |
| `.src/Gestion/Tables/Remisec.class` | `Exec` |
| `.src/Gestion/Tables/Remisecli.class` | `Exec` |
| `.src/Gestion/Tables/Statut.class` | `Exec` |
| `.src/Gestion/Tables/TarTypeCli.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/Tables/Tleg.class` | `Exec` |
| `.src/Gestion/Tables/Tmail.class` | `Exec` |
| `.src/Gestion/Tables/Txmo.class` | `Exec` |
| `.src/Gestion/Tables/Typec.class` | `Exec` |
| `.src/Gestion/option/Caleditcmat.class` | `Create9`, `Exec` |
| `.src/Gestion/option/Consigne.class` | `Exec` |
| `.src/Gestion/option/Ecomptamat.class` | `Exec` |
| `.src/Gestion/option/Edconsigne.class` | `Exec` |
| `.src/Gestion/option/EditStkDepart.class` | `Exec` |
| `.src/Gestion/option/Edittipp.class` | `Exec` |
| `.src/Gestion/option/Einvmat.class` | `Exec` |
| `.src/Gestion/option/ObjFacB.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/Saisiedecons.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/Tconsigne.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/Tregie.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/Tregion.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/Ttarfioul.class` | `Create9`, `Exec` |
| `.src/Gestion/option/Ttourne.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/Visucmat.class` | `Exec` |
| `.src/Gestion/option/artopt.class` | `Edit`, `Exec` |
| `.src/Gestion/option/atribvignette.class` | `Exec` |
| `.src/Gestion/option/calculdroit.class` | `Exec` |
| `.src/Gestion/option/calculdroit1.class` | `Exec` |
| `.src/Gestion/option/facopt.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/fourconsdroi.class` | `Create9`, `Edit`, `Exec` |
| `.src/Gestion/option/modfichier.module` | `AutoIncrement`, `Edit`, `Engine`, `Exec` |
| `.src/Gestion/option/rechcons.class` | `Exec` |
| `.src/Gestion/option/rechtipp.class` | `Exec` |
| `.src/Gestion/option/rechtour.class` | `Exec` |
| `.src/Gestion/option/ticpe.class` | `Exec` |
| `.src/Reports/Editfac.class` | `Exec` |
| `.src/Serveur.module` | `Exec` |
| `.src/Statistiques/Histocliart.class` | `Exec` |
| `.src/Statistiques/Histovmo.class` | `Exec` |
| `.src/Statistiques/HitCarte.class` | `Engine`, `Exec` |
| `.src/Statistiques/RelMoprod.class` | `Engine`, `Exec` |
| `.src/Statistiques/RelvMo.class` | `Engine`, `Exec` |
| `.src/Statistiques/StatClimo.class` | `Engine`, `Exec` |
| `.src/Statistiques/StatComArt.class` | `Engine`, `Exec` |
| `.src/Statistiques/StatComm.class` | `Engine`, `Exec` |
| `.src/Statistiques/StatFour.class` | `Engine`, `Exec` |
| `.src/Statistiques/StatPromo.class` | `Exec` |
| `.src/Statistiques/StatTypCli.class` | `Engine`, `Exec` |
| `.src/Statistiques/Statbase.class` | `Exec` |
| `.src/Statistiques/TBord.class` | `Engine`, `Exec` |
| `.src/Statistiques/VisHitCartes.class` | `Exec` |
| `.src/Statistiques/VisStatClimo.class` | `Exec` |
| `.src/Statistiques/VisStatComArt.class` | `Exec` |
| `.src/Statistiques/VisStatComm.class` | `Exec` |
| `.src/Statistiques/VisStatFour.class` | `Exec` |
| `.src/Statistiques/VisStatTypCli.class` | `Exec` |
| `.src/Tests/TriTest.class` | `Exec` |
| `.src/Utils/AffRdv.module` | `Exec` |
| `.src/Utils/Agenda.class` | `Exec` |
| `.src/Utils/CPrix.module` | `Exec` |
| `.src/Utils/CalcRem.class` | `Exec` |
| `.src/Utils/Calcsolde.class` | `Exec` |
| `.src/Utils/Calcstock.class` | `Exec` |
| `.src/Utils/Changefam.class` | `Engine`, `Exec` |
| `.src/Utils/Changefour.class` | `Engine`, `Exec` |
| `.src/Utils/CompArt.class` | `Exec` |
| `.src/Utils/Crupt.module` | `Engine`, `Exec` |
| `.src/Utils/Csolde.module` | `Exec` |
| `.src/Utils/Cstock.module` | `Exec` |
| `.src/Utils/DB_Log.class` | `<type>`, `Clear`, `Get_Filter`, `Get_Filter_Error`, `Get_Localfile_Path`, `Get_Log`, `Get_Remotefile_Path`, `Refresh`, `Set_Filter`, `Set_Log` |
| `.src/Utils/DB_Sanity.class` | `<type>`, `Exec`, `IsType`, `type_mysql`, `type_sqlite3` |
| `.src/Utils/Dcfour.class` | `Exec` |
| `.src/Utils/Enrgcp.module` | `Exec` |
| `.src/Utils/Epurfour.class` | `Exec` |
| `.src/Utils/Exports-Imports/Expart.class` | `Exec` |
| `.src/Utils/Exports-Imports/Expbase.class` | `<hérité>` |
| `.src/Utils/Exports-Imports/Expclient.class` | `Exec` |
| `.src/Utils/Exports-Imports/Expcontact.class` | `Exec` |
| `.src/Utils/Exports-Imports/Impclient.class` | `Exec` |
| `.src/Utils/Exports-Imports/Impcpostaux.class` | `Exec` |
| `.src/Utils/Exports-Imports/ImportStk.class` | `Exec` |
| `.src/Utils/Exports-Imports/ImptartypeC.class` | `Exec` |
| `.src/Utils/FSetFormat.class` | `Exec` |
| `.src/Utils/GedR.class` | `Exec` |
| `.src/Utils/HistoCom.class` | `Exec` |
| `.src/Utils/LDate.class` | `Exec` |
| `.src/Utils/LGed.class` | `Exec` |
| `.src/Utils/LLog.class` | `Log_Event` |
| `.src/Utils/Mmysql.module` | `<hérité>` |
| `.src/Utils/Papmp.class` | `Exec` |
| `.src/Utils/RazArt.class` | `Exec` |
| `.src/Utils/RecupN.class` | `Exec` |
| `.src/Utils/RenumBl.class` | `Exec` |
| `.src/Utils/ReplayObserver.class` | `GUI_Event` |
| `.src/Utils/Sha1Calc.module` | `Exec` |
| `.src/Utils/TarArt.class` | `Exec` |
| `.src/Utils/TextReg.class` | `Exec` |
| `.src/Utils/Trifam.class` | `Exec` |
| `.src/Utils/Utils.module` | `<type>`, `Backtrace`, `Exec` |
| `.src/Utils/VerifDate.class` | `Exec` |
| `.src/Utils/VerifNumfac.module` | `Exec` |
| `.src/Utils/VisPmp.class` | `Exec` |
| `.src/Utils/gridv.module` | `Exec` |
| `.src/Utils/gridvi.class` | `Exec` |
| `.src/Utils/gridvi2.class` | `Exec` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `LDate` | `<type>` |
| `NetHandler` | `<type>` |
| `Start` | `Arg_Log`, `Arg_LogFile`, `Arg_Replay`, `ConsoleLogLevel`, `LocalSettings`, `Societe` |
| `Utils` | `Find_cbarre`, `MouseDefault`, `MouseProcessing`, `Option`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Tvaav`, `Fiches_regie`

### Membres Public sans usage externe détecté (portée réductible ?)

`Start`, `Set_Level`, `Enable_Log`, `Disable_Log`, `Refresh_Filter`, `Is_Filtered`, `Print`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Usage réel** : la classe n'est instanciée qu'une fois, `Utils.module:9` (`Public db As New
  DB_Connection`). `DB_Log` (`_new(dbconnection)`) et `DB_Sanity` reçoivent `Utils.db` depuis
  `Fmenu.class:2487,2566` et `Cmenu.class:319`. Toute modification d'`Exec`/`Edit`/`Create9` touche
  environ 340 fichiers : le contrat (signature, `Null` si connexion fermée, `Error.Propagate`) doit
  rester strictement identique.
- **Appelants vérifiés par grep** (membres hors `Exec`/`Engine`/`AutoIncrement`/`Edit`/`Create9`) :
  - `Prepare` : `Gestion/Stock/commande1.class:83,84` ; `Set` : `Gestion/Stock/VarMajTar.class:77` ;
    `Execute` : `VarMajTar.class:79,82` (lot commun : `Prepare`/`Set`/`Execute` forment un seul contrat).
  - `Lockstock` : `Gestion/Entrées/Achat.class:818,902,907` ; `RecArt` : `Achat.class:185`.
  - `LockIncrement` : `Caisse/Caisse.class:455`, `Caisse/Moulinage.class:786`,
    `Compta/Utils/EcrAuto.class:272,279,351`, `Gestion/Stock/commande1.class:904,917`.
  - `CopieTable` : `Compta/Clotures/FClotureAn.class:357,364,371`.
  - `IsType`/`type_mysql` : `Communs/Fmenu.class:168,169,174`, `DB_Sanity.class:121,131,204`.
  - `Backtrace` : `Utils/Utils.module:127`.
  - `GUI_Event` : `Utils/ReplayObserver.class` (10 appels) ; `Log_Event` : `Utils/LLog.class:59`.
  - `Refresh`, `Clear`, `Get_*`, `Set_Log`, `Set_Filter` : `Utils/DB_Log.class` uniquement.
- **Portée réductible confirmée** : `Start`, `Set_Level`, `Refresh_Filter`, `Is_Filtered` (internes),
  `Enable_Log`, `Disable_Log`, `Print` (aucun appel). Aucun nom n'apparaît en chaîne littérale
  (pas d'appel dynamique externe).
- **Appels dynamiques internes** : `Object.Call(Me, "Subst", aArg)` (lignes 342, 467, 677) vers la
  méthode **native** `Connection.Subst` (gb.db) ; `Eval(…, $context)` dans `Execute` (ligne 513).
- **Tables** : l'heuristique détecte `Fiches_Art`, `Fiches_Tvaav`, `Fiches_regie` (en dur dans
  `Lockstock` et `RecArt`). `LockIncrement` et `CopieTable` reçoivent leur table en paramètre.
- **`LDate`** est déclaré (`Lockstock`, variable `DteInv`) mais inutilisé : fausse dépendance.
- **`NetHandler`** : instancié ligne 85 ; ses méthodes `Open`/`Write`/`Close` sont appelées par le
  framework gb.logging, et `GetOutput` via `logh["remote"]` (Collection non typée) : invisible pour
  `deps.py`.
- **Dépendances circulaires** : `DB_Connection` ↔ `Utils` (singleton + `Utils.MouseProcessing`),
  `DB_Connection` ↔ `LLog` (`Log_Event` ← `LLog.Log`), `DB_Connection` ↔ `DB_Log`/`DB_Sanity`
  (instance passée par constructeur), `DB_Connection` → `Start` (lecture des arguments) → `Utils`.
- **Contraintes d'ordre de rework** : DB_Connection doit être reworké **en premier** dans la couche
  base de données, et seulement après la mise en place des tests de caractérisation
  DB_CONNECTION-T01 à T06 (réécriture SQLite et format du log), car tout le harnais log/replay de
  la phase 2 dépend du format exact des lignes `Exec_SQL` et `GUI`. Lot commun avec `ReplayObserver`,
  `DB_Log` et `LLog` pour toute modification du format du log.
