#!/usr/bin/env python3
"""Jeu IMP_BILAN-T10 (performance) : ~1 000 lignes d'écritures 2018 (Fiches_Mvt) et 200 lignes 2017 (Fiches_Mvt1)
sur les comptes de bilan de Laurux01 (clients 411001-411027, fournisseurs 401001-401026, banques, immobilisations,
TVA) et quelques comptes de gestion. Déterministe (aucun aléa), une écriture non validée sur 97.
Usage, depuis la racine du dépôt (puis régénérer les attendus dans le clone de référence) :
  python3 .hidden/Tests/Compta/assets/imp_bilan_performance/gen_imp_bilan_perf.py > .hidden/Tests/Compta/assets/imp_bilan_performance/imp_bilan_perf.sql"""
clients = [411001 + i for i in range(27)]
fours = [401001 + i for i in range(26)]
banques = [512000, 512001, 530000]
immos = [211000, 213000, 218200, 218300, 218400]
tva = [445660, 445710]
print("-- IMP_BILAN-T10 : jeu de performance généré par .hidden/Tests/Compta/assets/imp_bilan_performance/gen_imp_bilan_perf.py")
print("-- 500 écritures 2018 (1 000 lignes, Fiches_Mvt), 100 écritures 2017 (200 lignes, Fiches_Mvt1), comptes de Laurux01.")

def ligne(jour, num, valide, cpt, dte, doc, lib, d, c, clot):
    numdef = num if valide else 0
    return f"('{jour}',{num},{numdef},'{cpt}',0,'Perf {cpt}','{dte}','{doc}','{lib}',{d},{c},{valide},0,0,0,NULL,0,{clot})"

def ecritures(table, annee, nb, debut):
    lignes = []
    clot = 1 if annee < 2018 else 0
    for n in range(nb):
        num = debut + n
        mois = 1 + n % (6 if annee == 2018 else 12)
        jour = 1 + (n * 7) % 28
        dte = f"{annee}-{mois:02d}-{jour:02d} 00:00:00"
        m = f"{10 + (n * 37) % 990}.{(n * 13) % 100:02d}"
        z = "0.00"
        v = 0 if n % 97 == 5 else 1
        cl = clients[n % len(clients)]
        fo = fours[n % len(fours)]
        ba = banques[n % len(banques)]
        k = n % 6
        if k == 0:    # vente : client au débit, produit au crédit
            e = [('70', cl, m, z), ('70', 707000, z, m)]
        elif k == 1:  # achat : charge au débit, fournisseur au crédit
            e = [('60', 606100, m, z), ('60', fo, z, m)]
        elif k == 2:  # encaissement client
            e = [('51', ba, m, z), ('51', cl, z, m)]
        elif k == 3:  # règlement fournisseur
            e = [('51', fo, m, z), ('51', ba, z, m)]
        elif k == 4:  # immobilisation payée en banque
            e = [('80', immos[n % len(immos)], m, z), ('80', ba, z, m)]
        else:         # TVA
            e = [('80', tva[n % len(tva)], m, z), ('80', fo, z, m)]
        for (j, cpt, d, c) in e:
            lignes.append(ligne(j, num, v, cpt, dte, f"P{num}", f"Perf {num}", d, c, clot))
    print(f"INSERT INTO {table} (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
    print(",\n".join(lignes) + ";")

ecritures("Fiches_Mvt", 2018, 500, 1)
ecritures("Fiches_Mvt1", 2017, 100, 1001)
