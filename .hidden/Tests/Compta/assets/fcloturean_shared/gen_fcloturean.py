#!/usr/bin/env python3
"""Génère les jeux de FClotureAn (clôture annuelle 2018 de Laurux01) dans ce répertoire (appliqués après
Laurux01.sql). Usage, depuis ce répertoire : python3 gen_fcloturean.py

Modèle : Compta/assets/fcloture_shared/gen_fcloture.py. Clés « control » de Fiches_Mvt calculées par Laurux
(Sha1Calc.CalcSha1_all("Fiches_Mvt"), chaînage compris) dans le clone de référence sur le jeu brut
brut_cloturean.sql (clés NULL, sur-ensemble de tous les jeux : l'écriture 10 de « desequilibre » a le plus grand
numéro, les clés des écritures 1 à 9 ne dépendent donc pas d'elle), puis recopiées dans cles.txt
(« <lind><TAB><clé> »). Procédure : module gb.test temporaire (TestKit.OuvreBase("fcloturean_shared/brut_cloturean"),
Sha1Calc.CalcSha1_all("Fiches_Mvt"), TestKit.Check("<lind>", control) ligne par ligne), « runner gbtest <Module>
--record --date "2018-06-15 10:00:00" » (date des scénarios : la clé dépend du décalage horaire courant,
SHA1CALC-A01), recopie des lignes de son expected.txt dans cles.txt, suppression du module.
Les lignes de Fiches_MvtM ont des numéros (50, 51) supérieurs à ceux de Fiches_Mvt : sans effet sur les clés.

Exercice 2018 (dteclec1 31/12/2017, dteclec 31/12/2018), écritures validées équilibrées sur les comptes B et G :
 1 capital (512000/101000), 2 achat (607000/512000), 3 vente (512000/707000), 4 client/fournisseur
 (411001 C / 401001 F), 5 collectifs (411000/401000, coll = 1) ;
exercice 2019 (postérieures) : 6 vente client (411001 clôturée / 707000), 7 fournisseur (401001/512000),
 8 achat provisoire non validé (607000/512000, A06), 9 compte absent 999999 (A05) / 512000 ;
desequilibre : 10 écriture validée 2018 sur 606100 (G) seule, débit 15.
"""
import os

COLS = "(jour,numero,numerodef,compte,collectif,intitule,dte,numcol,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee,lind,control)"

def l(num, compte, coll, intit, dte, doc, d, c, val=1, prov=0, clot=1, ndef=None):
    return dict(num=num, compte=compte, coll=coll, intit=intit, dte=dte, doc=doc, d=d, c=c, val=val, prov=prov,
                clot=clot, ndef=num if ndef is None else ndef)

ECR = [
    l(1, "512000", 0, "Banque", "2018-01-05", "C001", 1000, 0), l(1, "101000", 0, "Capital", "2018-01-05", "C001", 0, 1000),
    l(2, "607000", 0, "Achat", "2018-03-10", "A002", 300, 0), l(2, "512000", 0, "Banque", "2018-03-10", "A002", 0, 300),
    l(3, "512000", 0, "Banque", "2018-06-20", "V003", 800, 0), l(3, "707000", 0, "Ventes", "2018-06-20", "V003", 0, 800),
    l(4, "411001", 0, "A Divers", "2018-09-15", "F004", 120, 0), l(4, "401001", 0, "A Divers", "2018-09-15", "F004", 0, 120),
    l(5, "411000", 1, "Collectif client", "2018-09-15", "F005", 120, 0), l(5, "401000", 1, "Collectif fournisseur", "2018-09-15", "F005", 0, 120),
    l(6, "411001", 0, "A Divers", "2019-01-10", "V006", 50, 0, clot=1), l(6, "707000", 0, "Ventes", "2019-01-10", "V006", 0, 50, clot=0),
    l(7, "512000", 0, "Banque", "2019-01-12", "A007", 30, 0, clot=0), l(7, "401001", 0, "A Divers", "2019-01-12", "A007", 0, 30, clot=0),
    l(8, "607000", 0, "Achat", "2019-01-20", "A008", 20, 0, val=0, prov=1, clot=0, ndef=0), l(8, "512000", 0, "Banque", "2019-01-20", "A008", 0, 20, val=0, prov=1, clot=0, ndef=0),
    l(9, "999999", 0, "Compte absent", "2019-02-01", "D009", 10, 0, clot=0), l(9, "512000", 0, "Banque", "2019-02-01", "D009", 0, 10, clot=0),
]
DESEQ = [l(10, "606100", 0, "Fournitures", "2018-11-30", "D010", 15, 0)]

