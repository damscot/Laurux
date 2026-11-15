#!/usr/bin/env python3
# Générateur déterministe du jeu FTVA T06 (agent 3, vague 7) : trimestre 1 2018, 70 lignes de TVA collectée (445730,
# crédit 1,00 à 70,00) et 10 lignes de TVA déductible (445660, débit 2,00 à 20,00).
# Usage : python3 gen_ftva_multipage.py > ftva_multipage.sql
print("-- Jeu FTVA T06 (agent 3, vague 7, généré par gen_ftva_multipage.py) : 70 lignes 445730 et 10 lignes 445660 au 1er trimestre 2018.")
print("INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
rows=[]
for n in range(1,71):
    d="2018-%02d-%02d 00:00:00"%(1+(n-1)//24,1+(n-1)%24)
    rows.append("('70',%d,%d,'445730',0,'Tva','%s','F%03d','Facture F%03d',0.00,%.2f,1,0,0,0,NULL,0,0)"%(n,n,d,n,n,1.0*n))
for k in range(1,11):
    n=100+k; d="2018-%02d-%02d 00:00:00"%(1+(k-1)//4,3+(k-1)%4*5)
    rows.append("('60',%d,%d,'445660',0,'Tva deductible','%s','A%03d','Achat A%03d',%.2f,0.00,1,0,0,0,NULL,0,0)"%(n,n,d,k,k,2.0*k))
print(",\n".join(rows)+";")
