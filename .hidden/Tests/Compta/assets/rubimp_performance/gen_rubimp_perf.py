#!/usr/bin/env python3
"""Jeu RUBIMP-T10 (performance) : ~1 000 lignes d'écritures 2018 (Fiches_Mvt) et 200 lignes 2017 (Fiches_Mvt1)
sur 90 comptes de gestion ajoutés (60 charges, 30 produits). Déterministe (aucun aléa).
Usage, depuis la racine du dépôt (puis régénérer les attendus dans le clone de référence) :
  python3 .hidden/Tests/Compta/assets/rubimp_performance/gen_rubimp_perf.py > .hidden/Tests/Compta/assets/rubimp_performance/rubimp_perf.sql"""
charges = [601001 + i for i in range(20)] + [606101 + i for i in range(20)] + [613101 + i for i in range(20)]
produits = [706001 + i for i in range(15)] + [707101 + i for i in range(15)]
print("-- RUBIMP-T10 : jeu de performance généré par .hidden/Tests/Compta/assets/rubimp_performance/gen_rubimp_perf.py")
print("-- 90 comptes de gestion, 500 écritures 2018 (1 000 lignes, Fiches_Mvt), 100 écritures 2017 (200 lignes, Fiches_Mvt1).")
print("INSERT IGNORE INTO Fiches_Comptes (compte_cc,intitule_cc,type_cc,coll,coll_cc,cent_cc,comptr_cc,code_tvente,taux_tvente,gen_tv,code_tachat,taux_tachat,gen_ta,solde,soldep,cprincipal,lettrable) VALUES")
cpts = [f"({c},'Charge perf {c}','G',0,NULL,0,0,'','',0,'','',0,0,0,0,NULL)" for c in charges] + \
       [f"({c},'Produit perf {c}','G',0,NULL,0,0,'','',0,'','',0,0,0,0,NULL)" for c in produits]
print(",\n".join(cpts) + ";")

def ecritures(table, annee, nb, debut):
    lignes = []
    for n in range(nb):
        num = debut + n
        mois = 1 + n % (6 if annee == 2018 else 12)
        jour = 1 + (n * 7) % 28
        dte = f"{annee}-{mois:02d}-{jour:02d} 00:00:00"
        montant = f"{10 + (n * 37) % 990}.{(n * 13) % 100:02d}"
        if n % 3 == 0:   # vente : 411001 au débit, produit au crédit
            cpt = produits[n % len(produits)]
            lignes.append(f"('70',{num},{num},'411001',0,'A Divers','{dte}','FP{num}','Vente perf {num}',{montant},0.00,1,0,0,0,NULL,0,0)")
            lignes.append(f"('70',{num},{num},'{cpt}',0,'Produit perf {cpt}','{dte}','FP{num}','Vente perf {num}',0.00,{montant},1,0,0,0,NULL,0,0)")
        else:            # achat : charge au débit, 401001 au crédit
            cpt = charges[n % len(charges)]
            lignes.append(f"('60',{num},{num},'{cpt}',0,'Charge perf {cpt}','{dte}','AP{num}','Achat perf {num}',{montant},0.00,1,0,0,0,NULL,0,0)")
            lignes.append(f"('60',{num},{num},'401001',0,'A Divers','{dte}','AP{num}','Achat perf {num}',0.00,{montant},1,0,0,0,NULL,0,0)")
    print(f"INSERT INTO {table} (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES")
    print(",\n".join(lignes) + ";")

ecritures("Fiches_Mvt", 2018, 500, 1)
ecritures("Fiches_Mvt1", 2017, 100, 1001)
