#!/usr/bin/env python3
"""Génère les jeux de FCloture (FCLOTURE-T01 à T04, T06, T07 et la variante T01 « clé NULL ») dans les assets
de chaque scénario (appliqués après Laurux01.sql). Usage, depuis ce répertoire : python3 gen_fcloture.py

Clés « control » : calculées par Laurux lui-même (Sha1Calc.CalcSha1_all("Fiches_Mvt"), chaînage compris) dans le
clone de référence, sur les jeux bruts brut_<jeu>.sql (clés NULL) écrits par ce script, puis recopiées dans
cles.txt (« <jeu>/<lind><TAB><clé> »). Procédure pour les régénérer : module gb.test temporaire qui, pour chaque
jeu brut, fait TestKit.OuvreBase("fcloture_shared/brut_<jeu>"), Sha1Calc.CalcSha1_all("Fiches_Mvt") et
TestKit.Check("<jeu>/<lind>", control) ligne par ligne ; « runner gbtest <Module> --record --date "2018-06-15 10:00:00" » (date des scénarios : la clé dépend du
décalage horaire courant, été/hiver, car CStr(dte) est converti en UTC) ; recopier les lignes
de son expected.txt dans cles.txt ; supprimer le module. Une clé NULL n'est pas contrôlée par CalcSha1_Verify
(Sha1Calc.module:110) : seul le jeu cle_nulle la garde (variante de T01)."""
import os

COLS = "(jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,cloturee,lind,control)"
ALTEREE = "CLEALTEREE00000000000000000000000000000"

def ecr(lind, num, ndef, dte, doc, mt, prov=0, clot=0):
    nd = "NULL" if ndef is None else str(ndef)
    val = 0 if prov else 1
    return [(lind, f"('70',{num},{nd},'411001',0,'Client','{dte} 00:00:00','{doc}','Ecriture {num}',{mt:.2f},0.00,{val},{prov},{clot},{lind},"),
            (lind + 1, f"('70',{num},{nd},'707000',0,'Ventes','{dte} 00:00:00','{doc}','Ecriture {num}',0.00,{mt:.2f},{val},{prov},{clot},{lind+1},")]

def base(t02=False):
    l = []
    l += ecr(1, 9, 6, "2018-05-20", "F009", 10, clot=1)             # mai : déjà clôturée
    l += ecr(3, 10, None, "2018-06-03", "F010", 20)                # juin : sans numerodef
    l += ecr(5, 11, 4, "2018-06-10", "F011", 30)                   # juin : numerodef déjà posé
    l += ecr(7, 12, None, "2018-06-25", "F012", 40, prov=1 if t02 else 0)  # juin
    l += ecr(9, 13, None, "2018-07-02", "F013", 50)                # juillet : hors période
    return l

DECEMBRE = ecr(1, 20, None, "2018-12-05", "F020", 15) + ecr(3, 21, None, "2018-12-31", "F021", 25) + ecr(5, 22, None, "2019-01-02", "F022", 35)
HORS_EXERCICE = ecr(1, 30, None, "2019-01-10", "F030", 60)

def cles():
    c = {}
    if os.path.exists("cles.txt"):
        for l in open("cles.txt"):
            k, v = l.rstrip("\n").split("\t")
            c[k] = v
    return c

def insert(lignes, jeu_cles, alteree=()):
    c = cles()
    out = []
    for lind, deb in lignes:
        if lind in alteree:
            ctl = f"'{ALTEREE}'"
        elif jeu_cles:
            ctl = f"'{c[f'{jeu_cles}/{lind}']}'"
        else:
            ctl = "NULL"
        out.append(deb + ctl + ")")
    return f"INSERT INTO Fiches_Mvt {COLS} VALUES\n" + ",\n".join(out) + ";\n"

def ecrit(chemin, entete, dtepc, lignes, jeu_cles=None, alteree=()):
    os.makedirs(os.path.dirname(chemin) or ".", exist_ok=True)
    with open(chemin, "w") as f:
        f.write(f"-- FCloture ({entete}) : généré par Compta/assets/fcloture_shared/gen_fcloture.py.\n")
        f.write(f"UPDATE Fiches_Parametres SET dtepc = '{dtepc}', numecriture2 = 6;\n")
        f.write(insert(lignes, jeu_cles, alteree))

def jeu(nom, entete, dtepc, lignes, jeu_cles, alteree=()):
    ecrit(f"../fcloture_{nom}/fcloture_{nom}.sql", entete, dtepc, lignes, jeu_cles, alteree)

# Jeux bruts (clés NULL) pour le calcul des clés par Laurux
ecrit("brut_base.sql", "jeu brut, clés NULL", "2018-05-31", base())
ecrit("brut_decembre.sql", "jeu brut, clés NULL", "2018-11-30", DECEMBRE)
ecrit("brut_hors_exercice.sql", "jeu brut, clés NULL", "2018-12-31", HORS_EXERCICE)

if cles():
    jeu("cloture_mois", "T01 : clôture de juin 2018, clés valides ; 10 et 12 sans numerodef, 11 avec numerodef 4", "2018-05-31", base(), "base")
    jeu("cle_nulle", "T01 variante : mêmes écritures, clés control NULL (non contrôlées)", "2018-05-31", base(), None)
    jeu("provisoires", "T02 : écriture 12 provisoire en juin 2018, clés valides", "2018-05-31", base(t02=True), "base")
    jeu("sha1_invalide", "T03 : clé de l'écriture 11 (lind 5) altérée, clés précédentes valides", "2018-05-31", base(), "base", alteree=(5,))
    jeu("decembre", "T04 : dtepc 30/11/2018, écritures 20 et 21 en décembre 2018, clés valides", "2018-11-30", DECEMBRE, "decembre")
    jeu("mois_vide", "T06 : mars 2018 sans écriture (dtepc 28/02/2018), clés valides", "2018-02-28", base(), "base")
    jeu("hors_exercice", "T07 : dtepc = dteclec = 31/12/2018, écriture 30 en janvier 2019, clé valide", "2018-12-31", HORS_EXERCICE, "hors_exercice")
