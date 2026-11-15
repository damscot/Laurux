#!/usr/bin/env python3
# Générateur déterministe du jeu EcrM T05 (agent 3, vague 7) : 40 pièces supprimées (80 lignes Fiches_MvtM, 411001 non collectif : les lignes collectives ne sont pas imprimées)
# en 2018, pour dépasser 60 lignes et provoquer un saut de page. Usage : python3 gen_ecrm_multipage.py > ecrm_multipage.sql
cols="(jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,lind2,datem,supprimee)"
print("-- Jeu EcrM T05 (agent 3, vague 7, généré par gen_ecrm_multipage.py) : 40 pièces supprimées, 80 lignes Fiches_MvtM.")
print("INSERT INTO Fiches_MvtM %s VALUES" % cols)
rows=[]
for n in range(1,41):
    m=1+(n-1)//8; j=1+(n-1)%8*3
    d="2018-%02d-%02d 00:00:00"%(m,j); dm="2018-%02d-%02d 10:00:00"%(m,j+1)
    mt=10.0*n
    rows.append("('70',%d,%d,'411001',0,'A Divers','%s','F%03d','Fac F%03d',%.2f,0.00,1,0,0,0,NULL,0,0,1,'%s',1)"%(n,n,d,n,n,mt,dm))
    rows.append("('70',%d,%d,'707000',0,'Ventes','%s','F%03d','Fac F%03d',0.00,%.2f,1,0,0,0,NULL,0,0,2,'%s',1)"%(n,n,d,n,n,mt,dm))
print(",\n".join(rows)+";")
