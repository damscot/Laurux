#!/usr/bin/env python3
# Générateur déterministe du jeu EdNjustifiees T07 (agent 3, vague 7) : 70 écritures non lettrées 2018 sur 411001
# (10,00 à 700,00, total 24 850,00) avec un solde mémorisé faux (1,00) : compte en écart de plus de 60 lignes.
# Usage : python3 gen_ednj_multipage.py > ednj_multipage.sql
print("-- Jeu EdNjustifiees T07 (agent 3, vague 7, généré par gen_ednj_multipage.py) : 411001, 70 lignes non lettrées, solde mémorisé 1,00.")
print("UPDATE Fiches_Comptes SET solde = 1 WHERE compte_cc = 411001;")
print("INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
rows=[]
for n in range(1,71):
    d="2018-%02d-%02d 00:00:00"%(1+(n-1)//14,1+(n-1)%14*2)
    rows.append("('70',%d,%d,'411001',0,'A Divers','%s','F%03d','Facture F%03d',%.2f,0.00,1,0,0,0,NULL,0,0)"%(n,n,d,n,n,10.0*n))
print(",\n".join(rows)+";")
