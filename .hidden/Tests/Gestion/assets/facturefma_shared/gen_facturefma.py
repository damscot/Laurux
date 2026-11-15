import json, os
A="/home/damscot/.cache/laurux-sandbox/sb8/rework/.hidden/Tests/Gestion/assets/"
SH=A+"facturefma_shared/"
def dataset(name, head, dtepec, clients):
    # clients: (code, nom, aban, datab, [(numbl, dtefac or None, ht)])
    L=["-- "+h for h in head]
    L.append("UPDATE Fiches_Parametres SET dtepec = '%s';"%dtepec)
    L.append("CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;")
    for c,n,ab,d,_ in clients:
        L.append("UPDATE tmp_cli SET cli_code = %s, cli_nom = '%s', cli_div = 0, cli_aban = '%s', cli_datab = '%s';"%(c,n,ab,d))
        L.append("INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;")
    L.append("DROP TEMPORARY TABLE tmp_cli;")
    bl=[];lg=[]
    for c,n,ab,d,bls in clients:
        for num,dte,ht in bls:
            df="NULL" if dte is None else "'%s 00:00:00'"%dte
            bl.append("('%s', 'A', '%s', '%s', '75000', 'PARIS', '2017-01-10 00:00:00', %d, %d, 0, %s)"%(num,c,n,ht,ht*1.2,df))
            lg.append("('%s', '1', 'ABO', 'Abonnement', '%d', '1', '%d', '1', 'A')"%(num,ht,ht))
    L.append("INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, totalht, totalttc, imp, dtefac) VALUES\n"+",\n".join(bl)+";")
    L.append("INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, netht_ligbl, tx_ligbl, typel_ligbl) VALUES\n"+",\n".join(lg)+";")
    open(SH+name+".sql","w").write("\n".join(L)+"\n")
# T02 : periodicites
dates=["2017-07-05","2017-10-05","2017-11-05","2017-12-05"]
cl=[]; k=0
for p,ab in ((2,"2- Bimensuel"),(3,"3- Trimestriel"),(4,"4- Semestriel")):
    for i,d in enumerate(dates):
        k+=1; code="4119%d%d"%(p+0,i+1)
        cl.append((code,"PER %d%d"%(p,i+1),ab,"10",[("A%05d"%(200+k),d,10*k)]))
for mois,dp in (("01","01.2018"),("02","02.2018"),("07","07.2018")):
    dataset("periodicites_"+mois,["FacturefmA-T02 : BL d'abonnement (type A), clients bimensuels (41192x), trimestriels (41193x),",
        "semestriels (41194x), jour d'abonnement 10, facturés le 05.07.2017, 05.10.2017, 05.11.2017, 05.12.2017 ;",
        "période en cours %s (date du scénario dans ce mois)."%dp], dp, cl)
# T03 : annuel
dataset("annuel",["FacturefmA-T03 : clients annuels, période 06.2018 (scénario au 15.06.2018) : 411951 facturé le 15.06.2017",
    "(un an jour pour jour, jour d'abonnement 10), 411952 idem jour 20, 411953 facturé le 05.06.2016, 411954 le 05.05.2017,",
    "411955 le 05.07.2017."],"06.2018",[
    ("411951","ANN UN","5- Annuel","10",[("A00301","2017-06-15",10)]),
    ("411952","ANN DEUX","5- Annuel","20",[("A00302","2017-06-15",20)]),
    ("411953","ANN TROIS","5- Annuel","10",[("A00303","2016-06-05",30)]),
    ("411954","ANN QUATRE","5- Annuel","10",[("A00304","2017-05-05",40)]),
    ("411955","ANN CINQ","5- Annuel","10",[("A00305","2017-07-05",50)])])
# T05 : retraits
dataset("retraits",["FacturefmA-T05 : clients mensuels jamais facturés : 411961 (BL A00401 et A00402), 411962 (A00403),",
    "411963 (A00404) ; période 06.2018."],"06.2018",[
    ("411961","RET UN","1- Mensuel","10",[("A00401",None,10),("A00402",None,20)]),
    ("411962","RET DEUX","1- Mensuel","10",[("A00403",None,30)]),
    ("411963","RET TROIS","1- Mensuel","10",[("A00404",None,40)])])
