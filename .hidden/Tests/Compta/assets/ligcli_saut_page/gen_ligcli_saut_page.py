#!/usr/bin/env python3
"""Générateur déterministe du jeu LIGCLI-T06 (ligcli_45_ecritures.sql) : copie de
Compta/feditrel_shared/feditrel_relances_prete + 45 factures échues de 411001 (Fiches_Mvt et Fiches_relances).
Usage : python3 gen_ligcli_saut_page.py <feditrel_relances_prete.sql> > ligcli_45_ecritures.sql"""
import sys
print("-- Jeu LIGCLI-T06 (agent 1, vague 8), produit par gen_ligcli_saut_page.py : copie de")
print("-- Compta/feditrel_shared/feditrel_relances_prete + 45 factures échues F5xx de 411001 (1,00 à 45,00) :")
print("-- 46 lignes dans Fiches_relances pour 411001 (lettre sur deux pages).")
sys.stdout.write(open(sys.argv[1], encoding="utf-8").read())
mvt, rel = [], []
for i in range(1, 46):
    lind = 500 + i
    d = f"2018-{1 + (i - 1) // 28:02d}-{1 + (i - 1) % 28:02d}"
    e = f"2018-{2 + (i - 1) // 28:02d}-{1 + (i - 1) % 28:02d}"
    mvt.append(f"({lind},'70',{100 + i},{100 + i},'411001',NULL,'A Divers','{d} 00:00:00','{e} 00:00:00','F{lind}',NULL,'Facture F{lind}',{i}.00,0.00,1,0,0,0,NULL,0,0,NULL)")
    rel.append(f"('411001', NULL, 'A Divers  ', NULL, NULL, NULL, NULL, 'France', '{d}', 'F{lind}', NULL, 'Facture F{lind}', {i}.00, 0.00, {100 + i}, '70', 1, {lind})")
print("INSERT INTO Fiches_Mvt (lind,jour,numero,numerodef,compte,collectif,intitule,dte,dateech,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,relance) VALUES")
print(",\n".join(mvt) + ";")
print("INSERT INTO Fiches_relances (compte, rs, intitule, adr1, adr2, cp, ville, pays, dte, numdoc, numlot, libelle, montantd, montantc, numero, journal, niveau, lind) VALUES")
print(",\n".join(rel) + ";")
