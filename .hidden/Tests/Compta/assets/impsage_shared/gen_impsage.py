#!/usr/bin/env python3
"""Fichiers Sage à positions fixes pour les scénarios IMPSAGE-Tnn (clients.pnc, ecritures.pnm).
Positions (architecture.md d'ImpSage) : clients.pnc code 1-13, nom 14-37, collectif 51-53, adresse 1 64-87,
adresse 2 88-111, CP 112-119, ville 120-145 ; ecritures.pnm journal 1-3, date 4-9 (JJMMAA), type de pièce 10-11,
compte général 12-19, type de compte 25 (X = tiers), compte tiers 26-33, n° de pièce 39-51, libellé 52-76,
sens 84, montant 85-104, n° de ligne 106-112. La 1re ligne de chaque fichier est ignorée par ImpSage.
Usage, depuis ce répertoire : python3 gen_impsage.py  (écrit les fichiers <jeu>_clients.pnc / <jeu>_ecritures.pnm)."""

def champ(lig, pos, val, long):
    val = str(val)[:long].ljust(long)
    lig = lig.ljust(pos - 1 + long)
    return lig[:pos - 1] + val + lig[pos - 1 + long:]

def tiers(code, nom, coll, adr1="", adr2="", cp="", ville=""):
    l = ""
    for (p, v, n) in ((1, code, 13), (14, nom, 24), (51, coll, 3), (64, adr1, 24), (88, adr2, 24), (112, cp, 8), (120, ville, 26)):
        l = champ(l, p, v, n)
    return l.rstrip()

def ecr(jnl, dte, cpt, typ, cpt_t, piece, lib, sens, mt, lot):
    l = ""
    for (p, v, n) in ((1, jnl, 3), (4, dte, 6), (10, "FC", 2), (12, cpt, 8), (25, typ, 1), (26, cpt_t, 8),
                      (39, piece, 13), (52, lib, 25), (84, sens, 1), (85, mt.rjust(20), 20), (106, str(lot).rjust(7), 7)):
        l = champ(l, p, v, n)
    return l.rstrip()

ENTETE = "#FLG 000"
JEUX = {}
# T01 : 2 clients et 1 fournisseur inconnus, 4 pièces VTE, ACH, BQ1, OD sur comptes existants
JEUX["nominal"] = (
    [tiers("C001", "Client Sage Un", "411", "1 rue Sage", "", "44000", "Nantes"),
     tiers("C002", "Client Sage Deux", "411", "2 rue Sage", "Bat B", "35000", "Rennes"),
     tiers("F001", "Fournisseur Sage", "401", "3 rue Sage", "", "75001", "Paris")],
    [ecr("VTE", "100318", "411000", "X", "C001", "1001", "Facture C001", "D", "120.00", 1),
     ecr("VTE", "100318", "707000", " ", "", "1001", "Facture C001", "C", "100.00", 2),
     ecr("VTE", "100318", "445710", " ", "", "1001", "Facture C001", "C", "20.00", 3),
     ecr("VTE", "110318", "411000", "X", "C002", "1002", "Facture C002", "D", "60.00", 4),
     ecr("VTE", "110318", "707000", " ", "", "1002", "Facture C002", "C", "60.00", 5),
     ecr("ACH", "120318", "606100", " ", "", "2001", "Achat F001", "D", "50.00", 6),
     ecr("ACH", "120318", "445660", " ", "", "2001", "Achat F001", "D", "10.00", 7),
     ecr("ACH", "120318", "401000", "X", "F001", "2001", "Achat F001", "C", "60.00", 8),
     ecr("BQ1", "150318", "512000", " ", "", "3001", "Reglement C001", "D", "120.00", 9),
     ecr("BQ1", "150318", "411000", "X", "C001", "3001", "Reglement C001", "C", "120.00", 10),
     ecr("OD ", "200318", "658000", " ", "", "4001", "Regularisation", "D", "5.00", 11),
     ecr("OD ", "200318", "758000", " ", "", "4001", "Regularisation", "C", "5.00", 12)])

