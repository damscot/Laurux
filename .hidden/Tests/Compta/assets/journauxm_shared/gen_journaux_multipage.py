#!/usr/bin/env python3
# Générateur déterministe du jeu partagé JournauxM T06 / Jourcent T06 (agent 3, vague 7) : 60 comptes de produits
# 706001 à 706060 créés ; journal 70 (VE) de 60 pièces en 2018 (411001 au débit, 7060nn au crédit) : 120 lignes,
# 61 comptes centralisés. Usage : python3 gen_journaux_multipage.py > journaux_multipage.sql
print("-- Jeu JournauxM T06 / Jourcent T06 (agent 3, vague 7, généré par gen_journaux_multipage.py) : 120 lignes, 61 comptes.")
print("INSERT INTO Fiches_Comptes (compte_cc,intitule_cc,type_cc,coll,cent_cc,comptr_cc,code_tvente,taux_tvente,gen_tv,code_tachat,taux_tachat,gen_ta,solde,soldep,cprincipal) VALUES")
print(",\n".join("(%d,'Produits %02d','G',0,0,0,'','',0,'','',0,0,0,0)"%(706000+k,k) for k in range(1,61))+";")
print("INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
rows=[]
for n in range(1,61):
    d="2018-%02d-%02d 00:00:00"%(1+(n-1)//12,1+(n-1)%12*2)
    mt=5.0*n
    rows.append("('70',%d,%d,'411001',0,'A Divers','%s','F%03d','Facture F%03d',%.2f,0.00,1,0,0,0,NULL,0,0)"%(n,n,d,n,n,mt))
    rows.append("('70',%d,%d,'%d',0,'Produits %02d','%s','F%03d','Facture F%03d',0.00,%.2f,1,0,0,0,NULL,0,0)"%(n,n,706000+n,n,d,n,n,mt))
print(",\n".join(rows)+";")
