#!/usr/bin/env python3
# Générateur déterministe du jeu Imp_Sig T04 (agent 3, vague 7) : 40 rubriques SIG supplémentaires de type « L »
# (S0121 à S0160 hors numéros existants, charges « A », détail « O ») rattachées chacune à un compte 6061xx, et une
# écriture 2018 sur 606100 (rubrique S0120). Usage : python3 gen_imp_sig_pagination.py > imp_sig_pagination.sql
existants={"S0130","S0135","S0140","S0150","S0160"}
rub=[]
n=121
while len(rub)<40:
    r="S%04d"%n
    if r not in existants: rub.append(r)
    n+=1
print("-- Jeu Imp_Sig T04 (agent 3, vague 7, généré par gen_imp_sig_pagination.py) : 40 rubriques L ajoutées.")
print("INSERT INTO Fiches_Rubriques (numrub,intitule,type,detail,num) VALUES")
print(",\n".join("('%s','Rubrique ajoutee %02d','L','O','A')"%(r,i+1) for i,r in enumerate(rub))+";")
print("INSERT INTO Fiches_RubCompt (numrub,compte1,compte2,amortissement) VALUES")
print(",\n".join("('%s','6061%02d','6061%02d99',0)"%(r,i+50,i+50) for i,r in enumerate(rub))+";")
print("INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
print("('60',1,1,'606100',0,'Fournitures','2018-03-15 00:00:00','A001','Achat A001',40.00,0.00,1,0,0,0,NULL,0,0);")
