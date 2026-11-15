#!/usr/bin/env python3
# Générateur déterministe du jeu EdNlettrees T09 (agent 3, vague 7) : 411001 lettrable, 70 écritures non lettrées 2018
# (10,00 à 700,00) pour dépasser 60 lignes. Usage : python3 gen_ednl_multipage.py > ednl_multipage.sql
print("-- Jeu EdNlettrees T09 (agent 3, vague 7, généré par gen_ednl_multipage.py) : 411001 lettrable, 70 lignes non lettrées.")
print("UPDATE Fiches_Comptes SET lettrable = 1 WHERE compte_cc = 411001;")
print("INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
rows=[]
for n in range(1,71):
    d="2018-%02d-%02d 00:00:00"%(1+(n-1)//14,1+(n-1)%14*2)
    rows.append("('70',%d,%d,'411001',0,'A Divers','%s','F%03d','Facture F%03d',%.2f,0.00,1,0,0,0,NULL,0,0)"%(n,n,d,n,n,10.0*n))
print(",\n".join(rows)+";")