P="%s %s;Info;GUI;laurux;test;test;1;"
def write(name, meta, evs, day):
    d=A+name; os.makedirs(d, exist_ok=True)
    t=4000; out=[]
    for ev in evs:
        s=t//1000; out.append(P%(day,"10:%02d:%02d.%03d"%(s//60,s%60,t%1000))+ev); t+=1000
    open(d+"/scenario.log","w").write("\n".join(out)+"\n")
    json.dump(meta, open(d+"/meta.json","w"), ensure_ascii=False, indent=1)
OPEN="Fmenu.Menu299_Click;Click=True@Menu299#Fmenu#Menu66#Menu192#Menu299#"
TRT="FacturefmA.Button1_Click;Click=True@Button1#FacturefmA#Button1#"
CAD={"frappe":50,"focus":100,"traitement":1000,"fenetre":1000}
def meta(id_,objet,desc,ds,date):
    return {"id":id_,"objet":objet,"classe":"FacturefmA","description":desc,"dataset":"facturefma_shared/"+ds,
            "date":date,"args":[],"societe":"01","timeout":20,"conf":{"/Soc01/Faca":0},"cadence":CAD}
for mois,nom in (("01","janvier"),("02","février"),("07","juillet")):
    write("facturefma_periodicites_"+("fevrier" if mois=="02" else nom),
      meta("FACTUREFMA-T02","Bimensuel, trimestriel, semestriel (%s)"%nom,
       "Jeu facturefma_shared/periodicites_%s (dtepec %s.2018), date du scénario 15.%s.2018 (Datej par défaut). Facturation périodique (Menu299, /Faca = 0), Traitement (Button1). Clients bimensuels, trimestriels, semestriels facturés les 05.07, 05.10, 05.11 et 05.12.2017 : sélection figée dans les tables de travail Facturefm/Bl (calcul du mois de référence en début d'année, A03)."%(mois,mois,mois),
       "periodicites_"+mois,"2018-%s-15 10:00:00"%mois),[OPEN,TRT,"FacturefmA.Form_Close;Close=0@FacturefmA#FacturefmA#"],"%s/15/2018"%mois)
write("facturefma_annuel",meta("FACTUREFMA-T03","Annuel",
  "Jeu facturefma_shared/annuel, date 15.06.2018. Facturation périodique (Menu299, /Faca = 0), Traitement. Clients annuels facturés le 15.06.2017 (jour d'abonnement 10 et 20), le 05.06.2016, le 05.05.2017 et le 05.07.2017 : sélection figée dans Facturefm/Bl (A02 : conversion de dtefac).","annuel","2018-06-15 10:00:00"),
  [OPEN,TRT,"FacturefmA.Form_Close;Close=0@FacturefmA#FacturefmA#"],"06/15/2018")
write("facturefma_retraits",meta("FACTUREFMA-T05","Retraits (client puis BL)",
  "Jeu facturefma_shared/retraits, date 15.06.2018. Traitement : 411961 (2 BL), 411962, 411963 retenus. Clic sur 411962 dans Colbl, Suppr : client retiré de Facturefm et Bl. Clic sur 411961, clic sur son BL retenu A00401 dans Coldetail (seul le 1er BL de chaque client est sélectionné), Suppr : BL retiré de Bl (Facturefm non modifiée ; colonne Ville de Colbl remplacée par le TTC à l'écran, A01, non comparée). Comparé : tables de travail Facturefm/Bl (dump).","retraits","2018-06-15 10:00:00"),
  [OPEN,TRT,"FacturefmA.Colbl_Click;Click=411962@Colbl#FacturefmA#Colbl#",
   "FacturefmA.Colbl_GotFocus;Focus=@Colbl#FacturefmA#Colbl#","FacturefmA.Colbl_KeyPress;Keypress=16777223@Colbl#FacturefmA#Colbl#",
   "FacturefmA.Colbl_Click;Click=411961@Colbl#FacturefmA#Colbl#","FacturefmA.Coldetail_Click;Click=A00401@Coldetail#FacturefmA#Coldetail#",
   "FacturefmA.Coldetail_GotFocus;Focus=@Coldetail#FacturefmA#Coldetail#","FacturefmA.Coldetail_KeyPress;Keypress=16777223@Coldetail#FacturefmA#Coldetail#",
   "FacturefmA.Form_Close;Close=0@FacturefmA#FacturefmA#"],"06/15/2018")