# T02 : tiers K001 déjà dans Corsage (jeu impsage_corsage : K001 -> 411005) suivi d'un tiers inconnu N001
JEUX["compteur"] = (
    [tiers("K001", "Client connu", "411", "5 rue K", "", "44000", "Nantes"),
     tiers("N001", "Client nouveau", "411", "6 rue N", "", "35000", "Rennes")],
    [ecr("VTE", "100318", "411000", "X", "K001", "1101", "Facture K001", "D", "30.00", 1),
     ecr("VTE", "100318", "707000", " ", "", "1101", "Facture K001", "C", "30.00", 2),
     ecr("VTE", "110318", "411000", "X", "N001", "1102", "Facture N001", "D", "40.00", 3),
     ecr("VTE", "110318", "707000", " ", "", "1102", "Facture N001", "C", "40.00", 4)])
# T03 : aucun tiers ; comptes généraux à 8 chiffres absents de Fiches_Comptes (6, 512, 8)
JEUX["comptes"] = (
    [],
    [ecr("ACH", "120318", "60610000", " ", "", "5001", "Achat comptes", "D", "10.00", 1),
     ecr("ACH", "120318", "51210000", " ", "", "5001", "Achat comptes", "C", "10.00", 2),
     ecr("OD ", "130318", "80100000", " ", "", "5002", "Engagement", "D", "1.00", 3),
     ecr("OD ", "130318", "80200000", " ", "", "5002", "Engagement", "C", "1.00", 4)])
# T05 : 2 nouveaux clients avec écritures (compteur dnc fixé par le jeu de données)
JEUX["seuil"] = (
    [tiers("S001", "Client seuil Un", "411", "7 rue S", "", "44000", "Nantes"),
     tiers("S002", "Client seuil Deux", "411", "8 rue S", "", "35000", "Rennes")],
    [ecr("VTE", "100318", "411000", "X", "S001", "1201", "Facture S001", "D", "11.00", 1),
     ecr("VTE", "100318", "707000", " ", "", "1201", "Facture S001", "C", "11.00", 2),
     ecr("VTE", "110318", "411000", "X", "S002", "1202", "Facture S002", "D", "22.00", 3),
     ecr("VTE", "110318", "707000", " ", "", "1202", "Facture S002", "C", "22.00", 4)])
# T06 : fournisseur 403 puis fournisseur 401
JEUX["fournisseurs"] = (
    [tiers("G403", "Fournisseur 403", "403", "9 rue G", "", "75001", "Paris"),
     tiers("G401", "Fournisseur 401", "401", "10 rue G", "", "69001", "Lyon")],
    [ecr("ACH", "120318", "606100", " ", "", "2101", "Achat G403", "D", "70.00", 1),
     ecr("ACH", "120318", "403000", "X", "G403", "2101", "Achat G403", "C", "70.00", 2),
     ecr("ACH", "130318", "606100", " ", "", "2102", "Achat G401", "D", "80.00", 3),
     ecr("ACH", "130318", "401000", "X", "G401", "2102", "Achat G401", "C", "80.00", 4)])
# T07 : journal non reconnu XYZ et journaux RAN, CAI
JEUX["journaux"] = (
    [],
    [ecr("XYZ", "100318", "606100", " ", "", "6001", "Journal inconnu", "D", "3.00", 1),
     ecr("XYZ", "100318", "512000", " ", "", "6001", "Journal inconnu", "C", "3.00", 2),
     ecr("CAI", "110318", "606100", " ", "", "6002", "Caisse", "D", "4.00", 3),
     ecr("CAI", "110318", "530000", " ", "", "6002", "Caisse", "C", "4.00", 4),
     ecr("RAN", "010118", "512000", " ", "", "6003", "A nouveau", "D", "5.00", 5),
     ecr("RAN", "010118", "101000", " ", "", "6003", "A nouveau", "C", "5.00", 6)])

if __name__ == "__main__":
    for nom, (cli, ecrs) in JEUX.items():
        with open(f"{nom}_clients.pnc", "w") as f:
            f.write("\n".join([ENTETE] + cli) + "\n")
        with open(f"{nom}_ecritures.pnm", "w") as f:
            f.write("\n".join([ENTETE] + ecrs) + "\n")