MVTA = ("INSERT INTO Fiches_MvtA (numero,compte,intitule,dte,numdoc,libelle,pourcent,montantd,montantc,jour,poste,validee) VALUES\n"
        "(2,'607000','Achat','2018-03-10 00:00:00','A002','Analytique 2018',100,300.00,0.00,'60','P1',1),\n"
        "(6,'707000','Ventes','2019-01-10 00:00:00','V006','Analytique 2019',100,0.00,50.00,'70','P2',1);\n")
MVTM = ("INSERT INTO Fiches_MvtM (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,lettree,cloturee,pointee,control,lind2,lind,datem,supprimee) VALUES\n"
        "('70',50,50,'707000',0,'Ventes','2018-05-02 00:00:00','M050','','Modifiee 2018',0.00,40.00,1,0,0,0,1,0,'MODIF2018',1,1,'2018-05-03 00:00:00',0),\n"
        "('70',51,51,'707000',0,'Ventes','2019-01-15 00:00:00','M051','','Modifiee 2019',0.00,60.00,1,0,0,0,0,0,'MODIF2019',2,2,'2019-01-16 00:00:00',1);\n")

def cles():
    c = {}
    if os.path.exists("cles.txt"):
        for x in open("cles.txt"):
            k, v = x.rstrip("\n").split("\t")
            c[k] = v
    return c

def insert(lignes, avec_cles):
    c = cles()
    out = []
    for i, e in enumerate(lignes, 1):
        ctl = f"'{c[str(i)]}'" if avec_cles else "NULL"
        jour = "60" if e["compte"].startswith(("6", "40")) else "70"
        out.append(f"('{jour}',{e['num']},{e['ndef']},'{e['compte']}',{e['coll']},'{e['intit']}','{e['dte']} 00:00:00','0',"
                   f"'{e['doc']}','','Ecriture {e['num']}',{e['d']:.2f},{e['c']:.2f},{e['val']},{e['prov']},0,0,0,{e['clot']},{i},{ctl})")
    return f"INSERT INTO Fiches_Mvt {COLS} VALUES\n" + ",\n".join(out) + ";\n"

def ecrit(nom, entete, dtepc, lignes, avec_cles):
    with open(nom, "w") as f:
        f.write(f"-- FClotureAn ({entete}) : généré par Compta/assets/fcloturean_shared/gen_fcloturean.py.\n")
        f.write(f"UPDATE Fiches_Parametres SET dtepc = '{dtepc}', numecriture = 9, numecriture2 = 9;\n")
        f.write(insert(lignes, avec_cles))
        f.write(MVTA)
        f.write(MVTM)

ecrit("brut_cloturean.sql", "jeu brut, clés NULL", "2018-12-31", ECR + DESEQ, False)
if cles():
    ecrit("cloturean_base.sql", "exercice 2018 complet, périodes clôturées, balance équilibrée, écritures 2019", "2018-12-31", ECR, True)
    ecrit("cloturean_desequilibre.sql", "jeu de base + écriture 10 déséquilibrée sur 606100", "2018-12-31", ECR + DESEQ, True)
    ecrit("cloturean_ouvertes.sql", "jeu de base, dernière clôture de période au 30/11/2018", "2018-11-30", ECR, True)
