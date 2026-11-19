#!/usr/bin/env python3
"""Génère stockmvt_shared/stock_performance.sql (STOCKMVT-T11) : jeu stock_base + 1 000 lignes de vente
(500 lignes de BL en cours sur 100 BL, 500 lignes de factures archivées sur 100 factures), déterministe.
Usage : python3 gen_stockmvt_perf.py > stock_performance.sql (depuis ce répertoire)."""
import os
ici = os.path.dirname(os.path.abspath(__file__))
print("-- Stockmvt T11 (performance) : stock_base.sql + 1 000 lignes de vente générées par gen_stockmvt_perf.py.")
print(open(os.path.join(ici, "stock_base.sql"), encoding="utf-8").read())
arts = [("001", "Produit 2.10", "01"), ("002", "Produit 7.00", "02"), ("003", "produit 20.00", "03")]
bl, lbl, fa, lfa = [], [], [], []
for d in range(100):
    mois, jour = d % 12 + 1, d % 28 + 1
    date = "2018-%02d-%02d 00:00:00" % (mois, jour)
    nb, nf = "P%05d" % d, "Q%07d" % d
    bl.append("('%s', '411003', '%s', 'B', 10)" % (nb, date))
    fa.append("('%s', '411004', '%s')" % (nf, date))
    for l in range(5):
        c, lib, fam = arts[(d + l) % 3]
        q = (d * 7 + l) % 9 + 1
        lbl.append("('%s', '%d', '%s', '%s', '%d', '%d,00', 'A', '%s', '%s')" % (nb, l + 1, c, lib, q, q * 3, fam, date))
        lfa.append("('%s', '%d', '%s', '%s', '%d', '%d,00', 'A', '%s', '%s')" % (nf, l + 1, c, lib, q, q * 4, fam, date))
print("INSERT INTO Fiches_Bl (numbl, cdclibl, datebl, type, totalht) VALUES\n" + ",\n".join(bl) + ";")
print("INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, netht_ligbl, typel_ligbl, fam_ligbl, dte_ligbl) VALUES\n" + ",\n".join(lbl) + ";")
print("INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac) VALUES\n" + ",\n".join(fa) + ";")
print("INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac, fam_ligfac, dtligbl_ligfac) VALUES\n" + ",\n".join(lfa) + ";")
